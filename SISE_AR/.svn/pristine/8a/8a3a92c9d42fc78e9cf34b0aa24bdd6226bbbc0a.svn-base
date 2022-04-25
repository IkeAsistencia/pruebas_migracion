<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>Referencia Médicas</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <%
        String StrclExpediente = "0";
        String StrclUsrApp = "0";

        if (session.getAttribute("clUsrApp") != null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if (session.getAttribute("clExpediente") != null) {
            StrclExpediente = session.getAttribute("clExpediente").toString();
        }

        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
            StrclExpediente = null;
            StrclUsrApp = null;

            return;
        }

        StringBuffer StrSql = new StringBuffer();
        StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);

        ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0, StrSql.length());

        if (rs2.next()) {
        } else {
        %>El expediente no existe<%
            rs2.close();
            rs2 = null;

            StrclExpediente = null;
            StrclUsrApp = null;
            StrSql = null;

            return;
        }

        StrSql.append(" st_DetalleReferenciaM ").append(StrclExpediente);

        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0, StrSql.length());

        %> <script>fnOpenLinks()</script>
        <%
        String StrclPaginaWeb = "575";
        MyUtil.InicializaParametrosC(575, Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

        session.setAttribute("clPaginaWebP", StrclPaginaWeb);

        %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="ReferenciaMedica.jsp?"%>'>
        <%
        if (rs.next()) {

        %><script>document.all.btnAlta.disabled=true;</script>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjInput("Nombre del Paciente", "Paciente", rs.getString("Paciente"), true, true, 30, 80, "", true, true, 60)%>
        <%=MyUtil.ObjInput("Edad", "Edad", rs.getString("Edad"), true, true, 370, 80, "", false, false, 10, "fnRango(document.all.Edad,0,150)")%>
        <%=MyUtil.ObjComboC("Parentesco con N/U", "clParentesco", rs.getString("dsParentesco"), true, true, 450, 80, "", "Select clParentesco, dsParentesco From cParentesco ", "", "", 30, true, true)%>
        <%=MyUtil.DoBlock("Subservicio de Referencia Médica", -30, 0)%>

        <%=MyUtil.ObjInput("Padecimiento", "Padecimiento", rs.getString("Padecimiento"), true, true, 30, 170, "", true, true, 50)%>
        <%=MyUtil.ObjComboC("Servicio Referenciado", "clServicioMedico", rs.getString("dsServicioMedico"), true, true, 310, 170, "", "sp_GetServicioMedico", "", "", 30, true, true)%>
        <%=MyUtil.ObjTextArea("Antecedentes", "Antecedentes", rs.getString("Antecedentes"), "105", "4", true, true, 30, 210, "", false, false)%>
        <%=MyUtil.ObjTextArea("Tratamientos Previos", "TratamientosPrevios", rs.getString("TratamientosPrevios"), "105", "2", true, true, 30, 285, "", false, false)%>
        <%=MyUtil.ObjTextArea("Estudios Previos", "EstudiosPrevios", rs.getString("EstudiosPrevios"), "105", "2", true, true, 30, 335, "", false, false)%>
        <%=MyUtil.ObjTextArea("RecomendaMedico", "RecomendaMedico", rs.getString("RecomendaMedico"), "105", "4", true, true, 30, 385, "", false, false)%>
        <%=MyUtil.DoBlock("Datos de la Referencia", 110, 35)%>
        <%
        } else {
        %>
        <script>document.all.btnCambio.disabled=true;</script>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjInput("Nombre del Paciente", "Paciente", "", true, true, 30, 80, "", true, true, 60)%>
        <%=MyUtil.ObjInput("Edad", "Edad", "", true, true, 370, 80, "", false, false, 10, "fnRango(document.all.Edad,0,150)")%>
        <%=MyUtil.ObjComboC("Parentesco con N/U", "clParentesco", "", true, true, 450, 80, "", "Select clParentesco, dsParentesco From cParentesco ", "", "", 30, true, true)%>
        <%=MyUtil.DoBlock("Subservicio de Referencia Médica", -30, 0)%>

        <%=MyUtil.ObjInput("Padecimiento", "Padecimiento", "", true, true, 30, 170, "", true, true, 50)%>
        <%=MyUtil.ObjComboC("Servicio Referenciado", "clServicioMedico", "", true, true, 310, 170, "", "sp_GetServicioMedico", "", "", 30, true, true)%>
        <%=MyUtil.ObjTextArea("Antecedentes", "Antecedentes", "", "105", "4", true, true, 30, 210, "", false, false)%>
        <%=MyUtil.ObjTextArea("Tratamientos Previos", "TratamientosPrevios", "", "105", "2", true, true, 30, 285, "", false, false)%>
        <%=MyUtil.ObjTextArea("Estudios Previos", "EstudiosPrevios", "", "105", "2", true, true, 30, 335, "", false, false)%>
        <%=MyUtil.ObjTextArea("RecomendaMedico", "RecomendaMedico", "", "105", "4", true, true, 30, 385, "", false, false)%>
        <%=MyUtil.DoBlock("Datos de la referencia", 110, 35)%><%
        }

        %><%=MyUtil.GeneraScripts()%><%
        rs2.close();
        rs.close();
        rs2 = null;
        rs = null;

        StrclExpediente = null;
        StrclUsrApp = null;
        StrclPaginaWeb = null;

        StrSql = null;
        %>
        <script>
            document.all.Paciente.maxLength=50;
            document.all.Edad.maxLength=3;
            document.all.Padecimiento.maxLength=50;
            document.all.Antecedentes.maxLength=500;
            document.all.TratamientosPrevios.maxLength=200;
            document.all.EstudiosPrevios.maxLength=200;
            document.all.RecomendaMedico.maxLength=500;
        </script>
    </body>
</html>