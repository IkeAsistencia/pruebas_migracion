<%-- 
    Document   : CSBorrarProvSel
    Created on : 30/11/2011, 04:28:39 PM
    Author     : atorres
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
    <title>Borrar Registros de Proveedores Seleccionados</title>
    </head>
    <body class="cssBody">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <%
        String StrclAsistencia="0";
        String StrclReferencia="0";
        String StrclUsrApp="0";

         if (session.getAttribute("clUsrApp")!= null){
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
            %>Fuera de Horario<%
            StrclAsistencia=null;
            StrclReferencia=null;
            return;
        }

        if (request.getParameter("clAsistencia")!=null){
            StrclAsistencia = request.getParameter("clAsistencia");
        }

        if (request.getParameter("clReferencia")!=null){
            StrclReferencia = request.getParameter("clReferencia");
        }


        StringBuffer StrSql2 = new StringBuffer();
        StrSql2.append("sp_CSBorrarProvSel ").append(StrclAsistencia).append(",").append(StrclReferencia);
        System.out.println(StrSql2.toString());
        UtileriasBDF.ejecutaSQLNP(StrSql2.toString());
        StrSql2.delete(0,StrSql2.length());

        %>
        <script>window.close();top.opener.location.reload();</script>


        </body>
</html>