<%-- 
    Document   : CSValetEjecutivo
    Created on : 23/11/2010, 12:12:18 PM
    Author     : rfernandez
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOConciergeValet,com.ike.concierge.to.ConciergeValet,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.CSConcierto,com.ike.concierge.to.ReferenciasxAsist,com.ike.concierge.DAOCSConcierto" errorPage="" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,javax.servlet.http.HttpSession,java.sql.ResultSet"%>
<html>
    <head>
        <title>Valet Ejecutivo</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" OnLoad="">     
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />

        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <script src='../../Utilerias/UtilCalendarioV.js'></script>
        <script src='../../Utilerias/UtilStore.js'></script>

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Valet Ejecutivo </i></b></font><br></p></div>
        <div class='VTable' style='position:absolute; z-index:25; left:570px; top:83px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Automatica </i></b></font><br></p></div>

        <%
            String StrclConcierge = "";
            String StrclSubservicio = "";
            String StrclAsistencia = "0";
            String strclUsr = "";
            

            //--------------------*  1  *--------------------------
            String StrURL = "";
            String StrNomPag = "";

            if (request.getRequestURL() != null) {
                StrURL = request.getRequestURL().toString();
                StrNomPag = StrURL.substring(StrURL.lastIndexOf("/") + 1);
                System.out.println("URL RQ(getRequestURL): ........................................... " + StrURL);
                System.out.println("Pagina.................................... " + StrNomPag);
            }
            //---------------------------------------------------

            DAOConciergeValet daoConciergeValet = null;
            ConciergeValet Valet = null;

            DAOReferenciasxAsist daoRef = null;
            ReferenciasxAsist ref = null;

            DAOConciergeG daosg = null;
            ConciergeG conciergeg = null;


            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();
            }
            if (session.getAttribute("clConcierge") != null) {
                StrclConcierge = session.getAttribute("clConcierge").toString();
            }
            if (request.getParameter("clAsistencia") != null) {
                StrclAsistencia = request.getParameter("clAsistencia").toString();
            } else {
                if (session.getAttribute("clAsistencia") != null) {
                    StrclAsistencia = session.getAttribute("clAsistencia").toString();
                }
            }
            if (request.getParameter("clSubservicio") != null) {
                StrclSubservicio = request.getParameter("clSubservicio").toString();
            } else {
                if (session.getAttribute("clSubservicio") != null) {
                    StrclSubservicio = session.getAttribute("clSubservicio").toString();
                }
            }
            session.setAttribute("clAsistencia", StrclAsistencia);
            session.setAttribute("clSubservicio", StrclSubservicio);

            String StrclPaginaWeb = "1274";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

            //<<<<<<<<<<<< Servlet Generico >>>>>>>>>>>
            String Store = "";
            Store = "st_GuardaCSValetEjecutivo,st_ActualizaCSValetEjecutivo";
            session.setAttribute("sp_Stores", Store);

            String Commit = "";
            Commit = "clAsistencia";
            session.setAttribute("Commit", Commit);

            if (strclUsr != null) {
                daoConciergeValet = new DAOConciergeValet();
                Valet = daoConciergeValet.getConciergeValet(StrclAsistencia);
            }
            if (strclUsr != null) {
                daosg = new DAOConciergeG();
                conciergeg = daosg.getConciergeGenerico(StrclConcierge);
            }
            if (strclUsr != null ) {
                daoRef = new DAOReferenciasxAsist();
                ref = daoRef.getclAsistencia(StrclAsistencia);
            }


            //---------------------*  2  *--------------------------
            ResultSet rs1 = null;
            String StrPreguntaEncuesta = "0";

            rs1 = UtileriasBDF.rsSQLNP("sp_CSPreguntaEncuesta " + StrclConcierge);
            if (rs1.next()) {
                StrPreguntaEncuesta = rs1.getString("Pregunta").toString();
            }
            rs1.close();
            rs1 = null;
            //-----------------------------------------------------
		
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
        <%
        MyUtil.InicializaParametrosC(1274, Integer.parseInt(strclUsr));
        %><%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "fnAccionesAlta();", "fnsp_Guarda();fnAntesGuardar();fnReqCampo();")%><%
        %>

    <%-------------------------  3  ----------------------------%>
    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>'>
    <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
    <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
    <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
    <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
    <%----------------------------------------------------------%>

    <input id="Secuencia"  name="Secuencia"  type="hidden" value="">
    <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="clConcierge,FechaApAsist,clUsrApp,FechaServicio,NoPersonas,Etiqueta,ComentariosD,Costo,Nombre,Direccion,Telefono,Telefono2,Telefono3,Telefono4,Contacto,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,Confirmo,NConfirmo,PCancel,NuInf,Observaciones">
    <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clAsistencia,FechaServicio,NoPersonas,Etiqueta,ComentariosD,Costo,Nombre,Direccion,Telefono,Telefono2,Telefono3,Telefono4,Contacto,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,Confirmo,NConfirmo,PCancel,NuInf,Observaciones,clEstatus">

    <INPUT id='clConcierge'  name='clConcierge'  type='hidden' value='<%=StrclConcierge%>'>
    <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
    <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
    <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>

     <%String strEstatus = Valet != null ? Valet.getDsEstatus() : "";%>

    <%=MyUtil.ObjComboC("Estatus", "clEstatus", Valet != null ? Valet.getDsEstatus() : "", false, false, 30, 70, "", "sp_GetCSstatus", "", "", 30, false, false)%>
    <%=MyUtil.ObjInput("Asistencia", "AsistenciaVTR", StrclAsistenciaVTR, false, false, 350, 70, "", false, false, 10)%>
    <%=MyUtil.ObjTextArea("Descripcion del Evento", "Observaciones", Valet != null ? Valet.getComentarios() : "", "83", "3", true, true, 30, 110, "", true, true)%>
    <%=MyUtil.ObjInput("fecha de alta", "FechaA", Valet != null ? Valet.getFechaRegistro(): "", false, false, 650, 70, "", false, false, 20)%>
    <%=MyUtil.DoBlock("Datos Generales del Evento", 5, 15)%>

    <%=MyUtil.ObjInputF("Fecha del Servicio", "FechaServicio", Valet != null ? Valet.getFechaServicio() : "", true, true, 30, 220, "", false, false, 20, 2, "")%>
    <%=MyUtil.ObjInput("No. Personas Solicitadas", "NoPersonas", Valet != null ? Valet.getNoPersonas() : "", true, true, 200, 220, "", false, false, 20)%>
    <%=MyUtil.ObjInput("Etiqueta", "Etiqueta", Valet != null ? Valet.getEtiqueta() : "", true, true, 390, 220, "", false, false, 20)%>
    <%=MyUtil.ObjTextArea("Comentarios", "ComentariosD", Valet != null ? Valet.getComentariosS() : "", "40", "4", true, true, 530, 220, "", false, false)%>
    <%=MyUtil.ObjInput("Costo del Servicio", "Costo", Valet != null ? Valet.getCosto() : "", true, true, 780, 220, "", false, false, 20)%>
    <%=MyUtil.DoBlock("Detalle del Servicio", -25, 25)%>

    <%=MyUtil.ObjInput("Nombre", "Nombre", Valet != null ? Valet.getNombre() : "", true, true, 30, 340, "", false, false, 45)%>
    <%=MyUtil.ObjTextArea("Direccion", "Direccion", Valet != null ? Valet.getDireccion() : "", "40", "6", true, true, 300, 340, "", false, false)%>
    <%=MyUtil.ObjInput("Telefonos", "Telefono", Valet != null ? Valet.getTelefono() : "", true, true, 550, 340, "", false, false, 25)%>
    <%=MyUtil.ObjInput("", "Telefono2", Valet != null ? Valet.getTelefono2() : "", true, true, 550, 360, "", false, false, 25)%>
    <%=MyUtil.ObjInput("", "Telefono3", Valet != null ? Valet.getTelefono3() : "", true, true, 550, 380, "", false, false, 25)%>
    <%=MyUtil.ObjInput("", "Telefono4", Valet != null ? Valet.getTelefono4() : "", true, true, 550, 400, "", false, false, 25)%>
    <%=MyUtil.ObjInput("Contacto", "Contacto", Valet != null ? Valet.getContacto() : "", true, true, 720, 340, "", false, false, 40)%>
    <%=MyUtil.DoBlock("Detalle Restaurante", 35, -5)%>

    <%=MyUtil.ObjComboC("Forma de Pago:","clTipoPago",Valet!=null ? Valet.getDsTipoPago(): "",true,true,30,480,"","select clTipoPago,dsTipoPago from CSTipoPago","fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();","",30,false,false)%>
    <%=MyUtil.ObjInput("Nombre del Banco:","NomBanco",Valet!=null ? Valet.getNomBanco() :"",false,false,200,480,"",false,false,40)%>
    <%=MyUtil.ObjInput("Nombre en TC:","NombreTC",Valet!=null ? Valet.getNombreTC(): "",false,false,450,480,"",false,false,30)%>
    <%=MyUtil.ObjInput("Numero de TC:","NumeroTC",Valet!=null ? Valet.getNumeroTC(): "",false,false,30,520,"",false,false,50,"if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
    <%=MyUtil.ObjInput("Exp.D.:(MM/AA)","ExpiraVTR",Valet!=null ? Valet.getExpira(): "",false,false,350,520,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
    <input type="hidden" name="Expira" id="Expira" value="<%=Valet!=null ? Valet.getExpira(): ""%>">
    <%=MyUtil.ObjInput("Sec.C.:","SecC",Valet!=null ? Valet.getSecC(): "",false,false,440,520,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
    <%=MyUtil.ObjInput("Confirmo","Confirmo",Valet!=null ? Valet.getConfirmo(): "",true,true,30,560,"",false,false,30)%>
    <%=MyUtil.ObjInput("No.Conf.:","NConfirmo",Valet!=null ? Valet.getNConfirmo(): "",true,true,350,560,"",false,false,40,"")%>
    <%=MyUtil.ObjInput("Pol.Cancelación","PCancel",Valet!=null ? Valet.getPCancel(): "",true,true,30,600,"",false,false,50)%>
    <%=MyUtil.ObjChkBox("N/U inf.:","NuInf",Valet!=null ? Valet.getNuInf(): "",true,true,350,600,"","SI","NO","")%>
    <%=MyUtil.DoBlock("Forma de Pago",100,0)%>

        <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>

    <%@ include file="csVentanaFlotante.jspf" %>

    <%
        StrclConcierge = null;
        StrclSubservicio = null;
        StrclAsistencia = null;
        daosg = null;
        conciergeg = null;
        daoRef = null;
        ref = null;
        Valet = null;
    %>

    <%=MyUtil.GeneraScripts()%>

        <script>
        top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
        top.document.all.rightPO.rows="0,50,*";

            function fnAccionesAlta(){
            if (document.all.Action.value==1){

                    var pstrCadena = "../../Utilerias/RegresaFechaActual.jsp";
                    window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');
                }
            }

            function fnActualizaFechaActual(pFecha){
                document.all.FechaApAsist.value = pFecha;
            }


            function fnReqCampo(){
                if (document.all.clTipoPago.value==1 || document.all.clTipoPago.value==2 || document.all.clTipoPago.value==3){
                    if ( document.all.NumeroTC.value=="" || document.all.Expira.value=="" || document.all.SecC.value=="")
                    {
                        msgVal = msgVal + " Debe de Ingresar Los campos requeridos de Tarjetas de Credito. ";
                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    }
                }
            }

            function fnAntesGuardar(){          
                //-------------------------   4   ----------------------------

                fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
                //------------------------------------------------------------
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


        </script>
        <script type="text/javascript">
            initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
        </script>
    </body>
</html>