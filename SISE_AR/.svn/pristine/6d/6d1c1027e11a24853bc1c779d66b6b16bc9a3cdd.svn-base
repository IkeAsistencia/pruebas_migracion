<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title>Borrar Acumuladores por Expediente</title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<%
   String StrVencimiento="0";
   
           if (request.getParameter("Vencimiento")!=null)
           {
            StrVencimiento = request.getParameter("Vencimiento");
           }
            StringBuffer StrSql = new StringBuffer();
            
            StrSql.append("set dateformat ymd");
            StrSql.append(" select case when ISDATE('").append(StrVencimiento).append("') = 1 then (select case when datediff(month,getdate(),'").append(StrVencimiento).append("')< 0 THEN 0 ELSE 1 END) else 0 END 'RESP'");
            
            ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
            StrSql.delete(0,StrSql.length());
            
            if (rs.next()){
%>
    <script>top.opener.fnVencimiento(<%=rs.getString("Resp")%>); window.close();</script>
    <% } 
        
        StrSql=null;
        rs.close();
        rs=null;%>
    </body>
</html>
