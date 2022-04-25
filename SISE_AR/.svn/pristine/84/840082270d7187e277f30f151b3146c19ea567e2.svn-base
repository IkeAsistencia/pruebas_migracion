<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Historial</title> 
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>

<%

    String StrclCiudad="0";
    
        if (request.getParameter("clCiudad")!= null) {
            StrclCiudad= request.getParameter("clCiudad").toString();
        } 
%>

        
        <%  StringBuffer StrSql = new StringBuffer();
       
        StrSql.append("st_CSGetInfoCiudad ").append(StrclCiudad);
         System.out.println(StrSql);
         ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
            StrSql.delete(0,StrSql.length());

            if (rs.next()){
               
        %>
            <script>   
                        top.opener.fnInfoCiudad('<%=rs.getString("CodMD").toString()%>','<%=rs.getString("CodEnt").toString()%>')
                        window.close();

            </script>
        
        <% } 
            
    rs.close();
    rs=null;
    StrclCiudad=null;
%>  

<script>

</script> 
</body>
</html>
