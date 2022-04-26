<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist,java.sql.ResultSet,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>

<html>
    <head>
        <title>Warm Transfer</title>
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
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Warm Transfer </i></b></font><br></p></div>
        <script src='../../Utilerias/UtilCalendario.js'></script>
        <script src='../../Utilerias/UtilStore.js'></script>

        <div class='VTable' style='position:absolute; z-index:25; left:570px; top:93px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Autom�tica </i></b></font><br> </p></div>
                <%
                        String StrclConcierge = "";
                        String StrclSubservicio = "";
                        String StrclAsistencia = "0";
                        String strclUsr = "";
                        String StrURL = "";
                        String StrNomPag = "";
                        String StrclPaginaWeb = "1431";
                        String StrPreguntaEncuesta = "1";
                        String strEstatus = "";

                        if (request.getRequestURL() != null) {
                            StrURL = request.getRequestURL().toString();
                            StrNomPag = StrURL.substring(StrURL.lastIndexOf("/") + 1);
                        }

                        DAOReferenciasxAsist daoRef = null;
                        ReferenciasxAsist ref = null;

                        DAOConciergeG daosg = null;
                        ConciergeG conciergeg = null;

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
                            daoRef = new DAOReferenciasxAsist();
                            ref = daoRef.getclAsistencia(StrclAsistencia);
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

                        //<<<<<<<<<<<< Servlet Generico >>>>>>>>>>>
                        String Store = "";
                        Store = "st_GuardaWarmTransfer,st_ActualizaCSWarmTransfer";
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
                        //-----------------------------------------------------

                %><script>fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(strclUsr));%>

        <%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "fnAccionesAlta();", "fnAntesGuarda();fnsp_Guarda();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>'>
        <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
        <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
        <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
        <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>

        <input id="Secuencia" name="Secuencia" type="hidden" value=""><br>
        <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="clConcierge,FechaApAsist,clUsrApp,DescripcionEvento,Contacto,clCallCenter,clTelCallCenter,Agente,OtroCallCenter">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clAsistencia,DescripcionEvento,Contacto,clCallCenter,clTelCallCenter,Agente,OtroCallCenter,clEstatus">

        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>
        <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>

        <%
                StringBuffer StrSql = new StringBuffer();
                StrSql.append(" st_getCSWarmTransfer '").append(StrclAsistencia).append("'");
                ResultSet rsAsist = UtileriasBDF.rsSQLNP(StrSql.toString());

                if (rsAsist.next()) {%>
        <%=MyUtil.ObjComboC("Estatus", "clEstatus", rsAsist.getString("dsEstatus"), false, false, 30, 80, "0", "sp_GetCSstatus", "", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Asistencia", "AsistenciaVTR", rsAsist.getString("clAsistencia"), false, false, 350, 80, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Descripci�n del Evento", "DescripcionEvento", rsAsist.getString("Descripcion"), "83", "3", true, true, 30, 120, "", true, true)%>
        <%=MyUtil.ObjInput("Fecha de Apertura", "FechaRegistro", rsAsist.getString("FechaRegistro"), false, false, 650, 80, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Datos Generales del Evento", 10, 10)%>

        <%=MyUtil.ObjInput("Tel�fono Contacto", "Contacto", rsAsist.getString("TelefonoContacto"), true, true, 30, 220, "", true, true, 20)%>
        <%=MyUtil.ObjInput("Agente Contacto", "Agente", rsAsist.getString("AgenteContactado"), true, true, 250, 220, "", true, true, 50)%>
        <%=MyUtil.ObjComboC("Call Center", "clCallCenter", rsAsist.getString("dsCallCenter"), true, true, 30, 260, "0", "select clCallCenter, dsCallCenter from CScCallCenter where Activo=1 order by dsCallCenter asc", "fnTelCallCenter();fnValidaCallCenter();", "", 30, true, true)%>
        <div id="TelCallCenterDIV" name="TelCallCenterDIV" style="position:absolute; z-index:131; left:0px;">
            <%=MyUtil.ObjComboC("Tel�fono", "clTelCallCenter", rsAsist.getString("Telefono"), true, true, 30, 260, "0", "select clCallCenter, Telefono from CSTelefonoxCallCenter order by clCallCenter asc", "", "", 30, false, false)%>
        </div>
        <%=MyUtil.ObjInputDiv("Tel�fono", "OtroCallCenter", rsAsist.getString("OtroCallCenter"), true, true, 30, 300, "", false, false, 20, "", "OtroCallCenterDIV")%>
        <%=MyUtil.DoBlock("Detalle Warm Transfer", 230, 0)%>
        <%} else {%>
        <%=MyUtil.ObjComboC("Estatus", "clEstatus", "", false, false, 30, 80, "0", "sp_GetCSstatus", "", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Asistencia", "AsistenciaVTR", "", false, false, 350, 80, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Descripci�n del evento", "DescripcionEvento", "", "83", "3", true, true, 30, 120, "", true, true)%>
        <%=MyUtil.ObjInput("Fecha de Apertura", "FechaRegistro", "", false, false, 650, 80, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Datos Generales del Evento", 10, 10)%>

        <%=MyUtil.ObjInput("Tel�fono Contacto", "Contacto", "", true, true, 30, 220, "", true, true, 20)%>
        <%=MyUtil.ObjInput("Agente Contacto", "Agente", "", true, true, 250, 220, "", true, true, 50)%>
        <%=MyUtil.ObjComboC("Call Center", "clCallCenter", "", true, true, 30, 260, "0", "select clCallCenter, dsCallCenter from CScCallCenter where Activo=1 order by dsCallCenter asc", "fnTelCallCenter();fnValidaCallCenter();", "", 30, true, true)%>
        <div id="TelCallCenterDIV" name="TelCallCenterDIV" style="position:absolute; z-index:131; left:0px;">
            <%=MyUtil.ObjComboC("Tel�fono", "clTelCallCenter", "", true, true, 30, 300, "0", "select clCallCenter, Telefono from CSTelefonoxCallCenter order by clCallCenter asc", "", "", 30, false, false)%>
        </div>
        <%=MyUtil.ObjInputDiv("Tel�fono", "OtroCallCenter", "", true, true, 30, 300, "", false, false, 20, "", "OtroCallCenterDIV")%>
        <%=MyUtil.DoBlock("Detalle Warm Transfer", 230, 30)%>
        <%}%>

        <%
                StringBuffer StrSqlWT = new StringBuffer();
                StrSqlWT.append(" st_CSTablaWarmtransfer ");
                ResultSet rsWT = UtileriasBDF.rsSQLNP(StrSqlWT.toString());
                StrSqlWT.delete(0, StrSqlWT.length());
        %>
        <table style="position:absolute; z-index:31; left:20px; top:430px;" class='VTable' border='1' cellpadding='0'>
            <tr class="TTable"><td></td><td>Beneficiario</td><td>Breve Descripci�n</td><td>Vendedor</td><td>Tel�fono</td></tr>
            <%
                    while (rsWT.next()) {
            %>
            <tr class="R2Table"><td><%=rsWT.getString("dsWarmTransfer")%></td><td><%=rsWT.getString("Beneficiario")%></td><td><%=rsWT.getString("Descripcion")%></td><td><%=rsWT.getString("Vendor")%></td><td><%=rsWT.getString("Telefono")%></td></tr>
            <%
                    }
            %>
        </table>

        <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='FechaProgMskI' id='FechaProgMskI' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <input name='FechaProgMskS' id='FechaProgMskS' type='hidden' value='VN09VN09F:/:VN09VN09'>
        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>
        <input name='FechaIniMsk' id='FechaIniMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <%@ include file="csVentanaFlotante.jspf" %>
        <%
                //StrclConcierge = null;
                //StrclSubservicio = null;
                StrclAsistencia = null;
                daoRef = null;
                ref = null;
                rsAsist.close();
                rsAsist = null;
        %>
        <%=MyUtil.GeneraScripts()%>
        <script>
            top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
            top.document.all.rightPO.rows="0,80,*";
            document.all.OtroCallCenterDIV.style.visibility = 'hidden';

            fnNewBitacora(2);

            function fnAccionesAlta(){
                if (document.all.Action.value==1){
                    var pstrCadena = "../../Utilerias/RegresaFechaActual.jsp";
                    window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');
                }
            }

            function fnActualizaFechaActual(pFecha){
                document.all.FechaApAsist.value = pFecha;
            }

            function fnTelCallCenter(){
                var strConsulta = "st_CSTelCallCenter '" + document.all.clCallCenter.value + "'";
                var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=clTelCallCenterC";
                fnOptionxDefault('clTelCallCenterC',pstrCadena);
            }

            //funci�n antes de guardar
            function fnAntesGuarda(){
                if(document.all.clCallCenterC.value == 17 && document.all.OtroCallCenter.value == ''){
                    msgVal=msgVal + " Tel�fono.";
                }

                if(document.all.clCallCenterC.value != 17 && document.all.clTelCallCenterC.value == ''){
                    msgVal=msgVal + " Tel�fono.";
                }
                               
                var Urlback = document.all.URLBACK.value;
                Urlback = Urlback + document.all.clStrNomPag.value + "?";
                var cachahURL = document.all.URLBACK.value;
                if (cachahURL.indexOf(".jsp")==-1){
                document.all.URLBACK.value = Urlback;  }

                //SE QUITA ENCUESTA FOLIO 3726
                //fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
            }
            
            function fnValidaCallCenter(){
                //alert(document.all.clCallCenterC.value);
                if(document.all.clCallCenterC.value == 17){
                    document.all.TelCallCenterDIV.style.visibility = 'hidden';
                    document.all.OtroCallCenterDIV.style.visibility = 'visible';
                    document.all.clTelCallCenter.value = '';
                    document.all.clTelCallCenterC.value = '';
                }else{
                    document.all.TelCallCenterDIV.style.visibility = 'visible';
                    document.all.OtroCallCenterDIV.style.visibility = 'hidden';
                    document.all.OtroCallCenter.value = '';
                }
            }
            
            function fnMuestraDatos(){
                if(document.all.clCallCenterC.value == 17){
                    document.all.TelCallCenterDIV.style.visibility = 'hidden';
                    document.all.OtroCallCenterDIV.style.visibility = 'visible';
                }
                
                if(document.all.clCallCenterC.value != 17){
                    document.all.TelCallCenterDIV.style.visibility = 'visible';
                    document.all.OtroCallCenterDIV.style.visibility = 'hidden';
                }
            }
            
            fnMuestraDatos();
        </script>
        <script type="text/javascript">
            initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencia'),350,250,700,20,false,false,true,true,false);
        </script>
    </body>
</html>