<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Supervisión</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="fnValidaNoRecomienda();">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../Utilerias/UtilMask.js'></script>
        <%
            String StrclPaginaWeb = "288";
            String StrclExpediente = "0";
            String strclUsr = "0";
            String strclSupervision = "0";
            String strNumSupervision = "0";
            String StrNombreUsuario = "";
            String StrTipo = "";
            String strclEstatusSup = "";
            String strNuestroUsuario = "";
            String strLada1 = "";
            String strTelefono1 = "";
            String strLada2 = "";
            String strTelefono2 = "";
            StringBuffer StrSql = new StringBuffer();           

            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            if (request.getParameter("clSupervision") != null) {
                strclSupervision = request.getParameter("clSupervision").toString();
            } else {
                if (session.getAttribute("clSupervision") != null) {
                    strclSupervision = session.getAttribute("clSupervision").toString();
                }
            }

            if (request.getParameter("clNumSupervision") != null) {
                strNumSupervision = request.getParameter("clNumSupervision").toString();
            } else {
                if (session.getAttribute("clNumSupervision") != null) {
                    strNumSupervision = session.getAttribute("clNumSupervision").toString();
                }
            }

            if (session.getAttribute("NombreUsuario") != null) {
                StrNombreUsuario = session.getAttribute("NombreUsuario").toString();
            }

            session.setAttribute("clSupervision", strclSupervision);
            session.setAttribute("clNumSupervision", strNumSupervision);

            if (strclSupervision.compareToIgnoreCase("0") == 0) {   //Sin Supervision
                StrSql.append(" st_getDetalleSupSin ").append(StrclExpediente).append(",").append(strclSupervision).append(",'").append(strclUsr).append("','").append(StrNombreUsuario).append("'");
            } else {                                                //Con supervision
                StrSql.append(" st_getDetalleSup ").append(strclSupervision);
            }

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

            MyUtil.InicializaParametrosC(288, Integer.parseInt(strclUsr));
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());%>

        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "", "fnAntesGuardar();")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1) + "DetalleSupervision.jsp?"%>'>

        <%
            if (rs.next()) {
                String strdsCalifSup = rs.getString("dsCalificacionSup");
                if (strdsCalifSup == null) {
                    strdsCalifSup = "";
                }

                String strclCalifSup = rs.getString("clCalificacionSup");
                if (strclCalifSup == null) {
                    strclCalifSup = "0";
                }
                
                String strclUsrAppSup = rs.getString("clUsrAppSup");
                if (strclUsrAppSup == null) {
                    strclUsrAppSup = "0";
                }
                // si es MALO O MALO / CRITICO debe cerrar la ventana y mandar la pagina padre a registro de queja
%>
        <SCRIPT type="text/javascript" >if (window.name == 'Contenido') {
            fnOpenLinks();
        } else {
            if (<%=strclCalifSup%> == 4 || <%=strclCalifSup%> == 5) {
                window.opener.fnRelocate('../Supervision/QuejasxSupervision.jsp?');
                window.close();
            }
        }</SCRIPT>
            <%
                strclEstatusSup = rs.getString("clEstatusSup");
                if (strclEstatusSup == null) {
                    strclEstatusSup = "0";
                }

                strNuestroUsuario = rs.getString("NuestroUsuario");
                if (strNuestroUsuario == null) {
                    strNuestroUsuario = "";
                }

                strLada1 = rs.getString("Lada1");
                if (strLada1 == null) {
                    strLada1 = "";
                }

                strTelefono1 = rs.getString("Telefono1");
                if (strTelefono1 == null) {
                    strTelefono1 = "";
                }

                strLada2 = rs.getString("Lada2");
                if (strLada2 == null) {
                    strLada2 = "";
                }

                strTelefono2 = rs.getString("Telefono2");
                if (strTelefono2 == null) {
                    strTelefono2 = "";
                }

                if (strclEstatusSup.compareToIgnoreCase("6") == 0 || strclEstatusSup.compareToIgnoreCase("3") == 0) {%>
        <SCRIPT type="text/javascript">
            document.all.btnAlta.disabled = true;
            document.all.btnCambio.disabled = false;
            document.all.btnElimina.disabled = true;
        </SCRIPT>
        <%} else if (strclEstatusSup.compareToIgnoreCase("0") == 0) {%>
        <SCRIPT type="text/javascript">
            document.all.btnCambio.disabled = true;
            document.all.btnElimina.disabled = true;
        </SCRIPT>
        <% } else {
            StrSql.append(" st_getPermisoSup ").append(strclUsr);

            ResultSet rsPermiso = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rsPermiso.next()) {
                if (rsPermiso.getInt("Permiso") > 0) {
        %>
        <SCRIPT type="text/javascript">
            document.all.btnAlta.disabled = true;
            document.all.btnCambio.disabled = false;
            document.all.btnElimina.disabled = true;
        </SCRIPT>
        <% } else {%>
        <SCRIPT type="text/javascript">
            document.all.btnAlta.disabled = true;
            document.all.btnCambio.disabled = true;
            document.all.btnElimina.disabled = true;
        </SCRIPT>
        <% }
                }
            }%>
        <INPUT id='clSupervision' name='clSupervision' type='hidden' value='<%= strclSupervision%>'>
        <INPUT id='NumSupervision' name='NumSupervision' type='hidden' value='<%=strNumSupervision%>'>
        <INPUT id='clUsrAppAsig' name='clUsrAppAsig' type='hidden' value='<%=rs.getString("clUsrAppAsig")%>'>       
        <INPUT id='clUsrAppSup' name='clUsrAppSup' type='hidden' value='<%= strclUsrAppSup%>'>

        <%=MyUtil.ObjInput("Expediente", "clExpediente", StrclExpediente, false, false, 30, 70, StrclExpediente, false, false, 15)%>
        <%=MyUtil.ObjInput("Nuestro Usuario", "NuestroUsuario", strNuestroUsuario, false, false, 130, 70, strNuestroUsuario, false, false, 30)%>
        <%=MyUtil.ObjInput("Lada1", "Lada1", strLada1, false, false, 320, 70, strLada1, false, false, 8)%>
        <%=MyUtil.ObjInput("Teléfono1", "Telefono1", strTelefono1, false, false, 380, 70, strTelefono1, false, false, 20)%>
        <%=MyUtil.ObjInput("Lada2", "Lada2", strLada2, false, false, 520, 70, strLada2, false, false, 8)%>
        <%=MyUtil.ObjInput("Teléfono2", "Telefono2", strTelefono2, false, false, 580, 70, strTelefono2, false, false, 20)%>
        <%=MyUtil.DoBlock("Datos Generales del Expediente", -50, 0)%>

        <%=MyUtil.ObjComboC("Estatus", "clEstatusSup", rs.getString("dsEstatusSup"), true, true, 30, 160, "", "st_getEstatusSup", "fnValidaEstSup();", "", 20, true, true)%>
        <div id="Motivo" style="visibility: hidden">
            <%=MyUtil.ObjComboC("Motivo No Supervision", "clMotivoNoSupervision", rs.getString("dsMotivoNoSupervision"), true, true, 200, 160, "", "st_getMotivoNoSup", "", "", 20, false, false)%>
        </div>
        <div class='FTable' style='position:absolute; z-index:299; left:640px; top:160px;'>
            <input type='hidden' name='clAreaSupervisada' value=<%=rs.getString("clAreaSupervisada")%>
                   <p class='<%=rs.getString("Estilo")%>'><strong>Área a Supervisar: <br></strong><%=rs.getString("dsAreaSupervisada")%>
        </div>

        <%=MyUtil.ObjInput("No. de Superv.", "NumSupervisionVTR", strNumSupervision, false, false, 30, 200, "", false, false, 15)%>
        <%=MyUtil.ObjInput("Fecha de Supervisión", "FechaVTR", rs.getString("Fecha"), false, false, 130, 200, "", false, false, 22)%>
        <%=MyUtil.ObjInput("Fecha de Asignación", "FechaAsignacion", rs.getString("FechaAsignacion"), false, false, 280, 200, rs.getString("FechaAsignacion"), false, false, 22)%>
        <%=MyUtil.ObjInput("Usuario que Supervisó", "NomUsrSup", rs.getString("NomUsrSup"), false, false, 420, 200, session.getAttribute("NombreUsuario").toString(), false, false, 50)%>

        <%  StringBuffer StrSQLPregs = new StringBuffer();
            int iPreg = 1;
            int NumPregS = 1;
            int iY = 240;
            int iY2 = 0;
            int zIndex = 100;

            ResultSet rsPregs = null;

            if (strclEstatusSup.compareToIgnoreCase("0") == 0) {
                // no tiene supervisión o se encuentra pendiente
                StrSQLPregs.append(" st_getPreguntasxSupervisar ").append(rs.getString("clSubservicio")).append(",").append(strNumSupervision);
                rsPregs = UtileriasBDF.rsSQLNP(StrSQLPregs.toString());

                while (rsPregs.next()) {
                    StrTipo = rsPregs.getString("Tipo");
                    if (StrTipo.equalsIgnoreCase("N")) {
        %>
        <input type='hidden' name='clPS<%=iPreg%>' value='<%=rsPregs.getString("clPreguntaSup")%>'>
        <%=MyUtil.ObjComboC(rsPregs.getString("dsPreguntaSup"), "clCal" + iPreg, "", true, true, 30, iY, "", "st_getCalificaSup", "", "", 30, true, true)%>
        <%
                    iY += 40;
                }
                iPreg += 1;     //***
                zIndex = zIndex + 1;   //***
            }
        %>

        <%=MyUtil.ObjTextArea("Observaciones del Afiliado", "ObsAfiliado", rs.getString("ObsAfiliado"), "100", "3", true, true, 30, iY, "", false, false)%>
        <% iY += 60;%>
        <%=MyUtil.ObjTextArea("Observaciones del Supervisor", "ObsSuperv", rs.getString("ObsSuperv"), "100", "3", true, true, 30, iY, "", false, false)%>
        <% iY += 60;%>
        <%=MyUtil.ObjTextArea("Sugerencias", "Sugerencias", rs.getString("Sugerencias"), "100", "3", true, true, 30, iY, "", false, false)%>
        <% iY += 60;%>
        <%=MyUtil.ObjComboC("Usted recomendaría el servicio de asistencia?", "Recomendar", "", true, true, 30, iY, "", "st_getSiNo "+strclUsrAppSup, "fnValidaNoRecomienda();", "", 20, false, false)%>
        <%=MyUtil.ObjComboC("En una escala del 0 al 10 ¿Qué tan recomendable </BR>le parece nuestro servicio de asistencia?</BR>", "clCalificaServ", rs.getString("dsCalificaServ"), true, true, 530, 560, "", "st_getCalificaServ", "fnValidaNoRecomienda();", "", 20, true, true)%>

        <div id="MotivoNR" style="visibility: hidden">
            <%=MyUtil.ObjComboC("Motivo No Recomendaría", "clMotivoNoRecomienda", rs.getString("dsMotivoNoRecomienda"), true, true, 320, iY, "", "st_getMotivoNoRec", "", "", 20, false, false)%>
        </div>

        <%  iY += 45;%>
        <%=MyUtil.ObjTextArea("¿por qué?", "PorqueRecomendar", "", "100", "3", true, true, 30, iY, "", false, false)%>
        <%  iY += 60;%>

        <%
            rsPregs.beforeFirst();
            while (rsPregs.next()) {
                StrTipo = rsPregs.getString("Tipo");
                if (StrTipo.equalsIgnoreCase("S")) {
        %>
        <INPUT type='hidden' name='clPE<%=NumPregS%>' value='<%=rsPregs.getString("clPreguntaSup")%>'>
        <%=MyUtil.ObjComboC(rsPregs.getString("dsPreguntaSup"), "clCalE" + NumPregS, "", true, true, 30, iY, "", "st_getPreguntasSup 'S'", "", "", 30, true, true)%>
        <%
                    NumPregS += 1;
                    iY += 40;
                }
                iPreg += 1;
                zIndex = zIndex + 1;
            }

            rsPregs.beforeFirst();
            int numPregEs = 1;

            while (rsPregs.next()) {
                StrTipo = rsPregs.getString("Tipo");

                if (StrTipo.equalsIgnoreCase("E1")) {%>
        <INPUT type='hidden' name='clPES<%=numPregEs%>' value='<%=rsPregs.getString("clPreguntaSup")%>'>
        <%=MyUtil.ObjComboC(rsPregs.getString("dsPreguntaSup"), "clCalES" + numPregEs, "", true, true, 30, iY, "", "st_getPreguntasSup 'E1'", "", "", 30, false, false)%>
        <%
                    numPregEs += 1;
                    iY += 40;
                }
                zIndex = zIndex + 1;
            }
        } else { //preguntas expedientes ya sueprvisados
            StrSQLPregs.append(" st_getPreguntasSupervisadas ").append(strclSupervision);

            rsPregs = UtileriasBDF.rsSQLNP(StrSQLPregs.toString());

            while (rsPregs.next()) {
                StrTipo = rsPregs.getString("Tipo");
                if (StrTipo.equalsIgnoreCase("N")) {%>
        <input type='hidden' name='clPS<%=iPreg%>' value='<%=rsPregs.getString("clPreguntaSup")%>'>

        <%=MyUtil.ObjComboC(rsPregs.getString("dsPreguntaSup"), "clCal" + iPreg, rs.getString("dsCal" + iPreg), true, true, 30, iY, "", "st_getPreguntasSup 'N'", "", "", 30, true, true)%>
        <%
                    iY += 40;
                }
                iPreg += 1;
                zIndex = zIndex + 1;
            }

            iY += 30;
        %>
        <%=MyUtil.ObjTextArea("Observaciones del Afiliado", "ObsAfiliado", rs.getString("ObsAfiliado"), "100", "3", true, true, 30, iY, "", false, false)%>
        <% iY += 60;%>
        <%=MyUtil.ObjTextArea("Observaciones del Supervisor", "ObsSuperv", rs.getString("ObsSuperv"), "100", "3", true, true, 30, iY, "", false, false)%>
        <% iY += 60;%>
        <%=MyUtil.ObjTextArea("Sugerencias", "Sugerencias", rs.getString("Sugerencias"), "100", "3", true, true, 30, iY, "", false, false)%>
        <% iY += 60;%>
        <%=MyUtil.ObjComboC("Usted recomendaría el servicio de asistencia?", "Recomendar", rs.getString("Recomendar"), true, true, 30, iY, "", "st_getSiNo "+strclUsrAppSup, "fnValidaNoRecomienda();", "", 20, false, false)%>
        <%=MyUtil.ObjComboC("En una escala del 0 al 10 ¿Qué tan recomendable </BR> le parece nuestro servicio de asistencia?</BR>", "clCalificaServ",  rs.getString("dsCalificaServ"), true, true, 580, 600, "", "st_getCalificaServ", "fnValidaNoRecomienda();", "", 20, false, false)%>
        
        <div id="MotivoNR" style="visibility: hidden">
            <%=MyUtil.ObjComboC("Motivo No Recomendaría", "clMotivoNoRecomienda", rs.getString("dsMotivoNoRecomienda"), true, true, 350, iY, "", "st_getMotivoNoRec", "", "", 20, false, false)%>
        </div>
        <%  iY += 45;%>
        <%=MyUtil.ObjTextArea("¿por qué?", "PorqueRecomendar", rs.getString("PorqueRecomendar"), "100", "3", true, true, 30, iY, "", false, false)%>
        <%  iY += 60;%>

        <%
            rsPregs.beforeFirst();
            while (rsPregs.next()) {
                StrTipo = rsPregs.getString("Tipo");
                if (StrTipo.equalsIgnoreCase("S")) {
        %>
        <INPUT type='hidden' name='clPE<%=NumPregS%>' value='<%=rsPregs.getString("clPreguntaSup")%>'>
        <%=MyUtil.ObjComboC(rsPregs.getString("dsPreguntaSup"), "clCalE" + NumPregS, rs.getString("dsCalE" + NumPregS), true, true, 30, iY, "", "st_getPreguntasSup 'S'", "", "", 30, true, true)%>
        <%
                    NumPregS += 1;
                    iY += 40;
                }
                iPreg += 1;
                zIndex = zIndex + 1;
            }

            rsPregs.beforeFirst();
            int numPregES = 1;

            while (rsPregs.next()) {
                StrTipo = rsPregs.getString("Tipo");

                if (StrTipo.equalsIgnoreCase("E1")) {%>
        <INPUT type='HIDDEN' name='clPES<%=numPregES%>' value='<%=rsPregs.getString("clPreguntaSup")%>'>
        <%=MyUtil.ObjComboC(rsPregs.getString("dsPreguntaSup"), "clCalES" + numPregES, rs.getString("dsCalES" + numPregES), true, true, 30, iY, "", "st_getPreguntasSup 'E1'", "", "", 30, false, false)%>
        <%
                        numPregES += 1;
                        iY += 40;
                    }
                    zIndex = zIndex + 1;
                }
            }

            if (iY2 == 1) {
                iY -= 430;
            }
        %>

        <%=MyUtil.ObjChkBox("Inconforme", "Inconforme", rs.getString("Inconforme"), true, true, 450, 240, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjChkBox("Crítico", "Critico", rs.getString("Critico"), true, true, 580, 240, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjChkBox("Mala Venta", "ventaMala", rs.getString("ventaMala"), true, true, 690, 240, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjInput("Calificación Numerica", "CalifNumerico", rs.getString("CalifNumerico"), false, false, 450, 300, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Calificación", "CalifLetraVTR", strdsCalifSup, false, false, 610, 300, "", false, false, 25)%>

        <%=MyUtil.ObjInput("Cal. Evaluación", "CalifEvaluacion", rs.getString("CalifNumericoE"), false, false, 450, 350, "", false, false, 5)%>
        <%=MyUtil.ObjInput("Cal. CAT", "CalifCAT", rs.getString("CalifNumECAT"), false, false, 580, 350, "", false, false, 5)%>
        <%=MyUtil.ObjInput("Cal. Proveedor", "CalifPROV", rs.getString("CalifNumEPROV"), false, false, 690, 350, "", false, false, 5)%>

        <%=MyUtil.DoBlock("Datos de la Supervisión", 100, 0)%>

        <%
            rsPregs.close();
            rsPregs = null;
            StrSQLPregs = null;

            strclEstatusSup = null;
            strNuestroUsuario = null;
            strLada1 = null;
            strTelefono1 = null;
            strLada2 = null;
            strTelefono2 = null;

        } else {%>
        <script>
            alert('No existe el expediente que desea supervisar');
            window.close();
        </script>
        <%
                StrclExpediente = null;
                strclUsr = null;
                strclSupervision = null;
                strNumSupervision = null;
                StrNombreUsuario = null;
                StrTipo = null;
                StrclPaginaWeb = null;
                return;
            }%>
        <%=MyUtil.GeneraScripts()%>

        <%
            rs.close();
            rs = null;

            StrclExpediente = null;
            strclUsr = null;
            strclSupervision = null;
            strNumSupervision = null;
            StrNombreUsuario = null;
            StrTipo = null;
            StrclPaginaWeb = null;
        %>
        <div class='FTable' style='position:absolute; z-index:30; left:410px; top:120px;'>
            <p class='FTable' id='ClaveMskUsr'></p>
        </div>
        <script>
            window.focus();

            function fnValidaEstSup() {

                if (document.all.clEstatusSup.value == 3 || document.all.clEstatusSup.value == 6) {

                    if (document.getElementById("clCal1C")) {
                        document.all.clCal1C.value = '6';
                        document.all.clCal1C.disabled = true;
                    }
                    if (document.getElementById("clCal2C")) {
                        document.all.clCal2C.value = '6';
                        document.all.clCal2C.disabled = true;
                    }
                    if (document.getElementById("clCal3C")) {
                        document.all.clCal3C.value = '6';
                        document.all.clCal3C.disabled = true;
                    }
                    if (document.getElementById("clCal4C")) {
                        document.all.clCal4C.value = '6';
                        document.all.clCal4C.disabled = true;
                    }
                    /* GRUPO 2*/
                    if (document.getElementById("clCalE1C")) {
                        document.all.clCalE1C.disabled = true;
                    }
                    if (document.getElementById("clCalE2C")) {
                        document.all.clCalE2C.disabled = true;
                    }
                    if (document.getElementById("clCalE3C")) {
                        document.all.clCalE3C.disabled = true;
                    }
                    if (document.getElementById("clCalE4C")) {
                        document.all.clCalE4C.disabled = true;
                    }
                    if (document.getElementById("clCalE5C")) {
                        document.all.clCalE5C.disabled = true;
                    }
                    if (document.getElementById("clCalE6C")) {
                        document.all.clCalE6C.disabled = true;
                    }

                } else {
                    if (document.getElementById("clCal1C")) {
                        document.all.clCal1C.value = '';
                        document.all.clCal1C.disabled = false;
                    }
                    if (document.getElementById("clCal2C")) {
                        document.all.clCal2C.value = '';
                        document.all.clCal2C.disabled = false;
                    }
                    if (document.getElementById("clCal3C")) {
                        document.all.clCal3C.value = '';
                        document.all.clCal3C.disabled = false;
                    }
                    if (document.getElementById("clCal4C")) {
                        document.all.clCal4C.value = '';
                        document.all.clCal4C.disabled = false;
                    }
                    /* GRUPO 2*/
                    if (document.getElementById("clCalE1C")) {
                        document.all.clCalE1C.value = '';
                        document.all.clCalE1C.disabled = false;
                    }
                    if (document.getElementById("clCalE2C")) {
                        document.all.clCalE2C.value = '';
                        document.all.clCalE2C.disabled = false;
                    }
                    if (document.getElementById("clCalE3C")) {
                        document.all.clCalE3C.value = '';
                        document.all.clCalE3C.disabled = false;
                    }
                    if (document.getElementById("clCalE4C")) {
                        document.all.clCalE4C.value = '';
                        document.all.clCalE4C.disabled = false;
                    }
                    if (document.getElementById("clCalE5C")) {
                        document.all.clCalE5C.value = '';
                        document.all.clCalE5C.disabled = false;
                    }
                    if (document.getElementById("clCalE6C")) {
                        document.all.clCalE6C.value = '';
                        document.all.clCalE6C.disabled = false;
                    }
                }

                fnValidaNoRecomienda();

            }

            function fnValidaNoRecomienda() {
                
                if (document.all.clEstatusSup.value == '3') {
                    document.getElementById('Motivo').style.visibility = 'visible';

                } else {
                    document.getElementById('Motivo').style.visibility = 'hidden';
                }

                if (document.all.Recomendar.value == '0' || document.all.clCalificaServ.value == '1' || document.all.clCalificaServ.value == '2'|| document.all.clCalificaServ.value == '3' || document.all.clCalificaServ.value == '4'
                                                         || document.all.clCalificaServ.value == '5'|| document.all.clCalificaServ.value == '6'|| document.all.clCalificaServ.value == '7'|| document.all.clCalificaServ.value == '8' || document.all.clCalificaServ.value == '0') 
                {
                    document.getElementById('MotivoNR').style.visibility = 'visible';

                } else {
                    document.getElementById('MotivoNR').style.visibility = 'hidden';
                }
                
            }

            function fnAntesGuardar() {
                
                if (document.all.clEstatusSup.value == '1' && document.all.Recomendar.value == '') {
                    if (document.all.clMotivoNoSupervision.value == '') {
                        msgVal = msgVal + "Usted recomendaría el servicio de asistencia?."

                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    }
                }

                if (document.all.Recomendar.value == '0') {
                    if (document.all.clMotivoNoRecomienda.value == '') {
                        msgVal = msgVal + "Motivo no recomendaría."

                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    }
                } else {
                    document.all.clMotivoNoRecomienda.value == '';
                }


                if (document.all.clEstatusSup.value == '3') {
                    if (document.all.clMotivoNoSupervision.value == '') {
                        msgVal = msgVal + "Motivo no supervision."

                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    }
                } else {
                    document.all.clMotivoNoSupervision.value = '';
                }

            }
        </script>
    </body>
</html>