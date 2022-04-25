<%@page  contentType="text/html; charset=iso-8859-1" import="Utilerias.UtileriasBDF"%>


<html>
    <head>
        <title>Send Mail Cotizacion</title>
    </head>
    
    <body>
        <%
          String StrclCompra = "0";
            
            if (session.getAttribute("clCompra") != null ){
                StrclCompra = session.getAttribute("clCompra").toString();
            }

          UtileriasBDF.ejecutaSQLNP("sp_SendMailC_Cotizacion "+StrclCompra);  
        %>
        
             <script>
                alert('Correo Elctrónico de Cotización Enviado Correctamente');
                top.opener.location.href('<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>DetalleC_ProductosxSolicitud.jsp');
                window.close();
            </script>
            
    </body>
</html>
