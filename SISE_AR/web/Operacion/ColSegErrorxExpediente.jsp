<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Errores x Expediente</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js' ></script>

        <%
            StringBuffer StrSql = new StringBuffer();
            String StrclUsrApp = "0";
            String StrclPaginaWeb = "5100";
            String StrclExpediente = "0";
            String StrclErrorxExpediente = "0";
            String StrclTipoError = "";
            String StrclCuenta = "";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                    %>Fuera de Horario<%
                    StrSql = null;
                    StrclUsrApp = null;
                    StrclPaginaWeb = null;
                    StrclExpediente = null;
                    StrclErrorxExpediente = null;
                    StrclTipoError = null;
                    StrclCuenta = null;
                    return;
                }

                if (session.getAttribute("clExpediente") != null) {
                    StrclExpediente = session.getAttribute("clExpediente").toString();
                }

                if (request.getParameter("clErrorxExpediente") != null) {
                    StrclErrorxExpediente = request.getParameter("clErrorxExpediente");
                }

                if (session.getAttribute("clCuenta") != null) {
                    StrclCuenta = session.getAttribute("clCuenta").toString();
                }

                //System.out.println("StrclErrorxExpediente        "+StrclErrorxExpediente);
                StrSql.append(" st_ErrorxExpediente ").append(StrclErrorxExpediente);
                ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
                /*rs.rsSQL(StrSql.toString());*/
                StrSql.delete(0, StrSql.length());
        %>
        <script>fnOpenLinks()</script>
        <%
            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp));
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>ColSegErrorxExpediente.jsp?'>
        <%if (rs.next()) {
        %>
        <INPUT id='clErrorxExpediente' name='clErrorxExpediente' type='hidden' value='<%=StrclErrorxExpediente%>'>
        <%=MyUtil.ObjInput("Expediente", "ExpedienteVTR", StrclExpediente, false, false, 20, 80, StrclExpediente, false, false, 15)%>
        <%=MyUtil.ObjInput("Fecha Registro", "FechaRegistroVTR", rs.getString("FechaRegistra"), false, false, 150, 80, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Usuario que registra", "clUsrAppRegVTR", rs.getString("QuienRegistra"), false, false, 20, 120, "", false, false, 50)%>
        <%=MyUtil.ObjComboC("Tipo Error", "clTipoError", rs.getString("dsTipoError"), true, true, 20, 160, "", "st_TipoError " + StrclExpediente, "", "", 50, true, true)%>
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", rs.getString("Observaciones"), "50", "5", true, true, 20, 200, "", false, false)%>
        <%=MyUtil.ObjChkBox("¿Posible caso malo?", "EnviaCasoMalo", rs.getString("EnviaCasoMalo"), false, true, 300, 80, "0", "SI", "NO", "")%>
        <%
        } else {
        %>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='clUsrAppReg' name='clUsrAppReg' type='hidden' value='<%=StrclUsrApp%>'>
        <INPUT id='clErrorxExpediente' name='clErrorxExpediente' type='hidden' value=''>
        <%=MyUtil.ObjInput("Expediente", "ExpedienteVTR", StrclExpediente, false, false, 20, 80, StrclExpediente, false, false, 15)%>
        <%=MyUtil.ObjInput("Fecha Registro", "FechaRegistroVTR", "", false, false, 150, 80, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Usuario que registra", "clUsrAppRegVTR", "", false, false, 20, 120, "", false, false, 50)%>
        <%=MyUtil.ObjComboC("Tipo Error", "clTipoError", "", true, true, 20, 160, "", "st_TipoError " + StrclExpediente, "", "", 50, true, true)%>
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", "", "50", "5", true, true, 20, 200, "", false, false)%>
        <%=MyUtil.ObjChkBox("¿Posible caso malo?", "EnviaCasoMalo", "", false, true, 300, 80, "0", "SI", "NO", "")%>
        <%
                }%>

        <%=MyUtil.DoBlock("Error por Expediente", 0, 40)%>

        <%=MyUtil.GeneraScripts()%>
        <%
            rs.close();
            rs = null;
            StrSql = null;
            StrclUsrApp = null;
            StrclPaginaWeb = null;
            StrclExpediente = null;
            StrclErrorxExpediente = null;
            StrclTipoError = null;
            StrclCuenta = null;
        %>
    </body>
</html>