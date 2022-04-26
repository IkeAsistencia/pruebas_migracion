<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="com.ike.Compras.ImpresionPDF,Seguridad.SeguridadC,java.sql.ResultSet,Utilerias.UtileriasBDF" %>

<html>
    <head>
        <title>Impresion Solicitud de Compra</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>

    <body  class="cssBody" >

        <%
        String StrclUsr = "0";
        String StrclPaginaWeb = "5066";
        String StrclCompra = "0";

        if (session.getAttribute("clUsrApp") != null) {
            StrclUsr = session.getAttribute("clUsrApp").toString();
        }

        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr)) != true) {%>
        Fuera de Horario <%
            StrclUsr = null;
            StrclPaginaWeb = null;
            StrclCompra = null;
            return;
        }

        if (request.getParameter("clCompra") != null) {
            StrclCompra = request.getParameter("clCompra").toString();
            session.setAttribute("clCompra", StrclCompra);
        } else {
            if (session.getAttribute("clCompra") != null) {
                StrclCompra = session.getAttribute("clCompra").toString();
            }
        }
        // System.out.println("Entra Impresion: " + StrclCompra);

        // ResultSet rsProveedorxCompra = null;
        // rsProveedorxCompra = UtileriasBDF.rsSQLNP("sp_C_GetProvAsigCompra '"+StrclCompra+"'");

        String StrclProductoxCompra = "0";

        if (request.getParameter("clProductoxCompra") != null) {
            StrclProductoxCompra = request.getParameter("clProductoxCompra").toString();
        }
        /* if (rsProveedorxCompra.next()){
        StrclProveedor = rsProveedorxCompra.getString("clProveedor");
        }*/

        // rsProveedorxCompra.close();
        // rsProveedorxCompra = null;

        // if (!StrclProveedor.equalsIgnoreCase("0")) {

        java.io.ByteArrayOutputStream baos = new java.io.ByteArrayOutputStream();

        ImpresionPDF PDF = new ImpresionPDF();
        //baos = PDF.ImpresionPDF("C:\\PROYECTOS\\SISE_AR\\build\\web\\Imagenes\\IKE-M.gif","st_GetC_InfoPDF '"+StrclProductoxCompra+"'","st_GetC_InfoProdPDF '"+StrclProductoxCompra+"'");
        //baos = PDF.ImpresionPDF("/opt/app/apache-tomcat-6.0.18/webapps/SISE_AR/Imagenes/IKE-M.gif", "st_GetC_InfoPDF '" + StrclProductoxCompra + "'", "st_GetC_InfoProdPDF '" + StrclProductoxCompra + "'");
        baos = PDF.ImpresionPDF("/opt/app/apache-tomcat-7.0.50/webapps/SISE_AR/Imagenes/IKE-M.gif", "st_GetC_InfoPDF '" + StrclProductoxCompra + "'", "st_GetC_InfoProdPDF '" + StrclProductoxCompra + "'");
        
        //<<<<<<<<<<<<<<<<<<< Mostrar PDF En pantalla >>>>>>>>>>>>>>>>>
        response.setContentType("application/pdf");
        response.setContentLength(baos.size());
        ServletOutputStream myOut = response.getOutputStream();
        baos.writeTo(myOut);
        myOut.flush();
        // }

        StrclUsr = null;
        StrclPaginaWeb = null;
        StrclCompra = null;
        StrclProductoxCompra = null;

        %>

    </body>
</html>
