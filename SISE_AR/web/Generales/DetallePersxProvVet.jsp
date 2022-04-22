<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>Detalle del Personal por Proveedor (VETERINARIO)</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../Utilerias/Util.js' ></script>

        <%
        String StrclPersonalxProv = "0";
        String StrclUsrApp = "0";
        String StrclProveedor = "0";
        String StrNomOpe = "";

        if (session.getAttribute("clUsrApp") != null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if (StrclProveedor.compareToIgnoreCase("0") == 0) {
            if (session.getAttribute("clProveedor") != null) {
                StrclProveedor = session.getAttribute("clProveedor").toString();
            }
        }
        session.setAttribute("clProveedor", StrclProveedor);

        if (session.getAttribute("NombreOpe") != null) {
            StrNomOpe = session.getAttribute("NombreOpe").toString();
        }

        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %> Fuera de Horario <%
            StrclPersonalxProv = null;
            StrclUsrApp = null;
            StrclProveedor = null;
            StrNomOpe = null;
            return;
        }

        if (request.getParameter("clPersonalxProv") != null) {
            StrclPersonalxProv = request.getParameter("clPersonalxProv");
        }

        StringBuffer StrSql = new StringBuffer();

        StrSql.append("select PxP.clPersonalxProv, PxP.Nombre, NombreOpe, PxP.Activo ");
        StrSql.append(" from PersonalxProv PxP inner join cProveedor P on (PxP.clProveedor = P.clProveedor)");
        StrSql.append(" where PxP.clPersonalxProv =").append(StrclPersonalxProv);

        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0, StrSql.length());

        String StrclPaginaWeb = "5012";
        session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        session.setAttribute("clPersonalxProv", StrclPersonalxProv);
        %>
        <script>fnOpenLinks()</script>
        <%
        MyUtil.InicializaParametrosC(5012, Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
%>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetallePersxProvVet.jsp?"%>'>
        <INPUT id='clPersonalxProv' name='clPersonalxProv' type='hidden' value='<%=StrclPersonalxProv%>'><br><br><br><br>
        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
        <%
        if (rs.next()) {
        %>
        <%=MyUtil.ObjInput("Proveedor", "NombreOpe", StrNomOpe, false, false, 20, 100, StrNomOpe, false, false, 70)%>
        <%=MyUtil.ObjInput("Nombre del Personal", "Nombre", rs.getString("Nombre"), true, true, 20, 150, "", true, true, 70)%>
        <%=MyUtil.ObjChkBox("Activo", "Activo", rs.getString("Activo"), true, true, 20, 200, "0", "SI", "NO", "")%>
        <%
        } else {
        %>
        <%=MyUtil.ObjInput("Proveedor", "NombreOpe", StrNomOpe, true, false, 20, 100, StrNomOpe, false, false, 70)%>
        <%=MyUtil.ObjInput("Nombre del Personal", "Nombre", "", true, true, 20, 150, "", true, true, 70)%>
        <%=MyUtil.ObjChkBox("Activo", "Activo", "", true, true, 20, 200, "0", "SI", "NO", "")%>
        <% }%>
        <%=MyUtil.DoBlock("Detalle de Personal por Proveedor", 190, 0)%>
        <%=MyUtil.GeneraScripts()%>
        <%
        rs.close();
        rs = null;

        StrSql = null;
        StrclPersonalxProv = null;
        StrclUsrApp = null;
        StrclProveedor = null;
        StrNomOpe = null;
        StrclPaginaWeb = null;
        %>
    </body>
</html>