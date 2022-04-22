<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Descuento de Medicamentos</title>
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
            String StrclPaginaWeb = "6071";
            String StrFecha = "";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) { %>
                Fuera de Horario
                <%
                 StrclUsrApp = null;
                 StrclExpediente = null;
                 StrclPaginaWeb = null;
                 StrFecha = null;
                 return;
             }

             StringBuffer StrSql1 = new StringBuffer();

             StrSql1.append(" Select TieneAsistencia From Expediente Where clExpediente = ").append(StrclExpediente);
             ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql1.toString());
             StrSql1.delete(0, StrSql1.length());

             if (rs2.next()) {
             } else { %> 
                El expediente no existe 
                <%
                rs2.close();
                rs2 = null;
                StrclUsrApp = null;
                StrclExpediente = null;
                StrclPaginaWeb = null;
                StrFecha = null;
                return;
            }

            ResultSet rs3 = UtileriasBDF.rsSQLNP(" Select convert(varchar(20),getdate(),120) FechaApertura");
                if (rs3.next()) {
                    StrFecha = rs3.getString("FechaApertura");
                }

            StrSql1.append(" st_AsistDescMedicamentos ").append(StrclExpediente);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql1.toString());
            StrSql1.delete(0, StrSql1.length());
        %>
            <script>fnOpenLinks()</script>
        <%
            MyUtil.InicializaParametrosC(6071, Integer.parseInt(StrclUsrApp));
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>

            <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "", "")%>
            <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DescuentoMedicamento.jsp?'>"%>
            <% if (rs.next()) { %>
                <script>
                    document.all.btnAlta.disabled = true;
                </script>
                <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
                <%=MyUtil.ObjInput("Nombre del Paciente", "NombrePaciente", rs.getString("NombrePaciente"), true, true, 30, 70, "", false, false, 65)%>
                <%=MyUtil.ObjComboC("Ubicación Actual del Paciente", "clUbicacionActual", rs.getString("dsUbicacion"), true, true, 400, 70, "", "Select clUbicacion, dsUbicacion From cUbicacion Order by dsUbicacion", "", "", 10, false, false)%>
                <%=MyUtil.ObjComboMem("País de su Ubicación Actual", "clPais", rs.getString("dsPais"), rs.getString("clPais"), cbPais.GeneraHTML(20, rs.getString("dsPais")), true, true, 30, 120, "10", "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
                <%=MyUtil.ObjComboMemDiv("Ciudad de su Ubicación Actual", "CodEnt", rs.getString("dsEntFed"), rs.getString("CodEnt"), cbEntidad.GeneraHTML(40, rs.getString("dsEntFed"), Integer.parseInt(rs.getString("clPais"))), true, true, 400, 120, "", "", "", 20, false, false, "CodEntDiv")%>
                <%=MyUtil.ObjInput("Calle y número de su Ubicación Actual", "CalleNum", rs.getString("CalleNum"), true, true, 30, 170, "", false, false, 65)%>
                <%=MyUtil.ObjInput("Médico Tratante", "MedicoTratante", rs.getString("MedicoTratante"), true, true, 400, 170, "", false, false, 55)%>
                <%=MyUtil.ObjTextArea("Detalle de Medicamentos y Cantidades", "MedicamentoCantidad", rs.getString("MedicamentoCantidad"), "74", "4", true, true, 30, 220, "", false, false)%>
                <%=MyUtil.ObjInput("Fecha Receta", "FechaReceta", rs.getString("FechaReceta"), true, true, 440, 220, "", true, true, 22, "if(this.readOnly==false){fnValMask(this,document.all.FechaIngresoMsk.value,this.name)}")%>
                <%=MyUtil.ObjInput("Gastos Estimados", "GastosEstimados", rs.getString("GastosEstimados"), true, true, 30, 300, "", true, true, 25, "EsNumerico(document.all.GastosEstimados)")%>
                <%=MyUtil.ObjInput("Costo Final", "CostoFinal", rs.getString("CostoFinal"), true, true, 220, 300, "", true, true, 15, "EsNumerico(document.all.CostoFinal)")%>
                <%=MyUtil.ObjInput("Fecha Apertura", "FechaApertura", rs.getString("FechaApertura"), false, false, 350, 300, StrFecha, true, true, 22)%>
                <%=MyUtil.ObjInput("Fecha Registro", "FechaRegistro", rs.getString("FechaRegistro"), false, false, 498, 300, "", false, true, 22)%>
                <%=MyUtil.DoBlock("Descuento de Medicamentos", 25, 0)%>
            <% } else { %>
                <script>
                    document.all.btnCambio.disabled = true;
                </script>
                <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
                <%=MyUtil.ObjInput("Nombre del Paciente", "NombrePaciente", "", true, true, 30, 70, "", false, false, 65)%>
                <%=MyUtil.ObjComboC("Ubicación Actual del Paciente", "clUbicacionActual", "", true, true, 400, 70, "", "Select clUbicacion, dsUbicacion From cUbicacion Order by dsUbicacion", "", "", 10, false, false)%>
                <%=MyUtil.ObjComboMem("País de su Ubicación Actual", "clPais", "", "", cbPais.GeneraHTML(20, ""), true, true, 30, 120, "10", "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
                <%=MyUtil.ObjComboMemDiv("Ciudad de su Ubicación Actual", "CodEnt", "", "", cbEntidad.GeneraHTML(40, "", Integer.parseInt("10")), true, true, 400, 120, "", "", "", 20, false, false, "CodEntDiv")%>
                <%=MyUtil.ObjInput("Calle y número de su Ubicación Actual", "CalleNum", "", true, true, 30, 170, "", false, false, 65)%>
                <%=MyUtil.ObjInput("Médico Tratante", "MedicoTratante", "", true, true, 400, 170, "", false, false, 55)%>
                <%=MyUtil.ObjTextArea("Detalle de Medicamentos y Cantidades", "MedicamentoCantidad", "", "74", "4", true, true, 30, 220, "", false, false)%>
                <%=MyUtil.ObjInput("Fecha Receta", "FechaReceta", "", true, true, 440, 220, "", true, true, 22, "if(this.readOnly==false){fnValMask(this,document.all.FechaIngresoMsk.value,this.name)}")%>
                <%=MyUtil.ObjInput("Gastos Estimados", "GastosEstimados", "", true, true, 30, 300, "", true, true, 25, "EsNumerico(document.all.GastosEstimados)")%>
                <%=MyUtil.ObjInput("Costo Final", "CostoFinal", "", true, true, 220, 300, "", true, true, 15, "EsNumerico(document.all.CostoFinal)")%>
                <%=MyUtil.ObjInput("Fecha Apertura", "FechaApertura", "", false, false, 350, 300, StrFecha, true, true, 22)%>
                <%=MyUtil.ObjInput("Fecha Registro", "FechaRegistroVTR", "", false, false, 498, 300, "", false, true, 22)%>
                <%=MyUtil.DoBlock("Descuento de Medicamentos", 25, 0)%>
            <% } %>
            <%=MyUtil.GeneraScripts()%>
            <%
            rs.close();
            rs2.close();
            rs3.close();

            rs = null;
            rs2 = null;
            rs3 = null;
            StrclUsrApp = null;
            StrclExpediente = null;
            StrclPaginaWeb = null;
            StrFecha = null;
            StrSql1 = null;
            %>
            <input name='FechaIngresoMsk' id='FechaIngresoMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
            <script type="text/javascript">
                function fnLlenaEntidadAjaxFn(cod) {
                    IDCombo = 'CodEnt';
                    Label = 'Ciudad de su Ubicación Actual';
                    IdDiv = 'CodEntDiv';
                    FnCombo = '';
                    URL = "../../servlet/Combos.LlenaEntidadAjax?";
                    Cadena = "Opcion=" + cod + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                    fnLLenaInput(URL, Cadena, IdDiv);
                }
            </script>
    </body>
</html>

