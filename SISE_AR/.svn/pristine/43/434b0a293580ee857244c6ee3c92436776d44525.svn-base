<%@ page contentType="application/octet-stream" language="java" import="java.sql.ResultSet,Utilerias.UtileriasObj,Utilerias.UtileriasBDF,Seguridad.SeguridadC,java.io.PrintStream,java.io.FileInputStream,java.util.ArrayList" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<%

    String StrclUsr = "0";

    if (session.getAttribute("clUsrApp") != null) {
        StrclUsr = session.getAttribute("clUsrApp").toString();
    }

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr)) != true) {  %> 
Fuera de Horario <%
        StrclUsr = null;
        return;
    }

    String RutaArchivo = "";

    String Archivo = "";

    if (request.getParameter("Archivo") != null) {
        Archivo = request.getParameter("Archivo").toString();
        System.out.println("Archivo...." + Archivo);
    }

    RutaArchivo = Archivo;

    FileInputStream archivo = new FileInputStream(RutaArchivo);
    int longitud = archivo.available();
    byte[] datos = new byte[longitud];
    archivo.read(datos);
    archivo.close();
    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition", "attachment;filename=" + Archivo);
    ServletOutputStream ouputStream = response.getOutputStream();
    ouputStream.write(datos);
    ouputStream.flush();
    ouputStream.close();
    ouputStream = null;

    RutaArchivo = null;
    archivo = null;
%>




