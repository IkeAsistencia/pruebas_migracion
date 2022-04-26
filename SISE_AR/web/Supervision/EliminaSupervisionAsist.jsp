<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>
            Elimina Supervision Asistencia
        </title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">

        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js' ></script>
        <%
        StringBuffer StrSql = new StringBuffer();
        String StrclUsrApp = "0";
        String StrclAsistencia = "0";
        String StrclSupervision = "0";
        String StrclQuejaxSupervision = "0";
        String StrclDeficienciaxAsistencia = "0";

        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if (session.getAttribute("clAsistencia")!= null) {
            StrclAsistencia = session.getAttribute("clAsistencia").toString();
        }

        if ( request.getParameter("clSupervision")!= null) {
            StrclSupervision = request.getParameter("clSupervision").toString().trim();
        }

        if ( request.getParameter("clQuejaxSupervision")!= null) {
            StrclQuejaxSupervision = request.getParameter("clQuejaxSupervision").toString().trim();
        }

        if ( request.getParameter("clDeficienciaxAsistencia")!= null) {
            StrclDeficienciaxAsistencia = request.getParameter("clDeficienciaxAsistencia").toString().trim();
        }

        if (StrclAsistencia !="0") {
            StrSql.append(" st_SCSeliminasupervisionAsist ").append(StrclUsrApp).append(",").append(StrclAsistencia).append(",").append(StrclSupervision).append(",").append(StrclQuejaxSupervision).append(",").append(StrclDeficienciaxAsistencia);
            System.out.println("StrSql      "+StrSql);
            UtileriasBDF.ejecutaSQLNP(StrSql.toString());

            if (StrclSupervision !="0") { %>
                <script>
                        location.href='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>../servlet/Utilerias.Lista?P=6109&Apartado=S';
                </script>
        <%
            }
            if (StrclQuejaxSupervision !="0") { %>
                <script>
                        location.href='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>../servlet/Utilerias.Lista?P=6114&Apartado=S';
                </script>
        <% }
            if (StrclDeficienciaxAsistencia !="0") { %>
                <script>
                        location.href='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>../servlet/Utilerias.Lista?P=6112&Apartado=S';
                </script>
        <%
        }

        }else{
        %>Debe elejir una asistencia<%
        }
        StrSql.delete(0,StrSql.length());
        StrclUsrApp = null;
        StrclAsistencia = null;
        StrclSupervision = null;
        StrclQuejaxSupervision = null;
        StrclDeficienciaxAsistencia = null;
        %>
    </body>
</html>