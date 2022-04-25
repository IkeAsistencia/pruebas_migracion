<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>Coordinaciones Médicas</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>
        <%
            String StrclUsrApp = "0";
            String StrclExpediente = "0";
            String StrclPaginaWeb = "6072";
            String StrFecha = "";
            String StrdsSubServicio = "";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }
            
            if (session.getAttribute("dsSubServicio") != null) {
                StrdsSubServicio = session.getAttribute("dsSubServicio").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) { %>
                Fuera de Horario
                <%
                StrclUsrApp = null;
                StrclExpediente = null;
                StrclPaginaWeb = null;
                StrFecha = null;
                StrdsSubServicio = null;
                return;
            }

            StringBuffer StrSql1 = new StringBuffer();

            StrSql1.append(" Select TieneAsistencia From Expediente Where clExpediente = ").append(StrclExpediente);
            ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql1.toString());
            StrSql1.delete(0, StrSql1.length());

            if (rs2.next()) {
            } else {
        %><%="El expediente no existe"%><%
                rs2.close();
                rs2 = null;
                StrclExpediente = null;
                StrclPaginaWeb = null;
                StrFecha = null;
                StrclUsrApp = null;

                return;
            }

            ResultSet rs3 = UtileriasBDF.rsSQLNP("Select convert(varchar(20),getdate(),120) FechaApertura ");
            if (rs3.next()) {
                StrFecha = rs3.getString("FechaApertura");
            }

            StrSql1.append(" st_AsistCoordMedicas ").append(StrclExpediente);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql1.toString());
            StrSql1.delete(0, StrSql1.length());
        %>
        <script>fnOpenLinks()</script>
        <%
            MyUtil.InicializaParametrosC(6072, Integer.parseInt(StrclUsrApp));
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>

        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "", "")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="CoordinacionesMedicas.jsp?'>"%>
        <% if (rs.next()) { %>
            <script>
                document.all.btnAlta.disabled = true;
            </script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjComboC("Tipo de Información", "clcondicionado", rs.getString("dsCondicionado"), true, true, 30, 70, "", "Select clTipoInformacion, dsTipoInformacion From cTipoInformacion Order by dsTipoInformacion", "", "", 100, false, false)%>
            <%=MyUtil.ObjInput("Fecha Apertura", "FechaApertura", rs.getString("FechaApertura"), false, false, 210, 70, StrFecha, true, true, 25)%>
            <%=MyUtil.ObjInput("Fecha Registro", "FechaRegistro", rs.getString("FechaRegistro"), false, false, 380, 70, "", false, false, 25)%>
            <%=MyUtil.ObjTextArea("Descripción de Solicitud", "DescSolicitud", rs.getString("DescSolicitud"), "100", "4", true, true, 30, 110, "", false, false)%>
            <%=MyUtil.ObjInput("Teléfono de Contacto 1", "TelContacto1", rs.getString("TelContacto1"), true, true, 30, 190, "", false, false, 20)%>
            <%=MyUtil.ObjInput("Teléfono de Contacto 2", "TelContacto2", rs.getString("TelContacto2"), true, true, 200, 190, "", false, false, 20)%>
            <%=MyUtil.ObjInput("Email", "Email", "", true, true, 380, 190, rs.getString("Email"), false, false, 33)%>                                   
            <%=MyUtil.ObjComboMem("País", "clPais", rs.getString("dsPais"), rs.getString("clPais"), cbPais.GeneraHTML(20, rs.getString("dsPais")), true, true, 30, 230, "10", "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>                              
            <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", rs.getString("dsEntFed"), rs.getString("CodEnt"), cbEntidad.GeneraHTML(40, rs.getString("dsEntFed"), Integer.parseInt(rs.getString("clPais"))), true, true, 310, 230, "", "fnLLenaComboMDAjax(this.value);", "", 20, false, false, "CodEntDiv")%>                              
            <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", rs.getString("dsMunDel"), rs.getString("CodMD"), cbEntidad.GeneraHTMLMD(40, rs.getString("CodEnt"), rs.getString("dsMunDel")), false, false, 30, 270, rs.getString("CodEnt"), "", "", 20, false, false, "LocalidadDiv")%>
            <%=MyUtil.ObjInput("Domicilio", "domicilio", rs.getString("domicilio"), true, true, 380, 270, "", false, false, 55)%>
            <%=MyUtil.ObjInput("Profesional", "profesional", rs.getString("profesional"), true, true, 30, 310, "", false, false, 30)%>
            <%=MyUtil.ObjInput("Fecha Turno", "Fechaturno", rs.getString("Fechaturno"), true, true, 230, 310, "", true, true, 25)%>
            <%=MyUtil.ObjInput("Hora Turno", "horaturno", rs.getString("horaturno"), true, true, 400, 310, "", false, false, 20)%>
            <%=MyUtil.ObjInput("Establecimiento", "establecimiento", rs.getString("establecimiento"), true, true, 550, 310, "", false, false, 20)%>
            <%=MyUtil.DoBlock("Detalle de " + StrdsSubServicio, -40, 0)%>
        <% } else { %>
            <script>
                document.all.btnCambio.disabled = true;
            </script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjComboC("Tipo de Información", "clcondicionado", "", true, true, 30, 70, "", "Select clTipoInformacion, dsTipoInformacion From cTipoInformacion Order by dsTipoInformacion", "", "", 100, false, false)%>
            <%=MyUtil.ObjInput("Fecha Apertura", "FechaApertura", "", false, false, 210, 70, StrFecha, true, true, 25)%>
            <%=MyUtil.ObjInput("Fecha Registro", "FechaRegistroVTR", "", false, false, 380, 70, "", false, true, 25)%>
            <%=MyUtil.ObjTextArea("Descripción de Solicitud", "DescSolicitud", "", "100", "4", true, true, 30, 110, "", false, false)%>
            <%=MyUtil.ObjInput("Teléfono de Contacto 1", "TelContacto1", "", true, true, 30, 190, "", false, false, 20)%>
            <%=MyUtil.ObjInput("Teléfono de Contacto 2", "TelContacto2", "", true, true, 200, 190, "", false, false, 20)%>
            <%=MyUtil.ObjInput("Email", "Email", "", true, true, 380, 190, "", false, false, 33)%>                              
            <%=MyUtil.ObjComboMem("País", "clPais", "", "", cbPais.GeneraHTML(20, ""), true, true, 30, 230, "10", "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
            <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", "", "", cbEntidad.GeneraHTML(40, "", Integer.parseInt("10")), true, true, 310, 230, "", "fnLLenaComboMDAjax(this.value);", "", 20, false, false, "CodEntDiv")%>
            <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", "", "", cbEntidad.GeneraHTMLMD(40, "", ""), false, false, 30, 270, "", "", "", 20, false, false, "LocalidadDiv")%>                             
            <%=MyUtil.ObjInput("Domicilio", "domicilio", "", true, true, 380, 270, "", false, false, 55)%>
            <%=MyUtil.ObjInput("Profesional", "profesional", "", true, true, 30, 310, "", false, false, 30)%>
            <%=MyUtil.ObjInput("Fecha Turno", "Fechaturno", "", true, true, 230, 310, "", true, true, 25)%>
            <%=MyUtil.ObjInput("Hora Turno", "horaturno", "", true, true, 400, 310, "", false, false, 20)%>
            <%=MyUtil.ObjInput("Establecimiento", "establecimiento", "", true, true, 550, 310, "", false, false, 20)%>
            <%=MyUtil.DoBlock("Detalle de " + StrdsSubServicio, -40, 0)%>
        <% } %>

        <%=MyUtil.GeneraScripts()%>   

        <%
            rs.close();
            rs2.close();
            rs3.close();

            rs = null;
            rs2 = null;
            rs3 = null;

            StrclExpediente = null;
            StrSql1 = null;
            StrclPaginaWeb = null;
            StrFecha = null;
            StrclUsrApp = null;
            StrdsSubServicio = null;
        %>

        <input name='FechaIngresoMsk' id='FechaIngresoMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <script type="text/javascript">

            function fnLlenaEntidadAjaxFn(cod) {
                IDCombo = 'CodEnt';
                Label = 'Ciudad de su Ubicación Actual';
                IdDiv = 'CodEntDiv';
                FnCombo = 'fnLLenaComboMDAjax(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion=" + cod + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjax(value) {
                IDCombo = 'CodMD';
                Label = 'Localidad';
                IdDiv = 'LocalidadDiv';
                FnCombo = '';
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion=" + value + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }
        </script>
    </body>
</html>
