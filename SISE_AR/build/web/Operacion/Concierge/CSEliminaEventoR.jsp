<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title>Borrar Acumuladores por Expediente</title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<%
   String StrclConcierge="0";
   String StrclEvento="0";
   String StrEstatus="0";
   
        if (request.getParameter("clConcierge")!= null) {
            StrclConcierge= request.getParameter("clConcierge").toString();
        } else{
            if (session.getAttribute("clConcierge")!= null) {
                StrclConcierge= session.getAttribute("clConcierge").toString();
            }
        }        
        if (request.getParameter("clEvento")!= null) {
            StrclEvento= request.getParameter("clEvento").toString();
        } else{
            if (session.getAttribute("clEvento")!= null) {
                StrclEvento= session.getAttribute("clEvento").toString();
            }
        }
   
        if (request.getParameter("Estatus")!= null) {
            StrEstatus= request.getParameter("Estatus").toString();
        } else{
            if (session.getAttribute("Estatus")!= null) {
                StrEstatus= session.getAttribute("Estatus").toString();
            }
        }
   
   if (Integer.parseInt(StrEstatus)==1){
            StringBuffer StrSql2 = new StringBuffer();
            
            StrSql2.append("st_CSActivaRecordatorio ").append(StrclEvento);
            System.out.println(StrSql2);
            UtileriasBDF.ejecutaSQLNP(StrSql2.toString());
            StrSql2.delete(0,StrSql2.length());
   }
   else
       {
            StringBuffer StrSql2 = new StringBuffer();
            
            StrSql2.append("update CSEventosReminder set Activo=0 where clEvento = ").append(StrclEvento);
            System.out.println(StrSql2);
            UtileriasBDF.ejecutaSQLNP(StrSql2.toString());
            StrSql2.delete(0,StrSql2.length());
   }
%>
    <script>location.href="CSEventosReminder.jsp?clConcierge=<%=StrclConcierge%>"</script>
            <%  
            StrclConcierge=null;
            StrclEvento=null;
%>    
    </body>
</html>
   