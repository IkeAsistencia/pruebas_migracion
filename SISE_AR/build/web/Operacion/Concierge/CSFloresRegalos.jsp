<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOConciergeFlores,com.ike.concierge.to.Conciergeflores,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
<head><title>Flores o Regalos</title>
    <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
    <script type="text/javascript">
            var floating_window_skin = 2;
    </script>
    <script type="text/javascript" src="floating_window_with_tabs.js"></script>        
</head>
<body class="cssBody" onload="">
 
    <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
    <script src='../../Utilerias/Util.js' ></script>
    <script src='../../Utilerias/UtilMask.js'></script> 
    <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>    
    <script src='../../Utilerias/UtilCalendario.js'></script>
    <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Flores o Regalos </i></b>  <br> </p></div>
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

    DAOConciergeFlores daos=null;
    Conciergeflores conciergeflores=null;
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
    String StrclPaginaWeb = "730";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    if(strclUsr!=null){
        daos = new DAOConciergeFlores();
        conciergeflores= daos.getCSFlores(StrclAsistencia);
        
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
    MyUtil.InicializaParametrosC(730,Integer.parseInt(strclUsr)); 
    %>
    <%=MyUtil.doMenuActPost("../../servlet/Concierge.CSAltaFlores","fnAccionesAlta();","fnAntesGuardar();fnReqCampo();")%>

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
    <%String strEstatus = conciergeflores!=null ? conciergeflores.getDsEstatus() : ""; %>
    <!--%=MyUtil.ObjComboMem("Estatus","clEstatus",strEstatus,conciergeflores!=null ? conciergeflores.getEstatus() : "",cbEstatus.GeneraHTML(50,strEstatus),false,true,30,80,"0","","",50,false,true)%-->
    <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergeflores!=null ? conciergeflores.getDsEstatus(): "",false,false,30,80,"0","sp_GetCSstatus","","",30,false,false)%>
    <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,350,80,"",false,false,10)%>
    <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios", conciergeflores!=null ? conciergeflores.getComentarios(): "","83","3",true,true,30,120,"",true,true)%>
    <%=MyUtil.ObjInput("fecha de alta","FechaRegistro",conciergeflores!=null ? conciergeflores.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
    <%=MyUtil.DoBlock("Datos Generales del Usuario",10,10)%>
    <%=MyUtil.ObjInput("Destinatario","Destinatario", conciergeflores!=null ? conciergeflores.getDestinatario() : "",true,true,30,220,"",true,true,75)%>
    <%=MyUtil.ObjInput("Direccion","Direccion", conciergeflores!=null ? conciergeflores.getDireccion() :"",true,true,30,255,"",true,true,75)%>
    <%=MyUtil.ObjInput("Ciudad","Ciudad",conciergeflores!=null ? conciergeflores.getCiudad():"",true,true,30,290,"",true,true,30)%>
    <%=MyUtil.ObjInput("Estado","Estado",conciergeflores!=null ? conciergeflores.getEstado():"",true,true,250,290,"",true,true,30)%>
    <%=MyUtil.ObjInput("Pais","Pais",conciergeflores!=null ? conciergeflores.getPais().trim():"",true,true,450,290,"",true,true,30)%>
    <%=MyUtil.ObjInput("Telefono","TelefonoD",conciergeflores!=null ? conciergeflores.getTelefonoD():"",true,true,30,330,"",true,true,25)%>
    <%=MyUtil.ObjInput("Celular","CelularD",conciergeflores!=null ? conciergeflores.getCelularD():"",true,true,250,330,"",true,true,25)%>
    <%=MyUtil.ObjInputF("Fecha y hora de Entrega","FechaE",conciergeflores!=null ? conciergeflores.getFechaE():"",true,true,450,330,"",true,true,20, 2, "")%>  </div>
    <%=MyUtil.DoBlock("Destinatario",100,5)%>
    
    <%=MyUtil.ObjInput("Remitente","Remitente",conciergeflores!=null ? conciergeflores.getRemitente():"",true,true,30,420,"",true,true,75)%>
    <%=MyUtil.ObjInput("Tel�fono","TelefonoR",conciergeflores!=null ? conciergeflores.getTelefonoR():"",true,true,450,420,"",true,true,25)%>
    <%=MyUtil.ObjInput("Celular","CelularR",conciergeflores!=null ? conciergeflores.getCelularR():"",true,true,625,420,"",true,true,25)%>
    <%=MyUtil.ObjInput("Evento","Evento",conciergeflores!=null ? conciergeflores.getEvento():"",true,true,30,455,"",true,true,75)%>
    <%=MyUtil.ObjInput("Cargo Total","CargoT",conciergeflores!=null ? conciergeflores.getCargoT():"",true,true,450,455,"",false,false,25)%>
    <%=MyUtil.ObjInput("Arreglo Solicitado","Arreglo",conciergeflores!=null ? conciergeflores.getArreglo():"",true,true,30,490,"",true,true,75)%>
    <%=MyUtil.ObjChkBox("Requiere Adicionales","Adicionales",conciergeflores!=null ? conciergeflores.getAdicionales():"",true,true,450,490,"","SI","NO","fnServAds();")%>
    <%=MyUtil.ObjInput("Descripci�n","Descripcion",conciergeflores!=null ? conciergeflores.getDescripcion():"",true,true,30,525,"",false,false,75)%>
    <%=MyUtil.ObjTextArea("Mensaje","Mensaje",conciergeflores!=null ? conciergeflores.getMensaje().trim():"","83","2",true,true,30,560,"",false,false)%>
    <%=MyUtil.ObjComboC("Forma de Pago:","clTipoPago",conciergeflores!=null ? conciergeflores.getDsTipoPago() : "",true,true,30,605,"","select clTipoPago,dsTipoPago from CSTipoPago","fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();","",30,false,false)%>    
    <%=MyUtil.ObjInput("Nombre del Banco:","NomBanco",conciergeflores!=null ? conciergeflores.getNomBanco() :"",true,true,200,605,"",false,false,40)%>
    <%=MyUtil.ObjInput("Nombre en TC:","NombreTC",conciergeflores!=null ? conciergeflores.getNombreTC():"",true,true,450,605,"",false,false,40)%>
    <%=MyUtil.ObjInput("Numero de TC:","NumeroTC",conciergeflores!=null ? conciergeflores.getNumeroTC():"",false,false,30,640,"",false,false,50,"if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
    <%=MyUtil.ObjInput("Exp.D.:(MM/AA)","ExpiraVTR",conciergeflores!=null ? conciergeflores.getExpira():"",false,false,350,640,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
    <input type="hidden" name="Expira" id="Expira" value="<%=conciergeflores!=null ? conciergeflores.getExpira() : ""%>">
    <%=MyUtil.ObjInput("Sec.C.:","SecC",conciergeflores!=null ? conciergeflores.getSecC():"",true,false,440,640,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
    <%=MyUtil.ObjInput("Florista","FloristaC",conciergeflores!=null ? conciergeflores.getFloristaC():"",true,true,30,680,"",false,false,50)%>
    <%=MyUtil.ObjInput("Recibio","Recibio",conciergeflores!=null ? conciergeflores.getRecibio():"",true,true,350,680,"",false,false,50)%>
    <%=MyUtil.DoBlock("Remitente",100,20)%>
    
    <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
    <input name='FechaProgMskI' id='FechaProgMskI' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
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
    conciergeflores=null;
    daosg=null;
    conciergeg=null;
    
     daoRef=null;
         ref=null;
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
        }
        function fnActualizaFechaActual(pFecha){
        document.all.FechaApAsist.value = pFecha;
        }


        function fnAdicional(){
        if (document.all.Adicionales.value==1){
            if(document.all.Descripcion.value==""){
                msgVal = msgVal + " Debe Ingresar Descripci�n. ";
                //document.all.btnGuarda.disabled=true;
                //document.all.btnCancela.disabled=false;
            }
        }
        }

        //funci�n antes de guardar
        function fnAntesGuardar(){
            if (document.all.clEstatus.value==10 ) {
                if (document.all.FloristaC.value==0 ) { msgVal = msgVal + " Florista ";}
                if (document.all.Recibio.value=="" ) { msgVal = msgVal + " Recibio ";}
                if (document.all.CargoT.value=="" ) { msgVal = msgVal + " Cargo Total ";}
                document.all.btnGuarda.disabled=false;
                document.all.btnCancela.disabled=false;
            }
             //..........................................44444444444444444444444444
                fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
             //..........................................44444444444444444444444444
        }

        //Funci�n para quitarle los cero a la fecha
        function fnVerificaFecha() {
             document.all.FechaE.value=fnFechaID(document.all.FechaE.value);
             //document.all.FechaEventoF.value=fnFechaID(document.all.FechaEventoF.value);
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
         function fnServAds()
                                 {
                                  if ((document.all.Adicionales.value==1) && (document.all.Action.value==1))
                                     {
                                     document.all.Descripcion.className="Freq";
                                     }
                                  else
                                     {
                                     document.all.Descripcion.className="VTable";
                                     document.all.Descripcion.readOnly=false;
                                     }
                                  if(document.all.Adicionales.value==0) document.all.Descripcion.value="";
                                  }
    </script>
    <script type="text/javascript">
        initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
    </script>        
</body>
</html>