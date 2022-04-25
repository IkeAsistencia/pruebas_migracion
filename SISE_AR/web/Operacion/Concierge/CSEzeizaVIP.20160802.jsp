<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage=""%>
<%@ page import = "Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOCSEzeizaVIP,com.ike.concierge.to.CSEzeizaVIP,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist,java.sql.ResultSet,Utilerias.UtileriasBDF,Combos.cbAMIS"%>

<html>
    <head>
        <title>Ezeiza VIP</title>
        <link rel="stylesheet" href="../../StyleClasses/Global.css" type="text/css">
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <link rel="stylesheet" href="../../StyleClasses/Calendario.css" type="text/css">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>
        <style type="text/css">
            .terminos{
                font-variant:small-caps;
                font-family: 'Open Sans', sans-serif;
                font-size:13px;
            }
        </style>
    </head>
    <body class="cssBody" onload="fnAccionesAlta();">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>

        <script type="text/javascript" src='../../Utilerias/Util.js' ></script>
        <script type="text/javascript" src='../../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilCalendarioV.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilStore.js'></script>
        <script type="text/javascript" src='../../Utilerias/overlib.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAuto.js'></script>
    <%
        String StrclConcierge = "";
        String StrclSubservicio = "";
        String StrdsSubservicio = "";
        String StrclAsistencia = "0";
        String strclUsr = "";
        String StrURL = "";
        String StrNomPag = "";
        String StrclPaginaWeb = "1444";
        String StrPreguntaEncuesta = "0";
        String StrNombreBanco = "";
        String StrNumeroBin = "";
        String StrTipoTarjeta = "";
        String StrNombreNU = "";
        String StrclMarcaAuto = "";
        //String StrCorreoNU = "";

        String StrEmailComercialNU = "";
        String StrEmailPersonalNU = "";
        String StrEmailAlternoNU = "";
        String StrEmailOtroNU = "";

        String StrTelNU = "";

        if (request.getRequestURL() != null) {
            StrURL = request.getRequestURL().toString();
            StrNomPag = StrURL.substring(StrURL.lastIndexOf("/") + 1);
        }

        DAOCSEzeizaVIP daos = null;

        CSEzeizaVIP EVIP = null;
        CSEzeizaVIP EPREV = null;

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
        } else if (session.getAttribute("clAsistencia") != null) {
            StrclAsistencia = session.getAttribute("clAsistencia").toString();
        }

        if (request.getParameter("clSubservicio") != null) {
            StrclSubservicio = request.getParameter("clSubservicio").toString();
        } else if (session.getAttribute("clSubservicio") != null) {
            StrclSubservicio = session.getAttribute("clSubservicio").toString();
        }
        
        ResultSet rsNombreSS = null;
        rsNombreSS = UtileriasBDF.rsSQLNP("st_CSGetNombreSubServicio " + StrclSubservicio);
            
        if(rsNombreSS.next()){
            StrdsSubservicio = rsNombreSS.getString("dsSubservicio");
        }
            
        rsNombreSS.close();
        rsNombreSS = null;

        session.setAttribute("clAsistencia", StrclAsistencia);
        session.setAttribute("clSubservicio", StrclSubservicio);
        session.setAttribute("clPaginaWebP", StrclPaginaWeb);

        if (strclUsr != null) {
            daos = new DAOCSEzeizaVIP();

            EVIP = daos.getCSEzeizaVIP(StrclAsistencia);

            EPREV = daos.getCSEzeizaVIPPRevio(StrclConcierge);

            daoRef = new DAOReferenciasxAsist();
            ref = daoRef.getclAsistencia(StrclAsistencia);
        }

        if (strclUsr != null) {
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

        if (EVIP != null) {
            StrNombreBanco = EVIP != null ? EVIP.getBanco() : "";
            StrNumeroBin = EVIP != null ? EVIP.getNumeroBin() : "";
            StrTipoTarjeta = EVIP != null ? EVIP.getTipoTarjeta() : "";
            StrNombreNU = EVIP != null ? EVIP.getNuestroUsuario() : "";
            StrclMarcaAuto = EVIP != null ? EVIP.getClMarcaAuto() : "";
            StrEmailComercialNU = EVIP != null ? EVIP.getEmailComercialNU() : "";
            StrEmailPersonalNU = EVIP != null ? EVIP.getEmailPersonalNU() : "";
            StrEmailAlternoNU = EVIP != null ? EVIP.getEmailAlternoNU() : "";
            StrEmailOtroNU = EVIP != null ? EVIP.getEmailOtroNU() : "";
            StrTelNU = EVIP != null ? EVIP.getTelNU() : "";
        } else {
            StrNombreBanco = EPREV != null ? EPREV.getBanco() : "";
            StrNumeroBin = EPREV != null ? EPREV.getNumeroBin() : "";
            StrTipoTarjeta = EPREV != null ? EPREV.getTipoTarjeta() : "";
            StrNombreNU = EPREV != null ? EPREV.getNuestroUsuario() : "";
            StrclMarcaAuto = EPREV != null ? EPREV.getClMarcaAuto() : "";
            StrEmailComercialNU = EPREV != null ? EPREV.getEmailComercialNU() : "";
            StrEmailPersonalNU = EPREV != null ? EPREV.getEmailPersonalNU() : "";
            StrEmailAlternoNU = EPREV != null ? EPREV.getEmailAlternoNU() : "";
            StrEmailOtroNU = EPREV != null ? EPREV.getEmailOtroNU() : "";
            StrTelNU = EPREV != null ? EPREV.getTelNU() : "";
        }

        //<<<<<<<<<<<< Servlet Generico >>>>>>>>>>>
        String Store = "";
        Store = "st_GuardaCSEzeizaVIP,st_ActualizaCSEzeizaVIP";
        session.setAttribute("sp_Stores", Store);

        String Commit = "";
        Commit = "clAsistencia";
        session.setAttribute("Commit", Commit);

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

    %>
        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i><%=StrdsSubservicio%></i></b></font><br></p></div>
        <div class='VTable' style='position:absolute; z-index:25; left:460px; top:93px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Autom�tica</i></b></font><br></p></div>
        <script type="text/javascript" >fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(1444, Integer.parseInt(strclUsr));%>
        <%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "fnAccionesAlta();fnHabilitaAuto();", "fnHabilitaAuto();", "fnAntesGuardar();fnsp_Guarda();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>'>
        <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
        <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
        <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
        <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>

        <input id="Secuencia" name="Secuencia" type="hidden" value="">
        <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="DescripcionEvento,NombreBanco,NumeroBin,NombreNU,clConcierge,FechaApAsist,TipoTarjeta,DocumentoNU,TelNU,EmailComercialNU,EmailPersonalNU,EmailAlternoNU,EmailOtroNU,EmailExtra1,EnviaTCC,EnviaTCP,EnviaTCA,EnviaTCO,EnviaTCX1,clAerolinea_I,NoVuelo_I,FechaVuelo_I,Horario_I,Origen_I,Destino_I,Observaciones_I,NomPAX1_I,NomPAX2_I,NomPAX3_I,NomPAX4_I,NomPAX5_I,NomPAX6_I,DocPAX1_I,DocPAX2_I,DocPAX3_I,DocPAX4_I,DocPAX5_I,DocPAX6_I,MenorPAX1_I,MenorPAX2_I,MenorPAX3_I,MenorPAX4_I,MenorPAX5_I,MenorPAX6_I,THABPAX1_I,THABPAX2_I,THABPAX3_I,THABPAX4_I,THABPAX5_I,THABPAX6_I,BinPAX1_I,BinPAX2_I,BinPAX3_I,BinPAX4_I,BinPAX5_I,BinPAX6_I,clAerolinea_R,NoVuelo_R,FechaVuelo_R,Horario_R,Origen_R,Destino_R,Observaciones_R,NomPAX1_R,NomPAX2_R,NomPAX3_R,NomPAX4_R,NomPAX5_R,NomPAX6_R,DocPAX1_R,DocPAX2_R,DocPAX3_R,DocPAX4_R,DocPAX5_R,DocPAX6_R,MenorPAX1_R,MenorPAX2_R,MenorPAX3_R,MenorPAX4_R,MenorPAX5_R,MenorPAX6_R,THABPAX1_R,THABPAX2_R,THABPAX3_R,THABPAX4_R,THABPAX5_R,THABPAX6_R,BinPAX1_R,BinPAX2_R,BinPAX3_R,BinPAX4_R,BinPAX5_R,BinPAX6_R,Parking,CodigoMarca,ClaveAMIS,Patente,OtroAuto,clUsrApp,ViajaNU,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,Confirmo,NConfirmo,PCancel,NuInf,DomFiscal,clSubservicio">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clAsistencia,clEstatus,DescripcionEvento,NombreBanco,NumeroBin,NombreNU,clConcierge,FechaApAsist,TipoTarjeta,DocumentoNU,TelNU,EmailComercialNU,EmailPersonalNU,EmailAlternoNU,EmailOtroNU,EmailExtra1,clAerolinea_I,NoVuelo_I,FechaVuelo_I,Horario_I,Origen_I,Destino_I,Observaciones_I,NomPAX1_I,NomPAX2_I,NomPAX3_I,NomPAX4_I,NomPAX5_I,NomPAX6_I,DocPAX1_I,DocPAX2_I,DocPAX3_I,DocPAX4_I,DocPAX5_I,DocPAX6_I,MenorPAX1_I,MenorPAX2_I,MenorPAX3_I,MenorPAX4_I,MenorPAX5_I,MenorPAX6_I,THABPAX1_I,THABPAX2_I,THABPAX3_I,THABPAX4_I,THABPAX5_I,THABPAX6_I,BinPAX1_I,BinPAX2_I,BinPAX3_I,BinPAX4_I,BinPAX5_I,BinPAX6_I,clAerolinea_R,NoVuelo_R,FechaVuelo_R,Horario_R,Origen_R,Destino_R,Observaciones_R,NomPAX1_R,NomPAX2_R,NomPAX3_R,NomPAX4_R,NomPAX5_R,NomPAX6_R,DocPAX1_R,DocPAX2_R,DocPAX3_R,DocPAX4_R,DocPAX5_R,DocPAX6_R,MenorPAX1_R,MenorPAX2_R,MenorPAX3_R,MenorPAX4_R,MenorPAX5_R,MenorPAX6_R,THABPAX1_R,THABPAX2_R,THABPAX3_R,THABPAX4_R,THABPAX5_R,THABPAX6_R,BinPAX1_R,BinPAX2_R,BinPAX3_R,BinPAX4_R,BinPAX5_R,BinPAX6_R,Parking,CodigoMarca,ClaveAMIS,Patente,OtroAuto,clUsrApp,ViajaNU,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,Confirmo,NConfirmo,PCancel,NuInf,DomFiscal">

        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>
        <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
        <input id="MailContacto" name="MailContacto" type="hidden" value="">
        <INPUT id='AvisoPrivacidad' name='AvisoPrivacidad' type='hidden' value='0'>

        <%String strEstatus = EVIP != null ? EVIP.getDsEstatus() : "";%>

        <%=MyUtil.ObjComboC("Estatus", "clEstatus", EVIP != null ? EVIP.getDsEstatus() : "", false, false, 30, 80, "0", "sp_GetCSstatus", "", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Asistencia", "AsistenciaVTR", StrclAsistenciaVTR, false, false, 350, 80, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Descripci�n del evento", "DescripcionEvento", EVIP != null ? EVIP.getDescripcion().trim() : "", "77", "7", true, true, 30, 120, "", true, true)%>
        <div style="position:  relative; z-index: 80; left: 460px; top: 100px;">
            <img alt="Importante"  src="../../Imagenes/warning.png">
            <div style="position: absolute; left: 40px; top: 8px; text-align: justify">
                <input type="checkbox" id="AceptaCheck" onclick="fnRevisaTerminos();">
                <b class="terminos">aceptar t�rminos<br>y condiciones.</b>
            </div>
        </div>
        <%=MyUtil.ObjInput("Fecha de apertura", "FechaRegistro", EVIP != null ? EVIP.getFechaRegAsist() : "", false, false, 540, 80, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Datos Generales del Evento", -30, 60)%>


        <%=MyUtil.ObjInput("E-mail Extra No.1", "EmailExtra1", EVIP != null ? EVIP.getEmailExtra1() : "", true, true, 725, 80, "", false, false, 35)%>
        <%=MyUtil.ObjChkBox("", "EnviaTCX1", "", true, true, 936, 80, "0", "SI", "NO", "fnVerificaMailCondicionado('EnviaTCX1','EmailExtra1');")%>
        <div style="position: absolute; z-index: 50; left: 958px; top: 90px; background-color: #E6F2F9" class="FTable">
            <p><b>Enviar T�rminos<br>y Condiciones</b></p>
        </div>
        <div style="position: absolute; left: 728px; top: 125px; z-index: 100; text-align: justify">
            <b class="terminos" style="font-size: 12px">NOTA: para enviar t�rminos y condiciones (TC):
                <br>1. en <u>alta</u>, seleccionar las direcciones deseadas.
                <br>2. en <u>cambio</u>, seleccionar las direcciones y hacer clic en
                <br>"enviar t�rminos y condiciones" o en el bot�n "guardar".
            </b>
        </div>
        <div id="btnEnvio" name="btnEnvio" style='position:absolute; z-index:25; left:745px; top:200px;'>
            <img alt="Email"  src="../../Imagenes/email.png" style="position:absolute; z-index:26; left:260px; top:2px;">
            <INPUT type='button' value='ENVIAR T�RMINOS Y CONDICIONES' onClick='fnEnviaCondicionado();' class='cBtn'>
        </div>
        <%=MyUtil.DoBlock("T�rminos y Condiciones", -50, 100)%>

        <%=MyUtil.ObjInput("Nombre del Banco", "NombreBanco", StrNombreBanco, true, true, 30, 265, StrNombreBanco, true, true, 45)%>
        <%=MyUtil.ObjInput("N�mero de BIN", "NumeroBin", StrNumeroBin, true, true, 285, 265, StrNumeroBin, true, true, 45)%>
        <div onmouseover="return overlib('<b>TAL COMO APARECE EN SU DOCUMENTO.</b>', CENTER);" onmouseout="return nd();">
            <%=MyUtil.ObjInput("Nombre de nuestro usuario", "NombreNU", StrNombreNU, true, true, 30, 305, StrNombreNU, true, true, 45)%>
        </div>
        <%=MyUtil.ObjInput("Tipo de tarjeta", "TipoTarjeta", StrTipoTarjeta, true, true, 285, 305, StrTipoTarjeta, true, true, 45)%>
        <%=MyUtil.ObjInput("Documento", "DocumentoNU", EVIP != null ? EVIP.getDocumentoNU() : "", true, true, 30, 345, "", true, true, 30)%>
        <%=MyUtil.ObjInput("Tel�fono", "TelNU", StrTelNU, true, true, 210, 345, StrTelNU, true, true, 40)%>
        <!--%=MyUtil.ObjInput("Correo Electr�nico", "CorreoNU", StrEmailComercialNU, true, true, 440, 345, StrEmailComercialNU, true, true, 40, "fnvalidaCorreo();")%-->

        <%=MyUtil.ObjInput("E-mail Comercial", "EmailComercialNU", StrEmailComercialNU, false, false, 540, 305, StrEmailComercialNU, false, false, 35)%>
        <%=MyUtil.ObjInput("E-mail Personal", "EmailPersonalNU", StrEmailPersonalNU, false, false, 835, 305, StrEmailPersonalNU, false, false, 35)%>
        <%=MyUtil.ObjInput("E-mail Alterno", "EmailAlternoNU", StrEmailAlternoNU, false, false, 540, 345, StrEmailAlternoNU, false, false, 35)%>
        <%=MyUtil.ObjInput("E-mail Otro", "EmailOtroNU", StrEmailOtroNU, false, false, 835, 345, StrEmailOtroNU, false, false, 35)%>
        <div style="position: absolute; z-index: 50; left: 740px; top: 282px;" class="FTable">
            <p><b>Enviar T�rminos<br>y Condiciones</b></p>
        </div>
        <div style="position: absolute; z-index: 50; left: 1035px; top: 282px;" class="FTable">
            <p><b>Enviar T�rminos<br>y Condiciones</b></p>
        </div>
        <%=MyUtil.ObjChkBox("", "EnviaTCC", "", true, true, 735, 302, "0", "SI", "NO", "fnVerificaMailCondicionado('EnviaTCC','EmailComercialNU');")%>    <!--    Envia Terminos y Condiciones Comercial, Personal, Alterno y Otro    -->
        <%=MyUtil.ObjChkBox("", "EnviaTCP", "", true, true, 1030, 302, "0", "SI", "NO", "fnVerificaMailCondicionado('EnviaTCP','EmailPersonalNU');")%>
        <%=MyUtil.ObjChkBox("", "EnviaTCA", "", true, true, 735, 343, "0", "SI", "NO", "fnVerificaMailCondicionado('EnviaTCA','EmailAlternoNU');")%>
        <%=MyUtil.ObjChkBox("", "EnviaTCO", "", true, true, 1030, 343, "0", "SI", "NO", "fnVerificaMailCondicionado('EnviaTCO','EmailOtroNU');")%>
        <%=MyUtil.ObjChkBox("Titular Viaja", "ViajaNU", EVIP != null ? EVIP.getViajaNU() : "", true, true, 540, 265, "1", "SI", "NO", "")%>
        <%=MyUtil.DoBlock("Datos de nuestro usuario", -60, -10)%>

        <!--    INFORMACION DE VUELO DE PARTIDA     -->
        <%=MyUtil.ObjComboC("Aerol�nea", "clAerolinea_I", EVIP != null ? EVIP.getDsAerolinea_I() : "", true, true, 30, 420, "", "select clAerolinea, dsAerolinea from CScAerolinea order by (2)", "", "", 5, false, false)%>
        <%=MyUtil.ObjInput("No. Vuelo", "NoVuelo_I", EVIP != null ? EVIP.getNumVuelo_I() : "", true, true, 240, 420, "", false, false, 10)%>
        <%=MyUtil.ObjInputF("Fecha de Vuelo (AAAA-MM-DD)", "FechaVuelo_I", EVIP != null ? EVIP.getFechaVuelo_I() : "", true, true, 30, 460, "", false, false, 20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaIniViajeMsk.value,this.name)};")%>
        <%=MyUtil.ObjInput("Horario", "Horario_I", EVIP != null ? EVIP.getHorario_I() : "", true, true, 240, 460, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Partiendo de:", "Origen_I", EVIP != null ? EVIP.getOrigen_I() : "", true, true, 30, 500, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Con destino a:", "Destino_I", EVIP != null ? EVIP.getDestino_I() : "", true, true, 240, 500, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones_I", EVIP != null ? EVIP.getObservaciones_I() : "", "60", "11", true, true, 30, 540, "", false, false)%>
        <div style="position: absolute; z-index: 50; left: 365px; top: 568px;" class="FTable">
            <img alt="Datos de Partida"  src="../../Imagenes/partida.png">
        </div>
        <div style="position: absolute; z-index: 50; left: 400px; top: 432px;" class="FTable">
            <p><b>Nombre Completo de Personas que Viajan</b></p>
        </div>
        <div onmouseover="return overlib('<b>TAL COMO APARECE EN SU DOCUMENTO.</b>', CENTER);" onmouseout="return nd();">
            <%=MyUtil.ObjInput("PAX 1", "NomPAX1_I", EVIP != null ? EVIP.getNomPAX1_I() : "", true, true, 400, 455, "", false, false, 40)%>
            <%=MyUtil.ObjInput("PAX 2", "NomPAX2_I", EVIP != null ? EVIP.getNomPAX2_I() : "", true, true, 400, 495, "", false, false, 40)%>
            <%=MyUtil.ObjInput("PAX 3", "NomPAX3_I", EVIP != null ? EVIP.getNomPAX3_I() : "", true, true, 400, 535, "", false, false, 40)%>
            <%=MyUtil.ObjInput("PAX 4", "NomPAX4_I", EVIP != null ? EVIP.getNomPAX4_I() : "", true, true, 400, 575, "", false, false, 40)%>
            <%=MyUtil.ObjInput("PAX 5", "NomPAX5_I", EVIP != null ? EVIP.getNomPAX5_I() : "", true, true, 400, 615, "", false, false, 40)%>
            <%=MyUtil.ObjInput("PAX 6", "NomPAX6_I", EVIP != null ? EVIP.getNomPAX6_I() : "", true, true, 400, 655, "", false, false, 40)%>
        </div>
        <%=MyUtil.ObjInput("Documento", "DocPAX1_I", EVIP != null ? EVIP.getDocPAX1_I() : "", true, true, 630, 455, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Documento", "DocPAX2_I", EVIP != null ? EVIP.getDocPAX2_I() : "", true, true, 630, 495, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Documento", "DocPAX3_I", EVIP != null ? EVIP.getDocPAX3_I() : "", true, true, 630, 535, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Documento", "DocPAX4_I", EVIP != null ? EVIP.getDocPAX4_I() : "", true, true, 630, 575, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Documento", "DocPAX5_I", EVIP != null ? EVIP.getDocPAX5_I() : "", true, true, 630, 615, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Documento", "DocPAX6_I", EVIP != null ? EVIP.getDocPAX5_I() : "", true, true, 630, 655, "", false, false, 20)%>
        <div style="position: absolute; z-index: 50; left: 765px; top: 430px;" class="FTable">
            <p><b>Menor a<br>2 a�os</b></p>
        </div>
        <%=MyUtil.ObjChkBox("", "MenorPAX1_I", EVIP != null ? EVIP.getMenorPAX1_I() : "", true, true, 755, 452, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjChkBox("", "MenorPAX2_I", EVIP != null ? EVIP.getMenorPAX2_I() : "", true, true, 755, 492, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjChkBox("", "MenorPAX3_I", EVIP != null ? EVIP.getMenorPAX3_I() : "", true, true, 755, 532, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjChkBox("", "MenorPAX4_I", EVIP != null ? EVIP.getMenorPAX4_I() : "", true, true, 755, 572, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjChkBox("", "MenorPAX5_I", EVIP != null ? EVIP.getMenorPAX5_I() : "", true, true, 755, 612, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjChkBox("", "MenorPAX6_I", EVIP != null ? EVIP.getMenorPAX6_I() : "", true, true, 755, 652, "0", "SI", "NO", "")%>
        <div style="position: absolute; z-index: 50; left: 830px; top: 430px;" class="FTable">
            <p><b>Tarjeta<br>Habiente</b></p>
        </div>
        <%=MyUtil.ObjChkBox("", "THABPAX1_I", EVIP != null ? EVIP.getTHABPAX1_I() : "", true, true, 820, 452, "0", "SI", "NO", "fnHabilitaBIN_I();")%>
        <%=MyUtil.ObjChkBox("", "THABPAX2_I", EVIP != null ? EVIP.getTHABPAX2_I() : "", true, true, 820, 492, "0", "SI", "NO", "fnHabilitaBIN_I();")%>
        <%=MyUtil.ObjChkBox("", "THABPAX3_I", EVIP != null ? EVIP.getTHABPAX3_I() : "", true, true, 820, 532, "0", "SI", "NO", "fnHabilitaBIN_I();")%>
        <%=MyUtil.ObjChkBox("", "THABPAX4_I", EVIP != null ? EVIP.getTHABPAX4_I() : "", true, true, 820, 572, "0", "SI", "NO", "fnHabilitaBIN_I();")%>
        <%=MyUtil.ObjChkBox("", "THABPAX5_I", EVIP != null ? EVIP.getTHABPAX5_I() : "", true, true, 820, 612, "0", "SI", "NO", "fnHabilitaBIN_I();")%>
        <%=MyUtil.ObjChkBox("", "THABPAX6_I", EVIP != null ? EVIP.getTHABPAX6_I() : "", true, true, 820, 652, "0", "SI", "NO", "fnHabilitaBIN_I();")%>

        <%=MyUtil.ObjInput("N�mero de BIN", "BinPAX1_I", EVIP != null ? EVIP.getBinPAX1_I() : "", true, true, 895, 455, "", false, false, 15, "VerificaNumerico(document.all.BinPAX1_I);")%>
        <%=MyUtil.ObjInput("N�mero de BIN", "BinPAX2_I", EVIP != null ? EVIP.getBinPAX2_I() : "", true, true, 895, 495, "", false, false, 15, "VerificaNumerico(document.all.BinPAX2_I);")%>
        <%=MyUtil.ObjInput("N�mero de BIN", "BinPAX3_I", EVIP != null ? EVIP.getBinPAX3_I() : "", true, true, 895, 535, "", false, false, 15, "VerificaNumerico(document.all.BinPAX3_I);")%>
        <%=MyUtil.ObjInput("N�mero de BIN", "BinPAX4_I", EVIP != null ? EVIP.getBinPAX4_I() : "", true, true, 895, 575, "", false, false, 15, "VerificaNumerico(document.all.BinPAX4_I);")%>
        <%=MyUtil.ObjInput("N�mero de BIN", "BinPAX5_I", EVIP != null ? EVIP.getBinPAX5_I() : "", true, true, 895, 615, "", false, false, 15, "VerificaNumerico(document.all.BinPAX5_I);")%>
        <%=MyUtil.ObjInput("N�mero de BIN", "BinPAX6_I", EVIP != null ? EVIP.getBinPAX6_I() : "", true, true, 895, 655, "", false, false, 15, "VerificaNumerico(document.all.BinPAX6_I);")%>
        <%=MyUtil.DoBlock("Informaci�n del Vuelo  <b>PARTIDA</b>", -85, -10)%>
        <!--    INFORMACION DE VUELO DE PARTIDA FIN    -->

        <!--    INFORMACION DE VUELO DE LLEGADA     -->
        <%=MyUtil.ObjComboC("Aerol�nea", "clAerolinea_R", EVIP != null ? EVIP.getDsAerolinea_R() : "", true, true, 30, 730, "", "select clAerolinea, dsAerolinea from CScAerolinea order by (2)", "", "", 5, false, false)%>
        <%=MyUtil.ObjInput("No. Vuelo", "NoVuelo_R", EVIP != null ? EVIP.getNumVuelo_R() : "", true, true, 240, 730, "", false, false, 10)%>
        <%=MyUtil.ObjInputF("Fecha de Vuelo (AAAA-MM-DD)", "FechaVuelo_R", EVIP != null ? EVIP.getFechaVuelo_R() : "", true, true, 30, 770, "", false, false, 20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaIniViajeMsk.value,this.name)};")%>
        <%=MyUtil.ObjInput("Horario", "Horario_R", EVIP != null ? EVIP.getHorario_R() : "", true, true, 240, 770, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Partiendo de:", "Origen_R", EVIP != null ? EVIP.getOrigen_R() : "", true, true, 30, 810, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Con destino a:", "Destino_R", EVIP != null ? EVIP.getDestino_R() : "", true, true, 240, 810, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones_R", EVIP != null ? EVIP.getObservaciones_R() : "", "60", "11", true, true, 30, 850, "", false, false)%>
        <div style="position: absolute; z-index: 70; left: 365px; top: 876px;" class="FTable">
            <img alt="Datos de Llegada"  src="../../Imagenes/llegada.png">
        </div>
        <div style="position: absolute; z-index: 70; left: 400px; top: 742px;" class="FTable">
            <p><b>Nombre Completo de Personas que Viajan</b></p>
        </div>
        <div onmouseover="return overlib('<b>TAL COMO APARECE EN SU DOCUMENTO.</b>', CENTER);" onmouseout="return nd();">
            <%=MyUtil.ObjInput("PAX 1", "NomPAX1_R", EVIP != null ? EVIP.getNomPAX1_R() : "", true, true, 400, 765, "", false, false, 40)%>
            <%=MyUtil.ObjInput("PAX 2", "NomPAX2_R", EVIP != null ? EVIP.getNomPAX2_R() : "", true, true, 400, 805, "", false, false, 40)%>
            <%=MyUtil.ObjInput("PAX 3", "NomPAX3_R", EVIP != null ? EVIP.getNomPAX3_R() : "", true, true, 400, 845, "", false, false, 40)%>
            <%=MyUtil.ObjInput("PAX 4", "NomPAX4_R", EVIP != null ? EVIP.getNomPAX4_R() : "", true, true, 400, 885, "", false, false, 40)%>
            <%=MyUtil.ObjInput("PAX 5", "NomPAX5_R", EVIP != null ? EVIP.getNomPAX5_R() : "", true, true, 400, 925, "", false, false, 40)%>
            <%=MyUtil.ObjInput("PAX 6", "NomPAX6_R", EVIP != null ? EVIP.getNomPAX6_R() : "", true, true, 400, 965, "", false, false, 40)%>
        </div>
        <%=MyUtil.ObjInput("Documento", "DocPAX1_R", EVIP != null ? EVIP.getDocPAX1_R() : "", true, true, 630, 765, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Documento", "DocPAX2_R", EVIP != null ? EVIP.getDocPAX2_R() : "", true, true, 630, 805, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Documento", "DocPAX3_R", EVIP != null ? EVIP.getDocPAX3_R() : "", true, true, 630, 845, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Documento", "DocPAX4_R", EVIP != null ? EVIP.getDocPAX4_R() : "", true, true, 630, 885, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Documento", "DocPAX5_R", EVIP != null ? EVIP.getDocPAX5_R() : "", true, true, 630, 925, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Documento", "DocPAX6_R", EVIP != null ? EVIP.getDocPAX6_R() : "", true, true, 630, 965, "", false, false, 20)%>
        <div style="position: absolute; z-index: 80; left: 765px; top: 740px;" class="FTable">
            <p><b>Menor a<br>2 a�os</b></p>
        </div>
        <%=MyUtil.ObjChkBox("", "MenorPAX1_R", EVIP != null ? EVIP.getMenorPAX1_R() : "", true, true, 755, 762, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjChkBox("", "MenorPAX2_R", EVIP != null ? EVIP.getMenorPAX2_R() : "", true, true, 755, 802, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjChkBox("", "MenorPAX3_R", EVIP != null ? EVIP.getMenorPAX3_R() : "", true, true, 755, 842, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjChkBox("", "MenorPAX4_R", EVIP != null ? EVIP.getMenorPAX4_R() : "", true, true, 755, 882, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjChkBox("", "MenorPAX5_R", EVIP != null ? EVIP.getMenorPAX5_R() : "", true, true, 755, 922, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjChkBox("", "MenorPAX6_R", EVIP != null ? EVIP.getMenorPAX6_R() : "", true, true, 755, 962, "0", "SI", "NO", "")%>
        <div style="position: absolute; z-index: 90; left: 830px; top: 740px;" class="FTable">
            <p><b>Tarjeta<br>Habiente</b></p>
        </div>
        <%=MyUtil.ObjChkBox("", "THABPAX1_R", EVIP != null ? EVIP.getTHABPAX1_R() : "", true, true, 820, 762, "0", "SI", "NO", "fnHabilitaBIN_R();")%>
        <%=MyUtil.ObjChkBox("", "THABPAX2_R", EVIP != null ? EVIP.getTHABPAX2_R() : "", true, true, 820, 802, "0", "SI", "NO", "fnHabilitaBIN_R();")%>
        <%=MyUtil.ObjChkBox("", "THABPAX3_R", EVIP != null ? EVIP.getTHABPAX3_R() : "", true, true, 820, 842, "0", "SI", "NO", "fnHabilitaBIN_R();")%>
        <%=MyUtil.ObjChkBox("", "THABPAX4_R", EVIP != null ? EVIP.getTHABPAX4_R() : "", true, true, 820, 882, "0", "SI", "NO", "fnHabilitaBIN_R();")%>
        <%=MyUtil.ObjChkBox("", "THABPAX5_R", EVIP != null ? EVIP.getTHABPAX5_R() : "", true, true, 820, 922, "0", "SI", "NO", "fnHabilitaBIN_R();")%>
        <%=MyUtil.ObjChkBox("", "THABPAX6_R", EVIP != null ? EVIP.getTHABPAX6_R() : "", true, true, 820, 962, "0", "SI", "NO", "fnHabilitaBIN_R();")%>
        <%=MyUtil.ObjInput("N�mero de BIN", "BinPAX1_R", EVIP != null ? EVIP.getBinPAX1_R() : "", true, true, 895, 765, "", false, false, 15, "VerificaNumerico(document.all.BinPAX1_R);")%>
        <%=MyUtil.ObjInput("N�mero de BIN", "BinPAX2_R", EVIP != null ? EVIP.getBinPAX2_R() : "", true, true, 895, 805, "", false, false, 15, "VerificaNumerico(document.all.BinPAX2_R);")%>
        <%=MyUtil.ObjInput("N�mero de BIN", "BinPAX3_R", EVIP != null ? EVIP.getBinPAX3_R() : "", true, true, 895, 845, "", false, false, 15, "VerificaNumerico(document.all.BinPAX3_R);")%>
        <%=MyUtil.ObjInput("N�mero de BIN", "BinPAX4_R", EVIP != null ? EVIP.getBinPAX4_R() : "", true, true, 895, 885, "", false, false, 15, "VerificaNumerico(document.all.BinPAX4_R);")%>
        <%=MyUtil.ObjInput("N�mero de BIN", "BinPAX5_R", EVIP != null ? EVIP.getBinPAX5_R() : "", true, true, 895, 925, "", false, false, 15, "VerificaNumerico(document.all.BinPAX5_R);")%>
        <%=MyUtil.ObjInput("N�mero de BIN", "BinPAX6_R", EVIP != null ? EVIP.getBinPAX6_R() : "", true, true, 895, 965, "", false, false, 15, "VerificaNumerico(document.all.BinPAX6_R);")%>
        <%=MyUtil.DoBlock("Informaci�n del Vuelo <b>LLEGADA</b>", -85, -10)%>
        <!--    INFORMACION DE VUELO DE LLEGADA FIN    -->

        <%=MyUtil.ObjChkBox("Estacionamiento", "Parking", EVIP != null ? EVIP.getParking() : "", true, true, 30, 1040, "0", "SI", "NO", "fnHabilitaAuto();")%>
        <%=MyUtil.ObjComboC("Marca de Auto", "CodigoMarca", EVIP != null ? EVIP.getDsMarcaAuto() : "", true, true, 170, 1040, "", " Select CodigoMarca, dsMarcaAuto from cMarcaAuto order by dsMarcaAuto", "fnLlenaTipoAutoAjax(this.value,'ClaveAMIS','Tipo de Auto','TipoAutoDiv','',2);", "", 50, false, false)%>
        <%=MyUtil.ObjComboCDiv("Tipo de Auto", "ClaveAMIS", EVIP != null ? EVIP.getDsTipoAuto() : "", true, true, 170, 1080, "", " Select ClaveAMIS, dsTipoAuto from cTipoAuto where CodigoMarca = '" + StrclMarcaAuto + "' order by dsTipoAuto", "", "", 50, false, false, "TipoAutoDiv")%>
        <%=MyUtil.ObjInput("Patente", "Patente", EVIP != null ? EVIP.getPatente() : "", true, true, 50, 1080, "", false, false, 8)%>
        <div onmouseover="return overlib('<b>INTRODUCE UNA BREVE DESCRIPCI�N DEL AUTO.</b>', CENTER);" onmouseout="return nd();">
            <%=MyUtil.ObjInput("Otro:", "OtroAuto", EVIP != null ? EVIP.getOtroAuto() : "", true, true, 30, 1120, "", false, false, 60)%>
        </div>
        <%=MyUtil.DoBlock("Estacionamiento", 0, -5)%>    

        <%=MyUtil.ObjComboC("Forma de Pago:", "clTipoPago", EVIP != null ? EVIP.getDsTipoPago() : "", true, true, 400, 1040, "", "select clTipoPago,dsTipoPago from CSTipoPago", "fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Nombre del Banco:", "NomBanco", EVIP != null ? EVIP.getNomBanco() : "", true, true, 580, 1040, "", false, false, 32)%>
        <%=MyUtil.ObjInput("Nombre en TC:", "NombreTC", EVIP != null ? EVIP.getNombreTC() : "", true, true, 770, 1040, "", false, false, 40)%>
        <%=MyUtil.ObjInput("N�mero de TC:", "NumeroTC", EVIP != null ? EVIP.getNumeroTC() : "", false, false, 400, 1080, "", false, false, 50, "if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        <%=MyUtil.ObjInput("Exp.D.:(MM/AA)", "ExpiraVTR", EVIP != null ? EVIP.getExpira() : "", false, false, 680, 1080, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
        <input type="hidden" name="Expira" id="Expira" value= "<%=EVIP != null ? EVIP.getExpira().trim() : ""%>">
        <%=MyUtil.ObjInput("Sec.C.:", "SecC", EVIP != null ? EVIP.getSecC() : "", false, false, 780, 1080, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>

        <%=MyUtil.ObjInput("Confirmo", "Confirmo", EVIP != null ? EVIP.getConfirmo() : "", true, true, 400, 1120, "", false, false, 30)%>
        <%=MyUtil.ObjInput("No.Conf.:", "NConfirmo", EVIP != null ? EVIP.getNConfirmo() : "", true, true, 580, 1120, "", false, false, 20)%>

        <%=MyUtil.ObjInput("Pol. Cancelaci�n", "PCancel", EVIP != null ? EVIP.getPCancel() : "", true, true, 710, 1120, "", false, false, 30)%>
        <%=MyUtil.ObjChkBox("N/U inf.:", "NuInf", EVIP != null ? EVIP.getNuInf() : "", true, true, 890, 1118, "", "SI", "NO", "")%>
        <%=MyUtil.ObjTextArea("Domicilio del Tarjetahabiente (m�x. 500 caracteres)", "DomFiscal", EVIP != null ? EVIP.getDomFiscal() : "", "80", "8", true, true, 400, 1160, "", false, false)%>
        <%=MyUtil.DoBlock("Datos de Facturaci�n", -80, 80)%>

        <input name='FechaIniViajeMsk' id='FechaIniViajeMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>

        <%@ include file="csVentanaFlotante.jspf" %>
        <%
            StrclAsistencia = null;
            daos = null;
            EVIP = null;
            EPREV = null;

            daosg = null;
            conciergeg = null;

            daoRef = null;
            ref = null;
        %>
        <%=MyUtil.GeneraScripts()%>
        <script type="text/javascript" >
            document.all.BinPAX1_I.disabled = true;
            document.all.BinPAX2_I.disabled = true;
            document.all.BinPAX3_I.disabled = true;
            document.all.BinPAX4_I.disabled = true;
            document.all.BinPAX5_I.disabled = true;
            document.all.BinPAX6_I.disabled = true;

            document.all.BinPAX1_R.disabled = true;
            document.all.BinPAX2_R.disabled = true;
            document.all.BinPAX3_R.disabled = true;
            document.all.BinPAX4_R.disabled = true;
            document.all.BinPAX5_R.disabled = true;
            document.all.BinPAX6_R.disabled = true;

            top.document.all.DatosExpediente.src = "Operacion/Concierge/CSDatosConcierge.jsp";
            top.document.all.rightPO.rows = "0,80,*";

            fnNewBitacora(2);

            function fnVerificaMailCondicionado(Activo, Correo) {
                if (document.all[Activo].value == 1) {
                    if (document.all[Correo].value == '') {
                        document.all[Activo].value = 0;   //  NO SE REMUEVE EL CHECK PERO SE ASIGNA EL VALOR INTERNAMENTE.
                        alert('Direcci�n no v�lida para envio de T�rminos y Condiciones. Debe ingresar un email desde el Perfil del Usuario.');
                    }
                }
            }

            function fnHabilitaBIN_I() {
                if (document.all.THABPAX1_I.value == 1) {
                    document.all.BinPAX1_I.disabled = false;
                } else {
                    document.all.BinPAX1_I.disabled = true;
                    document.all.BinPAX1_I.value = '';
                }
                if (document.all.THABPAX2_I.value == 1) {
                    document.all.BinPAX2_I.disabled = false;
                } else {
                    document.all.BinPAX2_I.disabled = true;
                    document.all.BinPAX2_I.value = '';
                }
                if (document.all.THABPAX3_I.value == 1) {
                    document.all.BinPAX3_I.disabled = false;
                } else {
                    document.all.BinPAX3_I.disabled = true;
                    document.all.BinPAX3_I.value = '';
                }
                if (document.all.THABPAX4_I.value == 1) {
                    document.all.BinPAX4_I.disabled = false;
                } else {
                    document.all.BinPAX4_I.disabled = true;
                    document.all.BinPAX4_I.value = '';
                }
                if (document.all.THABPAX5_I.value == 1) {
                    document.all.BinPAX5_I.disabled = false;
                } else {
                    document.all.BinPAX5_I.disabled = true;
                    document.all.BinPAX5_I.value = '';
                }
                if (document.all.THABPAX6_I.value == 1) {
                    document.all.BinPAX6_I.disabled = false;
                } else {
                    document.all.BinPAX6_I.disabled = true;
                    document.all.BinPAX6_I.value = '';
                }
            }

            function fnHabilitaBIN_R() {
                if (document.all.THABPAX1_R.value == 1) {
                    document.all.BinPAX1_R.disabled = false;
                } else {
                    document.all.BinPAX1_R.disabled = true;
                    document.all.BinPAX1_R.value = '';
                }
                if (document.all.THABPAX2_R.value == 1) {
                    document.all.BinPAX2_R.disabled = false;
                } else {
                    document.all.BinPAX2_R.disabled = true;
                    document.all.BinPAX2_R.value = '';
                }
                if (document.all.THABPAX3_R.value == 1) {
                    document.all.BinPAX3_R.disabled = false;
                } else {
                    document.all.BinPAX3_R.disabled = true;
                    document.all.BinPAX3_R.value = '';
                }
                if (document.all.THABPAX4_R.value == 1) {
                    document.all.BinPAX4_R.disabled = false;
                } else {
                    document.all.BinPAX4_R.disabled = true;
                    document.all.BinPAX4_R.value = '';
                }
                if (document.all.THABPAX5_R.value == 1) {
                    document.all.BinPAX5_R.disabled = false;
                } else {
                    document.all.BinPAX5_R.disabled = true;
                    document.all.BinPAX5_R.value = '';
                }
                if (document.all.THABPAX6_R.value == 1) {
                    document.all.BinPAX6_R.disabled = false;
                } else {
                    document.all.BinPAX6_R.disabled = true;
                    document.all.BinPAX6_R.value = '';
                }
            }

            function fnHabilitaAuto() {
                if (document.all.Parking.value == 1) {
                    document.all.CodigoMarcaC.disabled = false;
                    document.all.ClaveAMISC.disabled = false;
                    document.all.Patente.disabled = false;
                    document.all.OtroAuto.disabled = false;
                } else {
                    document.all.CodigoMarcaC.disabled = true;
                    document.all.ClaveAMISC.disabled = true;
                    document.all.Patente.disabled = true;
                    document.all.OtroAuto.disabled = true;

                    document.all.CodigoMarca.value = '';
                    document.all.CodigoMarcaC.value = '';

                    document.all.ClaveAMISC.value = '';
                    document.all.ClaveAMISC.value = '';

                    document.all.Patente.value = '';
                    document.all.OtroAuto.value = '';
                }
            }

            function fnAccionesAlta() {
                if (document.all.Action.value == 1) {
                    document.all.AceptaCheck.disabled = false;
                    var pstrCadena = "../../Utilerias/RegresaFechaActual.jsp";
                    window.open(pstrCadena, 'newWin', 'width=10,height=10,left=1500,top=2000');
                } else {
                    document.all.AceptaCheck.disabled = true;
                }
            }

            function fnActualizaFechaActual(pFecha) {
                document.all.FechaApAsist.value = pFecha;
            }

            //funci�n antes de guardar
            function fnAntesGuardar() {
                if (document.all.Action.value == 1) {
                    if (document.all.AvisoPrivacidad.value == 1) {
                        if (document.all.EnviaTCC.value == '1' || document.all.EnviaTCP.value == '1' || document.all.EnviaTCA.value == '1' || document.all.EnviaTCO.value == '1' || document.all.EnviaTCX1.value == '1') {
                            alert("Se enviar�n T�rminos y Condiciones a las direcciones seleccionadas.");
                        }
                        fnPregunta(document.all.clConcierge.value, document.all.clSubservicio.value, document.all.clStrURL.value, document.all.clStrNomPag.value);
                    } else {
                        msgVal = msgVal + " El usuario debe aceptar los T�rminos y Condiciones para poder guardar la Asistencia.";
                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    }
                }

                if (document.all.Action.value == 2) {
                    if (document.all.EnviaTCC.value == '1' || document.all.EnviaTCP.value == '1' || document.all.EnviaTCA.value == '1' || document.all.EnviaTCO.value == '1' || document.all.EnviaTCX1.value == '1') {
                        fnEnviaCondicionado();
                    }
                    fnPregunta(document.all.clConcierge.value, document.all.clSubservicio.value, document.all.clStrURL.value, document.all.clStrNomPag.value);
                }
            }

            function isInteger(s) {
                var i;
                if (isEmpty(s))
                    if (isInteger.arguments.length == 1)
                        return 0;
                    else
                        return (isInteger.arguments[1] == true);
                for (i = 0; i < s.length; i++) {
                    var c = s.charAt(i);
                    if (!isDigit(c))
                        return false;
                }
                return true;
            }

            function isEmpty(s) {
                return ((s == null) || (s.length == 0))
            }

            function isDigit(c) {
                return ((c >= "0") && (c <= "9"))
            }

            function VerificaNumerico(Campo) {
                if (isNaN(Campo.value) == true) {
                    alert('El dato debe ser num�rico, favor de verificar.');
                    Campo.focus();
                }
            }

            function fnEnviaCondicionado() {
                if (document.all.AsistenciaVTR.value == "") {
                    alert("Para poder enviar los T�rminos y Condiciones, primero debes guardar la Asistencia.")
                } else {
                    if (document.all.EnviaTCC.value == '1' || document.all.EnviaTCP.value == '1' || document.all.EnviaTCA.value == '1' || document.all.EnviaTCO.value == '1' || document.all.EnviaTCX1.value == '1') {
                        var Resp = confirm("�Deseas enviar los T�rminos y Condiciones?")
                        if (Resp) {
                            var pstrCadena = "EnvioCondicionado.jsp?clAsistencia=" + document.all.clAsistencia.value +
                                    "&ETCC=" + document.all.EnviaTCC.value + "&ETCP=" + document.all.EnviaTCP.value +
                                    "&ETCA=" + document.all.EnviaTCA.value + "&ETCO=" + document.all.EnviaTCO.value +
                                    "&ETCX1=" + document.all.EnviaTCX1.value;
                            window.open(pstrCadena, 'newWin', 'width=100,height=100');
                        }
                    } else {
                        alert('Debes seleccionar un email v�lido.');
                    }
                }
            }

            function fnValidaEnvio(Mensaje) {
                //alert("Mensaje: "+Mensaje);
                if (Mensaje == 1) {
                    alert("Se ha programado exitosamente el env�o de T�rminos y Condiciones.");
                }
                if (Mensaje == 2) {
                    alert("Se encontr� un problema al registrar el envio. Favor de contactar a su Administrador.");
                }
            }

            function fnRevisaTerminos() {
                if (document.all.AceptaCheck.checked) {
                    document.all.AvisoPrivacidad.value = '1';
                } else {
                    document.all.AvisoPrivacidad.value = '0';
                }
            }
        </script>
        <script type="text/javascript">
            initFloatingWindowWithTabs('window4', Array('Nuestro Usuario', 'Referencia'), 350, 250, 700, 20, false, false, true, true, false);
        </script>
    </body>
</html>