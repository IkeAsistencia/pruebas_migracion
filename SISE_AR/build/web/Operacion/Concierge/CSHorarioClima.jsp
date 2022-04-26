<%--
 Document   : CSHorarioClima
 Create on  : 2010-11-23
 Author     : rfernandez
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOCSHorarioClima,com.ike.concierge.to.CSHorarioClima" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,javax.servlet.http.HttpSession,java.sql.ResultSet"%>

<html>
    <head>
        <title>Horario Clima</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="fnAccionesAlta();">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js' ></script>
        <script type="text/javascript" src='../../Utilerias/UtilDireccion.js' ></script>
        <script type="text/javascript" src='../../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilCalendario.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilStore.js'></script>

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Horario y Clima </i></b></font><br></p></div>
        <div class='VTable' style='position:absolute; z-index:25; left:470px; top:83px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Automática </i></b></font><br></p></div>

        <%      String StrclConcierge = "";
                    String StrclSubservicio = "";
                    String StrclUsr = "0";
                    String StrclHorarioClima = "0";
                    String StrclAsistencia = "0";

                    //--------------------*  1  *--------------------------
                    String StrURL = "";
                    String StrNomPag = "";

                    if (request.getRequestURL() != null) {
                        StrURL = request.getRequestURL().toString();
                        StrNomPag = StrURL.substring(StrURL.lastIndexOf("/") + 1);
                    }
                    //-----------------------------------------------------

                    DAOCSHorarioClima daoCSHorarioClima = null;
                    CSHorarioClima HC = null;

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

                    if (request.getParameter("clHorarioClima") != null) {
                        StrclHorarioClima = request.getParameter("clHorarioClima").toString();
                        session.setAttribute("clHorarioClima", StrclHorarioClima);
                    } else {
                        if (session.getAttribute("clHorarioClima") != null) {
                            StrclHorarioClima = session.getAttribute("clHorarioClima").toString();
                        }
                    }

                    session.setAttribute("clAsistencia", StrclAsistencia);
                    session.setAttribute("clSubservicio", StrclSubservicio);

                    String StrclPaginaWeb = "1252";
                    session.setAttribute("clPaginaWebP", StrclPaginaWeb);

                    if (StrclUsr != null) {
                        daoCSHorarioClima = new DAOCSHorarioClima();
                        HC = daoCSHorarioClima.getCSHorarioClima(StrclAsistencia);

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
                    Store = "st_GuardaCSHorarioClima, st_ActualizaCSHorarioClima";
                    session.setAttribute("sp_Stores", Store);

                    String Commit = "";
                    Commit = "clAsistencia";
                    session.setAttribute("Commit", Commit);

                    //---------------------*  2  *--------------------------
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
                            //StrclAsistenciaVTR = ConciergeInfTC!=null ? ConciergeInfTC.getClAsistencia().trim() : "";
                            StrclAsistenciaVTR = StrclAsistencia;
                        }
                        session.setAttribute("clAsistenciaVTR", StrclAsistenciaVTR);
                    }

                    rsTieneAsistMadre.close();
                    rsTieneAsistMadre = null;
                    //-----------------------------------------------------

        %><script type="text/javascript">fnOpenLinks()</script>

        <%MyUtil.InicializaParametrosC(1252, Integer.parseInt(StrclUsr));%>
        <%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "fnAccionesAlta();", "fnsp_Guarda();")%>

        <%-------------------------  3  ----------------------------%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>'>
        <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
        <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
        <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
        <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
        <%----------------------------------------------------------%>

        <input id="clPaginaWeb" name="clPaginaWeb" type="hidden" value="<%=StrclPaginaWeb%>" >
        <input id="Secuencia" name="Secuencia" type="hidden" value="">
        <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="clConcierge,FechaApAsist,clUsrApp,clPais,Ciudad,HoraActual,DifHorario,ZonaHoraria,HorarioVerano,clPaisC,CiudadC,Minima,Maxima,Probabilidad,FechaTemp,FechaTemp1,FechaTemp2,FechaTemp3,FechaTemp4,FechaTemp5,FechaTemp6,MinimaTemp,MinimaTemp1,MinimaTemp2,MinimaTemp3,MinimaTemp4,MinimaTemp5,MinimaTemp6,MaximaTemp,MaximaTemp1,MaximaTemp2,MaximaTemp3,MaximaTemp4,MaximaTemp5,MaximaTemp6,ProbTemp,ProbTemp1,ProbTemp2,ProbTemp3,ProbTemp4,ProbTemp5,ProbTemp6,Observaciones">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clAsistencia,clPais,Ciudad,HoraActual,DifHorario,ZonaHoraria,HorarioVerano,clPaisC,CiudadC,Minima,Maxima,Probabilidad,FechaTemp,FechaTemp1,FechaTemp2,FechaTemp3,FechaTemp4,FechaTemp5,FechaTemp6,MinimaTemp,MinimaTemp1,MinimaTemp2,MinimaTemp3,MinimaTemp4,MinimaTemp5,MinimaTemp6,MaximaTemp,MaximaTemp1,MaximaTemp2,MaximaTemp3,MaximaTemp4,MaximaTemp5,MaximaTemp6,ProbTemp,ProbTemp1,ProbTemp2,ProbTemp3,ProbTemp4,ProbTemp5,ProbTemp6,Observaciones,clEstatus">

        <INPUT id='clConcierge'  name='clConcierge'  type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsr%>'>

        <%String strEstatus = HC != null ? HC.getdsEstatus() : "";%>
        <%  int iY = 40;%>

        <%=MyUtil.ObjComboC("Estatus", "clEstatus", HC != null ? HC.getdsEstatus() : "", false, false, 30, 70, "", "sp_GetCSstatus", "", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Asistencia", "AsistenciaVTR", StrclAsistenciaVTR, false, false, 350, 70, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Descripción del Evento", "Observaciones", HC != null ? HC.getComentarios() : "", "90", "6", true, true, 30, 110, "", true, true)%>
        <%=MyUtil.ObjInput("Fecha de alta", "FechaA", HC != null ? HC.getFechaRegistro() : "", false, false, 550, 70, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Datos Generales del Evento", -50, 50)%>

        <%=MyUtil.ObjComboC("País", "clPais", HC != null ? HC.getdsPais() : "", true, true, 30, iY + 210, "", "SELECT clpais, dspais from cPais", "", "", 20, false, false)%>
        <%=MyUtil.ObjInput("Ciudad", "Ciudad", HC != null ? HC.getCiudad() : "", true, true, 290, iY + 210, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Hora Actual", "HoraActual", HC != null ? HC.getHoraActual() : "", true, true, 530, iY + 210, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Dif. Horario", "DifHorario", HC != null ? HC.getDifHorario() : "", true, true, 620, iY + 210, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Zona Horaria", "ZonaHoraria", HC != null ? HC.getZonaHoraria() : "", true, true, 710, iY + 210, "", false, false, 20)%>
        <%=MyUtil.ObjChkBox("H.Verano", "HorarioVerano", HC != null ? HC.getHorarioVerano() : "", true, true, 835, iY + 205, "", "SI", "NO", "")%>
        <%=MyUtil.DoBlock("Detalles de uso Hoario", -110, -10)%>

        <%=MyUtil.ObjComboC("País", "clPaisA", HC != null ? HC.getdsPaisC() : "", true, true, 30, iY + 285, "", "SELECT clpais, dspais from cPais", "", "", 20, false, false)%>
        <%=MyUtil.ObjInput("Ciudad", "CiudadC", HC != null ? HC.getCiudadC() : "", true, true, 290, iY + 285, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Mínima", "Minima", HC != null ? HC.getMinima() : "", true, true, 530, iY + 285, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Máxima", "Maxima", HC != null ? HC.getMaxima() : "", true, true, 620, iY + 285, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Probabilidad", "Probabilidad", HC != null ? HC.getProbabilidad() : "", true, true, 710, iY + 285, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Detalles Clima", -50, -10)%>

        <div id="link" style='position:absolute; z-index:25; left:750px; top:430px;'> <a href="http://espanol.weather.com" target="blank"> WEATHER  </a><br><br></div>
        <div id="link" style='position:absolute; z-index:25; left:750px; top:470px;'> <a href="http://www.timeanddate.com" target="blank"> TIME </a><br></div>

        <%=MyUtil.ObjInput("Fecha", "FechaTemp", HC != null ? HC.getFechaTemp() : "", true, true, 30, iY + 360, "", false, false, 20)%>   <%=MyUtil.ObjInput("", "FechaTemp1", HC != null ? HC.getFechaTemp() : "", true, true, 30, iY + 390, "", false, false, 20)%>
        <%=MyUtil.ObjInput("", "FechaTemp2", HC != null ? HC.getFechaTemp() : "", true, true, 30, iY + 420, "", false, false, 20)%>       <%=MyUtil.ObjInput("", "FechaTemp3", HC != null ? HC.getFechaTemp() : "", true, true, 30, iY + 450, "", false, false, 20)%>
        <%=MyUtil.ObjInput("", "FechaTemp4", HC != null ? HC.getFechaTemp() : "", true, true, 30, iY + 480, "", false, false, 20)%>       <%=MyUtil.ObjInput("", "FechaTemp5", HC != null ? HC.getFechaTemp() : "", true, true, 30, iY + 510, "", false, false, 20)%>
        <%=MyUtil.ObjInput("", "FechaTemp6", HC != null ? HC.getFechaTemp() : "", true, true, 30, iY + 540, "", false, false, 20)%>

        <%=MyUtil.ObjInput("Mínima", "MinimaTemp", HC != null ? HC.getMinimaTemp() : "", true, true, 180, iY + 360, "", false, false, 25)%>  <%=MyUtil.ObjInput("", "MinimaTemp1", HC != null ? HC.getMinimaTemp1() : "", true, true, 180, iY + 390, "", false, false, 25)%>
        <%=MyUtil.ObjInput("", "MinimaTemp2", HC != null ? HC.getMinimaTemp2() : "", true, true, 180, iY + 420, "", false, false, 25)%>      <%=MyUtil.ObjInput("", "MinimaTemp3", HC != null ? HC.getMinimaTemp3() : "", true, true, 180, iY + 450, "", false, false, 25)%>
        <%=MyUtil.ObjInput("", "MinimaTemp4", HC != null ? HC.getMinimaTemp4() : "", true, true, 180, iY + 480, "", false, false, 25)%>      <%=MyUtil.ObjInput("", "MinimaTemp5", HC != null ? HC.getMinimaTemp5() : "", true, true, 180, iY + 510, "", false, false, 25)%>
        <%=MyUtil.ObjInput("", "MinimaTemp6", HC != null ? HC.getMinimaTemp6() : "", true, true, 180, iY + 540, "", false, false, 25)%>

        <%=MyUtil.ObjInput("Máxima", "MaximaTemp", HC != null ? HC.getMaximaTemp() : "", true, true, 355, iY + 360, "", false, false, 25)%>  <%=MyUtil.ObjInput("", "MaximaTemp1", HC != null ? HC.getMaximaTemp1() : "", true, true, 355, iY + 390, "", false, false, 25)%>
        <%=MyUtil.ObjInput("", "MaximaTemp2", HC != null ? HC.getMaximaTemp2() : "", true, true, 355, iY + 420, "", false, false, 25)%>      <%=MyUtil.ObjInput("", "MaximaTemp3", HC != null ? HC.getMaximaTemp3() : "", true, true, 355, iY + 450, "", false, false, 25)%>
        <%=MyUtil.ObjInput("", "MaximaTemp4", HC != null ? HC.getMaximaTemp4() : "", true, true, 355, iY + 480, "", false, false, 25)%>      <%=MyUtil.ObjInput("", "MaximaTemp5", HC != null ? HC.getMaximaTemp5() : "", true, true, 355, iY + 510, "", false, false, 25)%>
        <%=MyUtil.ObjInput("", "MaximaTemp6", HC != null ? HC.getMaximaTemp6() : "", true, true, 355, iY + 540, "", false, false, 25)%>

        <%=MyUtil.ObjInput("Prob. Precipitación / Nieve", "ProbTemp", HC != null ? HC.getProbTemp() : "", true, true, 530, iY + 360, "", false, false, 35)%>    <%=MyUtil.ObjInput("", "ProbTemp1", HC != null ? HC.getProbTemp1() : "", true, true, 530, iY + 390, "", false, false, 35)%>
        <%=MyUtil.ObjInput("", "ProbTemp2", HC != null ? HC.getProbTemp2() : "", true, true, 530, iY + 420, "", false, false, 35)%>     <%=MyUtil.ObjInput("", "ProbTemp3", HC != null ? HC.getProbTemp3() : "", true, true, 530, iY + 450, "", false, false, 35)%>
        <%=MyUtil.ObjInput("", "ProbTemp4", HC != null ? HC.getProbTemp4() : "", true, true, 530, iY + 480, "", false, false, 35)%>     <%=MyUtil.ObjInput("", "ProbTemp5", HC != null ? HC.getProbTemp5() : "", true, true, 530, iY + 510, "", false, false, 35)%>
        <%=MyUtil.ObjInput("", "ProbTemp6", HC != null ? HC.getProbTemp6() : "", true, true, 530, iY + 540, "", false, false, 35)%>
        <%=MyUtil.DoBlock("Condiciones Futuras", 130, -5)%>

        <%=MyUtil.GeneraScripts()%>

        <%  //<<<<<<<<<<<<<<<< Limpiar Variables >>>>>>>>>
                    StrclUsr = null;
                    StrclPaginaWeb = null;
                    daoCSHorarioClima = null;
                    HC = null;
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
                fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value);
            }
            fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);

            initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
        </script>
    </body>
</html>
