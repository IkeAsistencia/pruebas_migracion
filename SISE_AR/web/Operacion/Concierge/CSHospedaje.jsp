<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOConciergeHospedaje,com.ike.concierge.to.Conciergehospedaje,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
<head><title>Reservacion de Hospedaje</title>
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
    
    <script src='../../Utilerias/UtilCalendarioV.js'></script>
    <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i>Reservacion de Hospedaje</i></b>  <br> </p></div>
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

    DAOConciergeHospedaje daos=null;
    Conciergehospedaje conciergehospedaje=null;
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
    String StrclPaginaWeb = "741";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    if(strclUsr!=null){
        daos = new DAOConciergeHospedaje();
        conciergehospedaje= daos.getCSHospedaje(StrclAsistencia);
        
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
    <script>fnOpenLinks()</script>
    <%        
    MyUtil.InicializaParametrosC(741,Integer.parseInt(strclUsr)); 
    %><%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaHospedaje","fnAccionesAlta();","fnAntesGuardar();fnValidaFecha();")%><%
    
    %>

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
    <%String strEstatus = conciergehospedaje!=null ? conciergehospedaje.getDsEstatus() : ""; %>
    <!--%=MyUtil.ObjComboMem("Estatus","clEstatus",strEstatus,conciergehospedaje!=null ? conciergehospedaje.getEstatus() : "",cbEstatus.GeneraHTML(50,strEstatus),false,false,30,80,"0","","",50,false,false)%-->
    <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergehospedaje!=null ? conciergehospedaje.getDsEstatus(): "",false,false,30,80,"0","sp_GetCSstatus","","",30,false,false)%>
    <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,350,80, "",false,false,10)%>
    <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios",conciergehospedaje!=null ? conciergehospedaje.getComentarios(): "","83","3",true,true,30,120,"",true,true)%>
    <%=MyUtil.ObjInput("fecha de alta","FechaRegistro",conciergehospedaje!=null ? conciergehospedaje.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
    <%=MyUtil.DoBlock("Datos Generales del Usuario",10,10)%>


    <%=MyUtil.ObjInput("Hotel","Hotel",conciergehospedaje!=null ? conciergehospedaje.getHotel(): "",true,true,30,220,"",false,false,35)%>
    <%=MyUtil.ObjInput("Tipo de Hab","TipoHab",conciergehospedaje!=null ? conciergehospedaje.getTipoHab(): "",true,true,240,220,"",false,false,20)%>
    <%=MyUtil.ObjInput("Reserva A Nombre de","Nombre",conciergehospedaje!=null ? conciergehospedaje.getNombre(): "",true,true,370,220,"",false,false,40)%>
    <%=MyUtil.ObjTextArea("Incluye","Incluye",conciergehospedaje!=null ? conciergehospedaje.getIncluye(): "","40","4",true,true,600,220,"",false,false)%>
    <%=MyUtil.ObjInput("No. Habitaciones","Habitaciones",conciergehospedaje!=null ? conciergehospedaje.getHabitaciones(): "",true,true,30,260,"",false,false,10)%>
    <%=MyUtil.ObjInputF("CHECK INN<Strong>(AAAA-MM-DD)</Strong>","FechaE",conciergehospedaje!=null ? conciergehospedaje.getFechaE(): "",true,true,30,300,"",false,false,20, 2, "")%>
    <%=MyUtil.ObjInputF("CHECK OUT<Strong>(AAAA-MM-DD)</Strong>","FechaS",conciergehospedaje!=null ? conciergehospedaje.getFechaS(): "",true,true,240,300,"",false,false,20, 2, "")%>
    <%=MyUtil.ObjTextArea("Observaciones","Adicionales",conciergehospedaje!=null ? conciergehospedaje.getAdicionales(): "","50","4",true,true,30,350,"",false,false)%>
    <%=MyUtil.ObjInput("Costo Noche Adicional","CostoN",conciergehospedaje!=null ? conciergehospedaje.getCostoN(): "",true,true,490,350,"",false,false,20)%>
    <%=MyUtil.ObjInput("Cargo Total","CargoT",conciergehospedaje!=null ? conciergehospedaje.getCargoT(): "",true,true,370,350,"",false,false,15)%>
    <!--%=MyUtil.ObjInput("Edades","Edades",conciergehospedaje!=null ? conciergehospedaje.getEdades(): "",true,true,220,300,"",false,false,10)%-->
    <%=MyUtil.DoBlock("Reservacion de Hospedaje",50,35)%>

    <%=MyUtil.ObjComboC("Forma de Pago:","clTipoPago",conciergehospedaje!=null ? conciergehospedaje.getDsTipoPago(): "",true,true,30,480,"","select clTipoPago,dsTipoPago from CSTipoPago","fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();","",30,false,false)%>
    <%=MyUtil.ObjInput("Nombre del Banco:","NomBanco",conciergehospedaje!=null ? conciergehospedaje.getNomBanco() :"",false,false,200,480,"",false,false,40)%>
    <%=MyUtil.ObjInput("Nombre en TC:","NombreTC",conciergehospedaje!=null ? conciergehospedaje.getNombreTC(): "",false,false,450,480,"",false,false,30)%>
    <%=MyUtil.ObjInput("Numero de TC:","NumeroTC",conciergehospedaje!=null ? conciergehospedaje.getNumeroTC(): "",false,false,30,520,"",false,false,50,"if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
    <%=MyUtil.ObjInput("Exp.D.:(MM/AA)","ExpiraVTR",conciergehospedaje!=null ? conciergehospedaje.getExpira(): "",false,false,350,520,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
    <input type="hidden" name="Expira" id="Expira" value="<%=conciergehospedaje!=null ? conciergehospedaje.getExpira2(): ""%>">
    <%=MyUtil.ObjInput("Sec.C.:","SecC",conciergehospedaje!=null ? conciergehospedaje.getSecC(): "",false,false,440,520,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
    <%=MyUtil.ObjInput("Confirmo","Confirmo",conciergehospedaje!=null ? conciergehospedaje.getConfirmo(): "",true,true,30,560,"",false,false,30)%>
    <%=MyUtil.ObjInput("No.Conf.:","NConfirmo",conciergehospedaje!=null ? conciergehospedaje.getNConfirmo(): "",true,true,350,560,"",false,false,30,"")%>
    <%=MyUtil.ObjInput("Pol.Cancelación","PCancel",conciergehospedaje!=null ? conciergehospedaje.getPCancel(): "",true,true,30,600,"",false,false,50)%>
    <%=MyUtil.ObjChkBox("N/U inf.:","NuInf",conciergehospedaje!=null ? conciergehospedaje.getNuInf(): "",true,true,350,600,"","SI","NO","")%>
    <%=MyUtil.DoBlock("Forma de Pago",100,0)%>
    
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
    conciergehospedaje=null;
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
            if (document.all.FechaE.value!='' && document.all.FechaS.value!= ''){
                if (document.all.FechaS.value <= document.all.FechaE.value){
                    msgVal = msgVal + "La fecha de salida debe de ser mayor a la fecha de Entrada. "
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

        /*function fnAdicional(){
            if (document.all.Ninos.value==1){
                if(document.all.Edades.value==""){
                    msgVal = msgVal + " Debe Ingresar Edades. ";
                    document.all.btnGuarda.disabled=false;
                    document.all.btnCancela.disabled=false;
                }
            }else{
                document.all.Edades.value="";
            }
        }*/

        //función antes de guardar
        function fnAntesGuardar(){
            if (document.all.clEstatus.value==10 ) {
                if (document.all.CostoN.value==0 ) { msgVal = msgVal + " Costo por Noche(Impuesto incluido) ";}
                if (document.all.CargoT.value==0 ) { msgVal = msgVal + " Cargo Total";}
                document.all.btnGuarda.disabled=false;
                document.all.btnCancela.disabled=false;
            }/*
            if (document.all.FechaE.value==''){
               miFecha = new Date();
               document.all.FechaE.value=miFecha.getYear()+"-"+(miFecha.getMonth()+1)+"-"+miFecha.getDate();
            }
           if (document.all.FechaS.value==''){
               miFechaO = new Date();
               document.all.FechaS.value='';
            }    */

           //..........................................44444444444444444444444444
            fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
           //..........................................44444444444444444444444444
        }
        //Función para quitarle los cero a la fecha
        function fnVerificaFecha() {
             document.all.FechaE.value=fnFechaID(document.all.FechaE.value);
             document.all.FechaS.value=fnFechaID(document.all.FechaS.value);

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
        /*function EdadesNinos(){
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
*/
            //Función para limpiar las fechas
            function fnLimpiaFechas(){
                if (document.all.FechaE.value=="1900-01-01"){
                    document.all.FechaE.value="";
                }
                else {
                    document.all.FechaE.value=fnFechaID(document.all.FechaE.value);
                }
                if (document.all.FechaS.value=="1900-01-01"){
                    document.all.FechaS.value="";
                }
                else {
                    document.all.FechaS.value=fnFechaID(document.all.FechaS.value);
                }
            }
    </script>
    <script type="text/javascript">
        initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
    </script>        
</body>
</html>