<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="com.ike.asistencias.DAOPagoHotel,com.ike.asistencias.to.PagoHotel,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,java.sql.ResultSet,Utilerias.UtileriasBDF;"%>

<html>
    <head>
        <title>Pago de Hotel</title> 
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <script src='../../Utilerias/UtilAjax.js'></script>

        <%
                String StrclUsrApp = "0";
                String StrclExpediente = "0";
                String StrclPaginaWeb = "133";

                //  DATOS DE LA UBICACION ORIGEN, VIENEN DEL EXPEDIENTE EN SESION
                String StrclPais = "";
                String StrdsPais = "";
                String StrdsEntFed = "";
                String StrCodEnt = "";
                String StrdsMunDel = "";
                String StrCodMD = "";

                //  DATOS DE LA UBICACION DESTINO
                String StrclPaisDest = "";
                String StrdsEntFedDest = "";
                String StrCodEntDest = "";
                String StrdsMunDelDest = "";
                String StrCodMDDest = "";

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
                    StrclPaisDest = null;
                    StrdsEntFedDest = null;
                    StrCodEntDest = null;
                    StrdsMunDelDest = null;
                    StrCodMDDest = null;

                    return;
                }

                StringBuffer StrSql = new StringBuffer();

                DAOPagoHotel daoPH = null;
                PagoHotel PH = null;

                StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
                ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
                StrSql.delete(0, StrSql.length());

                if (rs.next()) {
                    daoPH = new DAOPagoHotel();
                    PH = daoPH.getPagoHotel(StrclExpediente);

                    //  DATOS DE LA UBICACION DESTINO
                    StrclPaisDest = PH != null ? PH.getClPaisD() : "";
                    StrCodEntDest = PH != null ? PH.getCodEntD() : "";
                    StrdsEntFedDest = PH != null ? PH.getDsEntFedD() : "";
                    StrCodMDDest = PH != null ? PH.getCodMDD() : "";
                    StrdsMunDelDest = PH != null ? PH.getDsMunDelD() : "";

                    if (StrclPaisDest.equalsIgnoreCase("")) {
                        StrclPaisDest = "10";
                    }
                } else {
        %> El expediente no existe <%
                    rs.close();
                    rs = null;

                    StrclUsrApp = null;
                    StrclExpediente = null;
                    StrclPaginaWeb = null;
                    StrclPais = null;
                    StrdsPais = null;
                    StrdsEntFed = null;
                    StrCodEnt = null;
                    StrdsMunDel = null;
                    StrCodMD = null;
                    StrclPaisDest = null;
                    StrdsEntFedDest = null;
                    StrCodEntDest = null;
                    StrdsMunDelDest = null;
                    StrCodMDDest = null;

                    return;
                }               

                session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>

        <script type="text/javascript">fnOpenLinks()</script>

        <%MyUtil.InicializaParametrosC(133, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "fnFechaApertura();", "fnFechaRegistro();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="PagoHotel.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjComboC("Causa", "clCausaAsistencia", PH != null ? PH.getDsCausa() : "", true, true, 30, 82, "", "Select clCausaAsistencia, dsCausaAsistencia From cCausaAsistenciaKM0 Order by dsCausaAsistencia", "", "", 100, false, false)%>
        <%=MyUtil.ObjInput("Tiempo de reparación", "TiempoReparacion", PH != null ? PH.getTiempoReparacion() : "", true, true, 210, 82, "", false, false, 25)%>
        <%=MyUtil.ObjInput("Fecha Apertura<br>(AAAA/MM/DD HH:MM)", "FechaApertura", PH != null ? PH.getFechaApertura() : "", false, false, 380, 70, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Fecha Registro<br>(AAAA/MM/DD HH:MM)", "FechaRegistro", PH != null ? PH.getFechaRegistro() : "", false, false, 520, 70, "", false, false, 20)%>
        <%=MyUtil.ObjComboMem("Pais Residencia", "clPaisReside", StrdsPais, StrclPais, cbPais.GeneraHTML(20, StrdsPais), false, false, 30, 125, StrclPais, "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
        <%=MyUtil.ObjComboMemDiv("Provincia Residencia", "CodEntReside", StrdsEntFed, StrCodEnt, cbEntidad.GeneraHTML(40, StrdsEntFed, Integer.parseInt(StrclPais)), false, false, 300, 125, StrCodEnt, "fnLLenaComboMDAjax(this.value);", "", 20, false, false, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad Residencia", "CodMDReside", StrdsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(40, StrCodEnt, StrdsMunDel), false, false, 30, 165, StrCodMD, "", "", 20, false, false, "LocalidadDiv")%>
        <%=MyUtil.ObjInput("Reservación a nombre de", "ReservacionA", PH != null ? PH.getNomReserva() : "", true, true, 30, 205, "", false, false, 80)%>
        <%=MyUtil.ObjInput("Desde el día<br>(AAAA/MM/DD HH:MM)", "Desde", PH != null ? PH.getFechaInicio() : "", true, true, 465, 194, "", true, true, 20, "if(this.readOnly==false){fnValMask(this,document.all.FechaSiniestroMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Hasta el día<br>(AAAA/MM/DD HH:MM)", "Hasta", PH != null ? PH.getFechaFin() : "", true, true, 605, 194, "", true, true, 20, "if(this.readOnly==false){fnValMask(this,document.all.FechaSiniestroMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("No. Adultos", "NumAdultosViajan", PH != null ? PH.getNoAdultos() : "", true, true, 30, 245, "", false, false, 10, "EsNumerico(document.all.NumAdultosViajan)")%>
        <%=MyUtil.ObjInput("No. Niños", "NumNinosViajan", PH != null ? PH.getNoMenores() : "", true, true, 125, 245, "", false, false, 10, "EsNumerico(document.all.NumNinosViajan)")%>
        <%=MyUtil.ObjInput("Nombre del Hotel", "NombreHotel", PH != null ? PH.getNombreHotel() : "", true, true, 30, 290, "", false, false, 80)%>
        <%=MyUtil.ObjInput("Habitaciones<br>Reservadas", "NumHabitReservadas", PH != null ? PH.getHabReservadas() : "", true, true, 30, 330, "", false, false, 10, "EsNumerico(document.all.NumHabitReservadas)")%>
        <%=MyUtil.ObjInput("No. Habitación<br>Principal", "NumHabitacion", PH != null ? PH.getNumHabitacion() : "", true, true, 135, 330, "", false, false, 10)%>
        <%=MyUtil.ObjComboC("Tipo de Habitación", "clTipoHabitacion", PH != null ? PH.getDsTipoHabitacion() : "", true, true, 250, 343, "", "Select clTipoHabitacion, dsTipoHabitacion From cTipoHabitacion Order by dsTipoHabitacion", "", "", 10, false, false)%>
        <%=MyUtil.ObjInput("<b>Costo Diario<br>Por Habitación</b>", "CostoDiaHabitacion", PH != null ? PH.getCostoCotizado() : "", true, true, 415, 330, "", true, true, 15, "EsNumerico(document.all.CostoDiaHabitacion)")%>
        <%=MyUtil.ObjInput("<b>Costo Cotizado</b>", "CostoCotizacion", PH != null ? PH.getCostoCotizado() : "", true, true, 30, 385, "", true, true, 15, "EsNumerico(document.all.CostoCotizacion)")%>
        <%=MyUtil.ObjInput("<b>Costo Final</b>", "CostoFinal", PH != null ? PH.getCostoFinal() : "", true, true, 135, 385, "", true, true, 15, "EsNumerico(document.all.CostoFinal)")%>
        <%=MyUtil.DoBlock("Detalle del Pago de Hotel", -55, -5)%>

        <%=MyUtil.ObjComboMem("Pais Destino", "clPaisDest", PH != null ? PH.getDsPaisD() : "", PH != null ? PH.getClPaisD() : "", cbPais.GeneraHTML(20, PH != null ? PH.getDsPaisD() : ""), true, true, 30, 470, "0", "fnLlenaEntidadAjaxFnDest(this.value);", "", 20, true, true)%>
        <%=MyUtil.ObjComboMemDiv("Provincia Destino", "CodEntDest", StrdsEntFedDest, StrCodEntDest, cbEntidad.GeneraHTML(40, StrdsEntFedDest, Integer.parseInt(StrclPaisDest)), true, true, 30, 510, StrCodEntDest, "fnLLenaComboMDAjaxDest(this.value);", "", 20, true, true, "CodEntDivDest")%>
        <%=MyUtil.ObjComboMemDiv("Localidad Destino", "CodMDDest", StrdsMunDelDest, StrCodMDDest, cbEntidad.GeneraHTMLMD(40, StrCodEntDest, StrdsMunDelDest), true, true, 415, 510, "", "", "", 20, true, true, "LocalidadDivDest")%>
        <%=MyUtil.ObjInput("Calle y Número", "CalleNum", PH != null ? PH.getCalleD() : "", true, true, 30, 550, "", false, false, 106)%>
        <%=MyUtil.DoBlock("Ubicación del Hotel", 100, -5)%>

        <%=MyUtil.GeneraScripts()%>
        <input id='FechaSiniestroMsk' name='FechaSiniestroMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>

        <%
                rs.close();
                rs = null;

                StrclUsrApp = null;
                StrclExpediente = null;
                StrclPaginaWeb = null;
                StrclPais = null;
                StrdsPais = null;
                StrdsEntFed = null;
                StrCodEnt = null;
                StrdsMunDel = null;
                StrCodMD = null;
                StrclPaisDest = null;
                StrdsEntFedDest = null;
                StrCodEntDest = null;
                StrdsMunDelDest = null;
                StrCodMDDest = null;
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
