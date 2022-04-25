<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Envío Certificado Asatej</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <%
            String StrclUsrApp = "";
            String StrclAfiliado = "";
            String StrMensaje = "";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (request.getParameter("clAfiliado") != null) {
                StrclAfiliado = request.getParameter("clAfiliado");
            }

            StringBuffer strSql = new StringBuffer();
            strSql.append("st_GeneraMailAsatej ").append(StrclAfiliado).append(",").append(StrclUsrApp);

            ResultSet rs = UtileriasBDF.rsSQLNP(strSql.toString());
            strSql.delete(0, strSql.length());

            if (rs.next()) {
                StrMensaje = rs.getString("Mensaje");
        %>
        
        <script>
            top.opener.fnValidaEnvio('<%=StrMensaje%>');
            window.close();
        </script>
        <%}
            StrclUsrApp = null;
            StrclAfiliado = null;
            StrMensaje = null;

            rs.close();
            rs = null;
        %>
    </body>
</html>