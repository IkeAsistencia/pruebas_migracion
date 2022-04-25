<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Cambia Titular</title> 
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <script src='../../Utilerias/Util.js' ></script>

        <%

            StringBuffer StrSql = new StringBuffer();
            String StrclUsrApp = "0";
            String StrProveedor = "0";
            String StrclExpediente = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }
            if (request.getParameter("clProveedor") != null) {
                StrProveedor = request.getParameter("clProveedor").toString().trim();
            }
            if (StrProveedor != "0") {
                StrSql.append(" sp_CambiaTitular ").append(StrclUsrApp).append(",").append(StrclExpediente).append(",").append(StrProveedor);
                UtileriasBDF.ejecutaSQLNP(StrSql.toString());
                StrSql.delete(0, StrSql.length());
        %>
        <script>
            //window.opener.fnValidaResponse(1, '<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>../Utilerias/Lista.jsp?P=187&Apartado=S');
            window.opener.location.reload();
            window.close();
                    </script>
        <% return;
            }
        %>
    </body>
</html>

