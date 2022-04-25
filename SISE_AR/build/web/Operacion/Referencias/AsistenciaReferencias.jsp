<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="Utilerias.UtileriasBDF,Seguridad.SeguridadC,java.sql.ResultSet;" %>

<html>
    <head>
        <title>Módulo de Referencias</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../../Utilerias/Util.js'></script>
        <%
            String strclUsr = "0";
            String strclRReferencias = "0";
            String strclCuenta = "0";
            String StrclPaginaWeb = "6090";
            String strCodEnt = "";
            String strCodMD = "";
            String strclServicio = "0";
            String strdsSubServicio = "0";
            String strclSubServicio = "0";
            String strclServicioA = "0";
            String strclSubServicioA = "0";
            String StrclExpediente = "0";

            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true) {
        %> Fuera de Horario <%
                strclUsr = null;
                strclRReferencias = null;
                strclCuenta = null;
                strCodEnt = null;
                strCodMD = null;
                strclServicio = null;
                strclSubServicio = null;
                strclServicioA = null;
                strclSubServicioA = null;
                return;
            }

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            System.out.println(strclRReferencias);

            if (session.getAttribute("clServicio") != null) {
                strclServicioA = session.getAttribute("clServicio").toString();
            }

            if (session.getAttribute("clSubServicio") != null) {
                strclSubServicioA = session.getAttribute("clSubServicio").toString();
            }

            if (session.getAttribute("dsSubServicio") != null) {
                strdsSubServicio = session.getAttribute("dsSubServicio").toString();
            }

            StringBuffer StrSql = new StringBuffer();

            StrSql.append("st_AsistReferencias ").append(StrclExpediente);
            System.out.println(StrSql);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(strclUsr));
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <script>fnOpenLinks()</script>

        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "", "")%>


        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="AsistenciaReferencias.jsp?"%>'>
        <INPUT id="clUsrApp" name="clUsrApp" type="hidden" value="<%=strclUsr%>">
        <INPUT id="clExpediente" name="clExpediente" type="hidden" value="<%=StrclExpediente%>">
        <INPUT id="clServicioA" name="clServicioA" type="hidden" value="<%=strclServicioA%>">
        <INPUT id="clSubServicioA" name="clSubServicioA" type="hidden" value="<%=strclSubServicioA%>">
        

        <% if (rs.next()) {%>
        <script>document.all.btnAlta.disabled=true</script>
        <INPUT id="clRReferencias" name="clRReferencias" type="hidden" value="<%=rs.getString("clRReferencias")%>">
        <%=MyUtil.ObjTextArea("Link de Web o Fuente Proporcionada a N/U", "LigaPro", rs.getString("LigaPro"), "80", "4", true, true, 30, 70, "", false, false)%>
        <%=MyUtil.ObjTextArea("Información Solicitada por N/U", "InformacionSol", rs.getString("InformacionSol"), "80", "4", true, true, 30, 150, "", true, false)%>
        <%=MyUtil.ObjTextArea("Información Proporcionada a N/U", "InformacionPro", rs.getString("InformacionPro"), "80", "4", true, true, 470, 150, "", true, false)%>
        <% } else {%>
        <script>document.all.btnCambio.disabled=true;document.all.btnElimina.disabled=true</script>
        <INPUT id="clRReferencias" name="clRReferencias" type="hidden" value="">
        <%=MyUtil.ObjTextArea("Link de Web o Fuente Proporcionada a N/U", "LigaPro", "", "80", "4", true, true, 30, 70, "", false, false)%>
        <%=MyUtil.ObjTextArea("Información Solicitada por N/U", "InformacionSol", "", "80", "4", true, true, 30, 150, "", true, false)%>
        <%=MyUtil.ObjTextArea("Información Proporcionada a N/U", "InformacionPro", "", "80", "4", true, true, 470, 150, "", true, false)%>
        <% }%>
        <%=MyUtil.DoBlock(strdsSubServicio, 250, 30)%>

        <%=MyUtil.GeneraScripts()%>
        <%
            strclUsr = null;
            strclRReferencias = null;
            strclCuenta = null;
            strCodEnt = null;
            strCodMD = null;
            strclServicio = null;
            strclSubServicio = null;
            rs.close();
            rs = null;
        %>
    </body>
</html>
