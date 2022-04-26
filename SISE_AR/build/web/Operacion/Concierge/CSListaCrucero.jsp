<%-- 
    Document   : CSListaCrucero
    Created on : 3/01/2011, 06:17:18 PM
    Author     : rfernandez
--%>


    <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
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
       String StrclAsistencia = "0";

       if (session.getAttribute("clUsrApp")!= null) {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }


           if (request.getParameter("clAsistencia")!= null) {
            StrclAsistencia= request.getParameter("clAsistencia").toString();
        } else{
            if (session.getAttribute("clAsistencia")!= null) {
                StrclAsistencia= session.getAttribute("clAsistencia").toString();
            }
        }
%>


        <form id='Forma' name ='Forma'  action='CSCrucero.jsp?' method='post'>
        <input type='hidden' id='clAsistencia' name='clAsistencia' value='<%=StrclAsistencia%>'>
        
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px;'>
            <p><font color="navy" face="Arial" size="3" ><b><i> Lista del Crucero </i></b></font></p>
        </div>
        
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:50px;'>
        <%StringBuffer strSalidaW = new StringBuffer();
          UtileriasBDF.rsTableNP("st_CSObtenCrucero " + StrclAsistencia + "," + strclUsr, strSalidaW); %>
          
        <%=strSalidaW.toString()%>
        <%strSalidaW.delete(0,strSalidaW.length());%>
        </form>

<script>

        function fnVentanaEditarCrucero(clCrucero,clAsistencia,clUsrApp){

                parent.frames["AltaCrucero"].location.href='CSDetalleCrucero.jsp?clAsistencia='+clAsistencia+'&clUsrApp='+clUsrApp+'&clCrucero='+clCrucero, 'LlenaCrucero'
                }

</script>
<%
     StrclAsistencia=null;
%>
</body>
</html>
