<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@page import = "com.ike.asistencias.DAORentaAuto,com.ike.asistencias.to.RentaAuto,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS,java.sql.ResultSet,Combos.MarcaAuto,Utilerias.UtileriasObj,Utilerias.UtileriasBDF"%>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Auto Sustituto</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="fnOnLoad();">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js' ></script>
        <script type="text/javascript" src='../../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilDireccion.js' ></script>
        <script type="text/javascript" src='../../Utilerias/UtilAuto.js' ></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilStore.js'></script>

        <%
            com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es", "AR");

            String StrclUsrApp = "0";
            String StrclExpediente = "0";
            String StrclMarcaAuto = "";
            String StrclPaginaweb = "6094";
            //String StrFecha = "";
            String StrclPaisV = "";
            String StrdsPaisV = "";
            String StrCodEntV = "";
            String StrdsEntFedV = "";
            String StrCodMDV = "";
            String StrdsMunDelV = "";
            String StrclPais = "";
            String StrdsPais = "";
            String StrCodEnt = "";
            String StrdsEntFed = "";
            String StrCodMD = "";
            String StrdsMunDel = "";
            String StrDesencripTarj = "";
            String StrNumTC = "";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
                StrclUsrApp = null;
                StrclExpediente = null;
                StrclPaginaweb = null;

                StrclPaisV = null;
                StrdsPaisV = null;
                StrCodEntV = null;
                StrdsEntFedV = null;
                StrCodMDV = null;
                StrdsMunDelV = null;
                StrclPais = null;
                StrdsPais = null;
                StrCodEnt = null;
                StrdsEntFed = null;
                StrCodMD = null;
                StrdsMunDel = null;

                return;
            }

            StringBuffer StrSql = new StringBuffer();
            DAORentaAuto daoRA = null;
            RentaAuto RA = null;

            StrSql.append(" Select TieneAsistencia From Expediente Where clExpediente = ").append(StrclExpediente);
            System.out.println(StrSql.toString());
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs.next()) {

                daoRA = new DAORentaAuto();
                RA = daoRA.getRentaAuto(StrclExpediente);

                StrclPaisV = RA != null ? RA.getClPaisVieaje() : "";
                StrdsPaisV = RA != null ? RA.getDsPaisVieje() : "";
                StrCodEntV = RA != null ? RA.getCodEntViaje() : "";
                StrdsEntFedV = RA != null ? RA.getDsEntFedVieaje() : "";
                StrCodMDV = RA != null ? RA.getCodMDVieaje() : "";
                StrdsMunDelV = RA != null ? RA.getDsMunDelVieaje() : "";
                StrclPais = RA != null ? RA.getClPaisResid() : "";
                StrdsPais = RA != null ? RA.getDsPaisResid() : "";
                StrCodEnt = RA != null ? RA.getCodEntResid() : "";
                StrdsEntFed = RA != null ? RA.getDsEntFedResid() : "";
                StrCodMD = RA != null ? RA.getCodMDResid() : "";
                StrdsMunDel = RA != null ? RA.getDsMunDelResid() : "";
                StrclMarcaAuto = RA != null ? RA.getCodigoMarca() : "";
                StrDesencripTarj = RA != null ? RA.getDesencripTarj() : "0";
                StrNumTC = RA != null ? RA.getNumTC() : "";

                if (StrclPaisV.equalsIgnoreCase("")) {
                    StrclPaisV = "10";
                }
                if (StrclPais.equalsIgnoreCase("")) {
                    StrclPais = "10";
                }
            } else {
        %> El expediente no existe <%
                rs.close();
                rs = null;
                StrSql = null;

                StrclPaisV = null;
                StrdsPaisV = null;
                StrCodEntV = null;
                StrdsEntFedV = null;
                StrCodMDV = null;
                StrdsMunDelV = null;
                StrclPais = null;
                StrdsPais = null;
                StrCodEnt = null;
                StrdsEntFed = null;
                StrCodMD = null;
                StrdsMunDel = null;

                return;
            }
            session.setAttribute("clPaginaWebP", StrclPaginaweb);
        %>
        <script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(6094, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "", "")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="AutoSustituto.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrApp%>'>
        <INPUT id='DesencripTarj' name='DesencripTarj' type='hidden' value='<%=StrDesencripTarj%>'>
        <INPUT id='NumTarjCredito' name='NumTarjCredito' type='hidden' value='<%=StrNumTC%>'>


        <%=MyUtil.ObjComboC("Causa", "clCausaAsistencia", RA != null ? RA.getDsCausaAsistencia() : "", true, true, 30, 70, "", "Select clCausaAsistencia, dsCausaAsistencia From cCausaAsistenciaKM0", "", "", 100, false, false)%>
        <%=MyUtil.ObjInput("Hrs Estimadas de Reparación (>72hs)", "TiempoReparacion", RA != null ? RA.getTiempoReparacion() : "", true, true, 280, 70, "", false, false, 20)%>
        <%=MyUtil.ObjComboC("Marca de Auto que Maneja", "CodigoMarca", RA != null ? RA.getDsMarcaAuto() : "", true, true, 30, 110, "", "Select CodigoMarca, dsMarcaAuto from cMarcaAuto order by dsMarcaAuto", "fnLlenaTipoAutoAjax(this.value,'ClaveAMIS','Tipo de Auto que Maneja','TipoAutoDiv','',2);", "", 70, false, false)%>
        <%=MyUtil.ObjComboCDiv("Tipo de Auto que Maneja", "ClaveAMIS", RA != null ? RA.getDsTipoAuto() : "", true, true, 280, 110, "", "Select ClaveAMIS, dsTipoAuto from cTipoAuto where CodigoMarca = '" + StrclMarcaAuto + "' order by dsTipoAuto", "", "", 160, false, false, "TipoAutoDiv")%>
        <%=MyUtil.ObjInput("Horas de Reservación", "HorasReservacion", RA != null ? RA.getHorasReservacion() : "", true, true, 30, 150, "", false, false, 5)%>
        <%=MyUtil.ObjInput("Reservación a nombre de", "ReservacionA", RA != null ? RA.getReservacionA() : "", true, true, 280, 150, "", false, false, 45, "")%>
        <%--<%=MyUtil.ObjComboC("Tipo Tarjeta Crédito", "cltarjeta", RA != null ? RA.getDstarjeta(): "", true, true, 30, 190, "", "select clTipoPago,dsTipoPago from CSTipoPago where clTipoPago in(1,2,3)", "fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumTarjCredito.value!=''){fnValidaPrefijoTC(document.all.NumTarjCredito.value)};fnLimpiaTar();", "", 30, false, false)%>
            <%=MyUtil.ObjInput("Núm.Tarjeta Crédito","NumTarjCredito", RA != null ? RA.getNumTarjCredito() : "",true,true,200,190,"",false,false,30,"if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        --%>
        <%=MyUtil.ObjComboC("Tipo Tarjeta Crédito:", "clTipoPago", RA != null ? RA.getDsTipoPago() : "", true, false, 30, 190, "", "select clTipoPago,dsTipoPago from CSTipoPago where clTipoPago in(1,2,3)", "fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Número de TC:", "NumeroTC", RA != null ? RA.getNumTarjCredito() : "", true, false, 200, 190, "", false, false, 30, "if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name);fnValidaPrefijoTC(this.value);fnPasaTC()}")%>
        <%=MyUtil.ObjInput("Código Seguridad", "CodigoSeguridad", RA != null ? RA.getCodigoSeguridad() : "", true, false, 400, 190, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Vmto. T.C.(MM/AA)", "VmtoTarjVTR", RA != null ? RA.getVmtoTarjVTR() : "", false, false, 540, 190, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
        <input type="hidden" name="VmtoTarj" id="VmtoTarj" value= "<%=RA != null ? RA.getVmtoTarj() : ""%>">
        <%=MyUtil.ObjInput("# Personas viajan", "NumPersonasViajan", RA != null ? RA.getNumPersonasViajan() : "", true, true, 30, 230, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Nro. Licencia Conducir", "NroLiConducir", RA != null ? RA.getNroLiConducir() : "", true, true, 200, 230, "", false, false, 11)%>
        <%=MyUtil.ObjComboC("Moneda ", "clTipoMoneda", RA != null ? RA.getDsTipoMoneda() : "", true, true, 400, 270, "", "select clTipoMoneda,dsTipoMoneda from cTipoMoneda where activo = 1", "", "", 70, false, false)%>
        <%=MyUtil.ObjInput("Costo de Cotización", "CostoCotizacion", RA != null ? RA.getCostoCotizacion() : "", true, false, 30, 270, "", true, true, 15)%>
        <%=MyUtil.ObjInput("Costo Final", "CostoFinal", RA != null ? RA.getCostoFinal() : "", true, false, 200, 270, "", true, true, 15)%>
        <div class='VTable' id="divBtnDesencripTarj" style="position:absolute; z-index:501; left:400px; top:15px; ">
            <input class='cBtn' type='button' value='Desencriptar Tarjeta' onClick="fnDesencripT('<%=StrDesencripTarj%>')">
        </div>
        <%=MyUtil.DoBlock("Detalle de Renta de Auto", -80, 0)%>

        <%=MyUtil.ObjComboMem("Pais", "clPaisResid", StrdsPaisV, StrclPaisV, cbPais.GeneraHTML(20, StrdsPaisV), true, true, 30, 360, StrclPaisV, "fnLlenaEntidadAjaxFnR(this.value);", "", 20, false, false)%>
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEntResid", StrdsEntFedV, StrCodEntV, cbEntidad.GeneraHTML(40, StrdsEntFedV, Integer.parseInt(StrclPaisV)), true, true, 320, 360, StrCodEntV, "fnLLenaComboMDAjaxR(this.value);", "", 20, false, false, "CodEntDivR")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMDResid", StrdsMunDelV, StrCodMDV, cbEntidad.GeneraHTMLMD(40, StrCodEntV, StrdsMunDelV), true, true, 30, 400, StrCodMDV, "", "", 20, false, false, "LocalidadDivR")%>
        <%=MyUtil.ObjInput("Dirección", "calleNumResid", RA != null ? RA.getDireccionVieaje() : "", true, true, 320, 400, "", false, false, 70)%>
        <%=MyUtil.DoBlock("Lugar de Viaje", 200, 0)%>

        <%=MyUtil.ObjComboMem("Pais", "clPais", StrdsPais, StrclPais, cbPais.GeneraHTML(20, StrdsPais), true, true, 30, 490, StrclPais, "fnLlenaEntidadAjaxFnN(this.value);", "", 20, false, false)%>
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", StrdsEntFed, StrCodEnt, cbEntidad.GeneraHTML(40, StrdsEntFed, Integer.parseInt(StrclPais)), true, true, 320, 490, StrCodEnt, "fnLLenaComboMDAjaxN(this.value);", "", 20, false, false, "CodEntDivN")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", StrdsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(40, StrCodEnt, StrdsMunDel), true, true, 30, 530, StrCodMD, "", "", 20, false, false, "LocalidadDivN")%>
        <%=MyUtil.ObjInput("Dirección", "CalleNum", RA != null ? RA.getDireccionResid() : "", true, true, 320, 530, "", false, false, 60)%>
        <%=MyUtil.DoBlock("Lugar de Residencia", 200, 0)%>

        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>
        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
        <%
            daoRA = null;
            RA = null;

            rs.close();
            rs = null;

            StrclUsrApp = null;
            StrclExpediente = null;
            StrclPaginaweb = null;

            StrclPaisV = null;
            StrdsPaisV = null;
            StrCodEntV = null;
            StrdsEntFedV = null;
            StrCodMDV = null;
            StrdsMunDelV = null;
            StrclPais = null;
            StrdsPais = null;
            StrCodEnt = null;
            StrdsEntFed = null;
            StrCodMD = null;
            StrdsMunDel = null;
        %>

        <%=MyUtil.GeneraScripts()%>
        <script type="text/javascript">

            function fnOnLoad() { //alert(document.all.DesencripTarj.value);  //quitar

                document.all.btnElimina.disabled = true;

                if (document.all.NumTarjCredito.value != "" && document.all.DesencripTarj.value == 0) {
                    document.all.divBtnDesencripTarj.style.visibility = 'visible';
                } else {
                    document.all.divBtnDesencripTarj.style.visibility = 'hidden';
                }
            }

            function fnDesencripT() {
                var resp = confirm("DESEA DESENCRIPTAR LA TARJETA ?");
                if (resp == true) {
                    window.open('DesencripTarj.jsp?pclExpediente=' + document.all.clExpediente.value + '&clUsrApp=' + document.all.clUsrApp.value, 'Hist', 'scrollbars=yes,status=yes,width=100,height=100');
                }
            }

            function fnActualizaEncrip(ntaj, codseg) {
                document.all.NumeroTC.value = ntaj;
                document.all.CodigoSeguridad.value = codseg;
                document.all.divBtnDesencripTarj.style.visibility = 'hidden';
            }

            function fnLlenaEntidadAjaxFnR(cod) {
                IDCombo = 'CodEntResid';
                Label = 'Provincia';
                IdDiv = 'CodEntDivR';
                FnCombo = 'fnLLenaComboMDAjaxR(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion=" + cod + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjaxR(value) {
                IDCombo = 'CodMDResid';
                Label = 'Localidad';
                IdDiv = 'LocalidadDivR';
                FnCombo = '';
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion=" + value + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv)
            }

            function fnLlenaEntidadAjaxFnN(cod) {
                IDCombo = 'CodEnt';
                Label = 'Provincia';
                IdDiv = 'CodEntDivN';
                FnCombo = 'fnLLenaComboMDAjaxN(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion=" + cod + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjaxN(value) {
                IDCombo = 'CodMD';
                Label = 'Localidad';
                IdDiv = 'LocalidadDivN';
                FnCombo = '';
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion=" + value + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv)
            }

            function fnLimpiaTar() {//alert("valor campo: " + document.all.cltarjeta.value);
                if (document.all.clTipoPago.value == 1 || document.all.clTipoPago.value == 2 || document.all.clTipoPago.value == 3) {
                    document.all.NumeroTC.value = "";
                    document.all.VmtoTarj.value = "";
                    document.all.VmtoTarjVTR.value = "";
                    document.all.CodigoSeguridad.value = "";
                } else {
                    document.all.NumeroTC.readOnly = false;
                    document.all.VmtoTarj.readOnly = false;
                    document.all.VmtoTarjVTR.readOnly = false;
                    document.all.CodigoSeguridad.readOnly = false;
                }
            }

            function fnTipoPago(opcion) {
                if (document.all.Action.value == 1) {
                    if (opcion == 1) {
                        document.all.NumeroTC.readOnly = false;
                        document.all.CodigoSeguridad.readOnly = false;
                        document.all.VmtoTarjVTR.readOnly = false;
                        document.all.NumeroTC.maxLenght = 19;
                        document.all.CodigoSeguridad.maxLength = 3;
                        document.all.NumeroTCMsk.value = "VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09";
                        document.all.SecCMsk.value = "VN09VN09VN09";
                        document.all.NumeroTC.className = "FReq";
                        document.all.CodigoSeguridad.className = "FReq";
                        document.all.VmtoTarjVTR.className = "FReq";
                        document.all.ExpiraMsk.value = "VN09VN09F-/-VN09VN09";
                    } else if (opcion == 2) {
                        document.all.NumeroTC.readOnly = false;
                        document.all.CodigoSeguridad.readOnly = false;
                        document.all.VmtoTarjVTR.readOnly = false;
                        document.all.NumeroTC.maxLenght = 19;
                        document.all.CodigoSeguridad.maxLength = 3;
                        document.all.NumeroTCMsk.value = "VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09";
                        document.all.SecCMsk.value = "VN09VN09VN09";
                        document.all.NumeroTC.className = "FReq";
                        document.all.CodigoSeguridad.className = "FReq";
                        document.all.VmtoTarjVTR.className = "FReq";
                        document.all.ExpiraMsk.value = "VN09VN09F-/-VN09VN09";
                    } else if (opcion == 3) {
                        document.all.NumeroTC.readOnly = false;
                        document.all.CodigoSeguridad.readOnly = false;
                        document.all.VmtoTarjVTR.readOnly = false;
                        document.all.CodigoSeguridad.maxLength = 4;
                        document.all.NumeroTCMsk.value = "VN09VN09VN09VN09F-/-VN09VN09VN09VN09VN09VN09F-/-VN09VN09VN09VN09VN09";
                        document.all.NumeroTC.maxLenght = 18;
                        document.all.SecCMsk.value = "VN09VN09VN09VN09";
                        document.all.NumeroTC.className = "FReq";
                        document.all.CodigoSeguridad.className = "FReq";
                        document.all.VmtoTarjVTR.className = "FReq";
                        document.all.ExpiraMsk.value = "VN09VN09F-/-VN09VN09";
                    } else {
                        document.all.NumeroTCMsk.value = "";
                        document.all.ExpiraMsk.value = "";
                        document.all.NumeroTC.readOnly = true;
                        document.all.CodigoSeguridad.readOnly = true;
                        document.all.VmtoTarjVTR.readOnly = true;
                        document.all.NumeroTC.value = "";
                        document.all.CodigoSeguridad.value = "";
                        document.all.VmtoTarj.value = "";
                        document.all.SecCMsk.value = "";
                        document.all.VmtoTarjVTR.value = "";
                        document.all.NumeroTC.className = "VTable";
                        document.all.CodigoSeguridad.className = "VTable";
                        document.all.VmtoTarjVTR.className = "VTable";
                    }
                } else if (document.all.Action.value == 2) {

                    if (opcion == 1) {
                        document.all.NumeroTC.readOnly = false;
                        document.all.CodigoSeguridad.readOnly = false;
                        document.all.VmtoTarjVTR.readOnly = false;
                        document.all.NumeroTC.maxLenght = 19;
                        document.all.CodigoSeguridad.maxLength = 3;
                        document.all.NumeroTCMsk.value = "VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09";
                        document.all.SecCMsk.value = "VN09VN09VN09";
                        document.all.ExpiraMsk.value = "VN09VN09F-/-VN09VN09";
                    } else if (opcion == 2) {
                        document.all.NumeroTC.readOnly = false;
                        document.all.CodigoSeguridad.readOnly = false;
                        document.all.VmtoTarjVTR.readOnly = false;
                        document.all.NumeroTC.maxLenght = 19;
                        document.all.CodigoSeguridad.maxLength = 3;
                        document.all.NumeroTCMsk.value = "VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09";
                        document.all.SecCMsk.value = "VN09VN09VN09";
                        document.all.ExpiraMsk.value = "VN09VN09F-/-VN09VN09";
                    } else if (opcion == 3) {
                        document.all.NumeroTC.readOnly = false;
                        document.all.CodigoSeguridad.readOnly = false;
                        document.all.VmtoTarjVTR.readOnly = false;
                        document.all.CodigoSeguridad.maxLength = 4;
                        document.all.NumeroTCMsk.value = "VN09VN09VN09VN09F-/-VN09VN09VN09VN09VN09VN09F-/-VN09VN09VN09VN09VN09";
                        document.all.NumeroTC.maxLenght = 18;
                        document.all.SecCMsk.value = "VN09VN09VN09VN09";
                        document.all.ExpiraMsk.value = "VN09VN09F-/-VN09VN09";
                    } else {
                        document.all.NumeroTCMsk.value = "";
                        document.all.ExpiraMsk.value = "";
                        document.all.NumeroTC.readOnly = true;
                        document.all.CodigoSeguridad.readOnly = true;
                        document.all.VmtoTarjVTR.readOnly = true;
                        document.all.NumeroTC.value = "";
                        document.all.CodigoSeguridad.value = "";
                        document.all.VmtoTarj.value = "";
                        document.all.SecCMsk.value = "";
                        document.all.ExpiraVTR.value = "";
                        document.all.NumeroTC.className = "VTable";
                        document.all.CodigoSeguridad.className = "VTable";
                        document.all.VmtoTarjVTR.className = "VTable";
                    }
                }
            }

            function fnValidaPrefijoTC(numtc) {

                if (document.all.NumeroTC.value != "") {
                    if (document.all.clTipoPagoC.value == "1") {
                        if (numtc.substring(0, 1) != "4") {
                            alert("El prefijo de VISA no es válido.");
                            fnLimpiaTar();
                            document.all.NumeroTC.value = "";
                            document.all.NumeroTC.focus();
                        }
                    }

                    if (document.all.clTipoPagoC.value == "2") {
                        if (numtc.substring(0, 1) != "5") {
                            alert("El prefijo de MASTERCARD no es válido.");
                            fnLimpiaTar();
                            document.all.NumeroTC.value = "";
                            document.all.NumeroTC.focus();
                        }
                    }

                    if (document.all.clTipoPagoC.value == "3") {
                        if (numtc.substring(0, 1) != "3") {
                            alert("El prefijo de AMERICAN EXPRESS no es válido.");
                            fnLimpiaTar();
                            document.all.NumeroTC.value = "";
                            document.all.NumeroTC.focus();
                        }
                    }
                }
            }

            function fnFechVen(venc) {
                if (document.all.VmtoTarjVTR.value == "-") {      //*
                    document.all.VmtoTarjVTR.value = "";          //*
                } else {
                    if (document.all.VmtoTarjVTR.value != "") {
                        var mes = venc.substring(0, 2);
                        var anio = venc.substring(3, 5);
                        document.all.VmtoTarj.value = '20' + anio + "-" + mes;
                        var actual = new Date();
                        var vanio = '20' + anio;
                        var aanio = actual.getYear();
                        var ames = actual.getMonth();
                        //alert("Mes"+actual.getMonth());
                        var sanio = aanio.toString();
                        var smes = ames.toString();
                        var actanio = parseInt(sanio, 10);
                        var actmes = parseInt(smes, 10);
                        var venanio = parseInt(vanio, 10);
                        var venmes = parseInt(mes, 10);

                        actmes = actmes + 1;
                        // alert(actanio+"-"+venanio);
                        //alert(actmes+"-"+venmes);

                        if (actanio <= venanio) {
                            //alert(venmes);
                            if (venmes < 13 && venmes != 0) {
                                var ianio = actanio;
                                var imes = actmes;
                                var inmes = 12;
                                var contmes = 0;

                                for (ianio; ianio <= venanio; ianio++) {
                                    if (ianio == venanio)
                                        inmes = venmes;

                                    for (imes; (imes <= inmes) && (imes < 13); imes++) {
                                        contmes = contmes + 1;
                                    }

                                    if (imes > 12)
                                        imes = 1;
                                }
                            } else {
                                alert("Fecha Invalida, Favor de Verificar");
                                document.all.VmtoTarjVTR.value = "";
                                document.all.VmtoTarj.value = "";
                                document.all.VmtoTarjVTR.focus();
                                document.all.btnGuarda.readOnly = false;
                                document.all.btnCancela.readOnly = false;
                                document.all.btnGuarda.disabled = false;
                                document.all.btnCancela.disabled = false;
                            }

                        } else {

                            if (contmes < 1 || (venanio <= actanio)) {
                                alert("La Tarjeta Esta Vencida");
                                document.all.VmtoTarjVTR.value = "";
                                document.all.VmtoTarj.value = "";
                                document.all.VmtoTarjVTR.focus();
                                document.all.btnGuarda.readOnly = false;
                                document.all.btnCancela.readOnly = false;
                                document.all.btnGuarda.disabled = false;
                                document.all.btnCancela.disabled = false;
                            }
                        }
                    }
                }
            }

            function fnPasaTC() {
                document.all.NumTarjCredito.value = document.all.NumeroTC.value;
            }

        </script>
    </body>
</html>
