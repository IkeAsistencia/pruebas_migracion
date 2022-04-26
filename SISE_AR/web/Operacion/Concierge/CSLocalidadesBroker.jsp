<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOConciergeLocalidades,com.ike.concierge.to.ConciergeLocalidades,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
<head><title>Localidades pars Broker</title>
    <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
    <script type="text/javascript">
            var floating_window_skin = 2;
    </script>
    <script type="text/javascript" src="floating_window_with_tabs.js"></script>        
</head>
<body class="cssBody" onload="fnLimpiaFechas();fnVerificaFecha();">

    <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
    <script src='../../Utilerias/Util.js' ></script>
    <script src='../../Utilerias/UtilMask.js'></script> 
    <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>    
    <script src='../../Utilerias/UtilCalendario.js'></script>
    <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Localidades por Broker </i></b>  <br> </p></div>
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


    DAOConciergeLocalidades daos=null;
    ConciergeLocalidades conciergeLocalidades=null;
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
    String StrclPaginaWeb = "732";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    if(strclUsr!=null){
    daos = new DAOConciergeLocalidades();
    conciergeLocalidades= daos.getCSLocalidades(StrclAsistencia);
    
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
    MyUtil.InicializaParametrosC(732,Integer.parseInt(strclUsr)); 
    %><%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaLocalidadesB","fnAccionesAlta();","fnAntesGuardar();fnAdicional();fnValidaFecha();fnReqCampo();")%>

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
    <%String strEstatus = conciergeLocalidades!=null ? conciergeLocalidades.getDsEstatus() : ""; %>
    <!--%=MyUtil.ObjComboMem("Estatus","clEstatus",strEstatus,conciergeLocalidades!=null ? conciergeLocalidades.getEstatus() : "",cbEstatus.GeneraHTML(50,strEstatus),false,false,30,80,"0","","",50,false,false)%-->
    <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergeLocalidades!=null ? conciergeLocalidades.getDsEstatus(): "",false,false,30,80,"0","sp_GetCSstatus","","",30,false,false)%>
    <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,350,80,"",false,false,10)%>
    <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios",conciergeLocalidades!=null ? conciergeLocalidades.getComentarios().trim() :  "","83","3",true,true,30,120,"",true,true)%>
    <%=MyUtil.ObjInput("fecha de alta","FechaRegistro",conciergeLocalidades!=null ? conciergeLocalidades.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
    <%=MyUtil.DoBlock("Datos Generales del Usuario",10,10)%>
    
    <%=MyUtil.ObjInput("No.adultos","Nadultos",conciergeLocalidades!=null ? conciergeLocalidades.getNadultos().trim() : "",true,true,30,220,"",true,true,5)%>
    <%=MyUtil.ObjChkBox("Niños","Ninos",conciergeLocalidades!=null ? conciergeLocalidades.getNinos().trim() : "",true,true,130,220,"","SI","NO","EdadesNinos();")%>
    <%=MyUtil.ObjInput("Edades","Edades",conciergeLocalidades!=null ? conciergeLocalidades.getEdades().trim() : "",true,true,220,220,"",false,false,10)%>
    <%=MyUtil.ObjInput("Evento / Show","Evento",conciergeLocalidades!=null ? conciergeLocalidades.getEvento().trim() : "",true,true,30,255,"",true,true,75)%>
    <%=MyUtil.ObjInputF("Fecha del Evento <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaE",conciergeLocalidades!=null ? conciergeLocalidades.getFechaE().trim() : "",true,true,450,255,"",true,true,20, 2, "")%>  </div>
    <%=MyUtil.ObjInput("Teatro / Sede","Teatro",conciergeLocalidades!=null ? conciergeLocalidades.getTeatro().trim() : "",true,true,30,285,"",true,true,75)%>
    <%=MyUtil.ObjInput("Direccion","Direccion",conciergeLocalidades!=null ? conciergeLocalidades.getDireccion().trim(): "",true,true,30,315,"",false,false,75)%>
    <%=MyUtil.ObjInput("Sección / Zona","Seccion",conciergeLocalidades!=null ? conciergeLocalidades.getSeccion().trim() : "",true,true,30,350,"",false,false,20)%>
    <%=MyUtil.ObjInput("Fila / Asiento","Fila",conciergeLocalidades!=null ? conciergeLocalidades.getFila().trim() : "",true,true,300,350,"",false,false,20)%>
    <%=MyUtil.ObjInput("Hotel & Tel.:","Hotel",conciergeLocalidades!=null ? conciergeLocalidades.getHotel().trim() : "",true,true,30,390,"",false,false,75)%>
    <%=MyUtil.ObjInputF("Check-In <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaI",conciergeLocalidades!=null ? conciergeLocalidades.getFechaI().trim() : "",true,true,450,390,"",false,false,20, 2, "fnVerificaFecha();")%>  </div>
    <%=MyUtil.ObjInput("Rva. a nombre","Reservacion",conciergeLocalidades!=null ? conciergeLocalidades.getReservacion().trim() : "",true,true,30,430,"",false,false,75)%>
    <%=MyUtil.ObjInputF("Check-Out <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaO",conciergeLocalidades!=null ? conciergeLocalidades.getFechaO().trim() : "",true,true,450,430,"",false,false,20, 2, "fnVerificaFecha();")%>  </div>
    <%=MyUtil.ObjInput("Face Value","Face",conciergeLocalidades!=null ? conciergeLocalidades.getFace().trim() : "",true,true,30,470,"",false,false,30)%>
    <%=MyUtil.ObjInput("Re-Sale","Sale",conciergeLocalidades!=null ? conciergeLocalidades.getSale().trim() : "",true,true,250,470,"",false,false,30)%>
    <%=MyUtil.DoBlock("Datos Generales del Evento",100,5)%>
    
    <%=MyUtil.ObjComboC("Forma de Pago:","clTipoPago",conciergeLocalidades!=null ? conciergeLocalidades.getDsTipoPago() : "",true,true,30,560,"","select clTipoPago,dsTipoPago from CSTipoPago","fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();","",30,false,false)%>
    <%=MyUtil.ObjInput("Nombre del Banco:","NomBanco",conciergeLocalidades!=null ? conciergeLocalidades.getNomBanco() : "",true,true,30,600,"",false,false,40)%>
    <%=MyUtil.ObjInput("Nombre en TC:","NombreTC",conciergeLocalidades!=null ? conciergeLocalidades.getNombreTC().trim() : "",true,true,300,560,"",false,false,40)%>
    <%=MyUtil.ObjInput("Cargo Total","CargoT",conciergeLocalidades!=null ? conciergeLocalidades.getCargoT().trim() : "",true,true,540,560,"",false,false,10)%>
    <%=MyUtil.ObjInput("Numero de TC:","NumeroTC",conciergeLocalidades!=null ? conciergeLocalidades.getNumeroTC().trim(): "",false,false,300,600,"",false,false,40,"if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
    <%=MyUtil.ObjInput("Exp.D.:(MM/AA)","ExpiraVTR",conciergeLocalidades!=null ? conciergeLocalidades.getExpira().trim() : "",false,false,540,600,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
    <input type="hidden" name="Expira" id="Expira" value="<%=conciergeLocalidades!=null ? conciergeLocalidades.getExpira2().trim() : ""%>">
    <%=MyUtil.ObjInput("Sec.C.:","SecC",conciergeLocalidades!=null ? conciergeLocalidades.getSecC() : "",false,false,650,600,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
    <%=MyUtil.ObjInput("Metodo Entrega","Metodo",conciergeLocalidades!=null ? conciergeLocalidades.getMetodo().trim() :"",true,true,30,640,"",false,false,50)%>
    <%=MyUtil.ObjInput("Confirmo","Confirmo", conciergeLocalidades!=null ? conciergeLocalidades.getConfirmo().trim() :"",true,true,30,680,"",false,false,30)%>
    <%=MyUtil.ObjInput("No.Conf.:","NConfirmo",conciergeLocalidades!=null ? conciergeLocalidades.getNConfirmo().trim() :"",true,true,350,680,"",false,false,30,"")%>
    <%=MyUtil.ObjInput("Pol.Cancelación","PCancel",conciergeLocalidades!=null ? conciergeLocalidades.getPCancel().trim() :"",true,true,30,720,"",false,false,50)%>
    <%=MyUtil.ObjChkBox("N/U inf.:","NuInf",conciergeLocalidades!=null ? conciergeLocalidades.getNuInf().trim() :"",true,true,350,720,"0","SI","NO","")%>
    <%=MyUtil.DoBlock("Forma de Pago",100,0)%>
    
    <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
    <input name='FechaProgMskI' id='FechaProgMskI' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09 '>
    <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
    <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
    <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>
    <input name='FechaIniMsk' id='FechaIniMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
    
    <%@ include file="csVentanaFlotante.jspf" %>

    <%

    //aqui estaban los null's
    
    %>
    <%=MyUtil.GeneraScripts()%>        
    <script>
	                top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
                  top.document.all.rightPO.rows="0,80,*";
				  
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
        }

        //función antes de guardar
        function fnAntesGuardar(){
            if (document.all.clEstatus.value==10 ) {
                if (document.all.Direccion.value==0 ) { msgVal = msgVal + " Dirección";}
                if (document.all.Seccion.value==0 ) { msgVal = msgVal + " Sección";}
                if (document.all.Fila.value==0 ) { msgVal = msgVal + " Fila";}
                if (document.all.Sale.value==0 ) { msgVal = msgVal + " Re-sale";}
                if (document.all.CargoT.value==0 ) { msgVal = msgVal + " Cargo Total";}
                document.all.btnGuarda.disabled=false;
                document.all.btnCancela.disabled=false;
            }
          /*  if (document.all.FechaI.value==''){
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
             //document.all.FechaE.value=fnFechaID(document.all.FechaE.value);
             document.all.FechaI.value=fnFechaID(document.all.FechaI.value);
             document.all.FechaO.value=fnFechaID(document.all.FechaO.value);
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
            }else{
                document.all.Edades.className="VTable";
                document.all.Edades.readOnly=false;
             }
             if(document.all.Ninos.value==0) document.all.Edades.value="";
        }
        /////////////////////
        //Función para limpiar las fechas
        function fnLimpiaFechas(){
            if (document.all.FechaI.value=="1900-01-01 00:00"){
                document.all.FechaI.value="";
            }
            else {
                document.all.FechaI.value=fnFechaID(document.all.FechaI.value);
            }
            if (document.all.FechaO.value=="1900-01-01 00:00"){
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
    conciergeLocalidades=null;
    daosg=null;
    conciergeg=null;
    daoRef=null;
    ref=null;
    %>
</body>
</html>