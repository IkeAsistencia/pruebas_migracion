<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOConciergeAuto,com.ike.concierge.to.Conciergeauto,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
    <head><title>Bienvenida a Concierge</title>
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
        <script src='../../Utilerias/UtilStore.js'></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Bienvenida Concierge </i></b>  <br> </p></div>
        <div class='VTable' style='position:absolute; z-index:25; left:570px; top:93px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Automatica </i></b>  <br> </p></div>

        <%
            String StrclAsistencia = "0";
            String StrclConcierge = "";
            String strclUsr = "";
            String Strclservicio = "7";
            String StrclSubservicio = "43";
            String StrFechaRegAsist = "";
            String StrFechaApAsist = "";
            String StrURL = "";
            String StrNomPag = "";
            String StrclPaginaWeb = "6073";
            String StrPreguntaEncuesta = "0";
            String StrclAsistenciaVTR = "";
            String StrDsEtatus = "";

            String StrEComercial = "";
            String StrEPersonal = "";
            String StrEAlterno = "";
            String StrEOtro = "";
            String StrEPersonalAsist = "";
            String StrEOtroAsist = "";
            String StrDescripcion = "";

            String Commit = "";

            Commit = "clAsistencia";
            session.setAttribute("Commit", Commit);

            StringBuffer StrSql = new StringBuffer();
            ResultSet rs = null;

            if (request.getRequestURL() != null) {
                StrURL = request.getRequestURL().toString();
                StrNomPag = StrURL.substring(StrURL.lastIndexOf("/") + 1);
                System.out.println("URL RQ(getRequestURL): ........................................... " + StrURL);
                System.out.println("Pagina.................................... " + StrNomPag);
            }

            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();
            } else if (request.getParameter("clUsrApp") != null) {
                strclUsr = request.getParameter("clUsrApp").toString();
            }

            if (session.getAttribute("clConcierge") != null) {
                StrclConcierge = session.getAttribute("clConcierge").toString();
            } else if (request.getParameter("clConcierge") != null) {
                StrclConcierge = request.getParameter("clConcierge").toString();
            }

            if (request.getParameter("clAsistencia") != null) {
                StrclAsistencia = request.getParameter("clAsistencia").toString();
            } else {
                if (session.getAttribute("clAsistencia") != null) {
                    StrclAsistencia = session.getAttribute("clAsistencia").toString();
                }
            }

            if (request.getParameter("Strclservicio") != null) {
                Strclservicio = request.getParameter("Strclservicio").toString();
            } else {
                if (session.getAttribute("Strclservicio") != null) {
                    Strclservicio = session.getAttribute("Strclservicio").toString();
                }
            }

            if (request.getParameter("clSubservicio") != null) {
                StrclSubservicio = request.getParameter("clSubservicio").toString();
            } else {
                if (session.getAttribute("clSubservicio") != null) {
                    StrclSubservicio = session.getAttribute("clSubservicio").toString();
                }
            }

            DAOConciergeG daosg = null;
            ConciergeG conciergeg = null;
            DAOReferenciasxAsist daoRef = null;
            ReferenciasxAsist ref = null;

            session.setAttribute("clAsistencia", StrclAsistencia);
            session.setAttribute("clSubservicio", StrclSubservicio);
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

            rs = UtileriasBDF.rsSQLNP("sp_CSPreguntaEncuesta " + StrclConcierge);
            if (rs.next()) {
                StrPreguntaEncuesta = rs.getString("Pregunta").toString();
            }
            rs.close();
            rs = null;

            // SE AGREGA CODIGO PARA EL MANEJO DE LAS ASISTENCIAS DUPLICADAS.
            rs = UtileriasBDF.rsSQLNP(" st_CSTieneAsistMadre " + StrclAsistencia);
            if (rs.next()) {
                if (rs.getString("TieneAsistMadre").equalsIgnoreCase("1")) {
                    StrclAsistenciaVTR = rs.getString("Folio");
                } else {
                    StrclAsistenciaVTR = StrclAsistencia;
                }
                session.setAttribute("clAsistenciaVTR", StrclAsistenciaVTR);
            }
            rs.close();
            rs = null;

            StrSql.append("st_CSObtenBienvenida ").append(StrclAsistencia);

            if (strclUsr != null) {

                if (strclUsr != null) {
                    daosg = new DAOConciergeG();
                    conciergeg = daosg.getConciergeGenerico(StrclConcierge);

                    daoRef = new DAOReferenciasxAsist();
                    ref = daoRef.getclAsistencia(StrclAsistencia);
                }

                rs = UtileriasBDF.rsSQLNP(StrSql.toString());
                if (rs.next()) {
                    StrclConcierge = rs.getString("clConcierge");
                    StrFechaRegAsist = rs.getString("FechaRegAsist");
                    StrclSubservicio = rs.getString("clServicio");
                    StrclSubservicio = rs.getString("clSubservicio");
                    StrFechaRegAsist = rs.getString("FechaRegAsist");
                    StrFechaApAsist = rs.getString("clEstatus");
                    StrDsEtatus = rs.getString("dsEstatus");
                    StrEComercial = rs.getString("EComercial");
                    StrEPersonal = rs.getString("EPersonal");
                    StrEAlterno = rs.getString("EAlterno");
                    StrEOtro = rs.getString("EOtro");
                    StrEPersonalAsist = rs.getString("EPersonalAsist");
                    StrEOtroAsist = rs.getString("EOtroAsist");
                    StrDescripcion = rs.getString("Descripcion");
                }
            }
            rs.close();
            rs = null;

            String Store = "";
            Store = "st_CSGuardaBienvenida,st_CSActualizaBienvenida";
            session.setAttribute("sp_Stores", Store);
        %>
        <SCRIPT>fnOpenLinks()</script>
            <%
                MyUtil.InicializaParametrosC(6073, Integer.parseInt(strclUsr));
            %>
        <!--%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","fnAccionesAlta();","fnAntesGuardar();")%-->
        <%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "fnAccionesAlta();", "fnsp_Guarda();fnAntesGuardar();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>'>
        <input id="Secuencia" name="Secuencia" type="hidden" value="">
        <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="clConcierge,clUsrApp,clServicio,clSubservicio,FechaRegAsist,FechaApAsist,clAsistencia,clEstatus,Descripcion">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clConcierge,clUsrApp,clServicio,clSubservicio,FechaRegAsist,clAsistencia,clEstatus,Descripcion">
        <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>
        <INPUT id='clServicio' name='clServicio' type='hidden' value='<%=Strclservicio%>'>
        <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
        <INPUT id='FechaRegAsist' name='FechaRegAsist' type='hidden' value='<%=StrFechaRegAsist%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value='<%=StrFechaApAsist%>'>
        <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
        <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
        <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>

        <%=MyUtil.ObjComboC("Estatus", "clEstatus", StrDsEtatus, false, false, 30, 80, "0", "sp_GetCSstatus", "", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Asistencia", "AsistenciaVTR", StrclAsistenciaVTR, false, false, 350, 80, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento", "Descripcion", StrDescripcion, "83", "3", true, true, 30, 120, "", true, true)%>
        <%=MyUtil.ObjInput("fecha de alta", "FechaRegistro", StrFechaRegAsist, false, false, 650, 80, "", false, false, 20)%>
        <!--%=MyUtil.ObjChkBox("Comercial", "EComercial", StrEComercial, true, false, 30, 190, "0", "Si", "No", "")%-->
        <!--%=MyUtil.ObjChkBox("Personal", "EPersonal", StrEPersonal, true, false, 130, 190, "0", "Si", "No", "")%-->
        <!--%=MyUtil.ObjChkBox("Alterno", "EAlterno", StrEAlterno, true, false, 230, 190, "0", "Si", "No", "")%-->
        <!--%=MyUtil.ObjChkBox("Otro", "EOtro", StrEOtro, true, false, 330, 190, "0", "Si", "No", "")%-->
        <!--%=MyUtil.ObjChkBox("Personal (Asistente)", "EPersonalAsist", StrEPersonalAsist, true, false, 430, 190, "0", "Si", "No", "")%-->
        <!--%=MyUtil.ObjChkBox("Otro (Asistente)", "EOtroAsist", StrEOtroAsist, true, false, 600, 190, "0", "Si", "No", "")%-->
        <%=MyUtil.DoBlock("Datos Generales del Usuario", 10, 10)%>

        <%@ include file="csVentanaFlotante.jspf" %> 

        <%=MyUtil.GeneraScripts()%>
        <script>

            top.document.all.DatosExpediente.src = "Operacion/Concierge/CSDatosConcierge.jsp";
            top.document.all.rightPO.rows = "0,80,*";


            function fnActualizaFechaActual(pFecha) {
                document.all.FechaApAsist.value = pFecha;
                document.all.FechaRegAsist.value = pFecha;
            }
            //función antes de guardar
            function fnAntesGuardar() {
                fnPregunta(document.all.clConcierge.value, document.all.clSubservicio.value, document.all.clStrURL.value, document.all.clStrNomPag.value);
            }

            function fnAccionesAlta() {
                if (document.all.Action.value == 1) {
                    var pstrCadena = "../../Utilerias/RegresaFechaActual.jsp";
                    window.open(pstrCadena, 'newWin', 'width=10,height=10,left=1500,top=2000');
                }
            }
        </script>
        <script type="text/javascript">
            initFloatingWindowWithTabs('window4', Array('Nuestro Usuario', 'Referencias'), 350, 250, 700, 20, false, false, true, true, false);
        </script>
        <%

        %>
    </body>
</html>