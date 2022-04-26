<%-- 
    Document   : CSPaqueteViaje
    Created on : 4/02/2011, 08:13:19 AM
    Author     : rfernandez
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOCSPaqueteViaje,com.ike.concierge.to.CSPaqueteViaje" errorPage="" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,javax.servlet.http.HttpSession,java.sql.ResultSet"%>
<html>
    <head>
        <title>CSCrucero</title>
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
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <script src='../../Utilerias/UtilCalendarioV.js'></script>
        <script src='../../Utilerias/UtilStore.js'></script>

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Paquete de Viaje </i></b></font><br></p></div>
        <div class='VTable' style='position:absolute; z-index:25; left:570px; top:83px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Automatica </i></b></font><br></p></div>



        <%
                    String StrclConcierge = "";
                    String StrclSubservicio = "";
                    String StrclAsistencia = "0";
                    String StrclUsr = "0";
                    String StrclPaqueteViaje = "0";

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



                    DAOCSPaqueteViaje daoCSPaqueteViaje = null;
                    CSPaqueteViaje PV = null;

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


                         if (request.getParameter("clPaqueteViaje") != null) {
                             StrclPaqueteViaje = request.getParameter("clPaqueteViaje").toString();
                             session.setAttribute("clPaqueteViaje", StrclPaqueteViaje);
                         } else {
                             if (session.getAttribute("clPaqueteViaje") != null) {
                                 StrclPaqueteViaje = session.getAttribute("clPaqueteViaje").toString();
                             }
                         }

                         session.setAttribute("clAsistencia", StrclAsistencia);
                         session.setAttribute("clSubservicio", StrclSubservicio);

                         String StrclPaginaWeb = "1254";
                         session.setAttribute("clPaginaWebP", StrclPaginaWeb);


                         if (StrclUsr != null) {
                             daoCSPaqueteViaje = new DAOCSPaqueteViaje();
                             PV = daoCSPaqueteViaje.getCSPaqueteViaje(StrclAsistencia);
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
                         Store = "st_GuardaCSPaqueteViaje,st_ActualizaCSPaqueteViaje";
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
	
        %> <script>fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(1254, Integer.parseInt(StrclUsr));%>
        <%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "fnAccionesAlta();", "fnsp_Guarda();fnAntesGuardar();fnReqCampo();")%>

        <%-------------------------  3  ----------------------------%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>'>
        <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
        <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
        <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
        <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
        <%----------------------------------------------------------%>

        <input id="Secuencia" name="Secuencia" type="hidden" value="">
        <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="clConcierge,FechaApAsist,clUsrApp,CdOrigenV,CdDestinoV,NoNoches,Adultos,Menores,Edades,NoVuelo,Clase,Operadox,CdOrigen,CdDestino,AptOrigen,AptDestino,FechaSalida,FechaArribo,NoVuelo1,Clase1,Operadox1,CdOrigen1,CdDestino1,AptOrigen1,AptDestino1,FechaSalida1,FechaArribo1,Conexiones,TiempoLimite,NombreHotel,TipoHabitacion,ReservaNom,Incluye,NoHabitaciones,CheckInn,Checkout,Observaciones,CostoTotal,CostoNocheAd,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,Confirmo,NumConfirmacion,Cancelacion,NUInfo,Comentarios">
                             <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clAsistencia,CdOrigenV,CdDestinoV,NoNoches,Adultos,Menores,Edades,NoVuelo,Clase,Operadox,CdOrigen,CdDestino,AptOrigen,AptDestino,FechaSalida,FechaArribo,NoVuelo1,Clase1,Operadox1,CdOrigen1,CdDestino1,AptOrigen1,AptDestino1,FechaSalida1,FechaArribo1,Conexiones,TiempoLimite,NombreHotel,TipoHabitacion,ReservaNom,Incluye,NoHabitaciones,CheckInn,Checkout,Observaciones,CostoTotal,CostoNocheAd,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,Confirmo,NumConfirmacion,Cancelacion,NUInfo,Comentarios,clEstatus">

        <INPUT id='clConcierge'  name='clConcierge'  type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsr%>'>

              <%String strEstatus = PV != null ? PV.getdsEstatus(): "";%>

        <%  int iY = 10;%>
        <%=MyUtil.ObjComboC("Estatus", "clEstatus", PV != null ? PV.getdsEstatus() : "", false, false, 30, 70, "", "sp_GetCSstatus", "", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Asistencia", "AsistenciaVTR", StrclAsistenciaVTR, false, false, 350, 70, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento", "Comentarios", PV != null ? PV.getComentarios() : "", "100", "3", true, true, 30, 110, "", true, true, "", "")%>
        <%=MyUtil.ObjInput("fecha de alta", "FechaA", PV != null ? PV.getFechaRegistro() : "", false, false, 650, 70, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Datos Generales del Evento", 5, 15)%>

        <%=MyUtil.ObjInput("Ciudad de Origen", "CdOrigenV", PV != null ? PV.getCdOrigenV() : "", true, true, 30, 215, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Ciudad de Destino", "CdDestinoV", PV != null ? PV.getCdDestinoV() : "", true, true, 240, 215, "", false, false, 35)%>
        <%=MyUtil.ObjInput("No. de noches", "NoNoches", PV != null ? PV.getNoNoches() : "", true, true, 450, 215, "", false, false, 15)%>
        <%=MyUtil.ObjInput("Adultos", "Adultos", PV != null ? PV.getAdultos() : "", true, true, 560, 215, "", false, false, 20)%>
        <%=MyUtil.ObjChkBox("Menores", "Menores", PV != null ? PV.getMenores() : "", true, true, 690, 225, "", "")%>
        <%=MyUtil.ObjInput("Edades", "Edades", PV != null ? PV.getEdades() : "", true, true, 790, 215, "", false, false, 30)%>

        <%=MyUtil.ObjInput("No de Vuelo", "NoVuelo", PV != null ? PV.getNoVuelo() : "", true, true, 30, 275, "", false, false, 25)%>
        <%=MyUtil.ObjInput("Operado por:", "Operadox", PV != null ? PV.getOperadox() : "", true, true, 230, 275, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Clase", "Clase", PV != null ? PV.getClase() : "", true, true, 460, 275, "", false, false, 30)%>

        <div id='Destino' Name='Destino' class='VTable' style='position:absolute; z-index:11; left:50px; top:255px; width:700px;' align="center"><p class='Obs'>Detalle del Vuelo (Ida)</p> </div>

        <%=MyUtil.ObjInput("Ciudad Origen", "CdOrigen", PV != null ? PV.getCdOrigen() : "", true, true, 140, 315, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Aeropuerto Origen", "AptOrigen", PV != null ? PV.getAptOrigen() : "", true, true, 345, 315, "", false, false, 35)%>
        <%=MyUtil.ObjInputF("Fecha de Salida <Strong>(AAAA-MM-DD hh:mm)</Strong>", "FechaSalida", PV != null ? PV.getFechaSalida() : "", true, true, 550, 315, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Ciudad Destino", "CdDestino", PV != null ? PV.getCdDestino() : "", true, true, 140, 355, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Aeropuerto Destino", "AptDestino", PV != null ? PV.getAptDestino() : "", true, true, 345, 355, "", false, false, 35)%>
        <%=MyUtil.ObjInputF("Fecha de Arribo <Strong>(AAAA-MM-DD hh:mm)</Strong>", "FechaArribo", PV != null ? PV.getFechaArribo() : "", true, true, 550, 355, "", false, false, 20, 2, "")%>

        <div id='Destino' Name='Destino' class='VTable' style='position:absolute; z-index:11; left:50px; top:405px; width:700px;' align="center"><p class='Obs'>Detalle del Vuelo (Regreso)</p> </div>

        <%=MyUtil.ObjInput("No de Vuelo", "NoVuelo1", PV != null ? PV.getNoVuelo1() : "", true, true, 30, 425, "", false, false, 25)%>
        <%=MyUtil.ObjInput("Operado por:", "Operadox1", PV != null ? PV.getOperadox1(): "", true, true, 230, 425, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Clase", "Clase1", PV != null ? PV.getClase1() : "", true, true, 460, 425, "", false, false, 30)%>

        <%=MyUtil.ObjInput("Ciudad Origen", "CdOrigen1", PV != null ? PV.getCdOrigen1() : "", true, true, 140, 465, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Aeropuerto Origen", "AptOrigen1", PV != null ? PV.getAptOrigen1() : "", true, true, 345, 465, "", false, false, 35)%>
        <%=MyUtil.ObjInputF("Fecha de Salida <Strong>(AAAA-MM-DD hh:mm)</Strong>", "FechaSalida1", PV != null ? PV.getFechaSalida1() : "", true, true, 550, 465, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Ciudad Destino", "CdDestino1", PV != null ? PV.getCdDestino1() : "", true, true, 140, 505, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Aeropuerto Destino", "AptDestino1", PV != null ? PV.getAptDestino1() : "", true, true, 345, 505, "", false, false, 35)%>
        <%=MyUtil.ObjInputF("Fecha de Arribo <Strong>(AAAA-MM-DD hh:mm)</Strong>", "FechaArribo1", PV != null ? PV.getFechaArribo1() : "", true, true, 550, 505, "", false, false, 20, 2, "")%>

        <%=MyUtil.ObjInput("Conexiones", "Conexiones", PV != null ? PV.getConexiones() : "", true, true, 140, 545, "", false, false, 55, "")%>
        <%=MyUtil.ObjInputF("Tiempo L�mite <Strong>(AAAA-MM-DD hh:mm)</Strong>", "TiempoLimite", PV != null ? PV.getTiempoLimite() : "", true, true, 460,545,"", false, false,20,2,"")%>

        <div id='Destino' Name='Destino' class='VTable' style='position:absolute; z-index:11; left:50px; top:595px; width:700px;' align="center"><p class='Obs'>Detalle de Hospedaje</p> </div>

        <div class='VTable'  id="btnAsist" style="position:absolute; z-index:25; left:800px; top:275px;">
            <input class='cBtn' type='button' value='Agregar Pasajero' onClick="fnGetPasajero();"></input>
        </div>



        <%=MyUtil.ObjInput("Hotel","NombreHotel",PV!=null ? PV.getNombreHotel(): "",true,true,30,620,"",false,false,35)%>
        <%=MyUtil.ObjInput("Tipo de Hab","TipoHabitacion",PV!=null ? PV.getTipoHabitacion(): "",true,true,240,620,"",false,false,50)%>
        <%=MyUtil.ObjInput("Reserva A Nombre de","ReservaNom",PV!=null ? PV.getReservaNom(): "",true,true,520,620,"",false,false,40)%>
        <%=MyUtil.ObjTextArea("Incluye","Incluye",PV!=null ? PV.getIncluye(): "","60","5",true,true,370,740,"",false,false)%>
        <%=MyUtil.ObjInput("No. Habitaciones","NoHabitaciones",PV!=null ? PV.getNoHabitaciones(): "",true,true,30,660,"",false,false,15)%>
        <%=MyUtil.ObjInputF("CHECK INN<Strong>(AAAA-MM-DD)</Strong>","CheckInn",PV!=null ? PV.getCheckInn(): "",true,true,200,660,"",false,false,20, 2, "")%>
        <%=MyUtil.ObjInputF("CHECK OUT<Strong>(AAAA-MM-DD)</Strong>","Checkout",PV!=null ? PV.getCheckout(): "",true,true,370,660,"",false,false,20, 2, "")%>
        <%=MyUtil.ObjTextArea("Observaciones","Observaciones",PV!=null ? PV.getObservaciones(): "","60","5",true,true,30,740,"",false,false)%>
        <%=MyUtil.ObjInput("Costo Noche Adicional","CostoNocheAd",PV!=null ? PV.getCostoNocheAd(): "",true,true,30,700,"",false,false,20)%>
        <%=MyUtil.ObjInput("Cargo Total","CostoTotal",PV!=null ? PV.getCostoTotal(): "",true,true,200,700,"",false,false,15)%>
     
        <%=MyUtil.DoBlock("Descripcion del Viaje", 5, 50)%>

         <%=MyUtil.ObjComboC("Forma de Pago:", "clTipoPago", PV != null ? PV.getdsTipoPago() : "", true, true, 30, 880, "", "select clTipoPago,dsTipoPago from CSTipoPago", "fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();", "", 30, false, false)%>
        <INPUT id='dsTipoPago' name='dsTipoPago' type='hidden' value='< %=conciergeaviononeway != null ? conciergeaviononeway.getdsTipoPago() : ""%>'>
        <%=MyUtil.ObjInput("Nombre del Banco:", "NomBanco", PV != null ? PV.getNomBanco() : "", false, false, 200, 880, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Nombre en TC:", "NombreTC", PV != null ? PV.getNombreTC() : "", false, false, 450, 880, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Numero de TC:", "NumeroTC", PV != null ? PV.getNumeroTC() : "", false, false, 30, 920, "", false, false, 50, "if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        <%=MyUtil.ObjInput("Exp.D.:(MM-AA)", "ExpiraVTR", PV != null ? PV.getExpira() : "", false, false, 350, 920, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
        <input type="hidden" name="Expira" id="Expira" value="">
        <%=MyUtil.ObjInput("Sec.C.:", "SecC", PV != null ? PV.getSecC() : "", false, false, 540, 920, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Confirmo", "Confirmo", PV != null ? PV.getConfirmo() : "", true, true, 30, 960, "", false, false, 50)%>
        <%=MyUtil.ObjInput("No.Conf.:", "NumConfirmacion", PV != null ? PV.getNumConfirmacion() : "", true, true, 350, 960, "", false, false, 30, "")%>
        <%=MyUtil.ObjInput("Pol.Cancelaci�n", "Cancelacion", PV != null ? PV.getCancelacion() : "", true, true, 30, 1000, "", false, false, 50)%>
        <%=MyUtil.ObjChkBox("N/U inf.:", "NUInfo", PV != null ? PV.getNUInfo() : "", true, true, 350, 1000, "0", "SI", "NO", "")%>
        <%=MyUtil.DoBlock("Forma de Pago", 30, 0)%>

        <input name='FechaSalidaMsk' id='FechaSalidaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='FechaArriboMsk' id='FechaArriboMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>
        <input name='TiempoLimiteMsk' id='TiempoLimiteMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>


        <%@ include file="csVentanaFlotante.jspf" %>


        <%=MyUtil.GeneraScripts()%>


            <script>
            top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
            top.document.all.rightPO.rows="0,80,*";

            document.all.SecC.maxLength=4;


        function fnValidaFecha()
            {
             if (document.all.FechaSalida.value!='' && document.all.FechaArribo.value!= '')
            {
              if (document.all.FechaArribo.value <= document.all.FechaSalida.value)
              {
               msgVal = msgVal + " Fecha Arribo debe de ser mayor a Fecha Salida. "
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


             //funci�n antes de guardar
        function fnAntesGuardar(){

            //..........................................44444444444444444444444444
                fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
            //..........................................44444444444444444444444444
        }
              //Funci�n para quitarle los cero a la fecha
        /*function fnVerificaFecha() {
            document.all.FechaSalida.value=fnFechaID(document.all.FechaSalida.value);
            document.all.FechaArribo.value=fnFechaID(document.all.FechaArribo.value);
            document.all.TiempoLimite.value=fnFechaID(document.all.TiempoLimite.value);
        }*/

        //funci�n que regresa la fecha sin hora
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

       function fnGetPasajero(){

                var pstrCadena = "ConciergeFramePasajeros.jsp?clAsistencia=" + document.all.clAsistencia.value+"&clPaginaWeb=1";
                window.open(pstrCadena,'newWinNA','scrollbars=yes,status=yes,width=800,height=500,top=200,left=250');
            }



    </script>
    <%
            //StrclConcierge = null;
            //StrclSubservicio = null;
            StrclAsistencia = null;
            daoCSPaqueteViaje = null;
            PV = null;
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


