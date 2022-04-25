<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOConciergeLocaltaquilla,com.ike.concierge.to.Conciergelocaltaquilla,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
    <head>
        <title>Localidades por Taquilla</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>
    </head>
    <body class="cssBody" onload="fnVerificaFecha();fnLimpiaFechas();">

        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script type="text/javascript" src='../../Utilerias/Util.js' ></script>
        <script type="text/javascript" src='../../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilCalendario.js'></script>
    <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">

    <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center">
            <font color="navy" face="Arial" size="3" ><b><i> Localidades por Taquilla </i></b></font><br> </p>
    </div>
    <div class='VTable' style='position:absolute; z-index:25; left:570px; top:93px;'><p align="center">
            <font color="navy" face="Arial" size="2" ><b><i>Automatica </i></b></font>
            <br></p>
    </div>
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

                DAOConciergeLocaltaquilla daos = null;
                Conciergelocaltaquilla conciergelocaltaquilla = null;

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
                String StrclPaginaWeb = "732";
                session.setAttribute("clPaginaWebP", StrclPaginaWeb);

                if (strclUsr != null) {
                    daos = new DAOConciergeLocaltaquilla();
                    conciergelocaltaquilla = daos.getCSLocalidadesTaquilla(StrclAsistencia);

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
    <script type="text/javascript">fnOpenLinks()</script>
    <%MyUtil.InicializaParametrosC(732, Integer.parseInt(strclUsr));%>
    <%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaLocalidadesT", "fnAccionesAlta();", "fnAntesGuardar();fnAdicional();fnValidaFecha();fnReqCampo();")%>

    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>'>
    <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
    <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
    <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
    <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
    <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
    <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
    <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>

    <%String strEstatus = conciergelocaltaquilla != null ? conciergelocaltaquilla.getDsEstatus() : "";%>
    <%=MyUtil.ObjComboC("Estatus", "clEstatus", conciergelocaltaquilla != null ? conciergelocaltaquilla.getDsEstatus() : "", false, false, 30, 80, "0", "sp_GetCSstatus", "", "", 30, false, false)%>
    <%=MyUtil.ObjInput("Asistencia", "AsistenciaVTR", StrclAsistenciaVTR, false, false, 350, 80, "", false, false, 10)%>
    <%=MyUtil.ObjTextArea("Descripcion del Evento", "Comentarios", conciergelocaltaquilla != null ? conciergelocaltaquilla.getComentarios().trim() : "", "83", "3", true, true, 30, 120, "", true, true)%>
    <%=MyUtil.ObjInput("fecha de alta", "FechaRegistro", conciergelocaltaquilla != null ? conciergelocaltaquilla.getFechaRegistro() : "", false, false, 650, 80, "", false, false, 20)%>
    <%=MyUtil.DoBlock("Datos Generales del Usuario", 10, 10)%>

    <%=MyUtil.ObjInput("No.adultos", "Nadultos", conciergelocaltaquilla != null ? conciergelocaltaquilla.getNadultos().trim() : "", true, true, 30, 220, "", true, true, 5)%>
    <%=MyUtil.ObjChkBox("Niños", "Ninos", conciergelocaltaquilla != null ? conciergelocaltaquilla.getNinos().trim() : "", true, true, 130, 220, "", "SI", "NO", "EdadesNinos();")%>
    <%=MyUtil.ObjInput("Edades", "Edades", conciergelocaltaquilla != null ? conciergelocaltaquilla.getEdades().trim() : "", true, true, 220, 220, "", false, false, 10)%>
    <%=MyUtil.ObjInput("Evento / Show", "Evento", conciergelocaltaquilla != null ? conciergelocaltaquilla.getEvento().trim() : "", true, true, 30, 255, "", true, true, 75)%>
    <%=MyUtil.ObjInputF("Fecha del Evento <Strong>(AAAA-MM-DD hh:mm)</Strong>", "FechaE", conciergelocaltaquilla != null ? conciergelocaltaquilla.getFechaE().trim() : "", true, true, 450, 255, "", false, false, 20, 2, "fnVerificaFecha();")%>
    <%=MyUtil.ObjInput("Teatro / Sede", "Teatro", conciergelocaltaquilla != null ? conciergelocaltaquilla.getTeatro().trim() : "", true, true, 30, 285, "", false, false, 75)%>
    <%=MyUtil.ObjInput("Direccion", "Direccion", conciergelocaltaquilla != null ? conciergelocaltaquilla.getDireccion().trim() : "", true, true, 30, 315, "", false, false, 75)%>
    <%=MyUtil.ObjInput("Sección / Zona", "Seccion", conciergelocaltaquilla != null ? conciergelocaltaquilla.getSeccion().trim() : "", true, true, 30, 350, "", false, false, 20)%>
    <%=MyUtil.ObjInput("Fila / Asiento", "Fila", conciergelocaltaquilla != null ? conciergelocaltaquilla.getFila().trim() : "", true, true, 300, 350, "", false, false, 20)%>
    <%=MyUtil.ObjInput("Hotel & Tel.:", "Hotel", conciergelocaltaquilla != null ? conciergelocaltaquilla.getHotel().trim() : "", true, true, 30, 390, "", false, false, 75)%>
    <%=MyUtil.ObjInputF("Check-In <Strong>(AAAA-MM-DD hh:mm)</Strong>", "FechaI", conciergelocaltaquilla != null ? conciergelocaltaquilla.getFechaI().trim() : "", true, true, 450, 390, "", false, false, 20, 2, "fnVerificaFecha();")%>
    <%=MyUtil.ObjInput("Rva. a nombre", "Reservacion", conciergelocaltaquilla != null ? conciergelocaltaquilla.getReservacion().trim() : "", true, true, 30, 430, "", false, false, 75)%>
    <%=MyUtil.ObjInputF("Check-Out <Strong>(AAAA-MM-DD hh:mm)</Strong>", "FechaO", conciergelocaltaquilla != null ? conciergelocaltaquilla.getFechaO().trim() : "", true, true, 450, 430, "", false, false, 20, 2, "fnVerificaFecha();")%>
    <%=MyUtil.DoBlock("Datos Generales del Evento", 100, 5)%>

    <%=MyUtil.ObjComboC("Forma de Pago:", "clTipoPago", conciergelocaltaquilla != null ? conciergelocaltaquilla.getDsTipoPago() : "", true, true, 30, 545, "", "select clTipoPago,dsTipoPago from CSTipoPago", "fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();", "", 30, false, false)%>
    <%=MyUtil.ObjInput("Nombre del Banco:", "NomBanco", conciergelocaltaquilla != null ? conciergelocaltaquilla.getNomBanco() : "", true, true, 30, 585, "", false, false, 40)%>
    <%=MyUtil.ObjInput("Nombre en TC:", "NombreTC", conciergelocaltaquilla != null ? conciergelocaltaquilla.getNombreTC().trim() : "", true, false, 350, 545, "", false, false, 30)%>
    <%=MyUtil.ObjInput("Cargo Total", "CargoT", conciergelocaltaquilla != null ? conciergelocaltaquilla.getCargoT() : "", true, true, 600, 545, "", false, false, 10)%>
    <%=MyUtil.ObjInput("Numero de TC:", "NumeroTC", conciergelocaltaquilla != null ? conciergelocaltaquilla.getNumeroTC().trim() : "", true, false, 350, 585, "", false, false, 40, "if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
    <%=MyUtil.ObjInput("Exp.D.:(MM/AA)", "ExpiraVTR", conciergelocaltaquilla != null ? conciergelocaltaquilla.getExpira().trim() : "", true, false, 600, 585, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
    <input type="hidden" name="Expira" id="Expira" value="<%=conciergelocaltaquilla != null ? conciergelocaltaquilla.getExpira2().trim() : ""%>">
    <%=MyUtil.ObjInput("Sec.C.:", "SecC", conciergelocaltaquilla != null ? conciergelocaltaquilla.getSecC().trim() : "", true, false, 700, 585, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
    <%=MyUtil.ObjInput("Confirmo", "Confirmo", conciergelocaltaquilla != null ? conciergelocaltaquilla.getConfirmo().trim() : "", true, true, 30, 625, "", false, false, 30)%>
    <%=MyUtil.ObjInput("No.Conf.:", "NConfirmo", conciergelocaltaquilla != null ? conciergelocaltaquilla.getNConfirmo().trim() : "", true, true, 350, 625, "", false, false, 30, "")%>
    <%=MyUtil.ObjInput("Metodo Entrega", "Metodo", conciergelocaltaquilla != null ? conciergelocaltaquilla.getMetodo().trim() : "", true, true, 30, 680, "", false, false, 50)%>
    <%=MyUtil.ObjInput("3ra. Persona Autorizada", "Autoriza", conciergelocaltaquilla != null ? conciergelocaltaquilla.getAutoriza().trim() : "", true, true, 350, 680, "", false, false, 50)%>
    <%=MyUtil.ObjInput("Pol.Cancelación", "PCancel", conciergelocaltaquilla != null ? conciergelocaltaquilla.getPCancel().trim() : "", true, true, 30, 720, "", false, false, 50)%>
    <%=MyUtil.ObjChkBox("N/U inf.:", "NuInf", conciergelocaltaquilla != null ? conciergelocaltaquilla.getNuInf() : "", true, true, 350, 720, "0", "SI", "NO", "")%>
    <%=MyUtil.DoBlock("Forma de Pago", 100, 0)%>

    <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
    <input name='FechaProgMskI' id='FechaProgMskI' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
    <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
    <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
    <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>
    <input name='FechaIniMsk' id='FechaIniMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
    <%@ include file="csVentanaFlotante.jspf" %>


    <%=MyUtil.GeneraScripts()%>
    <script type="text/javascript" >
        top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
        top.document.all.rightPO.rows="0,80,*";
        document.all.SecC.maxLength=4;

        function fnValidaFecha(){
            if (document.all.FechaI.value!='' && document.all.FechaO.value!= ''){
                if (document.all.FechaO.value <= document.all.FechaI.value){
                    msgVal = msgVal + " Check-Out debe de ser mayor a Check-In. "
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

        function fnAdicional(){
            if (document.all.Ninos.value==1){
                if(document.all.Edades.value==""){
                    msgVal = msgVal + " Debe Ingresar Edades. ";
                    document.all.btnGuarda.disabled=false;
                    document.all.btnCancela.disabled=false;
                }
            }else{
                document.all.Edades.value="";
            }
        }

        //función antes de guardar
        function fnAntesGuardar(){
            if (document.all.clEstatus.value==10 ) {
                if (document.all.FechaE.value==0 ) { msgVal = msgVal + " Fecha del evento";}
                if (document.all.Teatro.value==0 ) { msgVal = msgVal + " Teatro sede";}
                if (document.all.Direccion.value==0 ) { msgVal = msgVal + " Dirección";}
                if (document.all.Seccion.value==0 ) { msgVal = msgVal + " Sección";}
                if (document.all.Fila.value==0 ) { msgVal = msgVal + " Fila";}
                if (document.all.NConfirmo.value==0 ) { msgVal = msgVal + " No. de Confirmación";}
                if (document.all.Metodo.value==0 ) { msgVal = msgVal + " Método de entrega";}
                document.all.btnGuarda.disabled=false;
                document.all.btnCancela.disabled=false;
            }
            
            fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
        }

        //Función para quitarle los cero a la fecha
        function fnVerificaFecha() {
            document.all.FechaI.value=fnFechaID(document.all.FechaI.value);
            document.all.FechaO.value=fnFechaID(document.all.FechaO.value);
            document.all.FechaE.value=fnFechaID(document.all.FechaE.value);
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

        //Funcion que hace requeribles las edades de los niños dependiendo de la accion
        function EdadesNinos(){
            if ((document.all.Ninos.value==1) && (document.all.Action.value==1)){
                document.all.Edades.className="Freq";
                document.all.Edades.value="";
                document.all.Edades.readOnly=false;
            }else{
                document.all.Edades.className="VTable";
                document.all.Edades.readOnly=false;
            }
            if(document.all.Ninos.value==0) document.all.Edades.value="";
        }

        //Función para limpiar las fechas
        function fnLimpiaFechas(){
            if (document.all.FechaI.value=="1900-01-01"){
                document.all.FechaI.value="";
            }else {
                document.all.FechaI.value=fnFechaID(document.all.FechaI.value);
            }
            if (document.all.FechaO.value=="1900-01-01"){
                document.all.FechaO.value="";
            }else {
                document.all.FechaO.value=fnFechaID(document.all.FechaO.value);
            }
            if (document.all.FechaE.value=="1900-01-01"){
                document.all.FechaE.value="";
            }else {
                document.all.FechaE.value=fnFechaID(document.all.FechaE.value);
            }
        }
    </script>
    <script type="text/javascript">
        initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
    </script>
    <%
                StrclConcierge = null;
                StrclSubservicio = null;
                StrclAsistencia = null;
                daos = null;
                conciergelocaltaquilla = null;
                daosg = null;
                conciergeg = null;
                daoRef = null;
                ref = null;
    %>
</body>
</html>