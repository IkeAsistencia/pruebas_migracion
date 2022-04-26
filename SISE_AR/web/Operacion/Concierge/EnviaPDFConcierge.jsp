<%-- 
    Document   : EnviaPDFConcierge
    Created on : 27/06/2011, 04:56:41 PM
    Author     : atorres
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="Seguridad.SeguridadC,java.sql.ResultSet,Utilerias.UtileriasBDF" %>


<html>
     <head><title>Envio PDF de Cotizacion ó Confirmacion Concierge </title>
            <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
     </head>


    <body class="cssBody" onload=''>
    <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" />
    <script src='../Utilerias/Util.js' ></script>


    <%
        String StrclUsr  = "0";
        String StrclPaginaWeb  = "0";
        String StrclConcierge = "0";
        String StrclCuenta = "0";
        String StrclAsistencia = "0";
        String StrRutaPDF = "";
        String StrVersion = "0";
        String StrPrefijo = "";
        String StrPath = "";
        String StrNombreFile = "";
        String StrclEnvio="0";
        String StrclReferencia="0";

        if ( session.getAttribute("clUsrApp") != null) {
            StrclUsr = session.getAttribute("clUsrApp").toString();
        }

        if ( SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr) ) != true ) {  %>
             Fuera de Horario <%
             StrclUsr = null;
             StrclPaginaWeb = null;
             return;
        }

        if (session.getAttribute("clConcierge") != null){
            StrclConcierge = session.getAttribute("clConcierge").toString();            
        }

        if  (session.getAttribute("clCuenta") != null) {
            StrclCuenta = session.getAttribute("clCuenta").toString();           
        }


        if (request.getParameter("clAsistencia")!= null) {
            StrclAsistencia= request.getParameter("clAsistencia").toString();
        } else{
            if (session.getAttribute("clAsistencia")!= null) {
                StrclAsistencia= session.getAttribute("clAsistencia").toString();
            }
        }

        if (session.getAttribute("NomFile")!= null) {
            StrNombreFile= session.getAttribute("NomFile").toString();
        }

        if (session.getAttribute("RutaPDF")!= null) {
            StrPath= session.getAttribute("RutaPDF").toString();
        }


        if (request.getParameter("clEnvio")!= null) {
            StrclEnvio= request.getParameter("clEnvio").toString();
        }

        if (request.getParameter("clReferencia")!= null) {
            StrclReferencia= request.getParameter("clReferencia").toString();
        }

        System.out.println("EnviaPDF.Concierge.clEnvio="+StrclEnvio);

        StrclPaginaWeb = "1380";
        MyUtil.InicializaParametrosC(1380,Integer.parseInt(StrclUsr));    // se checan permisos de alta,baja,cambio,consulta de esta pagina


        System.out.println("sp_SendMailAdjuntoPDFConcierge '"+StrclConcierge+"','"+StrPath+"','"+StrNombreFile+"','"+StrclUsr+"','"+StrclAsistencia+"','"+StrclEnvio+"','"+StrclReferencia+"'");

        UtileriasBDF.ejecutaSQLNP("sp_SendMailAdjuntoPDFConcierge '"+StrclConcierge+"','"+StrPath+"','"+StrNombreFile+"','"+StrclUsr+"','"+StrclAsistencia+"','"+StrclEnvio+"','"+StrclReferencia+"'");

        %>
        <script>alert("Formato Enviado"); </script>
        <script>window.close(); </script>
        <%
            StrclUsr  = null;
            StrclPaginaWeb  = null;
        %>
    </body>
</html>

