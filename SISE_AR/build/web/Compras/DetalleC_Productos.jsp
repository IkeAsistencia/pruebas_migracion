<%-- 
    Document   : DetalleC_Proveedores
    Created on : 19/03/2010, 11:12:24 AM
    Author     : atorres
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="Utilerias.UtileriasBDF,
                Seguridad.SeguridadC,
                java.sql.ResultSet"%>

<html>
     <head><title>Detalle Productos</title>
            <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
     </head>

     <body class="cssBody" onload="">
            <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
            <script src='../Utilerias/Util.js' ></script>
            <script src='../Utilerias/UtilDireccion.js'></script>

            <%
                String StrclUsr  = "0";
                String StrclPaginaWeb  = "0";

                if ( session.getAttribute("clUsrApp") != null) {
                    StrclUsr = session.getAttribute("clUsrApp").toString();
                }

                if ( SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr) ) != true ) {  %>
                     Fuera de Horario <%
                     StrclUsr = null;
                     StrclPaginaWeb = null;
                     return;
                }

                String StrclProducto = "0";

                if (request.getParameter("clProducto") != null){   
                       StrclProducto =  request.getParameter("clProducto").toString(); 
                       session.setAttribute("clProducto", StrclProducto); 
                }
                else{
                    if ( session.getAttribute("clProducto")!= null){  
                        StrclProducto =  session.getAttribute("clProducto").toString(); 
                    }
                }
                
                ResultSet rsProductos = null;
                rsProductos = UtileriasBDF.rsSQLNP("select dsProducto, coalesce(Activo,0) 'Activo' from C_cProducto where clProducto ="+StrclProducto);
                
                

                %><script>fnOpenLinks()</script><%

                StrclPaginaWeb = "5070";
                session.setAttribute("clPaginaWebP",StrclPaginaWeb);


              %>
                <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb),Integer.parseInt(StrclUsr));%>
                <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","","")%>


                    <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleC_Productos.jsp?'>"%>

                    <input id="clPaginaWeb" name="clPaginaWeb" type="hidden" value="<%=StrclPaginaWeb%>" >
                    <input id="clUsrApp" name="clUsrApp" type="hidden" value="<%=StrclUsr%>" >
                     <%  int iY = 40; %>
                    <input id="clProducto" name="clProducto" type="hidden" value="<%=StrclProducto%>" >

                    <% if (rsProductos.next()){ %>
                    
                    <%=MyUtil.ObjInput("Producto","dsProducto",rsProductos.getString("dsProducto"),true,true,30,iY+40,"",true,true,50)%>
                    <%=MyUtil.ObjChkBox("Activo","Activo",rsProductos.getString("Activo"),false,true,30,iY+80,"1","SI","NO","")%>
                    
                    <% } else { %>
                    
                    <%=MyUtil.ObjInput("Producto","dsProducto","",true,true,30,iY+40,"",true,true,50)%>
                    <%=MyUtil.ObjChkBox("Activo","Activo","0",false,true,30,iY+80,"1","SI","NO","")%>
                    
                    <% } %>

                    <%=MyUtil.DoBlock("Informacion del Proveedor",90,0)%>

                    <%=MyUtil.GeneraScripts()%>


                    <%  //<<<<<<<<<<<<<<<< Limpiar Variables >>>>>>>>>
                       rsProductos.close();
                       rsProductos = null;
                       
                       StrclUsr = null;
                       StrclPaginaWeb = null;
             
                       StrclProducto = null;
                    %>

        <script>
        </script>
     </body>
</html>
