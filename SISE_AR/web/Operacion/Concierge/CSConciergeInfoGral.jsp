<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOInfoGral,com.ike.concierge.to.ConciergeInfoGral,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<html>
<head><title>Informacion General</title>
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
    <script src='../../Utilerias/UtilMask.js'></script> 
    <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>
    <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i>Informacion General</i></b>  <br> </p></div>
    <script src='../../Utilerias/UtilCalendario.js'></script>
    <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    <div class='VTable' style='position:absolute; z-index:25; left:570px; top:93px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Autom�tica </i></b>  <br> </p></div>
    <%
    String strclUsr = "";
    if (session.getAttribute("clUsrApp") != null) {
        strclUsr = session.getAttribute("clUsrApp").toString();    }
   if(SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true){
        %>Fuera de Horario<% 
	strclUsr=null;
        return;
        }
    String StrclConcierge = "";
    String StrclSubservicio = "";
    String StrclAsistencia = "0";
    String StrURL="";
    String StrNomPag = "";
    String StrclPaginaWeb = "757";
    String StrPreguntaEncuesta = "0";
    String StrclAsistenciaVTR = "";
    String strEstatus="";
    String StrUbica="";
    String StrTipo = "";

    String StrclCuenta = "";

    DAOInfoGral daos=null;
    ConciergeInfoGral conciergeinfogral=null;
    DAOConciergeG daosg=null;
    ConciergeG conciergeg=null;
    DAOReferenciasxAsist daoRef=null;
    ReferenciasxAsist ref=null; 
    ResultSet rs = null;
    boolean Requerido=false;
    if (request.getRequestURL()!= null) {
        StrURL = request.getRequestURL().toString();
        StrNomPag = StrURL.substring(StrURL.lastIndexOf("/")+1) ;
        }
    if (session.getAttribute("clUsrApp")!= null) {
        strclUsr = session.getAttribute("clUsrApp").toString();  }
    if (session.getAttribute("clConcierge")!= null) {
        StrclConcierge= session.getAttribute("clConcierge").toString();   }
    if (request.getParameter("clAsistencia")!= null) {
        StrclAsistencia= request.getParameter("clAsistencia").toString();
    } else{
        if (session.getAttribute("clAsistencia")!= null) {
            StrclAsistencia= session.getAttribute("clAsistencia").toString();  }
    }
    if (request.getParameter("clSubservicio")!= null) {
        StrclSubservicio= request.getParameter("clSubservicio").toString();
    } else{
        if (session.getAttribute("clSubservicio")!= null) {
            StrclSubservicio= session.getAttribute("clSubservicio").toString(); }
    }
    session.setAttribute("clAsistencia",StrclAsistencia);
    session.setAttribute("clSubservicio",StrclSubservicio);
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    if(strclUsr!=null){
        daos = new DAOInfoGral();
        conciergeinfogral= daos.getCSInfoGral(StrclAsistencia);
        daoRef = new DAOReferenciasxAsist();
        ref = daoRef.getclAsistencia(StrclAsistencia);
        }
    if(strclUsr!=null){
        daosg = new DAOConciergeG();
        conciergeg = daosg.getConciergeGenerico(StrclConcierge);
        }
    rs = UtileriasBDF.rsSQLNP("sp_CSPreguntaEncuesta "+StrclConcierge);
    if (rs.next()) {
        StrPreguntaEncuesta = rs.getString("Pregunta").toString();   }
    rs.close();
    rs = null;
    // SE AGREGA CODIGO PARA EL MANEJO DE LAS ASISTENCIAS DUPLICADAS.
    rs = UtileriasBDF.rsSQLNP(" st_CSTieneAsistMadre "+StrclAsistencia);
    if(rs.next()){
	if(rs.getString("TieneAsistMadre").equalsIgnoreCase("1")){
	    StrclAsistenciaVTR = rs.getString("Folio");
        }else{ 	StrclAsistenciaVTR = StrclAsistencia;	}
	session.setAttribute("clAsistenciaVTR", StrclAsistenciaVTR);
	}
    rs.close();
    rs = null;
    //validacion para requerir nuevo combo de clasificacion de informacion
    rs = UtileriasBDF.rsSQLNP("st_CSValidaAsist "+StrclAsistencia);
    if(rs.next()){
	if(rs.getString("Requerido").equalsIgnoreCase("1")){
            Requerido = true;
        }else{ Requerido = false;   }
    }
    rs.close();
    rs = null;

    //----------------------------------------------------
     rs = UtileriasBDF.rsSQLNP("st_CSObtenCuenta " + StrclConcierge);

            if (rs.next()) {
                StrclCuenta = rs.getString("clCuenta").toString();
            }

            rs.close();
            rs = null;
    //-----------------------------------------------------
    strEstatus = conciergeinfogral!=null ? conciergeinfogral.getdsEstatus()  : "";
    StrUbica = conciergeinfogral!=null ? conciergeinfogral.getUbicacion() : "";
    %>
    <script>fnOpenLinks();</script> 
    <% MyUtil.InicializaParametrosC(757,Integer.parseInt(strclUsr));%>
    <%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaInfoGral","fnAccionesAlta();","fnAntesGuardar();")%>
    <input id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>'/>
    <input id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>"/>
    <input id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'/>
    <input id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'/>
    <input id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'/>
    <input id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'/>
    <input id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'/>
    <input id='FechaApAsist' name='FechaApAsist' type='hidden' value=''/>
    <input id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'/>
    <input name='FechaInicioMsk' id='FechaInicioMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'/>
    <input name='FechaTerminoMsk' id='FechaTerminoMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'/>
    
    <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergeinfogral!=null ? conciergeinfogral.getdsEstatus(): "",false,false,30,80,"0","sp_GetCSstatus","","",30,false,false)%>
    <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,350,80,conciergeinfogral!=null ? conciergeinfogral.getclAsistencia().trim() : "",false,false,10)%>
    <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios",conciergeinfogral!=null ? conciergeinfogral.getComentarios()  : "","83","3",true,true,30,120,"",true,true)%>
    <%=MyUtil.ObjInput("fecha de alta","FechaRegistro",conciergeinfogral!=null ? conciergeinfogral.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
    <%=MyUtil.DoBlock("Datos Generales del Usuario",10,20)%>
    
    <%=MyUtil.ObjInput("Informaci�n Solicitada","InfoSolicitada",conciergeinfogral!=null ? conciergeinfogral.getInfoSolicitada()  : "",true,true,30,260,"",true,true,75)%>
    <%=MyUtil.ObjInput("Ciudad","Ciudad",conciergeinfogral!=null ? conciergeinfogral.getCiudad()  : "",true,true,30,300,"",false,false,30)%>
    <%=MyUtil.ObjInput("Estado","Estado",conciergeinfogral!=null ? conciergeinfogral.getEstado()  : "",true,true,240,300,"",false,false,30)%>    
    <%=MyUtil.ObjInput("Pais","Pais",conciergeinfogral!=null ? conciergeinfogral.getPais()  : "",true,true,450,300,"",false,false,30)%>    
    <%=MyUtil.ObjInputF("Fecha Inicio <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaInicio",conciergeinfogral!=null ? conciergeinfogral.getFechaInicio()  : "",true,true,30,340,"",false,false,20, 2, "")%>  </div>
    <%=MyUtil.ObjInputF("Fecha T�rmino <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaTermino",conciergeinfogral!=null ? conciergeinfogral.getFechaTermino()  : "",true,true,240,340,"",false,false,20, 2, "")%>  </div>
    <%=MyUtil.ObjInput("Archivo Enviado","ArchEnviado",conciergeinfogral!=null ? conciergeinfogral.getArchEnviado()  : "",true,true,30,380,"",false,false,60)%>
    <%=MyUtil.ObjComboC("Tipo de Informacion","clTipoInfoBrindada",conciergeinfogral!=null ? conciergeinfogral.getDsTipoInfoBrindada(): "",true,true,400,380,"0","select clTipoInfoBrindada, dsTipoInfoBrindada from CScTipoInfoBrindada where Activo = 1 and clCuenta = " + StrclCuenta + " ","","",30,Requerido,Requerido)%>
   <% if (StrUbica.equals("")){ StrTipo="File";} else { StrTipo="Text";} %>
    <div id="Ubica" style='position:absolute; z-index:40; left:30px; top:420px; visibility:visible'>
        <p class='FTable'>Ubicacion<br>
            <input type="<%=StrTipo%>" name="Ubicacion" id="Ubicacion" size="75" class="VTable" ACCEPT="text/html" value="<%=StrUbica%>"/>
            <input type="hidden" name="Ubicacion1" id="Ubicacion1" value=""/>
        </p>
    </div>    
    <%=MyUtil.DoBlock("Detalle de la Solicitud",130,40)%>
    <%@ include file="csVentanaFlotante.jspf" %>
    <%=MyUtil.GeneraScripts()%> 
    <script>
//------------------------------------------------------------------------------
        top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
        top.document.all.rightPO.rows="0,80,*";	
//------------------------------------------------------------------------------
        //if (document.all.clAsistencia.value!="0"){document.all.btnAlta.disabled=true;}
//------------------------------------------------------------------------------
        function fnValidaFecha(){
            if (document.all.FechaInicio.value!='' && document.all.FechaTermino.value!= ''){
		if (document.all.FechaTermino.value <= document.all.FechaInicio.value){
                    msgVal = msgVal + " Fecha T�rmino debe de ser mayor a Fecha Inicio. ";
                    document.all.btnGuarda.disabled = false;
                    document.all.btnCancela.disabled = false;
                    }
                }
            }
//------------------------------------------------------------------------------
        function fnAccionesAlta(){
            if (document.all.Action.value=='1'){
		var pstrCadena = "../../Utilerias/RegresaFechaActual.jsp";
                window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');
		document.all.Ubicacion1.value=document.all.Ubicacion.value;
             }
        }
//------------------------------------------------------------------------------
        function fnActualizaFechaActual(pFecha){
        document.all.FechaApAsist.value = pFecha;
        }
//------------------------------------------------------------------------------
        function fnAdicional(){
                     document.all.Ubicacion1.value=document.all.Ubicacion.value;
        }
//-------------------------------Funcion para validar direccion de correo-------
        function isEmailAddress(theElement, nombre_del_elemento ){
            if (theElement.value!=""){
                var s = theElement.value;
                var filter=/^[A-Za-z][A-Za-z0-9_.]*@[A-Za-z0-9_]+\.[A-Za-z0-9_.]+[A-za-z]$/;
                if (s.length == 0 ) return true;
                if (filter.test(s))
                    return true;
                else
                    alert("Ingrese una direcci�n de correo v�lida");
                    theElement.focus();
                    return false;
             }
        }
//---------------------------Funci�n para quitarle los cero a la fecha----------
        function fnVerificaFecha() {
            document.all.FechaInicio.value=fnFechaID(document.all.FechaInicio.value);
            document.all.FechaTermino.value=fnFechaID(document.all.FechaTermino.value);
	    }
//--------------------------------funci�n que regresa la fecha sin hora---------
        function fnFechaID(Fecha){
	    if (Fecha!=""){
		FechaSinHora=Fecha;
		FechaSinHora=FechaSinHora.substring(0,10);
                return FechaSinHora;
	    }else{
                FechaSinHora='';
                return FechaSinHora;
                }
        }
//----------------------------------------funci�n antes de guardar--------------
        function fnAntesGuardar(){
	    clConcierge=document.all.clConcierge.value;
	    clSubservicio=document.all.clSubservicio.value;
	    clStrURL=document.all.clStrURL.value;
	    clStrNomPag=document.all.clStrNomPag.value;
            fnPregunta(clConcierge,clSubservicio,clStrURL,clStrNomPag);
        }
//------------------------------------------------------------------------------
        initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
    </script>    
 <%
    StrclConcierge = null;
    StrclSubservicio = null;
    StrclAsistencia = null;
    daos=null;
    conciergeinfogral=null;
    daosg=null;
    conciergeg=null;
    daoRef=null;
    ref=null;
    %>        
</body>
</html>