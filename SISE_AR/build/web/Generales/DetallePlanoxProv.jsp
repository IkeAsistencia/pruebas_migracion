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
    String StrclPlanoRojixProv = "0";
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
    
    if (request.getParameter("clPlanoRojixProv") != null)
    {
      StrclPlanoRojixProv = request.getParameter("clPlanoRojixProv");
    }    
    
    StringBuffer StrSql = new StringBuffer();
    
    StrSql.append("select PxP.clPlanoRojixProv, PxP.Plano, NombreOpe, PxP.Prioridad,PxP.clProveedor");
    StrSql.append(" from PlanoRojixProv PxP inner join cProveedor P on (PxP.clProveedor = P.clProveedor)");
    StrSql.append(" where PxP.clPlanoRojixProv =").append(StrclPlanoRojixProv);

     ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
     StrSql.delete(0,StrSql.length());
    
       String StrclPaginaWeb = "233";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %>
       <SCRIPT>fnOpenLinks()</script>
       <%
       MyUtil.InicializaParametrosC(233,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 
       %>
       <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
      <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetallePlanoxProv.jsp?'>"%>
       <%
       if (rs.next()) {
           %>
            <INPUT id='clPlanoRojixProv' name='clPlanoRojixProv' type='hidden' value='<%=StrclPlanoRojixProv%>'><br><br><br><br>
            <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=rs.getString("clProveedor")%>'>
            <%=MyUtil.ObjInput("Nombre Operativo","NombreOpe",rs.getString("NombreOpe"),true,false,20,100,rs.getString("NombreOpe"),false,false,70)%>
            <%=MyUtil.ObjInput("Plano","Plano",rs.getString("Plano"),true,true,20,150,"",true,true,70)%>
            <%=MyUtil.ObjInput("Prioridad","Prioridad",rs.getString("Prioridad"),true,true,470,150,"",true,true,10)%>
        <%    
        }
       else {
        %>
            <INPUT id='clPlanoRojixProv' name='clPlanoRojixProv' type='hidden' value='<%=StrclPlanoRojixProv%>'><br><br><br><br>
            <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
            <%=MyUtil.ObjInput("Nombre Operativo","NombreOpe",StrNomOpe,false,false,20,100,StrNomOpe,false,false,70)%>
            <%=MyUtil.ObjInput("Plano","Plano","",true,true,20,150,"",true,true,70)%>
            <%=MyUtil.ObjInput("Prioridad","Prioridad","",true,true,470,150,"",true,true,10)%>
         <%
        }
        StrclPlanoRojixProv =null;
        StrclUsrApp=null;
        StrclProveedor=null;
        StrNomOpe=null;
        StrSql=null;
        rs.close();
        rs=null;
        
         %>
          <%=MyUtil.DoBlock("Detalle de Plano por Proveedor")%>
          <%=MyUtil.GeneraScripts()%>
<script>
     document.all.Plano.maxLength=3;
     document.all.Prioridad.maxLength=1;
</script>
</body>
</html>