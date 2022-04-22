<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOConciergeTransp,com.ike.concierge.to.Conciergetransp,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>

<html>
    <head><title>Reservacion de Transportacion (Ejecutiva/Convencional)</title>
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
        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Reservacion de Transportaci�n (Ejecutiva / Convencional)</i></b>  <br> </p></div>
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

        DAOConciergeTransp daos=null;
        Conciergetransp conciergetransp=null;
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
        String StrclPaginaWeb = "747";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        if(strclUsr!=null){
            daos = new DAOConciergeTransp();
            conciergetransp= daos.getCSTransportacion(StrclAsistencia);
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
        if (rs.next()){
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
        <script>fnOpenLinks()</script>
        <%
        MyUtil.InicializaParametrosC(747,Integer.parseInt(strclUsr));
        %><%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaTransportacion","fnAccionesAlta();","fnAntesGuardar();fnAdicional();fnValidaFecha();fnReqCampo();")%>

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
        <%String strEstatus = conciergetransp!=null ? conciergetransp.getDsEstatus() : ""; %>
        <!--%=MyUtil.ObjComboMem("Estatus","clEstatus",strEstatus,conciergetransp!=null ? conciergetransp.getEstatus() : "",cbEstatus.GeneraHTML(50,strEstatus),false,true,30,80,"0","","",50,false,true)%-->
        <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergetransp!=null ? conciergetransp.getDsEstatus(): "",false,false,30,80, "0","sp_GetCSstatus","","",30,false,false)%>
        <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,350,80,"",false,false,10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios",conciergetransp!=null ? conciergetransp.getComentarios().trim():  "","83","3",true,true,30,120,"",true,true)%>
        <%=MyUtil.ObjInput("fecha de alta","FechaRegistro",conciergetransp!=null ? conciergetransp.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
        <%=MyUtil.DoBlock("Datos Generales del Usuario",10,10)%>
    
        <%=MyUtil.ObjInput("No.adultos","Nadultos",conciergetransp!=null ? conciergetransp.getNadultos().trim():"",true,true,30,220,"",true,true,5)%>
        <%=MyUtil.ObjChkBox("Ni�os","Ninos",conciergetransp!=null ? conciergetransp.getNinos().trim():"",true,true,130,220,"","SI","NO","EdadesNinos()")%>
        <%=MyUtil.ObjInput("Edades","Edades",conciergetransp!=null ? conciergetransp.getEdades().trim():"",true,true,220,220,"",false,false,10)%>
        <%=MyUtil.ObjInput("Vehiculo","Vehiculo",conciergetransp!=null ? conciergetransp.getVehiculo().trim():"",true,true,30,260,"",true,true,30)%>
        <%=MyUtil.ObjInput("Equipaje","Equipaje",conciergetransp!=null ? conciergetransp.getEquipaje().trim():"",true,true,220,260,"",true,true,20)%>
        <%=MyUtil.ObjInputF("Fecha y Hora <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaC",conciergetransp!=null ? conciergetransp.getFechaC().trim():"",true,true,30,300,"",true,true,20, 2, "")%>  </div>
        <%=MyUtil.ObjInput("Origen","Origen",conciergetransp!=null ? conciergetransp.getOrigen().trim():"",true,true,30,340,"",true,true,75)%>
        <%=MyUtil.ObjInput("Destino","Destino",conciergetransp!=null ? conciergetransp.getDestino().trim():"",true,true,30,380,"",false,false,75)%>
        <%=MyUtil.ObjInput("Costo por Hora","CostoH",conciergetransp!=null ? conciergetransp.getCostoH().trim():"",true,true,30,420,"",false,false,10)%>
        <%=MyUtil.ObjInput("Horas Conf","HorasC",conciergetransp!=null ? conciergetransp.getHorasC().trim():"",true,true,200,420,"",false,false,10)%>
        <%=MyUtil.ObjInput("Otros Cargos","OtrosC",conciergetransp!=null ? conciergetransp.getOtrosC().trim():"",true,true,350,420,"",false,false,10)%>
        <%=MyUtil.ObjInput("Punto de Encuentro","Encuentro",conciergetransp!=null ? conciergetransp.getEncuentro().trim():"",true,true,30,460,"",false,false,75)%>
        <%=MyUtil.ObjInput("Cargo Total","CargoT",conciergetransp!=null ? conciergetransp.getCargoT().trim():"",true,true,450,460,"",false,false,10)%>
        <%=MyUtil.ObjInput("Hotel & Tel.:","Hotel",conciergetransp!=null ? conciergetransp.getHotel().trim():"",true,true,30,500,"",false,false,75)%>
        <%=MyUtil.ObjInputF("Check-In <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaI", conciergetransp!=null ? conciergetransp.getFechaI().trim():"",true,true,450,500,"",false,false,20, 2, "fnVerificaFecha();")%>  </div>
        <%=MyUtil.ObjInput("Rva. a nombre","Reservacion",conciergetransp!=null ? conciergetransp.getReservacion().trim():"",true,true,30,540,"",false,false,75)%>
        <%=MyUtil.ObjInputF("Check-Out <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaO",conciergetransp!=null ? conciergetransp.getFechaO().trim():"",true,true,450,540,"",false,false,20, 2, "fnVerificaFecha();")%>  </div>
        <%=MyUtil.DoBlock("Reservacion de Transportaci�n (Ejecutiva / Convencional)",100,5)%>
        <%=MyUtil.ObjComboC("Forma de Pago:","clTipoPago",conciergetransp!=null ? conciergetransp.getDsTipoPago():"",true,true,30,630,"","select clTipoPago,dsTipoPago from CSTipoPago","fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();","",30,false,false)%>
        <%=MyUtil.ObjInput("Nombre del Banco:","NomBanco",conciergetransp!=null ? conciergetransp.getNomBanco():"",false,false,200,630,"",false,false,40)%>
        <%=MyUtil.ObjInput("Nombre en TC:","NombreTC", conciergetransp!=null ? conciergetransp.getNombreTC().trim():"",false,false,440,630,"",false,false,30)%>
        <%=MyUtil.ObjInput("Numero de TC:","NumeroTC", conciergetransp!=null ? conciergetransp.getNumeroTC().trim():"",false,false,30,670,"",false,false,50,"if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        <%=MyUtil.ObjInput("Exp.D.:(MM/AA)","ExpiraVTR",conciergetransp!=null ? conciergetransp.getExpira().trim():"",false,false,350,670,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
        <input type="hidden" name="Expira" id="Expira" value="<%=conciergetransp!=null ? conciergetransp.getExpira2().trim(): ""%>">
        <%=MyUtil.ObjInput("Sec.C.:","SecC", conciergetransp!=null ? conciergetransp.getSecC().trim():"",false,false,440,670,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Confirmo","Confirmo",conciergetransp!=null ? conciergetransp.getConfirmo().trim():"",true,true,30,710,"",false,false,30)%>
        <%=MyUtil.ObjInput("No.Conf.:","NConfirmo",conciergetransp!=null ? conciergetransp.getNConfirmo().trim():"",true,true,350,710,"",false,false,30,"")%>
        <%=MyUtil.ObjInput("Pol.Cancelaci�n","PCancel",conciergetransp!=null ? conciergetransp.getPCancel().trim():"",true,true,30,750,"",false,false,50)%>
        <%=MyUtil.ObjChkBox("N/U inf.:","NuInf",conciergetransp!=null ? conciergetransp.getNuInf().trim():"",true,true,350,750,"","SI","NO","")%>
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
        //StrclConcierge = null;
        //StrclSubservicio = null;
        StrclAsistencia = null;
        daos=null;
        conciergetransp=null;
        daosg=null;
        conciergeg=null;
        daoRef=null;
        ref=null;
        %>
        <%=MyUtil.GeneraScripts()%>
        <script>
	
        		top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
		top.document.all.rightPO.rows="0,80,*";
                
        document.all.SecC.maxLength=4;

        function fnValidaFecha(){
            if (document.all.FechaI.value!='' && document.all.FechaO.value!= ''){
                if (document.all.FechaO.value < document.all.FechaI.value){
                    msgVal = msgVal + " Check-Out debe de ser mayor o igual a Check-In. "
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
            }
            else{
                document.all.Edades.value="";
            }
        }

        //funci�n antes de guardar
        function fnAntesGuardar(){
            if (document.all.clEstatus.value==10 ) {
                if (document.all.Encuentro.value==0 ) { msgVal = msgVal + " Punto de Encuentro";}
                if (document.all.Origen.value==0 ) { msgVal = msgVal + " Origen";}
                if (document.all.CargoT.value==0 ) { msgVal = msgVal + " Cargo Total";}
                document.all.btnGuarda.disabled=false;
                document.all.btnCancela.disabled=false;
            }
            /*
            if (document.all.FechaI.value==''){
                miFecha = new Date();
                document.all.FechaI.value=miFecha.getYear()+"-"+(miFecha.getMonth()+1)+"-"+miFecha.getDate();
            }
            if (document.all.FechaO.value==''){
                miFechaO = new Date();
                document.all.FechaO.value='';
            }
            */
            //..........................................44444444444444444444444444
            fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
            //..........................................44444444444444444444444444
        }

        //Funci�n para quitarle los cero a la fecha
        function fnVerificaFecha() {
             //document.all.FechaC.value=fnFechaID(document.all.FechaC.value);
             document.all.FechaI.value=fnFechaID(document.all.FechaI.value);
             document.all.FechaO.value=fnFechaID(document.all.FechaO.value);
        }

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

        //Funcion que hace requeribles las edades de los ni�os dependiendo de la accion
        function EdadesNinos(){
            if ((document.all.Ninos.value==1) && (document.all.Action.value==1)){
                document.all.Edades.className="Freq";
            }
            else{
                document.all.Edades.className="VTable";
        }
        }
                          
        //Funci�n para limpiar las fechas
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
</body>
</html>