<%--
 Document   : C_ProductoxCompra
 Create on  : 2010-03-23
 Author     : vsampablo
--%>
 
 <%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
 <%@ page import="Utilerias.UtileriasBDF,Seguridad.SeguridadC,java.sql.ResultSet,com.ike.Compras.DAOC_ProductoxCompra,com.ike.Compras.to.C_ProductoxCompra;" %>
 
<html>
     <head><title>C_ProductoxCompra</title>
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
                String StrclProductoxCompra = "0";
 
                if ( session.getAttribute("clUsrApp") != null) { 
                    StrclUsr = session.getAttribute("clUsrApp").toString(); 
                } 
 
                if ( SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr) ) != true ) {  %> 
                     Fuera de Horario <% 
                     StrclUsr = null; 
                     StrclPaginaWeb = null; 
                     StrclProductoxCompra = null; 
                     return; 
                } 
 
                if ( request.getParameter("clProductoxCompra")!= null )  {  
                     StrclProductoxCompra = request.getParameter("clProductoxCompra").toString(); 
                     session.setAttribute("clProductoxCompra",StrclProductoxCompra);  
                } 
                else { 
                    if ( session.getAttribute("clProductoxCompra")!= null )  {  
                        StrclProductoxCompra = session.getAttribute("clProductoxCompra").toString(); 
                    } 
                } 
                
                String StrclCompra = "0";
                
                if (session.getAttribute("clCompra") != null ){
                    StrclCompra = session.getAttribute("clCompra").toString();
                }
                
                
                /*String StrclProveedorAsig ="0";
                
                if (request.getParameter("clProveedorAsig")!=null){
                    StrclProveedorAsig = request.getParameter("clProveedorAsig").toString();
                }*/
 
                DAOC_ProductoxCompra daoC_ProductoxCompra = null;
                C_ProductoxCompra  PxC = null;
 
                daoC_ProductoxCompra = new DAOC_ProductoxCompra(); 
                PxC = daoC_ProductoxCompra.getclProductoxCompra( StrclProductoxCompra.toString() );
 
                %><script>fnOpenLinks()</script><% 
 
                StrclPaginaWeb = "5075";
                session.setAttribute("clPaginaWebP",StrclPaginaWeb);
 
                //<<<<<<<<<<<< Servlet Generico >>>>>>>>>>>
                String Store = ""; 
                Store="st_GuardaC_ProductoxCompra,st_ActualizaC_ProductoxCompra"; 
                session.setAttribute("sp_Stores",Store); 
 
                String Commit = "";
                Commit = "clProductoxCompra";
                session.setAttribute("Commit",Commit);
 
            %> 
 
                <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb),Integer.parseInt(StrclUsr));%>
                <%=MyUtil.doMenuAct("../servlet/com.ike.guarda.EjecutaSP","//fnActualizaProv();","fnsp_Guarda();")%>
 
 
                    <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleC_ProductoxCompra.jsp?'>"%> 
 
                    <input id="clPaginaWeb" name="clPaginaWeb" type="hidden" value="<%=StrclPaginaWeb%>" > 
                    <input id="Secuencia" name="Secuencia" type="hidden" value=""> 
                    <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="clCompra,clProducto,clProveedor,Cantidad,ValorUnitario,IVA,ValorTotal,FormaPago,TiempoEntrega,Garantia,clTipoMoneda">
                    <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clProductoxCompra,clCompra,clProducto,clProveedor,Cantidad,ValorUnitario,IVA,ValorTotal,FormaPago,TiempoEntrega,Garantia,clTipoMoneda">
                    <input id="clUsrApp" name="clUsrApp" type="hidden" value="<%=StrclUsr%>" > 
 
                     <%  int iY = 10; %>
 
                    <input id="clProductoxCompra" name="clProductoxCompra" type="hidden" value="<%=StrclProductoxCompra%>" > 
                    <input id="clCompra" name="clCompra" type="hidden" value="<%=StrclCompra%>" > 
                    <!--input id="clProveedorAsig" name="clProveedorAsig" type="hidden" value="<StrclProveedorAsig" --> 
                    
                    <% String StrclProveedor = PxC != null ? PxC.getclProveedor():""; %>

                    
                    <%=MyUtil.ObjComboC("Proveedor","clProveedor",PxC != null ? PxC.getNombre(): "",true,true,30,iY+90,"","sp_GetProveedorxCompra "+StrclCompra,"fnLlenaProducos();","",20,true,true)%> 
          
                    <% StrclProveedor = PxC != null ? PxC.getclProveedor() : "0"; %>
                    
                    <%=MyUtil.ObjComboC("Producto","clProducto",PxC != null ? PxC.getdsProducto(): "",true,true,300,iY+90,"","sp_C_GetProductoxProveedor "+StrclProveedor,"","",20,true,true)%> 
 
                    <%=MyUtil.ObjInput("Forma de Pago","FormaPago",PxC != null ? PxC.getFormaPago() : "",true,true,30,iY+130,"",true,true,40)%> 
                    <%=MyUtil.ObjInput("Tiempo de Entrega","TiempoEntrega",PxC != null ? PxC.getTiempoEntrega() : "",true,true,300,iY+130,"",true,true,40)%>    
                   
                    <%=MyUtil.ObjInput("Garantia","Garantia",PxC != null ? PxC.getGarantia() : "",true,true,30,iY+170,"",true,true,40)%> 
                    <%=MyUtil.ObjInput("Cantidad","Cantidad",PxC != null ? PxC.getCantidad():"",true,true,300,iY+170,"",true,true,40,"validarEntero(this,this.id);Total();")%> 
                    
                    <%=MyUtil.ObjInput("Valor Unitario","ValorUnitario",PxC != null ? PxC.getValorUnitario():"",true,true,30,iY+210,"",true,true,20,"validarEntero(this,this.id);Total();")%>
                    <%=MyUtil.ObjComboC("Moneda","clTipoMoneda",PxC != null ? PxC.getDsTipoMoneda(): "",true,true,150,iY+210,"","select clTipoMoneda,dsTipoMoneda from ctipoMoneda where activo = 1 ","","",20,true,true)%>
                    

                    <%=MyUtil.ObjInput("IVA","IVA",PxC != null ? PxC.getIVA():"",true,true,300,iY+210,"",true,true,20,"validarEntero(this,this.id);Total();")%> 

                    <%=MyUtil.ObjInput("ValorTotal","ValorTotal",PxC != null ? PxC.getValorTotal():"",false,false,30,iY+250,"",false,false,20,"validarEntero(this,this.id);Total();")%> 
 
                    <%=MyUtil.DoBlock("Producto Solicitado",50,0)%> 
                    
                    <%=MyUtil.GeneraScripts()%> 
 
                    <%  //<<<<<<<<<<<<<<<< Limpiar Variables >>>>>>>>>  
                       StrclUsr = null;  
                       StrclPaginaWeb = null;  
                       daoC_ProductoxCompra = null;  
                       PxC = null;  
                    %>  
 
       
        <script>
            
        //<<<<<<<<<<<< Selecciona el proveedor que se eligio de la lista de asignados >>>>>>>>>>>>>
        function fnActualizaProv(){
            ProvAsig = document.all.clProveedorAsig.value;
            
  
            if (ProvAsig != 0 ){
                document.all.clProveedor.value = ProvAsig;
                document.all.clProveedorC.value = ProvAsig;
                
                fnLlenaProducos();
            }

        }
        
        function fnLlenaProducos(){  
            var strConsulta = "sp_C_GetProductoxProveedor '" + document.all.clProveedor.value + "'";
            var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
            
               document.all.clProducto.value = '';
               pstrCadena = pstrCadena + "&strName=clProductoC";		
               fnOptionxDefault('clProductoC',pstrCadena);
        }
        
         function validarEntero(Dato,id){
            valor=Dato.value;
                if(valor!=""){
                    if (isNaN(valor)) {
                        alert("El Dato debe ser Numerico");
                        document.all[id].focus(); 
                    }  
                }   
          }
            
         function Total(){
            if (document.all.ValorUnitario.value!='' && document.all.Cantidad.value!='' && document.all.IVA.value!=''){
              CostoUni=parseFloat(document.all.ValorUnitario.value);
              Cantidad=parseFloat(document.all.Cantidad.value);
              IVA = parseFloat(document.all.IVA.value);

              document.all.ValorTotal.value = ( CostoUni * Cantidad ) + ( ( IVA / 100 ) * ( CostoUni * Cantidad ) );
            }
         }
            
        </script>
     </body>
</html>
