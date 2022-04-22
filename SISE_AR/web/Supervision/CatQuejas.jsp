<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
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
        <script src='../Utilerias/UtilMask.js'></script>
        <%

            String StrclQueja = "0";
            String StrclPaginaWeb = "6089";
            String StrclUsrApp = "0";
            
            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {%>
        Fuera de Horario
        <% return;
            }
            if (request.getParameter("clQueja") != null) {
                StrclQueja = request.getParameter("clQueja").toString();
            }

            StringBuffer StrSql = new StringBuffer();

            StrSql.append(" st_getDetQueja ").append(StrclQueja);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
        %> 

        <script>fnOpenLinks()</script>

        <%
            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %> 
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "", "")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1) + "CatQuejas.jsp?"%>'>
        <% if (rs.next()) {%>
            <INPUT id='clDeficiencia' name='clQueja' type='hidden' value='<%=StrclQueja%>'>
            <%=MyUtil.ObjInput("Queja", "dsQueja", rs.getString("dsQueja"), true, false, 30, 70, "", false, false, 70, "")%>
            <%=MyUtil.ObjChkBox("Activo", "Activo", rs.getString("Activo"), true, true, 30, 110, "0", "Activo", "Inactivo", "")%>
        <% } else {%>
            <INPUT id='clDeficiencia' name='clQueja' type='hidden' value='<%=StrclQueja%>'>
            <%=MyUtil.ObjInput("Queja", "dsQueja", "", true, false, 30, 70, "", false, false, 70, "")%>
            <%=MyUtil.ObjChkBox("Activo", "Activo", "", true, true, 30, 110, "0", "Activo", "Inactivo", "")%>
        <% } %>
        <%=MyUtil.DoBlock("Catálogo de Quejas", 190, 5)%> 
        <%=MyUtil.GeneraScripts()%>
    </body>
</html>