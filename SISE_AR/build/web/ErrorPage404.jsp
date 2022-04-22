<%@page contentType="text/html" import="java.io.StringWriter,java.io.PrintWriter"   isErrorPage="true"%>
<html>
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
                background-image: url(<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>/Alert.png);
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
        <div class="divMsgAlert">Error en la página Web.</div>

        <%

                    //Exception Handler
                    //System.out.println("<<<<<<<<<<<<<<<<<<< ERROR 404 - SISE ARG - INICIO >>>>>>>>>>>>>>>>>>>");
                    try {
                        //<<<<<<<<<<<< Muestra Un error Interno >>>>>>>>>>>>
                        if (exception != null) {
                            System.out.println(exception.toString());
                        }

                        String StrUrl = "", StrStatusCode = "";

                        if (request.getAttribute("javax.servlet.forward.request_uri") != null) {
                            StrUrl = request.getAttribute("javax.servlet.forward.request_uri").toString();
                        }

                        if (request.getAttribute("javax.servlet.error.status_code") != null) {
                            StrStatusCode = request.getAttribute("javax.servlet.error.status_code").toString();
                        }

                        System.out.println("ERROR SISE ARG, "+StrStatusCode + ": " + StrUrl);



                    } catch (Exception e) {
                        System.out.println(e);
                    }
                    //System.out.println("<<<<<<<<<<<<<<<<<<< ERROR 404 - SISE ARG - FIN >>>>>>>>>>>>>>>>>>>");

        %>
    </body>
</html>
