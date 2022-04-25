<%--
 Document   : CSRecepcionVip
 Create on  : 2010-11-23
 Author     : rfernandez
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist,com.ike.concierge.DAOCSRecepcionVip,com.ike.concierge.to.CSRecepcionVip" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,javax.servlet.http.HttpSession,java.sql.ResultSet"%>
<html>
    <head><title>CSRecepcionVip</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
            <script type="text/javascript">
                var floating_window_skin = 2;
            </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>
       </head>
 <body class="cssBody" onload="if (document.all.ExpiraVTR.value!=''){fnFechVen(document.all.ExpiraVTR.value)}; ">

        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <script src='../../Utilerias/UtilCalendarioV.js'></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
        <script src='../../Utilerias/UtilStore.js'></script>

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Recepcion Vip </i></b></font><br></p></div>
        <div class='VTable' style='position:absolute; z-index:25; left:570px; top:83px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i> Automatica </i></b></font><br></p></div>

        <%
                    String StrclConcierge = "";
                    String StrclSubservicio = "";
                    String StrclAsistencia = "0";
                    String StrclUsr = "0";
                    String StrclRecepcionVip = "0";


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


                    DAOCSRecepcionVip daoCSRecepcionVip = null;
                    CSRecepcionVip R = null;

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

                    if (request.getParameter("clRecepcionVip") != null) {
                        StrclRecepcionVip = request.getParameter("clRecepcionVip").toString();
                        session.setAttribute("clRecepcionVip", StrclRecepcionVip);
                    } else {
                        if (session.getAttribute("clRecepcionVip") != null) {
                            StrclRecepcionVip = session.getAttribute("clRecepcionVip").toString();
                        }
                    }

                    session.setAttribute("clAsistencia", StrclAsistencia);
                    session.setAttribute("clSubservicio", StrclSubservicio);

                    String StrclPaginaWeb = "1275";
                    session.setAttribute("clPaginaWebP", StrclPaginaWeb);


                    if (StrclUsr != null) {
                        daoCSRecepcionVip = new DAOCSRecepcionVip();
                        R = daoCSRecepcionVip.getCSRecepcionVip(StrclAsistencia);
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
                    Store = "st_GuardaCSRecepcionVip,st_ActualizaCSRecepcionVip";
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
	
        %>
        <script>fnOpenLinks()</script><%
        %>

        <%MyUtil.InicializaParametrosC(1275, Integer.parseInt(StrclUsr));%>
        <%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "fnAccionesAlta();", "fnsp_Guarda();fnAntesGuardar();fnReqCampo();")%>

        <%-------------------------  3  ----------------------------%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>'>
        <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
        <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
        <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
        <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
        <%----------------------------------------------------------%>

        <input id="Secuencia" name="Secuencia" type="hidden" value="">
        <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="clConcierge,FechaApAsist,clUsrApp,NoPasajeros,RequiereT,Destino,CostoT,NoVuelo,Operado,Pasajero,CiudadO,CiudadD,AeropuertoO,AeropuertoD,FechaS,FechaAV,Conexiones,Terminal,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,Confirmo,NConfirmo,PCancel,NuInf,Observaciones">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clAsistencia,NoPasajeros,RequiereT,Destino,CostoT,NoVuelo,Operado,Pasajero,CiudadO,CiudadD,AeropuertoO,AeropuertoD,FechaS,FechaAV,Conexiones,Terminal,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,Confirmo,NConfirmo,PCancel,NuInf,Observaciones,clEstatus">

        <INPUT id='clConcierge'  name='clConcierge'  type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsr%>'>

        <%  int iY = 10;%>

        <%=MyUtil.ObjComboC("Estatus", "clEstatus", R != null ? R.getDsEstatus(): "", false, false, 30, 70, "", "sp_GetCSstatus", "", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Asistencia", "AsistenciaVTR", StrclAsistenciaVTR, false, false, 350, 70, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento", "Observaciones", R != null ? R.getComentarios(): "", "83", "3", true, true, 30, 110, "", true, true)%>
        <%=MyUtil.ObjInput("fecha de alta", "FechaA", R != null ? R.getFechaRegistro() : "", false, false, 650, 70, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Datos Generales del Evento", 5, 15)%>

        <%=MyUtil.ObjInput("numero Pasajeros", "NoPasajeros", R != null ? R.getNoPasajeros() : "", true, true, 30, iY + 200, "", false, false, 10)%>
        <%=MyUtil.ObjChkBox("Requiere Transporte", "RequiereT", R != null ? R.getRequiereT() : "", true, true, 180, iY + 200, "", "SI", "NO", "")%>
        <%=MyUtil.ObjTextArea("Destino", "Destino", R != null ? R.getDestino() : "", "60", "4", true, true, 330, iY + 200, "", false, false)%>
        <%=MyUtil.ObjInput("Costo Total", "CostoT", R != null ? R.getCostoT() : "", true, true, 700, iY + 200, "", false, false, 15)%>

        <%=MyUtil.ObjInput("Numero de Vuelo", "NoVuelo", R != null ? R.getNoVuelo() : "", true, true, 30, iY + 310, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Operado por", "Operado", R != null ? R.getOperado() : "", true, true, 190, iY + 310, "", false, false, 45)%>
        <%=MyUtil.ObjInput("Pasajero /Usuario", "Pasajero", R != null ? R.getPasajero(): "", true, true, 460, iY + 310, "", false, false, 45)%>
        <%=MyUtil.ObjInput("Ciudad de Origen", "CiudadO", R != null ? R.getCiudadO() : "", true, true, 190, iY + 350, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Aeropuerto de Origen", "AeropuertoO", R != null ? R.getAeropuertoO() : "", true, true, 400, iY + 350, "", false, false, 35)%>
        <%=MyUtil.ObjInputF("Fecha de Salida (AAAA-MM-DD)", "FechaS", R != null ? R.getFechaS() : "", true, true, 610, iY + 350, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Ciudad de Destino", "CiudadD", R != null ? R.getCiudadD() : "", true, true, 190, iY + 390, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Aeropuerto de Destino", "AeropuertoD", R != null ? R.getAeropuertoD() : "", true, true, 400, iY + 390, "", false, false, 35)%>
        <%=MyUtil.ObjInputF("FechaA (AAAA-MM-DD)", "FechaAV", R != null ? R.getFechaA() : "", true, true, 610, iY + 390, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjTextArea("Conexiones", "Conexiones", R != null ? R.getConexiones() : "", "70", "3", true, true, 30, iY + 430, "", false, false)%>
        <%=MyUtil.ObjTextArea("Terminal", "Terminal", R != null ? R.getTerminal() : "", "70", "3", true, true, 410, iY + 430, "", false, false)%>

        <div id='Des3' Name='Des3' class='VTable' style='position:absolute; z-index:11; left:90px; top:290px; width:600px; ' align="center"><p class='Obs'>detalles del vuelo</p> </div>

        <%=MyUtil.DoBlock("Descripcion del evento", -75, 10)%>

        <%=MyUtil.ObjComboC("Forma de Pago:", "clTipoPago", R != null ? R.getdsTipoPago(): "", true, true, 30, 540, "", "select clTipoPago,dsTipoPago from CSTipoPago", "fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Nombre del Banco:", "NomBanco", R != null ? R.getNomBanco() : "", true, true, 220, 540, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Nombre en TC:", "NombreTC", R != null ? R.getNombreTC() : "", true, true, 470, 540, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Numero de TC:", "NumeroTC", R != null ? R.getNumeroTC() : "", false, false, 30, 580, "", false, false, 50, "if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        <%=MyUtil.ObjInput("Exp.D.:(MM/AA)", "ExpiraVTR", R != null ? R.getExpira() : "", false, false, 350, 580, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
        <input type="hidden" name="Expira" id="Expira" value= "<%=R != null ? R.getExpira().trim() : ""%>">
        <%=MyUtil.ObjInput("Sec.C.:", "SecC", R != null ? R.getSecC(): "", false, false, 440, 580, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
        
        <%=MyUtil.ObjInput("Confirmo", "Confirmo", R != null ? R.getConfirmo() : "", true, true, 30, 620, "", false, false, 30)%>
        <%=MyUtil.ObjInput("No.Conf.:", "NConfirmo", R != null ? R.getNConfirmo() : "", true, true, 350, 620, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Pol.Cancelación", "PCancel", R != null ? R.getPCancel() : "", true, true, 30, 660, "", false, false, 50)%>
        <%=MyUtil.ObjChkBox("N/U inf.:", "NuInf", R != null ? R.getNuInf() : "", true, true, 350, 660, "", "SI", "NO", "")%>
        <%=MyUtil.DoBlock("Costos del Evento", 100, 10)%>
        <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>


        <%@ include file="csVentanaFlotante.jspf" %>

        <%=MyUtil.GeneraScripts()%>

        <%  //<<<<<<<<<<<<<<<< Limpiar Variables >>>>>>>>>
        StrclUsr = null;
        StrclPaginaWeb = null;
        daoCSRecepcionVip = null;
        R = null;
        StrclConcierge = null;
        StrclSubservicio = null;
        StrclAsistencia = null;
        daosg = null;
        conciergeg = null;
        daoRef = null;
        ref = null;
        %>

        <script>

  top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
        top.document.all.rightPO.rows="0,50,*";
        
            function fnAntesGuardar(){
                //-------------------------   4   ----------------------------
       
                fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
                //------------------------------------------------------------
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


        </script>
        <script type="text/javascript">
            initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
        </script>
    </body>
</html>
