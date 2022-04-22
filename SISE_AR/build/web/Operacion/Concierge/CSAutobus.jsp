<%--
 Document   : CSAutobus
 Create on  : 2010-11-23
 Author     : rfernandez
--%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOCSAutobus,com.ike.concierge.to.CSAutobus" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,javax.servlet.http.HttpSession,java.sql.ResultSet"%>
<html>
    <head>
        <title>Autobús</title>
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>

    <body class="cssBody"  OnLoad="if (document.all.ExpiraVTR.value!=''){fnFechVen(document.all.ExpiraVTR.value)}fnLimpiaFechas();">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>

        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <script src='../../Utilerias/UtilCalendarioV.js'></script>
        <script src='../../Utilerias/UtilStore.js'></script>

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Autobús </i></b></font><br></p></div>
        <div class='VTable' style='position:absolute; z-index:25; left:570px; top:83px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Automática </i></b></font><br></p></div>

        <%
                String StrclConcierge = "";
                String StrclSubservicio = "";
                String StrclAsistencia = "0";
                String StrclUsr = "0";
                String StrclAutobus = "0";
                String StrURL = "";
                String StrNomPag = "";

                if (request.getRequestURL() != null) {
                    StrURL = request.getRequestURL().toString();
                    StrNomPag = StrURL.substring(StrURL.lastIndexOf("/") + 1);
                }

                DAOCSAutobus daoCSAutobus = null;
                CSAutobus A = null;

                DAOReferenciasxAsist daoRef = null;
                ReferenciasxAsist ref = null;

                DAOConciergeG daosg = null;
                ConciergeG conciergeg = null;

                if (session.getAttribute("clUsrApp") != null) {
                    StrclUsr = session.getAttribute("clUsrApp").toString();
                }

                if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr)) != true) {
        %>Fuera de Horario <%
                    StrclUsr = null;
                    return;
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

                if (request.getParameter("clAutobus") != null) {
                    StrclAutobus = request.getParameter("clAutobus").toString();
                    session.setAttribute("clAutobus", StrclAutobus);
                } else {
                    if (session.getAttribute("clAutobus") != null) {
                        StrclAutobus = session.getAttribute("clAutobus").toString();
                    }
                }

                session.setAttribute("clAsistencia", StrclAsistencia);
                session.setAttribute("clSubservicio", StrclSubservicio);

                String StrclPaginaWeb = "1255";
                session.setAttribute("clPaginaWebP", StrclPaginaWeb);

                if (StrclUsr != null) {
                    daoCSAutobus = new DAOCSAutobus();
                    A = daoCSAutobus.getCSAutobus(StrclAsistencia);
                }

                if (StrclUsr != null) {
                    daosg = new DAOConciergeG();
                    conciergeg = daosg.getConciergeGenerico(StrclConcierge);

                    daoRef = new DAOReferenciasxAsist();
                    ref = daoRef.getclAsistencia(StrclAsistencia);
                }

                String Store = "";
                Store = "st_GuardaCSAutobus,st_ActualizaCSAutobus";
                session.setAttribute("sp_Stores", Store);

                String Commit = "";
                Commit = "clAsistencia";
                session.setAttribute("Commit", Commit);

                ResultSet rs1 = null;
                String StrPreguntaEncuesta = "0";

                rs1 = UtileriasBDF.rsSQLNP("sp_CSPreguntaEncuesta " + StrclConcierge);
                if (rs1.next()) {
                    StrPreguntaEncuesta = rs1.getString("Pregunta").toString();
                }
                rs1.close();
                rs1 = null;

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
        <%MyUtil.InicializaParametrosC(1255, Integer.parseInt(StrclUsr));%>
        <%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "fnAccionesAlta();", "fnsp_Guarda();fnAntesGuardar();fnReqCampo();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>'>
        <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
        <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
        <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
        <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>

        <input id="Secuencia" name="Secuencia" type="hidden" value="">
        <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="clConcierge,FechaApAsist,clUsrApp,CiudadO,CiudadD,TerminalO,TerminalD,FechaS,FechaAS,Linea,Clase,HorasR,Corrida,AutoFill,CiudadOR,CiudadDR,TerminalOR,TerminalDR,FechaSR,FechaAR,LineaR,ClaseR,HorasRR,CorridaR,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,Confirmo,NConfirmo,PCancel,NuInf,Observaciones">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clAsistencia,CiudadO,CiudadD,TerminalO,TerminalD,FechaS,FechaAS,Linea,Clase,HorasR,Corrida,AutoFill,CiudadOR,CiudadDR,TerminalOR,TerminalDR,FechaSR,FechaAR,LineaR,ClaseR,HorasRR,CorridaR,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,Confirmo,NConfirmo,PCancel,NuInf,Observaciones,clEstatus">
        <INPUT id='clConcierge'  name='clConcierge'  type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsr%>'>

        <%String strEstatus = A != null ? A.getdsEstatus() : "";%>

        <%  int iY = 10;%>
        <%=MyUtil.ObjComboC("Estatus", "clEstatus", A != null ? A.getdsEstatus() : "", false, false, 30, 70, "", "sp_GetCSstatus", "", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Asistencia", "AsistenciaVTR", StrclAsistenciaVTR, false, false, 350, 70, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento", "Observaciones", A != null ? A.getComentarios() : "", "100", "3", true, true, 30, 110, "", true, true)%>
        <%=MyUtil.ObjInput("fecha de alta", "FechaA", A != null ? A.getFechaRegistro() : "", false, false, 650, 70, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Datos Generales del Evento", 5, 15)%>

        <div id='Destino' Name='Destino' style='position:absolute; z-index:11; left:50px; top:360px; width:550px; ' align="center"><p class='Obs'>Viaje redondo</p></div>

        <%=MyUtil.ObjInput("Ciudad de Origen", "CiudadO", A != null ? A.getCiudadO() : "", true, true, 30, iY + 200, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Terminal de Origen", "TerminalO", A != null ? A.getTerminalO() : "", true, true, 260, iY + 200, "", false, false, 40)%>
        <%=MyUtil.ObjInputF("Fecha de salida (AAAA-MM-DD)", "FechaS", A != null ? A.getFechaS() : "", true, true, 490, iY + 200, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Ciudad de Destino", "CiudadD", A != null ? A.getCiudadD() : "", true, true, 30, iY + 240, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Terminal de DEstino", "TerminalD", A != null ? A.getTerminalD() : "", true, true, 260, iY + 240, "", false, false, 40)%>
        <%=MyUtil.ObjInputF("Fecha de arribo (AAAA-MM-DD)", "FechaAS", A != null ? A.getFechaAS() : "", true, true, 490, iY + 240, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Linea de autobus", "Linea", A != null ? A.getLinea() : "", true, true, 30, iY + 300, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Clase", "Clase", A != null ? A.getClase() : "", true, true, 280, iY + 300, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Horas de Recorrido", "HorasR", A != null ? A.getHorasR() : "", true, true, 420, iY + 300, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Corrida", "Corrida", A != null ? A.getCorrida() : "", true, true, 570, iY + 300, "", false, false, 20)%>

        <div class='VTable'  id="btnAsist" style="position:absolute; z-index:25; left:700px; top:235px;">
            <input class='cBtn' type='button' value='Agregar Pasajero' onClick="fnGetPasajero();">
        </div>
        <%=MyUtil.ObjChkBox("HABILITA (Autofill)", "AutoFill", A != null ? A.getAutoFill() : "", true, true, 610, 355, "", "fnDesabilita();")%>

        <%=MyUtil.ObjInput("Ciudad de Origen", "CiudadOR", A != null ? A.getCiudadOR() : "", true, true, 30, iY + 380, "", false, false, 40, "")%>
        <%=MyUtil.ObjInput("Terminal de Origen", "TerminalOR", A != null ? A.getTerminalOR() : "", true, true, 260, iY + 380, "", false, false, 40)%>
        <%=MyUtil.ObjInputF("Fecha de salida (AAAA-MM-DD)", "FechaSR", A != null ? A.getFechaSR() : "", true, true, 490, iY + 380, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Ciudad de Destino", "CiudadDR", A != null ? A.getCiudadDR() : "", true, true, 30, iY + 420, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Terminal de Termino", "TerminalDR", A != null ? A.getTerminalDR() : "", true, true, 260, iY + 420, "", false, false, 40)%>
        <%=MyUtil.ObjInputF("Fecha de Arribo(AAAA-MM-DD)", "FechaAR", A != null ? A.getFechaAR() : "", true, true, 490, iY + 420, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Linea de Autobus", "LineaR", A != null ? A.getLineaR() : "", true, true, 30, iY + 480, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Clase", "ClaseR", A != null ? A.getClaseR() : "", true, true, 280, iY + 480, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Horas de Recorrido", "HorasRR", A != null ? A.getHorasRR() : "", true, true, 420, iY + 480, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Corrida", "CorridaR", A != null ? A.getCorridaR() : "", true, true, 570, iY + 480, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Descripcion del Viaje", 60, -7)%>

        <%=MyUtil.ObjComboC("Forma de Pago:", "clTipoPago", A != null ? A.getdsTipoPago() : "", true, true, 30, 570, "", "select clTipoPago,dsTipoPago from CSTipoPago", "fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Nombre del Banco:", "NomBanco", A != null ? A.getNomBanco() : "", true, true, 220, 570, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Nombre en TC:", "NombreTC", A != null ? A.getNombreTC() : "", true, true, 470, 570, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Numero de TC:", "NumeroTC", A != null ? A.getNumeroTC() : "", false, false, 30, 610, "", false, false, 50, "if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        <%=MyUtil.ObjInput("Exp.D.:(MM/AA)", "ExpiraVTR", A != null ? A.getExpira() : "", false, false, 350, 610, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
        <input type="hidden" name="Expira" id="Expira" value= "<%=A != null ? A.getExpira().trim() : ""%>">
        <%=MyUtil.ObjInput("Sec.C.:", "SecC", A != null ? A.getSecC() : "", false, false, 440, 610, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Confirmo", "Confirmo", A != null ? A.getConfirmo() : "", true, true, 30, 650, "", false, false, 30)%>
        <%=MyUtil.ObjInput("No.Conf.:", "NConfirmo", A != null ? A.getNConfirmo() : "", true, true, 350, 650, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Pol.Cancelación", "PCancel", A != null ? A.getPCancel() : "", true, true, 30, 690, "", false, false, 50)%>
        <%=MyUtil.ObjChkBox("N/U inf.:", "NuInf", A != null ? A.getNuInf() : "", true, true, 350, 690, "", "SI", "NO", "")%>
        <%=MyUtil.DoBlock("Costos del Evento", 50, -5)%>

        <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>

        <%@ include file="csVentanaFlotante.jspf" %>

        <%=MyUtil.GeneraScripts()%>

        <script>
            top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
            top.document.all.rightPO.rows="0,80,*";

            document.all.SecC.maxLength=4;

   
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

            function fnDesabilita(){
                if (document.all.AutoFillC.checked ==1){
                    document.all.CiudadOR.disabled = false;
                    document.all.TerminalOR.disabled = false;
                    document.all.FechaSR.disabled = false;
                    document.all.CiudadDR.disabled = false;
                    document.all.TerminalDR.disabled = false;
                    document.all.FechaAR.disabled = false;
                    document.all.LineaR.disabled = false;
                    document.all.ClaseR.disabled = false;
                    document.all.HorasRR.disabled = false;
                    document.all.CorridaR.disabled = false;
                    document.all.CiudadOR.value =  document.all.CiudadD.value;
                    document.all.CiudadDR.value = document.all.CiudadO.value;              
                }else{
                    document.all.CiudadOR.disabled = true;
                    document.all.TerminalOR.disabled = true;
                    document.all.FechaSR.disabled = true;
                    document.all.CiudadDR.disabled = true;
                    document.all.TerminalDR.disabled = true;
                    document.all.FechaAR.disabled = true;
                    document.all.LineaR.disabled = true;
                    document.all.ClaseR.disabled = true;
                    document.all.HorasRR.disabled = true;
                    document.all.CorridaR.disabled = true;
                }
            }

            function fnLimpiaFechas(){
                if (document.all.FechaAS.value=="1900-01-01"){
                    document.all.FechaAS.value="";
                }
     
                if (document.all.FechaS.value=="1900-01-01"){
                    document.all.FechaS.value="";
                }        
            }

            function fnGetPasajero(){
                var pstrCadena = "ConciergeFramePasajeros.jsp?clAsistencia=" + document.all.clAsistencia.value;
                window.open(pstrCadena,'newWinNA','scrollbars=yes,status=yes,width=800,height=500,top=200,left=250');
            }

        </script>
        <%
                StrclUsr = null;
                StrclPaginaWeb = null;
                daoCSAutobus = null;
                A = null;
                StrclConcierge = null;
                StrclSubservicio = null;
                StrclAsistencia = null;
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
