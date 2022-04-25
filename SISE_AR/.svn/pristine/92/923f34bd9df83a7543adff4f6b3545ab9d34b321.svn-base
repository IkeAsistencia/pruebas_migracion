<%--
 Document   : C_ProductoxCompra
 Create on  : 2010-03-23
 Author     : vsampablo
--%>
 
 <%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
 <%@ page import="Utilerias.UtileriasBDF,Seguridad.SeguridadC,java.sql.ResultSet,com.ike.Compras.DAOC_ProductoxCompra,com.ike.Compras.to.C_ProductoxCompra;" %>
 
<html>
    
        <%
                String StrclUsrApp  = "0";
                String StrclPaginaWeb  = "0";
 
                if ( session.getAttribute("clUsrApp") != null) { 
                    StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
                } 
 
                if ( SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp) ) != true ) {  %> 
                     Fuera de Horario <% 
                     StrclUsrApp = null; 
                     StrclPaginaWeb = null; 
                     return; 
                } 
 
                
                String StrclCompra = "0";
                
                if (session.getAttribute("clCompra") != null ){
                    StrclCompra = session.getAttribute("clCompra").toString();
                }
                
                String StrCompras = "0";
                String StrEnvioCotizacion = "0";
                String StrOrdenCompra = "0";
                String StrProductosxCompra = "0";
                String StrProveedores = "0";
                
                ResultSet rsValidaPermisos = null;
                
                System.out.println("sp_ValidaC_PermisosCompra "+StrclCompra+","+StrclUsrApp);
                rsValidaPermisos = UtileriasBDF.rsSQLNP("sp_ValidaC_PermisosCompra "+StrclCompra+","+StrclUsrApp);
                
                if (rsValidaPermisos.next()){
                    StrCompras = rsValidaPermisos.getString("Compras");
                    StrEnvioCotizacion = rsValidaPermisos.getString("EnvioCotizacion");
                    StrOrdenCompra = rsValidaPermisos.getString("OrdenCompra");       
                    StrProductosxCompra = rsValidaPermisos.getString("ProductosxCompra");
                    StrProveedores  = rsValidaPermisos.getString("Proveedores");
                }
                
                
                rsValidaPermisos.close();
                rsValidaPermisos = null;
                
        %>
                
                
     <head><title>C_ProductoxCompra</title>
            <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
     </head>

    <body class="cssBody">
    <input type="hidden" id="Productos" name="Productos" value="">
    
    <b><center><table ><tr><td><font color='#423A9E'><b>Productos x Solicitud</b></font></td></tr></table></center></b>
    <br>
    
    <input class='cBtn' type='button' value='Buscar' onClick=""></input>
    
    <% if(StrCompras.equalsIgnoreCase("0")) {%>
        <% if (StrOrdenCompra.equalsIgnoreCase("1")) { %>
            <input class='cBtn' type='button' value='Nuevo' onClick="top.document.all.Contenido.src='Compras/DetalleC_ProductoxCompra.jsp?'"></input><br>
        <% } else { 
                if (StrEnvioCotizacion.equalsIgnoreCase("0")){ %>
            <input class='cBtn' type='button' value='Nuevo' onClick="top.document.all.Contenido.src='Compras/DetalleC_ProductoxCompra.jsp?'"></input><br>
                <% }  %>
        <% }  %>
    <%}%>
    <br>
    
    <% if (!StrProductosxCompra.equalsIgnoreCase("0")) { %>
            <% if (StrOrdenCompra.equalsIgnoreCase("1") && StrCompras.equalsIgnoreCase("0")) { %>
                <img src="../Imagenes/CCompra.png" alt="Solicitar Producto" alt="Autorizar Compra" class="handM" onclick="fnCompra();">
            <%  }   %>
            
            <% if (Integer.parseInt(StrProveedores) >= 2 && StrEnvioCotizacion.equalsIgnoreCase("0")) { %>
                <img src="../Imagenes/SendMail.png" alt="Enviar Mensaje de Cotización" class="handM" onclick="fnSendMail();">
            <% } %>
            <br>
    <% } %>

    <% 
        StringBuffer strSql = new StringBuffer();
        StringBuffer strSalida = new StringBuffer();
        
        UtileriasBDF.rsTableNP(strSql.append("st_ListaC_ProductodxCompra ").append(StrclCompra).append(",").append(StrclUsrApp).toString(), strSalida);
        
    %>
    
    <%=strSalida.toString()%>
    <%
        strSql.delete(0,strSql.length());
        strSalida.delete(0,strSalida.length());
    %>
    
    
    
    <%         
        //<<<<<<<<<<<<<<<<<<<< Validaciones para la Funcion de Compra >>>>>>>>>>>>>>>>>>>
        ResultSet rsProductos = null; 
        rsProductos = UtileriasBDF.rsSQLNP("select coalesce(clProductoxCompra,0) 'clProductoxCompra', 'Producto'+cast(clProductoxCompra as varchar(10)) 'ID' from  C_ProductoxCompra where clCompra = "+StrclCompra);
    %>
    
    <%  
        String StrID = "";
         
        while (rsProductos.next()){
            StrID = StrID  +"document.all."+ rsProductos.getString("ID")+".value == 0 && ";
        }
        
        rsProductos.close();
        rsProductos = null;
        
        if (!StrID.equalsIgnoreCase("")){
            StrID = StrID.substring(0,StrID.length()-4);
        }
        else {
            StrID = " document.all.Producto.value!=0 ";
        }

    %>

        <script>
             function fnCompra(){
                if ( <%=StrID%> ) {
                    alert ('No se elegio ningun producto');
                }
                else {
                    window.open('AsignaC_CompraProveedor.jsp?Productos='+document.all.Productos.value,'newWin','scrollbars=yes,status=yes,width=1,height=1');
                }
            }
            
            function fnCheck(ID){
                var Productos = document.all.Productos.value;
            
                if ( document.all[ID].checked == true ){
                    document.all[ID].value = '1';
                    Productos = Productos +  ID+',';
                    document.all.Productos.value = Productos;
                }
                else{
                     document.all[ID].value = '0';
                     var ProductoD = ID+',';
                     var NProductos= Productos.replace(ProductoD,"");
                     document.all.Productos.value = NProductos;
                }
            }
            
            function fnSendMail(){
                window.open('SendMailCotizacion.jsp','newWin','scrollbars=yes,status=yes,width=1,height=1');
            }
        </script>

    
    </body>
</html>
