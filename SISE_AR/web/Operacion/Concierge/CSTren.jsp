<%--
 Document   : CSTren
 Create on  : 2010-11-23
 Author     : rfernandez
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOCSTren,com.ike.concierge.to.CSTren" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,javax.servlet.http.HttpSession,java.sql.ResultSet"%>

<html>
    <head><title>CSTren</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>

        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <script src='../../Utilerias/UtilCalendario.js'></script>
        <script src='../../Utilerias/UtilStore.js'></script>

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Boletos de Tren </i></b></font><br></p></div>
        <div class='VTable' style='position:absolute; z-index:25; left:570px; top:83px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Automatica </i></b></font><br></p></div>

        <%

                    String StrclConcierge = "";
                    String StrclSubservicio = "";
                    String StrclAsistencia = "0";
                    String StrclUsr = "0";
                    String StrclTren = "0";

                    //--------------------*  1  *--------------------------
                    String StrURL = "";
                    String StrNomPag = "";

                    if (request.getRequestURL() != null) {
                        StrURL = request.getRequestURL().toString();
                        StrNomPag = StrURL.substring(StrURL.lastIndexOf("/") + 1);
                        System.out.println("URL RQ(getRequestURL): ........................................... " + StrURL);
                        System.out.println("Pagina.................................... " + StrNomPag);
                    }
                    //---------------------------------------------------

                    DAOCSTren daoCSTren = null;
                    CSTren T = null;

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

                    if (request.getParameter("clTren") != null) {
                        StrclTren = request.getParameter("clTren").toString();
                        session.setAttribute("clTren", StrclTren);
                    } else {
                        if (session.getAttribute("clTren") != null) {
                            StrclTren = session.getAttribute("clTren").toString();
                        }
                    }


                    session.setAttribute("clAsistencia", StrclAsistencia);
                    session.setAttribute("clSubservicio", StrclSubservicio);

                    String StrclPaginaWeb = "1253";
                    session.setAttribute("clPaginaWebP", StrclPaginaWeb);


                    if (StrclUsr != null) {
                        daoCSTren = new DAOCSTren();
                        T = daoCSTren.getCSTren(StrclAsistencia);
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
                    Store = "st_GuardaCSTren,st_ActualizaCSTren";
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
                    //-----------------------------------------------------

		
		//-----------------------------------------------------
		// SE AGREGA CODIGO PARA EL MANEJO DE LAS ASISTENCIAS DUPLICADAS.
		String StrclAsistenciaVTR = "";
		ResultSet rsTieneAsistMadre = null;
		rsTieneAsistMadre = UtileriasBDF.rsSQLNP(" st_CSTieneAsistMadre "+StrclAsistencia);

		if(rsTieneAsistMadre.next()){
			if(rsTieneAsistMadre.getString("TieneAsistMadre").equalsIgnoreCase("1")){
				StrclAsistenciaVTR = rsTieneAsistMadre.getString("Folio");
			}else{
				//StrclAsistenciaVTR = ConciergeInfTC!=null ? ConciergeInfTC.getClAsistencia().trim() : "";
				StrclAsistenciaVTR = StrclAsistencia;
			}
			session.setAttribute("clAsistenciaVTR", StrclAsistenciaVTR);
		}

		rsTieneAsistMadre.close();
		rsTieneAsistMadre = null;
		//-----------------------------------------------------
	
        %> <script>fnOpenLinks()</script><%
        %>
        <%MyUtil.InicializaParametrosC(1253, Integer.parseInt(StrclUsr));%>
        <%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "fnAccionesAlta();", "fnsp_Guarda();fnAntesGuardar();fnReqCampo();")%>

        <%-------------------------  3  ----------------------------%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>'>
        <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
        <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
        <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
        <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
        <%----------------------------------------------------------%>

        <input id="clPaginaWeb" name="clPaginaWeb" type="hidden" value="<%=StrclPaginaWeb%>" >
        <input id="Secuencia" name="Secuencia" type="hidden" value="">
        <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="clConcierge,FechaApAsist,clUsrApp,Region,LineaTren,Clase,CiudadO,CiudadD,EstacionO,EstacionD,FechaS,FechaAS,Escalas,Via,HorasRecorrido,CapacidadC,CostoC,AutoFill,RegionR,LineaTrenR,ClaseR,CiudadOR,CiudadDR,EstacionOR,EstacionDR,FechaSR,FechaAR,EscalasR,ViaR,HorasRR,CapacidadCR,CostoCR,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,Confirmo,NConfirmo,PCancel,NuInf,ObservacionesE">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clAsistencia,Region,LineaTren,Clase,CiudadO,CiudadD,EstacionO,EstacionD,FechaS,FechaAS,Escalas,Via,HorasRecorrido,CapacidadC,CostoC,AutoFill,RegionR,LineaTrenR,ClaseR,CiudadOR,CiudadDR,EstacionOR,EstacionDR,FechaSR,FechaAR,EscalasR,ViaR,HorasRR,CapacidadCR,CostoCR,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,Confirmo,NConfirmo,PCancel,NuInf,ObservacionesE,clEstatus">
                                                                                                                                                                                                                                                                                          

        <INPUT id='clConcierge'  name='clConcierge'  type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsr%>'>

        <%String strEstatus = T != null ? T.getdsEstatus() : "";%>

        <%  int iY = 10;%>
        <%=MyUtil.ObjComboC("Estatus", "clEstatus", T != null ? T.getdsEstatus() : "", false, false, 30, 70, "", "sp_GetCSstatus", "", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Asistencia", "AsistenciaVTR", StrclAsistenciaVTR, false, false, 350, 70, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento", "ObservacionesE", T != null ? T.getComentarios() : "", "100", "3", true, true, 30, 110, "", true, true)%>
        <%=MyUtil.ObjInput("fecha de alta", "FechaA", T != null ? T.getFechaRegistro() : "", false, false, 650, 70, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Datos Generales del Evento", 5, 15)%>

        <div id='Destino' Name='Destino' class='VTable' style='position:absolute; z-index:11; left:30px; top:213px; width:70px;' align="center"><p class='Obs'>Viaje <BR>Sencillo</p> </div>

        <%=MyUtil.ObjInput("Region", "Region", T != null ? T.getRegion() : "", true, true, 120, iY + 200, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Linea de Tren", "LineaTren", T != null ? T.getLineaTren() : "", true, true, 350, iY + 200, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Clase", "Clase", T != null ? T.getClase() : "", true, true, 580, iY + 200, "", false, false, 40)%>

        <%=MyUtil.ObjInput("Ciudad de Origen", "CiudadO", T != null ? T.getCiudadO() : "", true, true, 80, iY + 245, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Estacion de Origen", "EstacionO", T != null ? T.getEstacionO() : "", true, true, 300, iY + 245, "", false, false, 35)%>
        <%=MyUtil.ObjInputF("Fecha de Salida (AAAA-MM-DD)", "FechaS", T != null ? T.getFechaS() : "", true, true, 530, iY + 245, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Ciudad de destino", "CiudadD", T != null ? T.getCiudadD() : "", true, true, 80, iY + 285, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Estacion de Destino", "EstacionD", T != null ? T.getEstacionD() : "", true, true, 300, iY + 285, "", false, false, 35)%>
        <%=MyUtil.ObjInputF("Fecha de Arribo (AAAA-MM-DD)", "FechaAS", T != null ? T.getFechaAS() : "", true, true, 530, iY + 285, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Escalas", "Escalas", T != null ? T.getEscalas() : "", true, true, 30, iY + 325, "", false, false, 45)%>
        <%=MyUtil.ObjInput("Via", "Via", T != null ? T.getVia() : "", true, true, 300, iY + 325, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Horas de Recorrido", "HorasRecorrido", T != null ? T.getHorasRecorrido() : "", true, true, 500, iY + 325, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Capacidad Camarote", "CapacidadC", T != null ? T.getCapacidadC() : "", true, true, 30, iY + 365, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Costo Camarote", "CostoC", T != null ? T.getCostoC() : "", true, true, 300, iY + 365, "", false, false, 20)%>

        <div class='VTable'  id="btnAsist" style="position:absolute; z-index:25; left:650px; top:375px;">
            <input class='cBtn' type='button' value='Agregar Pasajero' onClick="fnGetPasajero();"></input>
        </div>
        <div id='Destino' Name='Destino' class='VTable' style='position:absolute; z-index:11; left:30px; top:435px; width:70px; ' align="center"><p class='Obs'><strong>Viaje REDONDO</strong></p> </div>
        <%=MyUtil.ObjChkBox("HABILITA (Autofill)", "AutoFill", T != null ? T.getAutoFill() : "", true, true, 645, 400, "", "fnDesabilitaT();")%>
        <hr style='position:absolute; z-index:90; left:30px; top:420px; width:750px; height:1px;' class="FReq">

        <%=MyUtil.ObjInput("Region", "RegionR", T != null ? T.getRegionR() : "", true, true, 120, iY + 420, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Linea de Tren", "LineaTrenR", T != null ? T.getLineaTrenR() : "", true, true, 350, iY + 420, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Clase", "ClaseR", T != null ? T.getClaseR() : "", true, true, 580, iY + 420, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Ciudad de Origen", "CiudadOR", T != null ? T.getCiudadOR() : "", true, true, 80, iY + 460, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Terminal de Origen", "EstacionOR", T != null ? T.getEstacionOR() : "", true, true, 300, iY + 460, "", false, false, 35)%>
        <%=MyUtil.ObjInputF("Fecha de salida (AAAA-MM-DD)", "FechaSR", T != null ? T.getFechaSR() : "", true, true, 530, iY + 460, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Ciudad de Destino", "CiudadDR", T != null ? T.getCiudadDR() : "", true, true, 80, iY + 500, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Terminal de destino", "EstacionDR", T != null ? T.getEstacionDR() : "", true, true, 300, iY + 500, "", false, false, 35)%>
        <%=MyUtil.ObjInputF("Fecha de Arribo (AAAA-MM-DD)", "FechaAR", T != null ? T.getFechaAR() : "", true, true, 530, iY + 500, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Escalas", "EscalasR", T != null ? T.getEscalasR() : "", true, true, 30, iY + 540, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Via", "ViaR", T != null ? T.getViaR() : "", true, true, 290, iY + 540, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Horas de Recorrido", "HorasRR", T != null ? T.getHorasRR() : "", true, true, 500, iY + 540, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Capacidad camarote", "CapacidadCR", T != null ? T.getCapacidadCR() : "", true, true, 30, iY + 580, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Costo Camarote", "CostoCR", T != null ? T.getCostoCR() : "", true, true, 300, iY + 580, "", false, false, 20)%>
        <%=MyUtil.DoBlock("descripcion del viaje", -20, -12)%>

        <%=MyUtil.ObjComboC("Forma de Pago:", "clTipoPago", T != null ? T.getdsTipoPago() : "", true, true, 30, 660, "", "select clTipoPago,dsTipoPago from CSTipoPago", "fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Nombre del Banco:", "NomBanco", T != null ? T.getNomBanco() : "", true, true, 220, 660, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Nombre en TC:", "NombreTC", T != null ? T.getNombreTC() : "", true, true, 470, 660, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Numero de TC:", "NumeroTC", T != null ? T.getNumeroTC() : "", false, false, 30, 700, "", false, false, 50, "if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        <%=MyUtil.ObjInput("Exp.D.:(MM/AA)", "ExpiraVTR", T != null ? T.getExpira() : "", false, false, 350, 700, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
        <input type="hidden" name="Expira" id="Expira" value= "<%=T != null ? T.getExpira().trim() : ""%>">
        <%=MyUtil.ObjInput("Sec.C.:", "SecC", T != null ? T.getSecC() : "", false, false, 440, 700, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Confirmo", "Confirmo", T != null ? T.getConfirmo() : "", true, true, 30, 740, "", false, false, 30)%>
        <%=MyUtil.ObjInput("No.Conf.:", "NConfirmo", T != null ? T.getNConfirmo() : "", true, true, 350, 740, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Pol.Cancelación", "PCancel", T != null ? T.getPCancel() : "", true, true, 30, 780, "", false, false, 50)%>
        <%=MyUtil.ObjChkBox("N/U inf.:", "NuInf", T != null ? T.getNuInf() : "", true, true, 350, 780, "", "SI", "NO", "")%>
        <%=MyUtil.DoBlock("Costos del Evento", 100, -10)%>

        <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>

        <%@ include file="csVentanaFlotante.jspf" %>

        <%=MyUtil.GeneraScripts()%>

        <script>
            top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
            top.document.all.rightPO.rows="0,50,*";


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
                if (document.all.clTipoPago.value==1 || document.all.clTipoPago.value==2 || document.all.clTipoPago.value==3)
                {
                    if ( document.all.NumeroTC.value=="" || document.all.Expira.value=="" || document.all.SecC.value=="")
                    {
                        msgVal = msgVal + " Debe de Ingresar Los campos requeridos de Tarjetas de Credito. ";
                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    }
                }
            }

            function fnGetPasajero(){

                var pstrCadena = "ConciergeFramePasajeros.jsp?clAsistencia=" + document.all.clAsistencia.value;
                window.open(pstrCadena,'newWinNA','scrollbars=yes,status=yes,width=800,height=500,top=200,left=250');
            }
                    document.all.RegionR.disabled = true;
                    document.all.LineaTrenR.disabled = true;
                    document.all.ClaseR.disabled = true;
                    document.all.CiudadOR.disabled = true;
                    document.all.CiudadDR.disabled = true;
                    document.all.EstacionOR.disabled = true;
                    document.all.EstacionDR.disabled = true;
                    document.all.FechaSR.disabled = true;
                    document.all.FechaAR.disabled = true;
                    document.all.EscalasR.disabled = true;
                    document.all.ViaR.disabled = true;
                    document.all.HorasRR.disabled = true;
                    document.all.CapacidadCR.disabled = true;
                    document.all.CostoCR.disabled = true;


            function fnDesabilitaT(){

                if (document.all.AutoFillC.checked ==1){

                    document.all.RegionR.disabled = false;
                    document.all.LineaTrenR.disabled = false;
                    document.all.ClaseR.disabled = false;
                    document.all.CiudadOR.disabled = false;
                    document.all.CiudadDR.disabled = false;
                    document.all.EstacionOR.disabled = false;
                    document.all.EstacionDR.disabled = false;
                    document.all.FechaSR.disabled = false;
                    document.all.FechaAR.disabled = false;
                    document.all.EscalasR.disabled = false;
                    document.all.ViaR.disabled = false;
                    document.all.HorasRR.disabled = false;
                    document.all.CapacidadCR.disabled = false;
                    document.all.CostoCR.disabled = false;

                    document.all.CiudadOR.value = document.all.CiudadD.value;
                    document.all.CiudadDR.value = document.all.CiudadO.value;

                }else{  document.all.RegionR.disabled = true;
                        document.all.LineaTrenR.disabled = true;
                        document.all.ClaseR.disabled = true;
                        document.all.CiudadOR.disabled = true;
                        document.all.CiudadDR.disabled = true;
                        document.all.EstacionOR.disabled = true;
                        document.all.EstacionDR.disabled = true;
                        document.all.FechaSR.disabled = true;
                        document.all.FechaAR.disabled = true;
                        document.all.EscalasR.disabled = true;
                        document.all.ViaR.disabled = true;
                        document.all.HorasRR.disabled = true;
                        document.all.CapacidadCR.disabled = true;
                        document.all.CostoCR.disabled = true;
                }
            }



            function fnAntesGuardar(){
                //-------------------------   4   ----------------------------
                fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
                //------------------------------------------------------------
            }


        </script>
        <%  //<<<<<<<<<<<<<<<< Limpiar Variables >>>>>>>>>
                    StrclUsr = null;
                    StrclPaginaWeb = null;
                    daoCSTren = null;
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
            initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
        </script>
    </body>
</html>
