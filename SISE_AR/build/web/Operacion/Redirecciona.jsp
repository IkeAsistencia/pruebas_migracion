<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title></title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <%

            String strclusrapp = "";
            String StrClRedirecciona = "";
            String StrURL = "";

            if (session.getAttribute("clUsrApp") != null) {
                strclusrapp = session.getAttribute("clUsrApp").toString();
            }

            if (request.getParameter("clRedirecciona") != null) {
                StrClRedirecciona = request.getParameter("clRedirecciona");
            }

            if (StrClRedirecciona.equalsIgnoreCase("1")) {
                //StrURL = "http://200.66.87.228:8080/AppMovil/Utilerias/Chat/ChatCat.jsp?clUsrApp=" + strclusrapp + "&PS=AR&TS=1";
                StrURL = "https://app.ikeasistencia.com/AppMovil/Utilerias/Chat/ChatCat.jsp?clUsrApp=" + strclusrapp + "&PS=AR&TS=1";
            }
        %>

        <script>
            //location.href='<%=StrURL%>';
            window.open('<%=StrURL%>', 'Chat', 'resizable=yes,scrollbars=yes,status=yes,width=930,height=570');
        </script>
    </body>
    <%
        strclusrapp = null;
        StrClRedirecciona = null;
        StrURL = null;
    %>
</html>