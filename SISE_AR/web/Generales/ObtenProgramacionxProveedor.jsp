<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Valida Programacion x Proveedor</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <%
            String StrTipo = "0";
            String StrclProveedor = "0";
            String StrclSubServicio = "0";
            String StrclConcepto = "0";
            String strActual = "";
            String strExistePendiente = "";

            if (request.getParameter("Tipo") != null) {
                StrTipo = request.getParameter("Tipo").toString();
            }

            if (request.getParameter("clProveedor") != null) {
                StrclProveedor = request.getParameter("clProveedor").toString();
            }

            if (request.getParameter("clSubServicio") != null) {
                StrclSubServicio = request.getParameter("clSubServicio").toString();
            }

            if (request.getParameter("clConcepto") != null) {
                StrclConcepto = request.getParameter("clConcepto").toString();
            }

            StringBuffer strSql = new StringBuffer();
            strSql.append("st_PGObtenActual ").append(StrTipo).append(",").append(StrclProveedor).append(",").append(StrclSubServicio).append(",").append(StrclConcepto);

            ResultSet rs = UtileriasBDF.rsSQLNP(strSql.toString());
            strSql.delete(0, strSql.length());

            if (rs.next()) {
                strActual = rs.getString("Actual");
                strExistePendiente = rs.getString("ExistePendiente");
        %>
        <script>
            top.opener.fnRegresaActual('<%=strActual%>', '<%=strExistePendiente%>');
            window.close();
        </script>
        <%}

            StrTipo = null;
            StrclProveedor = null;
            StrclSubServicio = null;
            strActual = null;
            strExistePendiente = null;
            rs.close();
            rs = null;
        %>
    </body>
</html>