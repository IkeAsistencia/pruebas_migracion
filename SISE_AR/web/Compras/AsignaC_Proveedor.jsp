<%@page  contentType="text/html; charset=iso-8859-1" import="Utilerias.UtileriasBDF"%>


<html>
    <head>
        <title>Asignación de Proveedor</title>
    </head>
    
    <body>
        <%
            String StrclProveedor = "0";
            
            if (request.getParameter("clProveedor")!= null ){
                StrclProveedor = request.getParameter("clProveedor").toString();
            }
            
            String StrclCompra = "0";
            
            if (session.getAttribute("clCompra") != null ){
                StrclCompra = session.getAttribute("clCompra").toString();
            }
            
            if (!StrclProveedor.equalsIgnoreCase("0")) {
                UtileriasBDF.ejecutaSQLNP(" st_AsignaC_Proveedor '"+StrclProveedor+"','"+StrclCompra+"'");   
            }
        %>
        
        <script>
            //alert('Proveedor Asignado Correctamente');
            top.opener.location.href('<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>../servlet/Utilerias.Lista?P=5073&Apartado=S');
            window.close();
        </script>
        
    </body>
</html>
