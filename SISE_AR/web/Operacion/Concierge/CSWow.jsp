<%--
 Document   : CSWow
 Create on  : 2010-11-23
 Author     : rfernandez
--%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOCSWow,com.ike.concierge.to.CSWow" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,javax.servlet.http.HttpSession,java.sql.ResultSet"%>
<html>
    <head><title>CSWow</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="if (document.all.ExpiraVTR.value!=''){fnFechVen(document.all.ExpiraVTR.value)}">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>

        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <script src='../../Utilerias/UtilCalendario.js'></script>
        <script src='../../Utilerias/UtilStore.js'></script>

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> WOW'S </i></b></font><br></p></div>
        <div class='VTable' style='position:absolute; z-index:25; left:570px; top:83px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Automatica </i></b></font><br></p></div>

        <%
                    String StrclUsr = "";
                    String StrclCSwow = "";
                    String StrclConcierge = "";
                    String StrclSubservicio = "";
                    String StrclAsistencia = "0";
                    
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

                    DAOCSWow daoCSWow = null;
                    CSWow W = null;

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
                    if (request.getParameter("clCSwow") != null) {
                        StrclCSwow = request.getParameter("clCSwow").toString();
                        session.setAttribute("clCSwow", StrclCSwow);
                    } else {
                        if (session.getAttribute("clCSwow") != null) {
                            StrclCSwow = session.getAttribute("clCSwow").toString();
                        }
                    }

                session.setAttribute("clAsistencia", StrclAsistencia);
                session.setAttribute("clSubservicio", StrclSubservicio);

                String StrclPaginaWeb = "1279";
                session.setAttribute("clPaginaWebP", StrclPaginaWeb);

         
            //<<<<<<<<<<<< Servlet Generico >>>>>>>>>>>
            String Store = "";
            Store = "st_GuardaCSWow,st_ActualizaCSWow";
            session.setAttribute("sp_Stores", Store);

            String Commit = "";
            Commit = "clAsistencia";
            session.setAttribute("Commit", Commit);


                 if (StrclUsr != null) {
                    daoCSWow = new DAOCSWow();
                     W = daoCSWow.getCSWow(StrclAsistencia);
                }
                if (StrclUsr != null) {
                    daosg = new DAOConciergeG();
                     conciergeg = daosg.getConciergeGenerico(StrclConcierge);
                }
                if (StrclUsr != null) {
                    daoRef = new DAOReferenciasxAsist();
                    ref = daoRef.getclAsistencia(StrclAsistencia);
                }

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
	
        %><script>fnOpenLinks()</script><%

        MyUtil.InicializaParametrosC(1230, Integer.parseInt(StrclUsr));
        %><%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "fnAccionesAlta();", "fnsp_Guarda();fnAntesGuardar();fnReqCampo();")%><%
        %>
        <%-------------------------  3  ----------------------------%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>'>
        <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
        <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
        <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
        <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
        <%----------------------------------------------------------%>
        
        <input id="Secuencia" name="Secuencia" type="hidden" value="">
        <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="clConcierge,FechaApAsist,clUsrApp,FechaS,NoPersonas,LimiteGastos,DetalleSolicitud,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,Confirmo,NConfirmo,PCancel,NuInf,Observaciones">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clAsistencia,FechaS,NoPersonas,LimiteGastos,DetalleSolicitud,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,Confirmo,NConfirmo,PCancel,NuInf,Observaciones,clEstatus">
    
        <INPUT id='clConcierge'  name='clConcierge'  type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsr%>'>

        <%String strEstatus = W != null ? W.getdsEstatus() : "";%>

        <%  int iY = 10;%>
        <%=MyUtil.ObjComboC("Estatus", "clEstatus", W != null ? W.getdsEstatus() : "", false, false, 30, 70, "", "sp_GetCSstatus", "", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Asistencia", "AsistenciaVTR", StrclAsistenciaVTR, false, false, 350, 70, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento", "Observaciones", W != null ? W.getComentarios() : "", "100", "3", true, true, 30, 110, "", true, true)%>
        <%=MyUtil.ObjInput("fecha de alta", "FechaRegistro", W != null ? W.getFechaRegistro() : "", false, false, 650, 70, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Datos Generales del Evento", 5, 15)%>

        <%=MyUtil.ObjInputF("Fecha de Solicitud (AAAA-MM-DD)", "FechaS", W != null ? W.getFechaS() : "", true, true, 30, iY + 200, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Numero de Personas", "NoPersonas", W != null ? W.getNoPersonas() : "", true, true, 260, iY + 200, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Limite de Gastos", "LimiteGastos", W != null ? W.getLimiteGastos() : "", true, true, 420, iY + 200, "", false, false, 20)%>
        <%=MyUtil.ObjTextArea("Detalle de la Solicitud", "DetalleSolicitud", W != null ? W.getDetalleSolicitud() : "", "100", "20", true, true, 30, iY + 250, "", false, false)%>
        <%=MyUtil.DoBlock("Descripcion WOW", 100, 220)%>

        <%=MyUtil.ObjComboC("Forma de Pago:", "clTipoPago", W != null ? W.getdsTipoPago() : "", true, true, 30, 570, "", "select clTipoPago,dsTipoPago from CSTipoPago", "fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Nombre del Banco:", "NomBanco", W != null ? W.getNomBanco() : "", true, true, 220, 570, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Nombre en TC:", "NombreTC", W != null ? W.getNombreTC() : "", true, true, 470, 570, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Numero de TC:", "NumeroTC", W != null ? W.getNumeroTC() : "", false, false, 30, 610, "", false, false, 50, "if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        <%=MyUtil.ObjInput("Exp.D.:(MM/AA)", "ExpiraVTR", W != null ? W.getExpira() : "", false, false, 350, 610, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
        <input type="hidden" name="Expira" id="Expira" value= "<%=W != null ? W.getExpira().trim() : ""%>">
        <%=MyUtil.ObjInput("Sec.C.:", "SecC", W != null ? W.getSecC() : "", false, false, 440, 610, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Confirmo", "Confirmo", W != null ? W.getConfirmo() : "", true, true, 30, 650, "", false, false, 30)%>
        <%=MyUtil.ObjInput("No.Conf.:", "NConfirmo", W != null ? W.getNConfirmo() : "", true, true, 350, 650, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Pol.Cancelación", "PCancel", W != null ? W.getPCancel() : "", true, true, 30, 690, "", false, false, 50)%>
        <%=MyUtil.ObjChkBox("N/U inf.:", "NuInf", W != null ? W.getNuInf() : "", true, true, 350, 690, "", "SI", "NO", "")%>
        <%=MyUtil.DoBlock("Costos del Evento", 100, 10)%>

        <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>

           <%@ include file="csVentanaFlotante.jspf" %>
           
        <%=MyUtil.GeneraScripts()%>

 
      <script>
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

            function fnAntesGuardar(){
                //-------------------------   4   ----------------------------
    
                fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
                //------------------------------------------------------------
            }

 

        </script>

               <%    //<<<<<<<<<<<<<<<< Limpiar Variables >>>>>>>>>
                StrclUsr = null;
                StrclPaginaWeb = null;
                daoCSWow = null;
                W = null;
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
