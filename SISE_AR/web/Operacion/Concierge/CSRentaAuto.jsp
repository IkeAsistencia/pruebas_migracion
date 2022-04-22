<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOConciergeAuto,com.ike.concierge.to.Conciergeauto,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
    <head><title>Renta de Autos Exoticos/Lujo</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>        
    </head>
    <body class="cssBody" onload="fnVerificaFecha();fnServAds();fnLimpiaFechas();">
       
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script> 
        <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>        
        <script src='../../Utilerias/UtilCalendario.js'></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Renta de Autos (Convencional/Exoticos � de Lujo) </i></b>  <br> </p></div>
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

        //String strFechaApAsist="";

        DAOConciergeAuto daos=null;
        Conciergeauto conciergeauto=null;
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
        String StrclPaginaWeb = "735";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        if(strclUsr!=null){
            daos = new DAOConciergeAuto();
            conciergeauto= daos.getCSAuto(StrclAsistencia);
            
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
        MyUtil.InicializaParametrosC(735,Integer.parseInt(strclUsr)); 
        %><%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaAuto","fnAccionesAlta();","fnAntesGuardar();fnAdicional();fnValidaFecha();fnReqCampo();")%>

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
        <%String strEstatus = conciergeauto!=null ? conciergeauto.getDsEstatus() : ""; %>
        <!--%=MyUtil.ObjComboMem("Estatus","clEstatus",strEstatus,conciergeauto!=null ? conciergeauto.getEstatus() : "",cbEstatus.GeneraHTML(50,strEstatus),false,false,30,80,"0","","",50,false,false)%-->
        <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergeauto!=null ? conciergeauto.getDsEstatus(): "",false,false,30,80,"0","sp_GetCSstatus","","",30,false,false)%>
        <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,350,80,"",false,false,10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios",conciergeauto!=null ? conciergeauto.getComentarios().trim() :  "","83","3",true,true,30,120,"",true,true)%>
        <%=MyUtil.ObjInput("fecha de alta","FechaRegistro",conciergeauto!=null ? conciergeauto.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
        <%=MyUtil.DoBlock("Datos Generales del Usuario",10,10)%>
        
        <%=MyUtil.ObjInput("Vehiculo Solicitado","Vehiculo",conciergeauto!=null ? conciergeauto.getVehiculo().trim():  "",true,true,30,220,"",true,true,50)%>
        <%=MyUtil.ObjInput("Pasajeros","Pasajeros",conciergeauto!=null ? conciergeauto.getPasajeros().trim():  "",true,true,350,220,"",true,true,10)%>
        <%=MyUtil.ObjInput("Ciudad","Ciudad",conciergeauto!=null ? conciergeauto.getCiudad().trim() :  "",true,true,30,255,"",true,true,50)%>
        <%=MyUtil.ObjInput("Estado","Estado",conciergeauto!=null ? conciergeauto.getEstado().trim() :  "",true,true,350,255,"",true,true,50)%>
        <%=MyUtil.ObjInput("Pais","Pais",conciergeauto!=null ? conciergeauto.getPais().trim() :  "",true,true,650,255,"",true,true,50)%>
        <%=MyUtil.ObjInputF("Entrega <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaE",conciergeauto!=null ? conciergeauto.getFechaE().trim() : "",true,true,30,290,"",true,true,20, 2, "")%>  </div>    
        <%=MyUtil.ObjInput("Lugar entrega","LugarEn",conciergeauto!=null ? conciergeauto.getLugarEn().trim() : "",true,true,30,330,"",true,true,75)%>
        <%=MyUtil.ObjInputF("Devoluci�n <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaD",conciergeauto!=null ? conciergeauto.getFechaD().trim() : "",true,true,30,370,"",true,true,20, 2, "")%>  </div>    
        <%=MyUtil.ObjInput("Lugar de Devoluci�n","LugarDev",conciergeauto!=null ? conciergeauto.getLugarDev().trim() : "",true,true,30,410,"",true,true,75)%>
        <%=MyUtil.ObjInput("Costo por Hora/D�a","CostoH",conciergeauto!=null ? conciergeauto.getCostoH().trim() : "",true,true,30,450,"",false,false,10,"EsNumerico(this)")%>
        <%=MyUtil.ObjInput("Horas/Dias.:","HorasC", conciergeauto!=null ? conciergeauto.getHorasC().trim() : "",true,true,200,450,"",true,true,5,"EsNumerico(this)")%>
        <%=MyUtil.ObjInput("Cargo Total:","CargoT",conciergeauto!=null ? conciergeauto.getCargoT().trim() : "",true,true,350,450,"",false,false,10,"EsNumerico(this)")%>    
        <%=MyUtil.ObjInput("Adicionales","Adicionales",conciergeauto!=null ? conciergeauto.getAdicionales().trim() : "",false,false,30,490,"",false,false,75)%>
        <%=MyUtil.ObjChkBox("Serv. Ads","SolAdic",conciergeauto!=null ? conciergeauto.getSolAdic().trim() : "",true,true,450,490,"","SI","NO","fnServAds()")%>        
        <%=MyUtil.ObjInput("Hotel & Tel.:","Hotel",conciergeauto!=null ? conciergeauto.getHotel().trim() : "",true,true,30,530,"",false,false,75)%>
        <%=MyUtil.ObjInputF("Check-In <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaI",conciergeauto!=null ? conciergeauto.getFechaI().trim() : "",true,true,450,530,"",false,false,20, 2, "fnVerificaFecha();")%>  </div>
        <%=MyUtil.ObjInput("Rva. a nombre","Reservacion", conciergeauto!=null ? conciergeauto.getReservacion().trim() : "",true,true,30,570,"",false,false,75)%>
        <%=MyUtil.ObjInputF("Check-Out <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaO", conciergeauto!=null ? conciergeauto.getFechaO().trim() : "",true,true,450,570,"",false,false,20, 2, "fnVerificaFecha();")%>  
        <%=MyUtil.ObjComboC("Forma de Pago:","clTipoPago", conciergeauto!=null ? conciergeauto.getDsTipoPago() : "",true,true,30,610,"","select clTipoPago,dsTipoPago from CSTipoPago","fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();","",30,false,false)%>
        <%=MyUtil.ObjInput("Nombre del Banco:","NomBanco",conciergeauto!=null ? conciergeauto.getNomBanco() : "",false,false,350,610,"",false,false,40)%>
        <%=MyUtil.ObjInput("Nombre en TC:","NombreTC",  conciergeauto!=null ? conciergeauto.getNombreTC().trim() : "",false,false,600,610,"",false,false,30)%>
        <%=MyUtil.ObjInput("Numero de TC:","NumeroTC", conciergeauto!=null ? conciergeauto.getNumeroTC().trim() : "",false,false,30,650,"",false,false,40,"if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        <%=MyUtil.ObjInput("Exp.D.:(MM/AA)","ExpiraVTR", conciergeauto!=null ? conciergeauto.getExpira().trim() : "",false,false,350,650,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
        <input type="hidden" name="Expira" id="Expira" value="<%=conciergeauto!=null ? conciergeauto.getExpira2().trim() : ""%>">
        <%=MyUtil.ObjInput("Sec.C.:","SecC", conciergeauto!=null ? conciergeauto.getSecC().trim() : "",false,false,460,650,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Confirmo","Confirmo", conciergeauto!=null ? conciergeauto.getConfirmo().trim() : "",true,true,30,690,"",false,false,30)%>
        <%=MyUtil.ObjInput("No.Conf.:","NConfirmo", conciergeauto!=null ? conciergeauto.getNConfirmo().trim() : "",true,true,350,690,"",false,false,30,"")%>
        <%=MyUtil.ObjInput("Pol.Cancelaci�n","PCancel", conciergeauto!=null ? conciergeauto.getPCancel().trim() : "",true,true,30,730,"",false,false,50)%>
        <%=MyUtil.ObjChkBox("N/U inf.:","NuInf", conciergeauto!=null ? conciergeauto.getNuInf().trim(): "",true,true,350,730,"" ,"SI","NO","")%>
        <%=MyUtil.DoBlock("Forma de Pago",100,0)%>
        
        <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='FechaProgMskI' id='FechaProgMskI' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
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
              
            function fnValidaFecha() {
                /*if (document.all.FechaI.value!='' && document.all.FechaO.value!= '') {
                    if (document.all.FechaO.value <= document.all.FechaI.value) {
                        msgVal = msgVal + " Check-Out debe de ser mayor a Check-In. "
                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    }

                }*/
                if (document.all.FechaE.value!='' && document.all.FechaD.value!= ''){
                    if (document.all.FechaD.value <= document.all.FechaE.value){
                        msgVal = msgVal + " La fecha de Devolucion debe de ser Mayor a la fecha de Entrega "
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
                if (document.all.SolAdic.value==1){
                    if(document.all.Adicionales.value==""){
                        msgVal = msgVal + " Debe Ingresar Adicionales. ";
                        document.all.btnGuarda.disabled=false;
                        document.all.btnCancela.disabled=false;
                    }
                }
                /*else{
                document.all.Adicionales.value="";
                }*/
            }

            //funci�n antes de guardar
            function fnAntesGuardar(){
                if (document.all.clEstatus.value==10 ) {
                    if (document.all.CostoH.value==0 ) { msgVal = msgVal + " Costo por Hora/D�a";}
                    if (document.all.CargoT.value==0 ) { msgVal = msgVal + " Cargo Total";}
                    document.all.btnGuarda.disabled=false;
                    document.all.btnCancela.disabled=false;
                }
                /*   if (document.all.FechaI.value==''){
                miFecha = new Date();
                document.all.FechaI.value=miFecha.getYear()+"-"+(miFecha.getMonth()+1)+"-"+miFecha.getDate();
                }*/
                //..........................................44444444444444444444444444
                fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
                //..........................................44444444444444444444444444
            }

            //Funcion para validar fecha
            function fnReqHoraWow(){
                var StrFechaWow = document.all.FechaI.value;
                //alert(document.all.clWowC.value);
                /*if (document.all.clWowC.value==6){
                    document.all.FechaIMsk.value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00';
                }else {*/
                document.all.FechaI.value=StrFechaWow.substring(0,10);
                //document.all.FechaIMsk.value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09';
                //}
            }

            //Funci�n para quitarle los cero a la fecha
            function fnVerificaFecha() {
                //document.all.FechaE.value=fnFechaID(document.all.FechaE.value);
                //document.all.FechaD.value=fnFechaID(document.all.FechaD.value);
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

            //Funcion que hace requeribles adicionales dependiendo de la accion
            function fnServAds(){
                if ((document.all.SolAdic.value==1) && (document.all.Action.value==1)){
                    document.all.Adicionales.className="Freq";
                    document.all.Adicionales.value="";
                    document.all.Adicionales.readOnly=false;
                }else{
                    document.all.Adicionales.className="VTable";
                    document.all.Adicionales.readOnly=false;
                }
                //if(document.all.SolAdic.value==0) document.all.Adicionales.value="";
            }
            
            //Funci�n para limpiar las fechas
            function fnLimpiaFechas(){
                if (document.all.FechaI.value=="1900-01-01"){
                    document.all.FechaI.value="";
                }else{
                    document.all.FechaI.value=fnFechaID(document.all.FechaI.value);
                }
                if (document.all.FechaO.value=="1900-01-01"){
                    document.all.FechaO.value="";
                }else {
                    document.all.FechaO.value=fnFechaID(document.all.FechaO.value);
                }
            }
        </script>
        <script type="text/javascript">
            initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
        </script>
        <%
        //StrclConcierge = null;
        //StrclSubservicio = null;
        StrclAsistencia = null;
        daos=null;
        conciergeauto=null;
        daosg=null;
        conciergeg=null;
        daoRef=null;
        ref=null;
        %>
    </body>
</html>