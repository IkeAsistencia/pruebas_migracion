<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">

<%  
    	String strclExpediente = "0";
    	String strclProveedor = "0";
    	String strclConcepto = "0";
        String strclTarifa ="0";
        String strClave ="";
    
    

      	if (session.getAttribute("clExpediente")!= null)
      	{
             strclExpediente = session.getAttribute("clExpediente").toString();
        }  
        
      	if (request.getParameter("clProveedor")!= null)
      	{
            strclProveedor= request.getParameter("clProveedor").toString(); 
       	}  
        
       	if (request.getParameter("clConcepto")!= null)
      	{
            strclConcepto = request.getParameter("clConcepto").toString(); 
       	}  

       	if (request.getParameter("clTarifa")!= null)
      	{
            strclTarifa = request.getParameter("clTarifa").toString(); 
       	}  

       	if (request.getParameter("Clave")!= null)
      	{
            strClave = request.getParameter("Clave").toString(); 
       	}  
        
        StringBuffer strSql= new StringBuffer();
        strSql.append("sp_RegresaCostoLegal ").append(strclExpediente).append(",'").append(strclConcepto).append("','").append(strclTarifa).append("','").append(strClave).append("','").append(strclProveedor).append("'");
        ResultSet rs = UtileriasBDF.rsSQLNP( strSql.toString());
        if (rs.next()){
                if(rs.getString("Existe").equalsIgnoreCase("1")){%>
                  <script>alert("El Concepto ya existe en el Expediente"); top.opener.fnActualizaDatosCostoLegal('0','','0','0','0'); window.close();</script>
                <%}else{
                    String strclCostoxSubservxEF; 
                    
                    strclCostoxSubservxEF=rs.getString("clCostoxSubservxEF");
                    if (strclCostoxSubservxEF.equalsIgnoreCase("0")){%><script>alert("NO EXISTE COSTO")</script> <%}
                    %><script>top.opener.fnActualizaDatosCostoLegal('<%=rs.getString("Costo")%>','<%=rs.getString("Clave")%>','<%=rs.getString("clConcepto")%>','<%=rs.getString("clTarifa")%>','<%=strclCostoxSubservxEF%>');window.close();</script>
             <%}
        }
        strSql.delete(0,strSql.length());
        rs.close();
        rs=null;
        
%>

</body>
</html>

