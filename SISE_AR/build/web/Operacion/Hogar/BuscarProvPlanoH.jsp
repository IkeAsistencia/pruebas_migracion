<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Utilerias.UtileriasBDF,java.sql.ResultSet" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Busca proveedor hogar por plano</title> 
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

    StrclPaginaWeb = "761";        
    MyUtil.InicializaParametrosC(761,Integer.parseInt(StrclUsrApp)); 
    session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
    %>
        <form target='proveedoresH' id='Forma' name ='Forma'  action='ProveedoresDireccionH.jsp?' method='get'>
    
        <%=MyUtil.ObjInput("PROVEEDORES DEL PLANO","Plano","",true,true,10,30,"",true,true,10,"EsNumerico(document.all.Plano)")%>
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px;'>
        <P align='left'><input type='button' value='BUSCAR' onClick='fnBuscaProvPlanoH()' class='cBtn'></input></p>
        </form>
    <%    
     StrSql = null; 
     StrclUsrApp=null;
     StrPlano =null;
     StrclExpediente=null;
     StrclPaginaWeb=null;
     
%>
<script>
document.all.Plano.readOnly=false;
function fnBuscaProvPlanoH()
{ 
    document.all.Forma.submit();
}
</script>
</body>
</html>
