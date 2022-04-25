<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF" %>

<html>
    <head>
        <title>Regresa Clave VIP</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        
        <%
        String strclCuenta = "0";

        if (request.getParameter("clCuenta") != null) {
            strclCuenta = request.getParameter("clCuenta").toString();
        }

        StringBuffer strSql = new StringBuffer();
        strSql.append("st_RegresaClaveVIP '").append(strclCuenta).append("'");
        ResultSet rs = UtileriasBDF.rsSQLNP(strSql.toString());

        if (rs.next()) {
        %>
        <script>top.opener.fnActualizaDatosClave('<%=rs.getString("Clave")%>','<%=rs.getString("Consecutivo")%>');window.close();</script>
        <% } else {%>
        <script>top.opener.fnActualizaDatosClave('0','0');window.close();</script>
        <% }
        strSql.delete(0, strSql.length());

        rs.close();
        rs = null;
        %>
    </body>
</html>
