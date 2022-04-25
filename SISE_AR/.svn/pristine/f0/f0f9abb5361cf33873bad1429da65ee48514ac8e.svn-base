<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title>Asignacion de Sector de Derivación</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>

        <%
            String StrclUsrApp = "0";
            String StrclUsrSector = "0";
            String StrclPaginaWeb = "6098";
            String StrclUsrApp2 = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clUsrApp2") != null) {
                StrclUsrApp2 = session.getAttribute("clUsrApp2").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %>Fuera de Horario<%
                StrclUsrApp = null;
                return;
            }

            if (request.getParameter("clUsrSector") != null) {
                StrclUsrSector = request.getParameter("clUsrSector").toString();
            }
                                                
            StringBuffer StrSQL = new StringBuffer();
            ResultSet rs = UtileriasBDF.rsSQLNP("st_usrxSector " + StrclUsrSector);
            StrSQL.delete(0, StrSQL.length());

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp));
        %>

        <script>fnOpenLinks()</script>

        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>UsxSector.jsp?'>
        <% if (rs.next()) {%>
            <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=rs.getString("clUsrApp")%>'>
            <INPUT id='clUsrSector' name='clUsrSector' type='hidden' value='<%=StrclUsrSector%>'>
            <%=MyUtil.ObjComboC("Sectores de Derivación", "clSector", rs.getString("dsSector"), true, true, 30, 80, "", "st_CatalogoSectores " + StrclUsrApp, "", "", 100, true, true)%>
        <% } else {%>
            <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrApp2%>'>
            <INPUT id='clUsrSector' name='clUsrSector' type='hidden' value='<%=StrclUsrSector%>'>
            <%=MyUtil.ObjComboC("Sector de Derivación", "clSector", "", true, true, 30, 80, "", "st_CatalogoSectores " + StrclUsrApp, "", "", 100, true, true)%>
        <%}%>

        <%=MyUtil.DoBlock("Sectores de Derivación", 250, 0)%>
        <%=MyUtil.GeneraScripts()%>
        <%
            rs.close();
            rs = null;
            StrSQL = null;
            StrclUsrApp = null;
            StrclUsrSector = null;
            StrclPaginaWeb = null;
        %>
    </body>
</html>