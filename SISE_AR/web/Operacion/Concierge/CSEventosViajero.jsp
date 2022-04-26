<%-- 
    Document   : CSEventosViajero
    Created on : 17/12/2009, 04:31:23 PM
    Author     : rfernandez
--%>

<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>JSP Page</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
<body class="cssBody" onLoad="">

<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
<script src='../../Utilerias/Util.js' ></script>

<%
       String strclUsr = "0";
       String StrclConcierge = "0";

       if (session.getAttribute("clUsrApp")!= null) {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }

        if (request.getParameter("clConcierge")!= null) {
            StrclConcierge= request.getParameter("clConcierge").toString();
        } else{
            if (session.getAttribute("clConcierge")!= null) {
                StrclConcierge= session.getAttribute("clConcierge").toString();
            }
        }
%>

        <form id='Forma' name ='Forma'  action='CSViajero.jsp?' method='post'>
        <input type='hidden' id='clConcierge' name='clConcierge' value='<%=StrclConcierge%>'>
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px;'>
        <p><font color="navy" face="Arial" size="3" ><b><i> Perfil de Viajero</i></b>  <br>
        <input type='button' value='Agregar Viajero' onClick='{fnVentanaLlenaViajero(<%=StrclConcierge%>,<%=strclUsr%>)}' class='cBtn'></input>
        </p>
        </div>
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:50px;'>
        <%StringBuffer strSalidaV = new StringBuffer();
          System.out.println("st_ObtenViajeroConcierge " + StrclConcierge + "," + strclUsr);
          UtileriasBDF.rsTableNP("st_ObtenViajeroConcierge " + StrclConcierge + "," + strclUsr, strSalidaV);%>

        <%=strSalidaV.toString()%>
        <%strSalidaV.delete(0,strSalidaV.length());%>        
        </form>

<script>
function fnVentanaLlenaViajero(clConcierge,clUsrApp)
   {
        window.open('CSAltaEventoViajero.jsp?clConcierge=<%=StrclConcierge%>&clUsrApp=<%=strclUsr%>', 'LlenaViajero' ,'scrolling=yes, width= 900 ,height= 300');
   }

function fnVentanaEditarViajero(clCSViajero,clConcierge,clUsrApp)

   {
        window.open('CSAltaEventoViajero.jsp?clConcierge='+clConcierge+'&clCSViajero='+clCSViajero, 'LlenaViajero','scrolling=yes, width= 900 ,height= 300');
   }


</script>   
 <%
    //strSalidaV = null;
       StrclConcierge=null;
%>
 </html>
</body>