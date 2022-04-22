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
    String StrCodEnt ="0";
    String StrCodMD ="0";
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
    if (request.getParameter("CodEnt")!= null)
        {
             StrCodEnt = request.getParameter("CodEnt").toString().trim();
        }  
    
    if ( request.getParameter("CodMD")!= null)
        {
             StrCodMD = request.getParameter("CodMD").toString().trim();
        }  
    
    StrclPaginaWeb = "573";        
    MyUtil.InicializaParametrosC(573,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
    session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
    
    if ( request.getParameter("StrSP")!= null && request.getParameter("StrSP")!= "")
        {
           StrSql.delete(0,StrSql.length());
           StrSql.append(" sp_EnviaExpAProvxEnt '").append(StrCodEnt).append("','").append(StrCodMD).append("','").append(StrclExpediente).append("','").append(StrclUsrApp).append("'");
           UtileriasBDF.ejecutaSQLNP(StrSql.toString()) ;
%>         Publicación Exitosa!!!

<%
           return;
        }
    
    %>
        <form id='Forma' name ='Forma' action='ProveedoresEntidad.jsp?' method='get'>
        <INPUT id='StrSP' name='StrSP' type='hidden' value=''>
        <INPUT id='CodEnt' name='CodEnt' type='hidden' value='<%=StrCodEnt%>'>
        <INPUT id='CodMD' name='CodMD' type='hidden' value='<%=StrCodMD%>'>

        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px;'>
        <P align='left'><input type='button' value='PUBLICAR' onClick='fnPublicaProv()' class='cBtn'></input></p>
        <% StringBuffer strSalida = new StringBuffer();
        StrSql.append("sp_ProvxEnt '").append(StrCodEnt).append("','").append(StrCodMD).append("','").append(StrclExpediente).append("'");
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
     StrCodEnt =null;
     StrCodMD =null;
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