<%--
    Document   : CSPreventa
    Created on : 02/10/2010
    Author     : rfernandez
--%>


<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOConciergePreventa,com.ike.concierge.to.ConciergePreventa,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist,com.ike.concierge.DAOCSConcierto,com.ike.concierge.to.CSConcierto" errorPage="" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,javax.servlet.http.HttpSession,java.sql.ResultSet"%>
<html>
    <head>
        <title>CSPreventa</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" OnLoad="if (document.all.ExpiraVTR.value!=''){fnFechVen(document.all.ExpiraVTR.value)}">

        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <script src='../../Utilerias/UtilCalendario.js'></script>
        <script src='../../Utilerias/UtilStore.js'></script>

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> PREEVENTA </i></b></font><br></p></div>
        <div class='VTable' style='position:absolute; z-index:25; left:570px; top:83px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Automatica </i></b></font><br></p></div>
                <%
                        String StrclConcierge = "";
                        String StrclSubservicio = "";
                        String StrclAsistencia = "0";
                        String strclUsr = "";
                        String strclPreventa = "";
                        String strclConcierto = "";

                        boolean btnAut1 = false;
                        boolean btnAut2 = false;


                        //1111111111111111111111111111111----
                        String StrURL = "";
                        String StrNomPag = "";

                        if (request.getRequestURL() != null) {
                            StrURL = request.getRequestURL().toString();
                            StrNomPag = StrURL.substring(StrURL.lastIndexOf("/") + 1);
                            System.out.println("URL RQ(getRequestURL): ........................................... " + StrURL);
                            System.out.println("Pagina.................................... " + StrNomPag);
                        }

                        //-------------------------------

                        DAOConciergePreventa daoConciergePreventa = null;
                        ConciergePreventa Preventa = null;

                        DAOReferenciasxAsist daoRef = null;
                        ReferenciasxAsist ref = null;

                        DAOConciergeG daosg = null;
                        ConciergeG conciergeg = null;

                        DAOCSConcierto daoCSC = null;
                        CSConcierto CSC = null;


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

                        String StrclPaginaWeb = "1230";
                        session.setAttribute("clPaginaWebP", StrclPaginaWeb);

                        //<<<<<<<<<<<< Servlet Generico >>>>>>>>>>>
                        String Store = "";
                        Store = "st_GuardaCSPreventa,st_ActualizaCSPreventa";
                        session.setAttribute("sp_Stores", Store);

                        String Commit = "";
                        Commit = "clAsistencia";
                        session.setAttribute("Commit", Commit);

                        if (strclUsr != null) {
                            daoConciergePreventa = new DAOConciergePreventa();
                            Preventa = daoConciergePreventa.getConciergePreventa(StrclAsistencia);
                        }
                        if (strclUsr != null) {
                            daosg = new DAOConciergeG();
                            conciergeg = daosg.getConciergeGenerico(StrclConcierge);
                        }
                        if (strclUsr != null) {
                            daoRef = new DAOReferenciasxAsist();
                            ref = daoRef.getclAsistencia(StrclAsistencia);
                        }
                        String StrclConcierto = Preventa != null ? Preventa.getclConcierto() : "";


                        //----------------------------2222222222222222222
                        ResultSet rs1 = null;
                        String StrPreguntaEncuesta = "0";

                        rs1 = UtileriasBDF.rsSQLNP("sp_CSPreguntaEncuesta " + StrclConcierge);
                        if (rs1.next()) {
                            StrPreguntaEncuesta = rs1.getString("Pregunta").toString();
                        }
                        rs1.close();
                        rs1 = null;

                        //-----------------------------


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

                %>
        <script>fnOpenLinks()</script>  
        <%
                MyUtil.InicializaParametrosC(1230, Integer.parseInt(strclUsr));
        %><%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "fnAccionesAlta();", "fnsp_Guarda();fnAntesGuardar(),fnReqCampo();")%><%

        %>

        <!--%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%>< %=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)% >< %="CSPreventa.jsp?'>"%-->

        <%--.....................................33333333333333333333333333333--%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>'>
        <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
        <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
        <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
        <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
        <%--.....................................33333333333333333333333333333--%>


        <input id="Secuencia"  name="Secuencia"  type="hidden" value="">
        <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="clConcierge,FechaApAsist,clUsrApp,Descripcion,FechaEvento,Direccion,Ciudad,Estado,Pais,Telefono,Celular,CostoH,HorasC,CargoT,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,PagoO,Confirmo,NConfirmo,PCancel,NuInf,Observaciones,clConcierto">
        <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clAsistencia,Descripcion,FechaEvento,Direccion,Ciudad,Estado,Pais,Telefono,Celular,CostoH,HorasC,CargoT,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,PagoO,Confirmo,NConfirmo,PCancel,NuInf,Observaciones,clEstatus,clConcierto">

        <INPUT id='clConcierge'  name='clConcierge'  type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>

        <%String strEstatus = Preventa != null ? Preventa.getDsEstatus() : "";%>

        <!--%=MyUtil.ObjComboMem("Estatus","clEstatus",strEstatus,P!=null ? P.getEstatus() : "",cbEstatus.GeneraHTML(50,strEstatus),false,true,30,80,"0","","",50,false,true)%-->
        <%=MyUtil.ObjComboC("Estatus", "clEstatus", Preventa != null ? Preventa.getDsEstatus() : "", false, false, 30, 70, "", "sp_GetCSstatus", "", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Asistencia", "AsistenciaVTR", StrclAsistenciaVTR, false, false, 350, 70, "", false, false, 10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento", "Observaciones", Preventa != null ? Preventa.getComentarios() : "", "83", "3", true, true, 30, 110, "", true, true)%>
        <%=MyUtil.ObjInput("fecha de alta", "FechaA", Preventa != null ? Preventa.getFechaRegistro() : "", false, false, 650, 70, "", false, false, 20)%>
        <%=MyUtil.ObjComboC("Tipo Concierto", "clConcierto", Preventa != null ? Preventa.getdsConcierto() : "", true, true, 500, 110, "", "st_CSGetConcierto " + StrclAsistencia, "", "", 20, true, true)%>
        <div class='VTable' style='position:absolute; z-index:40; left:500px; top:155px; visibility:visible' id="BtnConcierto">
            <input type="button" onClick="fnConcierto();" class="cBtn" value="Concierto">
        </div>



        <%=MyUtil.DoBlock("Datos Generales del Evento", 25, 25)%>
        <%=MyUtil.ObjInput("Descripción", "Descripcion", Preventa != null ? Preventa.getDescripcion() : "", true, true, 30, 220, "", false, false, 70)%>
        <%=MyUtil.ObjInputF("Fecha del Evento<strong>(aaaa/mm/dd hh:mm)</strong>", "FechaEvento", Preventa != null ? Preventa.getFechaEvento() : "", true, true, 450, 220, "", false, false, 20, 2, "")%>
        <%=MyUtil.ObjInput("Direccion", "Direccion", Preventa != null ? Preventa.getDireccion() : "", true, true, 30, 260, "", false, false, 70)%>
        <%=MyUtil.ObjInput("Ciudad", "Ciudad", Preventa != null ? Preventa.getCiudad() : "", true, true, 30, 300, "", false, false, 50)%>
        <%=MyUtil.ObjInput("Estado", "Estado", Preventa != null ? Preventa.getEstado() : "", true, true, 350, 300, "", false, false, 50)%>
        <%=MyUtil.ObjInput("Pais", "Pais", Preventa != null ? Preventa.getPais() : "", true, true, 650, 300, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Teléfono", "Telefono", Preventa != null ? Preventa.getTelefono() : "", true, true, 30, 340, "", false, false, 25)%>
        <%=MyUtil.ObjInput("Celular", "Celular", Preventa != null ? Preventa.getCelular() : "", true, true, 350, 340, "", false, false, 25)%>
        <%=MyUtil.DoBlock("Datos Generales del Evento", 100, 5)%>

        <%=MyUtil.ObjInput("Costo por Hora", "CostoH", Preventa != null ? Preventa.getCostoH() : "", true, true, 30, 430, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Horas Conf.:", "HorasC", Preventa != null ? Preventa.getHorasC() : "", true, true, 150, 430, "", false, false, 5)%>
        <%=MyUtil.ObjInput("Cargo Total:", "CargoT", Preventa != null ? Preventa.getCargoT() : "", true, true, 350, 430, "", false, false, 10)%>
        <%=MyUtil.ObjComboC("Forma de Pago:", "clTipoPago", Preventa != null ? Preventa.getDsTipoPago() : "", true, true, 30, 470, "", "select clTipoPago,dsTipoPago from CSTipoPago", "fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Nombre del Banco:", "NomBanco", Preventa != null ? Preventa.getNomBanco() : "", true, true, 30, 510, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Nombre en TC:", "NombreTC", Preventa != null ? Preventa.getNombreTC() : "", true, true, 350, 510, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Numero de TC:", "NumeroTC", Preventa != null ? Preventa.getNumeroTC() : "", false, false, 30, 550, "", false, false, 50, "if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        <%=MyUtil.ObjInput("Exp.D.:(MM/AA)", "ExpiraVTR", Preventa != null ? Preventa.getExpira() : "", false, false, 350, 550, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
        <input type="hidden" name="Expira" id="Expira" value= "<%=Preventa != null ? Preventa.getExpira().trim() : ""%>">
        <%=MyUtil.ObjInput("Sec.C.:", "SecC", Preventa != null ? Preventa.getSecC() : "", false, false, 440, 550, "", false, false, 10, "if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Otra Forma de Pago", "PagoO", Preventa != null ? Preventa.getPagoO() : "", true, true, 30, 590, "", false, false, 50)%>
        <%=MyUtil.ObjInput("Confirmo", "Confirmo", Preventa != null ? Preventa.getConfirmo() : "", true, true, 30, 630, "", false, false, 30)%>
        <%=MyUtil.ObjInput("No.Conf.:", "NConfirmo", Preventa != null ? Preventa.getNConfirmo() : "", true, true, 350, 630, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Pol.Cancelación", "PCancel", Preventa != null ? Preventa.getPCancel() : "", true, true, 30, 670, "", false, false, 50)%>
        <%=MyUtil.ObjChkBox("N/U inf.:", "NuInf", Preventa != null ? Preventa.getNuInf() : "", true, true, 350, 670, "", "SI", "NO", "")%>
        <%=MyUtil.DoBlock("Costos del Evento", 100, 20)%>
        <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>

        <%@ include file="csVentanaFlotante.jspf" %>

        <%
                StrclConcierge = null;
                StrclSubservicio = null;
                StrclAsistencia = null;
                Preventa = null;
                daosg = null;
                conciergeg = null;
                daoRef = null;
                ref = null;
        %>
        <%=MyUtil.GeneraScripts()%>
        <script>

            top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
            top.document.all.rightPO.rows="0,80,*";
		
            function fnAccionesAlta(){
                if (document.all.Action.value==1){

                    var pstrCadena = "../../Utilerias/RegresaFechaActual.jsp";
                    window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');

                }
                fnActualizaConcierto ();
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
            //función antes de guardar
            function fnAntesGuardar(){
                if (document.all.clEstatus.value==10 ) {
                    if (document.all.CostoH.value==0 ) { msgVal = msgVal + " Costo X Hora";}
                    if (document.all.HorasC.value==0 ) { msgVal = msgVal + " Horas Confirmadas";}
                    if (document.all.CargoT.value==0 ) { msgVal = msgVal + " Cargo Total";}
                    document.all.btnGuarda.disabled=false;
                    document.all.btnCancela.disabled=false;
                    //..........................................44444444444444444444444444
                    fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value);
                    //..........................................44444444444444444444444444
                }
                //..........................................44444444444444444444444444
                fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
                //..........................................44444444444444444444444444
                
                if (document.all.FechaEvento.value==''){
                    miFecha = new Date();
                    document.all.FechaEvento.value=miFecha.getYear()+"-"+(miFecha.getMonth()+1)+"-"+miFecha.getDate();
                }              
                /*  if (document.all.FechaO.value==''){
                       miFechaO = new Date();
                       document.all.FechaO.value='';
                    }    */

            }

            //Función para quitarle los cero a la fecha
            function fnVerificaFecha() {
                document.all.FechaEvento.value=fnFechaID(document.all.FechaEvento.value);

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

            function fnLlenaDespuesdeGuardarConcierto(Descripcion){

                // alert(Concierto);
                if (Descripcion=='Concierto'){
                    fnActualizaConcierto();
                }
            }

            function fnConcierto(){
                if(document.all.Action.value==1 || document.all.Action.value==2 ){

                    document.all.clConciertoC.value='';document.all.clConcierto.value=0;
                    window.open('../Concierge/CSConcierto.jsp?dsConcierto='+ document.all.clConcierto.value,'WinConcierto','scrollbars=yes,status=yes,width=650,height=180');
                }
            }

            function fnActualizaConcierto (){
                var strConsulta = "st_CSGetConcierto 0";
                var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=clConciertoC";
                fnOptionxDefault('clConciertoC',pstrCadena);

            }

            function fnActivaConcierto(Aut){

                window.open('ActivacionCSConcierto.jsp?clConcierto='+ document.all.clConcierto.value+"&Aut="+Aut,'WinAutConcierto','scrollbars=yes,status=yes,width=650,height=180');
            }

        </script>
        <script type="text/javascript">
            initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
        </script>
    </body>
</html>
