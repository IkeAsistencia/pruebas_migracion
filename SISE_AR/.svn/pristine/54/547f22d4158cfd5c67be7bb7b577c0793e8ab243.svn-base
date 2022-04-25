<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title>Elimina Pasajero</title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<%
   String StrclUsrRoundTrip="0";
   
        if (request.getParameter("clUsrRoundTrip")!= null) {
            StrclUsrRoundTrip= request.getParameter("clUsrRoundTrip").toString();
        } else{
            if (session.getAttribute("clUsrRoundTrip")!= null) {
                StrclUsrRoundTrip= session.getAttribute("clUsrRoundTrip").toString();
            }
        }        

            StringBuffer StrSql2 = new StringBuffer();
            
            StrSql2.append("update CScUsrRoundTrip set Activo=0 where clUsrRoundTrip = ").append(StrclUsrRoundTrip);
            System.out.println(StrSql2);
            UtileriasBDF.ejecutaSQLNP(StrSql2.toString());
            StrSql2.delete(0,StrSql2.length());
%>
    <script>top.opener.fnLlenaPasajeros();window.close();</script>
            <%  
            StrclUsrRoundTrip=null;
            StrSql2=null;
%>    
    </body>
</html>   