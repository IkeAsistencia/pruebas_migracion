<%--
 Document   : C_ProductoxProveedor
 Create on  : 2010-03-26
 Author     : vsampablo
--%>
 
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="Utilerias.UtileriasBDF,Seguridad.SeguridadC,java.sql.ResultSet,com.ike.Compras.DAOC_ProductoxProveedor,com.ike.Compras.to.C_ProductoxProveedor;" %>

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
        String StrclProductoxProveedor = "0";
        
        if ( session.getAttribute("clUsrApp") != null) {
            StrclUsr = session.getAttribute("clUsrApp").toString();
        }
        
        if ( SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr) ) != true ) {  %> 
        Fuera de Horario <% 
        StrclUsr = null;
        StrclPaginaWeb = null;
        StrclProductoxProveedor = null;
        return;
        }
        
        if ( request.getParameter("clProductoxProveedor")!= null )  {
            StrclProductoxProveedor = request.getParameter("clProductoxProveedor").toString();
            session.setAttribute("clProductoxProveedor",StrclProductoxProveedor);
        } else {
            if ( session.getAttribute("clProductoxProveedor")!= null )  {
                StrclProductoxProveedor = session.getAttribute("clProductoxProveedor").toString();
            }
        }
        
        String StrclProveedor = "0";
        
        if ( session.getAttribute("clProveedor")!= null )  {
            StrclProveedor = session.getAttribute("clProveedor").toString();
        }
        
        String StrdsProveedor = "";
        
        if (session.getAttribute("dsProveedorC") != null ){
            StrdsProveedor  = session.getAttribute("dsProveedorC").toString();
        }                
        
        DAOC_ProductoxProveedor daoC_ProductoxProveedor = null;
        C_ProductoxProveedor  PxP = null;
        
        daoC_ProductoxProveedor = new DAOC_ProductoxProveedor();
        PxP = daoC_ProductoxProveedor.getclProductoxProveedor( StrclProductoxProveedor.toString() );
        
        %><script>fnOpenLinks()</script><% 
        
        StrclPaginaWeb = "5076";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        
        %>                 
        
        <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb),Integer.parseInt(StrclUsr));%>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","fnLlenaProducos();","")%>
        
        
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleC_ProductoxProveedor.jsp?'>"%> 
        
        <input id="clPaginaWeb" name="clPaginaWeb" type="hidden" value="<%=StrclPaginaWeb%>" > 
        <input id="clProductoxProveedor" name="clProductoxProveedor" type="hidden" value="<%=StrclProductoxProveedor%>" > 
        <input id="clProveedor" name="clProveedor" type="hidden" value="<%= StrclProveedor%>" > 
        <input id="clUsrApp" name="clUsrApp" type="hidden" value="<%=StrclUsr%>" >  
        
        <%  int iY = 10; %>
        
        
        <%=MyUtil.ObjInput("Proveedor","Nombre",PxP != null ? PxP.getNombre() :"",false,false,30,iY+80,StrdsProveedor,false,false,45)%>
        <%=MyUtil.ObjComboC("Producto","clProducto",PxP != null ? PxP.getdsProducto(): "",true,true,30,iY+120,"","sp_GetC_Productos ","","",20,true,true)%> 
        <%=MyUtil.DoBlock("Producto de Proveedor",60,0)%>
        
        <%=MyUtil.GeneraScripts()%> 
        
        <%  //<<<<<<<<<<<<<<<< Limpiar Variables >>>>>>>>>
        StrclUsr = null;
        StrclPaginaWeb = null;
        daoC_ProductoxProveedor = null;
        PxP = null;
        StrdsProveedor = null;
        StrclProveedor  = null;
        %>  
        
        <script>
                      
            function fnLlenaProducos(){  
                var strConsulta = "sp_GetC_Productos '" + document.all.clProveedor.value + "'";
                var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;

                   document.all.clProducto.value = '';
                   pstrCadena = pstrCadena + "&strName=clProductoC";		
                   fnOptionxDefault('clProductoC',pstrCadena);
            }
        </script>
    </body>
</html>
