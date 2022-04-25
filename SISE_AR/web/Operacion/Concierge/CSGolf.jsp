
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOConciergeGolf,com.ike.concierge.to.Conciergegolf,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
    <head><title>Reservacion de Campos de Golf</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>        
    </head>
    <body class="cssBody" onload="fnVerificaFecha();">
     
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script> 
        <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>        
        <script src='../../Utilerias/UtilCalendario.js'></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i>Reservación de Campos de Golf</i></b>  <br> </p></div>
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

        DAOConciergeGolf daos=null;
        Conciergegolf conciergegolf=null;
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
        String StrclPaginaWeb = "740";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        if(strclUsr!=null){
            daos = new DAOConciergeGolf();
            conciergegolf= daos.getCSGolf(StrclAsistencia);
        }
        if(strclUsr!=null){
            daosg = new DAOConciergeG();
            conciergeg = daosg.getConciergeGenerico(StrclConcierge);
            
            daoRef = new DAOReferenciasxAsist();
            ref = daoRef.getclAsistencia(StrclAsistencia);
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
        MyUtil.InicializaParametrosC(740,Integer.parseInt(strclUsr)); 
        %><%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaGolf","fnAccionesAlta();","fnAntesGuardar();fnValidaFecha();fnReqCampo();")%>

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
        <%String strEstatus = conciergegolf!=null ? conciergegolf.getDsEstatus() : ""; %>
        <!--%=MyUtil.ObjComboMem("Estatus","clEstatus",strEstatus,conciergegolf!=null ? conciergegolf.getEstatus() : "",cbEstatus.GeneraHTML(50,strEstatus),false,false,30,80,"0","","",50,false,false)%-->
        <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergegolf!=null ? conciergegolf.getDsEstatus(): "",false,false,30,80, "0","sp_GetCSstatus","","",30,false,false)%>
        <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,350,80,"",false,false,10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios",conciergegolf!=null ? conciergegolf.getComentarios() : "","83","3",true,true,30,120,"",true,true)%>
        <%=MyUtil.ObjInput("fecha de alta","FechaRegistro",conciergegolf!=null ? conciergegolf.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
        <%=MyUtil.DoBlock("Datos Generales del Usuario",10,10)%>
        
        <%=MyUtil.ObjInput("Jugadores","Jugadores",conciergegolf!=null ? conciergegolf.getJugadores() :"",true,true,30,220,"",true,true,25)%>
        <%=MyUtil.ObjInputF("Fecha <Strong>(AAAA-MM-DD hh:mm)</Strong>","Fecha",conciergegolf!=null ? conciergegolf.getFecha() :"",true,true,250,220,"",true,true,20, 2, "")%>  </div>    
        <%=MyUtil.ObjInput("Green Fee/Pax","Green",conciergegolf!=null ? conciergegolf.getGreen() :"",true,true,30,260,"",false,false,8)%>
        <%=MyUtil.ObjInput("Costo por Renta de Equipo","Equipo",conciergegolf!=null ? conciergegolf.getEquipo() :"",true,true,150,260,"",false,false,8)%>
        <%=MyUtil.ObjInput("Diestros","Diestros",conciergegolf!=null ? conciergegolf.getDiestros() :"",true,true,350,260,"",true,true,8)%>
        <%=MyUtil.ObjInput("Zurdos","Zurdos",conciergegolf!=null ? conciergegolf.getZurdos() :"",true,true,430,260,"",true,true,8)%>
        <%=MyUtil.ObjInput("Otros Cargos","OtrosC",conciergegolf!=null ? conciergegolf.getOtrosC() :"",true,true,30,300,"",false,false,10,"")%>
        <%=MyUtil.ObjInput("Cargo Total","CargoT",conciergegolf!=null ? conciergegolf.getCargoT() :"",true,true,150,300,"",false,false,10,"")%>
        <%=MyUtil.ObjInput("Hotel & Tel.:","Hotel", conciergegolf!=null ? conciergegolf.getHotel() :"",true,true,30,340,"",false,false,75)%>
        <%=MyUtil.ObjInputF("Check-In <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaI",conciergegolf!=null ? conciergegolf.getFechaI() :"",true,true,450,340,"",false,false,20, 2, "fnVerificaFecha();")%>  </div>
        <%=MyUtil.ObjInput("Rva. a nombre","Reservacion", conciergegolf!=null ? conciergegolf.getReservacion() :"",true,true,30,380,"",false,false,75)%>
        <%=MyUtil.ObjInputF("Check-Out <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaO",conciergegolf!=null ? conciergegolf.getFechaO() :"",true,true,450,380,"",false,false,20, 2, "fnVerificaFecha();")%>  </div>
        <%=MyUtil.ObjComboC("Forma de Pago:","clTipoPago",conciergegolf!=null ? conciergegolf.getDsTipoPago() :"",true,true,30,420,"","select clTipoPago,dsTipoPago from CSTipoPago","fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();","",30,false,false)%>
        <%=MyUtil.ObjInput("Nombre del Banco:","NomBanco",conciergegolf!=null ? conciergegolf.getNomBanco() :"",false,false,200,420,"",false,false,40)%>
        <%=MyUtil.ObjInput("Nombre en TC:","NombreTC",conciergegolf!=null ? conciergegolf.getNombreTC() :"",false,false,450,420,"",false,false,30)%>
        <%=MyUtil.ObjInput("Numero de TC:","NumeroTC",conciergegolf!=null ? conciergegolf.getNumeroTC() :"",false,false,30,460,"",false,false,50,"if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        <%=MyUtil.ObjInput("Exp.D.:(MM/AA)","ExpiraVTR", conciergegolf!=null ? conciergegolf.getExpira():"",false,false,350,460,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
        <input type="hidden" name="Expira" id="Expira" value="<%=conciergegolf!=null ? conciergegolf.getExpira2() :""%>">
        <%=MyUtil.ObjInput("Sec.C.:","SecC",conciergegolf!=null ? conciergegolf.getSecC() :"",false,false,440,460,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Confirmo","Confirmo",conciergegolf!=null ? conciergegolf.getConfirmo() :"",true,true,30,500,"",false,false,30)%>
        <%=MyUtil.ObjInput("No.Conf.:","NConfirmo",conciergegolf!=null ? conciergegolf.getNConfirmo():"",true,true,350,500,"",false,false,30,"")%>
        <%=MyUtil.ObjInput("Pol.Cancelación","PCancel",conciergegolf!=null ? conciergegolf.getPCancel() :"",true,true,30,540,"",false,false,50)%>
        <%=MyUtil.ObjChkBox("N/U inf.:","NuInf",conciergegolf!=null ? conciergegolf.getNuInf():"",true,true,350,540,"" ,"SI","NO","")%>
        <%=MyUtil.DoBlock("Reservación de Campos de Golf",100,0)%>
        
        <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='FechaProgMskI' id='FechaProgMskI' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>
        <input name='FechaIniMsk' id='FechaIniMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        
        <%@ include file="csVentanaFlotante.jspf" %>

        <%
        StrclConcierge = null;
        StrclSubservicio = null;
        StrclAsistencia = null;
        /*daos=null;
        conciergebar=null;*/
        daosg=null;
        conciergeg=null;
        daoRef=null;
        ref=null;
        %>
        <%=MyUtil.GeneraScripts()%>        
        <script>
		                top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
                  top.document.all.rightPO.rows="0,80,*";
  function fnValidaFecha()
    {
     if (document.all.FechaI.value!='' && document.all.FechaO.value!= '')
    {
      if (document.all.FechaO.value <= document.all.FechaI.value)
      {
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

//función antes de guardar
function fnAntesGuardar(){
    if (document.all.clEstatus.value==10 ) {
        if (document.all.Green.value==0 ) { msgVal = msgVal + " Green Fee/Pax";}
        if (document.all.Equipo.value==0 ) { msgVal = msgVal + " Costo por Renta de Equipo";}
        if (document.all.OtrosC.value==0 ) { msgVal = msgVal + " Otros Cargos";}
        if (document.all.CargoT.value==0 ) { msgVal = msgVal + " Cargo Total";}
        document.all.btnGuarda.disabled=false;
        document.all.btnCancela.disabled=false;
    }
    /*if (document.all.FechaI.value==''){
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
     //document.all.Fecha.value=fnFechaID(document.all.Fecha.value);
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
    </body>
</html>