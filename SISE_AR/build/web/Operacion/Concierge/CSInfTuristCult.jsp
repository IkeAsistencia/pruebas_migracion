<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOConciergeInfTuristCult,com.ike.concierge.to.ConciergeInfTuristCult,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>

<html>
<head><title>Informaci�nTur�sticas / Cultural</title>
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
    <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Informaci�n Tur�stica / Cultural </i></b>  <br> </p></div>
    <script src='../../Utilerias/UtilCalendario.js'></script>
    <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    <script src='../../Utilerias/UtilStore.js'></script>
    
    <div class='VTable' style='position:absolute; z-index:25; left:570px; top:93px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Autom�tica </i></b>  <br> </p></div>
    <%
    String StrclConcierge = "";
    String StrclSubservicio = "";
    String StrclAsistencia = "0";
    String strclUsr = "";
    String StrURL = "";
    String StrNomPag = "";
    String StrclPaginaWeb = "1432";
    String StrPreguntaEncuesta = "0";

    if(request.getRequestURL()!= null){
        StrURL = request.getRequestURL().toString();
        StrNomPag = StrURL.substring(StrURL.lastIndexOf("/")+1) ;
        System.out.println("URL RQ(getRequestURL): ........................................... "+StrURL);
        System.out.println("Pagina.................................... "+StrNomPag);
    }

    DAOConciergeInfTuristCult daos = null;
    ConciergeInfTuristCult ConciergeInfTC = null;
    DAOConciergeG daosg = null;
    ConciergeG conciergeg = null;
    DAOReferenciasxAsist daoRef = null;
    ReferenciasxAsist ref = null;

    if(session.getAttribute("clUsrApp") != null){
        strclUsr = session.getAttribute("clUsrApp").toString();
    }

    if(session.getAttribute("clConcierge") != null){
        StrclConcierge= session.getAttribute("clConcierge").toString();
    }

    if(request.getParameter("clAsistencia") != null){
        StrclAsistencia= request.getParameter("clAsistencia").toString();
    }else{
        if(session.getAttribute("clAsistencia") != null){
            StrclAsistencia= session.getAttribute("clAsistencia").toString();
        }
    }

    if(request.getParameter("clSubservicio") != null){
        StrclSubservicio= request.getParameter("clSubservicio").toString();
    }else{
        if(session.getAttribute("clSubservicio") != null){
            StrclSubservicio= session.getAttribute("clSubservicio").toString();
        }
    }

    session.setAttribute("clAsistencia",StrclAsistencia);
    session.setAttribute("clSubservicio",StrclSubservicio);
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);

    if(strclUsr!=null){
        daos = new DAOConciergeInfTuristCult();
        ConciergeInfTC= daos.getCSInfTuristCult(StrclAsistencia);
        daoRef = new DAOReferenciasxAsist();
        ref = daoRef.getclAsistencia(StrclAsistencia);
    }

    if(strclUsr!=null){
        daosg = new DAOConciergeG();
        conciergeg = daosg.getConciergeGenerico(StrclConcierge);
    }

    ResultSet rs = null;
    rs = UtileriasBDF.rsSQLNP("sp_CSPreguntaEncuesta "+StrclConcierge);

    if(rs.next()){
        StrPreguntaEncuesta = rs.getString("Pregunta").toString();
    }

    rs.close();
    rs = null;

    //<<<<<<<<<<<< Servlet Generico >>>>>>>>>>>
    String Store = "";
    Store = "st_GuardaCSInfTuristCult,st_ActualizaCSInfTuristCult";
    session.setAttribute("sp_Stores", Store);

    String Commit = "";
    Commit = "clAsistencia";
    session.setAttribute("Commit", Commit);
		
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
	
    %><script>fnOpenLinks()</script>
    <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb),Integer.parseInt(strclUsr));%>
    
    <%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "fnAccionesAlta();","fnsp_Guarda();fnAntesGuardar();fnValidaFecha();")%>

    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>'>
    <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">
    <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
    <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
    <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
    
    <input id="Secuencia" name="Secuencia" type="hidden" value=""><br>
    <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="clConcierge,FechaApAsist,clUsrApp,DescripcionEvento,FechaInicio,FechaFin,Menores,DescripMenores,SitiosInteres,EventosCult,EventosDep,MuseoGaleria,Parques,CentroComer,InfLocal,Requisitos,Otros,DescripOtros,Hotel,FechaI,Reservacion,FechaO,CargoT,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,Confirmo,NConfirmo,PCancel,NuInf">
    <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="clAsistencia,DescripcionEvento,FechaInicio,FechaFin,Menores,DescripMenores,SitiosInteres,EventosCult,EventosDep,MuseoGaleria,Parques,CentroComer,InfLocal,Requisitos,Otros,DescripOtros,Hotel,FechaI,Reservacion,FechaO,CargoT,clTipoPago,NomBanco,NombreTC,NumeroTC,Expira,SecC,Confirmo,NConfirmo,PCancel,NuInf,clEstatus">
    
    <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>
    <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
    <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
    <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>

    <%String strEstatus = ConciergeInfTC!=null ? ConciergeInfTC.getDsEstatus() : ""; %>
    <%=MyUtil.ObjComboC("Estatus","clEstatus",ConciergeInfTC!=null ? ConciergeInfTC.getDsEstatus(): "",false,false,30,80, "0","sp_GetCSstatus","","",30,false,false)%>
    <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,350,80,"",false,false,10)%>
    <%=MyUtil.ObjTextArea("Descripci�n De evento","DescripcionEvento",ConciergeInfTC!=null ? ConciergeInfTC.getDescripcionEvento().trim():  "","83","3",true,true,30,120,"",true,true)%>
    <%=MyUtil.ObjInput("Fecha de Apertura","FechaRegistro",ConciergeInfTC!=null ? ConciergeInfTC.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
    <%=MyUtil.DoBlock("atos Generales del Evento",10,10)%>
    
    <%=MyUtil.ObjInputF("In�cio de actividades <Strong>(AAAA-MM-DD)</Strong>","FechaInicio",ConciergeInfTC!=null ? ConciergeInfTC.getFechaInicio().trim():"",true,true,30,220,"",false,false,20, 2, "")%>
    <%=MyUtil.ObjInputF("termino de actividades <Strong>(AAAA-MM-DD)</Strong>","FechaFin",ConciergeInfTC!=null ? ConciergeInfTC.getFechaFin().trim():"",true,true,300,220,"",false,false,20, 2, "")%>
    <%=MyUtil.ObjChkBox("Ni�os","Menores",ConciergeInfTC!=null ? ConciergeInfTC.getMenores().trim():"",true,true,600,220,"","SI","NO","EdadesNinos()")%>
    <%=MyUtil.ObjInput("Edades","DescripMenores",ConciergeInfTC!=null ? ConciergeInfTC.getDescripMenores().trim():"",true,true,700,220,"",false,false,10)%>
    <%=MyUtil.ObjChkBox("Lugares de Interes","SitiosInteres",ConciergeInfTC!=null ? ConciergeInfTC.getSitiosInteres().trim():"",true,true,30,280,"","SI","NO","")%>
    <%=MyUtil.ObjChkBox("Eventos Culturales","EventosCult",ConciergeInfTC!=null ? ConciergeInfTC.getEventosCult().trim():"",true,true,300,280,"","SI","NO","")%>
    <%=MyUtil.ObjChkBox("Eventos Deportivos","EventosDep",ConciergeInfTC!=null ? ConciergeInfTC.getEventosDep().trim():"",true,true,600,280,"","SI","NO","")%>
    <%=MyUtil.ObjChkBox("Museos y Galerias","MuseoGaleria",ConciergeInfTC!=null ? ConciergeInfTC.getMuseoGaleria().trim():"",true,true,30,340,"","SI","NO","")%>
    <%=MyUtil.ObjChkBox("Parques recreativos","Parques",ConciergeInfTC!=null ? ConciergeInfTC.getParques().trim():"",true,true,300,340,"","SI","NO","")%>
    <%=MyUtil.ObjChkBox("Comercios","CentroComer",ConciergeInfTC!=null ? ConciergeInfTC.getCentroComer().trim():"",true,true,600,340,"","SI","NO","")%>
    <%=MyUtil.ObjChkBox("Costumbres / Informaci�n local","InfLocal",ConciergeInfTC!=null ? ConciergeInfTC.getInfLocal().trim():"",true,true,30,400,"","SI","NO","")%>
    <%=MyUtil.ObjChkBox("Requisitos de viaje","Requisitos",ConciergeInfTC!=null ? ConciergeInfTC.getRequisitos().trim():"",true,true,300,400,"","SI","NO","")%>
    <%=MyUtil.ObjChkBox("Otros","Otros",ConciergeInfTC!=null ? ConciergeInfTC.getOtros().trim():"",true,true,600,400,"","SI","NO","")%>
    <%=MyUtil.ObjInput("Descripci�n","DescripOtros",ConciergeInfTC!=null ? ConciergeInfTC.getDescripOtros().trim():"",true,true,700,400,"",false,false,30)%>
    <%=MyUtil.DoBlock("Detalle de Evento",-10,5)%>
    
    <%=MyUtil.ObjInput("Hotel & Tel.:","Hotel",ConciergeInfTC!=null ? ConciergeInfTC.getHotel().trim():"",true,true,30,500,"",false,false,75)%>
    <%=MyUtil.ObjInputF("Check-In <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaI", ConciergeInfTC!=null ? ConciergeInfTC.getFechaI().trim():"",true,true,450,500,"",false,false,20, 2, "fnVerificaFecha();")%>
    <%=MyUtil.ObjInput("RESERVAdo A","Reservacion",ConciergeInfTC!=null ? ConciergeInfTC.getReservacion().trim():"",true,true,30,540,"",false,false,75)%>
    <%=MyUtil.ObjInputF("Check-Out <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaO",ConciergeInfTC!=null ? ConciergeInfTC.getFechaO().trim():"",true,true,450,540,"",false,false,20, 2, "fnVerificaFecha();")%>
    <%=MyUtil.ObjInput("Costo Total","CargoT",ConciergeInfTC!=null ? ConciergeInfTC.getCargoT().trim():"",true,true,700,540,"",false,false,10)%>
    <%=MyUtil.DoBlock("Detalle de alojamento",-100,5)%>
    
    <%=MyUtil.ObjComboC("Tipo de Pago:","clTipoPago",ConciergeInfTC!=null ? ConciergeInfTC.getDsTipoPago():"",true,true,30,640,"","select clTipoPago,dsTipoPago from CSTipoPago","fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();","",30,false,false)%>
    <%=MyUtil.ObjInput("Nombre del Banco:","NomBanco",ConciergeInfTC!=null ? ConciergeInfTC.getNomBanco():"",false,false,200,640,"",false,false,40)%>
    <%=MyUtil.ObjInput("Nombre en TC:","NombreTC", ConciergeInfTC!=null ? ConciergeInfTC.getNombreTC().trim():"",false,false,440,640,"",false,false,30)%>
    <%=MyUtil.ObjInput("Numero de TC:","NumeroTC", ConciergeInfTC!=null ? ConciergeInfTC.getNumeroTC().trim():"",false,false,30,680,"",false,false,50,"if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
    <%=MyUtil.ObjInput("Exp.D.:(MM/AA)","ExpiraVTR",ConciergeInfTC!=null ? ConciergeInfTC.getExpira().trim():"",false,false,350,680,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
    <input type="hidden" name="Expira" id="Expira" value="<%=ConciergeInfTC!=null ? ConciergeInfTC.getExpira2().trim(): ""%>">
    <%=MyUtil.ObjInput("Sec.C.:","SecC", ConciergeInfTC!=null ? ConciergeInfTC.getSecC().trim():"",false,false,500,680,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
    <%=MyUtil.ObjInput("Confirmo","Confirmo",ConciergeInfTC!=null ? ConciergeInfTC.getConfirmo().trim():"",true,true,30,720,"",false,false,30)%>
    <%=MyUtil.ObjInput("No.Conf.:","NConfirmo",ConciergeInfTC!=null ? ConciergeInfTC.getNConfirmo().trim():"",true,true,350,720,"",false,false,30,"")%>
    <%=MyUtil.ObjInput("Pol.Cancelaci�n","PCancel",ConciergeInfTC!=null ? ConciergeInfTC.getPCancel().trim():"",true,true,30,760,"",false,false,50)%>
    <%=MyUtil.ObjChkBox("N/U inf.:","NuInf",ConciergeInfTC!=null ? ConciergeInfTC.getNuInf().trim():"",true,true,350,760,"","SI","NO","")%>
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
    daos = null;
    ConciergeInfTC = null;
    daosg = null;
    conciergeg = null;
    daoRef = null;
    ref = null;
    %>
    <%=MyUtil.GeneraScripts()%>
    <script>
        top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
        top.document.all.rightPO.rows="0,80,*";

        fnNewBitacora(2);
        document.all.SecC.maxLength=4;

        function fnValidaFecha(){
            if (document.all.FechaI.value!='' && document.all.FechaO.value!= ''){
                if (document.all.FechaO.value < document.all.FechaI.value){
                    msgVal = msgVal + " Check-Out deve ser maior ou igual a Check-In. "
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
            if (document.all.Menores.value==1){
                if(document.all.DescripMenores.value==""){
                    msgVal = msgVal + " Deve ingresar Descripci�n (Idades). ";
                    document.all.btnGuarda.disabled=false;
                    document.all.btnCancela.disabled=false;
                }
            }
            else{
                document.all.DescripMenores.value="";
            }
        }

        //funci�n antes de guardar
        function fnAntesGuardar(){
            if (document.all.clEstatus.value==10 ) {
                if (document.all.Encuentro.value==0 ) { msgVal = msgVal + " Ponto de Encontro";}
                if (document.all.Origen.value==0 ) { msgVal = msgVal + " Origem";}
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
            if ((document.all.Menores.value==1) && (document.all.Action.value==1)){
                document.all.DescripMenores.className="Freq";
            }
            else{
                document.all.DescripMenores.className="VTable";
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
        initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencia'),350,250,700,20,false,false,true,true,false);
    </script>        
</body>
</html>