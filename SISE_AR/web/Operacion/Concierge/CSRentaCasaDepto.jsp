<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAORentaCasaDepto,com.ike.concierge.to.ConciergeRentaCasaDepto,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
<head><title>Renta de casas o Departamentos</title>
    <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
    <script type="text/javascript">
            var floating_window_skin = 2;
    </script>
    <script type="text/javascript" src="floating_window_with_tabs.js"></script>        
</head>
<body class="cssBody" onload="fnLimpiaFechas();fnVerificaFecha();if (document.all.ExpiraVTR.value!=''){fnFechVen(document.all.ExpiraVTR.value)}">

    <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
    <script src='../../Utilerias/Util.js' ></script>
    <script src='../../Utilerias/UtilMask.js'></script> 
    <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>    
    <script src='../../Utilerias/UtilCalendario.js'></script>
    <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i>Renta de Casa o Departamento</i></b>  <br> </p></div>
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


    //String strFechaApAsist="";

    DAORentaCasaDepto daos=null;
    ConciergeRentaCasaDepto conciergerentacasadepto=null;
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
        String StrclPaginaWeb = "736";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        
    if(strclUsr!=null){
        daos = new DAORentaCasaDepto();
        conciergerentacasadepto= daos.getCSRentaCasaDepto(StrclAsistencia);
        
        
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
    <SCRIPT>fnOpenLinks()</script> 
    <% MyUtil.InicializaParametrosC(736,Integer.parseInt(strclUsr));%>
    <%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaRentaCasaDepto","fnAccionesAlta();","fnAntesGuardar();fnAdicional();fnValidaFecha();fnReqCampo();")%>

    <%--.....................................33333333333333333333333333333--%>

    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>'>
    <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
    <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
    <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
    <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
    <%--.....................................33333333333333333333333333333--%>

    <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
    <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
    <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
    <%String strEstatus = conciergerentacasadepto!=null ? conciergerentacasadepto.getdsEstatus() : "";%>
    <!--%=MyUtil.ObjComboMem("Estatus","clEstatus",strEstatus,conciergerentacasadepto!=null ? conciergerentacasadepto.getclEstatus() : "",cbEstatus.GeneraHTML(50,strEstatus),false,false,30,80,"0","","",50,false,false)%-->    
    <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergerentacasadepto!=null ? conciergerentacasadepto.getdsEstatus(): "",false,false,30,80,"0","sp_GetCSstatus","","",30,false,false)%>
    <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,350,80,"",false,false,10)%>
    <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios",conciergerentacasadepto!=null ? conciergerentacasadepto.getComentarios() : "","83","3",true,true,30,120,"",true,true)%>
    <%=MyUtil.ObjInput("fecha de alta","FechaRegistro",conciergerentacasadepto!=null ? conciergerentacasadepto.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
    <%=MyUtil.DoBlock("Datos Generales del Usuario",10,10)%>
    
    <%=MyUtil.ObjInput("No.adultos","NumAdultos",conciergerentacasadepto!=null ? conciergerentacasadepto.getNumAdultos() : "",true,true,30,220,"",true,true,5,"EsNumerico(this)")%>
    <%=MyUtil.ObjChkBox("Ni�os","Ninos",conciergerentacasadepto!=null ? conciergerentacasadepto.getNinos() : "",true,true,130,220,"","SI","NO","EdadesNinos();")%>
    <%=MyUtil.ObjInput("Edades","Edades",conciergerentacasadepto!=null ? conciergerentacasadepto.getEdades() : "",false,false,220,220,"",false,false,10)%>
    <%=MyUtil.ObjInput("Tipo de Inmueble","TipoInmueble",conciergerentacasadepto!=null ? conciergerentacasadepto.getTipoInmueble() : "",true,true,30,260,"",true,true,75)%>
    <%=MyUtil.ObjInput("Ubicacion deseada","Servicios",conciergerentacasadepto!=null ? conciergerentacasadepto.getServicios() : "",true,true,30,300,"",true,true,75)%>
    <%=MyUtil.ObjInputF("Check-In <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaI",conciergerentacasadepto!=null ? conciergerentacasadepto.getFechaI() : "",true,true,450,260,"",true,true,20, 2, "fnVerificaFecha();")%>  </div>
    <%=MyUtil.ObjInputF("Check-Out <Strong>(AAAA-MM-DD hh:mm)</Strong>","Fecha0",conciergerentacasadepto!=null ? conciergerentacasadepto.getFecha0() : "",true,true,450,300,"",true,true,20, 2, "fnVerificaFecha();")%>  </div>
    <%=MyUtil.ObjInput("Pais","Pais",conciergerentacasadepto!=null ? conciergerentacasadepto.getPais() : "",true,true,30,340,"",true,true,30)%>
    <%=MyUtil.ObjInput("Estado","Estado",conciergerentacasadepto!=null ? conciergerentacasadepto.getEstado() : "",true,true,240,340,"",true,true,30)%>
    <%=MyUtil.ObjInput("Ciudad","Ciudad",conciergerentacasadepto!=null ? conciergerentacasadepto.getCiudad() : "",true,true,450,340,"",true,true,30)%>    
    <%=MyUtil.ObjInput("Costo por D�a","CostoxDia",conciergerentacasadepto!=null ? conciergerentacasadepto.getCostoxDia() : "",true,true,30,380,"",false,false,20,"EsNumerico(this)")%>
    <%=MyUtil.ObjInput("Otros Cargos","OtrosCargos",conciergerentacasadepto!=null ? conciergerentacasadepto.getOtrosCargos() : "",true,true,240,380,"",false,false,20,"EsNumerico(this)")%>
    <%=MyUtil.ObjInputF("Entrega de Llaves <Strong>(AAAA-MM-DD hh:mm)</Strong>","EntregaLlaves",conciergerentacasadepto!=null ? conciergerentacasadepto.getEntregaLlaves() : "",true,true,450,420,"",false,true,20, 2, "")%>  </div>    
    <%=MyUtil.ObjInput("Lugar de Entrega de Llaves","LEntregaLlaves",conciergerentacasadepto!=null ? conciergerentacasadepto.getLEntregaLlaves() : "",true,true,30,420,"",false,false,75)%>
    <%=MyUtil.DoBlock("Datos de Renta",100,5)%>
    
    <%=MyUtil.ObjComboC("Forma de Pago:","clTipoPago",conciergerentacasadepto!=null ? conciergerentacasadepto.getdsFormaPago() : "",true,true,30,520,"","select clTipoPago,dsTipoPago from CSTipoPago","fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();","",30,false,false)%>
    <%=MyUtil.ObjInput("Nombre del Banco:","NomBanco",conciergerentacasadepto!=null ? conciergerentacasadepto.getNomBanco() : "",false,false,30,560,"",false,false,40)%>
    <%=MyUtil.ObjInput("Nombre en TC:","NombreTC",conciergerentacasadepto!=null ? conciergerentacasadepto.getNombreTC() : "",true,true,280,520,"",false,false,30)%>
    <%=MyUtil.ObjInput("Cargo Total","CargoTotal",conciergerentacasadepto!=null ? conciergerentacasadepto.getCargoTotal() : "",true,true,540,520,"",false,false,10)%>
    <%=MyUtil.ObjInput("Numero de TC:","NumeroTC",conciergerentacasadepto!=null ? conciergerentacasadepto.getNumeroTC() : "",true,true,280,560,"",false,false,40,"if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
    <%=MyUtil.ObjInput("Exp.D.:(MM-AA)","ExpiraVTR",conciergerentacasadepto!=null ? conciergerentacasadepto.getExpira() :"",true,true,540,560,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
    <input  name="Expira" id="Expira" type="hidden" value="">
    <%=MyUtil.ObjInput("Sec.C.:","SecC",conciergerentacasadepto!=null ? conciergerentacasadepto.getSecC() : "",true,true,650,560,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
    <%=MyUtil.ObjInput("Confirmo","Confirmo",conciergerentacasadepto!=null ? conciergerentacasadepto.getConfirmo() : "",true,true,30,600,"",false,false,30)%>
    <%=MyUtil.ObjInput("No.Conf.:","NumConfirmacion",conciergerentacasadepto!=null ? conciergerentacasadepto.getNumConfirmacion() : "",true,true,280,600,"",false,false,30,"")%>
    <%=MyUtil.ObjInput("Pol.Cancelaci�n","Cancelacion",conciergerentacasadepto!=null ? conciergerentacasadepto.getCancelacion() : "",true,true,30,640,"",false,false,50)%>
    <%=MyUtil.ObjChkBox("N/U inf.:","NUInfo",conciergerentacasadepto!=null ? conciergerentacasadepto.getNUInfo() : "",true,true,350,640,"","SI","NO","")%>
    <%=MyUtil.DoBlock("Forma de Pago",100,0)%>
    
    <input name='EntregaLlavesMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
    <input name='FechaProgMskI' id='FechaProgMskI' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
    <input name='FechaProgMskI' id='FechaProgMskO' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
    <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
    <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
    <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>
    <input name='FechaIniMsk' id='FechaIniMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
    <%@ include file="csVentanaFlotante.jspf" %>


    <%=MyUtil.GeneraScripts()%> 
    <%
    //StrclConcierge = null;
    //StrclSubservicio = null;
    StrclAsistencia = null;
    daos=null;
    conciergerentacasadepto=null;
    daosg=null;
    conciergeg=null;
    daoRef=null;
    ref=null;
    %>       
    <script>
         		top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
		top.document.all.rightPO.rows="0,80,*";     
        document.all.SecC.maxLength=4;
              function fnValidaFecha()
    {
     if (document.all.FechaI.value!='' && document.all.Fecha0.value!= '')
    {
      if (document.all.Fecha0.value <= document.all.FechaI.value)
      {
       msgVal = msgVal + " Check-Out debe de ser mayor a Check-In. "
       document.all.btnGuarda.disabled = false;
       document.all.btnCancela.disabled = false;       
      }

     }
     }
function fnAccionesAlta(){
   if (document.all.Action.value==1){
      
             var pstrCadena = "../../Utilerias/RegresaFechaActual.jsp";
             window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');
       
     }
}
function fnActualizaFechaActual(pFecha){
document.all.FechaApAsist.value = pFecha;			
}

function fnAdicional(){

if (document.all.Ninos.value==1){
    if(document.all.Edades.value==""){
        msgVal = msgVal + " Debe Ingresar Edades. ";
        document.all.btnGuarda.disabled=false;
        document.all.btnCancela.disabled=false;
    }
}
else{
document.all.Edades.value="";
}
}

function fnChkNinos(){ 
/*    if (document.all.NinosLabel.value=="SI"){
        document.all.Edades.readOnly=false;
        } 
    else {
        document.all.Edades.readOnly=true;
        document.all.Edades.value="";
        }*/
}

//funci�n antes de guardar
function fnAntesGuardar(){
    if (document.all.clEstatus.value==10 ) {
        if (document.all.CostoxDia.value==0 ) { msgVal = msgVal + " Costo por D�a";}
        if (document.all.OtrosCargos.value==0 ) { msgVal = msgVal + " Otros Cargos";}
        if (document.all.CargoTotal.value==0 ) { msgVal = msgVal + " Cargo Total";}
        document.all.btnGuarda.disabled=false;
        document.all.btnCancela.disabled=false;
    }
  /*      if (document.all.FechaI.value==''){
       miFecha = new Date(); 
       document.all.FechaI.value=miFecha.getYear()+"-"+(miFecha.getMonth()+1)+"-"+miFecha.getDate();
    }
    if (document.all.FechaO.value==''){
       miFechaO = new Date(); 
       document.all.FechaO.value='';
    }    */
    //..........................................44444444444444444444444444
    fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
    //..........................................44444444444444444444444444
}


//Funci�n para quitarle los cero a la fecha
function fnVerificaFecha() {
     //document.all.EntregaLlaves.value=fnFechaID(document.all.EntregaLlaves.value);
     document.all.FechaI.value=fnFechaID(document.all.FechaI.value);
     document.all.Fecha0.value=fnFechaID(document.all.Fecha0.value);
}

//funci�n que regresa la fecha sin hora
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

    //Funcion que hace requeribles las edades de los ni�os dependiendo de la accion
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
                  
//Funci�n para limpiar las fechas
function fnLimpiaFechas(){
    if (document.all.FechaI.value=="1900-01-01"){
        document.all.FechaI.value="";
    }
    else {
        document.all.FechaI.value=fnFechaID(document.all.FechaI.value);
    }
    if (document.all.Fecha0.value=="1900-01-01"){
        document.all.Fecha0.value="";
    }
    else {
        document.all.Fecha0.value=fnFechaID(document.all.Fecha0.value);
    }
    
}                         
    </script>
    <script type="text/javascript">
    initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
    </script>        
</body>
</html>
