<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOCSSchengenLetter,com.ike.concierge.to.CSSchengenLetter,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>

<html>
    <head>
        <title>Schengen Letter</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="../../Utilerias/overlib.js"></script>
        <script>
            overlib_pagedefaults(WIDTH, 250, FGCOLOR, '#BED2EA', BGCOLOR, 'blue', TEXTFONT, "Arial, Helvetica, Verdana", TEXTSIZE, ".8em");
        </script>
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <script src='../../Utilerias/UtilCalendarioV.js'></script>
        <script src='../../Utilerias/UtilStore.js'></script>

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i>Schengen Letter</i></b></font><br></p></div>
        <div class='VTable' style='position:absolute; z-index:25; left:570px; top:93px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Autom�tica</i></b></font><br></p></div>
                        <%
                            String StrclConcierge = "";
                            String StrclSubservicio = "";
                            String StrclAsistencia = "0";
                            String strclUsr = "";
                            String StrURL = "";
                            String StrNomPag = "";
                            String StrclPaginaWeb = "1443";
                            String StrPreguntaEncuesta = "0";
                            String StrNombreBanco = "";
                            String StrNumeroBin = "";
                            String StrTipoTarjeta = "";
                            String StrNombreNU = "";
                            String StrTelefono = "";
                            String StrTelefono2 = "";
                            String StrEmail = "";
                            String StrEmailP = "";
                            String StrEmailA = "";
                            String StrEmailO = "";
                            String StrEmailAsis = "";
                            String StrEmail2Asis = "";

                            if (request.getRequestURL() != null) {
                                StrURL = request.getRequestURL().toString();
                                StrNomPag = StrURL.substring(StrURL.lastIndexOf("/") + 1);
                            }

                            DAOCSSchengenLetter daos = null;
                            CSSchengenLetter SchengenLetter = null;
                            CSSchengenLetter SchengenDatPre = null;

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
                            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

                            if (strclUsr != null) {
                                daos = new DAOCSSchengenLetter();
                                SchengenLetter = daos.getCSSchengenLetter(StrclAsistencia);
                                SchengenDatPre = daos.getCSSchengenDatPrev(StrclConcierge);
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

                            if (SchengenLetter != null) {
                                StrNombreBanco = SchengenLetter != null ? SchengenLetter.getBanco().trim() : "";
                                StrNumeroBin = SchengenLetter != null ? SchengenLetter.getNumeroBin().trim() : "";
                                StrTipoTarjeta = SchengenLetter != null ? SchengenLetter.getTipoTarjeta().trim() : "";
                                StrNombreNU = SchengenLetter != null ? SchengenLetter.getNuestroUsuario().trim() : "";
                                StrTelefono = SchengenLetter != null ? SchengenLetter.getTelefono().trim() : "";
                                StrTelefono2 = SchengenLetter != null ? SchengenLetter.getTelefono2().trim() : "";
                                StrEmail = SchengenLetter != null ? SchengenLetter.getEmailC().trim() : "";
                                StrEmailP = SchengenLetter != null ? SchengenLetter.getEmailP().trim() : "";
                                StrEmailA = SchengenLetter != null ? SchengenLetter.getEmailA().trim() : "";
                                StrEmailO = SchengenLetter != null ? SchengenLetter.getEmailO().trim() : "";
                                StrEmailAsis = SchengenLetter != null ? SchengenLetter.getEmailAsis().trim() : "";
                                StrEmail2Asis = SchengenLetter != null ? SchengenLetter.getEmailAsis2().trim() : "";
                            } else {
                                StrNombreBanco = SchengenDatPre != null ? SchengenDatPre.getBanco().trim() : "";
                                StrNumeroBin = SchengenDatPre != null ? SchengenDatPre.getNumeroBin().trim() : "";
                                StrTipoTarjeta = SchengenDatPre != null ? SchengenDatPre.getTipoTarjeta().trim() : "";
                                StrNombreNU = SchengenDatPre != null ? SchengenDatPre.getNuestroUsuario().trim() : "";
                                StrTelefono = SchengenDatPre != null ? SchengenDatPre.getTelefono().trim() : "";
                                StrTelefono2 = SchengenDatPre != null ? SchengenDatPre.getTelefono2().trim() : "";
                                StrEmail = SchengenDatPre != null ? SchengenDatPre.getEmailC().trim() : "";
                                StrEmailP = SchengenDatPre != null ? SchengenDatPre.getEmailP().trim() : "";
                                StrEmailA = SchengenDatPre != null ? SchengenDatPre.getEmailA().trim() : "";
                                StrEmailO = SchengenDatPre != null ? SchengenDatPre.getEmailO().trim() : "";
                                StrEmailAsis = SchengenDatPre != null ? SchengenDatPre.getEmailAsis().trim() : "";
                                StrEmail2Asis = SchengenDatPre != null ? SchengenDatPre.getEmailAsis2().trim() : "";
                            }

                            //<<<<<<<<<<<< Servlet Generico >>>>>>>>>>>
                            String Store = "";
                            Store = "st_GuardaCSSchengenLetter,st_ActualizaCSSchengenLetter";
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

                        %><script>fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(strclUsr));%>

        <%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "fnAccionesAlta();fnValidaCorreos();fnArmaMailsContacto();", "fnValidaCorreos()", "fnArmaMailsContacto();fnAntesGuardar();fnsp_Guarda();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>'>
        <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
        <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
        <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
        <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
        <input id="Secuencia" name="Secuencia" type="hidden" value="">
        <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="clPais,EmailA,EmailAsis,Email2Asis,Email,EmailO,EmailP,FechaIniViaje,Telefono,Telefono2,NombreEsposa,NombresHijos,clUsrApp,NombreBanco,NumeroBin,NombreNU,TipoTarjeta,clConcierge,FechaApAsist,DescripcionEvento,MailContacto,EmailC_Env,EmailP_Env,EmailA_Env,EmailO_Env,EmailAsis_Env,EmailAsis2_Env">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clAsistencia,clPais,EmailA,EmailAsis,Email2Asis,Email,EmailO,EmailP,FechaIniViaje,Telefono,Telefono2,NombreEsposa,NombresHijos,clUsrApp,NombreBanco,NumeroBin,NombreNU,TipoTarjeta,clConcierge,FechaApAsist,DescripcionEvento,clEstatus,MailContacto,EmailC_Env,EmailP_Env,EmailA_Env,EmailO_Env,EmailAsis_Env,EmailAsis2_Env">
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>
        <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>

        <div class='VTable' id="btnGeneraCarta" style="position:absolute; z-index:25; left:600px; top:20px;">
            <input class='cBtn' type='button' value='Generar Carta' onClick="window.open('../VistaPDF.jsp?clPDFxPaginaWeb=9', '', 'resizable=no,menubar=0,status=0,toolbar=0,height=930,width=660,screenX=0,screenY=0');">
        </div>

        <input id="MailContacto" name="MailContacto" type="hidden" value="">

        <%String strEstatus = SchengenLetter != null ? SchengenLetter.getDsEstatus() : "";%>
        <%=MyUtil.ObjComboC("Estatus", "clEstatus", SchengenLetter != null ? SchengenLetter.getDsEstatus() : "", false, false, 30, 80, "0", "sp_GetCSstatus", "", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Asistencia", "AsistenciaVTR", StrclAsistenciaVTR, false, false, 350, 80, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Descripci�n del evento", "DescripcionEvento", SchengenLetter != null ? SchengenLetter.getDescipcion().trim() : "", "83", "3", true, true, 30, 120, "", true, true)%>
        <%=MyUtil.ObjInput("Fecha de apertura", "FechaRegistro", SchengenLetter != null ? SchengenLetter.getFechaRegAsist() : "", false, false, 650, 80, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Datos Generales del Evento", 10, 10)%>

        <%=MyUtil.ObjInput("Nombre del Banco", "NombreBanco", StrNombreBanco, true, true, 30, 240, StrNombreBanco, true, true, 45)%>
        <%=MyUtil.ObjInput("N�mero de BIN", "NumeroBin", StrNumeroBin, true, true, 30, 280, StrNumeroBin, true, true, 45)%>
        <%=MyUtil.ObjInput("Tipo de tarjeta", "TipoTarjeta", StrTipoTarjeta, true, true, 300, 320, StrTipoTarjeta, true, true, 45)%>
        <div onmouseover="return overlib('NOMBRE COMPLETO COMO CONSTA EN EL PASAPORTE', CENTER);" onmouseout="return nd();">
            <%=MyUtil.ObjInput("Nombre de nuestro usuario", "NombreNU", StrNombreNU, true, true, 30, 320, StrNombreNU, true, true, 45)%>
        </div>
        <%=MyUtil.DoBlock("Datos de nuestro usuario", 80, 5)%>

        <div onmouseover="return overlib('NOMBRE COMPLETO COMO CONSTA EN EL PASAPORTE', CENTER);" onmouseout="return nd();">
            <%=MyUtil.ObjInput("Nombre  esposa(o)", "NombreEsposa", SchengenLetter != null ? SchengenLetter.getNombreConyuge().trim() : "", true, true, 600, 240, "", false, false, 45)%>
        </div>
        <div onmouseover="return overlib('NOMBRE COMPLETO DE LOS DEPENDIENTES COMO CONSTA EN EL PASAPORTE Y FECHA DE NACIMIENTO', CENTER);" onmouseout="return nd();">
            <%=MyUtil.ObjTextArea("Nombre(s)  hijo(s)", "NombresHijos", SchengenLetter != null ? SchengenLetter.getNombresHijos().trim() : "", "50", "5", true, true, 600, 280, "", false, false)%>
        </div>
        <%=MyUtil.ObjInputF("Fecha de inicio del viaje (AAAA-MM-DD)", "FechaIniViaje", SchengenLetter != null ? SchengenLetter.getFechaIniViaje().trim() : "", true, true, 600, 360, "", true, true, 20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaIniViajeMsk.value,this.name)};")%>
        <%=MyUtil.ObjComboC("Pa�s de destino", "clPais", SchengenLetter != null ? SchengenLetter.getDsPais().trim() : "", true, true, 600, 400, "", "select clPais, rtrim(dsPais) 'dsPais' from cPais where Schengen = 1", "", "", 5, true, true)%>
        <%=MyUtil.DoBlock("Datos del Viaje", 80, 5)%>

        <%=MyUtil.ObjInput("Tel�fono", "Telefono", StrTelefono, true, true, 30, 420, StrTelefono, false, false, 30)%>
        <%=MyUtil.ObjInput("Celular", "Telefono2", StrTelefono2, true, true, 300, 420, StrTelefono2, false, false, 30)%>
        <%=MyUtil.ObjInput("E-mail Comercial", "Email", StrEmail, true, true, 30, 460, StrEmail, false, false, 45, "fnValidaCorreos();")%>
        <p style="position:absolute; z-index:101; left:300px; top:460px;" class="VTable">NOTIFICAR POR EMAIL</p>
        <%=MyUtil.ObjChkBox("", "EmailC_Env", SchengenLetter != null ? SchengenLetter.getEmailC_Env().trim() : "", true, true, 350, 460, "0", "SI", "NO", "fnValidaCorreos();")%>
        <%=MyUtil.ObjInput("E-mail Personal", "EmailP", StrEmailP, true, true, 30, 500, StrEmailP, false, false, 45, "fnValidaCorreos();")%>
        <%=MyUtil.ObjChkBox("", "EmailP_Env", SchengenLetter != null ? SchengenLetter.getEmailP_Env().trim() : "", true, true, 350, 500, "0", "SI", "NO", "fnValidaCorreos();")%>
        <%=MyUtil.ObjInput("E-mail Alternativo", "EmailA", StrEmailA, true, true, 30, 540, StrEmailA, false, false, 45, "fnValidaCorreos();")%>
        <%=MyUtil.ObjChkBox("", "EmailA_Env", SchengenLetter != null ? SchengenLetter.getEmailA_Env().trim() : "", true, true, 350, 540, "0", "SI", "NO", "fnValidaCorreos();")%>
        <%=MyUtil.ObjInput("E-mail Otro", "EmailO", StrEmailO, true, true, 30, 580, StrEmailO, false, false, 45, "fnValidaCorreos();")%>
        <%=MyUtil.ObjChkBox("", "EmailO_Env", SchengenLetter != null ? SchengenLetter.getEmailO_Env().trim() : "", true, true, 350, 580, "0", "SI", "NO", "fnValidaCorreos();")%>
        <%=MyUtil.ObjInput("E-mail Asistente", "EmailAsis", StrEmailAsis, true, true, 30, 620, StrEmailAsis, false, false, 45, "fnValidaCorreos();")%>
        <%=MyUtil.ObjChkBox("", "EmailAsis_Env", SchengenLetter != null ? SchengenLetter.getEmailAsis_Env().trim() : "", true, true, 350, 620, "0", "SI", "NO", "fnValidaCorreos();")%>
        <%=MyUtil.ObjInput("E-mail Asistente alternativo", "Email2Asis", StrEmail2Asis, true, true, 30, 660, StrEmail2Asis, false, false, 45, "fnValidaCorreos();")%>
        <%=MyUtil.ObjChkBox("", "EmailAsis2_Env", SchengenLetter != null ? SchengenLetter.getEmailAsis2_Env().trim() : "", true, true, 350, 660, "0", "SI", "NO", "fnValidaCorreos();")%>
        <%=MyUtil.DoBlock("Datos para el contacto de nuestro usuario", 10, 5)%>

        <input name='FechaIniViajeMsk' id='FechaIniViajeMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>

        <%@ include file="csVentanaFlotante.jspf" %>
        <%
            StrclAsistencia = null;
            daos = null;
            SchengenLetter = null;
            daosg = null;
            conciergeg = null;
            daoRef = null;
            ref = null;
        %>
        <%=MyUtil.GeneraScripts()%>
        <script>
            top.document.all.DatosExpediente.src = "Operacion/Concierge/CSDatosConcierge.jsp";
            top.document.all.rightPO.rows = "0,80,*";

            fnNewBitacora(2);

            function fnAccionesAlta() {
                if (document.all.Action.value == 1) {
                    var pstrCadena = "../../Utilerias/RegresaFechaActual.jsp";
                    window.open(pstrCadena, 'newWin', 'width=10,height=10,left=1500,top=2000');
                }
            }

            function fnActualizaFechaActual(pFecha) {
                document.all.FechaApAsist.value = pFecha;
            }

            //funci�n antes de guardar
            function fnAntesGuardar() {
                fnPregunta(document.all.clConcierge.value, document.all.clSubservicio.value, document.all.clStrURL.value, document.all.clStrNomPag.value);

                if (document.all.Email.value == '' && document.all.EmailP.value == '' &&
                        document.all.EmailA.value == '' && document.all.EmailO.value == '' &&
                        document.all.EmailAsis.value == '' && document.all.Email2Asis.value == '') {
                    msgVal = msgVal + " Debe informar por lo menos una direcci�n de email.";
                    //alert('Debe informar por lo menos un correo.');
                    document.all.btnGuarda.disabled = false;
                    document.all.btnCancela.disabled = false;
                }
            }

            function fnValidaCorreos() {
                if (document.all.Email.value == '') {
                    document.all.EmailC_EnvC.disabled = true;
                    document.all.EmailC_EnvC.checked = false;
                } else {
                    document.all.EmailC_EnvC.disabled = false;
                }

                if (document.all.EmailP.value == '') {
                    document.all.EmailP_EnvC.disabled = true;
                    document.all.EmailP_EnvC.checked = false;
                } else {
                    document.all.EmailP_EnvC.disabled = false;
                }

                if (document.all.EmailA.value == '') {
                    document.all.EmailA_EnvC.disabled = true;
                    document.all.EmailA_EnvC.checked = false;
                } else {
                    document.all.EmailA_EnvC.disabled = false;
                }

                if (document.all.EmailO.value == '') {
                    document.all.EmailO_EnvC.disabled = true;
                    document.all.EmailO_EnvC.checked = false;
                } else {
                    document.all.EmailO_EnvC.disabled = false;
                }

                if (document.all.EmailAsis.value == '') {
                    document.all.EmailAsis_EnvC.disabled = true;
                    document.all.EmailAsis_EnvC.checked = false;
                } else {
                    document.all.EmailAsis_EnvC.disabled = false;
                }

                if (document.all.Email2Asis.value == '') {
                    document.all.EmailAsis2_EnvC.disabled = true;
                    document.all.EmailAsis2_EnvC.checked = false;
                } else {
                    document.all.EmailAsis2_EnvC.disabled = false;
                }
            }

            function fnArmaMailsContacto() {
                if (document.all.EmailC_EnvC.checked != false) {
                    if (document.all.MailContacto.value != '') {
                        document.all.EmailC_Env.value = 1;
                        document.all.MailContacto.value = document.all.MailContacto.value + ',' + document.all.Email.value;
                    } else {
                        document.all.EmailC_Env.value = 1;
                        document.all.MailContacto.value = document.all.Email.value;
                    }
                } else {
                    document.all.EmailC_Env.value = 0;
                }

                if (document.all.EmailP_EnvC.checked != false) {
                    if (document.all.MailContacto.value != '') {
                        document.all.EmailP_Env.value = 1;
                        document.all.MailContacto.value = document.all.MailContacto.value + ',' + document.all.EmailP.value;
                    } else {
                        document.all.EmailP_Env.value = 1;
                        document.all.MailContacto.value = document.all.EmailP.value;
                    }
                } else {
                    document.all.EmailP_Env.value = 0;
                }

                if (document.all.EmailA_EnvC.checked != false) {
                    if (document.all.MailContacto.value != '') {
                        document.all.EmailA_Env.value = 1;
                        document.all.MailContacto.value = document.all.MailContacto.value + ',' + document.all.EmailA.value;
                    } else {
                        document.all.EmailA_Env.value = 1;
                        document.all.MailContacto.value = document.all.EmailA.value;
                    }
                } else {
                    document.all.EmailA_Env.value = 0;
                }

                if (document.all.EmailO_EnvC.checked != false) {
                    if (document.all.MailContacto.value != '') {
                        document.all.EmailO_Env.value = 1;
                        document.all.MailContacto.value = document.all.MailContacto.value + ',' + document.all.EmailO.value;
                    } else {
                        document.all.EmailO_Env.value = 1;
                        document.all.MailContacto.value = document.all.EmailO.value;
                    }
                } else {
                    document.all.EmailO_Env.value = 0;
                }

                if (document.all.EmailAsis_EnvC.checked != false) {
                    if (document.all.MailContacto.value != '') {
                        document.all.EmailAsis_Env.value = 1;
                        document.all.MailContacto.value = document.all.MailContacto.value + ',' + document.all.EmailAsis.value;
                    } else {
                        document.all.EmailAsis_Env.value = 1;
                        document.all.MailContacto.value = document.all.EmailAsis.value;
                    }
                } else {
                    document.all.EmailAsis_Env.value = 0;
                }

                if (document.all.EmailAsis2_EnvC.checked != false) {
                    if (document.all.MailContacto.value != '') {
                        document.all.EmailAsis2_Env.value = 1;
                        document.all.MailContacto.value = document.all.MailContacto.value + ',' + document.all.Email2Asis.value;
                    } else {
                        document.all.EmailAsis2_Env.value = 1;
                        document.all.MailContacto.value = document.all.Email2Asis.value;
                    }
                } else {
                    document.all.EmailAsis2_Env.value = 0;
                }
                return;
            }

            function fnCompruebaEmails() {
                if (document.all.Email.value == '' || document.all.EmailP.value == '' ||
                        document.all.EmailA.value == '' || document.all.EmailO.value == '' ||
                        document.all.EmailAsis.value == '' || document.all.Email2Asis.value == '') {
                    msgVal = msgVal + " Debe informar por lo menos una direcci�n de email.";
                    //alert('Deve informar pelo menos um endere�o de e-mail.');
                }
            }

        </script>
        <script type="text/javascript">
            initFloatingWindowWithTabs('window4', Array('Nuestro Usuario', 'Referencia'), 350, 250, 700, 20, false, false, true, true, false);
        </script>
    </body>
</html>
