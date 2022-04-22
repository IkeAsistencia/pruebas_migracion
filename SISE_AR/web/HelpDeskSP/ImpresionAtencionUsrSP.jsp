<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="com.ike.helpdeskSP.ImpresionMasivaSP,Seguridad.SeguridadC,java.sql.ResultSet,Utilerias.UtileriasBDF" %>


<html>
    <head><title>Impresion de Imágenes x Expediente PDF</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>

    <body  class="cssBody" >

        <%
                    String StrclUsr = "0";
                    String StrclPaginaWeb = " 1348";
                    String StrImagenesSelec = "0";

                    String StrRuta = "/opt/app/apache-tomcat-6.0.18/webapps/SISE_AR/Imagenes/LogoAR_P.gif";
                    // RUTA Local String StrRuta = "C:\\Proyectos\\SISE_CO\\build\\web\\Imagenes\\LogoCO_P.GIF";

                    if (session.getAttribute("clUsrApp") != null) {
                        StrclUsr = session.getAttribute("clUsrApp").toString();
                    }


                    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr)) != true) {%>
        Fuera de Horario <%
                        StrclUsr = null;
                        StrclPaginaWeb = null;
                        StrImagenesSelec = null;


                        return;
                    }

                    if (request.getParameter("Resultados") != null) {
                        StrImagenesSelec = request.getParameter("Resultados").toString();
                    }

                    java.io.ByteArrayOutputStream baos = new java.io.ByteArrayOutputStream();

                    ImpresionMasivaSP PDF = new ImpresionMasivaSP();
                    baos = PDF.ImpresionEvalServicio(StrRuta, "st_HelpdeskSPMasiva '" + StrImagenesSelec + "'", StrclUsr);

                    //<<<<<<<<<<<<<<<<<<< Mostrar PDF En pantalla >>>>>>>>>>>>>>>>>
                    response.setContentType("application/pdf");
                    response.setContentLength(baos.size());
                    ServletOutputStream myOut = response.getOutputStream();
                    baos.writeTo(myOut);
                    myOut.flush();

                    //Limpia Variables
                    StrclUsr = null;
                    StrclPaginaWeb = null;
                    StrImagenesSelec = null;
        %>    



    </body>
</html>