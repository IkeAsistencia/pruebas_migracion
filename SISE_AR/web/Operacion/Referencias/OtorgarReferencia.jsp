<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title> 
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<%  
    String StrclReferenciaLlamada="0"; 
    String StrclReferencia="0";
    String StrclCuenta="0";
    String StrclRefxCta="0";
    String StrclPaginaWeb="0";
    
    

    if (session.getAttribute("clReferenciaLlamada")!= null)
     {
       StrclReferenciaLlamada = session.getAttribute("clReferenciaLlamada").toString(); 
     }  
    
    if (session.getAttribute("clCuenta")!= null)
     {
       StrclCuenta = session.getAttribute("clCuenta").toString(); 
     }  
    
    if ( request.getParameter("clReferencia")!= null)
        {
             StrclReferencia = request.getParameter("clReferencia").toString().trim();
        }  
    %>
    <script>fnOpenLinks()</script>
       <%
       StrclPaginaWeb = "396";       
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 

        StringBuffer StrSql = new StringBuffer();
       
        StrSql.append("Select clRefxCta from cRefxCta where clReferencia=");
        StrSql.append(StrclReferencia).append(" and clCuenta =").append(StrclCuenta);
    
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());

        if (rs.next()) {
            StrclRefxCta = rs.getString("clRefxCta");
              if (StrclRefxCta ==null){
                StrclRefxCta = "";
                 }
        }else{
            StrclRefxCta = "0";
                }
//Insertar en ReferenciaxRefLlamada
    if (StrclReferencia !="0"){
           UtileriasBDF.ejecutaSQLNP(" sp_OtorgaReferencia " + StrclReferenciaLlamada + "," + StrclReferencia + "," + StrclRefxCta);
           %>
           <script>location.href='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>../../Utilerias/Lista.jsp?P=395&Apartado=S';</script>
          <%
           rs.close();
           rs=null;
           return;
    }
    rs.close();
    rs=null;
    
%>
</body>
</html>

