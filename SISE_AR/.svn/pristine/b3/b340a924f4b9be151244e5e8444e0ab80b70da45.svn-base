<%@page contentType="text/html"%>
<%@page pageEncoding="ISO-8859-1" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Utilerias.PDF"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Envia PDF</title>
    </head>
    <body>
        <%
                String StrStoreProcedure = "",
                        StrParametros = "",
                        StrParametrosPDF = "",
                        StrCorreo = "",
                        StrCorreoCC = "",
                        StrStoreCuerpoMail = "",
                        StrRuta = "",
                        StrCuerpoMail = "",
                        StrclTipoEnvioMail = "",
                        StrInsert = "",
                        StrAsunto = "",
                        StrArchivo = "",
                        StrclUsrApp = "0",
                        StrBitacora = "",
                        StrCampoLlave = "",
                        StrdsPDF = "",
                        StrclCuentaCorreo = "",
                        StrObservaciones = "";

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

                if (request.getParameter("Correo") != null) {
                    StrCorreo = request.getParameter("Correo").toString();
                }

                if (request.getParameter("StoreCuerpoMail") != null) {
                    StrStoreCuerpoMail = request.getParameter("StoreCuerpoMail").toString();
                }

                if (request.getParameter("Ruta") != null) {
                    StrRuta = request.getParameter("Ruta").toString();
                }

                if (request.getParameter("CampoLlave") != null) {
                    StrCampoLlave = request.getParameter("CampoLlave").toString();
                }

                if (request.getParameter("dsPDF") != null) {
                    StrdsPDF = request.getParameter("dsPDF").toString();
                }

                StrRuta = StrRuta + "_" + StrParametros + ".pdf";

                PDF pdf = new PDF();
                pdf.ImprimePDF(StrStoreProcedure, StrParametros + "','" + StrclUsrApp + "", StrParametrosPDF, StrRuta);
                pdf = null;

                ResultSet rsCuerpoMail = null;

                rsCuerpoMail = UtileriasBDF.rsSQLNP(StrStoreCuerpoMail + " '" + StrParametros + "','" + StrclUsrApp + "'");

                if (rsCuerpoMail.next()) {
                    StrCuerpoMail = rsCuerpoMail.getString("CuerpoMail");
                    StrArchivo = rsCuerpoMail.getString("Archivo");
                    StrAsunto = rsCuerpoMail.getString("Asunto");
                    StrclTipoEnvioMail = rsCuerpoMail.getString("clTipoEnvioMail");
                    StrBitacora = rsCuerpoMail.getString("Bitacora");
                    StrObservaciones = rsCuerpoMail.getString("Observaciones");
                    StrCorreoCC = rsCuerpoMail.getString("CorreoCC");
                    StrclCuentaCorreo = rsCuerpoMail.getString("clCuentaCorreo");
                }

                StrCuerpoMail = StrCuerpoMail.replace("'", "''");
                //StrCuerpoMail = StrCuerpoMail.replace("\"","\"\"");

                StrInsert = " insert into MensajesMail  (tipo,Asunto,Fecha, Destinatario,Archivo,Cuerpo,Enviado,clUsrApp,Adjuntos,clTipoEnvioMail,clCuentaCorreo) values";
                StrInsert = StrInsert + " (1,'" + StrAsunto + "',getdate(),'" + StrCorreo + StrCorreoCC + "','" + StrArchivo + "','" + StrCuerpoMail + "','0','" + StrclUsrApp + "','" + StrRuta + "','" + StrclTipoEnvioMail + "','" + StrclCuentaCorreo + "')";

                //System.out.println("Mensaje Mail:--"+StrInsert);
                UtileriasBDF.ejecutaSQLNP(StrInsert);


                StrInsert = " insert into " + StrBitacora + " (" + StrCampoLlave + ",clEstatus,Fecha,clUsrApp,Observaciones) values";
                StrInsert = StrInsert + " ('" + StrParametros + "','9',getdate(),'" + StrclUsrApp + "','<STRONG>SE ENVIA FORMATO DE " + StrdsPDF + " AL CORREO: " + StrCorreo + " " + StrObservaciones + "</STRONG>')";

                //System.out.println("Bitácora:--"+StrInsert);
                UtileriasBDF.ejecutaSQLNP(StrInsert);

                StrStoreProcedure = null;
                StrParametros = null;
                StrStoreCuerpoMail = null;
                StrRuta = null;
                StrCuerpoMail = null;
                StrArchivo = null;
                StrAsunto = null;
                StrclTipoEnvioMail = null;
                StrclUsrApp = null;
                StrBitacora = null;
                StrCampoLlave = null;
                StrdsPDF = null;
        %>

    </body>
    <script>
        alert('Se enviara el archivo al correo: <%=StrCorreo%>');
        top.opener.fnClose();
        window.close();
    </script>
</html>
