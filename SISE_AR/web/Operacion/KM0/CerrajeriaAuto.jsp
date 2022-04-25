<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="com.ike.asistencias.DAOAsistenciaVial,com.ike.asistencias.to.AsistenciaVial,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF"%>

<html>
    <head>
        <title>Cerrajeria Automovilistica</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>

    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAuto.js'></script>

        <%
            String StrclUsrApp = "0";
            String StrclExpediente = "";
            String StrclPaginaWeb = "6000";

            //  DATOS DE LA UBICACION ORIGEN, VIENEN DEL EXPEDIENTE EN SESION
            String StrclPais = "";
            String StrdsPais = "";
            String StrdsEntFed = "";
            String StrCodEnt = "";
            String StrdsMunDel = "";
            String StrCodMD = "";
            String StrclMarcaAuto = "";
            String StrclCuenta = "0";
            String StrClave = "";

            //  DATOS DEL AFILIADO
            String StrCalleNum = "";
            String StrModelo = "";
            String StrColor = "";
            String StrPlacas = "";
            String StrDescAuto = "";
            String StrCodigoMarca = "";
            String StrClaveAMIS = "";
            String StrDsTipoAuto = "";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }
            if (session.getAttribute("clPais") != null) {
                StrclPais = session.getAttribute("clPais").toString();
            }
            if (session.getAttribute("dsPais") != null) {
                StrdsPais = session.getAttribute("dsPais").toString();
            }
            if (session.getAttribute("CodEnt") != null) {
                StrCodEnt = session.getAttribute("CodEnt").toString();
            }
            if (session.getAttribute("dsEntFed") != null) {
                StrdsEntFed = session.getAttribute("dsEntFed").toString();
            }
            if (session.getAttribute("CodMD") != null) {
                StrCodMD = session.getAttribute("CodMD").toString();
            }
            if (session.getAttribute("dsMunDel") != null) {
                StrdsMunDel = session.getAttribute("dsMunDel").toString();
            }
            if (session.getAttribute("clCuenta") != null) {
                StrclCuenta = session.getAttribute("clCuenta").toString();
            }
            if (session.getAttribute("Clave") != null) {
                StrClave = session.getAttribute("Clave").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
                StrclUsrApp = null;
                StrclExpediente = null;
                StrclPaginaWeb = null;
                StrclPais = null;
                StrdsPais = null;
                StrdsEntFed = null;
                StrCodEnt = null;
                StrdsMunDel = null;
                StrCodMD = null;
                StrclMarcaAuto = null;
                StrclCuenta = null;
                StrClave = null;
                StrCalleNum = null;
                StrModelo = null;
                StrColor = null;
                StrPlacas = null;
                StrDescAuto = null;
                StrCodigoMarca = null;
                StrClaveAMIS = null;
                StrDsTipoAuto = null;

                return;
            }

            StringBuffer StrSql = new StringBuffer();

            DAOAsistenciaVial daoAV = null;
            AsistenciaVial AV = null;

            StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs.next()) {
                daoAV = new DAOAsistenciaVial();
                AV = daoAV.getAsistenciaVial(StrclExpediente);

                StrclMarcaAuto = AV != null ? AV.getClMarca() : "0";
            } else {
        %> El expediente no existe <%
                rs.close();
                rs = null;

                StrclPais = null;
                StrdsPais = null;
                StrdsEntFed = null;
                StrCodEnt = null;
                StrdsMunDel = null;
                StrCodMD = null;
                StrclMarcaAuto = null;
                StrCalleNum = null;
                StrModelo = null;
                StrColor = null;
                StrPlacas = null;
                StrDescAuto = null;
                return;
            }

            StrSql.append(" st_getDatosAfiliadoGral '").append(StrClave).append("','").append(StrclCuenta).append("'");
            System.out.println(StrSql);
            ResultSet rsDatosAfil = UtileriasBDF.rsSQLNP(StrSql.toString());

            StrSql.delete(0, StrSql.length());

            if (rsDatosAfil.next()) {
                StrCalleNum = rsDatosAfil.getString("callenum");
                StrModelo = rsDatosAfil.getString("anio");
                StrColor = rsDatosAfil.getString("color");
                StrPlacas = rsDatosAfil.getString("Placas");
                StrDescAuto = rsDatosAfil.getString("descauto");

                StrCodigoMarca = rsDatosAfil.getString("CodigoMarca");
                StrClaveAMIS = rsDatosAfil.getString("ClaveAMIS");
                StrDsTipoAuto = rsDatosAfil.getString("DsTipoAuto");
            }

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(6000, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "fnValLugar();fnLlenaComboAuto();", "fnValLugar();", "")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="CerrajeriaAuto.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjComboMem("Pais", "clPais", StrdsPais, StrclPais, cbPais.GeneraHTML(20, StrdsPais), false, false, 30, 80, StrclPais, "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", StrdsEntFed, StrCodEnt, cbEntidad.GeneraHTML(40, StrdsEntFed, Integer.parseInt(StrclPais)), false, false, 30, 120, StrCodEnt, "fnLLenaComboMDAjax(this.value);", "", 20, false, false, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", StrdsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(40, StrCodEnt, StrdsMunDel), false, false, 415, 120, StrCodMD, "", "", 20, false, false, "LocalidadDiv")%>
        <%=MyUtil.ObjInput("Calle y N�mero", "CalleNum", AV != null ? AV.getCalleO() : "", true, true, 30, 160, StrCalleNum, false, false, 106)%>
        <%=MyUtil.ObjTextArea("Referencias Visuales", "Referencias", AV != null ? AV.getReferenciasO() : "", "105", "5", true, true, 30, 200, StrDescAuto, false, false)%>
        <%=MyUtil.DoBlock("Ubicaci�n del Evento", 80, 40)%>

        <%=MyUtil.ObjInput("Modelo", "Modelo", AV != null ? AV.getModelo() : "", true, true, 30, 368, StrModelo, true, true, 6, "if(this.readOnly==false){fnValidaModelo(this)}")%>
        <%=MyUtil.ObjInput("Color", "Color", AV != null ? AV.getColor() : "", true, true, 100, 368, StrColor, true, true, 10)%>
        <%=MyUtil.ObjInput("Patente", "Placas", AV != null ? AV.getPatente() : "", true, true, 190, 368, StrPlacas, true, true, 8)%>
        <%=MyUtil.ObjComboC("Marca de Auto", "CodigoMarca", AV != null ? AV.getDsMarca() : "", true, true, 30, 330, StrCodigoMarca, "st_getMarcaAutoKM " + StrclExpediente, "fnLlenaTipoAutoAjax(this.value,'ClaveAMIS','Tipo de Auto','TipoAutoDiv','',2);", "", 50, true, false)%>
        <%=MyUtil.ObjComboCDiv("Tipo de Auto", "ClaveAMIS", AV != null ? AV.getDsTipoAuto() : "", true, true, 195, 330, "", "st_getTipoAutoKM '" + StrclMarcaAuto + "'," + StrclExpediente, "", "", 50, true, false, "TipoAutoDiv")%>
        <%=MyUtil.ObjComboC("Lugar", "clLugarEvento", AV != null ? AV.getDsLugar() : "", true, true, 280, 368, "", "select clLugarEvento, dsLugarEvento from cLugarEvento order by dsLugarEvento", "", "", 20, true, true)%>
        <INPUT id='ClaveAMISVTR' name='ClaveAMISVTR' type='hidden' value=''>
        <%=MyUtil.DoBlock("Detalle Cerrajer�a Automovilistica", 70, -10)%>

        <%=MyUtil.GeneraScripts()%>

        <script type="text/javascript">
            document.all.Modelo.maxLength = 4;
            document.all.Placas.maxLength = 8;

            function fnLlenaEntidadAjaxFn(cod) {  /// Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion
                IDCombo = 'CodEnt';
                Label = 'Provincia';
                IdDiv = 'CodEntDiv';
                FnCombo = 'fnLLenaComboMDAjax(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion=" + cod + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjax(value) {
                IDCombo = 'CodMD';
                Label = 'Localidad';
                IdDiv = 'LocalidadDiv';
                FnCombo = '';
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion=" + value + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnValLugar() {
                if (document.all.CodEnt.value.toString() == '002') {
                    document.all.clLugarEventoC.value = 2;
                    document.all.clLugarEvento.value = 2;
                }
                else {
                    document.all.clLugarEventoC.value = 1;
                    document.all.clLugarEvento.value = 1;
                }
            }

            function fnLlenaComboAuto() {
                /*20160406 Se agrega para llenar las opciones de la marca seleccionada*/
                fnLlenaTipoAutoAjax(document.all.CodigoMarca.value, 'ClaveAMIS', 'Tipo de Auto', 'TipoAutoDiv', '', 2);

                cadenaTexto = '<%=StrDsTipoAuto%>';

                var nuevaOpc = document.createElement("OPTION");
                nuevaOpc.text = cadenaTexto.toString();
                nuevaOpc.value = "<%=StrClaveAMIS%>";
                forma.ClaveAMISC.add(nuevaOpc);
                document.all.ClaveAMISC.value = '<%=StrClaveAMIS%>'
                document.all.ClaveAMIS.value = '<%=StrClaveAMIS%>'
            }
            
            document.all.btnElimina.disabled = true;
        </script>

        <%
            if (AV != null) {
                //si hay asiistencia
        %>
        <script>
            document.all.btnAlta.disabled = true;
        </script>
        <%
        } else {
        %>
        <script>
            document.all.btnCambio.disabled = true;
        </script>
        <%
            } %>
    </body>

    <%
        daoAV = null;
        AV = null;

        rs.close();
        rs = null;

        rsDatosAfil.close();
        rsDatosAfil = null;

        StrclUsrApp = null;
        StrclExpediente = null;
        StrclPaginaWeb = null;
        StrclPais = null;
        StrdsPais = null;
        StrdsEntFed = null;
        StrCodEnt = null;
        StrdsMunDel = null;
        StrCodMD = null;
        StrclMarcaAuto = null;
        StrclCuenta = null;
        StrClave = null;
        StrCalleNum = null;
        StrModelo = null;
        StrColor = null;
        StrPlacas = null;
        StrDescAuto = null;
        StrCodigoMarca = null;
        StrClaveAMIS = null;
        StrDsTipoAuto = null;
    %>
</html>
