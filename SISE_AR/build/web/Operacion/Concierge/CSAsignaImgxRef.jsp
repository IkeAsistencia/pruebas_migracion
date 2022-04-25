<%@page contentType="text/html"%>
<%@page pageEncoding="ISO-8859-1" import="Utilerias.UtileriasBDF"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;">
        <title>Asigna Img x Ref</title>
    </head>
    <body>
    
        <%
             String StrclAsistencia = "", StrclReferencia = "", StrclImagen = ""; 
                     
             if (session.getAttribute("clAsistencia")!= null) {
                StrclAsistencia= session.getAttribute("clAsistencia").toString();
            }
             
               if (request.getParameter("clReferencia")!= null) {
                StrclReferencia= request.getParameter("clReferencia").toString();
            }
             
             if (request.getParameter("clImagen")!= null) {
                StrclImagen= request.getParameter("clImagen").toString();
            }
            
            System.out.println("update CSReferenciaxAsistencia set clImagen = '"+StrclImagen+"' where clAsistencia = '"+StrclAsistencia+"' and clReferencia = '"+StrclReferencia+"' ");
            UtileriasBDF.ejecutaSQLNP("update CSReferenciaxAsistencia set clImagen = '"+StrclImagen+"' where clAsistencia = '"+StrclAsistencia+"' and clReferencia = '"+StrclReferencia+"' ");
        %>
    
        <script>top.opener.fnCloseAsigImg();window.close();</script>
    </body>
</html>
