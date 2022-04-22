<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOConciergeEspectaculo,com.ike.concierge.to.Conciergeespectaculo,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>

<html>
    <head>
        <title>Contratación de Esparcimiento/Espectáculos</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" OnLoad="if (document.all.ExpiraVTR.value!=''){fnFechVen(document.all.ExpiraVTR.value)}">

        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script type="text/javascript" src='../../Utilerias/Util.js' ></script>
        <script type="text/javascript" src='../../Utilerias/UtilDireccion.js' ></script>
        <script type="text/javascript" src='../../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilCalendario.js'></script>

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i>Contratación de Esparcimiento / Espectáculos</i></b></font><br></p></div>
        <div class='VTable' style='position:absolute; z-index:25; left:570px; top:93px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Automatica</i></b></font><br></p></div>
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

                        DAOConciergeEspectaculo daos = null;
                        Conciergeespectaculo conciergeespectaculo = null;

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
                        String StrclPaginaWeb = "727";
                        session.setAttribute("clPaginaWebP", StrclPaginaWeb);

                        if (strclUsr != null) {
                            daos = new DAOConciergeEspectaculo();
                            conciergeespectaculo = daos.getCSespectaculo(StrclAsistencia);
                        }
                        if (strclUsr != null) {
                            daosg = new DAOConciergeG();
                            conciergeg = daosg.getConciergeGenerico(StrclConcierge);

                            daoRef = new DAOReferenciasxAsist();
                            ref = daoRef.getclAsistencia(StrclAsistencia);
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
                                StrclAsistenciaVTR = StrclAsistencia;
                            }
                            session.setAttribute("clAsistenciaVTR", StrclAsistenciaVTR);
                        }

                        rsTieneAsistMadre.close();
                        rsTieneAsistMadre = null;
                %>

        <script>fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(727, Integer.parseInt(strclUsr));%>
        <%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaEspec", "fnAccionesAlta();", "fnAntesGuardar(),fnReqCampo();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>'>
        <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
        <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
        <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
        <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
        <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>

        <% String strEstatus = conciergeespectaculo != null ? conciergeespectaculo.getDsEstatus() : "";%>

        <%=MyUtil.ObjComboC("Estatus", "clEstatus", conciergeespectaculo != null ? conciergeespectaculo.getDsEstatus() : "", false, false, 30, 80, "0", "sp_GetCSstatus", "", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Asistencia", "AsistenciaVTR", StrclAsistenciaVTR, false, false, 350, 80, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento", "Observaciones", conciergeespectaculo != null ? conciergeespectaculo.getComentarios() : "", "83", "3", true, true, 30, 120, "", true, true)%>
        <%=MyUtil.ObjInput("fecha de alta", "FechaRegistro", conciergeespectaculo != null ? conciergeespectaculo.getFechaRegistro() : "", false, false, 650, 80, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Datos Generales del Evento", 10, 10)%>

        <%=MyUtil.ObjInput("Descripción", "Descripcion", conciergeespectaculo != null ? conciergeespectaculo.getDescripcion() : "", true, true, 30, 220, "", true, true, 70)%>
        <%=MyUtil.ObjInputF("Fecha del Evento<strong>(aaaa/mm/dd hh:mm)</strong>", "FechaEvento", conciergeespectaculo != null ? conciergeespectaculo.getFechaEvento() : "", true, true, 450, 220, "", true, true, 20, 2, "")%>
        <%=MyUtil.ObjInput("Direccion", "Direccion", conciergeespectaculo != null ? conciergeespectaculo.getDireccion() : "", true, true, 30, 260, "", true, true, 70)%>
        <%=MyUtil.ObjInput("Ciudad", "Ciudad", conciergeespectaculo != null ? conciergeespectaculo.getCiudad() : "", true, true, 30, 300, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Estado", "Estado", conciergeespectaculo != null ? conciergeespectaculo.getEstado() : "", true, true, 350, 300, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Pais", "Pais", conciergeespectaculo != null ? conciergeespectaculo.getPais() : "", true, true, 650, 300, "", true, true, 30)%>
        <%=MyUtil.ObjInput("Teléfono", "Telefono", conciergeespectaculo != null ? conciergeespectaculo.getTelefono() : "", true, true, 30, 340, "", true, true, 25)%>
        <%=MyUtil.ObjInput("Celular", "Celular", conciergeespectaculo != null ? conciergeespectaculo.getCelular() : "", true, true, 350, 340, "", true, true, 25)%>
        <%=MyUtil.DoBlock("Datos Generales del Evento", 100, 5)%>

        <%=MyUtil.ObjInput("Costo por Hora", "CostoH", conciergeespectaculo != null ? conciergeespectaculo.getCostoH() : "", true, true, 30, 430, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Horas Conf.:", "HorasC", conciergeespectaculo != null ? conciergeespectaculo.getHorasC() : "", true, true, 150, 430, "", false, false, 5)%>
        <%=MyUtil.ObjInput("Cargo Total:", "CargoT", conciergeespectaculo != null ? conciergeespectaculo.getCargoT() : "", true, true, 350, 430, "", false, false, 10)%>
        <%=MyUtil.ObjComboC("Forma de Pago:", "clTipoPago", conciergeespectaculo != null ? conciergeespectaculo.getDsTipoPago() : "", true, true, 30, 470, "", "select clTipoPago,dsTipoPago from CSTipoPago", "fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Nombre del Banco:", "NomBanco", conciergeespectaculo != null ? conciergeespectaculo.getNomBanco() : "", true, true, 30, 510, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Nombre en TC:", "NombreTC", conciergeespectaculo != null ? conciergeespectaculo.getNombreTC() : "", true, true, 350, 510, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Numero de TC:", "NumeroTC", conciergeespectaculo != null ? conciergeespectaculo.getNumeroTC() : "", false, false, 30, 550, "", false, false, 50, "if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        <%=MyUtil.ObjInput("Exp.D.:(MM/AA)", "ExpiraVTR", conciergeespectaculo != null ? conciergeespectaculo.getExpira() : "", false, false, 350, 550, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
        <input type="hidden" name="Expira" id="Expira" value= "<%=conciergeespectaculo != null ? conciergeespectaculo.getExpira().trim() : ""%>">
        <%=MyUtil.ObjInput("Sec.C.:", "SecC", conciergeespectaculo != null ? conciergeespectaculo.getSecC() : "", false, false, 440, 550, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Otra Forma de Pago", "PagoO", conciergeespectaculo != null ? conciergeespectaculo.getPagoO() : "", true, true, 30, 590, "", false, false, 50)%>
        <%=MyUtil.ObjInput("Confirmo", "Confirmo", conciergeespectaculo != null ? conciergeespectaculo.getConfirmo() : "", true, true, 30, 630, "", false, false, 30)%>
        <%=MyUtil.ObjInput("No.Conf.:", "NConfirmo", conciergeespectaculo != null ? conciergeespectaculo.getNConfirmo() : "", true, true, 350, 630, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Pol.Cancelación", "PCancel", conciergeespectaculo != null ? conciergeespectaculo.getPCancel() : "", true, true, 30, 670, "", false, false, 50)%>
        <%=MyUtil.ObjChkBox("N/U inf.:", "NuInf", conciergeespectaculo != null ? conciergeespectaculo.getNuInf() : "", true, true, 350, 670, "", "SI", "NO", "")%>
        <%=MyUtil.DoBlock("Costos del Evento", 100, 20)%>

        <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>

        <%@ include file="csVentanaFlotante.jspf" %>
        <%
                StrclAsistencia = null;
                daos = null;
                conciergeespectaculo = null;
                daosg = null;
                conciergeg = null;
                daoRef = null;
                ref = null;

        %>
        <%=MyUtil.GeneraScripts()%>
        <script type="text/javascript">
            top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
            top.document.all.rightPO.rows="0,80,*";
				  
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

            //función antes de guardar
            function fnAntesGuardar(){
                if (document.all.clEstatus.value==10 ) {
                    if (document.all.CostoH.value==0 ) { msgVal = msgVal + " Costo X Hora";}
                    if (document.all.HorasC.value==0 ) { msgVal = msgVal + " Horas Confirmadas";}
                    if (document.all.CargoT.value==0 ) { msgVal = msgVal + " Cargo Total";}
                    document.all.btnGuarda.disabled=false;
                    document.all.btnCancela.disabled=false;
                }
                if (document.all.FechaEvento.value==''){
                    miFecha = new Date();
                    document.all.FechaEvento.value=miFecha.getYear()+"-"+(miFecha.getMonth()+1)+"-"+miFecha.getDate();
                }
                fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
            }

            //Función para quitarle los cero a la fecha
            function fnVerificaFecha() {
                document.all.FechaEvento.value=fnFechaID(document.all.FechaEvento.value);
            }

            //función que regresa la fecha sin hora
            function fnFechaID(Fecha){
                if (Fecha!=""){
                    FechaSinHora=Fecha;
                    FechaSinHora=FechaSinHora.substring(0,10);
                    return FechaSinHora;
                } else {
                    FechaSinHora='';
                    return FechaSinHora;
                }
            }

        </script>
        <script type="text/javascript">
            initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
        </script>
    </body>
</html>
