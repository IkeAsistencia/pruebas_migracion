<%-- 
    Document   : debugParms.jsp
    Created on : 20/04/2020, 04:45:11 PM
    Author     : ddiez
--%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Map"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>JSP Page</title>
    </head>
    <body>
        <table>
        <%
        //DEbug de Parameters
        Map<String, String[]> parameters = request.getParameterMap();
        for(String parameter: parameters.keySet()) {
            String[] values = parameters.get(parameter);
            out.print("<tr><td>" );
            out.print(parameter);
            out.print("</td><td>\n");
            out.print(values[0]);
            out.print("</td></tr>\n");
        }
        // FIN DEBUG PARMS
        %>
        </table>
    </body>
</html>
