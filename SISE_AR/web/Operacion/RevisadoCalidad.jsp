<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Revisado por Calidad</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <%

        String strclusrapp = "";
        String strexpediente = "";

        if (session.getAttribute("clUsrApp") != null) {
            strclusrapp = session.getAttribute("clUsrApp").toString();
        }

        if (request.getParameter("clexpediente") != null) {
            strexpediente = request.getParameter("clexpediente");
        }

        ResultSet cdr = null;
        cdr = UtileriasBDF.rsSQLNP("st_ActualizaEstatusRev " + strclusrapp + "," + strexpediente);

        //System.out.println("clusrapp: " + strclusrapp + " xpedient " + strexpediente);

        %>

        <script>
            top.opener.actualizar();
            window.close();
        </script>
    </body>
</html>