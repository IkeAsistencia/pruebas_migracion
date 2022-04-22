<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Busca Tarifa para Asatej</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <%
            String StrFechaIni = "";
            String StrFechaFin = "";
            String StrISIC = "";
            String StrclTipoProducto = "";
            String StrPrecioAsatej = "";
            String StrPrecioPublico = "";

            String StrMensaje = "";

            if (request.getParameter("FechaIni") != null) {
                StrFechaIni = request.getParameter("FechaIni");
            }

            if (request.getParameter("FechaFin") != null) {
                StrFechaFin = request.getParameter("FechaFin");
            }

            if (request.getParameter("ISIC") != null) {
                StrISIC = request.getParameter("ISIC");
            }

            if (request.getParameter("clTipoProducto") != null) {
                StrclTipoProducto = request.getParameter("clTipoProducto");
            }

            StringBuffer strSql = new StringBuffer();
            strSql.append("st_BuscaTarifaAsatej ").append(StrFechaIni).append(",").append(StrFechaFin).append(",").append(StrISIC).append(",").append(StrclTipoProducto);

            ResultSet rs = UtileriasBDF.rsSQLNP(strSql.toString());
            strSql.delete(0, strSql.length());

            if (rs.next()) {
                StrMensaje = rs.getString("Mensaje");

                if (StrMensaje.equalsIgnoreCase("0")) {
                    StrPrecioAsatej = rs.getString("PrecioAsatej");
                    StrPrecioPublico = rs.getString("PrecioPublico");
                } else {
                    StrPrecioAsatej = "";
                    StrPrecioPublico = "";
                }
        %>
        
        <script>
            top.opener.fnObtieneTarifas('<%=StrMensaje%>','<%=StrPrecioAsatej%>','<%=StrPrecioPublico%>');
            window.close();
        </script>
        <%}
            StrFechaIni = null;
            StrFechaFin = null;
            StrISIC = null;
            StrclTipoProducto = null;
            StrPrecioAsatej = null;
            StrPrecioPublico = null;
            StrMensaje = null;

            rs.close();
            rs = null;
        %>
    </body>
</html>