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

<%  

    String StrclContactoxPersonal = "0";
    String StrclUsrApp="0";
    String StrclProveedor="0";
    String StrclPersonalxProv="0";
    String StrNomOpe="";
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    
     if (session.getAttribute("clProveedor")!= null)
     {
       StrclProveedor = session.getAttribute("clProveedor").toString(); 
     }  
    
     if (session.getAttribute("clPersonalxProv")!= null)
     {
       StrclPersonalxProv = session.getAttribute("clPersonalxProv").toString(); 
     }  

     if (session.getAttribute("NombreOpe")!= null)
     {
       StrNomOpe = session.getAttribute("NombreOpe").toString(); 
     }  

   if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {
       %><%="Fuera de Horario"%><%
       
        return; 
     }     
    
    if (request.getParameter("clContactoxPersonal") != null)
    {
      StrclContactoxPersonal = request.getParameter("clContactoxPersonal");
    }    
    StringBuffer StrSql1 = new StringBuffer();
    StrSql1.append( "select CxP.clContactoxPersonal, CxP.Contacto, TC.clTipoContacto, ");
StrSql1.append(" TC.dsTipoContacto ");
StrSql1.append(" from ContactoxPersonal CxP inner join cProveedor P on (CxP.clProveedor = P.clProveedor)");
StrSql1.append(" inner join cTipoContacto TC on (TC.clTipoContacto = CxP.clTipoContacto) ");
StrSql1.append(" where CxP.clContactoxPersonal =").append(StrclContactoxPersonal);
ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());
    StrSql1.delete(0,StrSql1.length());
       String StrclPaginaWeb = "360";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %>
       <SCRIPT>fnOpenLinks()</script>
       <%
       MyUtil.InicializaParametrosC(360,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 
       %>
       <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleContxPersV.jsp?'>"%>
       <INPUT id='clContactoxPersonal' name='clContactoxPersonal' type='hidden' value='<%=StrclContactoxPersonal%>'><br><br><br><br>
        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor %>'>
        <INPUT id='clPersonalxProv' name='clPersonalxProv' type='hidden' value='<%=StrclPersonalxProv%>'>
        <%
       if (rs.next()) {
       %>
            <%=MyUtil.ObjInput("Proveedor","NombreOpe",StrNomOpe,false,false,20,100,StrNomOpe,false,false,70)%>
            <%=MyUtil.ObjComboC("Tipo de Contacto","clTipoContacto",rs.getString("dsTipoContacto"),true,true,20,140,"","Select clTipoContacto, dsTipoContacto from cTipoContacto order by dsTipoContacto ","","",50,true,true)%>
            <%=MyUtil.ObjInput("Contacto","Contacto",rs.getString("Contacto"),true,true,20,180,"",true,true,70)%>
            <%
        }
       else {
        %>
            <%=MyUtil.ObjInput("Proveedor","NombreOpe",StrNomOpe,false,false,20,100,StrNomOpe,false,false,70)%>
            <%=MyUtil.ObjComboC("Tipo de Contacto","clTipoContacto","",true,true,20,140,"","Select clTipoContacto, dsTipoContacto from cTipoContacto order by dsTipoContacto ","","",50,true,true)%>
            <%=MyUtil.ObjInput("Contacto","Contacto","",true,true,20,180,"",true,true,70)%>
            <%
        }     
        %>
          <%=MyUtil.DoBlock("Detalle de Medio de Contacto",190,0)%>
          <%=MyUtil.GeneraScripts()%>
        
<%        
 rs.close();
    rs=null;
    StrSql1=null;
    
    StrclUsrApp=null;
    StrclProveedor=null;
    StrclPersonalxProv=null;
    StrNomOpe=null;
    StrclPaginaWeb=null;
    
%>  
</body>
</html>