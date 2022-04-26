<%@page contentType="text/html" pageEncoding="ISO-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF"  errorPage=""%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="refresh" content="5">
        <title>Alerta Chat App</title>
        <link href="StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <style type="text/css" >
            body{background-color:transparent;}
        </style>
    </head>

    <body>
        <%
            String strDisponible = "";
            String strLink = "";
            String strClusrApp = "0";
            String strPais = "";
            String StrTipoSISE = "1";   //  SISE1

            if (session.getAttribute("clUsrApp") != null) {
                strClusrApp = session.getAttribute("clUsrApp").toString();
            }

            //System.out.println("-------------------------- ENTRA APP--------------------------------");

            ResultSet rs = null;
            rs = UtileriasBDF.rsSQLNP("st_getChatDisponiblesApp  '" + strClusrApp + "'");
            if (rs.next()) {
                strDisponible = rs.getString("Disponibles");
                strPais = "AR";
                if (strClusrApp != null) {
                    //strLink = "http://app.ikeasistencia.com:8080/AppMovil/Utilerias/Chat/ChatCat.jsp?clUsrApp=" + strClusrApp + "&PS=" + strPais;
                    //strLink = "http://172.21.10.235:8080/AppMovil/Utilerias/Chat/ChatCat.jsp?clUsrApp=" + strClusrApp + "&PS=" + strPais + "&TS=" + StrTipoSISE; //  PRODUCCION, INDICA TIPO DE SISE
                    //strLink = "https://app.ikeasistencia.com/AppMovil/Utilerias/Chat/ChatCat.jsp?clUsrApp=" + strClusrApp + "&PS=" + strPais + "&TS=" + StrTipoSISE; //  PRODUCCION, INDICA TIPO DE SISE
                    //strLink = "http://200.66.87.228:8080/AppMovil/Utilerias/Chat/ChatCat.jsp?clUsrApp=" + strClusrApp + "&PS=" + strPais + "&TS=" + StrTipoSISE; //  actualizo 20151202
                    strLink = "http://172.21.10.236:8080/AppMovil/Utilerias/Chat/ChatCat.jsp?clUsrApp=" + strClusrApp + "&PS=" + strPais + "&TS=" + StrTipoSISE;
        %>            
        <center>
            <table>
                <tr>
                    <td>
                        <% if (!strDisponible.equalsIgnoreCase("0")) {%>
                <blink>
                    <img src='Imagenes/new_chat.png' alt='¡Chat entrante!' onclick="fnOpenChat('<%=strLink%>');" style="position:absolute; z-index:140; left:200px; top:-5px;"/>
                    <!--<bgsound SRC="Music/UTOPIA.WAV"/>-->
                </blink>
                <%}%>
                </td>
                </tr>
            </table>
        </center>
        <%} else {%>
        <center><p>SU SESIÓN EXPIRÓ. POR FAVOR INGRESE NUEVAMENTE!!!</p></center>
            <%}
                    strDisponible = null;
                    strLink = null;
                }
            rs.close();
            rs = null;

            %>

        <script type="text/javascript">
            //------------------------------------------------------------------------------
            function fnOpenChat(URL) {
                WinChat = window.open(URL, 'Chat', 'resizable=yes,scrollbars=yes,status=yes,width=930,height=570');
            }
            //------------------------------------------------------------------------------
            function fn_blink() {
                var blinks = document.getElementsByTagName('blink');
                for (var i = blinks.length - 1; i >= 0; i--) {
                    var s = blinks[i];
                    s.style.visibility = (s.style.visibility === 'visible') ? 'hidden' : 'visible';
                }
                window.setTimeout(fn_blink, 750); // FRECUENCIA DE PARPADEO DEL GLOBO DEL CHAT
            }
            //------------------------------------------------------------------------------
            if (document.addEventListener)
                document.addEventListener("DOMContentLoaded", fn_blink, false);
            else if (window.addEventListener)
                window.addEventListener("load", fn_blink, false);
            else if (window.attachEvent)
                window.attachEvent("onload", fn_blink);
            else
                window.onload = fn_blink;
            //------------------------------------------------------------------------------
        </script>
    </body>
</html>