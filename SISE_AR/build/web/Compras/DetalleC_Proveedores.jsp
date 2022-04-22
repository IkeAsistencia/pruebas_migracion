<%-- 
    Document   : DetalleC_Proveedores
    Created on : 19/03/2010, 11:12:24 AM
    Author     : atorres
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="Utilerias.UtileriasBDF,
                Seguridad.SeguridadC,
                java.sql.ResultSet,
                com.ike.Compras.DAOC_cProveedor,
                com.ike.Compras.to.C_cProveedor;"%>

<html>
     <head><title>Detalle Proveedores</title>
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

                String StrclProveedor = "0";

                if (request.getParameter("clProveedor") != null){   
                       StrclProveedor =  request.getParameter("clProveedor").toString(); 
                       session.setAttribute("clProveedor", StrclProveedor); 
                }
                else{
                    if ( session.getAttribute("clProveedor")!= null){  
                        StrclProveedor =  session.getAttribute("clProveedor").toString(); 
                    }
                }

                DAOC_cProveedor daoProveedor = null;
                C_cProveedor P = null;

                daoProveedor = new DAOC_cProveedor();
                P = daoProveedor.getClProveedor(StrclProveedor);

                %><script>fnOpenLinks()</script><%

                StrclPaginaWeb = "5068";
                session.setAttribute("clPaginaWebP",StrclPaginaWeb);

                if (P!= null){
                    session.setAttribute("dsProveedorC",P.getNombre());
                }

              %>
                <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb),Integer.parseInt(StrclUsr));%>
                <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","","")%>


                    <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleC_Proveedores.jsp?'>"%>

                    <input id="clPaginaWeb" name="clPaginaWeb" type="hidden" value="<%=StrclPaginaWeb%>" >
                    <input id="clUsrApp" name="clUsrApp" type="hidden" value="<%=StrclUsr%>" >
                     <%  int iY = 40; %>
                    <input id="clProveedor" name="clProveedor" type="hidden" value="<%=StrclProveedor%>" >


                    <%=MyUtil.ObjInput("Nombre Proveedor","Nombre", P != null ? P.getNombre():"",true,true,30,iY+40,"",true,true,70)%>
                    <%=MyUtil.ObjInput("NIT","Nit",P != null ? P.getNit():"",true,true,30,iY+80,"",true,true,20)%>
                    <%=MyUtil.ObjInput("Contacto","Contacto", P != null ? P.getContacto():"",true,true,30,iY+120,"",true,true,70)%>
                    <%=MyUtil.ObjInput("Telefono 1","Telefono1", P != null ? P.getTelefono1():"",true,true,30,iY+160,"",true,true,20)%>
                    <%=MyUtil.ObjInput("Telefono 2","Telefono2", P != null ? P.getTelefono2():"",true,true,30,iY+200,"",true,true,20)%>
                    <%=MyUtil.ObjChkBox("Activo","Activo",P != null ? P.getActivo():"0",false,true,30,iY+240,"1","SI","NO","")%>

                    <%=MyUtil.DoBlock("Informacion del Proveedor",250,0)%>

                    <%=MyUtil.GeneraScripts()%>


                    <%  //<<<<<<<<<<<<<<<< Limpiar Variables >>>>>>>>>
                       StrclUsr = null;
                       StrclPaginaWeb = null;
                       daoProveedor = null;
                       P = null;
                       StrclProveedor = null;
                    %>

        <script>
        </script>
     </body>
</html>
