<%-- 
    Document   : CSCampoxAsistencia
    Created on : 30/08/2011, 05:55:42 PM
    Author     : rfernandez
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>JSP Page</title>
    </head>
    <body>
     
    </body>
</html>

<%

    String StrclAsistencia = "0";
    String StrclGolfProgram = "0";
    String StrSemestre = "0";
    String StrclUsr = "0";
    String StrclConcierge = "0";

        if (request.getParameter("clConcierge") != null) {
            StrclConcierge = request.getParameter("clConcierge").toString();
        } else {
            if (session.getAttribute("clConcierge") != null) {
                StrclConcierge = session.getAttribute("clConcierge").toString();
            }
        }


            if (session.getAttribute("clUsrApp") != null) {
                StrclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr)) != true) {
                            %>Fuera de Horario <%
                StrclUsr = null;
                return;
            }
       
            if (request.getParameter("clAsistencia") != null) {
                StrclAsistencia = request.getParameter("clAsistencia").toString();
            } else {
                if (session.getAttribute("clAsistencia") != null) {
                    StrclAsistencia = session.getAttribute("clAsistencia").toString();
                }
            }

            if (request.getParameter("Semestre") != null) {
                StrSemestre = request.getParameter("Semestre").toString();
            }

            if (request.getParameter("clGolfProgram") != null) {
                StrclGolfProgram = request.getParameter("clGolfProgram").toString();
            }
            
            StringBuffer strSalida = new StringBuffer();


            System.out.println("st_CSGuardaCampoxAsistencia'"+ StrclGolfProgram + "','" + StrclAsistencia + "','" + StrclUsr + "','" +StrSemestre + "','" +StrclConcierge+"'");
            UtileriasBDF.ejecutaSQLNP("st_CSGuardaCampoxAsistencia'"+ StrclGolfProgram + "','" + StrclAsistencia + "','" + StrclUsr + "','" +StrSemestre + "','" +StrclConcierge+"'");
            %>
            <%=strSalida.toString()%>
            <%strSalida.delete(0,strSalida.length());
            %>
%>

<script>

    top.opener.fnActualizaCampos();

    window.close();
       
</script>