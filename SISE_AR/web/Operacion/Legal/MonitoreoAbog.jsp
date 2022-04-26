<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title> 
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<%  
    String StrSql = ""; 
    String StrclUsrApp="0";
    String StrPlano ="0";
    String StrclExpediente="0";
    String StrclPaginaWeb="0";
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString();  
     }     

    StrclPaginaWeb = "217";        
    MyUtil.InicializaParametrosC(217,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
    session.setAttribute("clPaginaWebP",StrclPaginaWeb); %>
    
        <form id='Forma' name ='Forma'  action='MonitoreoAbog.jsp?' method='get'>  
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px;'>
        <P align='left'><input type='button' value='Monitorear Abogados' onClick='document.all.Forma.submit();' class='cBtn'></input></p>
        <table border='1'><tr ><td class='Rojo'>Más de 2 Hrs.</td><td class='Verde'>En cita 2 Hrs.</td><td class='Amarillo'>1 Hr.antes de cita</td><td class='Blanco'>Más de 1 Hr. antes</td><td>   </td><td>   </td><td>   </td><td class='Blanco'>Click en Monitorear para actualizar</td></tr></table>
        <%StringBuffer strSalida = new StringBuffer();
          UtileriasBDF.rsTableGRNP("sp_ListaMonitorAbog ", strSalida);
        %>        
        <%=strSalida.toString()%>
        <%strSalida.delete(0,strSalida.length());
        strSalida = null;%>
        </form><%
        
     StrSql = null; 
     StrclUsrApp=null;
     StrPlano =null;
     StrclExpediente=null;
     StrclPaginaWeb=null;
     
        
%>
<script>
/*	timeM =0;
	Actualizar = 1;
	function dnSetTimeM(){
	   timeM = timeM + 1;
	   if (timeM == 150) {
		  if (Actualizar == 1) {
   		     location.reload();
		  }
	   }
	   setTimeout('dnSetTimeM()',100);
	}
	dnSetTimeM();*/
</script> 
</body>
</html>
