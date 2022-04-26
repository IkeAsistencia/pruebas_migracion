<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Asignar Red</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <%
            String strclModuloRedDescuentos = "0";
            String strclReddeDescuentos = "0";
            String strclSucursalReddeDescuentos = "0";

            if (request.getParameter("clReddeDescuentos") != null) {
                strclReddeDescuentos = request.getParameter("clReddeDescuentos").toString();
            }

            // System.out.println("Matriz "+strclReddeDescuentos);
            if (request.getParameter("clSucursalReddeDescuentos") != null) {
                strclSucursalReddeDescuentos = request.getParameter("clSucursalReddeDescuentos").toString();
            }

            //System.out.println("Sucursal "+strclSucursalReddeDescuentos);
            if (session.getAttribute("clModuloRedDescuentos") != null) {
                strclModuloRedDescuentos = session.getAttribute("clModuloRedDescuentos").toString();
            }

            // System.out.println("Mini Exp Modulo "+strclModuloRedDescuentos);
            UtileriasBDF.ejecutaSQLNP(" st_AsignaunaRed '" + strclReddeDescuentos + "','" + strclModuloRedDescuentos + "','" + strclSucursalReddeDescuentos + "'");
        %>
        <script>
            //top.opener.location.reload();
            top.opener.location.href='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>../../servlet/Utilerias.Lista?P=5030&Apartado=S';
            window.close();
        </script>
        
    </body>
</html>