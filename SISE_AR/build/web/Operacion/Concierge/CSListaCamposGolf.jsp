<%-- 
    Document   : CSListaCamposGolf
    Created on : 29/08/2011, 12:15:51 PM
    Author     : rfernandez
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Lista de Campos de Golf</title>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody" onLoad="">

<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
<script src='../../Utilerias/Util.js' ></script>

<%
       String strclUsr = "0";
       String StrclConcierge = "0";
       String StrclAsistencia = "0";

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
       if (session.getAttribute("clAsistencia")!= null) {
            StrclAsistencia = session.getAttribute("clAsistencia").toString();
        }

   %>

        <form id='Forma' name ='Forma'  action='' method='post'>
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px;'>
        <p align="center"><font color="navy" face="Arial" size="2" ><b><i>Campos Disponibles</i></b>  <br>
        </p>
        </div>
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:30px;'>
        <%StringBuffer strSalida = new StringBuffer();

           System.out.println("st_CSListaCamposGolf '"+ StrclAsistencia+"','"+ StrclConcierge +"'");
          UtileriasBDF.rsTableNP("st_CSListaCamposGolf '"+ StrclAsistencia + "','" + StrclConcierge +"'", strSalida);
        %>
        <%=strSalida.toString()%>
        <%strSalida.delete(0,strSalida.length());
        %>
        </form>


 <%
    strSalida = null;
     StrclConcierge=null;
%>

<SCRIPT>

    function fnAsignaCampo(clCampo, Campo, Semestre){
         if(confirm("¿Desea asiganar el campo "+Campo+"? ")==true ){
                var pstrCadena = "CSCampoxAsistencia.jsp?clGolfProgram="+clCampo;
                pstrCadena = pstrCadena+"&Semestre="+Semestre;
                window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
         }
         else {
            location.reload();
         }
    }


    function fnActualizaCampos (){

        location.reload();

    }

    function fnAbrirCampoGolf(clGolfProgram){
         var pstrCadena = "InfoCampoGolf.jsp?clGolfProgram="+clGolfProgram;
         window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=650,height=600,top=0,left=0');

    }


</SCRIPT>


</body>
</html>
