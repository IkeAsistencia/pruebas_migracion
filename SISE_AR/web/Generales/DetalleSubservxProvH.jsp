<%@page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@page import="Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.generales.DAOSubServxProv,com.ike.generales.to.SubServxProv"%>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>JSP Page</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilServicio.js' ></script>
        
        <%  
        String StrclProveedor = "0";
        String StrclServicio = "0";
        String StrclSubServicio = "0";
        String StrNomOpe = "";
        String StrclUsrApp="0";
        
        if (session.getAttribute("clUsrApp")!= null){
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (session.getAttribute("clProveedor")!= null){
            StrclProveedor = session.getAttribute("clProveedor").toString();
        }
        
        if (session.getAttribute("NombreOpe")!= null){
            StrNomOpe = session.getAttribute("NombreOpe").toString();
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %><%="Fuera de Horario"%><%;  return; 
        }     
        
        if (request.getParameter("clServicio") != null){
        StrclServicio = request.getParameter("clServicio");
        }    
        if (request.getParameter("clSubServicio") != null){
        StrclSubServicio = request.getParameter("clSubServicio");
        }    
        
        DAOSubServxProv dao = new DAOSubServxProv();        
        SubServxProv sub = null;
        
        if (!StrclProveedor.equalsIgnoreCase("0")){
        
        sub = dao.getSubServxProv(StrclProveedor,StrclServicio,StrclSubServicio);
        }
        
        String StrclPaginaWeb = "350";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %><SCRIPT>fnOpenLinks()</script><%
        
        
        MyUtil.InicializaParametrosC(350,Integer.parseInt(StrclUsrApp)); 
        %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleSubservxProvH.jsp?'>"%><INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
        
        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='<%=StrclPaginaWeb%>'>
        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
        
        <%=MyUtil.ObjInput("Nombre Operativo","NombreOpe",StrNomOpe,false,false,20,100,StrNomOpe,false,false,70)%>            
        <%=MyUtil.ObjInput("Prioridad","Prioridad",sub != null ? sub.getPrioridad() : "",true,true,420,100,"",true,true,5)%>    
        <%=MyUtil.ObjComboC("Servicio","clServicio",sub != null ? sub.getDsServicio() : "",true,true,20,140,"0","SELECT clServicio, dsServicio FROM cServicio ORDER BY dsServicio ","fnLlenaSubServicios()","",50,true,true)%>            
        <%=MyUtil.ObjComboC("Subservicio","clSubServicio",sub != null ? sub.getDsSubServicio() : "",true,true,250,140,"0","SELECT clSubServicio, dsSubServicio FROM cSubServicio where clServicio = "+StrclServicio +" ORDER BY dsSubServicio ","","",50,true,true)%>            
        <%=MyUtil.ObjInput("Costo Base","Costo",sub != null ? sub.getCosto() : "",true,true,380,180,"0",true,true,10)%>            
        <%=MyUtil.ObjTextArea("Observaciones","Observaciones",sub != null ? sub.getObservaciones() : "","60","3",true,true,20,180,"",false,false)%>
        
        <%=MyUtil.DoBlock("Detalle de Subservicio por Proveedor Hogar",0,30)%>
        <%=MyUtil.GeneraScripts()%>
        
        <%
        
        StrclProveedor =null;
        StrclServicio = null;
        StrclSubServicio =null;
        StrNomOpe = null;
        StrclUsrApp=null;
        StrclPaginaWeb=null;
        
        dao=null;
        sub=null;
        
        %> 
    </body>
</html>