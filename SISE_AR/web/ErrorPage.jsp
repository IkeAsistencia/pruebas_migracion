<%@page contentType="text/html" import="java.io.StringWriter,java.io.PrintWriter"   isErrorPage="true"%>
<html>
    <%
        String StrXSS = "0";

        if (session.getAttribute("XSS") != null) {
            StrXSS = session.getAttribute("XSS").toString();
        }
    %>

    <head>
        <title>Error Página Web</title>
        <style>
            .ErrorP{
                font-family: Verdana, Arial, Helvetica, sans-serif;
                color: #062F67;
                font-size: 18px;
                font-weight: bold;
            }

            .divAlert {
                position: absolute;
                left: 50%;
                top: 100px;
                width: 550px;
                height: 355px;
                margin-top: -90px;
                margin-left: -273px;
                overflow: auto;
                background-image: url(<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>Imagenes/Alert.png);
                background-repeat: no-repeat;
            }

            .divMsgAlert {
                position: absolute;
                left: 50%;
                top: 320px;
                width: 200px;
                height: 100px;
                margin-top: -140px;
                margin-left: -100px;
                overflow: auto;
                font-family: Verdana, Arial, Helvetica, sans-serif;
                color: #CC0000;
                font-weight: bold;
                font-size: 12px;
                text-transform: uppercase;
                z-index:2;
                text-align: center;
            }
        </style>
    </head>
    <body bgcolor="#ecf2f9">

        <div class="divAlert"></div>
        <% if (session.getAttribute("clUsrApp") != null) {
         System.out.println("sesion error: " + session.getAttribute("clUsrApp") );    
        %>
        
        <div class="divMsgAlert">Error en la página Web.</div>
        <% } else {
        System.out.println("sesion expira: " + session.getAttribute("clUsrApp") );
        %>
        <div class="divMsgAlert">SU SESIÓN EXPIRÓ.</div>
        <% }%>

        <%
        System.out.println("<<<<<<<<<<<<<<<<<<< ERROR 500 - SISE ARG - INICIO >>>>>>>>>>>>>>>>>>>");
        try {
            //<<<<<<<<<<<< Muestra Un error Interno >>>>>>>>>>>>
            if (exception != null) {
                System.out.println(exception.toString());
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            if (session.getAttribute("XSS") != null) {
                session.removeAttribute("XSS");
            }
        }
        System.out.println("<<<<<<<<<<<<<<<<<<< ERROR 500 - SISE ARG - FIN >>>>>>>>>>>>>>>>>>>");

        %>
    </body>
</html>
