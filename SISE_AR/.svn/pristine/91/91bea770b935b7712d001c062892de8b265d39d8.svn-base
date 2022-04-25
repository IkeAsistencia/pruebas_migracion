<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>EjecutaCostos</title> 
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <%
            String StrclExpediente = "0";
            String StrclCosto = "0";
            String StrAccion = "";

            if (request.getParameter("clExpediente") != null) {
                StrclExpediente = request.getParameter("clExpediente").toString();
            } else {
                if (session.getAttribute("clExpediente") != null) {
                    StrclExpediente = session.getAttribute("clExpediente").toString();
                }
            }

            if (request.getParameter("clCosto") != null) {
                StrclCosto = request.getParameter("clCosto").toString();
            }

            if (request.getParameter("Accion") != null) {
                StrAccion = request.getParameter("Accion").toString();
            }

            if (StrAccion.equalsIgnoreCase("E")) {
                UtileriasBDF.ejecutaSQLNP("st_EliminaCostosTmp " + StrclCosto);

                StrclExpediente = null;
                StrclCosto = null;
                StrAccion = null;
        %>
        <script>
            location.href = "ListaCostosTmp.jsp"
        </script>         
        <%
            }else{

            if (StrAccion.equalsIgnoreCase("P")) {
                UtileriasBDF.ejecutaSQLNP("st_ProcesaCostosTmp " + StrclExpediente);

                StrclExpediente = null;
                StrclCosto = null;
                StrAccion = null;
        %>
        <script>
            alert('Costos Procesados');
            window.opener.fnReload(); // llamo funcion en ventana dos (hija)
            window.close(); // cierro ventana 3 (nieta)
        </script>         
        <%
            }
            }
        %>

    </body>
</html>
