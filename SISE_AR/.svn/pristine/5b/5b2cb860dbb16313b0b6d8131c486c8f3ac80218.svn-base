<%-- 
    Document   : CSEventosPreferencia
    Created on : 17/12/2009, 05:44:22 PM
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

        <form id='Forma' name ='Forma'  action='CSPreferencia.jsp?' method='post'>
        <input type='hidden' id='clConcierge' name='clConcierge' value='<%=StrclConcierge%>'>
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px;'>
        <p><font color="navy" face="Arial" size="3" ><b><i> Perfil de Preferencia</i></b>  <br>
        <input type='button' value='Agregar Preferencia' onClick='{fnVentanaLlenaPreferencia(<%=StrclConcierge%>,<%=strclUsr%>)}' class='cBtn'></input>
        </p>
        </div>
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:50px;'>
        <%StringBuffer strSalidaP = new StringBuffer();
          System.out.println("st_ObtenPreferenciaConcierge " + StrclConcierge + "," + strclUsr);
          UtileriasBDF.rsTableNP("st_ObtenPreferenciaConcierge " + StrclConcierge + "," + strclUsr, strSalidaP);%>

        <%=strSalidaP.toString()%>
        <%strSalidaP.delete(0,strSalidaP.length());%>

        </form>
<script>
function fnVentanaLlenaPreferencia(clConcierge,clUsrApp)
   {
        window.open('CSAltaEventoPreferencia.jsp?clConcierge=<%=StrclConcierge%>&clUsrApp=<%=strclUsr%>', 'LlenaPreferencia' ,'scrolling=yes, width= 700 ,height= 200');
   }

function fnVentanaEditarPreferencia(clCSHistoricoP,clConcierge,clUsrApp)
   {
        window.open('CSAltaEventoPreferencia.jsp?clConcierge='+clConcierge+'&clUsrApp='+clUsrApp+'&clCSHistoricoP='+clCSHistoricoP, 'LlenaPreferencia' ,'scrolling=yes, width= 700 ,height= 200');
   }

</script>
<%
   //strSalidaP = null;
      StrclConcierge=null;
%>
 </html>
</body>