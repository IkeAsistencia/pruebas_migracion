<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>Datos de Colonia</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js' ></script>

        <%
        String StrdsColonia = "0";

        if (request.getParameter("dsColonia") != null) {
            StrdsColonia = request.getParameter("dsColonia").toString();
        }

        StringBuffer StrSql = new StringBuffer();
        StrSql.append("Select CP from cColonia where dsColonia= '").append(StrdsColonia).append("'");

        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0, StrSql.length());

        if (rs.next()) {

        %>
        <script>  
            top.opener.fnInfoColonia('<%=rs.getString("CP").toString()%>')
            window.close();
        </script>

        <% }

        rs.close();
        rs = null;
        StrdsColonia = null;
        %>

    </body>
</html>
