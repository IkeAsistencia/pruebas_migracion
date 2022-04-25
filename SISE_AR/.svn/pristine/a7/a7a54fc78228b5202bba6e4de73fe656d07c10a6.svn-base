<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>Lista de Eventos</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onLoad="fnalertaTUC1();fnMsjTUC();">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js' ></script>
        <%
                String StrclConcierge = "0";
                String StrclCuenta = "0";
                String StrclTUC = "0";
                String StrdsTUC = "";

                if (request.getParameter("clConcierge") != null) {
                    StrclConcierge = request.getParameter("clConcierge").toString();
                } else {
                    if (session.getAttribute("clConcierge") != null) {
                        StrclConcierge = session.getAttribute("clConcierge").toString();
                    }
                }
                
                if (request.getParameter("clCuenta") != null) {
                    StrclCuenta = request.getParameter("clCuenta").toString();
                } else {
                    if (session.getAttribute("clCuenta") != null) {
                        StrclCuenta = session.getAttribute("clCuenta").toString();
                    }
                }
                
                if (request.getParameter("clTipoUsConcierge") != null) {
                    StrclTUC = request.getParameter("clTipoUsConcierge").toString();
                } else {
                    if (session.getAttribute("clTipoUsConcierge") != null) {
                        StrclTUC = session.getAttribute("clTipoUsConcierge").toString();
                    }
                }            
                
                if (request.getParameter("dsTUC") != null) {
                    StrdsTUC = request.getParameter("dsTUC").toString();
                } else {
                    if (session.getAttribute("dsTUC") != null) {
                        StrdsTUC = session.getAttribute("dsTUC").toString();
                    }
                }
                        //System.out.println("st_CSListaEventos '" + StrclCuenta + "','" + StrclConcierge + "'");
%>

        <form id='Forma' name ='Forma'  action='' method='post'>
            <INPUT id='StrdsTUC' name='StrdsTUC' type='hidden' value="<%=StrdsTUC%>">
            <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px;'>
                <p align="center"><font color="navy" face="Arial" size="2" ><b><i>Eventos Disponibles</i></b></font><br></p>
            </div>
            <div id="alertaTUC" style='position:absolute; z-index:26; left:230px; top:10px; visibility:hidden'>
                <p align="center"><font face="Arial" size="2" ><b>USUARIO <%=StrdsTUC%></b></font></p>
            </div>
            <div class='VTable' style='position:absolute; z-index:25; left:10px; top:30px;'>
                <%
                        StringBuffer strSalida = new StringBuffer();
                        UtileriasBDF.rsTableNP("st_CSListaEventos '" + StrclCuenta + "','" + StrclConcierge + "'", strSalida);
                %>
                <%=strSalida.toString()%>
                <%strSalida.delete(0, strSalida.length());
                %>
            </div>
        </form>
        <script>

                function fnMsjTUC(){
                   if(<%=StrclTUC%> != ''){
                       alert("USUARIO: " + document.all.StrdsTUC.value);
                   }
                }

            	function fnalertaTUC1(){
                    if(<%=StrclTUC%> != ''){
                          document.all.alertaTUC.style.visibility = 'visible';
                          document.all.alertaTUC.style.color="red"
                          setTimeout("fnalertaTUC2()",500)
                    }
                }

                function fnalertaTUC2(){
                     document.all.alertaTUC.style.color="32CD32"
                     setTimeout("fnalertaTUC1()",500)
                }

        </script>
        <%
                strSalida = null;
                StrclConcierge = null;
        %>
    </body>
</html>
