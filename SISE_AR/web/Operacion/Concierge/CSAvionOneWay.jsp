
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOAvionOneWay,com.ike.concierge.to.ConciergeAvionOneWay,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>

<html>
    <head>
        <title>Compra de Boletos de Avión One Way</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script type="text/javascript" src='../../Utilerias/Util.js' ></script>
        <script type="text/javascript" src='../../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilCalendarioV.js'></script>

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i>Compra de Boletos de Avión</i></b></font><br> </p></div>
        <div class='VTable' style='position:absolute; z-index:25; left:570px; top:93px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Automática</i></b></font><br> </p></div>

        <%
                String StrclConcierge = "";
                String StrclSubservicio = "";
                String StrclAsistencia = "0";
                String strclUsr = "";
                String StrURL = "";
                String StrNomPag = "";

                if (request.getRequestURL() != null) {
                    StrURL = request.getRequestURL().toString();
                    StrNomPag = StrURL.substring(StrURL.lastIndexOf("/") + 1);
                }

                DAOAvionOneWay daos = null;
                ConciergeAvionOneWay CAO = null;

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

                session.setAttribute("clAsistencia", StrclAsistencia);
                session.setAttribute("clSubservicio", StrclSubservicio);

                String StrclPaginaWeb = "748";
                session.setAttribute("clPaginaWebP", StrclPaginaWeb);

                if (strclUsr != null) {
                    daos = new DAOAvionOneWay();
                    CAO = daos.getCSAvionOneWay(StrclAsistencia);
                }
                if (strclUsr != null) {
                    daoRef = new DAOReferenciasxAsist();
                    ref = daoRef.getclAsistencia(StrclAsistencia);
                }
                if (strclUsr != null) {
                    daosg = new DAOConciergeG();
                    conciergeg = daosg.getConciergeGenerico(StrclConcierge);
                }

                ResultSet rs = null;
                String StrPreguntaEncuesta = "0";

                rs = UtileriasBDF.rsSQLNP("sp_CSPreguntaEncuesta " + StrclConcierge);
                if (rs.next()) {
                    StrPreguntaEncuesta = rs.getString("Pregunta").toString();
                }
                rs.close();
                rs = null;

                String StrclAsistenciaVTR = "";
                ResultSet rsTieneAsistMadre = null;
                rsTieneAsistMadre = UtileriasBDF.rsSQLNP(" st_CSTieneAsistMadre " + StrclAsistencia);

                if (rsTieneAsistMadre.next()) {
                    if (rsTieneAsistMadre.getString("TieneAsistMadre").equalsIgnoreCase("1")) {
                        StrclAsistenciaVTR = rsTieneAsistMadre.getString("Folio");
                    } else {
                        StrclAsistenciaVTR = StrclAsistencia;
                    }
                    session.setAttribute("clAsistenciaVTR", StrclAsistenciaVTR);
                }

                rsTieneAsistMadre.close();
                rsTieneAsistMadre = null;
        %>

        <script type="text/javascript" >fnOpenLinks()</script>
        <% MyUtil.InicializaParametrosC(748, Integer.parseInt(strclUsr));%>
        <%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaAvionOneWay", "fnAccionesAlta();", "fnAntesGuardar();fnValidaFecha();fnReqCampo();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>'>
        <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
        <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
        <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
        <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
        <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>

        <%String strEstatus = CAO != null ? CAO.getdsEstatus() : "";%>

        <%=MyUtil.ObjComboC("Estatus", "clEstatus", CAO != null ? CAO.getdsEstatus() : "", false, false, 30, 80, "0", "sp_GetCSstatus", "", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Asistencia", "AsistenciaVTR", StrclAsistenciaVTR, false, false, 350, 80, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento", "Comentarios", CAO != null ? CAO.getComentarios() : "", "83", "3", true, true, 30, 120, "", true, true)%>
        <%=MyUtil.ObjInput("fecha de alta", "FechaRegistro", CAO != null ? CAO.getFechaRegistro() : "", false, false, 650, 80, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Datos Generales del Usuario", 10, 10)%>

        <%=MyUtil.ObjInput("No de Vuelo", "NoVuelo", CAO != null ? CAO.getNoVuelo() : "", true, true, 30, 215, "", false, false, 25)%>
        <%=MyUtil.ObjInput("Operado por:", "Operadox", CAO != null ? CAO.getOperadox() : "", true, true, 230, 215, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Clase", "Clase", CAO != null ? CAO.getClase() : "", true, true, 460, 215, "", false, false, 30)%>

        <div class='VTable'  id="btnAsist" style="position:absolute; z-index:25; left:700px; top:227px;">
            <input class='cBtn' type='button' value='Agregar Pasajero' onClick="fnGetPasajero();">
        </div>

        <div id='Destino' Name='Destino' class='VTable' style='position:absolute; z-index:11; left:50px; top:255px; width:700px;' align="center"><p class='Obs'>Destinos</p> </div>
        <div id='Des' Name='Des' class='VTable' style='position:absolute; z-index:11; left:23px; top:320px; width:110px; ' align="center"><p class='TTablePlasma' ><font size="5"> Vuelo 1</font></p> </div>

        <hr style='position:absolute; z-index:90; left:30px; top:405px; width:750px; height:1px;' class="FReq">

        <%=MyUtil.ObjInput("Ciudad Origen", "CdOrigen", CAO != null ? CAO.getCdOrigen() : "", true, true, 140, 275, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Aereopuerto Origen", "AptOrigen", CAO != null ? CAO.getAptOrigen() : "", true, true, 345, 275, "", false, false, 35)%>
        <%=MyUtil.ObjInputF("Fecha de Salida <Strong>(AAAA-MM-DD hh:mm)</Strong>", "FechaSalida", CAO != null ? CAO.getFechaSalida() : "", true, true, 550, 275, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Ciudad Destino", "CdDestino", CAO != null ? CAO.getCdDestino() : "", true, true, 140, 315, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Aereopuerto Destino", "AptDestino", CAO != null ? CAO.getAptDestino() : "", true, true, 345, 315, "", false, false, 35)%>
        <%=MyUtil.ObjInputF("Fecha de Arribo <Strong>(AAAA-MM-DD hh:mm)</Strong>", "FechaArribo", CAO != null ? CAO.getFechaArribo() : "", true, true, 550, 315, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Conexiones", "Conexiones", CAO != null ? CAO.getConexiones() : "", true, true, 140, 355, "", false, false, 55, "")%>
        <%=MyUtil.ObjInputF("Tiempo Límite <Strong>(AAAA-MM-DD hh:mm)</Strong>", "TiempoLimite", CAO != null ? CAO.getTiempoLimite() : "", true, true, 460, 355, "", false, false, 20, 2, "")%>

        <div id='Des1' Name='Des1' class='VTable' style='position:absolute; z-index:11; left:23px; top:470px; width:110px; ' align="center"><p class='TTablePlasma' ><font size="5"> Vuelo 2</font></p> </div>
        <hr style='position:absolute; z-index:90; left:30px; top:555px; width:750px; height:1px;' class="FReq">

        <%=MyUtil.ObjInput("Ciudad Origen", "CdOrigen1", CAO != null ? CAO.getCdOrigen1() : "", true, true, 140, 425, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Aereopuerto Origen", "AptOrigen1", CAO != null ? CAO.getAptOrigen1() : "", true, true, 345, 425, "", false, false, 35)%>
        <%=MyUtil.ObjInputF("Fecha de Salida <Strong>(AAAA-MM-DD hh:mm)</Strong>", "FechaSalida1", CAO != null ? CAO.getFechaSalida1() : "", true, true, 550, 425, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Ciudad Destino", "CdDestino1", CAO != null ? CAO.getCdDestino1() : "", true, true, 140, 465, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Aereopuerto Destino", "AptDestino1", CAO != null ? CAO.getAptDestino1() : "", true, true, 345, 465, "", false, false, 35)%>
        <%=MyUtil.ObjInputF("Fecha de Arribo <Strong>(AAAA-MM-DD hh:mm)</Strong>", "FechaArribo1", CAO != null ? CAO.getFechaArribo1() : "", true, true, 550, 465, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Conexiones", "Conexiones1", CAO != null ? CAO.getConexiones1() : "", true, true, 140, 505, "", false, false, 55, "")%>
        <%=MyUtil.ObjInputF("Tiempo Límite <Strong>(AAAA-MM-DD hh:mm)</Strong>", "TiempoLimite1", CAO != null ? CAO.getTiempoLimite1() : "", true, true, 460, 505, "", false, false, 20, 2, "")%>

        <div id='Des2' Name='Des2' class='VTable' style='position:absolute; z-index:11; left:23px; top:620px; width:110px; ' align="center"><p class='TTablePlasma' ><font size="5"> Vuelo 3</font></p> </div>

        <%=MyUtil.ObjInput("Ciudad Origen", "CdOrigen2", CAO != null ? CAO.getCdOrigen2() : "", true, true, 140, 575, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Aereopuerto Origen", "AptOrigen2", CAO != null ? CAO.getAptOrigen2() : "", true, true, 345, 575, "", false, false, 35)%>
        <%=MyUtil.ObjInputF("Fecha de Salida <Strong>(AAAA-MM-DD hh:mm)</Strong>", "FechaSalida2", CAO != null ? CAO.getFechaSalida2() : "", true, true, 550, 575, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Ciudad Destino", "CdDestino2", CAO != null ? CAO.getCdDestino2() : "", true, true, 140, 615, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Aereopuerto Destino", "AptDestino2", CAO != null ? CAO.getAptDestino2() : "", true, true, 345, 615, "", false, false, 35)%>
        <%=MyUtil.ObjInputF("Fecha de Arribo <Strong>(AAAA-MM-DD hh:mm)</Strong>", "FechaArribo2", CAO != null ? CAO.getFechaArribo2() : "", true, true, 550, 615, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Conexiones", "Conexiones2", CAO != null ? CAO.getConexiones2() : "", true, true, 140, 655, "", false, false, 55, "")%>
        <%=MyUtil.ObjInputF("Tiempo Límite <Strong>(AAAA-MM-DD hh:mm)</Strong>", "TiempoLimite2", CAO != null ? CAO.getTiempoLimite2() : "", true, true, 460, 655, "", false, false, 20, 2, "")%>

        <div id='Des3' Name='Des3' class='VTable' style='position:absolute; z-index:11; left:50px; top:700px; width:700px; ' align="center"><p class='Obs'>Viaje Redondo</p> </div>

        <%=MyUtil.ObjInput("Ciudad Origen", "CdOrigen3", CAO != null ? CAO.getCdOrigen3() : "", true, true, 140, 725, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Aereopuerto Origen", "AptOrigen3", CAO != null ? CAO.getAptOrigen3() : "", true, true, 345, 725, "", false, false, 35)%>
        <%=MyUtil.ObjInputF("Fecha de Salida <Strong>(AAAA-MM-DD hh:mm)</Strong>", "FechaSalida3", CAO != null ? CAO.getFechaSalida3() : "", true, true, 550, 725, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Ciudad Destino", "CdDestino3", CAO != null ? CAO.getCdDestino3() : "", true, true, 140, 765, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Aereopuerto Destino", "AptDestino3", CAO != null ? CAO.getAptDestino3() : "", true, true, 345, 765, "", false, false, 35)%>
        <%=MyUtil.ObjInputF("Fecha de Arribo <Strong>(AAAA-MM-DD hh:mm)</Strong>", "FechaArribo3", CAO != null ? CAO.getFechaArribo3() : "", true, true, 550, 765, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Conexiones", "Conexiones3", CAO != null ? CAO.getConexiones3() : "", true, true, 140, 805, "", false, false, 55, "")%>
        <%=MyUtil.ObjInputF("Tiempo Límite <Strong>(AAAA-MM-DD hh:mm)</Strong>", "TiempoLimite3", CAO != null ? CAO.getTiempoLimite3() : "", true, true, 460, 805, "", false, false, 20, 2, "")%>
        <%=MyUtil.DoBlock("Descripcion del Viaje", 100, -7)%>

        <%=MyUtil.ObjComboC("Forma de Pago:", "clTipoPago", CAO != null ? CAO.getdsTipoPago() : "", true, true, 30, 880, "", "select clTipoPago,dsTipoPago from CSTipoPago", "fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();", "", 30, false, false)%>
        <INPUT id='dsTipoPago' name='dsTipoPago' type='hidden' value='< %=CAO != null ? CAO.getdsTipoPago() : ""%>'>
        <%=MyUtil.ObjInput("Nombre del Banco:", "NomBanco", CAO != null ? CAO.getNomBanco() : "", false, false, 200, 880, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Nombre en TC:", "NombreTC", CAO != null ? CAO.getNombreTC() : "", false, false, 450, 880, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Numero de TC:", "NumeroTC", CAO != null ? CAO.getNumeroTC() : "", false, false, 30, 920, "", false, false, 50, "if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        <%=MyUtil.ObjInput("Exp.D.:(MM-AA)", "ExpiraVTR", CAO != null ? CAO.getExpira() : "", false, false, 350, 920, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
        <input type="hidden" name="Expira" id="Expira" value="">
        <%=MyUtil.ObjInput("Sec.C.:", "SecC", CAO != null ? CAO.getSecC() : "", false, false, 540, 920, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Confirmo", "Confirmo", CAO != null ? CAO.getConfirmo() : "", true, true, 30, 960, "", false, false, 50)%>
        <%=MyUtil.ObjInput("No.Conf.:", "NumConfirmacion", CAO != null ? CAO.getNumConfirmacion() : "", true, true, 350, 960, "", false, false, 30, "")%>
        <%=MyUtil.ObjInput("Pol.Cancelación", "Cancelacion", CAO != null ? CAO.getCancelacion() : "", true, true, 30, 1000, "", false, false, 50)%>
        <%=MyUtil.ObjChkBox("N/U inf.:", "NUInfo", CAO != null ? CAO.getNUInfo() : "", true, true, 350, 1000, "0", "SI", "NO", "")%>
        <%=MyUtil.DoBlock("Forma de Pago", 30, 0)%>

        <input name='FechaSalidaMsk' id='FechaSalidaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='FechaArriboMsk' id='FechaArriboMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>
        <input name='TiempoLimiteMsk' id='TiempoLimiteMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>

        <%@ include file="csVentanaFlotante.jspf" %>

        <%=MyUtil.GeneraScripts()%>

        <script type="text/javascript" >
            top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
            top.document.all.rightPO.rows="0,80,*";

            document.all.SecC.maxLength=4;

            function fnValidaFecha(){
                if (document.all.FechaSalida.value!='' && document.all.FechaArribo.value!= ''){
                    if (document.all.FechaArribo.value <= document.all.FechaSalida.value){
                        msgVal = msgVal + " Fecha Arribo debe de ser mayor a Fecha Salida. "
                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    }
                }
            }

            function fnAccionesAlta(){
                if (document.all.Action.value==1){
                    var pstrCadena = "../../Utilerias/RegresaFechaActual.jsp";
                    window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');
                }
            }
        
            function fnActualizaFechaActual(pFecha){
                document.all.FechaApAsist.value = pFecha;
            }

            function fnReqCampo(){
                if (document.all.clTipoPago.value==1 || document.all.clTipoPago.value==2 || document.all.clTipoPago.value==3){
                    if ( document.all.NumeroTC.value=="" || document.all.Expira.value=="" || document.all.SecC.value==""){
                        msgVal = msgVal + " Debe de Ingresar Los campos requeridos de Tarjetas de Credito. ";
                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    }
                }
            }

            function fnAntesGuardar(){
                fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
            }

            //función que regresa la fecha sin hora
            function fnFechaID(Fecha){
                if (Fecha!=""){
                    FechaSinHora=Fecha;
                    FechaSinHora=FechaSinHora.substring(0,10);
                    return FechaSinHora;
                }
                else {
                    FechaSinHora='';
                    return FechaSinHora;
                }
            }

            function fnGetPasajero(){
                var pstrCadena = "ConciergeFramePasajeros.jsp?clAsistencia=" + document.all.clAsistencia.value+"&clPaginaWeb=1";
                window.open(pstrCadena,'newWinNA','scrollbars=yes,status=yes,width=800,height=500,top=200,left=250');
            }

        </script>
        <%
                StrclAsistencia = null;
                daos = null;
                CAO = null;
                daosg = null;
                conciergeg = null;
                daoRef = null;
                ref = null;
        %>
        <script type="text/javascript">
            initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
        </script>
    </body>
</html>