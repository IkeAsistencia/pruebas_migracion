<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="com.ike.helpdeskSP.to.ImpresionResponsivaInvPDF,Seguridad.SeguridadC,java.sql.ResultSet,Utilerias.UtileriasBDF" %>

<html>
    <head><title>Impresion de Responsiva</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    
    <body  class="cssBody" >
        
        <%
        String StrclUsr  = "0";
        String StrclPaginaWeb  = " 1198";
        String StrclUsrSP = "0";
        //String StrRuta = "D:\\01 Desarrollo\\SISE_CO\\build\\web\\Imagenes\\IKE-M.gif";
        //String StrRuta = "/opt/app/apache-tomcat-5.5.15/webapps/SISE_CO_TEST/Imagenes/IKE-M.gif";
        String StrRuta = "/opt/app/apache-tomcat-6.0.18/webapps/SISE_AR/Imagenes/IKE-M.gif";

        if(session.getAttribute("clUsrApp") != null){
            StrclUsr = session.getAttribute("clUsrApp").toString();
        }

        if(session.getAttribute("clUsrAppSP") != null){
            StrclUsrSP = session.getAttribute("clUsrAppSP").toString();
        }

        if(SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr) ) != true){
            %>Fuera de Horario <% 
            StrclUsr = null;
            StrclPaginaWeb = null;
            StrclUsrSP = null;
            return;
        }

        java.io.ByteArrayOutputStream baos = new java.io.ByteArrayOutputStream();
        ImpresionResponsivaInvPDF PDF = new ImpresionResponsivaInvPDF();
        baos = PDF.ImpresionPDF(StrRuta,"st_GetC_InfoResponsivaxUsrPDF '"+StrclUsrSP+"'","st_GetC_InfoInventarioSPPDF '"+StrclUsrSP+"'", "st_GetC_InfoResponsivaPDF2 '" +StrclUsrSP+"'");
        //<<<<<<<<<<<<<<<<<<< Mostrar PDF En pantalla >>>>>>>>>>>>>>>>>
        response.setContentType("application/pdf");
        response.setContentLength(baos.size());
        ServletOutputStream myOut = response.getOutputStream();
        baos.writeTo(myOut);
        myOut.flush();
        StrclUsr  = null;
        StrclPaginaWeb  = null;
        StrclUsrSP = null;
        %>     
    </body>
</html>