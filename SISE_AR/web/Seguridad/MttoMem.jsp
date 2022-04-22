<%@ page contentType="text/html;charset=windows-1252" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF"%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>Mtto Catálogos de Memoria</title>
  </head>
  <body>
<%
 String StrclUsrApp="0";
 try{
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     } 

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {%>
       Fuera de Horario
       <%return;  
     } 
%>
    <input type="button" onClick="fnReload('cbEntidad')" value="Entidades, Municipios y Colonias"><br>
    <input type="button" onClick="fnReload('cbAMIS')" value="Marcas y Tipos de Auto"><br>
    <input type="button" onClick="fnReload('')" value=""><br>
    <input type="button" onClick="fnReload('')" value=""><br>
    <input type="button" onClick="fnReload('')" value=""><br>
    
<%
  }catch(Exception e){
  }
%>
<script> 
  function fnReload(strClass){
    window.open("ReloadMem.jsp?class=cbEntidad","")
  }
</script>

  </body>
</html>
