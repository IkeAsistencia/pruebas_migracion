<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>

<html>
    <head>
        <title>Asignar Referencia</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <%
        String StrclProveedorRef = "0";
        String StrclRReferencias = "";
        String StrclSubServicio = "0";

        if (request.getParameter("clProveedorRef") != null) {
            StrclProveedorRef = request.getParameter("clProveedorRef");
        }

        if (request.getParameter("clRReferencias") != null) {
            StrclRReferencias = request.getParameter("clRReferencias");
        } else {
            if (session.getAttribute("clRReferencias") != null) {
                StrclRReferencias = session.getAttribute("clRReferencias").toString();
            }
        }

        if (session.getAttribute("clSubservicioSession") != null) {
            StrclSubServicio = session.getAttribute("clSubservicioSession").toString();
        }
        //System.out.println(" st_AsignaunaRedRef '" + StrclRReferencias + "','" + StrclProveedorRef + "'," + StrclSubServicio);

        UtileriasBDF.ejecutaSQLNP(" st_AsignaunaRedRef '" + StrclRReferencias + "','" + StrclProveedorRef + "'," + StrclSubServicio);

        StrclProveedorRef = null;
        StrclRReferencias = null;
        StrclSubServicio = null;
        %>
        <script>
            top.opener.location.href='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>../../servlet/Utilerias.Lista?P=966&Apartado=S';
            window.close();
        </script>
    </body>
</html>