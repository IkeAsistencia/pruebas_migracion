<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<%  
String StrclAcumulador="0";
String StrUltra="0";

 if (request.getParameter("clAcumulador")!= null)
 {
  StrclAcumulador = request.getParameter("clAcumulador").toString(); 
 }  
       

 StringBuffer strSql= new StringBuffer();
 strSql.append("Select ultra from cAcumulador where clAcumulador = ").append(StrclAcumulador);
 
 ResultSet rs = UtileriasBDF.rsSQLNP(strSql.toString());
 strSql.delete(0,strSql.length());
  
 if (rs.next())
 {
  StrUltra=rs.getString("ultra");
%>
 <script>top.opener.fnActualizaGarantia('<%=StrUltra%>')</script>
 <script>window.close();</script>
 <%}else{%>
  Error al Calcular los Montos
 <%}
 rs.close();
 rs=null;
 
 
      
%>
</body>
</html>