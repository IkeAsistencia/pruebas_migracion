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
            int Error = 0;
            
            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
                if (request.getParameter("FechaIni") != null) {
                    StrFechaIni = request.getParameter("FechaIni").toString();
                    if (request.getParameter("FechaFin") != null) {
                        StrFechaFin = request.getParameter("FechaFin").toString();
                        
                        EscribeRPT EF = new EscribeRPT();
                        Error = EF.EscribeRPT(StrclUsrApp, StrFechaIni, StrFechaFin);
                        
                        EF = null;
                        %>
                        <script>
                            alert('Solicitud recibída.');
                            opener.location.reload();
                            window.close();
                        </script>
                        <%
                    }
                }
            }


        %>

    </body>
</html>

