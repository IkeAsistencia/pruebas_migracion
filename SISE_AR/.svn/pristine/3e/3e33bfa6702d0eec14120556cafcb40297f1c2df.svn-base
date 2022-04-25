<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody" topmargin="10">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">

        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilServicio.js'></script>
        <%
            String StrClave = "";
            String StrclCuenta = "0";
            String clbandera = "0";

            if (session.getAttribute("Clave") != null) {
                StrClave = session.getAttribute("Clave").toString();
            }
            if (session.getAttribute("clCuenta") != null) {
                StrclCuenta = session.getAttribute("clCuenta").toString();
            }

            String StrclPaginaWeb = "254";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            if (request.getParameter("banderaLink") == "0") { %>
                <SCRIPT>fnOpenLinks()</script>
            <% } %>
            <tr>
        <td class='cssTitDet'>SERVICIOS OTORGADOS  EN EL ULTIMO CONTRATO</td></tr>
    <tr>
        <td>
            <table>
                <tr>
                    <td>
                        <% StringBuffer strSalida = new StringBuffer();
                            UtileriasBDF.rsTableNP("sp_GetHistoricoNU '" + StrclCuenta + "','" + StrClave + "','" + request.getParameter("banderaLink") + "'", strSalida);
                            System.out.println("sp_GetHistoricoNU '" + StrclCuenta + "','" + StrClave + "'");

                        %>
                        <%=strSalida.toString()%>
                        <%strSalida.delete(0, strSalida.length());
                            strSalida = null;
                        %>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</body>
</html>