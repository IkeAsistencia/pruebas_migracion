<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOConciergeRentajet,com.ike.concierge.to.Conciergerentajet,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
    <head><title>Renta de Helicopteros/Jets Privados</title>
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
        <script src='../../Utilerias/UtilCalendario.js'></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Renta de Jet o Helicóptero Privado </i></b>  <br> </p></div>
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


        DAOConciergeRentajet daos=null;
        Conciergerentajet conciergerentajet=null;
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
        String StrclPaginaWeb = "737";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        if(strclUsr!=null){
            daos = new DAOConciergeRentajet();
            conciergerentajet= daos.getCSRentaJet(StrclAsistencia);
            
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
        MyUtil.InicializaParametrosC(737,Integer.parseInt(strclUsr)); 
        %><%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaJet","fnAccionesAlta();","fnAntesGuardar();fnValidaFecha();fnReqCampo();")%><%
        
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
        <%String strEstatus = conciergerentajet!=null ? conciergerentajet.getDsEstatus() : "";%>
        <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergerentajet!=null ? conciergerentajet.getDsEstatus(): "",false,false,30,80,"0","sp_GetCSstatus","","",30,false,false)%>
        <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,350,80,"",false,false,10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios",conciergerentajet!=null ? conciergerentajet.getComentarios() : "","83","3",true,true,30,120,"",true,true)%>
        <%=MyUtil.ObjInput("fecha de alta","FechaRegistro",conciergerentajet!=null ? conciergerentajet.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
        <%=MyUtil.DoBlock("Datos Generales del Usuario",10,10)%>
        
        <%=MyUtil.ObjInput("Aeronave Solicitada","Aeronave",conciergerentajet!=null ? conciergerentajet.getAeronave() : "",true,true,30,220,"",true,true,50)%>
        <%=MyUtil.ObjInput("Pasajeros","Pasajeros",conciergerentajet!=null ? conciergerentajet.getPasajeros() : "",true,true,350,220,"",true,true,10)%>
        <%=MyUtil.ObjInput("Origen","Origen",conciergerentajet!=null ? conciergerentajet.getOrigen() : "",true,true,30,255,"",true,true,50)%>
        <%=MyUtil.ObjInput("Destino","Destino", conciergerentajet!=null ? conciergerentajet.getDestino(): "",true,true,350,255,"",true,true,50)%>
        <%=MyUtil.ObjInputF("Fecha Salida <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaS",conciergerentajet!=null ? conciergerentajet.getFechaS() : "",true,true,30,290,"",true,true,20, 2, "")%>  </div>    
        <%=MyUtil.ObjInput("Costo por Hora/Día","CostoH",conciergerentajet!=null ? conciergerentajet.getCostoH() : "",true,true,30,330,"",false,false,10,"EsNumerico(this)")%>
        <%=MyUtil.ObjInput("Hrs./Pernoctas:","HorasP",conciergerentajet!=null ? conciergerentajet.getHorasP() : "",true,true,200,330,"",false,false,5,"EsNumerico(this)")%>
        <%=MyUtil.ObjInput("Cargo Total:","CargoT",conciergerentajet!=null ? conciergerentajet.getCargoT() : "",true,true,350,330,"",false,false,10,"EsNumerico(this)")%>    
        <%=MyUtil.ObjInput("Hotel & Tel.:","Hotel",conciergerentajet!=null ? conciergerentajet.getHotel(): "",true,true,30,370,"",false,false,75)%>
        <%=MyUtil.ObjInputF("Check-In <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaI",conciergerentajet!=null ? conciergerentajet.getFechaI() :  "",true,true,450,370,"",false,false,20, 2, "fnVerificaFecha();")%>  </div>
        <%=MyUtil.ObjInput("Rva. a nombre","Reservacion",conciergerentajet!=null ? conciergerentajet.getReservacion() : "",true,true,30,410,"",false,false,75)%>
        <%=MyUtil.ObjInputF("Check-Out <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaO", conciergerentajet!=null ? conciergerentajet.getFechaO() : "",true,true,450,410,"",false,false,20, 2, "fnVerificaFecha();")%>  </div>        
        <%=MyUtil.ObjComboC("Forma de Pago:","clTipoPago", conciergerentajet!=null ? conciergerentajet.getDsTipoPago() :"",true,true,30,450,"","select clTipoPago,dsTipoPago from CSTipoPago","fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();","",30,false,false)%>
        <%=MyUtil.ObjInput("Nombre del Banco:","NomBanco",conciergerentajet!=null ? conciergerentajet.getNomBanco() : "",false,false,30,490,"",false,false,40)%>
        <%=MyUtil.ObjInput("Nombre en TC:","NombreTC", conciergerentajet!=null ? conciergerentajet.getNombreTC() :"",false,false,260,450,"",false,false,30)%>
        <%=MyUtil.ObjInput("Numero de TC:","NumeroTC", conciergerentajet!=null ? conciergerentajet.getNumeroTC() :"",false,false,260,490,"",false,false,30,"if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        <%=MyUtil.ObjInput("Exp.D.:(MM/AA)","ExpiraVTR", conciergerentajet!=null ? conciergerentajet.getExpira() :"",false,false,450,490,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
        <input type="hidden" name="Expira" id="Expira" value="<%=conciergerentajet!=null ? conciergerentajet.getExpira2() :""%>">
        <%=MyUtil.ObjInput("Sec.C.:","SecC", conciergerentajet!=null ? conciergerentajet.getSecC() :"",true,false,550,490,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Confirmo","Confirmo",conciergerentajet!=null ? conciergerentajet.getConfirmo() :"",true,true,30,530,"",false,false,30)%>
        <%=MyUtil.ObjInput("No.Conf.:","NConfirmo",conciergerentajet!=null ? conciergerentajet.getNConfirmo() :"",true,true,350,530,"",false,false,30,"")%>
        <%=MyUtil.ObjInput("Pol.Cancelación","PCancel",conciergerentajet!=null ? conciergerentajet.getPCancel() :"",true,true,30,570,"",false,false,50)%>
        <%=MyUtil.ObjChkBox("N/U inf.:","NuInf",conciergerentajet!=null ? conciergerentajet.getNuInf() :"",true,true,350,570,"" ,"SI","NO","")%>
        <%=MyUtil.DoBlock("Renta de Jet o Helicóptero Privado",100,0)%>
      
        
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
        conciergerentajet=null;
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
     if (document.all.FechaI.value!='')
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
  
function fnAdicional(){
if (document.all.SolAdic.value==1){
    if(document.all.Adicionales.value==""){
        msgVal = msgVal + " Debe Ingresar Adicionales. ";
        document.all.btnGuarda.disabled=false;
        document.all.btnCancela.disabled=false;
    }
}
else{
document.all.Adicionales.value="";
}
}

//función antes de guardar
function fnAntesGuardar(){
    if (document.all.clEstatus.value==10 ) {
        if (document.all.CostoH.value==0 ) { msgVal = msgVal + " Costo por Hora/Día";}
        if (document.all.HorasP.value==0 ) { msgVal = msgVal + " Hrs./Pernoctas";}
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
     //document.all.FechaS.value=fnFechaID(document.all.FechaS.value);
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