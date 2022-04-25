<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOConciergeTour,com.ike.concierge.to.Conciergetour,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
<head><title>Reservacion de Tour Privado/Colectivo</title>
    <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
    <script type="text/javascript">
            var floating_window_skin = 2;


    </script>
    <script type="text/javascript" src="floating_window_with_tabs.js"></script>        
</head>
<body class="cssBody" onload="fnVerificaFecha();fnLimpiaFechas();">

    <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
    <script src='../../Utilerias/Util.js' ></script>
    <script src='../../Utilerias/UtilMask.js'></script> 
    <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>
    <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Reservacion de Tour Privado/Colectivo </i></b>  <br> </p></div>
    <script src='../../Utilerias/UtilCalendarioV.js'></script>
    <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
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

    DAOConciergeTour daos=null;
    Conciergetour conciergetour=null;
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
    String StrclPaginaWeb = "746";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    if(strclUsr!=null){
        daos = new DAOConciergeTour();
        conciergetour= daos.getCSTour(StrclAsistencia);
        
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
    <%        
    MyUtil.InicializaParametrosC(746,Integer.parseInt(strclUsr)); 
    %><%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaTour","fnAccionesAlta();","fnAntesGuardar();fnAdicional();fnValidaFecha();fnReqCampo();")%><%
    
    %>


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
    <%String strEstatus = conciergetour!=null ? conciergetour.getDsEstatus() : ""; %>
    <!--%=MyUtil.ObjComboMem("Estatus","clEstatus",strEstatus,conciergetour!=null ? conciergetour.getEstatus() : "",cbEstatus.GeneraHTML(50,strEstatus),false,true,30,80,"0","","",50,false,true)%-->
    <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergetour!=null ? conciergetour.getDsEstatus(): "",false,false,30,80,"0","sp_GetCSstatus","","",30,false,false)%>
    <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,350,80,"",false,false,10)%>
    <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios", conciergetour!=null ? conciergetour.getComentarios() : "","83","3",true,true,30,120,"",true,true)%>
    <%=MyUtil.ObjInput("fecha de alta","FechaRegistro",conciergetour!=null ? conciergetour.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
    <%=MyUtil.DoBlock("Datos Generales del Usuario",10,10)%>
    
    <%=MyUtil.ObjInput("No.adultos","Nadultos", conciergetour!=null ? conciergetour.getNadultos():"",true,true,30,220,"",true,true,5)%>
    <%=MyUtil.ObjChkBox("Ni�os","Ninos", conciergetour!=null ? conciergetour.getNinos() :"",true,true,130,220,"","SI","NO","EdadesNinos()")%>
    <%=MyUtil.ObjInput("Edades","Edades", conciergetour!=null ? conciergetour.getEdades() :"",true,true,220,220,"",false,false,10)%>
    <%=MyUtil.ObjInput("Tour Solicitado","Tour", conciergetour!=null ? conciergetour.getTour():"",true,true,30,260,"",true,true,30)%>
    <%=MyUtil.ObjInput("Vehiculo","Vehiculo", conciergetour!=null ? conciergetour.getVehiculo() :"",true,true,220,260,"",false,false,20)%>
    <%=MyUtil.ObjInput("Ciudad","Ciudad", conciergetour!=null ? conciergetour.getCiudad():"",true,true,30,300,"",false,false,50)%>
    <%=MyUtil.ObjInput("Estado","Estado",  conciergetour!=null ? conciergetour.getEstado() :"",true,true,350,300,"",false,false,50)%>
    <%=MyUtil.ObjInput("Pais","Pais", conciergetour!=null ? conciergetour.getPais(): "",true,true,650,300,"",false,false,50)%>
    <%=MyUtil.ObjInputF("Fecha Inicio del Evento <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaIn", conciergetour!=null ? conciergetour.getFechaIn() : "",true,true,30,340,"",false,true,20, 2, "")%>  
    <%=MyUtil.ObjInputF("Fecha Fin del Evento <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaFi", conciergetour!=null ? conciergetour.getFechaFi() :"",true,true,350,340,"",false,true,20, 2, "")%>  
    <%=MyUtil.ObjInput("Costo por Hora","CostoH",  conciergetour!=null ? conciergetour.getCostoH() :"",true,true,30,380,"",false,false,10)%>
    <%=MyUtil.ObjInput("Horas Conf","HorasC",  conciergetour!=null ? conciergetour.getHorasC():"",true,true,200,380,"",false,false,10)%>
    <%=MyUtil.ObjInput("Costo por Pax","CostoP", conciergetour!=null ? conciergetour.getCostoP() : "",true,true,30,420,"",false,false,10)%>    
    <%=MyUtil.ObjInput("Otros Cargos","OtrosC", conciergetour!=null ? conciergetour.getOtrosC() : "",true,true,200,420,"",false,false,10)%>    
    <%=MyUtil.ObjInput("Cargo Total","CargoT", conciergetour!=null ? conciergetour.getCargoT() : "",true,true,350,420,"",false,false,10)%>    
    <%=MyUtil.ObjInput("Punto de Encuentro","Encuentro", conciergetour!=null ? conciergetour.getEncuentro():"",true,true,30,460,"",false,false,50)%>
    <%=MyUtil.ObjInput("Horario","Horario", conciergetour!=null ? conciergetour.getHorario() :"",true,true,350,460,"",false,false,5,"if(this.readOnly==false){fnValMask(this,document.all.FechaProgMskS.value,this.name)}")%>
    <%=MyUtil.ObjInput("Hotel & Tel.:","Hotel", conciergetour!=null ? conciergetour.getHotel():"",true,true,30,500,"",false,false,75)%>
    <%=MyUtil.ObjInputF("Check-In <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaI", conciergetour!=null ? conciergetour.getFechaI() : "",true,true,450,500,"",false,false,20, 2, "fnVerificaFecha() ;")%>  
    <%=MyUtil.ObjInput("Rva. a nombre","Reservacion", conciergetour!=null ? conciergetour.getReservacion():"",true,true,30,540,"",false,false,75)%>
    <%=MyUtil.ObjInputF("Check-Out <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaO", conciergetour!=null ? conciergetour.getFechaO() :"",true,true,450,540,"",false,false,20, 2, "fnVerificaFecha() ;")%>  
    <%=MyUtil.DoBlock("Reservacion de Tour Privado/colectivo",100,5)%>
    <%--=MyUtil.ObjComboC("Forma de Pago:","clTipoPago", conciergetour!=null ? conciergetour.getDsTipoPago().trim() :"",true,false,30,630, conciergetour!=null ? conciergetour.getClTipoPago():"","select clTipoPago,dsTipoPago from CSTipoPago","fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)}","",30,true,true)--%>
    <%=MyUtil.ObjComboC("Forma de Pago:","clTipoPago",conciergetour!=null ? conciergetour.getDsTipoPago() :"",true,true,30,630,"","select clTipoPago,dsTipoPago from CSTipoPago","fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();","",30,false,false)%>
    <%=MyUtil.ObjInput("Nombre del Banco:","NomBanco",conciergetour!=null ? conciergetour.getNomBanco() :"",false,false,200,630,"",false,false,40)%>
    <%=MyUtil.ObjInput("Nombre en TC:","NombreTC", conciergetour!=null ? conciergetour.getNombreTC():"",false,false,450,630,"",false,false,30)%>
    <%=MyUtil.ObjInput("Numero de TC:","NumeroTC", conciergetour!=null ? conciergetour.getNumeroTC() :"",false,false,30,670,"",false,false,50,"if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
    <%=MyUtil.ObjInput("Exp.D.:(MM/AA)","ExpiraVTR", conciergetour!=null ? conciergetour.getExpira():"",false,false,350,670,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
    <input type="hidden" name="Expira" id="Expira" value="<%= conciergetour!=null ? conciergetour.getExpira2():""%>">
    <%=MyUtil.ObjInput("Sec.C.:","SecC", conciergetour!=null ? conciergetour.getSecC() :"",false,false,440,670,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
    <%=MyUtil.ObjInput("Confirmo","Confirmo", conciergetour!=null ? conciergetour.getConfirmo():"",true,true,30,710,"",false,false,30)%>
    <%=MyUtil.ObjInput("No.Conf.:","NConfirmo", conciergetour!=null ? conciergetour.getNConfirmo() :"",true,true,350,710,"",false,false,30,"")%>
    <%=MyUtil.ObjInput("Pol.Cancelaci�n","PCancel", conciergetour!=null ? conciergetour.getPCancel() :"",true,true,30,750,"",false,false,50)%>
    <%=MyUtil.ObjChkBox("N/U inf.:","NuInf", conciergetour!=null ? conciergetour.getNuInf():"",true,true,350,750,"","SI","NO","")%>
    <%=MyUtil.DoBlock("Forma de Pago",100,0)%>
    
    <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
    <input name='FechaProgMskI' id='FechaProgMskI' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
    <input name='FechaProgMskS' id='FechaProgMskS' type='hidden' value='VN09VN09F:/:VN09VN09'>
    <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
    <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
    <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>
    <input name='FechaIniMsk' id='FechaIniMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
    <%@ include file="csVentanaFlotante.jspf" %>
    <%
    //StrclConcierge = null;
    //StrclSubservicio = null;
    StrclAsistencia = null;
    daos=null;
    conciergetour=null;
    daosg=null;
    conciergeg=null;    
    daoRef=null;
    ref=null;
    %>
    <%=MyUtil.GeneraScripts()%>        
    <script>
			top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
		top.document.all.rightPO.rows="0,80,*";
		
                document.all.SecC.maxLength=4;
              function fnValidaFecha()
    {
     if (document.all.FechaI.value!='' && document.all.FechaO.value!= '')
    {
      if (document.all.FechaO.value < document.all.FechaI.value)
      {
       msgVal = msgVal + " Check-Out debe de ser mayor o igual a Check-In. "
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

//funci�n antes de guardar
function fnAntesGuardar(){
    if (document.all.clEstatus.value==10 ) {
        if (document.all.Encuentro.value==0 ) { msgVal = msgVal + " Punto de Encuentro";}
        if (document.all.CargoT.value==0 ) { msgVal = msgVal + " Cargo Total";}
        
        document.all.btnGuarda.disabled=false;
        document.all.btnCancela.disabled=false;
    }
   /* if (document.all.FechaI.value==''){
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
    // document.all.FechaIn.value=fnFechaID(document.all.FechaIn.value);
     //document.all.FechaFi.value=fnFechaID(document.all.FechaFi.value);
     document.all.FechaI.value=fnFechaID(document.all.FechaI.value);
     document.all.FechaO.value=fnFechaID(document.all.FechaO.value);
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
    if (document.all.FechaO.value=="1900-01-01"){
        document.all.FechaO.value="";
    }
    else {
        document.all.FechaO.value=fnFechaID(document.all.FechaO.value);
    }
    
}      
                          
    </script>
    <script type="text/javascript">
    initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
    </script>        
</body>
</html>