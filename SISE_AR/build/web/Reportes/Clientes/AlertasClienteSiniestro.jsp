<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<title>Bitácora de Expediente</title>
</head>
<script src='../../Utilerias/Util.js'></script>

<%
    String StrclUsrApp="0";
    String StrclSubservicio="0";
    String StrclProceso="0";
    String StrCodEnt=" ";
    String StrTitulo="";
    String strTiempoLlegada="";
    StringBuffer StrSql = new StringBuffer();

    if (session.getAttribute("clUsrApp")!= null){
        StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     } 

  
    
    if (request.getParameter("clSubservicio")!= null)
     {
       StrclSubservicio = request.getParameter("clSubservicio").toString(); 
     } 
      
     
     if (request.getParameter("clProceso")!= null)
     {
       StrclProceso = request.getParameter("clProceso").toString(); 
     } 
     
     
     if (request.getParameter("CodEnt")!= null)
     {
       StrCodEnt = request.getParameter("CodEnt").toString(); 
     } 
     
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
        StrclUsrApp=null;
        return; 
     } 
     
      if (StrclProceso.equalsIgnoreCase("2")){
		StrTitulo = "Servicios Terminados en las Últimas 48 Horas";
    }else{
      StrTitulo = "Servicios Abiertos";
    }
    
    StrSql.append(" sp_AlertasClienteProm '").append(StrclSubservicio).append("','").append(StrclProceso).append("'");
    ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
    if (rs.next()) { 
          strTiempoLlegada = rs.getString("TiempoLlegada");
      }
    rs.close();
    rs=null;
         
    /* out.println(StrclSubservicio);
     out.println(StrclProceso);
     out.println(StrCodEnt);
     out.println(strTiempoLlegada);*/
     
    %>
   <table cellspacing=5 bgcolor="#c3d3fd">
			<tr class="cssSubTitle" >
					<td colspan="2">Resumen</td>
			</tr>
			<tr class="cssSubTitle"><td >Tiempo Promedio <br> de Llegada (min)</td><td>'<%=strTiempoLlegada%>'</td></tr>
	    <table><br><br>
    
    
    <body class='cssBody' topmargin='10'>
<p class='cssTitDet'><%= StrTitulo %></p>
        <% StringBuffer strSalida = new StringBuffer();
        UtileriasBDF.rsTableNP( "sp_AlertasCliente '" + StrclSubservicio + "','" + StrclProceso + "','" + StrCodEnt + "'",strSalida);
        %>
        <%=strSalida.length()%>
        <%strSalida.delete(0,strSalida.length());
        strSalida = null;
        %>

</table>
<%
    StrclUsrApp=null;
    StrclSubservicio=null;
    StrclProceso=null;
    StrCodEnt=null;
    strTiempoLlegada=null;


%>


</body>
</html>
