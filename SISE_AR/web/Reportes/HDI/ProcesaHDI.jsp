<%@page import="Utilerias.EscribeRPTGenerico"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Utilerias.EscribeRPT" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Reporte LISOL</title>
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>

        <%
            String StrclUsrApp = "0";
            String StrFechaIni = "";
            String StrFechaFin = "";
            String StrPoliza = "";
            String StrPatente = "";
            String Bandera = "";
            String StrclPaginaWeb = "";
            int Error = 0;

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
                if (request.getParameter("FechaIni") != null) {
                    StrFechaIni = request.getParameter("FechaIni").toString();
                }
                if (request.getParameter("FechaFin") != null) {
                    StrFechaFin = request.getParameter("FechaFin").toString();
                }
                if (request.getParameter("Poliza") != null) {
                    StrPoliza = request.getParameter("Poliza").toString();
                }
                if (request.getParameter("Patente") != null) {
                    StrPatente = request.getParameter("Patente").toString();
                }
                if (request.getParameter("Bandera") != null) {
                    Bandera = request.getParameter("Bandera").toString();
                }
                if (request.getParameter("clPaginaWeb") != null) {
                    StrclPaginaWeb = request.getParameter("clPaginaWeb").toString();
                }
                System.out.println("Bandera: " + Bandera);
                EscribeRPTGenerico escribeRPTGenerico = new EscribeRPTGenerico();
                Error = escribeRPTGenerico.EscribeRPTGenerico(StrclUsrApp, StrFechaIni, StrFechaFin, Bandera, StrclPaginaWeb, StrPatente, StrPoliza);

                escribeRPTGenerico = null;
        %>
        <script>
            alert('Solicitud recibída.');
            opener.location.reload();
            window.close();
        </script>
        <%
            }
        %>

    </body>
</html>

