<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>JSP Page</title> 
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <%
            String StrclExpediente = "0";

            if (request.getParameter("clExpediente") != null) {
                StrclExpediente = request.getParameter("clExpediente").toString();
            } else {
                if (session.getAttribute("clExpediente") != null) {
                    StrclExpediente = session.getAttribute("clExpediente").toString();
                }
            }
        %>

        <div class='VTable' style='position:absolute; z-index:35; left:17px; top:30px;'>
            <INPUT name ='btnProcesar' type='button' VALUE='Procesar' class='cBtn' onclick ='fnProcesa();'>
        </div>
        <br><br><br>
        <table>
            <tr>
                <td>
                    <% StringBuffer strSalida = new StringBuffer();

                        UtileriasBDF.rsTableNP("st_ListaCostosTmp " + StrclExpediente.toString(), strSalida);
                    %>   
                    <%=strSalida.toString()%>
                    <%strSalida.delete(0, strSalida.length());
                        strSalida = null;
                    %>
                </td>
            </tr>
        </table>

        <%
            StrclExpediente = null;
        %>
        <script>
            function fnProcesa() {
                window.open('EjecutaCostoTmp.jsp?Accion=P', '', 'resizable=yes,menubar=0,status=0,toolbar=0,screenY=100,height=200,width=400,scrollbars=1');
            }
        </script> 
    </body>
</html>