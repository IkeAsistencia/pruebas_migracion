<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Descuento</title> 
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody" onLoad="fnSumaMonto();">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<script>
top.document.all.rightPO.rows="70,*";
</script>
<%

    String StrclAcumuladorNuevo="0";
    String StrFechaCompra="0";
    String StrUltra="0";
    
    if (request.getParameter("clAcumuladorNuevo")!= null)
     {
       StrclAcumuladorNuevo = request.getParameter("clAcumuladorNuevo").toString(); 
     } 
    if (request.getParameter("fechacompra")!= null)
     {
       StrFechaCompra = request.getParameter("fechacompra").toString(); 
     } 
        if (request.getParameter("Ultra")!= null)
     {
       StrUltra = request.getParameter("Ultra").toString(); 
     } 

%>

        
        <%  StringBuffer StrSql = new StringBuffer();
       
        StrSql.append("st_DescuentoAcumuladorNuevo " + StrclAcumuladorNuevo + ",'" + StrFechaCompra + "'," + StrUltra );
         ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
            StrSql.delete(0,StrSql.length());

            if (rs.next()){
        %>
            <script>   
                        top.opener.fnProveeDescuento('<%=rs.getString("MontoNormal")%>','<%=rs.getString("Descuento")%>','<%=rs.getString("Totalusr")%>','<%=rs.getString("Porcentaje")%>');
                        window.close();

            </script>
         <%
            
            }
        
 rs.close();
        rs=null;
     StrclAcumuladorNuevo=null;
     StrFechaCompra=null;
     StrUltra=null;
%>  

<script>

</script> 
</body>
</html>
