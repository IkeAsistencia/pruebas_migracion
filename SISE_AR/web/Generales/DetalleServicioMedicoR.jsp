<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">

<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>


<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<script src='../Utilerias/UtilDireccion.js' ></script>
<%  

    String StrclProveedor = "";
    String StrNomOpe = "";
    String StrNombreCA = "";
    String StrclCentroAtencion = "";
    String StrclServicioMedico = "";
    String StrclServicioMedxCentro = "0";

    
    

    String StrSql = "";    
    String StrclUsrApp="0";

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    
     if (session.getAttribute("clProveedor")!= null)
     {
       StrclProveedor = session.getAttribute("clProveedor").toString(); 
     }  
     
     if (session.getAttribute("NombreOpe")!= null)
     {
       StrNomOpe = session.getAttribute("NombreOpe").toString(); 
     } 

     if (session.getAttribute("clCentroAtencion")!= null)
     {
       StrclCentroAtencion = session.getAttribute("clCentroAtencion").toString(); 
     }  

     if (request.getParameter("clServicioMedxCentro")!= null)
     {
       StrclServicioMedxCentro = request.getParameter("clServicioMedxCentro").toString();  
     } 

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {
       %><%="Fuera de Horario"%><%
       
        return; 
     }     
     
      StringBuffer StrSql1 = new StringBuffer();
      
      StrSql1.append(" select NmbCentroAtecion as NombreCA from CentroAtencion where clCentroAtencion= ").append(StrclCentroAtencion);
      ResultSet rsCA = UtileriasBDF.rsSQLNP(StrSql1.toString());                  
      StrSql1.delete(0,StrSql1.length());      
       
      if (rsCA.next()) { StrNombreCA = rsCA.getString("NombreCA"); }
             
      StrSql1.append(" select SXC.clProveedor,PRO.NombreOpe as NombreOpe,SXC.clCentroAtencion,CA.NmbCentroAtecion as CentroA, ");
      StrSql1.append(" SXC.clServicioMedico,SM.dsServicioMedico as ServicioM");
      StrSql1.append(" from ServicioMedxCentroAtencion SXC ");
      StrSql1.append(" inner join cproveedor PRO on (SXC.clProveedor=PRO.clProveedor) ");
      StrSql1.append(" inner join CentroAtencion CA on (SXC.clCentroAtencion=CA.clCentroAtencion) ");
      StrSql1.append(" inner join cServicioMedico SM on (SXC.clServicioMedico=SM.clServicioMedico) ");
      StrSql1.append(" where SXC.clServicioMedxCentro= ").append(StrclServicioMedxCentro);
             
      ResultSet rs = UtileriasBDF.rsSQLNP(StrSql1.toString());            
      
      StrSql1.delete(0,StrSql1.length());
      

      
       String StrclPaginaWeb = "495";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %>
       <SCRIPT>fnOpenLinks()</script>
       <%
       MyUtil.InicializaParametrosC(495,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 
       %>
       <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleServicioMedicoR.jsp?'>"%>
       <%
           if (rs.next()) {
               %>
            <INPUT id='clServicioMedxCentro' name='clServicioMedxCentro' type='hidden' value='<%=StrclServicioMedxCentro%>'>
            <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
            <INPUT id='clCentroAtencion' name='clCentroAtencion' type='hidden' value='<%=StrclCentroAtencion%>'>
            
            <%=MyUtil.ObjInput("Nombre Operativo Proveedor","NombreOpeVTR",rs.getString("NombreOpe"),false,false,30,80,StrNomOpe,false,false,50)%>
            <%=MyUtil.ObjInput("Centro Atencion","NmbCentroAtecionVTR",rs.getString("CentroA"),false,false,330,80,StrNombreCA,false,false,50)%>
            <%=MyUtil.ObjComboC("Servicios Médicos","clServicioMedico",rs.getString("ServicioM"),true,true,30,120,"","SELECT clServicioMedico,dsServicioMedico FROM cServicioMedico","","",45,true,true)%>
            <%=MyUtil.DoBlock("Detalle Servicios Médicos del Centro de Atención (Redes Médicas)",90,30)%>     
            <%
        }
       else {  
               %>
               
               
            <INPUT id='clServicioMedxCentro' name='clServicioMedxCentro' type='hidden' value=''>
            <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
            <INPUT id='clCentroAtencion' name='clCentroAtencion' type='hidden' value='<%=StrclCentroAtencion%>'>
            
            <%=MyUtil.ObjInput("Nombre Operativo Proveedor","NombreOpeVTR",StrNomOpe,false,false,30,80,StrNomOpe,false,false,50)%>
            <%=MyUtil.ObjInput("Centro Atencion","NmbCentroAtecionVTR",StrNombreCA,false,false,330,80,StrNombreCA,false,false,50)%>
            <%=MyUtil.ObjComboC("Servicios Médicos","clServicioMedico","",true,true,30,120,"","SELECT clServicioMedico,dsServicioMedico FROM cServicioMedico","","",45,true,true)%>
            <%=MyUtil.DoBlock("Detalle Servicios Médicos del Centro de Atención (Redes Médicas)",90,30)%>     
            <%
        } 
         %>
       
       <%=MyUtil.GeneraScripts()%>
<%
    rs.close();
    rs=null;
    rsCA.close();
    rsCA=null;
    
    StrSql1=null;
    StrclProveedor=null;  
    StrNomOpe=null;
    StrclCentroAtencion=null; 
    StrclServicioMedxCentro=null; 
        
    StrclPaginaWeb=null;
%>
</body>
</html>
