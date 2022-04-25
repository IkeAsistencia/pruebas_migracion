<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<script src='../../Utilerias/Util.js' ></script>

<%  
    String StrclExpediente="0";
    String StrCoberturaSeleccionada="0";
    
    
    

    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     }  
    
    if (request.getParameter("CoberturaSeleccionada")!= null)
     {
       StrCoberturaSeleccionada = request.getParameter("CoberturaSeleccionada").toString(); 
     }  


    StringBuffer StrSql1 = new StringBuffer();
    StrSql1.append(" Insert into CobxExpediente");
    StrSql1.append(" Select ").append(StrclExpediente).append(" as clExpediente,clGpoCob as clGpoCob,clPrefijo as clPrefijo from cCoberturaSB ");
    StrSql1.append(" where clPrefijo in(").append(StrCoberturaSeleccionada).append(")");
    
    try{
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());
        %>
            <script>window.close();</script>
        <%
    }catch(Exception e){
        e.printStackTrace();
    }
%>
<%          
    StrSql1.delete(0,StrSql1.length());
    //rs=null;
    StrSql1=null;
    
    StrclExpediente=null;
    StrCoberturaSeleccionada=null;
%>   
</body>
</html>