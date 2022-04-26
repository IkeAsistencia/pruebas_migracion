<%-- 
    Document   : CSObtenInfoExp
    Created on : 1/12/2009, 06:09:11 PM
    Author     : rfernandez
--%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>

<html>
    <head>
         <title>Informacion Expediente</title>        
    </head> 
<body>

<%
    String StrclAsistencia="0";
    String StrclExpediente="0";
    String StrclUsrApp="0";

        if (session.getAttribute("clAsistencia") != null) {
                StrclAsistencia = session.getAttribute("clAsistencia").toString();}

        if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();}


            StringBuffer Strsql = new StringBuffer();
            Strsql.append("st_CSObtenInfoExpediente ").append(StrclAsistencia).append(",").append(StrclUsrApp).append("");
            ResultSet rs = UtileriasBDF.rsSQLNP(Strsql.toString());

            if (rs.next()) { // bien, si existe!!!
      
                 StrclExpediente = rs.getString("clExpediente");
            }

            Strsql=Strsql.delete(0, Strsql.length());
            session.setAttribute("clExpediente",StrclExpediente);
%>
          <script>
           location.href=('../../Operacion/DetalleExpediente.jsp');
           window.close();
          </script>
</body>
</html>