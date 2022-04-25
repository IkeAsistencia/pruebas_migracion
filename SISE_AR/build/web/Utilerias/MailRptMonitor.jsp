<%@ page contentType="vnd.ms-excel" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>untitled</title>
  </head>
  <body class="cssBody">
  <center><table width="800">
    <tr valign="center">
      <td height="70" align="center" class="cssTituloPlasma" id="LabelMon" name="LabelMon" >Monitoreo de Correos</td>
    </tr>
  </table>
  </center>
<%
    String StrclUsrApp="0";
    
    
    if (session.getAttribute("clUsrApp")!= null){
        StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     } 
    
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %>Fuera de Horario<% return; 
     } 
    %>
    <%
    
    StringBuffer StrSql = new StringBuffer();
    StrSql.append(" Select top 100 SQLSentence Sentencia, U.Nombre Usuario, ");
    StrSql.append(" FechaSolicitud, FechaInicio, FechaFin, FechaEnvio ");
    StrSql.append(" from HDMailRptMonitor HDM ");
    StrSql.append(" inner join cUsrApp U on (HDM.clUsrApp = U.clUsrApp ) ");
    StrSql.append(" order by clMailRpt desc ");
    
    StringBuffer strSalida = new StringBuffer();
    UtileriasBDF.rsTableNP(StrSql.toString(),strSalida);
    %>
       <%=strSalida.toString()%>
    <%
    strSalida.delete(0,strSalida.length());
    StrSql.delete(0,StrSql.length());
    %>
  </body>
</html>
