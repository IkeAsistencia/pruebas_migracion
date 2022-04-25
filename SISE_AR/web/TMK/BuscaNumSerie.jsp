<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Número de Serie</title> 
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody" onLoad="fnSumaMonto();">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<script>
top.document.all.rightPO.rows="70,*";
</script>
<%

    String StrNumSerie="0";
    
    if (request.getParameter("NumSerie")!= null)
     {
       StrNumSerie = request.getParameter("NumSerie").toString(); 
     }  %>

        <form id='Forma' name ='Forma'  action='CarritoAcumulador.jsp?' method='post'>  
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px;'>
        
        <%StringBuffer strSalida = new StringBuffer();
          UtileriasBDF.rsTableNP("sp_BuscaNumSerie '" + StrNumSerie + "'", strSalida);
        %>        
        <%=strSalida.toString()%>
        <%strSalida.delete(0,strSalida.length());
        strSalida = null;%>
       </div>
        </form>        
 <%

     StrNumSerie=null;
%>  

<script>
   
function fnProveeNumSerie(FechaCompra,NumSerie,dsAcumulador,Ultra){
        top.opener.fnProveeNumSerie(FechaCompra,NumSerie,dsAcumulador,Ultra);
        window.close();
}
</script> 
</body>
</html>
