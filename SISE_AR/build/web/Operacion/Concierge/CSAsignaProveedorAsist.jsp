<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title>Asignar Proveedor</title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<%
   String StrclAsistencia="0";
   String StrclProveedor="0";
   String StrclConcierge="0";
   String StrclSubservicio="0";
   String StrclUsrApp="0";
   
        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp= session.getAttribute("clUsrApp").toString();
        } 
   
        if (request.getParameter("clAsistencia")!= null) {
            StrclAsistencia= request.getParameter("clAsistencia").toString();
        } 
   
        if (request.getParameter("clProveedor")!= null) {
            StrclProveedor= request.getParameter("clProveedor").toString();
        } 
   
        if (session.getAttribute("clConcierge")!= null) {
            StrclConcierge= session.getAttribute("clConcierge").toString();
        } 

        if (session.getAttribute("clSubservicio")!= null) {
            StrclSubservicio= session.getAttribute("clSubservicio").toString();
        } 
   
            StringBuffer StrSql2 = new StringBuffer();
            
            StrSql2.append("st_CSInsertReferencia ").append(StrclAsistencia).append(",").append(StrclProveedor).append(",").append(StrclUsrApp);
            System.out.println(StrSql2);            
            UtileriasBDF.ejecutaSQLNP(StrSql2.toString());
            StrSql2.delete(0,StrSql2.length());
            
%>
    <script>top.opener.location.reload();
            window.close();</script>
            <%  
            StrclAsistencia=null;
            StrclProveedor=null;
            StrSql2=null;
%>    
    </body>
</html>

  