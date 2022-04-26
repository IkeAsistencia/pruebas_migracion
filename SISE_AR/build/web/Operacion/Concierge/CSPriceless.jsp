<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOPriceless,com.ike.concierge.to.ConciergePriceless,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
<head><title>Solicitud de Información</title>
    <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
    <script type="text/javascript">
            var floating_window_skin = 2;
    </script>
    <script type="text/javascript" src="floating_window_with_tabs.js"></script>        
</head>
<body class="cssBody" onload="fnVerificaFecha();DesExa();">
   
    <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
    <script src='../../Utilerias/Util.js' ></script>
    <script src='../../Utilerias/UtilMask.js'></script> 
    <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>
    <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i>Priceless BsAs Loggeo Web</i></b>  <br> </p></div>
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

    DAOPriceless daos=null;
    ConciergePriceless conciergepriceless=null;
    
    
    DAOConciergeG daosg = null;
    ConciergeG conciergeg = null;
    DAOReferenciasxAsist daoRef = null;
    ReferenciasxAsist ref = null;  
    
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
    String StrclPaginaWeb = "1776";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        
    if(strclUsr!=null){
        daos = new DAOPriceless();
        conciergepriceless= daos.getCSPriceless(StrclAsistencia);
        
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
    <% MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb),Integer.parseInt(strclUsr));%>
    <%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaPriceless","fnAccionesAlta();","fnAntesGuardar();")%>

    <%--.....................................33333333333333333333333333333--%>

    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>'>
    <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
    <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
    <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
    <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
    <%--.....................................33333333333333333333333333333--%>

    <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
    <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>
    <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
    <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
    <%String strEstatus = conciergepriceless!=null ? conciergepriceless.getdsEstatus()  : "";%>
    <!--%=MyUtil.ObjComboMem("Estatus","clEstatus",strEstatus,conciergepriceless!=null ? conciergepriceless.getclEstatus()  : "",cbEstatus.GeneraHTML(50,strEstatus),false,true,30,80,"0","","",50,false,false)%-->
    <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergepriceless!=null ? conciergepriceless.getdsEstatus(): "",false,false,30,80,"0","sp_GetCSstatus","","",30,false,false)%>
    <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,350,80,conciergepriceless!=null ? conciergepriceless.getclAsistencia().trim() : "",false,false,10)%>
    <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios",conciergepriceless!=null ? conciergepriceless.getComentarios()  : "","83","3",true,true,30,120,"",true,true)%>
    <%=MyUtil.ObjInput("fecha de alta","FechaRegistro",conciergepriceless!=null ? conciergepriceless.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
    <%=MyUtil.DoBlock("Datos Generales del Usuario",10,20)%>
    
    <%=MyUtil.ObjInput("Información Solicitada","InfoSolicitada",conciergepriceless!=null ? conciergepriceless.getInfoSolicitada()  : "",true,true,30,260,"",true,true,75)%>
    <%=MyUtil.ObjInput("Ciudad","Ciudad",conciergepriceless!=null ? conciergepriceless.getCiudad()  : "",true,true,30,300,"",false,false,30)%>
    <%=MyUtil.ObjInput("Estado","Estado",conciergepriceless!=null ? conciergepriceless.getEstado()  : "",true,true,240,300,"",false,false,30)%>    
    <%=MyUtil.ObjInput("Pais","Pais",conciergepriceless!=null ? conciergepriceless.getPais()  : "",true,true,450,300,"",false,false,30)%>    
    <%=MyUtil.ObjInputF("Fecha Inicio <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaInicio",conciergepriceless!=null ? conciergepriceless.getFechaInicio()  : "",true,true,30,340,"",false,false,20, 2, "")%>  </div>
    <%=MyUtil.ObjInputF("Fecha Término <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaTermino",conciergepriceless!=null ? conciergepriceless.getFechaTermino()  : "",true,true,240,340,"",false,false,20, 2, "")%>  </div>
    <!--%=MyUtil.ObjInput("E-mail","Correo",conciergepriceless!=null ? conciergepriceless.getCorreo()  : "",true,true,30,380,"",true,true,35,"isEmailAddress(this,Correo);")%-->
    <!--%=MyUtil.ObjInput("Otro","Otro",conciergepriceless!=null ? conciergepriceless.getOtro()  : "",true,true,240,380,"",false,false,30)%-->
    <%=MyUtil.ObjInput("Archivo Enviado","ArchEnviado",conciergepriceless!=null ? conciergepriceless.getArchEnviado()  : "",true,true,30,380,"",false,false,60)%>
    <% String StrUbica = conciergepriceless!=null ? conciergepriceless.getUbicacion() : "";
        String StrTipo = "";
        if (StrUbica.equals("")){ StrTipo="File";} else { StrTipo="Text";}
    %>
    <div id="Ubica" style='position:absolute; z-index:40; left:30px; top:420px; visibility:visible'>
        <p class='FTable'>Ubicacion<br>
        <input type="<%=StrTipo%>" name="Ubicacion" id="Ubicacion" size="75" class="VTable" ACCEPT="text/html" value="<%=StrUbica%>"></input>
        <input type="hidden" name="Ubicacion1" id="Ubicacion1" value="">
        </p>
    </div>    
    <%=MyUtil.DoBlock("Detalle de la Solicitud",50,40)%>
    
    <input name='FechaInicioMsk' id='FechaInicioMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
    <input name='FechaTerminoMsk' id='FechaTerminoMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
    <%@ include file="csVentanaFlotante.jspf" %>


    <%=MyUtil.GeneraScripts()%> 
      
    <script>
	
	                top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
                  top.document.all.rightPO.rows="0,80,*";
				  
        //if (document.all.clAsistencia.value!="0"){document.all.btnAlta.disabled=true;}
        function fnValidaFecha(){
            if (document.all.FechaInicio.value!='' && document.all.FechaTermino.value!= ''){
                if (document.all.FechaTermino.value <= document.all.FechaInicio.value){
                    msgVal = msgVal + " Fecha Término debe de ser mayor a Fecha Inicio. "
                    document.all.btnGuarda.disabled = false;
                    document.all.btnCancela.disabled = false;
                }
            }
        }
        function fnAccionesAlta(){
           if (document.all.Action.value==1){

                     var pstrCadena = "../../Utilerias/RegresaFechaActual.jsp";
                     window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');

                     document.all.Ubicacion1.value=document.all.Ubicacion.value;

             }
        }
        function fnActualizaFechaActual(pFecha){
        document.all.FechaApAsist.value = pFecha;
        }

        function fnAdicional(){
                     document.all.Ubicacion1.value=document.all.Ubicacion.value;
        }
        //Funcion para validar direccion de correo
        function isEmailAddress(theElement, nombre_del_elemento ){
            if (theElement.value!=""){
                var s = theElement.value;
                var filter=/^[A-Za-z][A-Za-z0-9_.]*@[A-Za-z0-9_]+\.[A-Za-z0-9_.]+[A-za-z]$/;
                if (s.length == 0 ) return true;
                if (filter.test(s))
                    return true;
                else
                    alert("Ingrese una dirección de correo válida");
                    theElement.focus();
                    return false;
             }
        }
        //Función para quitarle los cero a la fecha
        function fnVerificaFecha() {
             document.all.FechaInicio.value=fnFechaID(document.all.FechaInicio.value);
             document.all.FechaTermino.value=fnFechaID(document.all.FechaTermino.value);
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

        function DesExa(){
            //if(document.all.btnGuarda.disabled == true)document.all.Ubicacion.disabled=true;
            //else document.all.Ubicacion.disabled=false;
        }

        //función antes de guardar
        function fnAntesGuardar(){
            //..........................................44444444444444444444444444
            fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
            //..........................................44444444444444444444444444
        }
       
    </script>
    <script type="text/javascript">
            initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
    </script>    
 <%
    StrclConcierge = null;
    StrclSubservicio = null;
    StrclAsistencia = null;
    daos=null;
    conciergepriceless=null;
    daosg=null;
    conciergeg=null;
    daoRef=null;
    ref=null;
    %>        
</body>
</html>