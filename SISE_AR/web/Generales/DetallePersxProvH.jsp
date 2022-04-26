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

    String StrclPersonalxProv = "0";
    String StrclUsrApp="0";
    String StrclProveedor="0";
    String StrNomOpe="";
    
    

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

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {%>
       Fuera de Horario
      <%
      
      return;
     }     
    
    if (request.getParameter("clPersonalxProv") != null)
    {
      StrclPersonalxProv = request.getParameter("clPersonalxProv");
    }    
    
    StringBuffer StrSql = new StringBuffer();
    
    StrSql.append("select PxP.clPersonalxProv, PxP.Nombre, NombreOpe ");
    StrSql.append(" from PersonalxProv PxP inner join cProveedor P on (PxP.clProveedor = P.clProveedor)");
    StrSql.append(" where PxP.clPersonalxProv =").append(StrclPersonalxProv);

     ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
     StrSql.delete(0,StrSql.length());
    
       String StrclPaginaWeb = "273";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %>
        <SCRIPT>fnOpenLinks()</script>
        <%
       MyUtil.InicializaParametrosC(273,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 
       %>
       <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
      <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetallePersxProvH.jsp?'>"%>
       <%
       session.setAttribute("clPersonalxProv",StrclPersonalxProv);
       
       if (rs.next()) {
           %>
            <INPUT id='clPersonalxProv' name='clPersonalxProv' type='hidden' value='<%=StrclPersonalxProv%>'><br><br><br><br>
            <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
            <%=MyUtil.ObjInput("Proveedor","NombreOpe",StrNomOpe,false,false,20,100,StrNomOpe,false,false,70)%>
            <%=MyUtil.ObjInput("Nombre del Personal","Nombre",rs.getString("Nombre"),true,true,20,150,"",true,true,70)%>
        <%    
        }
       else {
        %>
            <INPUT id='clPersonalxProv' name='clPersonalxProv' type='hidden' value='<%=StrclPersonalxProv%>'><br><br><br><br>
            <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
            <%=MyUtil.ObjInput("Proveedor","NombreOpe",StrNomOpe,true,false,20,100,StrNomOpe,false,false,70)%>
            <%=MyUtil.ObjInput("Nombre del Personal","Nombre","",true,true,20,150,"",true,true,70)%>
         <%
        } 
        rs.close();
        rs=null;
        StrSql = null;
        
        StrclPersonalxProv = null;
        StrclUsrApp=null;
        StrclProveedor=null;
        StrNomOpe=null;
         %>
          <%=MyUtil.DoBlock("Detalle de Personal por Proveedor",190,0)%>
          <%=MyUtil.GeneraScripts()%>
</body>
</html>