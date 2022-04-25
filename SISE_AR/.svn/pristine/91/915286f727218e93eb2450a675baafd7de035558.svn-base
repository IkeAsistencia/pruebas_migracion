<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title>Elimina Pasajero</title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<%
   String StrclUsrOneWay="0";
   
        if (request.getParameter("clUsrOneWay")!= null) {
            StrclUsrOneWay= request.getParameter("clUsrOneWay").toString();
        } else{
            if (session.getAttribute("clUsrOneWay")!= null) {
                StrclUsrOneWay= session.getAttribute("clUsrOneWay").toString();
            }
        }        

   System.out.println(StrclUsrOneWay);
            StringBuffer StrSql2 = new StringBuffer();
            
            StrSql2.append("update CScUsrOneWay set Activo=0 where clUsrOneWay = ").append(StrclUsrOneWay);
            System.out.println(StrSql2);
            UtileriasBDF.ejecutaSQLNP(StrSql2.toString());
            StrSql2.delete(0,StrSql2.length());
%>
    <script>top.opener.fnLlenaPasajeros();window.close();</script>
            <%  
            StrclUsrOneWay=null;
            StrSql2=null;
%>    
    </body>
</html>
   