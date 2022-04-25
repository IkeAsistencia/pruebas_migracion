<%--
 Document   : C_ProductoxProveedor
 Create on  : 2010-03-26
 Author     : vsampablo
--%>
 
 <%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
 <%@ page import="Utilerias.UtileriasBDF,Seguridad.SeguridadC,java.sql.ResultSet" %>
 
<html>
     <head><title>C_ProductoxProveedor</title>
            <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
     </head>
 
     <body class="cssBody">
            <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
            <script src='../Utilerias/Util.js' ></script>
            <script src='../Utilerias/UtilStore.js' ></script>
            <script src='../Utilerias/UtilCalendario.js' ></script>
            <link href='../StyleClasses/Calendario.css' rel='stylesheet' type='text/css'>
 
            <% 
                String StrclUsr  = "0";
                String StrclPaginaWeb  = "0";
                String StrclCompra = "0";
 
                if ( session.getAttribute("clUsrApp") != null) { 
                    StrclUsr = session.getAttribute("clUsrApp").toString(); 
                } 
 
                if ( SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr) ) != true ) {  %> 
                     Fuera de Horario <% 
                     StrclUsr = null; 
                     StrclPaginaWeb = null; 
                     StrclCompra = null; 
                     return; 
                } 
 
   
 
              if ( request.getParameter("clCompra")!= null )  {  
                    StrclCompra = request.getParameter("clCompra").toString(); 
                    session.setAttribute("clCompra",StrclCompra);  
                } 
                else { 
                    if ( session.getAttribute("clCompra")!= null )  {  
                        StrclCompra = session.getAttribute("clCompra").toString(); 
                    } 
                } 

                String StrclCalificacionxProveedor = "0";
        
                if (request.getParameter("clCalificacionxProveedor")!=null){
                    StrclCalificacionxProveedor  = request.getParameter("clCalificacionxProveedor").toString();
                }
                
                
                ResultSet rsCalificacion = null;
                rsCalificacion = UtileriasBDF.rsSQLNP("st_C_CalificacionxProveedor "+StrclCalificacionxProveedor);
 
               
                
                %><script>fnOpenLinks()</script><% 
 
                StrclPaginaWeb = "5085";
                session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
            %> 
        
                  
                <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb),Integer.parseInt(StrclUsr));%>
                <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","fnLlenaProveedor();","")%>
 
 
                    <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleC_CalificacionxProv.jsp?'>"%> 
 
                    <input id="clPaginaWeb" name="clPaginaWeb" type="hidden" value="<%=StrclPaginaWeb%>" > 
                    <input id="clCompra" name="clCompra" type="hidden" value="<%=StrclCompra%>" > 
                    <input id="clUsrApp" name="clUsrApp" type="hidden" value="<%=StrclUsr%>" >  
                    
                     <%  int iY = 10; %>
 
                     <% if (rsCalificacion.next()) { %>
                        <input id="clCalificacionxProveedor" name="clCalificacionxProveedor" type="hidden" value="<%=rsCalificacion.getString("clCalificacionxProveedor")%>" > 
                        <%=MyUtil.ObjComboC("Proveedor","clProveedor",rsCalificacion.getString("Nombre").toString(),true,false,30,iY+80,"","sp_GetC_ProvCalxCompra "+StrclCompra+",1","","",20,true,true)%> 
                        <%=MyUtil.ObjComboC("Tiempo de Entrega","TiempoEntrega",rsCalificacion.getString("CalificacionTE").toString(),true,true,30,iY+120,"","select * from C_cCalificacion ","","",20,true,true)%> 
                        <%=MyUtil.ObjComboC("Producto Entregado Cumple con El Producto requerido","ProductoEntregado",rsCalificacion.getString("CalificacionPE").toString(),true,true,30,iY+160,"","select * from C_cCalificacion ","","",20,true,true)%> 
                    <% } else { %>
                        <input id="clCalificacionxProveedor" name="clCalificacionxProveedor" type="hidden" value=''">
                        <%=MyUtil.ObjComboC("Proveedor","clProveedor","",true,false,30,iY+80,"","sp_GetC_ProvCalxCompra "+StrclCompra+",1","","",20,true,true)%> 
                        <%=MyUtil.ObjComboC("Tiempo de Entrega","TiempoEntrega","",true,true,30,iY+120,"","select * from C_cCalificacion ","","",20,true,true)%> 
                        <%=MyUtil.ObjComboC("Producto Entregado Cumple con El Producto requerido","ProductoEntregado","",true,true,30,iY+160,"","select * from C_cCalificacion ","","",20,true,true)%> 
                    <% }  %>
                    <%=MyUtil.DoBlock("Calificacion de Proveedor",180,0)%>
 
                    <%=MyUtil.GeneraScripts()%> 
 
                    <%  //<<<<<<<<<<<<<<<< Limpiar Variables >>>>>>>>>  
                       StrclUsr = null;  
                       StrclPaginaWeb = null;  
                       StrclCompra = null;
                        rsCalificacion.close();
                        rsCalificacion = null;  
                    %>  
 
        <script>
            function fnLlenaProveedor(){
                   var strConsulta = "sp_GetC_ProvCalxCompra '" + document.all.clCompra.value + "','2'";
                   var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
            
               document.all.clProveedor.value = '';
               pstrCadena = pstrCadena + "&strName=clProveedorC";		
               fnOptionxDefault('clProveedorC',pstrCadena);
           }
                      
        </script>
     </body>
</html>
