<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">

        <%
            String strclExpediente = "0";
            String strclProveedor = "0";
            String strclConcepto = "0";

            if (session.getAttribute("clExpediente") != null) {
                strclExpediente = session.getAttribute("clExpediente").toString();
            }

            if (request.getParameter("clProveedor") != null) {
                strclProveedor = request.getParameter("clProveedor").toString();
            }

            if (request.getParameter("clConcepto") != null) {
                strclConcepto = request.getParameter("clConcepto").toString();
            }

            StringBuffer strSql = new StringBuffer();
            strSql.append("sp_RegresaCostoVIAL '").append(strclExpediente).append("','").append(strclProveedor).append("','").append(strclConcepto).append("'");
            ResultSet rs = UtileriasBDF.rsSQLNP(strSql.toString());
            if (rs.next()) { %>
                <script>
                    top.opener.fnActualizaDatosCosto('<%=rs.getString("Costo")%>', '<%=rs.getString("clCostoxSubservxEF")%>', '<%=rs.getString("clCostoXProvXSubserv")%>', '<%=rs.getString("clCategoria")%>', '<%=rs.getString("Excepcion")%>');
                    window.close();
                </script>
            <% } else { %>
                <script>
                    top.opener.fnActualizaDatosCosto('0');
                    window.close();
                </script>
            <%
                }
            strSql.delete(0, strSql.length());
            rs.close();
            rs = null;
        %>
    </body>
</html>

