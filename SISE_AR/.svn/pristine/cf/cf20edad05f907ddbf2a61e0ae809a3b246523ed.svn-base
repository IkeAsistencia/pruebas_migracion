<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.asistencias.DAOAsistenciaMenores,com.ike.asistencias.to.AsistenciaMenores,Combos.cbPais" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>Reemplazo de Documentos</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <%
        String StrclExpediente = "0";
        String StrclUsrApp = "0";

        StringBuffer StrSql = new StringBuffer();

        if (session.getAttribute("clUsrApp") != null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if (session.getAttribute("clExpediente") != null) {
            StrclExpediente = session.getAttribute("clExpediente").toString();
        }

        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
            StrclExpediente = null;
            StrclUsrApp = null;

            return;
        }

        DAOAsistenciaMenores daoAM = null;
        AsistenciaMenores AM = null;

        StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0, StrSql.length());

        if (rs.next()) {
            daoAM = new DAOAsistenciaMenores();
            AM = daoAM.getAsistenciaMenores(StrclExpediente.toString());
        } else {
        %> El expediente no existe <%
            StrclUsrApp = null;
            StrclExpediente = null;

            rs.close();
            rs = null;

            daoAM = null;
            AM = null;
            return;
        }

        %>
        <script>fnOpenLinks()</script>
        <%
        String StrclPaginaWeb = "6044";
        MyUtil.InicializaParametrosC(6044, Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "fnPaisDefault();","")%>

        <%
        if (rs.getString("TieneAsistencia").equals("1")) {
        %>
        <script>
            document.all.btnAlta.disabled=true;
            document.all.btnCambio.disabled=false;
        </script>
        <% } else {
        %>
        <script>
            document.all.btnAlta.disabled=false;
            document.all.btnCambio.disabled=true;
        </script>
        <% }%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="AsistenciaMenores.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjInput("Nombre", "Nombre", AM != null ? AM.getNombre() : "", true, true, 30, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Edad (años)", "Edad", AM != null ? AM.getEdad() : "", true, true, 320, 80, "", true, true, 10)%>
        <%=MyUtil.ObjComboC("Parentesco con N/U", "clParentesco", AM != null ? AM.getDsParentesco() : "", true, true, 420, 80, "", "Select clParentesco, dsParentesco From cParentesco where Activo = 1", "", "", 30, true, true)%>
        <%=MyUtil.DoBlock("Asistencia Menores", -30, 0)%>

        <%=MyUtil.ObjComboC("País", "clPais", AM != null ? AM.getDsPais() : "", true, true, 30, 170, "", "select clPais, dsPais from cPais where Activo=1 order by dsPais", "", "", 20, true, true)%>
        <%=MyUtil.ObjInput("Dirección", "Direccion", AM != null ? AM.getDireccion() : "", true, true, 250, 170, "", true, true, 60)%>
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", AM != null ? AM.getObservaciones() : "", "80", "6", true, true, 30, 210, "", false, false)%>
        <%=MyUtil.DoBlock("Ubicación del Menor", 140, 50)%>

        <%=MyUtil.GeneraScripts()%><%

        rs.close();
        rs = null;

        StrclExpediente = null;
        StrclUsrApp = null;
        StrclPaginaWeb = null;
        StrSql = null;
        %>
        <script>
            function fnPaisDefault(){
                document.all.clPais.value=10;
                document.all.clPaisC.value=10

                //fnLlenaEntidadAjaxFn(10); // Carga Entidades de Argentina Por Default
            }
        </script>
    </body>
</html>