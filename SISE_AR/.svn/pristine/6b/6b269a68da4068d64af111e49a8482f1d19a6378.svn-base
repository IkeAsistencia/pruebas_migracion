<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="com.ike.asistencias.DAOAsistenciaTransportacion,com.ike.asistencias.to.AsistenciaTransportacion,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF;"%>

<html>
    <head>
        <title>Transportacion</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>

    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAuto.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>

        <%

                String StrclUsrApp = "0";
                String StrclExpediente = "0";
                String StrclMarcaAuto = "";
                String StrclPaginaWeb = "144";

                // DATOS DE LA UBICACION ORIGEN, VIENEN DEL EXPEDIENTE EN SESION
                String StrclPais = "";
                String StrdsPais = "";
                String StrCodEnt = "";
                String StrdsEntFed = "";
                String StrCodMD = "";
                String StrdsMunDel = "";

                // DATOS DE LA UBICACION DESTINO
                String StrclPaisDest = "";
                String StrCodEntDest = "";
                String StrdsEntFedDest = "";
                String StrCodMDDest = "";
                String StrdsMunDelDest = "";

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

                if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>  Fuera de Horario <%

                    StrclUsrApp = null;
                    StrclExpediente = null;
                    StrclPais = null;
                    StrdsPais = null;
                    StrCodEnt = null;
                    StrdsEntFed = null;
                    StrCodMD = null;
                    StrdsMunDel = null;
                    StrclPaisDest = null;
                    StrCodEntDest = null;
                    StrdsEntFedDest = null;
                    StrCodMDDest = null;
                    StrdsMunDelDest = null;

                    return;
                }

                StringBuffer StrSql = new StringBuffer();

                DAOAsistenciaTransportacion DAOAT = null;
                AsistenciaTransportacion AT = null;

                StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
                ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
                StrSql.delete(0, StrSql.length());

                if (rs.next()) {

                    DAOAT = new DAOAsistenciaTransportacion();
                    AT = DAOAT.getAsistenciaTransportacion(StrclExpediente);

                    StrclPaisDest = AT != null ? AT.getClPaisDest() : "";
                    StrCodEntDest = AT != null ? AT.getCodEntDest() : "";
                    StrdsEntFedDest = AT != null ? AT.getDsEntFedDest() : "";
                    StrCodMDDest = AT != null ? AT.getCodMDDest() : "";
                    StrdsMunDelDest = AT != null ? AT.getDsMunDelDest() : "";

                    StrclMarcaAuto = AT != null ? AT.getCodigoMarca() : "";

                    if (StrclPaisDest.equalsIgnoreCase("")) {
                        StrclPaisDest = "10";
                    }

                } else {
        %> El expediente no existe <%
                    rs.close();
                    rs = null;

                    StrclUsrApp = null;
                    StrclExpediente = null;
                    StrclPais = null;
                    StrdsPais = null;
                    StrCodEnt = null;
                    StrdsEntFed = null;
                    StrCodMD = null;
                    StrdsMunDel = null;
                    StrclPaisDest = null;
                    StrCodEntDest = null;
                    StrdsEntFedDest = null;
                    StrCodMDDest = null;
                    StrdsMunDelDest = null;

                    return;
                }

                session.setAttribute("clPaginaWebP", StrclPaginaWeb);

        %>
        <script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(144, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "fnFechaApertura();", "fnFechaRegistro();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="Transportacion.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjComboC("Tipo de Transporte", "clTipoTransporte", AT != null ? AT.getDsTipoTransporte() : "", true, true, 30, 95, "", "Select clTipoTransporte, dsTipoTransporte From cTipoTransporte Where Clasificacion='TRANS' or Clasificacion='TODAS' Order by dsTipoTransporte", "", "", 100, false, false)%>
        <%=MyUtil.ObjInput("Horas estimadas<br>de reparación", "TiempoReparacion", AT != null ? AT.getTiempoReparacion() : "", true, true, 200, 80, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Fecha Apertura<br>(AAAA/MM/DD HH:MM)", "FechaApertura", AT != null ? AT.getFechaApertura() : "", false, false, 370, 80, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Fecha Registro<br>(AAAA/MM/DD HH:MM)", "FechaRegistro", AT != null ? AT.getFechaRegistro() : "", false, false, 520, 80, "", false, false, 20)%>
        <%=MyUtil.ObjComboC("Marca de Auto", "CodigoMarca", AT != null ? AT.getDsMarcaAuto() : "", true, true, 30, 135, "", " Select CodigoMarca, dsMarcaAuto from cMarcaAuto order by dsMarcaAuto", "fnLlenaTipoAutoAjax(this.value,'ClaveAMIS','Tipo de Auto','TipoAutoDiv','',2);", "", 70, true, false)%>
        <%=MyUtil.ObjComboCDiv("Tipo de Auto", "ClaveAMIS", AT != null ? AT.getDsTipoAuto() : "", true, true, 200, 135, "", " Select ClaveAMIS, dsTipoAuto from cTipoAuto where CodigoMarca = '" + StrclMarcaAuto + "' order by dsTipoAuto", "", "", 160, true, false, "TipoAutoDiv")%>
        <%=MyUtil.ObjInput("Reservación a nombre de:", "ReservacionA", AT != null ? AT.getReservacion() : "", true, true, 30, 175, "", false, false, 70)%>
        <%=MyUtil.ObjInput("No. Adultos", "NumAdultosViajan", AT != null ? AT.getNumAdultos() : "", true, true, 480, 175, "", false, false, 10, "EsNumerico(document.all.NumAdultosViajan)")%>
        <%=MyUtil.ObjInput("No. Niños", "NumNinosViajan", AT != null ? AT.getNumMenores() : "", true, true, 570, 175, "", false, false, 10, "EsNumerico(document.all.NumNinosViajan)")%>

        <%=MyUtil.ObjComboMem("Pais Residencia", "clPaisReside", StrdsPais, StrclPais, cbPais.GeneraHTML(20, StrdsPais), false, false, 30, 219, StrclPais, "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
        <%=MyUtil.ObjComboMemDiv("Provincia Residencia", "CodEntReside", StrdsEntFed, StrCodEnt, cbEntidad.GeneraHTML(40, StrdsEntFed, Integer.parseInt(StrclPais)), false, false, 300, 219, StrCodEnt, "fnLLenaComboMDAjax(this.value);", "", 20, false, false, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad Residencia", "CodMDReside", StrdsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(40, StrCodEnt, StrdsMunDel), false, false, 30, 259, StrCodMD, "", "", 20, false, false, "LocalidadDiv")%>

        <%=MyUtil.ObjComboMem("Pais Destino", "clPaisDest", AT != null ? AT.getDsPaisDest() : "", AT != null ? AT.getClPaisDest() : "", cbPais.GeneraHTML(20, AT != null ? AT.getDsPaisDest() : ""), true, true, 30, 310, "", "fnLlenaEntidadAjaxFnDest(this.value);", "", 20, true, true)%>
        <%=MyUtil.ObjComboMemDiv("Provincia Destino", "CodEntDest", StrdsEntFedDest, StrCodEntDest, cbEntidad.GeneraHTML(40, StrdsEntFedDest, Integer.parseInt(StrclPaisDest)), true, true, 300, 310, StrCodEntDest, "fnLLenaComboMDAjaxDest(this.value);", "", 20, true, true, "CodEntDivDest")%>
        <%=MyUtil.ObjComboMemDiv("Localidad Destino", "CodMDDest", StrdsMunDelDest, StrCodMDDest, cbEntidad.GeneraHTMLMD(40, StrCodEntDest, StrdsMunDelDest), true, true, 30, 350, "", "", "", 20, true, true, "LocalidadDivDest")%>

        <%=MyUtil.ObjInput("Fecha Preferente de Corrida", "HoraFechaCorrida", AT != null ? AT.getFechaCorrida() : "", true, true, 30, 395, "", false, false, 30)%>
        <%=MyUtil.ObjInput("<b>Costo Cotizado</b>", "CostoCotizacion", AT != null ? AT.getCostoCotizado() : "", true, true, 305, 395, "", true, true, 15, "EsNumerico(document.all.CostoCotizacion)")%>
        <%=MyUtil.ObjInput("<b>Costo Final</b>", "CostoFinal", AT != null ? AT.getCostoFinal() : "", true, true, 420, 395, "", true, true, 15, "EsNumerico(document.all.CostoFinal)")%>
        <%=MyUtil.DoBlock("Detalle de Transportación", -70, -10)%>

        <%=MyUtil.GeneraScripts()%>

        <%
                rs.close();
                rs = null;

                StrclUsrApp = null;
                StrclExpediente = null;
                StrclPais = null;
                StrdsPais = null;
                StrCodEnt = null;
                StrdsEntFed = null;
                StrCodMD = null;
                StrdsMunDel = null;
                StrclPaisDest = null;
                StrCodEntDest = null;
                StrdsEntFedDest = null;
                StrCodMDDest = null;
                StrdsMunDelDest = null;

                StrSql = null;

        %>

        <script type="text/javascript">
            function fnFechaApertura(){ //  ESTA FUNCION TOMA LA FECHA LOCAL DEL SERVIDOR DONDE CORRE LA APP
                if (document.all.FechaApertura.value==''){
                    var fechaActual = new Date()
                    var mes = fechaActual.getMonth() + 1    //  SE SUMA 1 PORQUE TOMA EL MES DE ENERO COMO 0 Y A DICIEMBRE COMO 11
                    var dia = fechaActual.getDate()
                    var anio = fechaActual.getFullYear()
                    var horas = fechaActual.getHours()
                    var minutos = fechaActual.getMinutes()
                    document.all.FechaApertura.value = anio + "-"+mes+"-"+dia+" "+horas+":"+minutos;
                }
            }

            function fnFechaRegistro(){ //  ESTA FUNCION TOMA LA FECHA LOCAL DEL SERVIDOR DONDE CORRE LA APP
                if (document.all.FechaRegistro.value==''){
                    var fechaActual = new Date()
                    var mes = fechaActual.getMonth() + 1    //  SE SUMA 1 PORQUE TOMA EL MES DE ENERO COMO 0 Y A DICIEMBRE COMO 11
                    var dia = fechaActual.getDate()
                    var anio = fechaActual.getFullYear()
                    var horas = fechaActual.getHours()
                    var minutos = fechaActual.getMinutes()
                    document.all.FechaRegistro.value = anio + "-"+mes+"-"+dia+" "+horas+":"+minutos;
                }
            }

            function fnLlenaEntidadAjaxFn(cod){  /// Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion
                IDCombo= 'CodEntReside';
                Label='Provincia Residencia';
                IdDiv='CodEntDiv';
                FnCombo='fnLLenaComboMDAjax(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion="+cod+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjax(value){
                IDCombo= 'CodMDReside';
                Label='Localidad Residencia';
                IdDiv='LocalidadDiv';
                FnCombo='';
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion="+value+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLlenaEntidadAjaxFnDest(cod){  /// Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion
                IDCombo= 'CodEntDest';
                Label='Provincia Destino';
                IdDiv='CodEntDivDest';
                FnCombo='fnLLenaComboMDAjaxDest(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion="+cod+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjaxDest(value){
                IDCombo= 'CodMDDest';
                Label='Localidad Destino';
                IdDiv='LocalidadDivDest';
                FnCombo='';
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion="+value+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }
        </script>
    </body>
</html>
