<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Historial</title> 
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>

        <%
            String StrclConcierge = "0";
            if (request.getParameter("clConcierge").equalsIgnoreCase("")) {
                StrclConcierge = null;
            }
            if (StrclConcierge != null) {
                StrclConcierge = request.getParameter("clConcierge").toString();
            } else {
                if (session.getAttribute("clConcierge") != null) {
                    StrclConcierge = session.getAttribute("clConcierge").toString();
                }
            }
        %>

        <%  StringBuffer StrSql = new StringBuffer();
            StrSql.append("st_CSgetTieneAsistencias " + StrclConcierge);

            System.out.println(StrSql);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs.next()) {
                if (Integer.parseInt(rs.getString("TieneAsistencias")) == 1) { %>
                    <script>
                        top.opener.btnHist.style.visibility = 'visible';
                        window.close();
                    </script>
            <% } else { %>
                    <script>
                        top.opener.btnHist.style.visibility = 'hidden';
                        window.close();
                    </script>
            <% }
            }
            rs.close();
            rs = null;
            StrclConcierge = null;
            StrSql = null;
        %>  
    </body>
</html>
