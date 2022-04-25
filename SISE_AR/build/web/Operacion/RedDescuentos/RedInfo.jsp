<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>

<html>
    <head>
        <title>Red Informacion</title> 
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>        
        
        <%
            String strclReddeDescuentos = "0";
            StringBuffer strSalida = new StringBuffer();

            if (request.getParameter("clRedDescuentos") != null) {
                strclReddeDescuentos = request.getParameter("clRedDescuentos").toString();
            }

            UtileriasBDF.rsTableNP("st_MuestraSucursalRed '" + strclReddeDescuentos + "'", strSalida);
            //System.out.println("st_MuestraSucursalRed " + strclReddeDescuentos);
        %><%=strSalida.toString()%><%

            strSalida.delete(0, strSalida.length());
            strclReddeDescuentos = null;
            strSalida = null;
        %>
    </body>
</html>
