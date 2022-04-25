<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.helpdesk.DAOHelpdesk,com.ike.helpdesk.HDActivxUsr,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title>Detalle Actividad a Desarrollar</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <%
        String StrclActivxUsr = "0";
        String StrclSolicitud = "0";
        String StrclUsrApp = "0";

        if (session.getAttribute("clUsrApp") != null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) {
        %> Fuera de Horario <%
            StrclActivxUsr = null;
            StrclSolicitud = null;
            StrclUsrApp = null;
            return;
        }

        if (request.getParameter("clActivxUsr") != null) {
            StrclActivxUsr = request.getParameter("clActivxUsr");
        }
        /*
        if (session.getAttribute("clUsrxSol")!= null)
        {
        StrclUsrxSol = session.getAttribute("clUsrxSol").toString();
        }
         */
        if (session.getAttribute("clSolicitud") != null) {
            StrclSolicitud = session.getAttribute("clSolicitud").toString();
        }

        boolean blnAbierto = false;
        boolean blnAdmin = false;

        ResultSet rs = null;
        StringBuffer StrSql = new StringBuffer();

        StrSql.append("Select coalesce(sum(cast(HDAdmin as tinyint)),0) HDAdmin ");
        StrSql.append("from PermisoPartxGpoPag PP ");
        StrSql.append("inner join UsrxGpo UxG on (PP.clGpoUsr = UxG.clGpoUsr)");
        StrSql.append("where UxG.clUsrApp = ").append(StrclUsrApp);

        rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0, StrSql.length());

        if (rs.next()) {
            if (rs.getString("HDAdmin").toString().compareToIgnoreCase("0") != 0) {
                blnAdmin = true;
            }
        }

        DAOHelpdesk daoh = new DAOHelpdesk();
        HDActivxUsr ActivxUsr = null;

        if (StrclActivxUsr.compareToIgnoreCase("0") != 0) {
            ActivxUsr = daoh.getActivxUsr(StrclActivxUsr);
        }
        String StrclPaginaWeb = "571";
        session.setAttribute("clPaginaWebP", StrclPaginaWeb);%>
        <script>fnOpenLinks()</script> <%
        MyUtil.InicializaParametrosC(571, Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        if (ActivxUsr != null) {
            if (StrclActivxUsr.compareToIgnoreCase("0") == 0) {
                blnAbierto = true;
            }
        }

        if (ActivxUsr != null) {
            if (ActivxUsr.getclEstatus() == 8) {
                blnAbierto = true;
            }
        }
        //StrclUsrApp = "2628";
%>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetActividad.jsp?"%>'>
        <INPUT id='clActivxUsr' name='clActivxUsr' type='hidden' value='<%=StrclActivxUsr%>'><br>
        <INPUT id='clUsrxSol' name='clUsrxSol' type='hidden' value='<%--=ActivxUsr != null? String.valueOf(ActivxUsr.getClUsrxSol()) : StrclUsrxSol--%>'><br>
        <INPUT id='clSolicitud' name='clSolicitud' type='hidden' value='<%=ActivxUsr != null ? String.valueOf(ActivxUsr.getClSolicitud()) : StrclSolicitud%>'><br>

        <%=MyUtil.ObjInput("Folio de Solicitud", "clSolicitudVTR", ActivxUsr != null ? String.valueOf(ActivxUsr.getClSolicitud()) : StrclSolicitud, false, false, 20, 100, "", false, false, 15)%>
        <%=MyUtil.ObjComboC("ColaboradorAsignado", "clUsrApp", ActivxUsr != null ? ActivxUsr.getColaborador() : "", blnAdmin, blnAdmin, 160, 100, "", "select C.clUsrApp,US.Nombre from HDcColaborador C inner join cUsrApp US on (C.clUsrApp = US.clUsrApp) inner join HDUsrxSol UxS on (UxS.clUsrApp = US.clUsrApp) where UxS.clSolicitud=" + StrclSolicitud + "order by US.Nombre", "", "", 35, true, blnAdmin)%>
        <%=MyUtil.ObjComboC("Estatus", "clEstatus", ActivxUsr != null ? ActivxUsr.getDsEstatusSol() : "", false, blnAdmin || blnAbierto, 510, 100, "8", "select clEstatus, dsEstatusSol from HDcEstatus where cltipoestatus = 3 order by dsEstatusSol ", "", "", 30, true, true)%>
        <%=MyUtil.ObjInput("Fecha de Alta<br>aaaa/mm/dd", "FechaAltaVTR", ActivxUsr != null ? ActivxUsr.getFechaAlta() : "", false, false, 20, 140, "", false, false, 20, "")%>
        <%=MyUtil.ObjInput("Fecha de Inicio<br>aaaa/mm/dd", "FechaInicio", ActivxUsr != null ? ActivxUsr.getFechaInicio() : "", blnAdmin, blnAdmin, 160, 140, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.FechaSingleMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Fecha Compromiso<br>aaaa/mm/dd", "FechaCompromiso", ActivxUsr != null ? ActivxUsr.getFechaCompromiso() : "", blnAdmin, blnAdmin, 290, 140, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.FechaSingleMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Fecha de Término", "FechaTerminoVTR", ActivxUsr != null ? ActivxUsr.getFechaTermino() : "", false, false, 510, 152, "", false, false, 20, "")%>
        <%=MyUtil.ObjTextArea("Grupo de Actividad", "Grupo", ActivxUsr != null ? ActivxUsr.getGrupo() : "", "90", "4", true, !blnAbierto && true, 20, 200, "", true, true)%>
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", ActivxUsr != null ? ActivxUsr.getObservaciones() : "", "90", "6", true, !blnAbierto && true, 20, 275, "", true, true)%>
        <%=MyUtil.ObjInput("Porcentaje de<br> avance %", "Porcentaje", ActivxUsr != null ? String.valueOf(ActivxUsr.getPorcentaje()) : "", blnAdmin, blnAdmin, 535, 200, "0", false, false, 15, "")%>
        <%=MyUtil.ObjInput("Secuencia", "Secuencia", ActivxUsr != null ? String.valueOf(ActivxUsr.getSecuencia()) : "", true, true, 535, 250, "", true, true, 15, "")%>
        <%=MyUtil.DoBlock("Detalle de Actividad", -40, 50)%>

        <%=MyUtil.GeneraScripts()%>
        <%
        if (!blnAdmin && (blnAbierto == false || (StrclUsrApp.compareToIgnoreCase(ActivxUsr != null ? String.valueOf(ActivxUsr.getClUsrApp()) : StrclUsrApp) != 0))) {%>
        <script>document.all.btnCambio.disabled=true;</script>
        <% }
        rs.close();
        rs = null;

        daoh = null;
        ActivxUsr = null;

        StrclActivxUsr = null;
        StrclSolicitud = null;
        StrclUsrApp = null;
        StrclPaginaWeb = null;
        %>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F'>
        <input name='FechaSingleMsk' id='FechaSingleMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <script>
            function fnChk(){
                alert(document.all.clUsrApp.value);
                alert(document.all.clUsrAppC.value);
            }
        </script>
    </body>
</html>