<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOConciergeResta,com.ike.concierge.to.Conciergeresta,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
    <head><title>Reservacion de Restaurante</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>        
    </head>
    <body class="cssBody" onload="fnVerificaFecha();fnLimpiaFechas(); fnMuestraSMS();">
        
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script> 
        <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i>Reservación de Restaurante</i></b>  <br> </p></div>
        <script src='../../Utilerias/UtilCalendario.js'></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">

        <div class='VTable' style='position:absolute; z-index:25; left:570px; top:93px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Automatica </i></b>  <br> </p></div>
        <%
        String StrclConcierge = "";
        String StrclSubservicio = "";
        String StrclAsistencia = "0";
        String strclUsr = "";

        //1111111111111111111111111111111----
        String StrURL="";
        String StrNomPag = "";

        if (request.getRequestURL()!= null) {
            StrURL = request.getRequestURL().toString();
            StrNomPag = StrURL.substring(StrURL.lastIndexOf("/")+1) ;
            System.out.println("URL RQ(getRequestURL): ........................................... "+StrURL);
            System.out.println("Pagina.................................... "+StrNomPag);
        }
        //-------------------------------

        DAOConciergeResta daos=null;
        Conciergeresta conciergeresta=null;
        DAOConciergeG daosg=null;
        ConciergeG conciergeg=null;
        
        DAOReferenciasxAsist daoRef=null;
        ReferenciasxAsist ref=null;  
        
        if (session.getAttribute("clUsrApp")!= null) {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }
        
        if (session.getAttribute("clConcierge")!= null) {
            StrclConcierge= session.getAttribute("clConcierge").toString();
        }
        if (request.getParameter("clAsistencia")!= null) {
            StrclAsistencia= request.getParameter("clAsistencia").toString();
        } else{
            if (session.getAttribute("clAsistencia")!= null) {
                StrclAsistencia= session.getAttribute("clAsistencia").toString();
            }
        }
        if (request.getParameter("clSubservicio")!= null) {
            StrclSubservicio= request.getParameter("clSubservicio").toString();
        } else{
            if (session.getAttribute("clSubservicio")!= null) {
                StrclSubservicio= session.getAttribute("clSubservicio").toString();
            }
        }
        session.setAttribute("clAsistencia",StrclAsistencia);
        session.setAttribute("clSubservicio",StrclSubservicio);
        String StrclPaginaWeb = "744";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        if(strclUsr!=null){
            daos = new DAOConciergeResta();
            conciergeresta= daos.getCSRestaurant(StrclAsistencia);
            daoRef = new DAOReferenciasxAsist();
            ref = daoRef.getclAsistencia(StrclAsistencia);
        }
        if(strclUsr!=null){
            daosg = new DAOConciergeG();
            conciergeg = daosg.getConciergeGenerico(StrclConcierge);
        }

        //----------------------------2222222222222222222
        ResultSet rs = null;
        String StrPreguntaEncuesta = "0";

        rs = UtileriasBDF.rsSQLNP("sp_CSPreguntaEncuesta "+StrclConcierge);
        if (rs.next()) {
           StrPreguntaEncuesta = rs.getString("Pregunta").toString();
        }
        rs.close();
        rs = null;
        //-----------------------------
        //OBTIENE LA CUENTA DEPENDIENDO DEL CLCONCIERGE
        ResultSet rsCTA = null;
        String StrclCuenta = "0";

        rsCTA = UtileriasBDF.rsSQLNP("select clCuenta from CSConcierge where clConcierge = "+StrclConcierge);
        if (rsCTA.next()) {
           StrclCuenta = rsCTA.getString("clCuenta").toString();
        }
        rsCTA.close();
        rsCTA = null;
        //-----------------------------
		
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
        <script>fnOpenLinks()</script>
        <%        
        MyUtil.InicializaParametrosC(744,Integer.parseInt(strclUsr)); 
        %><%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaRestaurante","fnAccionesAlta();","fnAntesGuardar();fnValidaFecha();fnAdicional();fnReqCampo();")%><%

        %>

        <%--.....................................33333333333333333333333333333--%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>'>
        <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
        <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
        <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
        <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
        <INPUT id='clCuenta' name='clCuenta' type='hidden' value='<%=StrclCuenta%>'>
        <%--.....................................33333333333333333333333333333--%>


        <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
        <%String strEstatus = conciergeresta!=null ? conciergeresta.getDsEstatus() : ""; %>
        
        <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergeresta!=null ? conciergeresta.getDsEstatus(): "",false,false,30,80,"0","sp_GetCSstatus","","",30,false,false)%>
        <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,350,80, "",false,false,10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios",conciergeresta!=null ? conciergeresta.getComentarios() :"","83","3",true,true,30,120,"",true,true)%>
        <%=MyUtil.ObjInput("fecha de alta","FechaRegistro",conciergeresta!=null ? conciergeresta.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
        <%=MyUtil.DoBlock("Datos Generales del Usuario",10,10)%>
        
        <%=MyUtil.ObjInput("No.adultos","Nadultos",conciergeresta!=null ? conciergeresta.getNadultos() : "",true,true,30,220,"",true,true,5)%>
        <%=MyUtil.ObjChkBox("Niños","Ninos",conciergeresta!=null ? conciergeresta.getNinos() : "",true,true,130,220,"","SI","NO","EdadesNinos();")%>
        <%=MyUtil.ObjInput("Edades","Edades",conciergeresta!=null ? conciergeresta.getEdades(): "",true,true,220,220,"",false,false,10)%>
        <%=MyUtil.ObjInputF("Fecha Deseada <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaD",conciergeresta!=null ? conciergeresta.getFechaD() : "",true,true,30,260,"",true,true,20, 2, "")%>     
        
        <div id="dataSMS" name="dataSMS" style='visibility:hidden'>
                <%=MyUtil.ObjInput("Código","Codigo",conciergeresta!=null ? conciergeresta.getCodigo() : "",true,true,300,260,"",false,false,5)%>
                <%=MyUtil.ObjInput("Teléfono","Telefono",conciergeresta!=null ? conciergeresta.getTelefono() : "",true,true,400,260,"",false,false,10)%>
            </div>
        <div id="btnSMS" name="btnSMS" style='position:absolute; z-index:25; left:505px; top:269px; visibility:hidden'>
                <INPUT type='button' value='SMS Reminder' class='cBtn' onClick="fnEnviaSMS();">
            </div>        
        
        <!--%=MyUtil.ObjInputF("Fecha Confirmada <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaC",conciergeresta!=null ? conciergeresta.getFechaC() : "",true,true,30,300,"",false,false,20, 2, "")%-->     
        <%=MyUtil.ObjInput("Ocasión Especial","Ocasion",conciergeresta!=null ? conciergeresta.getOcasion(): "",true,true,30,300,"",true,true,50,"")%>
        <%=MyUtil.ObjComboC("Fumar","clSeccion",conciergeresta!=null ? conciergeresta.getDsSeccion(): "",true,true,350,300,"","select clSeccion,dsSeccion from CSSeccion","","",30,true,true)%>
        
        <%=MyUtil.ObjComboC("Restaurantes","clCallRest",conciergeresta!=null ? conciergeresta.getDsCallRest(): "",true,true,30,340,"","select clCallRest,dsCallRest from CScRestaurantes","fnLlenaRest();","",50,true,true)%>
        
        <%=MyUtil.ObjInput("Restaurante Elegido","Hotel", conciergeresta!=null ? conciergeresta.getHotel(): "",true,true,30,380,"",true,false,50)%>
        <!--%=MyUtil.ObjInputF("Check-In <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaI",conciergeresta!=null ? conciergeresta.getFechaI() : "",true,true,450,380,"",false,false,20, 2, "fnVerificaFecha();")%-->  
        <%=MyUtil.ObjInput("Rva. a nombre","Reservacion",conciergeresta!=null ? conciergeresta.getReservacion() : "",true,true,30,420,"",true,false,75)%>
        <!--%=MyUtil.ObjInputF("Check-Out <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaO",conciergeresta!=null ? conciergeresta.getFechaO() : "",true,true,450,420,"",false,false,20, 2, "fnVerificaFecha();")%-->         
        <%=MyUtil.ObjComboC("Forma de Pago:","clTipoPago",conciergeresta!=null ? conciergeresta.getDsTipoPago(): "",true,true,30,460,"","select clTipoPago,dsTipoPago from CSTipoPago","fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();","",30,false,false)%>
        <%=MyUtil.ObjInput("Nombre del Banco:","NomBanco",conciergeresta!=null ? conciergeresta.getNomBanco() :"",false,false,200,460,"",false,false,40)%>
        <%=MyUtil.ObjInput("Nombre en TC:","NombreTC",conciergeresta!=null ? conciergeresta.getNombreTC() : "",false,false,450,460,"",false,false,30)%>
        <%=MyUtil.ObjInput("Numero de TC:","NumeroTC",conciergeresta!=null ? conciergeresta.getNumeroTC() : "",false,false,30,500,"",false,false,50,"if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        <%=MyUtil.ObjInput("Exp.D.:(MM/AA)","ExpiraVTR",conciergeresta!=null ? conciergeresta.getExpira() : "",false,false,350,500,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
        <input type="hidden" name="Expira" id="Expira" value="<%=conciergeresta!=null ? conciergeresta.getExpira2() : ""%>">
        <%=MyUtil.ObjInput("Sec.C.:","SecC",conciergeresta!=null ? conciergeresta.getSecC() : "",false,false,440,500,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Confirmo","Confirmo",conciergeresta!=null ? conciergeresta.getConfirmo(): "",true,true,30,540,"",false,false,30)%>
        <%=MyUtil.ObjInput("No.Conf.:","NConfirmo",conciergeresta!=null ? conciergeresta.getNConfirmo(): "",true,true,350,540,"",false,false,30,"")%>
        <%=MyUtil.ObjInput("Pol.Cancelación","PCancel",conciergeresta!=null ? conciergeresta.getPCancel(): "",true,true,30,580,"",false,false,50)%>
        <%=MyUtil.ObjChkBox("N/U inf.:","NuInf",conciergeresta!=null ? conciergeresta.getNuInf(): "",true,true,350,580,"" ,"SI","NO","")%>
        <%=MyUtil.ObjInput("Tolerancia","Tolerancia",conciergeresta!=null ? conciergeresta.getTolerancia() : "",true,true,30,620,"",false,false,50)%>
        <%=MyUtil.DoBlock("Reservación de Restaurante",100,0)%>
        
        <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='FechaProgMskI' id='FechaProgMskI' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>
        <input name='FechaIniMsk' id='FechaIniMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        
    <%@ include file="csVentanaFlotante.jspf" %>
        <%
        //aqui estaban el nulleo de variables
        %>
        <%=MyUtil.GeneraScripts()%>
       
        <script>
                        
	    top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
	    top.document.all.rightPO.rows="0,80,*";
            function fnValidaFecha(){
//                if (document.all.FechaI.value!='' && document.all.FechaO.value!= ''){
//                    if (document.all.FechaO.value < document.all.FechaI.value){
//                        msgVal = msgVal + " Check-Out debe de ser mayor o igual a Check-In. "
//                        document.all.btnGuarda.disabled = false;
//                        document.all.btnCancela.disabled = false;
//                    }
//
//                }
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
            function fnAdicional(){
                if (document.all.Ninos.value==1){
                    if(document.all.Edades.value==""){
                        msgVal = msgVal + " Debe Ingresar Edades. ";
                        document.all.btnGuarda.disabled=false;
                        document.all.btnCancela.disabled=false;
                    }
                }
                else{
                    document.all.Edades.value="";
                }
            }

            //función antes de guardar
            function fnAntesGuardar(){
                if (document.all.clEstatus.value==10 ) {
                    //if (document.all.FechaC.value==0 ) { msgVal = msgVal + " Fecha Confirmada";}
                    document.all.btnGuarda.disabled=false;
                    document.all.btnCancela.disabled=false;
                }
                //..........................................44444444444444444444444444
                fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
                //..........................................44444444444444444444444444
            }
            //Función para quitarle los cero a la fecha
            function fnVerificaFecha() {
                 //document.all.FechaD.value=fnFechaID(document.all.FechaD.value);
                 //document.all.FechaC.value=fnFechaID(document.all.FechaC.value);
                 //document.all.FechaI.value=fnFechaID(document.all.FechaI.value);
                 //document.all.FechaO.value=fnFechaID(document.all.FechaO.value);
                 //document.all.FechaC.value=fnFechaID(document.all.FechaC.value);
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

            //Funcion que hace requeribles las edades de los niños dependiendo de la accion
            function EdadesNinos(){
                if ((document.all.Ninos.value==1) && (document.all.Action.value==1)){
                    document.all.Edades.className="Freq";
                    document.all.Edades.value="";
                    document.all.Edades.readOnly=false;
                }
                else{
                    document.all.Edades.className="VTable";
                    document.all.Edades.readOnly=false;
                }
                if(document.all.Ninos.value==0) document.all.Edades.value="";
            }

            //Función para limpiar las fechas
            function fnLimpiaFechas(){
//                if (document.all.FechaI.value=="1900-01-01"){
//                    document.all.FechaI.value="";
//                }
//                else {
//                    document.all.FechaI.value=fnFechaID(document.all.FechaI.value);
//                }
//                if (document.all.FechaO.value=="1900-01-01"){
//                    document.all.FechaO.value="";
//                }
//                else {
//                    document.all.FechaO.value=fnFechaID(document.all.FechaO.value);
//                }
//
//                 if (document.all.FechaC.value=="1900-01-01"){
//                    document.all.FechaC.value="";
//                }
//                else {
//                    document.all.FechaC.value=fnFechaID(document.all.FechaC.value);
//                }
            }
            
            function fnMuestraSMS(){
            if ((document.all.clCuenta.value=="1353")|| (document.all.clCuenta.value=="1354")){
                   document.all.dataSMS.style.visibility = 'hidden';
                   document.all.btnSMS.style.visibility = 'hidden';
                }
                else {
                   document.all.dataSMS.style.visibility = 'visible';
                   document.all.btnSMS.style.visibility = 'visible';
               }
                
            }
            
            function fnLlenaRest(){
                
               var StrRest = document.all.clCallRest.value;
               var StrdsRest = document.getElementById('clCallRestC').options[document.getElementById('clCallRestC').selectedIndex].text;
                if (StrRest != "1") {
                    document.all.Hotel.value = StrdsRest;
                }else{
                    document.all.Hotel.value = "";
                }
            }
                        
            function fnEnviaSMS() {
              
                var mensaje;
                var opcion = confirm("Se enviará SMS");
                if (opcion == true){
                  var strCadena = "../../servlet/Utilerias.RegistraSMSConcierge?clAsistencia=" + document.all.AsistenciaVTR.value +
                  "&Nadultos=" + document.all.Nadultos.value + 
                  "&FechaD=" + document.all.FechaD.value + 
                  "&Hotel=" + document.all.Hotel.value + 
                  "&Reservacion=" + document.all.Reservacion.value +
                  "&Codigo=" + document.all.Codigo.value +
                  "&Telefono=" + document.all.Telefono.value;
                  window.open(strCadena, "newWin", "scrollbars=no,status=yes,width=1,height=1"); 
                  mensaje="SMS enviado";
                } else {
                    mensaje="SMS no enviado";
                  }             
            }
            
        </script>
        <script type="text/javascript">
                initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
        </script>
        <%
        StrclConcierge = null;
        StrclSubservicio = null;
        StrclAsistencia = null;
        daos=null;
        conciergeresta=null;
        daosg=null;
        conciergeg=null;
        daoRef=null;
        ref=null;
        %>

    </body>
</html>