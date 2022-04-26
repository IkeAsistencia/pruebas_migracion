<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.asistencias.DAOReemplazoDocumentos,com.ike.asistencias.to.ReemplazoDocumentos" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>Reemplazo de Documentos</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
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

        DAOReemplazoDocumentos daoRD = null;
        ReemplazoDocumentos RD = null;

        StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0, StrSql.length());

        if (rs.next()) {
            daoRD = new DAOReemplazoDocumentos();
            RD = daoRD.getReemplazoDocumentos(StrclExpediente);
        } else {
        %> El expediente no existe <%
            StrclUsrApp = null;
            StrclExpediente = null;

            return;
        }

        %>
        <script>fnOpenLinks()</script>
        <%
        String StrclPaginaWeb = "6013";
        MyUtil.InicializaParametrosC(6013, Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "")%>

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
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="ReemplazoDocumentos.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjInput("Nombre", "Nombre", RD != null ? RD.getNombre() : "", true, true, 30, 80, "", true, true, 60)%>
        <%=MyUtil.ObjComboC("Parentesco con N/U", "clParentesco", RD != null ? RD.getDsParentesco() : "", true, true, 360, 80, "", "Select clParentesco, dsParentesco From cParentesco where Activo = 1 ", "", "", 30, true, true)%>
        <%=MyUtil.DoBlock("Subservicio de Reemplazo de Documentos", -30, 0)%>

        <label class="VTable" style="position:absolute; z-index:100; left:30px; top:188px;"><b>1.</b></label>
        <label class="VTable" style="position:absolute; z-index:100; left:30px; top:228px;"><b>2.</b></label>
        <label class="VTable" style="position:absolute; z-index:100; left:30px; top:268px;"><b>3.</b></label>
        <label class="VTable" style="position:absolute; z-index:100; left:30px; top:308px;"><b>4.</b></label>
        <label class="VTable" style="position:absolute; z-index:100; left:30px; top:348px;"><b>5.</b></label>

        <hr style="position:absolute; z-index:100; left:30px; top:212px" width="500px">
        <hr style="position:absolute; z-index:100; left:30px; top:252px" width="500px">
        <hr style="position:absolute; z-index:100; left:30px; top:292px" width="500px">
        <hr style="position:absolute; z-index:100; left:30px; top:332px" width="500px">

        <%=MyUtil.ObjInput("Tipo de Documento", "TipoDocumento1", RD != null ? RD.getTipoDocumento1() : "", true, true, 45, 170, "", true, true, 40)%>
        <%=MyUtil.ObjInput("Número", "Numero1", RD != null ? RD.getNumero1() : "", true, true, 275, 170, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Costo del Trámite", "CostoTramite1", RD != null ? RD.getCostoTramite1() : "", true, true, 405, 170, "", false, false, 20)%>

        <%=MyUtil.ObjInput("", "TipoDocumento2", RD != null ? RD.getTipoDocumento2() : "", true, true, 45, 210, "", false, false, 40)%>
        <%=MyUtil.ObjInput("", "Numero2", RD != null ? RD.getNumero2() : "", true, true, 275, 210, "", false, false, 20)%>
        <%=MyUtil.ObjInput("", "CostoTramite2", RD != null ? RD.getCostoTramite2() : "", true, true, 405, 210, "", false, false, 20)%>

        <%=MyUtil.ObjInput("", "TipoDocumento3", RD != null ? RD.getTipoDocumento3() : "", true, true, 45, 250, "", false, false, 40)%>
        <%=MyUtil.ObjInput("", "Numero3", RD != null ? RD.getNumero3() : "", true, true, 275, 250, "", false, false, 20)%>
        <%=MyUtil.ObjInput("", "CostoTramite3", RD != null ? RD.getCostoTramite3() : "", true, true, 405, 250, "", false, false, 20)%>

        <%=MyUtil.ObjInput("", "TipoDocumento4", RD != null ? RD.getTipoDocumento4() : "", true, true, 45, 290, "", false, false, 40)%>
        <%=MyUtil.ObjInput("", "Numero4", RD != null ? RD.getNumero4() : "", true, true, 275, 290, "", false, false, 20)%>
        <%=MyUtil.ObjInput("", "CostoTramite4", RD != null ? RD.getCostoTramite4() : "", true, true, 405, 290, "", false, false, 20)%>

        <%=MyUtil.ObjInput("", "TipoDocumento5", RD != null ? RD.getTipoDocumento5() : "", true, true, 45, 330, "", false, false, 40)%>
        <%=MyUtil.ObjInput("", "Numero5", RD != null ? RD.getNumero5() : "", true, true, 275, 330, "", false, false, 20)%>
        <%=MyUtil.ObjInput("", "CostoTramite5", RD != null ? RD.getCostoTramite5() : "", true, true, 405, 330, "", false, false, 20)%>

        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", RD != null ? RD.getObservaciones() : "", "93", "4", true, true, 30, 380, "", false, false)%>
        <%=MyUtil.DoBlock("Datos del Reemplazo de Documentos", -50, 30)%>

        <%=MyUtil.GeneraScripts()%><%

        rs.close();
        rs = null;

        StrclExpediente = null;
        StrclUsrApp = null;
        StrclPaginaWeb = null;
        StrSql = null;
        %>
        <script>

        </script>
    </body>
</html>