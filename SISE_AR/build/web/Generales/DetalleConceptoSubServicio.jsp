<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,Utilerias.UtileriasObj" errorPage="" %>
<html>
    <head>
        <title>Detalle Cobertura del Proveedor Veterinario</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script type="text/javascript"  src='../Utilerias/Util.js' ></script>

        <%

            String StrclConceptoxSubServicio = "0";
            String StrclSubServicio = "0";
            String StrclPaginaWeb = "321";
            String StrclUsrApp = "0";
            StringBuffer StrSql = new StringBuffer();

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clSubServicio") != null) {
                StrclSubServicio = session.getAttribute("clSubServicio").toString();
            }

            if (request.getParameter("clConceptoxSubServicio") != null) {
                if (request.getParameter("clConcepto") != "") {
                    StrclConceptoxSubServicio = request.getParameter("clConceptoxSubServicio").toString();
                }
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) { %>
        Fuera de Horario
        <%
                StrclConceptoxSubServicio = null;
                StrclUsrApp = null;
                return;
            }

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

            StrSql.append("st_getConceptoxSubServ ").append(StrclConceptoxSubServicio);

            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());

            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp));
        %>

        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "", "")%>
        <input id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1) + "DetalleConceptoSubServicio.jsp?"%>'>
        <input id='clConceptoxSubServicio' name='clConceptoxSubServicio' type='hidden' value='<%=StrclConceptoxSubServicio%>'>
        <input id='StrclSubServicio' name='clSubservicio' type='hidden' value='<%=StrclSubServicio%>'>
        <input id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='<%=StrclPaginaWeb%>'>
        <% if (rs.next()) {%>
        <%=MyUtil.ObjComboC("SubServicio", "clSubServicioVTR", rs.getString("dsSubServicio"), false, false, 30, 80, "0", "select clSubServicio, dsSubServicio from cSubServicio where clSubservicio =" + StrclSubServicio, "", "", 50, false, false)%>
        <%=MyUtil.ObjComboC("Concepto Costo", "clConcepto", rs.getString("dsConcepto"), true, false, 30, 125, "0", "st_getComboConceptoxSubServ " + StrclSubServicio, "", "", 50, true, true)%>

        <% } else {%>
        <%=MyUtil.ObjComboC("SubServicio", "clSubServicioVTR", "", false, false, 30, 80, "0", "select clSubServicio, dsSubServicio from cSubServicio where clSubservicio =" + StrclSubServicio, "", "", 50, false, false)%>
        <%=MyUtil.ObjComboC("Concepto Costo", "clConcepto", "", true, false, 30, 125, "0", "st_getComboConceptoxSubServ " + StrclSubServicio, "", "", 50, true, false)%>
        <% }%>
        <%=MyUtil.DoBlock("Detalle de Concepto de Costo", 0, 0)%>
        <%=MyUtil.GeneraScripts()%>
        <%
            StrclConceptoxSubServicio = null;
            StrclUsrApp = null;

            rs.close();
            rs = null;
        %>
        <script>
            document.all.btnCambio.disabled = true;
        </script>
    </body>
</html>
