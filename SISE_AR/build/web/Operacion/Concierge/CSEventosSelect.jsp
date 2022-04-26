<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage=""%>
<%@ page import = "Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOCSEventosSelects,com.ike.concierge.to.CSEventosSelects,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist,java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
    <head>
        <title>Eventos Select</title>
        <link rel="stylesheet" href="../../StyleClasses/Global.css" type="text/css">
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <link rel="stylesheet" href="../../StyleClasses/Calendario.css" type="text/css">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>
        <style type="text/css">
            .labelAutorizacion{
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                padding: 5px 16px;
                position: absolute;
                font-family: Verdana, Arial, Helvetica, sans-serif;
                font-size: 11px;
                color: white;
                background-color: #000080;
                text-transform: none;
            }
        </style>
    </head>
    <body class="cssBody" onload="fnOnLoad();">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js' ></script>
        <script type="text/javascript" src='../../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilCalendarioV.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilStore.js'></script>
        <script type="text/javascript" src='../../Utilerias/overlib.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>

        <%
            String StrclConcierge = "";
            String StrclSubservicio = "";
            String StrclAsistencia = "0";
            String strclUsr = "";
            String StrURL = "";
            String StrNomPag = "";
            String StrclPaginaWeb = "1445";
            String StrPreguntaEncuesta = "0";
            String strclTipoBen = "0";
            String strclCiudad = "0";
            String strdsEventoSelect = "";
            String strExpCancelada = "0";
            String strFechaExpCancelada = "";
            String strClCSEventoSelect = "";
            String strwList = "0";
            String strNAdultosTMP = "0";
            String StrNumeroAutorizacion = "0";

            if (request.getRequestURL() != null) {
                StrURL = request.getRequestURL().toString();
                StrNomPag = StrURL.substring(StrURL.lastIndexOf("/") + 1);
            }

            DAOCSEventosSelects DAOE = null;
            CSEventosSelects EP = null;

            DAOConciergeG daosg = null;
            ConciergeG conciergeg = null;

            DAOReferenciasxAsist daoRef = null;
            ReferenciasxAsist ref = null;

            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (request.getParameter("clConcierge") != null) {
                StrclConcierge = request.getParameter("clConcierge").toString();
            } else {
                if (session.getAttribute("clConcierge") != null) {
                    StrclConcierge = session.getAttribute("clConcierge").toString();
                }
            }

            if (request.getParameter("clAsistencia") != null) {
                StrclAsistencia = request.getParameter("clAsistencia").toString();
            } else {
                if (session.getAttribute("clAsistencia") != null) {
                    StrclAsistencia = session.getAttribute("clAsistencia").toString();
                }
            }

            if (request.getParameter("clSubservicio") != null) {
                StrclSubservicio = request.getParameter("clSubservicio").toString();
            } else {
                if (session.getAttribute("clSubservicio") != null) {
                    StrclSubservicio = session.getAttribute("clSubservicio").toString();
                }
            }

            session.setAttribute("clAsistencia", StrclAsistencia);
            session.setAttribute("clSubservicio", StrclSubservicio);
            session.setAttribute("clConcierge", StrclConcierge);
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

            //System.out.println("<<<<<<<<<<<<< PArametros: StrclAsistencia:" + StrclAsistencia + ", StrclConcierge:" + StrclConcierge);
            if (strclUsr != null) {

                DAOE = new DAOCSEventosSelects();
                EP = DAOE.getCSEventosSelects(StrclAsistencia);

                daoRef = new DAOReferenciasxAsist();
                ref = daoRef.getclAsistencia(StrclAsistencia);

                daosg = new DAOConciergeG();
                conciergeg = daosg.getConciergeGenerico(StrclConcierge);
            }

            ResultSet rs = null;
            rs = UtileriasBDF.rsSQLNP("sp_CSPreguntaEncuesta " + StrclConcierge);

            if (rs.next()) {
                StrPreguntaEncuesta = rs.getString("Pregunta").toString();
            }

            rs.close();
            rs = null;

            //<<<<<<<<<<<< Servlet Generico >>>>>>>>>>>
            String Store = "";
            Store = "st_GuardaCSEventoSelect,st_ActualizaCSEventosSelect"; //!!!!!!!!!!!!!!!!!!!!!!!
            session.setAttribute("sp_Stores", Store);

            String Commit = "";
            Commit = "clAsistencia";
            session.setAttribute("Commit", Commit);                //!!!!!!!!!!!!!!!!!!!!!!!

            //-----------------------------------------------------
            // SE AGREGA CODIGO PARA EL MANEJO DE LAS ASISTENCIAS DUPLICADAS.
            String StrclAsistenciaVTR = "";
            ResultSet rsTieneAsistMadre = null;
            rsTieneAsistMadre = UtileriasBDF.rsSQLNP(" st_CSTieneAsistMadre " + StrclAsistencia);

            if (rsTieneAsistMadre.next()) {
                if (rsTieneAsistMadre.getString("TieneAsistMadre").equalsIgnoreCase("1")) {
                    StrclAsistenciaVTR = rsTieneAsistMadre.getString("Folio");
                } else {
                    //StrclAsistenciaVTR = ConciergeInfTC!=null ? ConciergeInfTC.getClAsistencia().trim() : "";
                    StrclAsistenciaVTR = StrclAsistencia;
                }
                session.setAttribute("clAsistenciaVTR", StrclAsistenciaVTR);
            }

            rsTieneAsistMadre.close();
            rsTieneAsistMadre = null;

            ResultSet Autorizacion;
            Autorizacion = UtileriasBDF.rsSQLNP(" sp_getNumeroAutorizacion " + StrclAsistencia);
            while (Autorizacion.next()) {
                StrNumeroAutorizacion = Autorizacion.getString("Autorizacion");
                System.out.println("Autorizacion: " + StrNumeroAutorizacion);
            }
            Autorizacion.close();

            strclTipoBen = EP != null ? EP.getClTipoBen() : "0";
            strclCiudad = EP != null ? EP.getClCiudadEveSel() : "0";
            strdsEventoSelect = EP != null ? EP.getDsEventoSelect() : "";
            strExpCancelada = EP != null ? EP.getExpCancelada() : "0";
            strFechaExpCancelada = EP != null ? EP.getFechaExpCancelada() : "";
            strClCSEventoSelect = EP != null ? EP.getClCSEventoSelect() : "";
            strwList = EP != null ? EP.getWList() : "";
            strNAdultosTMP = EP != null ? EP.getNAdultos() : "0";

        %><script type="text/javascript" >fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(1445, Integer.parseInt(strclUsr));%>
        <%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "fnAccionesAlta();", "fnCambio();", "fnAntesGuardar();fnsp_Guarda();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>'>
        <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
        <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
        <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
        <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>

        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>
        <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
        <INPUT id='expCancelada' name='expCancelada' type='hidden' value='<%=strExpCancelada%>'>
        <INPUT id='clCSEventoSelect' name='clCSExpPriceless' type='hidden' value='<%=strClCSEventoSelect%>'>
        <INPUT id='NAdultosTMP' name='NAdultosTMP' type='hidden' value='<%=strNAdultosTMP%>'>

        <input id="Secuencia" name="Secuencia" type="hidden" value="">
        <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="clConcierge,FechaApAsist,DescripcionEvento,clTipoBen,clCiudad,clEventoSelect,FechaE,NLugaresDisponibles,NAdultos,Ninos,Edades,comentExp,wList,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,Confirmo,NConfirmo,PCancel,NuInf,DomFiscal,clUsrApp">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clCSEventoSelect,clAsistencia,DescripcionEvento,clEventoSelect,NAdultos,Ninos,Edades,comentExp,wList,expCancelada,clTipoPago,NomBanco,NombreTC,Confirmo,NConfirmo,PCancel,NuInf,DomFiscal,NAdultosTMP,clUsrApp">

        <div class='VTable' id="divBtnWList" style="position:absolute; z-index:500; left:400px; top:20px; ">
            <input class='cBtn' type='button' value='Waiting List' onClick="fnListaWaitingList();">
        </div>

        <%String strEstatus = EP != null ? EP.getDsEstatus() : "0";%>

        <%=MyUtil.ObjComboC("Estatus", "clEstatus", EP != null ? EP.getDsEstatus() : "", false, false, 30, 80, "0", "sp_GetCSstatus", "", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Asistencia", "AsistenciaVTR", StrclAsistenciaVTR, false, false, 350, 80, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Descripción del evento (máx. 800 caracteres)", "DescripcionEvento", EP != null ? EP.getDescEvent() : "", "77", "7", true, true, 30, 120, "", true, true)%>
        <%=MyUtil.ObjInput("Fecha de apertura", "FechaRegistro", EP != null ? EP.getFechaRegistro() : "", false, false, 540, 80, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Datos Generales del Usuario", -30, 60)%>
        <%=MyUtil.ObjComboC("Beneficio Select", "clTipoBen", EP != null ? EP.getDsTipoBen() : "", true, false, 30, 280, "", "select clTipoBen, dsTipoBen from CScTipoBenEvent where Activo=1 order by dsTipoBen", "fnLlenaCiudadExpAjax(this.value);", "", 20, true, false)%>
        <%=MyUtil.ObjComboCDiv("Ciudad", "clCiudad", EP != null ? EP.getDsCiudadEveSel() : "", true, false, 230, 280, "", "select clCiudad,dsCiudad from CScCiudadEventSel where clTipoBen = " + strclTipoBen + " order by dsCiudad", "fnLlenaExperienciaAjax(this.value)", "", 20, true, false, "CiudadExpDiv")%>
        <%=MyUtil.ObjComboCDiv("Experiencia/Acceso/Evento", "clEventoSelect", EP != null ? EP.getDsEventoSelect() : "", true, false, 430, 280, "", "select clEventoSelect, dsEventoSelect from CScEventSelect where clCiudad = " + strclCiudad + " and Activo=1 order by dsEventoSelect", "fnLlenaLocalidades()", "", 20, true, false, "ExperienciadDiv")%>
        <%=MyUtil.ObjInputF("Fecha del Evento (AAAA-MM-DD)", "FechaE", EP != null ? EP.getFechaE() : "", false, false, 30, 320, "", true, false, 20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};fnValidaFecha();")%>
        <%=MyUtil.ObjInput("Lugares Disponibles", "NLugaresDisponibles", "", false, false, 250, 320, "", false, false, 20)%>
        <%=MyUtil.ObjInput("No. Adultos", "NAdultos", EP != null ? EP.getNAdultos() : "", true, true, 410, 320, "", true, false, 10, "fnValidaLocalidades();")%>
        <%=MyUtil.ObjChkBox("Niños", "Ninos", EP != null ? EP.getNinos().trim() : "", true, true, 520, 320, "", "SI", "NO", "EdadesNinos();")%>
        <%=MyUtil.ObjInput("Edades", "Edades", EP != null ? EP.getEdades().trim() : "", true, true, 620, 320, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Otros (máx. 800 caracteres)", "comentExp", EP != null ? EP.getComentExp() : "", "77", "7", true, true, 30, 360, "", true, false)%>
        <div class='VTable' id='divWList'>
            <%=MyUtil.ObjChkBox("Waiting List", "wList", EP != null ? EP.getWList().trim() : strwList, true, true, 460, 360, "", "SI", "NO", "fnDescStock();")%>
        </div>
        <div class='VTable' id="divBtnCancelaExp" style="position:absolute; z-index:501; left:460px; top:410px; ">
            <input class='cBtn' type='button' value='Cancelar Experiencia/Acceso/Evento' onClick="fnCancelaExp('<%=strdsEventoSelect%>');">
        </div>
        <div class='VTable' id="divLblCancela" style="position:absolute; z-index:502; left:460px; top:410px; ">
            <label class='cBtn'>EXPERIENCIA/ACCESO CANCELAD@<br> EL DÍA:  <%=strFechaExpCancelada%></label>
        </div>

        <%=MyUtil.DoBlock("Datos Generales del Evento", -110, 70)%>

        <%=MyUtil.ObjComboC("Forma de Pago:", "clTipoPago", EP != null ? EP.getDsTipoPago() : "", true, true, 30, 530, "", "select clTipoPago,dsTipoPago from CSTipoPago", "fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Nombre del Banco:", "NomBanco", EP != null ? EP.getNomBanco() : "", true, true, 230, 530, "", false, false, 32)%>
        <%=MyUtil.ObjInput("Nombre en TC:", "NombreTC", EP != null ? EP.getNombreTC() : "", true, true, 450, 530, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Número de TC:", "NumeroTC", EP != null ? EP.getNumeroTC() : "", false, false, 30, 570, "", false, false, 50, "if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        <%=MyUtil.ObjInput("Exp.D.:(MM/AA)", "ExpiraVTR", EP != null ? EP.getExpira() : "", false, false, 330, 570, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
        <input type="hidden" name="Expira" id="Expira" value= "<%=EP != null ? EP.getExpira().trim() : ""%>">
        <%=MyUtil.ObjInput("Sec.C.:", "SecC", EP != null ? EP.getSecC() : "", false, false, 430, 570, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Confirmo", "Confirmo", EP != null ? EP.getConfirmo() : "", true, true, 30, 610, "", false, false, 30)%>
        <%=MyUtil.ObjInput("No.Conf.:", "NConfirmo", EP != null ? EP.getNConfirmo() : "", true, true, 230, 610, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Pol. Cancelación", "PCancel", EP != null ? EP.getPCancel() : "", true, true, 380, 610, "", false, false, 30)%>
        <%=MyUtil.ObjChkBox("N/U inf.:", "NuInf", EP != null ? EP.getNuInf() : "", true, true, 580, 610, "", "SI", "NO", "")%>
        <%=MyUtil.ObjTextArea("Domicilio del Tarjetahabiente (máx. 500 caracteres)", "DomFiscal", EP != null ? EP.getDomFiscal() : "", "80", "8", true, true, 30, 650, "", false, false)%>

        <div id="btnAutorizar" name="btnAutorizar" style="position: absolute; z-index: 503; left: 520px; top: 680px;">
            <label class="labelAutorizacion">
                <%=StrNumeroAutorizacion%>
            </label>
            <BR>
            <input type='button' class='cBtn' style="position: absolute;left: 20px; top: 25px;" value='Autorizar' onClick="fnAbrirLink()">
        </div>
        <%=MyUtil.DoBlock("Datos de Facturación", -70, 80)%>

        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>
        <input name='fechaini' id='fechaini' type='hidden' value=''>
        <input name='fechafin' id='fechafin' type='hidden' value=''>

        <%@ include file="csVentanaFlotante.jspf"%>

        <%
            StrclAsistencia = null;
            DAOE = null;
            EP = null;

            daosg = null;
            conciergeg = null;

            daoRef = null;
            ref = null;

            strclTipoBen = null;
            strclCiudad = null;
            strdsEventoSelect = null;
            strExpCancelada = null;
            strFechaExpCancelada = null;
            strwList = null;
        %>
        <%=MyUtil.GeneraScripts()%>
        <script type="text/javascript" >

            function fnOnLoad() {
                document.all.Edades.readOnly = true;
                document.all.divWList.style.visibility = 'hidden';
                document.all.divBtnCancelaExp.style.visibility = 'hidden';
                document.all.divLblCancela.style.visibility = 'hidden';

                if (document.all.wList.value == 1) {
                    document.all.divWList.style.visibility = 'visible';
                }
                if (document.all.expCancelada.value == "1") {
                    document.all.divLblCancela.style.visibility = 'visible';
                    document.all.btnCambio.disabled = true
                }
                if (document.all.clCSEventoSelect.value != "") {
                    document.all.FechaE.readOnly = true;
                }

                fnLlenaLocalidades();
            }

            function fnLlenaLocalidades() {
                document.all.NLugaresDisponibles.value = "";
                if ((document.all.clCiudad.value != 0) && (document.all.clEventoSelect.value.toString() != "")) {
                    var pstrCadena = "CSValidacionesEventoSelect.jsp?clCiudad=" + document.all.clCiudad.value +
                            "&clEventoSelect=" + document.all.clEventoSelect.value;
                    window.open(pstrCadena, 'newWin', 'width=100,height=100');
                }
            }

            function fnAccionesAlta() {
                if (document.all.Action.value == 1) {
                    var pstrCadena = "../../Utilerias/RegresaFechaActual.jsp";
                    window.open(pstrCadena, 'newWin', 'width=10,height=10,left=1500,top=2000');

                    document.all.clTipoBen.value = "0";
                    document.all.clCiudad.value = "0";
                    document.all.clEventoSelect.value = "0";
                    document.all.Edades.readOnly = true;
                    document.all.divWList.style.visibility = 'hidden'
                    document.all.divLblCancela.style.visibility = 'hidden';
                }
            }

            function fnActualizaFechaActual(pFecha) {    //ok
                document.all.FechaApAsist.value = pFecha;
            }

            function fnRecuperaLocalidades(pLocalidadesDisp, pfechaini, pfechafin) {
                if (document.all.AsistenciaVTR.value != "") {
                    document.all.NLugaresDisponibles.value = pLocalidadesDisp.toString();
                } else {
                    if (pLocalidadesDisp == "nolim") {
                        document.all.NLugaresDisponibles.value = "Sin Limite";
                        document.all.fechaini.value = pfechaini.toString();
                        document.all.fechafin.value = pfechafin.toString();
                        document.all.NAdultos.disabled = false;
                    }
                    else if (pLocalidadesDisp == "0") {
                        alert("LOCALIDADES INSUFICIENTES. LA ASISTENCIA DEBE MARCARSE EN LISTA DE ESPERA PARA RESERVAR UNA CANTIDAD SUPERIOR A LA DISPONIBLE !");
                        document.all.NAdultos.disabled = false;
                        document.all.NLugaresDisponibles.value = "INSUFICIENTES";
                        document.all.divWList.style.visibility = 'visible';
                    }
                    else {
                        document.all.NLugaresDisponibles.value = pLocalidadesDisp.toString();
                        document.all.fechaini.value = pfechaini.toString();
                        document.all.fechafin.value = pfechafin.toString();
                        //document.all.divWList.style.visibility='hidden';
                        document.all.NAdultos.disabled = false;
                    }
                }
            }

            function fnCambio() {               // alert("entro en cambio action: " + document.all.Action.value + " wlis: " + document.all.wList.value + " expCancelada " + document.all.expCancelada.value);                

                if (document.all.Action.value == 2 && document.all.wList.value == 0 && document.all.expCancelada.value == "0") {
                    document.all.divBtnCancelaExp.style.visibility = 'visible';
                } else if (document.all.Action.value == 2 && document.all.wList.value == 1 && document.all.expCancelada.value == "0") {
                    document.all.divWList.style.visibility = 'visible';
                    document.all.divBtnCancelaExp.style.visibility = 'hidden';
                }
            }

            function fnAntesGuardar() {
                var Urlback = document.all.URLBACK.value;

                if (document.all.Action.value == 1) {
                    Urlback = Urlback + "CSCamposExtraAs.jsp?clConcierge=" + document.all.clConcierge.value
                            + "&clSubservicio=" + document.all.clSubservicio.value
                            + "&URLASISTENCIA=" + document.all.clStrURL.value
                            + "&Pregunta=" + document.all.Pregunta.value;

                    if (document.all.NLugaresDisponibles.value != "Sin Limite") {
                        if ((parseInt(document.all.NAdultos.value) > parseInt(document.all.NLugaresDisponibles.value)) && (document.all.wList.value != 1)) {
                            msgVal = msgVal + " DEBE PONERLO EN WAITING LIST";
                            document.all.btnGuarda.readOnly = true;
                            document.all.btnCancela.readOnly = true;
                            document.all.btnGuarda.disabled = false;
                            document.all.btnCancela.disabled = false;
                        }
                    }

                } else {
                    Urlback = Urlback + document.all.clStrNomPag.value + "?";
                }

                var cachahURL = document.all.URLBACK.value;
                if (cachahURL.indexOf(".jsp") == -1) {
                    document.all.URLBACK.value = Urlback;
                }

                if (((document.all.NLugaresDisponibles.value == "INSUFICIENTES") || (document.all.NLugaresDisponibles.value == "0")) && (document.all.wList.value != 1)) {
                    msgVal = msgVal + " DEBE PONERLO EN WAITING LIST";
                    document.all.btnGuarda.readOnly = true;
                    document.all.btnCancela.readOnly = true;
                    document.all.btnGuarda.disabled = false;
                    document.all.btnCancela.disabled = false;
                } else if ((parseInt(document.all.NAdultos.value) > parseInt(document.all.NLugaresDisponibles.value)) && (document.all.wList.value != 1)) {
                    msgVal = msgVal + "DEBE PONERLO EN WAITING LIST";
                    document.all.divWList.style.visibility = 'visible';
                    document.all.btnGuarda.readOnly = true;
                    document.all.btnCancela.readOnly = true;
                    document.all.btnGuarda.disabled = false;
                    document.all.btnCancela.disabled = false;
                }
            }

            function EdadesNinos() {
                document.all.Edades.readOnly = false;
            }

            function fnLlenaCiudadExpAjax(value) {
                IDCombo = 'clCiudad';
                Label = 'Ciudad';
                IdDiv = 'CiudadExpDiv';
                FnCombo = 'fnLlenaExperienciaAjax(this.value)'
                URL = "../../servlet/Utilerias.LlenaCombosAjax?";
                var strConsulta = "st_GetCiudadSelectCS '" + document.all.clTipoBen.value + "'";
                var Cadena = "strSQL=" + strConsulta + "&strName=clCiudadC";
                Cadena += "&Opcion=" + value + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLlenaExperienciaAjax(value) {
                IDCombo = 'clEventoSelect';
                Label = 'Experiencia/Acceso/Evento';
                IdDiv = 'ExperienciadDiv';
                FnCombo = 'fnLlenaLocalidades()';
                URL = "../../servlet/Utilerias.LlenaCombosAjax?";
                var strConsulta = "st_GetEventoSelectCS '" + document.all.clCiudad.value + "'";
                var Cadena = "strSQL=" + strConsulta + "&strName=clEventoSelectC";
                Cadena += "&Opcion=" + value + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);

            }

            function fnValidaLocalidades() {
                if ((isNaN(document.all.NAdultos.value) == true) || (document.all.NAdultos.value.toString().match(/\./))) {
                    alert('Debe ser un número entero.');
                    document.all.NAdultos.value = "";
                } else {
                    if (document.all.clTipoBen.value.toString() == "" || document.all.clTipoBen.value.toString() == "0") {
                        alert("Debe seleccionar un Beneficio Priceless.");
                        document.all.NAdultos.value = "";
                    } else if (document.all.clCiudad.value.toString() == "" || document.all.clCiudad.value.toString() == "0") {
                        alert("Debe seleccionar Ciudad.");
                        document.all.NAdultos.value = "";
                    } else if (document.all.clEventoSelect.value.toString() == "" || document.all.clEventoSelect.value.toString() == "0") {
                        alert("Debe seleccionar Experiencia / Acceso.");
                        document.all.NAdultos.value = "";
                    }
                    else if (document.all.NLugaresDisponibles.value != "Sin Limite") {
                        if ((parseInt(document.all.NAdultos.value) > parseInt(document.all.NLugaresDisponibles.value))) {
                            alert("LOCALIDADES INSUFICIENTES. LA ASISTENCIA DEBE MARCARSE EN LISTA DE ESPERA PARA RESERVAR UNA CANTIDAD SUPERIOR A LA DISPONIBLE !");
                            document.all.divWList.style.visibility = 'visible';
                        } else if (document.all.NAdultos.value.toString() == "0" || document.all.NAdultos.value == "") {
                            alert("Debe ser un número mayor a cero");
                            document.all.NAdultos.value = "";
                        }
                    }
                }
            }

            function fnValidaFecha() {
                if (document.all.clEventoSelect.value.toString() == "" || document.all.clEventoSelect.value.toString() == "0") {
                    alert("Debe seleccionar Experiencia / Acceso.");
                    document.all.FechaE.value = "";
                } else {
                    if (document.all.NLugaresDisponibles.value != "INSUFICIENTES") {
                        if ((document.all.FechaE.value < document.all.fechaini.value) || (document.all.FechaE.value > document.all.fechafin.value)) {
                            alert("Localidades no disponibles para esta fecha.");
                            document.all.divWList.style.visibility = 'visible';
                            document.all.FechaE.value = "";
                        }
                    }
                }
            }

            function fnListaWaitingList() {
                window.open('CSWaitingList.jsp?pclAsistencia=' + document.all.AsistenciaVTR.value, 'Hist', 'scrollbars=yes,status=yes,width=650,height=300');
            }

            function fnCancelaExp(dsExperiencia) {
                var resp = confirm("DESEA CANCELAR " + document.all.NAdultos.value + " ADULTOS" + " DE EXPERIENCIA/ACCESO " + dsExperiencia + " ?");
                if (resp == true) {
                    window.open('CSCancelaEvn.jsp?clCSEventoSelect=' + document.all.clCSEventoSelect.value + '&valProceso=1&NAdultos=' + document.all.NAdultos.value, 'Hist', 'scrollbars=yes,status=yes,width=650,height=300');
                }
            }

            function fnDescStock() {
                if (document.all.wList.value == "0" && document.all.expCancelada.value == "0") {
                    var respWL = confirm("¿DESEA HACER EFECTIVA ESTA RESERVA?");
                    if (respWL == true) {
                        if (parseInt(document.all.NLugaresDisponibles.value) >= parseInt(document.all.NAdultos.value)) {     //alert("VOY A DESCONTAR !!");                                        
                            window.open('CSCancelaEvn.jsp?clCSEventoSelect=' + document.all.clCSEventoSelect.value + '&valProceso=2&NAdultos=' + document.all.NAdultos.value, 'Hist', 'scrollbars=yes,status=yes,width=650,height=300');
                        } else {//alert("LOCALIDADES INSUFICIENTES !!!");                           
                            fnEliminaWL();
                        }
                    } else {
                        fnEliminaWL();
                    }
                }
            }

            function fnEliminaWL() {
                var WL = confirm("¿DESEA QUITAR LA ASISTENCIA DEL LISTADO DE ESPERA?");
                if (WL == true) {
                    window.open('CSCancelaEvn.jsp?clCSEventoSelect=' + document.all.clCSEventoSelect.value + '&valProceso=3&NAdultos=' + document.all.NAdultos.value, 'Hist', 'scrollbars=yes,status=yes,width=650,height=300');
                } else {
                    document.all.wListC.checked = true;
                    document.all.wList.value = 1;
                }
            }

            function fnAbrirAsistencia(NombrePaginaWeb, clAsistencia, clConcierge, clSubservicio) {
                top.Contenido.location.href = NombrePaginaWeb + "&clAsistencia=" + clAsistencia + "&clConcierge=" + document.all.clConcierge.value + "&clSubservicio=" + clSubservicio;
            }
            
            function fnAbrirLink(){
                window.open("../Concierge/CSAutorizaAsistencia.jsp?clAsistencia="+ document.all.clAsistencia.value,"newWin","scrollbars=yes,status=yes,width=1,height=1");
            }

        </script>
        <script type="text/javascript">
            initFloatingWindowWithTabs('window4', Array('Nuestro Usuario', 'Referencia'), 350, 250, 700, 20, false, false, true, true, false);
        </script>
    </body>
</html>
