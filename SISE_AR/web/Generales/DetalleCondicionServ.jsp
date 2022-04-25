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
    String StrclUsrApp="0";
    String StrclCondicionServicio="0";
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    
     if (request.getParameter("clCondicionServicio")!= null)
     {
       StrclCondicionServicio = request.getParameter("clCondicionServicio").toString(); 
     }  

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {
      %><%="Fuera de Horario"%><%
      
        return; 
     }     
    StringBuffer StrSql = new StringBuffer();
    StrSql.append(" select clCondicionServicio, dsCondicionServicio");
    StrSql.append(" from cCondicionServicio");
    StrSql.append(" Where clCondicionServicio=").append(StrclCondicionServicio);
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
    
       String StrclPaginaWeb = "150";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);

       MyUtil.InicializaParametrosC(150,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 
       %>
       <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleCondicionServ.jsp?'>"%> 
       <%
       if (rs.next()) {
           %>
            <INPUT id='clCondicionServicio' name='clCondicionServicio' type='hidden' value='<%=StrclCondicionServicio%>'>
            <%=MyUtil.ObjInput("Descripción","dsCondicionServicio",rs.getString("dsCondicionServicio"),true,true,20,100,"",true,true,50)%>
            <%
        }
       else {
           %>
            <INPUT id='clCondicionServicio' name='clCondicionServicio' type='hidden' value=''>
            <%=MyUtil.ObjInput("Descripción","dsCondicionServicio","",true,true,20,100,"",true,true,50)%>
            <%
        }     
      %>
       <%=MyUtil.DoBlock("Detalle de Condicion de Servicio",150,0)%>
       <%=MyUtil.GeneraScripts()%>
<%
    rs.close();
    rs=null;
    StrSql=null;
    
    StrclPaginaWeb=null;
    StrclCondicionServicio=null;
%>
</body>
</html>