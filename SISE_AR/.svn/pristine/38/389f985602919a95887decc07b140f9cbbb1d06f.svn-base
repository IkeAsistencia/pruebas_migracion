<%-- 
    Document   : CambioSubservicio
    Created on : 27/11/2008, 09:45:52 AM
    Author     : rurbina
--%>

<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>


<html>
    <head><title>Cambio de Subservicio</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        
    </head>
    
    <body class="cssBody">
        
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/> 
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilMask.js'></script>
        
        <%
        String StrclUsrApp = "";
        String StrclPaginaWeb = "";
        String StrclExpediente = "";
        String StrSubservicio = "";
        
        if (session.getAttribute("clUsrApp") != null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        } else {
            StrclUsrApp = request.getParameter("clUsrApp");
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
        StrclUsrApp = null;
        StrclPaginaWeb = null;
        StrclExpediente = null;
        StrSubservicio = null;
        return;
        }
        
        if (request.getParameter("clExpediente") != null) {
            StrclExpediente = request.getParameter("clExpediente");
        }
        
        
        StringBuffer StrSql = new StringBuffer();
        
        StrSql.append("st_getCambioSubservicio ").append(StrclExpediente);
        System.out.println(StrSql);
        
        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0, StrSql.length());
        
        StrclPaginaWeb = "792";
        MyUtil.InicializaParametrosC(792, Integer.parseInt(StrclUsrApp));
        session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        
        %>
        
          
        <%=MyUtil.doMenuAct("../servlet/Utilerias.CambioSubservicio","","")%>
        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='792'>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="CambioSubservicio.jsp?"%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrApp%>'>
        
        <%
        if (rs.next()) {
            StrSubservicio = rs.getString("clSubservicio");
        %>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>  
        
        <%=MyUtil.ObjInput("Expediente", "clExpediente", StrclExpediente, false, false, 30, 80, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Subservicio ACTUAL", "clSubservicio", rs.getString("dsSubServicio"), false, false, 30, 120, rs.getString("dsSubServicio"), false, false, 50)%>
        <%=MyUtil.ObjComboC("Nuevo SubServicio", "clSubservicioNuevo", "", true, true, 30, 160, "", "st_LlenaCambioSubservicio " + StrSubservicio, "", "", 50, true, true)%> 
        <%=MyUtil.DoBlock("Cambio de Subservicio", 85, 0)%>
        <% }%>
        
        
        
        <%=MyUtil.GeneraScripts()%>
        <%
        
        rs.close();
        rs = null;
        
        StrSql = null;
        
        StrclUsrApp = null;
        StrclPaginaWeb = null;
        StrclExpediente = null;
        StrSubservicio = null;
        
        %>
    </body>
</html>
