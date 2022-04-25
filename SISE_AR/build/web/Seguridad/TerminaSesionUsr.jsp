<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Termina Sesión</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>

        <%
        String StrclUsrApp1 = "0";  //  usuario que inicia sesión
        String StrclUsrApp2 = "0";  //  usuario del detalle

        if(request.getParameter("clUsrApp1") != null){
            StrclUsrApp1 = request.getParameter("clUsrApp1");
        }

        if(request.getParameter("clUsrApp2") != null){
            StrclUsrApp2 = request.getParameter("clUsrApp2");
        }

        StringBuffer StrSql = new StringBuffer();
        StrSql.append("st_TerminaSesionUsr '" + StrclUsrApp1 + "', '" + StrclUsrApp2 + "'");
        UtileriasBDF.ejecutaSQLNP(StrSql.toString());
        StrSql.delete(0, StrSql.length());

        out.println("<br><br><br>");
        out.println("<p align='center'>");
        out.println("<font class='TitResumen'> Has finalizado la sesión del usuario.</font><br><br><font class='cssazul'>");
        %>

        <br><br>
        <input type="button" name="btnCrr" id="btnCrr" onclick="window.close();" value="Cerrar Ventana"></input>
        <%
        StrclUsrApp1 = null;
        StrclUsrApp2 = null;
        %>
    </body>
</html>