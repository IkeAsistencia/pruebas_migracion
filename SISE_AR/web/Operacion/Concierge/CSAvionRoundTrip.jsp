<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOAvionOneWay,com.ike.concierge.to.ConciergeAvionOneWay,com.ike.concierge.DAOAvionRoundTrip,com.ike.concierge.to.ConciergeAvionRoundTrip,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<html>
    <head><title>Compra de Boletos de Avión Round Trip</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>        
    </head>
    <body class="cssBody" onload="NUInfo();
                fnVerificaFecha();
                fnApareceBtnAgregar();
                if (document.all.ExpiraVTR.value != '') {
                    fnFechVen(document.all.ExpiraVTR.value)
                }">

        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script> 
        <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>    
        <script src='../../Utilerias/UtilCalendarioV.js'></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i>Compra de Boletos de Avión (Round Trip)</i></b>  <br> </p></div>
        <div class='VTable' style='position:absolute; z-index:25; left:570px; top:93px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Automatica </i></b>  <br> </p></div>
                        <%
                            String StrclConcierge = "0";
                            String StrclSubservicio = "0";
                            String StrclAsistencia = "0";
                            String strclUsr = "0";
                            String StrNumAdultos = "0";
                            String StrNumNinos = "0";
                            String StrEdades = "";
                            String StrclAvionRoundTrip = "";
                            String StrCargo = "";
                            String StrCdOrigen = "";
                            String StrCdDestino = "";
                            String StrAptOrigen = "";
                            String StrAptDestino = "";
                            String StrClase = "";
                            String StrclFormaPago = "";
                            String StrNomBanco = "";
                            String StrNombreTC = "";
                            String StrNumeroTC = "";
                            String StrExpira = "";
                            String StrExpiraVTR = "";
                            String StrSecC = "";
                            String StrConfirmo = "";
                            String StrNumConfirmacion = "";
                            String StrCancelacion = "";
                            String StrNUInfo = "0";
                            String StrLugarPagar = "";
                            String StrCveReservacion = "";
                            String StrMetEntrega = "";
                            String StrComentarios = "";
                            DAOAvionOneWay daos = null;
                            ConciergeAvionOneWay conciergeaviononeway = null;
                            DAOAvionRoundTrip daosrt = null;
                            ConciergeAvionRoundTrip conciergeavionroundtrip = null;
                            DAOConciergeG daosg = null;
                            ConciergeG conciergeg = null;

                            DAOReferenciasxAsist daoRef = null;
                            ReferenciasxAsist ref = null;

                            if (session.getAttribute("clUsrApp") != null) {
                                strclUsr = session.getAttribute("clUsrApp").toString();
                            }

                            if (session.getAttribute("clConcierge") != null) {
                                StrclConcierge = session.getAttribute("clConcierge").toString();
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

                            if (request.getParameter("NumAdultos") != null) {
                                StrNumAdultos = request.getParameter("NumAdultos").toString();
                            }
                            if (request.getParameter("NumNinos") != null) {
                                StrNumNinos = request.getParameter("NumNinos").toString();
                            }
                            if (request.getParameter("Edades") != null) {
                                StrEdades = request.getParameter("Edades").toString();
                            }
                            if (request.getParameter("clAvionRoundTrip") != null) {
                                StrclAvionRoundTrip = request.getParameter("clAvionRoundTrip").toString();
                            }
                            if (request.getParameter("Cargo") != null) {
                                StrCargo = request.getParameter("Cargo").toString();
                            }
                            if (request.getParameter("CdOrigen") != null) {
                                StrCdOrigen = request.getParameter("CdOrigen").toString();
                            }
                            if (request.getParameter("CdDestino") != null) {
                                StrCdDestino = request.getParameter("CdDestino").toString();
                            }
                            if (request.getParameter("AptOrigen") != null) {
                                StrAptOrigen = request.getParameter("AptOrigen").toString();
                            }
                            if (request.getParameter("AptDestino") != null) {
                                StrAptDestino = request.getParameter("AptDestino").toString();
                            }
                            if (request.getParameter("Clase") != null) {
                                StrClase = request.getParameter("Clase").toString();
                            }
                            if (request.getParameter("clFormaPago") != null) {
                                StrclFormaPago = request.getParameter("clFormaPago").toString();
                            }
                            if (request.getParameter("NomBanco") != null) {
                                StrNomBanco = request.getParameter("NomBanco").toString();
                            }
                            if (request.getParameter("NombreTC") != null) {
                                StrNombreTC = request.getParameter("NombreTC").toString();
                            }
                            if (request.getParameter("NumeroTC") != null) {
                                StrNumeroTC = request.getParameter("NumeroTC").toString();
                            }
                            if (request.getParameter("Expira") != null) {
                                StrExpira = request.getParameter("Expira").toString();
                            }
                            if (request.getParameter("ExpiraVTR") != null) {
                                StrExpiraVTR = request.getParameter("ExpiraVTR").toString();
                            }
                            if (request.getParameter("SecC") != null) {
                                StrSecC = request.getParameter("SecC").toString();
                            }
                            if (request.getParameter("Confirmo") != null) {
                                StrConfirmo = request.getParameter("Confirmo").toString();
                            }
                            if (request.getParameter("NumConfirmacion") != null) {
                                StrNumConfirmacion = request.getParameter("NumConfirmacion").toString();
                            }
                            if (request.getParameter("Cancelacion") != null) {
                                StrCancelacion = request.getParameter("Cancelacion").toString();
                            }
                            if (request.getParameter("NUInfo") != null) {
                                StrNUInfo = request.getParameter("NUInfo").toString();
                            }
                            if (request.getParameter("LugarPagar") != null) {
                                StrLugarPagar = request.getParameter("LugarPagar").toString();
                            }
                            if (request.getParameter("CveReservacion") != null) {
                                StrCveReservacion = request.getParameter("CveReservacion").toString();
                            }
                            if (request.getParameter("MetEntrega") != null) {
                                StrMetEntrega = request.getParameter("MetEntrega").toString();
                            }
                            if (request.getParameter("Comentarios") != null) {
                                StrComentarios = request.getParameter("Comentarios").toString();
                            }

                            System.out.println(StrMetEntrega);

                            session.setAttribute("clAsistencia", StrclAsistencia);
                            session.setAttribute("clSubservicio", StrclSubservicio);
                            String StrclPaginaWeb = "755";
                            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

                            if (strclUsr != null) {
                                daosrt = new DAOAvionRoundTrip();
                                conciergeavionroundtrip = daosrt.getCSAvionRoundTrip(StrclAsistencia);

                                daoRef = new DAOReferenciasxAsist();
                                ref = daoRef.getclAsistencia(StrclAsistencia);
                            }
                            if (strclUsr != null) {
                                daos = new DAOAvionOneWay();
                                conciergeaviononeway = daos.getCSAvionOneWay(StrclAsistencia);
                            }
                            if (strclUsr != null) {
                                daosg = new DAOConciergeG();
                                conciergeg = daosg.getConciergeGenerico(StrclConcierge);
                            }
                        %>
        <SCRIPT>fnOpenLinks()</script> 
            <% MyUtil.InicializaParametrosC(755, Integer.parseInt(strclUsr));%>
            <%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaAvionRoundTrip", "fnAccionesAlta();", "fnAntesGuardar();fnAdicional();fnValidaFecha();fnReqCampo();")%>
            <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="CSAvionRoundTrip.jsp?'>"%>

        <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
        <INPUT id='clAvionRoundTrip' name='clAvionRoundTrip' type='hidden' value='<%=conciergeavionroundtrip != null ? conciergeavionroundtrip.getclAvionRoundTrip() : ""%>'>
        <%String strEstatus = conciergeavionroundtrip != null ? conciergeavionroundtrip.getdsEstatus() : "";%>
        <%=MyUtil.ObjComboC("Estatus", "clEstatus", conciergeaviononeway != null ? conciergeaviononeway.getdsEstatus() : "", false, false, 30, 80, "0", "sp_GetCSstatus", "", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Asistencia", "AsistenciaVTR", conciergeavionroundtrip != null ? conciergeavionroundtrip.getclAsistencia().trim() : "", false, false, 350, 80, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento", "Comentarios", conciergeavionroundtrip != null ? conciergeavionroundtrip.getComentarios() : "", "83", "3", true, true, 30, 120, StrComentarios, true, true)%>
        <%=MyUtil.ObjInput("fecha de alta", "FechaRegistro", conciergeavionroundtrip != null ? conciergeavionroundtrip.getFechaRegistro() : "", false, false, 650, 80, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Datos Generales del Usuario", 10, 10)%>

        <%=MyUtil.ObjInput("No.Adultos", "NumAdultos", conciergeavionroundtrip != null ? conciergeavionroundtrip.getNumAdultos() : "", true, true, 30, 220, StrNumAdultos, false, false, 5, "EsNumerico(this)")%>
        <%=MyUtil.ObjInput("No. Niños", "NumNinos", conciergeavionroundtrip != null ? conciergeavionroundtrip.getNumNinos() : "", true, true, 130, 220, StrNumNinos, false, false, 5, "EsNumerico(this)")%>
        <%=MyUtil.ObjInput("Edades", "Edades", conciergeavionroundtrip != null ? conciergeavionroundtrip.getEdades() : "", true, true, 220, 220, StrEdades, false, false, 30)%>

        <%=MyUtil.ObjInput("Info de Vuelo", "InfoVuelo", conciergeavionroundtrip != null ? conciergeavionroundtrip.getInfoVuelo() : "", true, true, 30, 260, "", true, true, 30)%>
        <%=MyUtil.ObjComboC("Pasajeros", "Pasajeros", "", false, true, 240, 260, "", "st_CSMostrarUsrRoundTrip " + StrclAsistencia, "", "fnApareceBtnEliminar(this.value)", 50, false, false)%>  
        <div class='VTable' style='position:absolute; z-index:40; left:550px; top:270px; visibility:hidden' id="BtnEliminar">
            <input type="button" onClick="fnVentanaEliminaPasajero(document.all.PasajerosC.value);" class="cBtn" value="Eliminar">
        </div>
        <div class='VTable' style='position:absolute; z-index:40; left:620px; top:270px; visibility:hidden' id="BtnAgregar">
            <input type="button" onClick="if (document.all.Action.value == '1' || document.all.Action.value == '2') {
                    fnVentanaAltaPasajero(document.all.clConcierge.value, document.all.clUsrApp.value);
                }" class="cBtn" value="Agregar">
        </div>    
        <%=MyUtil.ObjInput("Ciudad Origen", "CdOrigen", conciergeavionroundtrip != null ? conciergeavionroundtrip.getCdOrigen() : "", true, true, 30, 300, StrCdOrigen, true, true, 30)%>
        <%=MyUtil.ObjInput("Aereopuerto Origen", "AptOrigen", conciergeavionroundtrip != null ? conciergeavionroundtrip.getAptOrigen() : "", true, true, 240, 300, StrAptOrigen, true, true, 30)%>    
        <%=MyUtil.ObjInputF("Fecha de Salida <Strong>(AAAA-MM-DD hh:mm)</Strong>", "FechaSalida", conciergeavionroundtrip != null ? conciergeavionroundtrip.getFechaSalida() : "", true, true, 450, 300, "", true, true, 20, 2, "")%>  </div>
        <%=MyUtil.ObjInput("Ciudad Destino", "CdDestino", conciergeavionroundtrip != null ? conciergeavionroundtrip.getCdDestino() : "", true, true, 30, 340, StrCdDestino, true, true, 30)%>
        <%=MyUtil.ObjInput("Aereopuerto Destino", "AptDestino", conciergeavionroundtrip != null ? conciergeavionroundtrip.getAptDestino() : "", true, true, 240, 340, StrAptDestino, true, true, 30)%>    
        <%=MyUtil.ObjInputF("Fecha de Arribo <Strong>(AAAA-MM-DD hh:mm)</Strong>", "FechaArribo", conciergeavionroundtrip != null ? conciergeavionroundtrip.getFechaArribo() : "", true, true, 450, 340, "", true, true, 20, 2, "")%>  </div>
    <%=MyUtil.ObjInput("Conexiones", "Conexiones", conciergeavionroundtrip != null ? conciergeavionroundtrip.getConexiones() : "", true, true, 30, 380, "", false, false, 75, "")%>
    <%=MyUtil.ObjInput("Clase/Código", "Clase", conciergeavionroundtrip != null ? conciergeavionroundtrip.getClase() : "", true, true, 30, 420, StrClase, false, false, 30, "")%>
    <%=MyUtil.ObjInputF("Tiempo Límite <Strong>(AAAA-MM-DD hh:mm)</Strong>", "TiempoLimite", conciergeavionroundtrip != null ? conciergeavionroundtrip.getTiempoLimite() : "", true, true, 240, 420, "", false, false, 20, 2, "")%>  </div>

<%=MyUtil.DoBlock("Datos de Compra (One Way)", 50, 5)%>

<%=MyUtil.ObjComboC("Forma de Pago:", "clTipoPago", conciergeavionroundtrip != null ? conciergeavionroundtrip.getdsFormaPago() : "", true, true, 30, 520, StrclFormaPago, "select clTipoPago,dsTipoPago from CSTipoPago", "fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();", "", 30, false, false)%>
<%=MyUtil.ObjInput("Nombre del Banco:", "NomBanco", conciergeavionroundtrip != null ? conciergeavionroundtrip.getNomBanco() : "", false, false, 200, 520, StrNomBanco, false, false, 40)%>
<%=MyUtil.ObjInput("Nombre en TC:", "NombreTC", conciergeavionroundtrip != null ? conciergeavionroundtrip.getNombreTC() : "", false, false, 450, 520, StrNombreTC, false, false, 30)%>
<%=MyUtil.ObjInput("Cargo Total", "Cargo", conciergeavionroundtrip != null ? conciergeavionroundtrip.getCargo() : "", true, true, 650, 520, StrCargo, false, false, 10, "EsNumerico(this)")%>
<%=MyUtil.ObjInput("Numero de TC:", "NumeroTC", conciergeavionroundtrip != null ? conciergeavionroundtrip.getNumeroTC() : "", false, false, 30, 560, StrNumeroTC, false, false, 50, "if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
<%=MyUtil.ObjInput("Exp.D.:(MM-AA)", "ExpiraVTR", conciergeavionroundtrip != null ? conciergeavionroundtrip.getExpira() : "", false, false, 350, 560, StrExpiraVTR, false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
<input type="hidden" name="Expira" id="Expira" value="<%=StrExpira%>">
<%=MyUtil.ObjInput("Sec.C.:", "SecC", conciergeavionroundtrip != null ? conciergeavionroundtrip.getSecC() : "", false, false, 540, 560, StrSecC, false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
<%=MyUtil.ObjInput("Confirmo", "Confirmo", conciergeavionroundtrip != null ? conciergeavionroundtrip.getConfirmo() : "", true, true, 30, 600, StrConfirmo, false, false, 50)%>
<%=MyUtil.ObjInput("No.Conf.:", "NumConfirmacion", conciergeavionroundtrip != null ? conciergeavionroundtrip.getNumConfirmacion() : "", true, true, 350, 600, StrNumConfirmacion, false, false, 30, "")%>
<%=MyUtil.ObjInput("Pol.Cancelación", "Cancelacion", conciergeavionroundtrip != null ? conciergeavionroundtrip.getCancelacion() : "", true, true, 30, 640, StrCancelacion, false, false, 50)%>
<%=MyUtil.ObjInput("Lugar de Pago", "LugarPagar", conciergeavionroundtrip != null ? conciergeavionroundtrip.getLugarPagar() : "", true, true, 350, 640, StrLugarPagar, false, false, 30)%>
<%=MyUtil.ObjInput("Clave de Reservación", "CveReservacion", conciergeavionroundtrip != null ? conciergeavionroundtrip.getCveReservacion() : "", true, true, 30, 680, StrCveReservacion, false, false, 50)%>
<%=MyUtil.ObjChkBox("N/U inf.:", "NUInfo", conciergeavionroundtrip != null ? conciergeavionroundtrip.getNUInfo() : "", true, true, 350, 680, "0", "SI", "NO", "")%>
<!--%=MyUtil.ObjChkBox("N/U inf.:","NUInfo",conciergeavionroundtrip!=null ? conciergeavionroundtrip.getNUInfo() : "",true,true,350,680,"0","SI","NO","")%-->
<%=MyUtil.ObjInput("Método de Entrega", "MetEntrega", conciergeavionroundtrip != null ? conciergeavionroundtrip.getMetEntrega() : "", true, true, 30, 720, StrMetEntrega, false, false, 50)%>
<%=MyUtil.DoBlock("Forma de Pago", 30, 0)%>

<input name='FechaSalidaMsk' id='FechaSalidaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<input name='FechaArriboMsk' id='FechaArriboMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
<input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
<input name='SecCMsk' id='SecCMsk' type='hidden' value=''>
<input name='TiempoLimiteMsk' id='TiempoLimiteMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<%@ include file="csVentanaFlotante.jspf" %>

<%=MyUtil.GeneraScripts()%> 



<script>
            function NUInfo() {
                document.all.NUInfo.value = 0;
            }

            document.all.SecC.maxLength = 4;
//alert(document.all.clAvionRoundTrip.value);

            if (document.all.clAvionRoundTrip.value != "") {
                document.all.btnAlta.disabled = true;
            }

            function fnValidaFecha()
            {
                if (document.all.FechaSalida.value != '' && document.all.FechaArribo.value != '')
                {
                    if (document.all.FechaArribo.value <= document.all.FechaSalida.value)
                    {
                        msgVal = msgVal + " Fecha Arribo debe de ser mayor a Fecha Salida. "
                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    }

                }
            }
            function fnAccionesAlta() {
                if (document.all.Action.value == 1) {
                    var pstrCadena = "../../Utilerias/RegresaFechaActual.jsp";
                    window.open(pstrCadena, 'newWin', 'width=10,height=10,left=1500,top=2000');
                }
            }
            function fnActualizaFechaActual(pFecha) {
                document.all.FechaApAsist.value = pFecha;
            }

            function fnAdicional() {
                /*if (document.all.Ninos.value==1){
                 if(document.all.Edades.value==""){
                 msgVal = msgVal + " Debe Ingresar Edades. ";
                 document.all.btnGuarda.disabled=false;
                 document.all.btnCancela.disabled=false;
                 }
                 }
                 else{
                 document.all.Edades.value="";
                 } */
            }


            function fnApareceBtnEliminar(valor) {
                if (valor != "") {
                    document.all.BtnEliminar.style.visibility = 'visible';
                } else {
                    document.all.BtnEliminar.style.visibility = 'hidden';
                }
            }

            function fnApareceBtnAgregar() {
                if (document.all.clAsistencia.value != "0") {
                    document.all.BtnAgregar.style.visibility = 'visible';
                } else {
                    document.all.BtnAgregar.style.visibility = 'hidden';
                }
            }


            function fnLlenaPasajeros() {
                var strConsulta = "st_CSMostrarUsrRoundTrip " + document.all.clAsistencia.value;
                var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=PasajerosC";
                fnOptionxDefault('PasajerosC', pstrCadena);
                fnChkNumPasajeros();
            }

            function fnVentanaAltaPasajero(clConcierge, clUsrApp)
            {
                window.open('CSAltaUsrAvionRoundTrip.jsp?clConcierge=<%=StrclConcierge%>&clUsrApp=<%=strclUsr%>', 'LlenaUsr', 'scrolling=yes, width= 500 ,height= 170');
            }

            function fnVentanaEliminaPasajero(clUsrRoundTrip)
            {
                window.open('CSEliminaUsrAvionRoundTrip.jsp?clUsrRoundTrip=' + clUsrRoundTrip, 'DelUsr', 'scrolling=yes, width= 50 ,height= 50');
            }


            function fnChkNumPasajeros()
            {
                window.open('CSNumUsrAvionRoundTrip.jsp?clAsistencia=' + document.all.clAsistencia.value, 'ChkUsr', 'scrolling=yes, width= 50 ,height= 50');
            }

            function fnListaNumPasajeros(NumAdultos, NumNinos)
            {
                document.all.NumAdultos.value = NumAdultos;
                document.all.NumNinos.value = NumNinos;
                if (document.all.NumNinos.value != "0") {
                    document.all.Edades.readOnly = false;
                }
            }

            //Función para quitarle los cero a la fecha
            function fnVerificaFecha() {
                document.all.FechaSalida.value = fnFechaID(document.all.FechaSalida.value);
                document.all.FechaArribo.value = fnFechaID(document.all.FechaArribo.value);
                document.all.TiempoLimite.value = fnFechaID(document.all.TiempoLimite.value);
            }

//función que regresa la fecha sin hora
            function fnFechaID(Fecha) {
                if (Fecha != "") {
                    FechaSinHora = Fecha;
                    FechaSinHora = FechaSinHora.substring(0, 10);
                    return FechaSinHora;
                }
                else {
                    FechaSinHora = '';
                    return FechaSinHora;
                }

            }

            function fnGoToRoundTrip() {


            }
//función antes de guardar
            function fnAntesGuardar() {
                if (document.all.clEstatus.value == 10) {
                    if (document.all.InfoVuelo.value == 0) {
                        msgVal = msgVal + " Info de Vuelo";
                    }
                    if (document.all.AptOrigen.value == 0) {
                        msgVal = msgVal + " Aereopuerto Origen";
                    }
                    if (document.all.AptDestino.value == 0) {
                        msgVal = msgVal + " Aereopuerto Destino";
                    }
                    if (document.all.FechaSalida.value == 0) {
                        msgVal = msgVal + " Fecha de Salida";
                    }
                    if (document.all.FechaArribo.value == 0) {
                        msgVal = msgVal + " Fecha de Arribo";
                    }
                    if (document.all.Clase.value == 0) {
                        msgVal = msgVal + " Clase/Código";
                    }
                    if (document.all.Cargo.value == 0) {
                        msgVal = msgVal + " Cargo Total";
                    }
                    if (document.all.LugarPagar.value == 0) {
                        msgVal = msgVal + " Lugar de Pago";
                    }
                    if (document.all.CveReservacion.value == 0) {
                        msgVal = msgVal + " Clave de Reservación";
                    }
                    if (document.all.MetEntrega.value == 0) {
                        msgVal = msgVal + " Método de Entrega";
                    }
                    document.all.btnGuarda.disabled = false;
                    document.all.btnCancela.disabled = false;
                }
            }

</script>
<script type="text/javascript">
    initFloatingWindowWithTabs('window4', Array('Nuestro Usuario', 'Referencias'), 350, 250, 700, 20, false, false, true, true, false);
</script> 
<%
    StrclConcierge = null;
    StrclSubservicio = null;
    StrclAsistencia = null;
    strclUsr = null;
    StrNumAdultos = null;
    StrNumNinos = null;
    StrEdades = null;
    StrclAvionRoundTrip = null;
    StrCargo = null;
    StrCdOrigen = null;
    StrCdDestino = null;
    StrAptOrigen = null;
    StrAptDestino = null;
    StrClase = null;
    StrclFormaPago = null;
    StrNomBanco = null;
    StrNombreTC = null;
    StrNumeroTC = null;
    StrExpira = null;
    StrExpiraVTR = null;
    StrSecC = null;
    StrConfirmo = null;
    StrNumConfirmacion = null;
    StrCancelacion = null;
    StrNUInfo = null;
    StrLugarPagar = null;
    StrCveReservacion = null;
    StrMetEntrega = null;
    daos = null;
    conciergeaviononeway = null;
    daosg = null;
    conciergeg = null;
    daosrt = null;
    conciergeavionroundtrip = null;
    daoRef = null;
    ref = null;
%>             
</body>
</html>

