<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Vista de Publicaciones</title> 
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<%  
    String StrclUsrApp="0";
    String StrclExpediente="0";    
    String StrclPaginaWeb="0";
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
     
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %>Fuera de Horario<%
        return;
    }

    if (request.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = request.getAttribute("clExpediente").toString();  
     }      
        
     StrclPaginaWeb = "411";       
     MyUtil.InicializaParametrosC(411,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
 
    session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
    StringBuffer StrSql = new StringBuffer();
    StringBuffer StrSalida = new StringBuffer();
 
   // Obteniendo los envíos ya realizados para ese Expediente
    StrSql.append("sp_VistaPublicaciones ").append(StrclExpediente);
    UtileriasBDF.rsTableNP(StrSql.toString(),StrSalida);
  %>
        <%=StrSalida.toString()%>
    <%
    StrSalida.delete(0,StrSalida.length());
    StrSql.delete(0,StrSql.length());
    StrSql = null; 
    StrSalida = null;
    StrclUsrApp=null;
    StrclExpediente=null;    
    StrclPaginaWeb=null;
%>
</body>
</html>