<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title>Asignacion de Grupos</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>

        <%
            String StrclUsrApp = "0";
            String StrclUsrxGpo = "0";
            String StrclPaginaWeb = "128";
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

            if (request.getParameter("clUsrxGpo") != null) {
                StrclUsrxGpo = request.getParameter("clUsrxGpo").toString();
            }

            StringBuffer StrSQL = new StringBuffer();
            ResultSet rs = UtileriasBDF.rsSQLNP("st_usrxgpo " + StrclUsrxGpo);
            StrSQL.delete(0, StrSQL.length());

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

            MyUtil.InicializaParametrosC(128, Integer.parseInt(StrclUsrApp));
        %>

        <script>fnOpenLinks()</script>

        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>UsrxGpo.jsp?'>
        <% if (rs.next()) {%>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=rs.getString("clUsrApp")%>'>
        <INPUT id='clUsrxGpo' name='clUsrxGpo' type='hidden' value='<%=StrclUsrxGpo%>'>
        <%=MyUtil.ObjComboC("Grupo", "clGpoUsr", rs.getString("dsGpoUsr"), true, true, 30, 80, "", "st_CatalogoGrupos " + StrclUsrApp, "", "", 100, true, true)%>
        <% } else {%>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrApp2%>'>
        <INPUT id='clUsrxGpo' name='clUsrxGpo' type='hidden' value='<%=StrclUsrxGpo%>'>
        <%=MyUtil.ObjComboC("Grupo", "clGpoUsr", "", true, true, 30, 80, "", "st_CatalogoGrupos " + StrclUsrApp, "", "", 100, true, true)%>
        <%}%>

        <%=MyUtil.DoBlock("Grupos", 250, 0)%>
        <%=MyUtil.GeneraScripts()%>
        <%
            rs.close();
            rs = null;
            StrSQL = null;
            StrclUsrApp = null;
            StrclUsrxGpo = null;
            StrclPaginaWeb = null;
        %>
    </body>
</html>