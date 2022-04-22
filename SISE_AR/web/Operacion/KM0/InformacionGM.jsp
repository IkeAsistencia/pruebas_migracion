<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<title>Bitácora de Expediente</title>
</head>
<script src='Utilerias/Util.js'></script>

<%
    String StrclUsrApp="0";
    String StrclConcesionarioGM="0";

    if (session.getAttribute("clUsrApp")!= null){
        StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     } 

    if (request.getParameter("clConcesionarioGM")!= null){
        StrclConcesionarioGM = request.getParameter("clConcesionarioGM").toString(); 
     } 

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
        StrclUsrApp=null;
        StrclConcesionarioGM=null;
        return; 
     } 
     
    %><body class='cssBody' topmargin='10'>
<p class='cssTitDet'>Marca de Vehiculos por Concesionario</p>
<% 
    StringBuffer strSql = new StringBuffer();
    StringBuffer strSalida = new StringBuffer();
   UtileriasBDF.rsTableNP(strSql.append("st_InformacionMarcaGM ").append(StrclConcesionarioGM).toString(), strSalida);
%><%=strSalida.toString()%><%
   strSql.delete(0,strSql.length());
   strSalida.delete(0,strSalida.length());
%>
</table>
<%
   strSalida = null;
   strSql=null;
   StrclUsrApp=null;
   StrclConcesionarioGM=null;

%>
</table>

</body>
</html>
