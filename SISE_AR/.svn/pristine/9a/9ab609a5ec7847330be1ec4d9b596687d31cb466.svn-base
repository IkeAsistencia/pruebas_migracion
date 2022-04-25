<%-- 
    Document   : CSListaProveedores
    Created on : 6/10/2011, 12:17:00 PM
    Author     : atorres
--%>

<%@page import="Utilerias.UtileriasBDF,java.sql.ResultSet,Seguridad.SeguridadC" %>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<html>
    <head>

    </head>
    <body>
        <%        

        String StrclAsistencia="0";

        if (request.getParameter("clAsistencia")!= null) {
            StrclAsistencia= request.getParameter("clAsistencia").toString();
            System.out.println("clAsistencia.Request="+StrclAsistencia);
        }

        %>
       <br><br><hr size="1">
                <p><font color="navy" face="Arial" size="3" ><b><i>Referencias Asignadas</i></b> </font></p>
                <%
                StringBuffer strSalida2 = new StringBuffer();
                UtileriasBDF.rsTableNP("st_CSListaProveedoresAsignados "+ StrclAsistencia , strSalida2);
                %>
                <%=strSalida2.toString()%>
                <%strSalida2.delete(0,strSalida2.length());  %>

    </body>
</html>

