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

    String StrclAsistencia="0";
    
        if (request.getParameter("clAsistencia")!= null) {
            StrclAsistencia= request.getParameter("clAsistencia").toString();
        } else{
            if (session.getAttribute("clAsistencia")!= null) {
                StrclAsistencia = session.getAttribute("clAsistencia").toString();
            }
        }

%>

        
        <%  StringBuffer StrSql = new StringBuffer();
       
        StrSql.append("select (select count(1) from CScUsrRoundTrip where clAsistencia=234 and Activo=1 and Tipo = 0)  NumAdultos , (select count(1)  from CScUsrRoundTrip where clAsistencia=").append(StrclAsistencia).append(" and Activo=1 and Tipo = 1) NumNinos");
         System.out.println(StrSql);
         ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
            StrSql.delete(0,StrSql.length());

            if (rs.next()){
                 %>
            <script>   
                        top.opener.fnListaNumPasajeros(<%=rs.getString("NumAdultos")%>,<%=rs.getString("NumNinos")%>);
                        window.close();
           </script>
         <%
            
            }
          
    rs.close();
    rs=null;
    StrclAsistencia=null;
%>  

<script>

</script> 
</body>
</html>
  