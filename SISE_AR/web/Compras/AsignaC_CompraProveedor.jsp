<%@page  contentType="text/html; charset=iso-8859-1" import="Utilerias.UtileriasBDF,java.util.StringTokenizer,java.util.ArrayList"%>


<html>
    <head>
        <title>Asignación Compra de Proveedor</title>
    </head>
    
    <body>
        <%
            String StrclUsrApp  = "0";
            
            if ( session.getAttribute("clUsrApp") != null) { 
                StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
            } 
                
            String StrclCompra = "0";
            
            if (session.getAttribute("clCompra") != null ){
                StrclCompra = session.getAttribute("clCompra").toString();
            }
            
            String StrProductos = "0";
            
            if (request.getParameter("Productos")!= null){
                StrProductos = request.getParameter("Productos").toString();
            }
            
            
            StrProductos = StrProductos.replace("Producto","");

            ArrayList ListProductos = new ArrayList();
            StringTokenizer stProductos = new StringTokenizer(StrProductos,",");

            while (stProductos.hasMoreTokens()){
                ListProductos.add(stProductos.nextElement().toString());
            }
            
            
            //<<<<<<<<<<<<<<<<<<<<<< Actualizar los productos por Comprar >>>>>>>>>>>>>>>>>>>>>
            for (int i=0; i<ListProductos.size(); i++){
                     System.out.println("st_AsignaC_CompraProveedor '"+ListProductos.get(i).toString()+"','"+StrclCompra+"','"+StrclUsrApp+"'"); 
                     UtileriasBDF.ejecutaSQLNP(" st_AsignaC_CompraProveedor '"+ListProductos.get(i).toString()+"','"+StrclCompra+"','"+StrclUsrApp+"'"); 
            }


            StrclCompra = null;
            StrclUsrApp = null;
            StrProductos = null;
            
        %>
        
        <script>
            //alert('Proveedor Asignado Correctamente');
            top.opener.location.href('<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>DetalleC_ProductosxSolicitud.jsp');
            window.close();
        </script>
        
    </body>
</html>
