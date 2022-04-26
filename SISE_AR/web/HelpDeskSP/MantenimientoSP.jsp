<%--
 Document   : MantenimientoSP
 Create on  : 2010-08-05
 Author     : bsanchez
--%>
 
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="Utilerias.UtileriasBDF,Seguridad.SeguridadC,java.sql.ResultSet,com.ike.helpdeskSP.DAOMantenimientoSP,com.ike.helpdeskSP.to.MantenimientoSP;" %>

<html>
    <head><title>MantenimientoSP</title>
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
        String StrclMantenimiento = "0";
        String StrclInventarioSP = "0";
        String StrclPeriferico ="0";
        
        if ( session.getAttribute("clUsrApp") != null) {
            StrclUsr = session.getAttribute("clUsrApp").toString();
        }
        
        if ( SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr) ) != true ) {  %> 
        Fuera de Horario <% 
        StrclUsr = null;
        StrclPaginaWeb = null;
        StrclMantenimiento = null;
        StrclInventarioSP = null;
        StrclPeriferico = null;
        return;
        }
        
   
        
        if ( request.getParameter("clMantenimiento")!= null )  {
             StrclMantenimiento = request.getParameter("clMantenimiento").toString();
            session.setAttribute("clMantenimiento", StrclMantenimiento);
        } else {
            if ( session.getAttribute("clMantenimiento")!= null )  {
                StrclInventarioSP = session.getAttribute("clMantenimiento").toString();
            }
        }
        
        if ( request.getParameter("clInventarioSP")!= null )  {
           StrclInventarioSP = request.getParameter("clInventarioSP").toString();
            session.setAttribute("clInventarioSP",StrclInventarioSP);
        } else {
            if ( session.getAttribute("clInventarioSP")!= null )  {
                StrclInventarioSP = session.getAttribute("clInventarioSP").toString();
            }
        }
        
       if ( request.getParameter("clPeriferico")!= null )  {
            StrclPeriferico = request.getParameter("clPeriferico").toString();
            session.setAttribute("clPeriferico", StrclPeriferico);
        } else {
            if ( session.getAttribute("clPeriferico")!= null )  {
                StrclPeriferico = session.getAttribute("clPeriferico").toString();
            }
        }
    
        DAOMantenimientoSP daoMantenimientoSP = null;
        MantenimientoSP  MSP = null;
        
        daoMantenimientoSP = new DAOMantenimientoSP();
        MSP = daoMantenimientoSP.getclMantenimiento( StrclMantenimiento.toString() );
        
        %><script>fnOpenLinks()</script><% 
        
        StrclPaginaWeb = "1197";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        
        //<<<<<<<<<<<< Servlet Generico >>>>>>>>>>>
        String Store = "";
        Store="st_GuardaMantenimientoSP,st_ActualizaMantenimientoSP";
        session.setAttribute("sp_Stores",Store);
        
        String Commit = "";
        Commit = "clMantenimiento";
        session.setAttribute("Commit",Commit);
        
        %> 
        
        <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb),Integer.parseInt(StrclUsr));%>
        <%=MyUtil.doMenuAct("../servlet/com.ike.guarda.EjecutaSP","","fnsp_Guarda();")%>
        
        
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="MantenimientoSP.jsp?'>"%> 
        
        <input id="clPaginaWeb" name="clPaginaWeb" type="hidden" value="<%=StrclPaginaWeb%>" > 
        <input id="Secuencia" name="Secuencia" type="hidden" value=""> 
        <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="clPeriferico,clInventarioSP,MttoProg,Folio,Realizo"> 
        <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clMantenimiento,clPeriferico,clInventarioSP,MttoProg,Folio,Realizo"> 
        <input id="clUsrApp" name="clUsrApp" type="hidden" value="<%=StrclUsr%>" > 
        
        <%  int iY = 10;  int iX=10; %>
        <input id="clInventarioSP" name="clInventarioSP" type="hidden" value="<%=StrclInventarioSP%>" >  
        <input id="clPeriferico" name="clPeriferico" type="hidden" value="<%=StrclPeriferico%>" >      
        <input id="clMantenimiento" name="clMantenimiento" type="hidden" value="<%=StrclMantenimiento%>" >                     
        <%=MyUtil.ObjInputF("MTTO PROGRAMADO :","MttoProg",MSP != null ? MSP.getMttoProg():"",true,true,iX+20,iY+70,"",true,true,20,1,"")%> 
        <%=MyUtil.ObjInput("FOLIO:","Folio",MSP != null ? MSP.getFolio():"",true,true,iX+20,iY+120,"",false,false,30,"")%>   
        <%=MyUtil.ObjChkBox("SE REALIZO:","Realizo",MSP != null ? MSP.getRealizo():"",true,true,iX+220,iY+120,"0","SI","NO","")%>        
        <%=MyUtil.DoBlock("MANTENIMIENTO",-10,40)%>         
        <%=MyUtil.GeneraScripts()%> 
        
        <%
        //Limpiar Variables
        StrclUsr = null;
        StrclPaginaWeb = null;
        daoMantenimientoSP = null;
        StrclPeriferico=null;
        StrclInventarioSP =null;
        StrclMantenimiento=null;
        MSP = null;  
        
        %>
    </body>
</html>
