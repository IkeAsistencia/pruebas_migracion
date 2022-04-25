<%@page contentType="text/html"%>
<%@page pageEncoding="ISO-8859-1" import="Utilerias.UtileriasBDF,java.sql.ResultSet"%>



<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Asigna Promocion</title>
    </head>
    
    <%
       String StrclPromocion = "0";
       String StrclAsistencia = "";
       String StrclUsr = "0";
        
        if (session.getAttribute("clUsrApp")!= null){
       		StrclUsr = session.getAttribute("clUsrApp").toString();
        }
        
        
        if (request.getParameter("clAsistencia")!= null){
                StrclAsistencia = request.getParameter("clAsistencia").toString();
        }
                    
       if (request.getParameter("clPromocion")!= null){
            StrclPromocion= request.getParameter("clPromocion").toString();
      	}

       System.out.println("sp_GuardaPromocionxAsistencia '"+StrclPromocion+"','"+StrclAsistencia+"','"+StrclUsr+"'");
       UtileriasBDF.ejecutaSQLNP("sp_GuardaPromocionxAsistencia '"+StrclPromocion+"','"+StrclAsistencia+"','"+StrclUsr+"'");

    %>
    <body>
        <script>
            alert('Se asigno correctamente la Promoción');
            window.close();
        </script>
  
    </body>
</html>
