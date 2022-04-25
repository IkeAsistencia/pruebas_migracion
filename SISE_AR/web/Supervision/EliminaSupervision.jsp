<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Elimina Supervision</title> 
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">

        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>

        <%

            StringBuffer StrSql = new StringBuffer();
            String StrclUsrApp = "0";
            String StrclExpediente = "0";
            String StrclSupervision = "0";
            String StrclQuejaxSupervision = "0";
            String StrclDeficienciaxExpediente = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            if (request.getParameter("clSupervision") != null) {
                StrclSupervision = request.getParameter("clSupervision").toString().trim();
            }

            if (request.getParameter("clQuejaxSupervision") != null) {
                StrclQuejaxSupervision = request.getParameter("clQuejaxSupervision").toString().trim();
            }

            if (request.getParameter("clDeficienciaxExpediente") != null) {
                StrclDeficienciaxExpediente = request.getParameter("clDeficienciaxExpediente").toString().trim();
            }

            if (StrclExpediente != "0") {
                StrSql.append(" sp_EliminaSupervision ").append(StrclUsrApp).append(",").append(StrclExpediente).append(",").append(StrclSupervision).append(",").append(StrclQuejaxSupervision).append(",").append(StrclDeficienciaxExpediente);
                System.out.println(StrSql);
                UtileriasBDF.ejecutaSQLNP(StrSql.toString());

                if (StrclSupervision != "0") {
        %><script>
            location.href = '<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>../servlet/Utilerias.Lista?P=289&Apartado=S';
        </script>                                                                                                
        <%
            }

            if (StrclQuejaxSupervision != "0") {
        %><script>
            location.href = '<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>../servlet/Utilerias.Lista?P=335&Apartado=S';
        </script>
        <%
            }

            if (StrclDeficienciaxExpediente != "0") {
        %><script>
            location.href = '<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>../servlet/Utilerias.Lista?P=294&Apartado=S';
        </script>
        <%
                }

            }
            StrSql.delete(0, StrSql.length());
            StrclUsrApp = null;
            StrclExpediente = null;
            StrclSupervision = null;
            StrclQuejaxSupervision = null;
            StrclDeficienciaxExpediente = null;

        %>
    </body>
</html>
