
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeComprasVIP,com.ike.concierge.to.Conciergecomprasvip,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
<head><title>Compras Especiales/compras VIP</title>
    <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
    <script type="text/javascript">
            var floating_window_skin = 2;
    </script>
    <script type="text/javascript" src="floating_window_with_tabs.js"></script>        
</head>
<body class="cssBody" onload="">

    <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
    <script src='../../Utilerias/Util.js' ></script>
    <script src='../../Utilerias/UtilMask.js'></script>    
    <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>
    <script src='../../Utilerias/UtilCalendario.js'></script>
    <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Compras Especiales / Compras VIP </i></b>  <br> </p></div>
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

    DAOConciergeComprasVIP daos=null;
    Conciergecomprasvip conciergecomprasvip=null;
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
    String StrclPaginaWeb = "726";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    if(strclUsr!=null){
        daos = new DAOConciergeComprasVIP();
        conciergecomprasvip= daos.getCSVentasVIP(StrclAsistencia);
        
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
    MyUtil.InicializaParametrosC(726,Integer.parseInt(strclUsr)); 
    %><%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaComprasVIP","fnAccionesAlta();","fnAntesGuardar();fnReqCampo();fnReqCampo();")%><%
    
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
    <% String strEstatus = conciergecomprasvip!=null ? conciergecomprasvip.getDsEstatus() : ""; %>
    <!--%=MyUtil.ObjComboMem("Estatus","clEstatus",strEstatus,conciergecomprasvip!=null ? conciergecomprasvip.getEstatus() : "",cbEstatus.GeneraHTML(50,strEstatus),false,false,30,80,"0","","",50,false,false)%-->
    <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergecomprasvip!=null ? conciergecomprasvip.getDsEstatus(): "",false,false,30,80,conciergecomprasvip!=null ? conciergecomprasvip.getEstatus(): "0","sp_GetCSstatus","","",30,false,false)%>
    <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,350,80,conciergecomprasvip!=null ? conciergecomprasvip.getClAsistencia().trim() : "",false,false,10)%>
    <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios",conciergecomprasvip!=null ? conciergecomprasvip.getComentarios() : "","83","3",true,true,30,120,"",true,true)%>
    <%=MyUtil.ObjInput("fecha de alta","FechaRegistro",conciergecomprasvip!=null ? conciergecomprasvip.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
    <%=MyUtil.DoBlock("Datos Generales del Usuario",10,10)%>
    
    <%=MyUtil.ObjInput("Articulo Deseado","dsArticulo",conciergecomprasvip!=null ? conciergecomprasvip.getDsArticulo() : "",true,true,30,220,"",true,true,50)%>
    <%=MyUtil.ObjInput("Costo","Costo",conciergecomprasvip!=null ? conciergecomprasvip.getCosto() : "",true,true,350,220,"",false,false,10)%>
    <%=MyUtil.ObjInput("Destinatario","Destinatario",conciergecomprasvip!=null ? conciergecomprasvip.getDestinatario() : "",true,true,30,260,"",true,true,75)%>
    <%=MyUtil.ObjInput("Direccion","Direccion",conciergecomprasvip!=null ? conciergecomprasvip.getDireccion() : "",true,true,30,295,"",true,true,75)%>
    <%=MyUtil.ObjInput("Ciudad","Ciudad", conciergecomprasvip!=null ? conciergecomprasvip.getCiudad() : "",true,true,30,335,"",false,false,30)%>
    <%=MyUtil.ObjInput("Estado","Estado",conciergecomprasvip!=null ? conciergecomprasvip.getEstado() : "",true,true,250,335,"",false,false,30)%>
    <%=MyUtil.ObjInput("Pais","Pais",conciergecomprasvip!=null ? conciergecomprasvip.getPais() : "",true,true,450,335,"",false,false,30)%>
    <%=MyUtil.ObjInput("Telefono","TelefonoD",conciergecomprasvip!=null ? conciergecomprasvip.getTelefonoD() : "",true,true,30,375,"",true,true,25)%>
    <%=MyUtil.ObjInput("Otro Telefono","OtroTelD",conciergecomprasvip!=null ? conciergecomprasvip.getOtroTelD() : "",true,true,250,375,"",true,true,25)%>
    <%=MyUtil.ObjInputF("Fecha y hora de Entrega","FechaE",conciergecomprasvip!=null ? conciergecomprasvip.getFechaE() : "",true,true,30,410,"",false,true,20, 2, "")%>  </div>
    <%=MyUtil.ObjInput("Metodo Entrega","Metodo",conciergecomprasvip!=null ? conciergecomprasvip.getMetodo() : "",true,true,250,410,"",false,true,30)%>
    <%=MyUtil.ObjInput("Mensajeria","Mensajeria",conciergecomprasvip!=null ? conciergecomprasvip.getMensajeria() : "",true,true,450,410,"",false,false,30)%>
    <%=MyUtil.ObjInput("Guia","Guia",conciergecomprasvip!=null ? conciergecomprasvip.getGuia() : "",true,true,30,445,"",false,false,30)%>
    <%=MyUtil.ObjInput("Cargo Total","CargoT",conciergecomprasvip!=null ? conciergecomprasvip.getCargoT() : "",true,true,250,445,"",false,false,30)%>
    <%=MyUtil.DoBlock("Destinatario",100,5)%>
   
    <%=MyUtil.ObjInput("Remitente","Remitente",conciergecomprasvip!=null ? conciergecomprasvip.getRemitente() : "",true,true,30,535,"",false,false,75)%>
    <%=MyUtil.ObjInput("Tel�fono","Telefono", conciergecomprasvip!=null ? conciergecomprasvip.getTelefono() : "",true,true,450,535, "",false,false,25)%>
    <%=MyUtil.ObjInput("Celular","Celular",conciergecomprasvip!=null ? conciergecomprasvip.getCelular() : "",true,true,625,535,"",false,false,25)%>
    <%=MyUtil.ObjComboC("Forma de Pago:","clTipoPago",conciergecomprasvip!=null ? conciergecomprasvip.getDsTipoPago() : "",true,true,30,580,"","select clTipoPago,dsTipoPago from CSTipoPago","fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();","",30,false,false)%>
    <%=MyUtil.ObjInput("Nombre del Banco:","NomBanco",conciergecomprasvip!=null ? conciergecomprasvip.getNomBanco(): "",true,true,350,580,"",false,false,40)%>
    <%=MyUtil.ObjInput("Nombre en TC:","NombreTC",conciergecomprasvip!=null ? conciergecomprasvip.getNombreTC() : "",true,true,625,580,"",false,false,40)%>
    <!--%=MyUtil.ObjComboC("Tipo Tarjeta:","clTipoTarjeta",conciergecomprasvip!=null ? conciergecomprasvip.getDsTipoTarjeta() : "",true,true,625,580,: "","select clTipoTarjeta,dsTipoTarjeta from CSTipoTarjeta","","",30,true,true)%-->
    <%=MyUtil.ObjInput("Numero de TC:","NumeroTC", conciergecomprasvip!=null ? conciergecomprasvip.getNumeroTC() : "",true,false,30,615,"",false,false,50,"if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
    <%=MyUtil.ObjInput("Exp.D.:(MM/AA)","ExpiraVTR",conciergecomprasvip!=null ? conciergecomprasvip.getExpira2() : "",true,false,350,615,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
    <input type="hidden" name="Expira" id="Expira" value="<%=conciergecomprasvip!=null ? conciergecomprasvip.getExpira() : ""%>">
    <%=MyUtil.ObjInput("Sec.C.:","SecC",conciergecomprasvip!=null ? conciergecomprasvip.getSecC() : "",true,false,440,615,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
    <%=MyUtil.ObjInput("Otra Forma de Pago","PagoO",conciergecomprasvip!=null ? conciergecomprasvip.getPagoO() : "",true,true,30,650,"",false,false,50)%>
    <%=MyUtil.ObjInput("Confirmo","Confirmo",conciergecomprasvip!=null ? conciergecomprasvip.getConfirmo() : "",true,true,350,650,"",false,false,30)%>
    <%=MyUtil.ObjInput("No.Conf.:","NConfirmo",conciergecomprasvip!=null ? conciergecomprasvip.getNConfirmo(): "",true,true,625,650,"",false,false,30)%>
    <%=MyUtil.ObjInput("Pol.Cancelaci�n","PCancel",conciergecomprasvip!=null ? conciergecomprasvip.getPCancel() : "",true,true,30,690,"",false,false,50)%>
    <%=MyUtil.ObjChkBox("N/U inf.:","NuInf",conciergecomprasvip!=null ? conciergecomprasvip.getNuInf() : "",true,true,350,690,"0","SI","NO","")%>
    <%=MyUtil.DoBlock("Remitente",100,20)%>
    
    <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
    
    <%@ include file="csVentanaFlotante.jspf" %>
    <%
    //StrclConcierge = null;
    //StrclSubservicio = null;
    StrclAsistencia = null;
    daos=null;
    conciergecomprasvip=null;
    daosg=null;
    conciergeg=null;
    
     daoRef=null;
         ref=null;
    %>
    <%=MyUtil.GeneraScripts()%>

        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>
        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
    

<script>
                top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
                  top.document.all.rightPO.rows="0,80,*";
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
   

//funci�n antes de guardar
function fnAntesGuardar(){
    if (document.all.clEstatus.value==10 ) {
        if (document.all.CargoT.value==0 ) { msgVal = msgVal + " Cargo Total";}
        document.all.btnGuarda.disabled=false;
        document.all.btnCancela.disabled=false;
    }
    //..........................................44444444444444444444444444
        fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
    //..........................................44444444444444444444444444
}
//Funci�n para quitarle los cero a la fecha
function fnVerificaFecha() {
     document.all.FechaE.value=fnFechaID(document.all.FechaE.value);
     //document.all.FechaEventoF.value=fnFechaID(document.all.FechaEventoF.value);
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

    </script>
    <script type="text/javascript">
         initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
    </script>        
</body>
</html>