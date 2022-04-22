<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Utilerias.CamposExtra,java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<%@ page import="Seguridad.SeguridadC,com.ike.asistencias.DAOAsistenciaHogar,com.ike.asistencias.to.DetalleAsistenciaHogar"%>
<%@ page import="com.ike.model.DAOTieneAsistencia,com.ike.model.to.TieneAsistenciaExp, Combos.cbEntidad" errorPage="" %>
<html>
    <head>
        <title>Detalle Vigilancia</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="fnHabilitaSolucion();">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../../Utilerias/Util.js'></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <%
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es", "AR");
        String StrclExpediente = "";
        String StrclUsr = "";

        if (session.getAttribute("clUsrApp") != null) {
            StrclUsr = session.getAttribute("clUsrApp").toString();
        }

        if (session.getAttribute("clExpediente") != null) {
            StrclExpediente = session.getAttribute("clExpediente").toString();
        }

        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr)) != true) {
        %>Fuera de Horario<%
            StrclExpediente = null;
            StrclUsr = null;
            return;
        }

        DAOAsistenciaHogar daoAH = null;
        DetalleAsistenciaHogar AH = null;

        StringBuffer StrSql = new StringBuffer();
        StrSql.append(" st_TieneAsistH ").append(StrclExpediente);

        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0, StrSql.length());

        if (rs.next()) {
            daoAH = new DAOAsistenciaHogar();
            AH = daoAH.getDetalleAsistenciaHogar(StrclExpediente.toString());
        } else {
        %> El expediente no existe  <%
            StrclExpediente = null;
            StrclUsr = null;
            StrSql = null;

            rs.close();
            rs = null;

            daoAH = null;
            AH = null;
            return;
        }

        %>
        <script>fnOpenLinks()</script>
        <%
        String StrclPaginaWeb = "818";
        session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        MyUtil.InicializaParametrosC(818, Integer.parseInt(StrclUsr));
        %>

        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "", "fnAntesGuardar();")%>

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

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleVigilancia.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjTextArea("Motivo de Pedido del Servicio", "MotivoServicio", AH != null ? AH.getMotivoServicio() : "", "50", "4", true, true, 30, 80, "", true, true)%>
        <%=MyUtil.ObjInput("Tiempo de Cobertura", "TiempoCobertura", AH != null ? AH.getTiempoCobertura() : "", true, true, 420, 80, "", true, true, 25)%>
        <%=MyUtil.ObjComboC("Tipo solución", "clTipoSolucion", AH != null ? AH.getDsTipoSolucion() : "", true, true, 30, 155, "", "select clConcepto,dsConcepto from cConceptoCosto where clAreaOperativa = 4 and EstatusAct=1 and dsConcepto like 'Vigilancia%' or clConcepto=0 order by dsConcepto", "", "fnHabilitaSolucion()", 50, true, true)%>
        <%=MyUtil.ObjTextArea("Descripcion Solución", "Solucion", AH != null ? AH.getSolucion() : "", "40", "4", true, true, 420, 120, "", false, false)%>
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", AH != null ? AH.getObservaciones() : "", "50", "6", true, true, 30, 195, "", true, true)%>
        <%=MyUtil.ObjChkBox("Cita Programada", "EsProgramado", AH != null ? AH.getEsProgramado() : "", true, true, 418, 210, "0", "fnFechaProg()")%>
        <%=MyUtil.ObjInput("Fecha Programada<br>(aaaa/mm/dd hh:mm)", "FechaProgMom", AH != null ? AH.getFechaProgMom() : "", true, true, 420, 240, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.FechaProgMomMsk.value,this.name)};")%>
        <%=MyUtil.DoBlock("Datos Generales de la Asistencia Hogar", 45, 10)%>

        <%=MyUtil.ObjComboMem(i18n.getMessage("message.title.entidad"), "CodEnt", AH != null ? AH.getDsEntFed() : "", AH != null ? AH.getCodEnt() : "", cbEntidad.GeneraHTML(20, AH != null ? AH.getDsEntFed() : ""), true, true, 30, 330, "", "fnLlenaMunicipiosCS()", "", 20, true, true)%>
        <%=MyUtil.ObjComboMem(i18n.getMessage("message.title.municipio"), "CodMD", AH != null ? AH.getDsMunDel() : "", AH != null ? AH.getCodMD() : "", cbEntidad.GeneraHTMLMD(30, AH != null ? AH.getCodEnt() : "", AH != null ? AH.getDsMunDel() : ""), true, true, 30, 370, AH != null ? AH.getDsMunDel() : "", "", "", 20, true, true)%>
        <%=MyUtil.ObjInput("Calle", "Calle", AH != null ? AH.getCalle() : "", true, true, 30, 410, "", false, false, 50)%>
        <%=MyUtil.ObjInput("CP", "CP", AH != null ? AH.getCP() : "", true, true, 315, 410, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Referencias Visuales", "Referencias", AH != null ? AH.getReferencias() : "", "70", "5", true, true, 30, 450, "", true, true)%>
        <%=MyUtil.DoBlock("Domicilio", -80, 40)%>
        <%=MyUtil.GeneraScripts()%>

        <%
        StrclExpediente = null;
        StrclUsr = null;
        StrSql = null;

        rs.close();
        rs = null;

        daoAH = null;
        AH = null;
        %>
        <input name='FechaProgMomMsk' id='FechaProgMomMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>

        <script>
            document.all.FechaProgMom.disabled=true;

            function fnHabilitaSolucion(){
                if (document.all.clTipoSolucion.value==0){
                    document.all.D6.style.visibility="visible";
                }
                else
                {
                    document.all.Solucion.value='';
                    document.all.D6.style.visibility="hidden";
                }
            }

            function fnFechaProg(){
                if (document.all.EsProgramado.value==1){
                    document.all.FechaProgMom.disabled=false;
                }else{
                    if (document.all.EsProgramado.value==0){
                        document.all.FechaProgMom.disabled=true;
                        document.all.FechaProgMom.value="";
                    }
                }
            }

            function fnAntesGuardar(){
                if(document.all.EsProgramado.value==1){
                    if(document.all.FechaProgMom.value==""){
                        msgVal=msgVal + " Fecha Programada ";
                        document.all.btnGuarda.disabled=false;
                        document.all.btnCancela.disabled=false;
                    }
                }
                if (document.all.clTipoSolucion.value==0 && document.all.Solucion.value==""){
                    msgVal=msgVal + " Falta informar la descripción solucion ";
                    document.all.btnGuarda.disabled=false;
                    document.all.btnCancela.disabled=false;
                }
            }
        </script>
    </body>
</html>

