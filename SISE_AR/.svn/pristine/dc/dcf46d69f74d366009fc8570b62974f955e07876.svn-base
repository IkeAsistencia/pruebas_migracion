<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOconciergepicko,com.ike.concierge.to.Conciergepicko,com.ike.concierge.DAOConciergepickr,com.ike.concierge.to.Conciergepickr,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<html>
    <head><title>Reservacion PickUp Roun Trip</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>        
    </head>
    <body class="cssBody" onload="fnVerificaFecha();">

        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script> 
        <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <script src='../../Utilerias/UtilCalendarioV.js'></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Reservación de Pick Up en Aeropuerto(Round Trip) </i></b>  <br> </p></div>
        <div class='VTable' style='position:absolute; z-index:25; left:570px; top:93px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Automatica </i></b>  <br> </p></div>

        <%
            String StrclConcierge = "";
            String strRoundTrip = "0";
            String StrclSubservicio = "";
            String StrclPickUpO = "0";
            String strclUsr = "";
            String strNAdultos = "";
            String strNinos = "";
            String strEdades = "";
            DAOconciergepicko daos = null;
            Conciergepicko conciergepicko = null;
            DAOConciergepickr daosr = null;
            Conciergepickr conciergepickr = null;
            DAOConciergeG daosg = null;
            ConciergeG conciergeg = null;

            DAOReferenciasxAsist daoRef = null;
            ReferenciasxAsist ref = null;

            String StrclAsistencia = "0";
            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clConcierge") != null) {
                StrclConcierge = session.getAttribute("clConcierge").toString();
            }

            if (request.getParameter("clPickUpO") != null) {
                StrclPickUpO = request.getParameter("clPickUpO").toString();
            }
            if (session.getAttribute("clAsistencia") != null) {
                StrclAsistencia = session.getAttribute("clAsistencia").toString();
            }
            if (StrclPickUpO.equalsIgnoreCase("0")) {
        %>
        "Debe de Ingresar una Reservación de Pick Up en Aeropuerto (One Way)"
        <%
                return;
            }


            String StrclPaginaWeb = "743";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            if (strclUsr != null) {
                daos = new DAOconciergepicko();
                conciergepicko = daos.getCSPuO(StrclAsistencia);

                daoRef = new DAOReferenciasxAsist();
                ref = daoRef.getclAsistencia(StrclAsistencia);
            }
            if (strclUsr != null) {
                daosr = new DAOConciergepickr();
                conciergepickr = daosr.getCSPuR(StrclPickUpO);
            }
            if (strclUsr != null) {
                daosg = new DAOConciergeG();
                conciergeg = daosg.getConciergeGenerico(StrclConcierge);
            }

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
            //-----------------------------------------------------

        %> 
        <script>fnOpenLinks()</script>
        <%
            MyUtil.InicializaParametrosC(743, Integer.parseInt(strclUsr));
        %><%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaPickUpR", "fnAccionesAlta();", "fnAdicional();")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="CSPickUpR.jsp?'>"%>
        <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='clPickUpO' name='clPickUpO' type='hidden' value='<%=StrclPickUpO%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
        <%String strEstatus = conciergepicko != null ? conciergepicko.getDsEstatus() : "";
            strNAdultos = conciergepicko != null ? conciergepicko.getNadultos() : "";
            strNinos = conciergepicko != null ? conciergepicko.getNinos() : "";
            strEdades = conciergepicko != null ? conciergepicko.getEdades() : "";

    //    if (conciergepickr!=null){

            strRoundTrip = conciergepickr != null ? conciergepickr.getRoundTrip() : "";
            if (strRoundTrip.equalsIgnoreCase("")) {%>
        <script> document.all.btnAlta.disabled = false;</script>
        <%} else {%>
        <script> document.all.btnAlta.disabled = true;</script>
        <%}%>
        <!--%=MyUtil.ObjComboMem("Estatus","clEstatus",strEstatus,conciergepicko!=null ? conciergepicko.getEstatus() : "",cbEstatus.GeneraHTML(50,strEstatus),false,false,30,80,"0","","",50,false,false)%-->
        <%=MyUtil.ObjComboC("Estatus", "clEstatus", strEstatus != null ? conciergepicko.getDsEstatus() : "", false, false, 30, 80, "0", "sp_GetCSstatus", "", "", 30, false, false)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento", "Comentarios", conciergepicko != null ? conciergepicko.getComentarios() : "", "83", "3", true, true, 30, 120, conciergepicko != null ? conciergepicko.getComentarios() : "", true, true)%>
        <%=MyUtil.ObjInput("fecha de alta", "FechaRegistro", conciergepicko != null ? conciergepicko.getFechaRegistro() : "", false, false, 650, 80, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Datos Generales del Usuario", 10, 10)%>

        <%=MyUtil.ObjInput("No.adultos", "Nadultos", conciergepickr != null ? conciergepickr.getNadultos() : "", false, false, 30, 220, conciergepicko != null ? conciergepicko.getNadultos() : "", true, true, 5)%>
        <%=MyUtil.ObjChkBox("Niños", "Ninos", conciergepickr != null ? conciergepickr.getNinos() : "", true, true, 130, 220, conciergepicko != null ? conciergepicko.getNinos() : "", "SI", "NO", "EdadesNinos();")%>
        <%=MyUtil.ObjInput("Edades", "Edades", conciergepickr != null ? conciergepickr.getEdades() : "", false, false, 220, 220, conciergepicko != null ? conciergepicko.getEdades() : "", false, false, 10)%>
        <%=MyUtil.ObjInput("Vehículo Sol", "Vehiculo", conciergepickr != null ? conciergepickr.getVehiculo() : "", true, true, 30, 260, conciergepicko != null ? conciergepicko.getVehiculo() : "", true, true, 25)%>
        <%=MyUtil.ObjInput("Equipaje", "Equipaje", conciergepickr != null ? conciergepickr.getEquipaje() : "", true, true, 250, 260, conciergepicko != null ? conciergepicko.getEquipaje() : "", true, true, 25)%>
        <%=MyUtil.ObjInput("Info Vuelo", "Vuelo", conciergepickr != null ? conciergepickr.getVuelo() : "", true, true, 30, 300, "", true, true, 25)%>
        <%=MyUtil.ObjInputF("Fecha<Strong>(AAAA-MM-DD)</Strong>", "Fecha", conciergepickr != null ? conciergepickr.getFecha() : "", true, true, 250, 300, "", true, true, 20, 2, "")%>
        <%=MyUtil.ObjInput("Horario de Salida", "HoraS", conciergepickr != null ? conciergepickr.getHoraS() : "", true, true, 30, 340, "", true, true, 5, "if(this.readOnly==false){fnValMask(this,document.all.FechaProgMskS.value,this.name)}")%>
        <%=MyUtil.ObjInput("Destino", "Destino", conciergepickr != null ? conciergepickr.getDestino() : "", true, true, 250, 340, "", true, true, 25)%>
        <%=MyUtil.ObjInput("Ciudad de Sal", "CiudadS", conciergepickr != null ? conciergepickr.getCiudadS() : "", true, true, 30, 380, "", true, true, 25)%>
        <%=MyUtil.ObjInput("Aeropuerto", "Aeropuerto", conciergepickr != null ? conciergepickr.getAeropuerto() : "", true, true, 250, 380, conciergepicko != null ? conciergepicko.getAeropuerto() : "", true, true, 20)%>
        <%=MyUtil.ObjInput("P. Encuentro", "Encuentro", conciergepickr != null ? conciergepickr.getEncuentro() : "", true, true, 30, 420, "", true, true, 20)%>
        <%=MyUtil.ObjInput("Horario", "Horario", conciergepickr != null ? conciergepickr.getHorario() : "", true, true, 250, 420, "", true, true, 5, "if(this.readOnly==false){fnValMask(this,document.all.FechaProgMskS.value,this.name)}")%>  
        <%=MyUtil.ObjInput("Adicionales", "Adicionales", conciergepickr != null ? conciergepickr.getAdicionales() : "", true, true, 30, 460, conciergepicko != null ? conciergepicko.getAdicionales() : "", false, false, 25)%>
        <%=MyUtil.ObjInput("Cargo Total", "CargoT", conciergepickr != null ? conciergepickr.getCargoT() : "", true, true, 250, 460, conciergepicko != null ? conciergepicko.getCargoT() : "", false, false, 10)%>
        <%=MyUtil.ObjInput("Destino", "Destino2", conciergepickr != null ? conciergepickr.getDestino2() : "", true, true, 30, 500, "", false, false, 75)%>
        <%=MyUtil.ObjInput("Confirmo", "Confirmo", conciergepickr != null ? conciergepickr.getConfirmo() : "", true, true, 30, 540, conciergepicko != null ? conciergepicko.getConfirmo() : "", false, false, 30)%>
        <%=MyUtil.ObjInput("No.Conf.:", "NConfirmo", conciergepickr != null ? conciergepickr.getNConfirmo() : "", true, true, 350, 540, conciergepicko != null ? conciergepicko.getNConfirmo() : "", false, false, 30, "")%> <!--%--EsNumerico(this) %-->
        <%=MyUtil.ObjInput("Pol.Cancelación", "PCancel", conciergepickr != null ? conciergepickr.getPCancel() : "", true, true, 30, 580, "", false, false, 50)%>
        <%=MyUtil.ObjChkBox("N/U inf.:", "NuInf", conciergepickr != null ? conciergepickr.getNuInf() : "", true, true, 350, 580, "", "SI", "NO", "")%>
        <%=MyUtil.DoBlock("Reservación de Pick Up en Aeropuerto(Round Trip)", 100, 0)%>

        <%
//        }
%>

        <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='FechaProgMskS' id='FechaProgMskS' type='hidden' value='VN09VN09F:/:VN09VN09'>
        <input name='FechaProgMskI' id='FechaProgMskI' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>
        <input name='FechaIniMsk' id='FechaIniMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <%@ include file="csVentanaFlotante.jspf" %>
        <%
            StrclConcierge = null;
            StrclAsistencia = null;
            StrclPickUpO = null;
            daos = null;
            conciergepicko = null;
            daosr = null;
            conciergepickr = null;
            daosg = null;
            conciergeg = null;
            daoRef = null;
            ref = null;
        %>
        <%=MyUtil.GeneraScripts()%>        
        <script>
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
                if (document.all.Ninos.value == 1) {
                    if (document.all.Edades.value == "") {
                        msgVal = msgVal + " Debe Ingresar Edades. ";
                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    }
                }
                else {
                    document.all.Edades.value = "";
                }
            }


            //Funcion que hace requeribles las edades de los niños dependiendo de la accion
            function EdadesNinos()
            {
                if ((document.all.Ninos.value == 1) && (document.all.Action.value == 1))
                {
                    document.all.Edades.className = "Freq";
                    document.all.Edades.value = "";
                    document.all.Edades.readOnly = false;
                }
                else
                {
                    document.all.Edades.className = "VTable";
                    document.all.Edades.readOnly = false;
                }
                if (document.all.Ninos.value == 0)
                    document.all.Edades.value = "";
            }
    //Función para quitarle los cero a la fecha
            function fnVerificaFecha() {
                document.all.Fecha.value = fnFechaID(document.all.Fecha.value);

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
        </script>
        <script type="text/javascript">
            initFloatingWindowWithTabs('window4', Array('Nuestro Usuario', 'Referencias'), 350, 250, 700, 20, false, false, true, true, false);
        </script>        
    </body>
</html>