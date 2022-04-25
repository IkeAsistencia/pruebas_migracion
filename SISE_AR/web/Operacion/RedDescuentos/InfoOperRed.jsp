<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <script src='../../Utilerias/Util.js'></script>
        <%
        String StrclReddeDescuentos = "0";
        String StrclModuloRedDescuentos = "0";
        String StrclCentroAtencion = "0";

        if(request.getParameter("clReddeDescuentos")!= null){
            StrclReddeDescuentos = request.getParameter("clReddeDescuentos").toString();
        }

        if(request.getParameter("clModuloRedDescuentos")!= null){
            StrclModuloRedDescuentos = request.getParameter("clModuloRedDescuentos").toString();
        } 

        StringBuffer strSalida = new StringBuffer();
        UtileriasBDF.rsTableNP("st_MuestraRed '" + 1+"'",strSalida);
        %><%=strSalida.toString()%><%

        strSalida.delete(0,strSalida.length());

        strSalida = null;
        StrclReddeDescuentos = null;
        StrclModuloRedDescuentos = null;
        StrclCentroAtencion = null;
        %>
        
        
    </body>
</html>
