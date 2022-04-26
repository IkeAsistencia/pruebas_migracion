<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOconciergepicko,com.ike.concierge.to.Conciergepicko,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
<head><title>Reservacion de Pick Up en Aeropuerto (One Way)</title>
    <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
    <script type="text/javascript">
            var floating_window_skin = 2;
    </script>
    <script type="text/javascript" src="floating_window_with_tabs.js"></script>        
</head>
<body class="cssBody" onload="fnVerificaFecha();fnLimpiaFechas();">

    <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
    <script src='../../Utilerias/Util.js' ></script>
    <script src='../../Utilerias/UtilMask.js'></script> 
    <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>
    <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Reservación de Pick Up en Aeropuerto(One Way) </i></b>  <br> </p></div>
    <script src='../../Utilerias/UtilCalendarioV.js'></script>
    <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">

    <div class='VTable' style='position:absolute; z-index:25; left:570px; top:93px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Automatica </i></b>  <br> </p></div>
    <%
    String StrclConcierge = "";
    String StrclSubservicio = "";
    String StrclAsistencia = "0";
    String strclUsr = "";
    String strclPickUpO="0";

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

    DAOconciergepicko daos=null;
    Conciergepicko conciergepicko=null;
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
    String StrclPaginaWeb = "742";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    if(strclUsr!=null){
        daos = new DAOconciergepicko();
        conciergepicko= daos.getCSPuO(StrclAsistencia);
        
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
    <SCRIPT>fnOpenLinks()</script> 
    <%        
    MyUtil.InicializaParametrosC(742,Integer.parseInt(strclUsr)); 
    %><%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaPickUpO","fnAccionesAlta();","fnAntesGuardar();fnAdicional();fnValidaFecha();fnReqCampo();")%>

    <%--.....................................33333333333333333333333333333--%>

    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>'>
    <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
    <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
    <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
    <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
    <%--.....................................33333333333333333333333333333--%>

    <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
    <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
    <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
    <%String strEstatus = conciergepicko!=null ? conciergepicko.getDsEstatus() : "";
             strclPickUpO = conciergepicko!=null ? conciergepicko.getClPickUpO() : "";
    %>
    <INPUT id='clPickUpO' name='clPickUpO' type='hidden' value='<%=strclPickUpO%>'>
    <!--%=MyUtil.ObjComboMem("Estatus","clEstatus",strEstatus,conciergepicko!=null ? conciergepicko.getEstatus() : "",cbEstatus.GeneraHTML(50,strEstatus),false,true,30,80,"0","","",50,false,true)%-->
    <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergepicko!=null ? conciergepicko.getDsEstatus(): "",false,false,30,80, "0","sp_GetCSstatus","","",30,false,false)%>
    <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,350,80, "",false,false,10)%>
    <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios",conciergepicko!=null ? conciergepicko.getComentarios():"","83","3",true,true,30,120,"",true,true)%>
    <%=MyUtil.ObjInput("fecha de alta","FechaRegistro",conciergepicko!=null ? conciergepicko.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
    <%=MyUtil.DoBlock("Datos Generales del Usuario",10,10)%>
    
    <%=MyUtil.ObjInput("No.adultos","Nadultos",conciergepicko!=null ? conciergepicko.getNadultos():"",true,true,30,220,"",true,true,5)%>
    <%=MyUtil.ObjChkBox("Niños","Ninos",conciergepicko!=null ? conciergepicko.getNinos():"",true,true,130,220,"","SI","NO","EdadesNinos()")%>
    <%=MyUtil.ObjInput("Edades","Edades",conciergepicko!=null ? conciergepicko.getEdades():"",true,true,220,220,"",false,false,10)%>
    <%=MyUtil.ObjInput("Vehículo Solicitado","Vehiculo", conciergepicko!=null ? conciergepicko.getVehiculo():"",true,true,30,260,"",true,true,25)%>
    <%=MyUtil.ObjInput("Equipaje","Equipaje",conciergepicko!=null ? conciergepicko.getEquipaje(): "",true,true,200,260,"",true,true,25)%>
    <%=MyUtil.ObjInput("Info Vuelo","Vuelo",conciergepicko!=null ? conciergepicko.getVuelo(): "",true,true,370,260,"",true,true,25)%>
    <%=MyUtil.ObjInputF("Fecha<Strong>(AAAA-MM-DD)</Strong>","Fecha",conciergepicko!=null ? conciergepicko.getFecha():"",true,true,540,260,"",true,true,20, 2, "fnVerificaFecha();")%>  </div>
    <%=MyUtil.ObjInput("Horario Arribo","FechaA",conciergepicko!=null ? conciergepicko.getFechaA():"",true,true,30,300,"",true,true,5,"if(this.readOnly==false){fnValMask(this,document.all.FechaProgMskS.value,this.name)}")%>  </div>
    <%=MyUtil.ObjInput("Ciudad de Origen","Origen",conciergepicko!=null ? conciergepicko.getOrigen():"",true,true,200,300,"",true,true,25)%>
    <%=MyUtil.ObjInput("Ciudad de Arribo","CiudadA",conciergepicko!=null ? conciergepicko.getCiudadA():"",true,true,370,300,"",true,true,25)%>
    <%=MyUtil.ObjInput("Aeropuerto y/o terminal","Aeropuerto",conciergepicko!=null ? conciergepicko.getAeropuerto():"",true,true,540,300,"",true,true,25)%>
    <%=MyUtil.ObjInput("Punto de Encuentro","Encuentro",conciergepicko!=null ? conciergepicko.getEncuentro() :"",true,true,30,340,"",false,false,60)%>
    <%=MyUtil.ObjInput("Cargo Total","CargoT",conciergepicko!=null ? conciergepicko.getCargoT():"",true,true,370,340,"",false,false,10)%>
    <%=MyUtil.ObjInput("Adicionales","Adicionales",conciergepicko!=null ? conciergepicko.getAdicionales():"",true,false,30,380,"",false,false,60)%>
    <%=MyUtil.ObjChkBox("Serv. Ads","ServAds",conciergepicko!=null ? conciergepicko.getServAds():"",true,true,370,380,"","SI","NO","fnServAds()")%>
    <%if (!StrclAsistencia.equalsIgnoreCase("0") && !StrclAsistencia.equalsIgnoreCase(null)){%>
        <div id='RoundT' name='RoundT' class='VTable' style='position:absolute; z-index:27; left:500px; top:392px;'>
        <input class='cBtn'  type='button' id='RT'  name='RT'  value='Round Trip' onClick="fnRoundTrip()"></input></div>
        <%}%>
    <%=MyUtil.ObjInput("Destino","Destino",conciergepicko!=null ? conciergepicko.getDestino():"",true,true,30,420,"",true,true,75)%>
    <%=MyUtil.ObjInput("Hotel & Tel.:","Hotel",conciergepicko!=null ? conciergepicko.getHotel():"",true,true,30,460,"",false,false,75)%>
    <%=MyUtil.ObjInputF("Check-In <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaI",conciergepicko!=null ? conciergepicko.getFechaI():"",true,true,450,460,"",false,false,20, 2, "fnVerificaFecha();")%>  </div>
    <%=MyUtil.ObjInput("Rva. a nombre","Reservacion",conciergepicko!=null ? conciergepicko.getReservacion():"",true,true,30,500,"",false,false,75)%>
    <%=MyUtil.ObjInputF("Check-Out <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaO",conciergepicko!=null ? conciergepicko.getFechaO():"",true,true,450,500,"",false,false,20, 2, "fnVerificaFecha();")%>  </div>
    <%=MyUtil.DoBlock("Reservación de Pick Up en Aeropuerto (One Way) ",100,5)%>
    
    <%=MyUtil.ObjComboC("Forma de Pago:","clTipoPago",conciergepicko!=null ? conciergepicko.getDsTipoPago():"",true,true,30,600,"","select clTipoPago,dsTipoPago from CSTipoPago","fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();","",30,false,false)%>
    <%=MyUtil.ObjInput("Nombre del Banco:","NomBanco",conciergepicko!=null ? conciergepicko.getNomBanco():"",false,false,200,600,"",false,false,40)%>
    <%=MyUtil.ObjInput("Nombre en TC:","NombreTC",conciergepicko!=null ? conciergepicko.getNombreTC():"",false,false,440,600,"",false,false,30)%>
    <%=MyUtil.ObjInput("Numero de TC:","NumeroTC",conciergepicko!=null ? conciergepicko.getNumeroTC():"",false,false,30,640, "",false,false,50,"if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
    <%=MyUtil.ObjInput("Exp.D.:(MM/AA)","ExpiraVTR",conciergepicko!=null ? conciergepicko.getExpira():"",false,false,350,640,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
    <input type="hidden" name="Expira" id="Expira" value="<%=conciergepicko!=null ? conciergepicko.getExpira2():""%>">
    <%=MyUtil.ObjInput("Sec.C.:","SecC", conciergepicko!=null ? conciergepicko.getSecC():"",false,false,440,640,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
    <%=MyUtil.ObjInput("Confirmo","Confirmo",conciergepicko!=null ? conciergepicko.getConfirmo():"",true,true,30,680,"",false,false,30)%>
    <%=MyUtil.ObjInput("No.Conf.:","NConfirmo",conciergepicko!=null ? conciergepicko.getNConfirmo():"",true,true,350,680,"",false,false,30,"")%>
    <%=MyUtil.ObjInput("Pol.Cancelación","PCancel",conciergepicko!=null ? conciergepicko.getPCancel():"",true,true,30,720,"",false,false,50)%>
    <%=MyUtil.ObjChkBox("N/U inf.:","NuInf",conciergepicko!=null ? conciergepicko.getNuInf():"",true,true,350,720,"","SI","NO","")%>
    <%=MyUtil.DoBlock("Forma de Pago",100,0)%>
    
    <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
    <input name='FechaProgMskI' id='FechaProgMskI' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
    <input name='FechaProgMskS' id='FechaProgMskS' type='hidden' value='VN09VN09F:/:VN09VN09'>
    <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
    <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
    <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>
    <input name='FechaIniMsk' id='FechaIniMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
    <%@ include file="csVentanaFlotante.jspf" %>

    <%
    //Aqui estaban los null's, los envie al final despues del SCRIPT ATS-10-01-2010
    %>
    <%=MyUtil.GeneraScripts()%>        
    <script>
		top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
		top.document.all.rightPO.rows="0,80,*";
	
        document.all.SecC.maxLength=4;
        function fnValidaFecha(){
            if (document.all.FechaI.value!='' && document.all.FechaO.value!= ''){
                if (document.all.FechaO.value <= document.all.FechaI.value){
                    msgVal = msgVal + " Check-Out debe de ser mayor a Check-In. "
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

        function fnAdicional(){
            if (document.all.Ninos.value==1){
                if(document.all.Edades.value==""){
                    msgVal = msgVal + " Debe Ingresar Edades. ";
                    document.all.btnGuarda.disabled=false;
                    document.all.btnCancela.disabled=false;
                }
            }else{
                document.all.Edades.value="";
            }
            if (document.all.ServAds.value==1){
                if(document.all.Adicionales.value==""){
                    msgVal = msgVal + " Debe Ingresar Adicionales. ";
                    document.all.btnGuarda.disabled=false;
                    document.all.btnCancela.disabled=false;
                }
            }else{
                document.all.Edades.value="";
            }
        }
        function fnRoundTrip(){
            if (document.all.Action.value==2 ){
                location.href='CSPickUpR.jsp?clPickUpO=<%=strclPickUpO%>';
            }
        }

        //función antes de guardar
        function fnAntesGuardar(){
            if (document.all.clEstatus.value==10 ) {
                if (document.all.Encuentro.value==0 ) { msgVal = msgVal + " Punto de Encuentro";}
                if (document.all.CargoT.value==0 ) { msgVal = msgVal + " Cargo Total";}
                document.all.btnGuarda.disabled=false;
                document.all.btnCancela.disabled=false;
            }
            /* if (document.all.FechaI.value==''){
               miFecha = new Date();
               document.all.FechaI.value=miFecha.getYear()+"-"+(miFecha.getMonth()+1)+"-"+miFecha.getDate();
            }
            if (document.all.FechaO.value==''){
               miFechaO = new Date();
               document.all.FechaO.value='';
            }    */
            //..........................................44444444444444444444444444
            fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
            //..........................................44444444444444444444444444
        }

        //Función para quitarle los cero a la fecha
        function fnVerificaFecha() {
             document.all.FechaI.value=fnFechaID(document.all.FechaI.value);
             document.all.FechaO.value=fnFechaID(document.all.FechaO.value);
             document.all.Fecha.value=fnFechaID(document.all.Fecha.value);
        }

        //función que regresa la fecha sin hora
        function fnFechaID(Fecha){
            if (Fecha!=""){
              FechaSinHora=Fecha;
              FechaSinHora=FechaSinHora.substring(0,10);
              return FechaSinHora;
            }else {
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
            }else{
                document.all.Edades.className="VTable";
                document.all.Edades.readOnly=false;
            }
            if(document.all.Ninos.value==0) document.all.Edades.value="";
        }
        //Funcion que hace requeribles adicionales dependiendo de la accion
        function fnServAds(){
            if ((document.all.ServAds.value==1) && (document.all.Action.value==1)){
                document.all.Adicionales.className="Freq";
            }else{
                document.all.Adicionales.className="VTable";
                document.all.Adicionales.readOnly=false;
            }
            if(document.all.ServAds.value==0) document.all.Adicionales.value="";
        }
        //Función para limpiar las fechas
        function fnLimpiaFechas(){
            if (document.all.FechaI.value=="1900-01-01"){
                document.all.FechaI.value="";
            }
            else {
                document.all.FechaI.value=fnFechaID(document.all.FechaI.value);
            }
            if (document.all.FechaO.value=="1900-01-01"){
                document.all.FechaO.value="";
            }
            else {
                document.all.FechaO.value=fnFechaID(document.all.FechaO.value);
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
    conciergepicko=null;
    daosg=null;
    conciergeg=null;
    daoRef=null;
    ref=null;
    %>
</body>
</html>