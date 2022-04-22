<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title>Borrar Acumuladores por Expediente</title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<%
   String StrclExpediente="0";
   String StrNumSerie="0";
   String StrclUsrAppVenta="0";
   
           if (request.getParameter("clExpediente")!=null)
           {
            StrclExpediente = request.getParameter("clExpediente");
           }
           if (request.getParameter("NumSerie")!=null)
           {
            StrNumSerie = request.getParameter("NumSerie");
           }
           if (request.getParameter("clUsrAppVenta")!=null)
           {
            StrclUsrAppVenta = request.getParameter("clUsrAppVenta");
           }
   
            StringBuffer StrSql2 = new StringBuffer();
            
            if (StrNumSerie.equals("0")){
            StrSql2.append("delete AcumuladorxExpediente where clExpediente = ").append(StrclExpediente);
            UtileriasBDF.ejecutaSQLNP(StrSql2.toString());
            StrSql2.delete(0,StrSql2.length());
            %>
    <script> window.close();</script>
            <%  
            } else {    
            StrSql2.append("delete AcumuladorxExpediente where clExpediente = ").append(StrclExpediente).append("and NumSerie = '").append(StrNumSerie).append("'");
            UtileriasBDF.ejecutaSQLNP(StrSql2.toString());
            StrSql2.delete(0,StrSql2.length());
            
%>
    <script>location.href="CarritoAcumulador.jsp?clExpediente=<%=StrclExpediente%>&clUsrApp=<%=StrclUsrAppVenta%>"</script>
            <% } %>    
    </body>
</html>
