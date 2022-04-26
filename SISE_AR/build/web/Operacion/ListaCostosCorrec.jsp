<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title> 
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<%  
    String StrclUsrApp="0";
    String StrclExpediente="0";
    String StrclPaginaWeb="0";
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
     
     if (request.getParameter("clExpediente")!= null)
     {
       StrclExpediente= request.getParameter("clExpediente").toString(); 
     }   
     
    StrclPaginaWeb = "434";        
    MyUtil.InicializaParametrosC(434,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
    session.setAttribute("clPaginaWebP",StrclPaginaWeb); %>

        <table border='1' class='title'><tr><td>COSTOS DEL EXPEDIENTE AUN NO PAGADOS EN ALIX</td></tr></table><br><br>
        <table><tr><td>
        <% StringBuffer strSalida = new StringBuffer();
        
        UtileriasBDF.rsTableNP("sp_ListaCostosCorrec " + StrclExpediente.toString(),strSalida);
        %>   
        <%=strSalida.toString()%>
        <%strSalida.delete(0,strSalida.length());
        strSalida = null;
        %>
        </td></tr></table>
 
    <%   
     StrclUsrApp=null;
     StrclExpediente=null;
     StrclPaginaWeb=null;
     
        
%>
<script>
</script> 
</body>
</html>
