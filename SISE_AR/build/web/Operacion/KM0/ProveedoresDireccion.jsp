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
    StringBuffer StrSql = new StringBuffer(); 
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
    if ( request.getParameter("Plano")!= null)
        {
             StrPlano = request.getParameter("Plano").toString().trim();
        }  
    
    StrclPaginaWeb = "188";        
    MyUtil.InicializaParametrosC(188,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
    session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
    
    if ( request.getParameter("StrSP")!= null && request.getParameter("StrSP")!= "")
        {
           StrSql.delete(0,StrSql.length());
           StrSql.append(" sp_EnviaExpAProv '").append(StrPlano).append("','").append(StrclExpediente).append("','").append(StrclUsrApp).append("'");
           UtileriasBDF.ejecutaSQLNP(StrSql.toString()) ;
        }
    %>
        <form id='Forma' name ='Forma' action='ProveedoresDireccion.jsp?' method='get'>
        <INPUT id='Plano' name='Plano' type='hidden' value='<%=StrPlano%>'>
        <INPUT id='StrSP' name='StrSP' type='hidden' value=''>

        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px;'>
        <P align='left'><input type='button' value='PUBLICAR' onClick='fnPublicaProv()' class='cBtn'></input></p>
        <% StringBuffer strSalida = new StringBuffer();
        StrSql.append("sp_ProvxPlano '").append(StrPlano).append("','").append(StrclExpediente).append("'");
        UtileriasBDF.rsTableNP(StrSql.toString(), strSalida);%>
        <%=strSalida.toString()%>
        <%StrSql.delete(0,StrSql.length());
        strSalida.delete(0,strSalida.length());
        %>
        <%=MyUtil.GeneraScripts()%>
        </form>
      <%
     StrSql = null; 
     strSalida=null;
     StrclUsrApp=null;
     StrPlano =null;
     StrclExpediente=null;
     StrclPaginaWeb=null;
     
%>
<script>
function fnPublicaProv()
{ 
    document.all.StrSP.value='PUBLICA';
    document.all.Forma.submit();
}

</script>
</body>
</html>