<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>Lista de Beneficiarios</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../Utilerias/Util.js' ></script>
        <script>

        </script>
        <%
        //String StrSql = "";
        String StrclUsrApp = "0";
        String StrclAfiliadoNU = "0";
        //String StrclPaginaWeb = "0";
        String strclCuenta = "0";

        if (session.getAttribute("clUsrApp") != null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        } else if (request.getParameter("clUsrApp") != null) {
            StrclUsrApp = request.getParameter("clUsrApp").toString();
        }
        if (request.getParameter("clAfiliadoNU") != null) {
            StrclAfiliadoNU = request.getParameter("clAfiliadoNU").toString();
        }

        if (request.getParameter("clCuenta") != null) {
            strclCuenta = request.getParameter("clCuenta").toString();
        }

        %>
        <form id='Forma' name ='Forma'  action='ListaVentaAcumulador.jsp?' method='post'>
            <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px;'></div>

            <div class='VTable' style='position:absolute; z-index:25; left:10px; top:50px;'></div>
            <%StringBuffer strSalida = new StringBuffer();
        UtileriasBDF.rsTableNP("st_ListaBeneficiarios " + StrclAfiliadoNU + "," + strclCuenta, strSalida);
            %>
            <%=strSalida.toString()%>
            <%strSalida.delete(0, strSalida.length());
        strSalida = null;%>
        </form>
        <%
        //StrSql = null;
        StrclUsrApp = null;
        StrclAfiliadoNU = null;
        strclCuenta = null;
    //StrclPaginaWeb = null;

        %>

        <script>
        </script>
    </body>
</html>
