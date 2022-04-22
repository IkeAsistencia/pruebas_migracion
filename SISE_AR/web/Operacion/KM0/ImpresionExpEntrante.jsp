<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>IMPRESION EXPEDIENTE TOMADO</title> 
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<%  
    String StrPag="";
    String StrSql="";    
    String StrclUsrApp="0";
    String StrclExpediente="0";
    String StrclPaginaWeb="0";
    String StrclProveedor="0";   
    
    

    int iCont=0;
  
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    
    if (request.getParameter("Expediente")!= null)   //expediente viene como parámetro aqui
     {
       StrclExpediente = request.getParameter("Expediente").toString();
     }        

    if (request.getParameter("Proveedor")!= null) 
     {
       StrclProveedor = request.getParameter("Proveedor").toString();
     }       

    StrclPaginaWeb = "214";        
    MyUtil.InicializaParametrosC(214,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
    session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
    
    ResultSet rs = UtileriasBDF.rsSQLNP( "sp_WebSolicitudServicioProv " + StrclUsrApp + "," + StrclExpediente + "," + StrclProveedor); 
    %>
    <form id='Forma' name ='Forma'  action='ImpresionExpEntrante.jsp?' method='get'>
    <%
    if (rs.next())
    { %>
        <table class='TTable'>
        <tr><th colspan=4>ASISTENCIA TOMADA EXITOSAMENTE!!!</th></tr><tr></tr><tr></tr>
      <%
	iCont = 2;
	while(9 > iCont){
            %>
	   <tr><td width='190'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td>
	   <%
	   iCont = iCont + 2;
           %>
	   <td width='120'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rs.getString(iCont-1)%></td></tr>
	   <%
	   iCont = iCont + 2;
	}
        // descripcion ocurrido	
            %>
	   <tr><td width='190'><%=rs.getString(iCont)%>: </td><td class='R1Table' colspan='3'><%=rs.getString(iCont-1)%></td></tr>
	   <%
	   iCont = iCont + 2;
           %>
           <tr></tr><tr></tr>
	   <tr><td colspan='4'>UBICACION DEL SINIESTRO: </td></tr>
	   <%
     	   iCont = 12;
	// calle ubicacion
           %>
	   <tr><td width='190'><%=rs.getString(iCont)%>: </td><td class='R1Table' colspan=3><%=rs.getString(iCont-1)%></td></tr>
	   <%
	   iCont = iCont + 2;
   	// referencias visuales
           %>
	   <tr><td width='190'><%=rs.getString(iCont)%>: </td><td class='R1Table' colspan='3'><%=rs.getString(iCont-1)%></td></tr>
	   <%
	   iCont = iCont + 2;
	// colonia
           %>
  	   <tr><td width='190'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td>
  	   <%
   	   iCont = iCont + 2;
	// municipio
           %>
	   <td width='110'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='270'><%=rs.getString(iCont-1)%></td></tr>
	   <%
   	   iCont = iCont + 2;
	// entidad
           %>
  	   <tr><td width='190'><%=rs.getString(iCont)%>: </td><td class='R1Table' colspan='3'><%=rs.getString(iCont-1)%></td></tr>
           <tr></tr><tr></tr>
	   <tr><td colspan='4'>TRANSPORTE INVOLUCRADO:</td></tr>
	   <%
           iCont = 22;
       // marca vehículo
           %>
	   <tr><td width='190'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td>
	   <%
   	   iCont = iCont + 2;
       // tipo
           %>
	   <td width='190'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td></tr>
	   <%
   	   iCont = iCont + 2;
       // modelo
           %>
	   <tr><td width='190'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td></tr>
	   <%
   	   iCont = iCont + 2;
       // destino
   	   iCont = iCont + 2;
            %>           
           <tr></tr><tr></tr>
	   <tr><td colspan='4'>TIEMPOS: </td></tr>
	   <%
	   iCont = 30;
	while(44 > iCont){
            %>
	   <tr><td width='190'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td>
	   <%
   	   iCont = iCont + 2; 
           %>
    	   <td width='190'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td></tr>
    	   <%
   	   iCont = iCont + 2; 
	}
           %>
	   <tr><td colspan='2'><td> &laquo &nbsp FIN DEL REPORTE &nbsp &raquo </td><td align='center'><input type='Button' class='cBtn' value='Imprimir' onclick='window.print();'></td></tr></table>
	   <%
     }
    else {
        %>
	<table><tr><td width='450'>LA &nbsp ASISTENCIA  &nbsp FUE &nbsp TOMADA &nbsp POR &nbsp OTRO &nbsp PROVEEDOR<br></td></tr></table>
	<%
    }
    %>
    </form>
    <%
    rs.close();
    rs=null;
    
    StrPag=null;
    StrSql=null;    
    StrclUsrApp=null;
    StrclExpediente=null;
    StrclPaginaWeb=null;
    StrclProveedor=null;   
%>

</body>
</html>
