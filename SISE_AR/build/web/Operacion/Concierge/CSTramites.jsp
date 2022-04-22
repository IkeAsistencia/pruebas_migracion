<%--
 Document   : CSTramites
 Create on  : 2010-11-23
 Author     : rfernandez
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java"  %>
<%@ page import="java.sql.ResultSet,Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOCSTramites,com.ike.concierge.to.CSTramites,Utilerias.UtileriasBDF"%>

<html>
    <head>
        <title>Tramites</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody"  OnLoad="if (document.all.ExpiraVTR.value!=''){fnFechVen(document.all.ExpiraVTR.value)}">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>

        <script type="text/javascript" src='../../Utilerias/Util.js' ></script>
        <script type="text/javascript" src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilDireccion.js' ></script>
        <script type="text/javascript" src='../../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilCalendario.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilStore.js'></script>

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i>Trámites e Información</i></b></font><br></p></div>
        <div class='VTable' style='position:absolute; z-index:25; left:570px; top:83px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Automática</i></b></font><br></p></div>

        <%
                    String StrclConcierge = "";
                    String StrclSubservicio = "";
                    String StrclAsistencia = "0";
                    String StrclUsr = "0";
                    String StrclTramites = "0";
                    String StrURL = "";
                    String StrNomPag = "";

                    if (request.getRequestURL() != null) {
                        StrURL = request.getRequestURL().toString();
                        StrNomPag = StrURL.substring(StrURL.lastIndexOf("/") + 1);
                    }

                    DAOCSTramites daoCSTramites = null;
                    CSTramites T = null;

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

                    if (request.getParameter("clTramites") != null) {
                        StrclTramites = request.getParameter("clTramites").toString();
                        session.setAttribute("clTramites", StrclTramites);
                    } else {
                        if (session.getAttribute("clTramites") != null) {
                            StrclTramites = session.getAttribute("clTramites").toString();
                        }
                    }

                    session.setAttribute("clAsistencia", StrclAsistencia);
                    session.setAttribute("clSubservicio", StrclSubservicio);

                    String StrclPaginaWeb = "1283";
                    session.setAttribute("clPaginaWebP", StrclPaginaWeb);


                    if (StrclUsr != null) {
                        daoCSTramites = new DAOCSTramites();
                        T = daoCSTramites.getCSTramites(StrclAsistencia);
                    }
                    if (StrclUsr != null) {
                        daosg = new DAOConciergeG();
                        conciergeg = daosg.getConciergeGenerico(StrclConcierge);
                    }
                    if (StrclUsr != null) {
                        daoRef = new DAOReferenciasxAsist();
                        ref = daoRef.getclAsistencia(StrclAsistencia);
                    }

                    //<<<<<<<<<<<< Servlet Generico >>>>>>>>>>>
                    String Store = "";
                    Store = "st_GuardaCSTramites, st_ActualizaCSTramites";
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

        %><script type="text/javascript">fnOpenLinks()</script><%%>

        <%MyUtil.InicializaParametrosC(1283, Integer.parseInt(StrclUsr));%>
        <%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "fnAccionesAlta();", "fnsp_Guarda();fnAntesGuardar();fnReqCampo();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>'>
        <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
        <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
        <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
        <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
        <INPUT id="clPaginaWeb" name="clPaginaWeb" type="hidden" value="<%=StrclPaginaWeb%>" >
        <INPUT id="Secuencia" name="Secuencia" type="hidden" value="">
        <INPUT id="SecuenciaG" name="SecuenciaG" type="hidden" value="clConcierge,FechaApAsist,clUsrApp,TipoTramite,PagoDerechos,Horario,FechaCita,Ubicacion,Requisitos,Requisitos1,Requisitos2,Requisitos3,Requisitos4,Requisitos5,Requisitos6,Requisitos7,Requisitos8,Requisitos9,Observaciones,Observaciones1,Observaciones2,Observaciones3,Observaciones4,Observaciones5,Observaciones6,Observaciones7,Observaciones8,Observaciones9,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,Confirmo,NConfirmo,PCancel,NuInf,ObservacionesE">
        <INPUT id="SecuenciaA" name="SecuenciaA" type="hidden" value="clAsistencia,TipoTramite,PagoDerechos,Horario,FechaCita,Ubicacion,Requisitos,Requisitos1,Requisitos2,Requisitos3,Requisitos4,Requisitos5,Requisitos6,Requisitos7,Requisitos8,Requisitos9,Observaciones,Observaciones1,Observaciones2,Observaciones3,Observaciones4,Observaciones5,Observaciones6,Observaciones7,Observaciones8,Observaciones9,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,Confirmo,NConfirmo,PCancel,NuInf,ObservacionesE,clEstatus">
        <INPUT id='clConcierge'  name='clConcierge'  type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsr%>'>

        <%String strEstatus = T != null ? T.getdsEstatus() : "";%>

        <% int iY = 10;%>
        <%=MyUtil.ObjComboC("Estatus", "clEstatus", T != null ? T.getdsEstatus() : "", false, false, 30, 70, "", "sp_GetCSstatus", "", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Asistencia", "AsistenciaVTR", StrclAsistenciaVTR, false, false, 350, 70, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento", "ObservacionesE", T != null ? T.getComentarios() : "", "83", "3", true, true, 30, 110, "", true, true)%>
        <%=MyUtil.ObjInput("fecha de alta", "FechaA", T != null ? T.getFechaRegistro() : "", false, false, 650, 70, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Datos Generales del Evento", 5, 15)%>

        <%=MyUtil.ObjInput("Tipo de Tramite", "TipoTramite", T != null ? T.getTipoTramite() : "", true, true, 30, iY + 200, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Pago de Derechos", "PagoDerechos", T != null ? T.getPagoDerechos() : "", true, true, 300, iY + 200, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Horario de Atencion", "Horario", T != null ? T.getHorario() : "", true, true, 500, iY + 200, "", false, false, 45)%>

        <div class='VTable' style='position:absolute; z-index:25; left:40px; top:265px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>1 </i></b></font><br></p></div>
                <%=MyUtil.ObjInput("Requisitos", "Requisitos", T != null ? T.getRequisitos() : "", true, true, 50, iY + 240, "", false, false, 60)%>
                <%=MyUtil.ObjInput("Observaciones", "Observaciones", T != null ? T.getObservaciones() : "", true, true, 380, iY + 240, "", false, false, 50)%>

        <div class='VTable' style='position:absolute; z-index:25; left:40px; top:285px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>2 </i></b></font><br></p></div>
                <%=MyUtil.ObjInput("", "Requisitos1", T != null ? T.getRequisitos1() : "", true, true, 50, iY + 260, "", false, false, 60)%>
                <%=MyUtil.ObjInput("", "Observaciones1", T != null ? T.getObservaciones1() : "", true, true, 380, iY + 260, "", false, false, 50)%>

        <div class='VTable' style='position:absolute; z-index:25; left:40px; top:305px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>3 </i></b></font><br></p></div>
                <%=MyUtil.ObjInput("", "Requisitos2", T != null ? T.getRequisitos2() : "", true, true, 50, iY + 280, "", false, false, 60)%>
                <%=MyUtil.ObjInput("", "Observaciones2", T != null ? T.getObservaciones2() : "", true, true, 380, iY + 280, "", false, false, 50)%>

        <div class='VTable' style='position:absolute; z-index:25; left:40px; top:325px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>4 </i></b></font><br></p></div>
                <%=MyUtil.ObjInput("", "Requisitos3", T != null ? T.getRequisitos3() : "", true, true, 50, iY + 300, "", false, false, 60)%>
                <%=MyUtil.ObjInput("", "Observaciones3", T != null ? T.getObservaciones3() : "", true, true, 380, iY + 300, "", false, false, 50)%>

        <div class='VTable' style='position:absolute; z-index:25; left:40px; top:345px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>5 </i></b></font><br></p></div>
                <%=MyUtil.ObjInput("", "Requisitos4", T != null ? T.getRequisitos4() : "", true, true, 50, iY + 320, "", false, false, 60)%>
                <%=MyUtil.ObjInput("", "Observaciones4", T != null ? T.getObservaciones4() : "", true, true, 380, iY + 320, "", false, false, 50)%>

        <div class='VTable' style='position:absolute; z-index:25; left:40px; top:365px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>6 </i></b></font><br></p></div>
                <%=MyUtil.ObjInput("", "Requisitos5", T != null ? T.getRequisitos5() : "", true, true, 50, iY + 340, "", false, false, 60)%>
                <%=MyUtil.ObjInput("", "Observaciones5", T != null ? T.getObservaciones5() : "", true, true, 380, iY + 340, "", false, false, 50)%>

        <div class='VTable' style='position:absolute; z-index:25; left:40px; top:385px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>7 </i></b></font><br></p></div>
                <%=MyUtil.ObjInput("", "Requisitos6", T != null ? T.getRequisitos6() : "", true, true, 50, iY + 360, "", false, false, 60)%>
                <%=MyUtil.ObjInput("", "Observaciones6", T != null ? T.getObservaciones6() : "", true, true, 380, iY + 360, "", false, false, 50)%>

        <div class='VTable' style='position:absolute; z-index:25; left:40px; top:405px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>8 </i></b></font><br></p></div>
                <%=MyUtil.ObjInput("", "Requisitos7", T != null ? T.getRequisitos7() : "", true, true, 50, iY + 380, "", false, false, 60)%>
                <%=MyUtil.ObjInput("", "Observaciones7", T != null ? T.getObservaciones7() : "", true, true, 380, iY + 380, "", false, false, 50)%>

        <div class='VTable' style='position:absolute; z-index:25; left:40px; top:425px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>9 </i></b></font><br></p></div>
                <%=MyUtil.ObjInput("", "Requisitos8", T != null ? T.getRequisitos8() : "", true, true, 50, iY + 400, "", false, false, 60)%>
                <%=MyUtil.ObjInput("", "Observaciones8", T != null ? T.getObservaciones8() : "", true, true, 380, iY + 400, "", false, false, 50)%>

        <div class='VTable' style='position:absolute; z-index:25; left:33px; top:445px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>10 </i></b></font><br></p></div>
                <%=MyUtil.ObjInput("", "Requisitos9", T != null ? T.getRequisitos9() : "", true, true, 50, iY + 420, "", false, false, 60)%>
                <%=MyUtil.ObjInput("", "Observaciones9", T != null ? T.getObservaciones9() : "", true, true, 380, iY + 420, "", false, false, 50)%>

        <%=MyUtil.ObjInputF("Fecha de la Cita (AAAA-MM-DD)", "FechaCita", T != null ? T.getFechaCita() : "", true, true, 60, iY + 465, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjTextArea("Ubicacion", "Ubicacion", T != null ? T.getUbicacion() : "", "80", "2", true, true, 270, iY + 465, "", false, false)%>
        <%=MyUtil.DoBlock("Costos del Evento", 80, 3)%>

        <%=MyUtil.ObjComboC("Forma de Pago:", "clTipoPago", T != null ? T.getdsTipoPago() : "", true, true, 30, 570, "", "select clTipoPago,dsTipoPago from CSTipoPago", "fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Nombre del Banco:", "NomBanco", T != null ? T.getNomBanco() : "", true, true, 220, 570, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Nombre en TC:", "NombreTC", T != null ? T.getNombreTC() : "", true, true, 470, 570, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Numero de TC:", "NumeroTC", T != null ? T.getNumeroTC() : "", false, false, 30, 610, "", false, false, 50, "if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        <%=MyUtil.ObjInput("Exp.D.:(MM/AA)", "ExpiraVTR", T != null ? T.getExpira() : "", false, false, 350, 610, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
        <input type="hidden" name="Expira" id="Expira" value= "<%=T != null ? T.getExpira().trim() : ""%>">
        <%=MyUtil.ObjInput("Sec.C.:", "SecC", T != null ? T.getSecC() : "", false, false, 440, 610, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Confirmo", "Confirmo", T != null ? T.getConfirmo() : "", true, true, 30, 650, "", false, false, 30)%>
        <%=MyUtil.ObjInput("No.Conf.:", "NConfirmo", T != null ? T.getNConfirmo() : "", true, true, 350, 650, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Pol.Cancelación", "PCancel", T != null ? T.getPCancel() : "", true, true, 30, 690, "", false, false, 50)%>
        <%=MyUtil.ObjChkBox("N/U inf.:", "NuInf", T != null ? T.getNuInf() : "", true, true, 350, 690, "", "SI", "NO", "")%>
        <%=MyUtil.DoBlock("Costos del Evento", 100, 10)%>

        <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>

        <%@ include file="csVentanaFlotante.jspf" %>

        <%=MyUtil.GeneraScripts()%>

        <%
                    StrclUsr = null;
                    StrclPaginaWeb = null;
                    daoCSTramites = null;
                    T = null;
                    StrclConcierge = null;
                    StrclSubservicio = null;
                    StrclAsistencia = null;
                    daosg = null;
                    conciergeg = null;
                    daoRef = null;
                    ref = null;
        %>

        <script type="text/javascript">
            top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
            top.document.all.rightPO.rows="0,50,*";

            function fnAccionesAlta(){
                if (document.all.Action.value==1){

                    var pstrCadena = "../../Utilerias/RegresaFechaActual.jsp";
                    window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');
                }
            }

            function fnActualizaFechaActual(pFecha){
                document.all.FechaApAsist.value = pFecha;
            }

            function fnAntesGuardar(){
                fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
            }
    
            initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
        </script>
    </body>
</html>
