<%@page import="Utilerias.EscribeRPTGenericoGalicia"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Utilerias.EscribeRPTGenericoGalicia" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Reporte Galicia</title>
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>

        <%
            String StrclUsrApp = "0";
            String StrFechaIni = "";
            String StrFechaFin = "";
            String StrDocumento = "";
            String Bandera = "";
            String StrclPaginaWeb = "6134";
            int Error = 0;

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
                if (request.getParameter("FechaIni") != null) {
                    StrFechaIni = request.getParameter("FechaIni").toString();
                }
                if (request.getParameter("FechaFin") != null) {
                    StrFechaFin = request.getParameter("FechaFin").toString();
                }
                if (request.getParameter("Documento") != null) {
                    StrDocumento  = request.getParameter("Documento").toString();
                }
                if (request.getParameter("Bandera") != null) {
                    Bandera = request.getParameter("Bandera").toString();
                }
                if (request.getParameter("clPaginaWeb") != null) {
                    StrclPaginaWeb = request.getParameter("clPaginaWeb").toString();
                }
                System.out.println("Bandera: " + Bandera);
                EscribeRPTGenericoGalicia escribeRPTGenericoGalicia = new EscribeRPTGenericoGalicia();
                //Error = escribeRPTGenericoGalicia.EscribeRPTGenericoGaliciaBG(StrclUsrApp, StrFechaIni, StrFechaFin, Bandera, StrclPaginaWeb, StrDocumento);
                Error = escribeRPTGenericoGalicia.EscribeRPTGenericoGaliciaBG(StrclUsrApp, StrFechaIni, StrFechaFin, Bandera, StrclPaginaWeb,StrDocumento);
                escribeRPTGenericoGalicia = null;
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

