<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <%
            String StrclExpediente = "0";
            if (request.getParameter("clExpediente") != null) {
                StrclExpediente = request.getParameter("clExpediente");
            }
            String strQuejaActual = "0";

            StringBuffer strSql = new StringBuffer();
            strSql.append("select coalesce(max(clQuejaxSupervision),'0')  'clQuejaxSupervision' from DeficienciasxExpediente where clExpediente = ").append(StrclExpediente);
            ResultSet rs = UtileriasBDF.rsSQLNP(strSql.toString());

            if (rs.next()) {
                strQuejaActual = rs.getString("clQuejaxSupervision");
        %>
        <script>
            window.opener.fnActualizaQ('<%=strQuejaActual%>');            
        </script>
        <script>window.close()</script>

        <%} else {
        %>
        <script>window.close();</script>

        <%}

            strSql.delete(0, strSql.length());
            rs.close();
            rs = null;

        %>
    </body>
</html>