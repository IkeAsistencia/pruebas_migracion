<%@page contentType="application/pdf"%>
<%@page pageEncoding="ISO-8859-1" import="Utilerias.PDF,java.io.ByteArrayOutputStream"%>
<%--
The taglib directive below imports the JSTL library. If you uncomment it,
you must also add the JSTL library to the project. The Add Library... action
on Libraries node in Projects view can be used to add the JSTL 1.1 library.
--%>
<%--
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>PDF Dinamico</title>
    </head>
    <body>
        <table><tr><td align='center' class='cssTitDet'>Información Adicional</td></tr></table>
    <tr><td>
            <table><a target='Contenido' href='Operacion/Concierge/CSSeguimiento.jsp?clAsistencia=0&Apartado=S'><tr><td width=200 class='cssLinkOu' onMouseOver=this.className='cssLinkOv' onMouseOut=this.className='cssLinkOu'>Agenda</td></tr></a><a target='Contenido' href='Operacion/Concierge/Concierge.jsp?&Apartado=S'><tr><td width=200 class='cssLinkOu' onMouseOver=this.className='cssLinkOv' onMouseOut=this.className='cssLinkOu'>Datos Usuario Concierge</td></tr></a><a target='Contenido' href='Operacion/Concierge/CSSeleccionaServicio.jsp?&Apartado=S'><tr><td width=200 class='cssLinkOu' onMouseOver=this.className='cssLinkOv' onMouseOut=this.className='cssLinkOu'>Detalle Evento</td></tr></a></table>
            <%
                        String StrStoreProcedure = "", StrParametros = "", StrParametrosPDF = "";
                        String StrclUsrApp = "0";

                        if (session.getAttribute("clUsrApp") != null) {
                            StrclUsrApp = session.getAttribute("clUsrApp").toString();
                        }


                        if (request.getParameter("StoreProcedure") != null) {
                            StrStoreProcedure = request.getParameter("StoreProcedure").toString();
                        }

                        if (request.getParameter("Parametros") != null) {
                            StrParametros = request.getParameter("Parametros").toString();
                        }

                        if (request.getParameter("ParametrosPDF") != null) {
                            StrParametrosPDF = request.getParameter("ParametrosPDF").toString();
                        }

                        ByteArrayOutputStream baos = new ByteArrayOutputStream();

                        PDF Pdf = new PDF();
                        baos = Pdf.VistaPDF(StrStoreProcedure, StrParametros + "','" + StrclUsrApp + "", StrParametrosPDF);


                        //<<<<<<<<<<<<<<<<<<< Mostrar PDF En pantalla >>>>>>>>>>>>>>>>>
                        response.setContentType("application/pdf");
                        response.setContentLength(baos.size());
                        ServletOutputStream myOutPDF = response.getOutputStream();
                        //ServletOutputStream myOutPDF = response.getWriter();
                        baos.writeTo(myOutPDF);
                        myOutPDF.flush();
                        Pdf = null;
                        baos.close();
                        myOutPDF.close();


                        myOutPDF = null;
                        baos = null;


                        StrStoreProcedure = null;
                        StrParametros = null;
            %>

        </body>
</html>
