<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.helpdeskSP.DAOHelpdeskSP,com.ike.helpdeskSP.HelpdeskSP,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>

<html>
    <head><title>CALIFICACION SOPORTE</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilDireccion.js'></script>
        <script src='../Utilerias/UtilStore.js'></script>
        
        <%
        String StrclSolicitud = "0";
        String StrclUsrApp = "0";
        String StrclEstatus ="0";
        
        if (session.getAttribute("clUsrApp")!= null){
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %>Fuera de Horario <%
        
        StrclUsrApp=null;
        return;
        }
        
        if (session.getAttribute("clSolicitud")!= null) {
            StrclSolicitud= session.getAttribute("clSolicitud").toString();
        }
        
        DAOHelpdeskSP daoCalificacionSP = null;
        HelpdeskSP CSP = null;
        
        daoCalificacionSP = new DAOHelpdeskSP();
        CSP = daoCalificacionSP.getHelpdeskSP(StrclSolicitud.toString());
        
        String StrclPaginaWeb = "981";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>        
        <%//servlet generico
        String Store="";
        
        Store="st_GuardaHelpdeskCalificacion,st_ActualizaHelpdeskCalificacion";
        
        session.setAttribute("sp_Stores",Store);
        
        String Commit="";
        Commit="clSolicitud";
        
        session.setAttribute("Commit",Commit);
        %>
        <script>fnOpenLinks()</script>  
        
        <%
        StrclEstatus = CSP != null ? CSP.getclEstatus().toString() : "0";
        %>
        
        <% if (StrclEstatus.equalsIgnoreCase("4")) {%>
        
        <%MyUtil.InicializaParametrosC(981,Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../servlet/com.ike.guarda.EjecutaSP","","fnsp_Guarda();")%>
        
        <script> document.all.btnCambio.disabled=true;</script>
        
        <%
        if  (!CSP.getDsAtencion().equalsIgnoreCase("")  ||
                !CSP.getDsDominio().equalsIgnoreCase("") ||
                !CSP.getDsActitud().equalsIgnoreCase("") ||
                !CSP.getDsServicio().equalsIgnoreCase("") ||
                !CSP.getDsTiempodeEspera().equalsIgnoreCase("")
                ){
        %><script> document.all.btnAlta.disabled=true;</script><%
        }
        %>
        
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="CalificacionSP.jsp?'>"%>
        <%  int iY = 40; %>
        
        <input id="Secuencia" name="Secuencia" type="hidden" value="">        
        <input id="SecuenciaG" name="SecuenciaG" type="hidden"  VALUE="clSolicitud,clAtencion,clDominio,clActitud,clServicio,clTiempodeEspera">       
        <input id="SecuenciaA" name="SecuenciaA" type="hidden"  VALUE="clSolicitud,clAtencion,clDominio,clActitud,clServicio,clTiempodeEspera">  
        
        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='HIDDEN' value='<%=StrclPaginaWeb%>'>
        <INPUT id='clSolicitud' name='clSolicitud' type='HIDDEN' value='<%=StrclSolicitud%>'>
        
        <%=MyUtil.ObjComboC("ATENCION","clAtencion",CSP != null ? CSP.getDsAtencion():"",true,true,20,80,"","select * from cTipoServicioSP ","","",10,true,false)%>
        <%=MyUtil.ObjComboC("DOMINIO","clDominio",CSP != null ? CSP.getDsDominio():"",true,true,190,80,"","select * from cTipoServicioSP ","","",10,true,false)%>
        <%=MyUtil.ObjComboC("ACTITUD","clActitud",CSP != null ? CSP.getDsActitud():"",true,true,360,80,"","select * from cTipoServicioSP ","","",10,true,false)%>
        <%=MyUtil.ObjComboC("SERVICIO","clServicio",CSP != null ? CSP.getDsServicio():"",true,true,530,80,"","select * from cTipoServicioSP ","","",10,true,false)%>
        <%=MyUtil.ObjComboC("TIEMPO DE RESPUESTA","clTiempodeEspera",CSP != null ? CSP.getDsTiempodeEspera():"",true,true,700,80,"","select * from cTipoServicioSP ","","",10,true,false)%>
        <%=MyUtil.DoBlock("CALIFICACION DE SERVICIO",10,20)%>
        
        <%=MyUtil.GeneraScripts()%> 
        
        <%} else {%>
        *** NO SE PUEDE CALIFICAR LA SOLICITUD HASTA CONCLUIR EL FOLIO ***
        <% }
        
        StrclSolicitud=null;
        StrclUsrApp=null;
        StrclEstatus=null;
        StrclPaginaWeb=null;
        Store=null;
        Commit=null;

        daoCalificacionSP =null;
        CSP=null;
        
        %>
    </body>
    

</html>
