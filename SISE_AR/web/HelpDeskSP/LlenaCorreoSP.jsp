<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LlenaCorreoSP</title>
    </head>
    <body>
        <% 
        String StrclUsrApp="0";
        
        
        
        if (session.getAttribute("clUsrApp")!= null){
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        %>
        
        <%
        //-------------- Obtiene el Correo
        ResultSet rsSP = UtileriasBDF.rsSQLNP( "st_ObtenCorreoSP " + StrclUsrApp);
        String StrCorreoSP ="";
        
        if(rsSP.next()){
            StrCorreoSP=rsSP.getString("Correo");
        }
        
        if (rsSP!=null){
            rsSP.close();
            rsSP=null;
        }
        
        StrclUsrApp=null;
        %>    
        <script>
               // alert('<%=StrCorreoSP%>');
              top.opener.fnLlenaCorreo('<%=StrCorreoSP%>');
              window.close();
        </script>
    </body>
</html>



