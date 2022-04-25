<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">


<%  
    	String strNoSerie = "";
        String strStore="";
        String numSerie="";
        StringBuffer strSql= new StringBuffer(); 
        
   
      if (request.getParameter("strSQL")!= null)
      	{
           strStore=request.getParameter("strSQL").toString(); 
       	}  

     if (request.getParameter("NoSerie")!= null)
     	{
            strNoSerie= request.getParameter("NoSerie").toString().trim(); 
       	}  
       
      strSql.append(strStore).append(" '").append(strNoSerie).append("'");
      System.out.println("Qry: "+strSql.toString());
      ResultSet rs = UtileriasBDF.rsSQLNP( strSql.toString());
      strSql.delete(0,strSql.length());
      
      if (rs.next()) {
          
          numSerie=rs.getString(1);
          if(numSerie.equalsIgnoreCase("1")){
              
             %><script>top.opener.fnExisteNoSerie();</script>   
         <% }          
          
        %><script>window.close();</script>
        <%
      } 
      rs.close();
      rs = null;
      strStore=null;
      strNoSerie=null;
      numSerie=null;
      

%>

</body>
</html>
