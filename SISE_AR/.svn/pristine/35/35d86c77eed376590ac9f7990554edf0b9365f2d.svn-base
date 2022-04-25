<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Verifica Clave de Afiliado Asatej</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <%
            String StrClave = "";
            String StrclTipoDocumento = "";
            String strMensaje = "";

            if (request.getParameter("Clave") != null) {
                StrClave = request.getParameter("Clave").toString();
            }

            if (request.getParameter("clTipoDocumento") != null) {
                StrclTipoDocumento = request.getParameter("clTipoDocumento").toString();
            }

            StringBuffer strSql = new StringBuffer();
            strSql.append("st_VerificaAfiliadoAsatej ").append(StrClave).append(",").append(StrclTipoDocumento);

            ResultSet rs = UtileriasBDF.rsSQLNP(strSql.toString());
            strSql.delete(0, strSql.length());

            if (rs.next()) {
                strMensaje = rs.getString("Mensaje");%>
        <script>
            top.opener.fnVerificacion('<%=strMensaje%>');
            window.close();
        </script>
        <%}
            StrClave = null;
            StrclTipoDocumento = null;
            strMensaje = null;

            rs.close();
            rs = null;
        %>
    </body>
</html>