<%-- 
    Document   : CSCobertura
    Created on : 8/10/2010, 08:48:25 AM
    Author     : rfernandez
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Cobertura Concierge</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <script src='Util.js'></script>
        <table width='900px' class='cssTitDet'><tr><td><font style="font-size: 10pt; color: white">Cobertura de Bin MasterCard</font></td></tr></table>
        <table width='900px' Border=1 Class='vTable'></table>

        <%
                String StrclConcierge = "";

                if (request.getParameter("clConcierge") != null) {
                    StrclConcierge = request.getParameter("clConcierge").toString();
                }

                StringBuffer strSQL = new StringBuffer();
                strSQL.append("st_CSGetCobertura ").append(StrclConcierge);
                ResultSet rs = UtileriasBDF.rsSQLNP(strSQL.toString());

                strSQL.delete(0, strSQL.length());

                if (rs.next()) {
        %>

        <p>
            <%= rs.getString("Mensaje")%>

        </p>
        <%}%>
    </body>
</html>