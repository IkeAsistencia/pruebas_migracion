<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="com.ike.model.DAOTieneAsistencia,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.asistencias.DAOSeguimientoProveedor,com.ike.asistencias.to.SeguimientoProveedor,Combos.cbEntidad,java.sql.ResultSet;" %>

<html>
    <head>        
        <title>DetalleSeguimientoProveedorA</title>
    </head>

<body class="cssBody" onload="">
 <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">      
   <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
    <script src='../Utilerias/Util.js'></script>                    
    <script src='../Utilerias/UtilDireccion.js'></script>
    <script src='../Utilerias/UtilServicio.js' ></script>
    
    <%
    String StrclUsr = "0";
    String StrclSeguimientoProveedor="0";
    String StrclProveedor="0";
    String StrNomOpe = "";
    String Strfecha="";
    String StrclPaginaWeb = "798";
    
    if (session.getAttribute("clUsrApp" )!= null) {
        StrclUsr = session.getAttribute("clUsrApp").toString();
    }
    
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr)) != true){
    %>Fuera de Horario <%
    
    StrclUsr = null;
    StrclSeguimientoProveedor = null;
    StrclProveedor = null;
    StrNomOpe = null;
    Strfecha = null;
    return;
    }

    if (request.getParameter("clSeguimientoProveedor") != null) {
        StrclSeguimientoProveedor = request.getParameter("clSeguimientoProveedor");
    }
    
    session.setAttribute("clSeguimientoProveedor",StrclSeguimientoProveedor);
    
    if (session.getAttribute("clProveedor")!= null) {
        StrclProveedor= session.getAttribute("clProveedor").toString();
    }
    
    if (session.getAttribute("NombreOpe")!= null) {
        StrNomOpe = session.getAttribute("NombreOpe").toString();
    }
    
    DAOSeguimientoProveedor daoSeguimientoProveedor = null;
    SeguimientoProveedor SP = null;
    
    daoSeguimientoProveedor = new DAOSeguimientoProveedor();
    SP = daoSeguimientoProveedor.getSeguimientoProveedor(StrclSeguimientoProveedor.toString());
    
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    %>
    <script>fnOpenLinks()</script>
    
    <%MyUtil.InicializaParametrosC(798,Integer.parseInt(StrclUsr));
    %>
    <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
 
    
    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="SeguimientoProveedorA.jsp?"%>'>
    <INPUT id='clSeguimientoProveedor' name='clSeguimientoProveedor' type='hidden' value='<%=StrclSeguimientoProveedor%>'>
    <INPUT id='clProveedor' name='clProveedor' type = "hidden" value='<%=StrclProveedor%>'>
    <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsr%>'>
    
    <%
    int iY = 40;
    %> 
    
    <%=MyUtil.ObjInput("Nombre Operativo","NombreOpe",StrNomOpe,false,false,30,80,StrNomOpe,false,false,70,"")%>   
    <%=MyUtil.ObjInput("FECHA DE ALTA <br> (AAAA-MM-DD-HH:MM)<br>AUTOMATICA","fechaVR", SP != null ? SP.getFecha(): "",false,false,440,80,Strfecha,false,false,20,"")%>           
    <%=MyUtil.ObjComboC("MEDIOS DE CONTACTO", "clMediosContacto", SP != null ? SP.getDsMediosContacto(): "", true, true, 30, 125, "", "Select clMediosContacto, dsMediosContacto from cMediosContacto","", "", 50, true, true)%>
    <%=MyUtil.ObjComboC("CLASIFICACION", "clClasificacionSeguimiento", SP != null ? SP.getDsClasificacionSeguimiento(): "", true, true,210, 125, "", "Select clClasificacionSeguimiento, dsClasificacionSeguimiento from cClasificacionSeguimiento","", "", 50, true, true)%>      
    <%=MyUtil.ObjTextArea("OBSERVACIONES", "Observaciones", SP != null ? SP.getObservaciones(): "", "105", "5", true, true, 30, 180, "", true, false)%>
    <%=MyUtil.DoBlock("SEGUIMIENTO PROVEEDOR",20,50)%>
    
    <%=MyUtil.GeneraScripts()%>
    
    <%
    daoSeguimientoProveedor = null;
    SP = null;
        
    StrclSeguimientoProveedor=null;
    StrclUsr = null;
    StrclPaginaWeb = null;
    StrclProveedor = null;
    StrNomOpe = null;
    %>
    <script>
    </script>        
</body>       
</html>
