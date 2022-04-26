<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,com.ike.concierge.DAOConciergeBanquete,com.ike.concierge.to.Conciergebanquete,Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOBoletosCine,com.ike.concierge.to.ConciergeBoletosCine,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<html>
<head><title>Boletos de Cine(Reservacion y compra)</title>
    <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
    <script type="text/javascript">
            var floating_window_skin = 2;
    </script>
    <script type="text/javascript" src="floating_window_with_tabs.js"></script>
</head>
<body class="cssBody" onload="fnVerificaFecha();">

    <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
    <script src='../../Utilerias/Util.js' ></script>
    <script src='../../Utilerias/UtilDireccion.js' ></script>
    <script src='../../Utilerias/UtilMask.js'></script> 
    <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>    
    <script src='../../Utilerias/UtilCalendario.js'></script>
    <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    
    <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Boletos de Cine (Compra/Reservacion)</i></b>  <br> </p></div>
    <div class='VTable' style='position:absolute; z-index:25; left:570px; top:93px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Automatica </i></b>  <br> </p></div>
    <%  
    String StrclConcierge = "";
    String StrclSubservicio = "";
    String StrclAsistencia = "0";
    String strclUsr = "";

    //1111111111111111111111111111111----
    String StrURL="";
    String StrNomPag = "";

    if (request.getRequestURL()!= null) {
        StrURL = request.getRequestURL().toString();
        StrNomPag = StrURL.substring(StrURL.lastIndexOf("/")+1) ;
        System.out.println("URL RQ(getRequestURL): ........................................... "+StrURL);
        System.out.println("Pagina.................................... "+StrNomPag);
    }
    //-------------------------------

    DAOBoletosCine daos=null;
    ConciergeBoletosCine conciergeboletoscine=null;
    /*Falta  meter datos de concierge Generico */
    DAOConciergeG daosg=null;
    ConciergeG conciergeg=null;
    
    DAOReferenciasxAsist daoRef=null;
    ReferenciasxAsist ref=null;     
    
    if (session.getAttribute("clUsrApp")!= null) {
        strclUsr = session.getAttribute("clUsrApp").toString();
    }
    
    if (session.getAttribute("clConcierge")!= null) {
        StrclConcierge= session.getAttribute("clConcierge").toString();
    }
    
    if (request.getParameter("clAsistencia")!= null) {
        StrclAsistencia= request.getParameter("clAsistencia").toString();
    } else{
        if (session.getAttribute("clAsistencia")!= null) {
            StrclAsistencia= session.getAttribute("clAsistencia").toString();
        }
    }
    if (request.getParameter("clSubservicio")!= null) {
        StrclSubservicio= request.getParameter("clSubservicio").toString();
    } else{
        if (session.getAttribute("clSubservicio")!= null) {
            StrclSubservicio= session.getAttribute("clSubservicio").toString();
        }
    }
    session.setAttribute("clAsistencia",StrclAsistencia);
    session.setAttribute("clSubservicio",StrclSubservicio);
    String StrclPaginaWeb = "728";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    if(strclUsr!=null){
        daos = new DAOBoletosCine();
        conciergeboletoscine = daos.getCSBoletosCine(StrclAsistencia);
        
        daoRef = new DAOReferenciasxAsist();
        ref = daoRef.getclAsistencia(StrclAsistencia);
    }
    if(strclUsr!=null){
        daosg = new DAOConciergeG();
        conciergeg = daosg.getConciergeGenerico(StrclConcierge);
    }

    //----------------------------2222222222222222222
    ResultSet rs = null;
    String StrPreguntaEncuesta = "0";

    rs = UtileriasBDF.rsSQLNP("sp_CSPreguntaEncuesta "+StrclConcierge);
    if (rs.next()) {
       StrPreguntaEncuesta = rs.getString("Pregunta").toString();
    }
    rs.close();
    rs = null;
    //-----------------------------
		
		//-----------------------------------------------------
		// SE AGREGA CODIGO PARA EL MANEJO DE LAS ASISTENCIAS DUPLICADAS.
		String StrclAsistenciaVTR = "";
		ResultSet rsTieneAsistMadre = null;
		rsTieneAsistMadre = UtileriasBDF.rsSQLNP(" st_CSTieneAsistMadre "+StrclAsistencia);

		if(rsTieneAsistMadre.next()){
			if(rsTieneAsistMadre.getString("TieneAsistMadre").equalsIgnoreCase("1")){
				StrclAsistenciaVTR = rsTieneAsistMadre.getString("Folio");
			}else{
				//StrclAsistenciaVTR = ConciergeInfTC!=null ? ConciergeInfTC.getClAsistencia().trim() : "";
				StrclAsistenciaVTR = StrclAsistencia;
			}
			session.setAttribute("clAsistenciaVTR", StrclAsistenciaVTR);
		}

		rsTieneAsistMadre.close();
		rsTieneAsistMadre = null;
		//-----------------------------------------------------
	
    %>
    <script>fnOpenLinks()</script>
    <% MyUtil.InicializaParametrosC(728,Integer.parseInt(strclUsr)); %>
    <%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaBoletoCine","fnAccionesAlta();","fnAntesGuardar();fnReqCampo();")%>
    
    <%--.....................................33333333333333333333333333333--%>

    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>'>
    <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
    <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
    <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
    <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
   <%--.....................................33333333333333333333333333333--%>

    <%String strEstatus = conciergeboletoscine!=null ? conciergeboletoscine.getdsEstatus() : ""; %>
    <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergeboletoscine!=null ? conciergeboletoscine.getdsEstatus(): "",false,false,30,80,  "0","sp_GetCSstatus","","",30,false,false)%>
    <!--%=MyUtil.ObjComboMem("Estatus","clEstatus",strEstatus,strEstatus,cbEstatus.GeneraHTML(50,strEstatus),false,true,30,80,"0","","",50,false,false)%-->
    <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,330,80,"",false,false,10)%>
    <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios",conciergeboletoscine!=null ? conciergeboletoscine.getComentarios() : "","83","3",true,true,30,110,"",true,true)%>
     <%=MyUtil.ObjInput("fecha de alta","FechaRegistro",conciergeboletoscine!=null ? conciergeboletoscine.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
    <%=MyUtil.DoBlock("Datos Generales del Evento",10,20)%>
    
    <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
    <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
    <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
    
    <%=MyUtil.ObjInput("Número de Adultos","NumAdultos",conciergeboletoscine!=null ? conciergeboletoscine.getNumAdultos() : "",true,true,30,220,"",true,true,5,"EsNumero(this);")%>
    <%=MyUtil.ObjChkBox("Niños","Ninos",conciergeboletoscine!=null ? conciergeboletoscine.getNumNinos().trim() : "",true,true,230,220,"","SI","NO","EdadesNinos();")%>
    <%=MyUtil.ObjInput("Edades","Edades",conciergeboletoscine!=null ? conciergeboletoscine.getEdades() : "",true,true,330,220,"",false,false,10)%>
    <%=MyUtil.ObjInput("Película","Pelicula",conciergeboletoscine!=null ? conciergeboletoscine.getPelicula() : "",true,true,30,260,"",true,true,50)%>
    <%=MyUtil.ObjInputF("Fecha/Hora (AAAA/MM/DD)","FechaIni", conciergeboletoscine!=null ? conciergeboletoscine.getFechaIni() : "",true,true,330,260,"",true,true,20, 2, "")%> 
    <%=MyUtil.ObjInput("Complejo/Cine","dsComplejo",conciergeboletoscine!=null ? conciergeboletoscine.getdsComplejo() : "",true,true,30,300,"",false,false,30)%>
    <%=MyUtil.ObjInput("Sala","dsSala",conciergeboletoscine!=null ? conciergeboletoscine.getdsSala() : "",true,true,330,300,"",false,false,15)%>
    <%=MyUtil.ObjComboC("Reservación/Compra","clReservaCompra",conciergeboletoscine!=null ? conciergeboletoscine.getdsReservaCompra() : "",true,true,550,300,"","st_reservacion","","",30,true,true)%>
    <%=MyUtil.ObjInput("Cargo Total","Cargo",conciergeboletoscine!=null ? conciergeboletoscine.getCargo() : "",true,true,30,340,"0",false,false,20,"EsNumerico(this);")%>
    <%=MyUtil.ObjComboC("Tipo de Pago","clTipoPago",conciergeboletoscine!=null ? conciergeboletoscine.getdsTipoPago() : "",true,true,330,340,"","select clTipoPago,dsTipoPago from CSTipoPago","fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();","",30,false,false)%>
    <%=MyUtil.ObjInput("Nombre del Banco:","NomBanco",conciergeboletoscine!=null ? conciergeboletoscine.getNomBanco().trim() :"",true,true,550,340,"",false,false,40)%>
    <%=MyUtil.ObjInput("Nombre en TC:","NombreTC",conciergeboletoscine!=null ? conciergeboletoscine.getNombreTC().trim() : "",true,true,30,380,"",false,false,40,"")%>
    <%=MyUtil.ObjInput("Numero de TC","NumeroTC",conciergeboletoscine!=null ? conciergeboletoscine.getNumTarjeta() : "",false,false,330,380,"",false,false,30,"if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
    <%=MyUtil.ObjInput("Exp.D.(MM/AA)","ExpiraVTR",conciergeboletoscine!=null ? conciergeboletoscine.getExpiraTarjeta() : "",false,false,550,380,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
    <input type="hidden" name="Expira" id="Expira" value="<%=conciergeboletoscine!=null ? conciergeboletoscine.getExpiraTarjeta2() : ""%>">
    <%=MyUtil.ObjInput("Sec.C.","SecC",conciergeboletoscine!=null ? conciergeboletoscine.getClaveTarjeta() : "",false,false,650,380,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
    <%=MyUtil.DoBlock("Datos Compra/Reservación",10,0)%>
   
    <% String StrCodEnt = conciergeboletoscine!=null ? conciergeboletoscine.getCodEnt() : "";%>
    <%=MyUtil.ObjInput("Colonia","Colonia",conciergeboletoscine!=null ? conciergeboletoscine.getColonia() : "",true,true,330,470,"",false,false,30)%>
    <%=MyUtil.ObjInput("Calle y Número","CalleNum",conciergeboletoscine!=null ? conciergeboletoscine.getCalleNum() : "",true,true,30,470,"",false,false,50)%>
    <%=MyUtil.ObjInput("C.P.","CP",conciergeboletoscine!=null ? conciergeboletoscine.getCP() : "",true,true,550,470,"",false,false,10,"EsNumerico(this);")%>
    <%=MyUtil.ObjComboC("Entidad Federativa","CodEnt",conciergeboletoscine!=null ? conciergeboletoscine.getdsEntFed() : "",true,true,30,510,"","Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","fnLlenaMunicipiosKM();","",40,false,false)%>
    <%=MyUtil.ObjComboC("Municipio / Delegación","CodMD",conciergeboletoscine!=null ? conciergeboletoscine.getdsMunDel() : "",true,true,330,510,"","Select CodMD, dsMunDel from cMunDel where CodEnt='"+ StrCodEnt + "' order by dsMunDel","","",40,false,false)%>
    <%=MyUtil.ObjInput("Confirmo","Confirmo",conciergeboletoscine!=null ? conciergeboletoscine.getConfirmo() : "",true,true,30,550,"",false,false,50)%>
    <%=MyUtil.ObjInput("No.Conf.","NumConfimacion",conciergeboletoscine!=null ? conciergeboletoscine.getNumConfimacion() : "",true,true,330,550,"",false,false,30)%>
    <%=MyUtil.ObjInput("Pol.Cancelación","Cancelacion", conciergeboletoscine!=null ? conciergeboletoscine.getCancelacion() : "",true,true,30,590,"",false,false,50)%>
    <%=MyUtil.ObjChkBox("N/U inf.:","NUInfoK", conciergeboletoscine!=null ? conciergeboletoscine.getNUInfoK() : "",true,true,330,590,"0","SI","NO","")%>
    <%=MyUtil.DoBlock("Datos de Facturación",50,0)%>
    
    <%@ include file="csVentanaFlotante.jspf" %>
    
    <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09 '>
    <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>
    <input name='FechaIniMsk' id='FechaIniMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
    <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>    
    
    <%
    //StrclConcierge = null;
    //StrclSubservicio = null;
    StrclAsistencia = null;
    daos=null;
    conciergeboletoscine=null;
    daosg=null;
    conciergeg=null;
    
    daoRef=null;
    ref=null;
    %>
    <%=MyUtil.GeneraScripts()%>
    
    <script>

		top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
		top.document.all.rightPO.rows="0,80,*";
				  
        document.all.CP.maxLength=6;
        document.all.NumAdultos.maxLength=3;
        document.all.Ninos.maxLength=3;
        document.all.SecC.maxLength=4;

       function fnAccionesAlta(){
               if (document.all.Action.value==1){
                         var pstrCadena = "../../Utilerias/RegresaFechaActual.jsp";
                         window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');
                 }
            }
   
        function fnActualizaFechaActual(pFecha){
        document.all.FechaApAsist.value = pFecha;			
        }
       
//función antes de guardar
function fnAntesGuardar(){
    if (document.all.clEstatus.value==10 ) 
       {
        if (document.all.Cargo.value==0 ) 
           { 
            msgVal = msgVal + " Cargo ";
           }
            document.all.btnGuarda.disabled=false;
            document.all.btnCancela.disabled=false;
       }
    if ((document.all.Ninos.value == 1) && (document.all.Edades.value == "" ))
       { 
        msgVal = msgVal + " Edades de los niños ";
        document.all.btnGuarda.disabled=false;
        document.all.btnCancela.disabled=false;
       }
     //..........................................44444444444444444444444444
        fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
     //..........................................44444444444444444444444444
}
    
//Función para quitarle los cero a la fecha
function fnVerificaFecha() {
    //document.all.FechaIni.value=fnFechaID(document.all.FechaIni.value);
     
}

//función que regresa la fecha sin hora
function fnFechaID(Fecha){
       if (Fecha!=""){
          FechaSinHora=Fecha;
          FechaSinHora=FechaSinHora.substring(0,10);
          return FechaSinHora;
       }
       else {
          FechaSinHora='';
          return FechaSinHora;
       }

}
//Funcion de validacion de numero de adultos
     function EsNumero(Campo)
                      {        
                       if (isNaN(Campo.value)==true)
                          {
                           alert('Numero de Adultos' + ' debe ser numérico');
                           Campo.value="";
                           }
                       }              
                   
        //Funcion que hace requeribles las edades de los niños dependiendo de la accion
 function EdadesNinos()
                         {
                          if ((document.all.Ninos.value==1) && (document.all.Action.value==1))
                             {
                             document.all.Edades.className="Freq";
                             document.all.Edades.value="";
                             document.all.Edades.readOnly=false;
                             }
                          else   
                             {
                             document.all.Edades.className="VTable";
                             document.all.Edades.readOnly=false;
                             }
                             if(document.all.Ninos.value==0) document.all.Edades.value="";
                          }     
        
    </script>
    <script type="text/javascript">
        initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);

    </script>
</body>
</html>
