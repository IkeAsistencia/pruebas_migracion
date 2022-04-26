<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>Lista de Eventos</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onLoad="">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js' ></script>
        <%
                String strclUsr = "0";
                String StrclConcierge = "0";

                if (session.getAttribute("clUsrApp") != null) {
                    strclUsr = session.getAttribute("clUsrApp").toString();
                }

                if (request.getParameter("clConcierge") != null) {
                    StrclConcierge = request.getParameter("clConcierge").toString();
                } else {
                    if (session.getAttribute("clConcierge") != null) {
                        StrclConcierge = session.getAttribute("clConcierge").toString();
                    }
                }

        %>      <form id='Forma' name ='Forma'  action='CSWows.jsp?' method='post'>
            <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px; right:10px;'>
                <p align="center"><font color="navy" face="Arial" size="2" ><b><i>Eventos</i></b></font><br>
                </p>
            </div>
            <div class='VTable' style='position:absolute; z-index:25; left:10px; top:30px;'>
                <%StringBuffer strSalida = new StringBuffer();

                        UtileriasBDF.rsTableNP("st_CSListaAsistenciasxNU " + StrclConcierge, strSalida);
                %>
                <%=strSalida.toString()%>
                <%strSalida.delete(0, strSalida.length());
                %>
            </div>
        </form>


        <script>   </script>
        <%
                strSalida = null;
                StrclConcierge = null;
        %>

    </body>
</html>
