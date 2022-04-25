<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">


<%  
    	String strClave = "";
        StringBuffer strSql= new StringBuffer(); 

      if (request.getParameter("strSQL")!= null)
      	{
            strSql.append(request.getParameter("strSQL").toString()); 
       	}  

     if (request.getParameter("Clave")!= null)
     	{
            strClave= request.getParameter("Clave").toString().trim(); 
       	}  
       
      strSql.append(strSql).append(" '").append(strClave).append("'");
      ResultSet rs = UtileriasBDF.rsSQLNP( strSql.toString());
      strSql.delete(0,strSql.length());
      
      if (rs.next()) {
          rs.last();
          if (rs.getRow()>1){
             %>
              <% StringBuffer strSalida = new StringBuffer();
               UtileriasBDF.rsTableNP(strSql.toString(),strSalida);
              %><%=strSalida.toString()%><%
              strSalida.delete(0,strSalida.length());
              strSalida=null;
         }else{
           %><script><%=rs.getString("Cuenta").substring(21,rs.getString("Cuenta").indexOf('"',10))%></script>
           <%
          }    
      }else{
        %><script>top.opener.fnActualizaDatosCuenta('','','');window.close();</script>
        <%
      } 
      rs.close();
      rs = null;
      

%>

</body>
</html>

