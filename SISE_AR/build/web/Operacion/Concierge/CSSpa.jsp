<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOConciergeSpa,com.ike.concierge.to.Conciergespa,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
    <head><title>Reservacion de Servicio de SPA</title>
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
        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i>Reservación de Servicio de SPA</i></b>  <br> </p></div>
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

        DAOConciergeSpa daos=null;
        Conciergespa conciergespa=null;
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
        String StrclPaginaWeb = "745";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        if(strclUsr!=null){
            daos = new DAOConciergeSpa();
            conciergespa= daos.getCSSpa(StrclAsistencia);
            
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
        MyUtil.InicializaParametrosC(745,Integer.parseInt(strclUsr)); 
        %><%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaSpa","fnAccionesAlta();","fnAntesGuardar();")%><%
        
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
        <%String strEstatus = conciergespa!=null ? conciergespa.getDsEstatus() : ""; %>
        <!--%=MyUtil.ObjComboMem("Estatus","clEstatus",strEstatus,conciergespa!=null ? conciergespa.getEstatus() : "",cbEstatus.GeneraHTML(50,strEstatus),false,false,30,80,"0","","",50,false,false)%-->
        <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergespa!=null ? conciergespa.getDsEstatus(): "",false,false,30,80,conciergespa!=null ? conciergespa.getEstatus(): "0","sp_GetCSstatus","","",30,false,false)%>
        <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,350,80,conciergespa!=null ? conciergespa.getClAsistencia().trim() : "",false,false,10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios",conciergespa!=null ? conciergespa.getComentarios() : "","83","3",true,true,30,120,"",true,true)%>
        <%=MyUtil.ObjInput("fecha de alta","FechaRegistro",conciergespa!=null ? conciergespa.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
        <%=MyUtil.DoBlock("Datos Generales del Usuario",10,10)%>
        
        <%=MyUtil.ObjInput("Tratamiento","TipoServicio",conciergespa!=null ? conciergespa.getTipoServicio() :"",true,true,30,220,"",false,false,45)%>
        <%=MyUtil.ObjTextArea("Descripcion Tratamiento","DesTratamiento",conciergespa!=null ? conciergespa.getDesTratamiento(): "","40","12",true,true,290,220,"",false,false)%>
        <%=MyUtil.ObjInput("Duración","Duracion",conciergespa!=null ? conciergespa.getDuracion() :"",true,true,535,220,"",false,false,20)%>
        <%=MyUtil.ObjInput("Costo","CargoT",conciergespa!=null ? conciergespa.getCargoT() :"",true,true,675,220,"",false,false,10)%>
        <%=MyUtil.ObjInputF("Fecha de la cita <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaD",conciergespa!=null ? conciergespa.getFechaD() : "",true,true,535,280,"",false,false,20, 2, "fnVerificaFecha();")%>
        <%=MyUtil.ObjInput("Beneficiario","Nombre",conciergespa!=null ? conciergespa.getNombre() : "",true,true,535,335,"",false,false,45,"")%>
        <%=MyUtil.ObjInput("Especialista Hombre/Mujer","Masajista",conciergespa!=null ? conciergespa.getMasajista() : "",true,true,30,325,"",false,false,45,"")%>
        <%=MyUtil.DoBlock("Reservación de Servicio de SPA",-20,10)%>
        
        <!--%=MyUtil.ObjInputF("Fecha y Hora Confirmada <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaC",conciergespa!=null ? conciergespa.getFechaC(): "",true,true,30,300,"",false,false,20, 2, "")%>  </div>
                
            <div class='VTable' style='position:absolute; z-index:25; left:30px; top:385px;'>
            <TEXT>MASAJISTA FAVORITO </TEXT></div>
        
        < %=MyUtil.ObjChkBox("Hombre","Hombre",conciergespa!=null ? conciergespa.getHombre() :"",true,true,30,400,"","fnDesactivaH()")%>
        < %=MyUtil.ObjChkBox("Mujer","Mujer",conciergespa!=null ? conciergespa.getMujer() :"",true,true,150,400,"","fnDesactivaM()")%>
        < %=MyUtil.ObjChkBox("Indistinto","Indistinto",conciergespa!=null ? conciergespa.getIndistinto():"",true,true,270,400,"","fnDesactivaI()")%>
        < %=MyUtil.ObjInput("Hotel & Tel.:","Hotel",conciergespa!=null ? conciergespa.getHotel() :"",true,true,30,510,"",false,false,75)%>
        < %=MyUtil.ObjInputF("Check-In <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaI",conciergespa!=null ? conciergespa.getFechaI() :"",true,true,450,510,"",false,false,20, 2, "fnVerificaFecha();")%>  </div>
        < %=MyUtil.ObjInput("Rva. a nombre","Reservacion",conciergespa!=null ? conciergespa.getReservacion() :"",true,true,30,550,"",false,false,75)%>
        < %=MyUtil.ObjInputF("Check-Out <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaO",conciergespa!=null ? conciergespa.getFechaO() :"",true,true,450,550,"",false,false,20, 2, "fnVerificaFecha();")%>  </div-->


        <%=MyUtil.ObjComboC("Forma de Pago:","clTipoPago",conciergespa!=null ? conciergespa.getDsTipoPago() :"",true,true,30,435,"","select clTipoPago,dsTipoPago from CSTipoPago","fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();","",30,false,false)%>
        <%=MyUtil.ObjInput("Nombre del Banco:","NomBanco",conciergespa!=null ? conciergespa.getNomBanco() :"",false,false,200,435,"",false,false,40)%>
        <%=MyUtil.ObjInput("Nombre en TC:","NombreTC",conciergespa!=null ? conciergespa.getNombreTC() :"",false,false,450,435,"",false,false,30)%>
        <%=MyUtil.ObjInput("Numero de TC:","NumeroTC",conciergespa!=null ? conciergespa.getNumeroTC() :"",false,false,30,475,"",false,false,50,"if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        <%=MyUtil.ObjInput("Exp.D.:(MM/AA)","ExpiraVTR",conciergespa!=null ? conciergespa.getExpira() :"",false,false,350,475,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
        <input type="hidden" name="Expira" id="Expira" value="<%=conciergespa!=null ? conciergespa.getExpira2() :""%>">
        <%=MyUtil.ObjInput("Sec.C.:","SecC",conciergespa!=null ? conciergespa.getSecC() :"",false,false,440,475,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Confirmo","Confirmo",conciergespa!=null ? conciergespa.getConfirmo() :"",true,true,30,515,"",false,false,30)%>
        <%=MyUtil.ObjInput("No.Conf.:","NConfirmo",conciergespa!=null ? conciergespa.getNConfirmo() :"",true,true,350,515,"",false,false,30,"")%>
        <%=MyUtil.ObjInput("Pol.Cancelación","PCancel",conciergespa!=null ? conciergespa.getPCancel() :"",true,true,30,555,"",false,false,50)%>
        <%=MyUtil.ObjChkBox("N/U inf.:","NuInf",conciergespa!=null ? conciergespa.getNuInf() :"",true,true,350,555,"" ,"SI","NO","")%>
        <%=MyUtil.DoBlock("Forma de Pago",100,0)%>
        
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
        daos=null;
        conciergespa=null;
        daosg=null;
        conciergeg=null;
        
             daoRef=null;
         ref=null;
        %>
        <%=MyUtil.GeneraScripts()%>        
        <script>
		
				top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
		top.document.all.rightPO.rows="0,80,*";
  /*function fnValidaFecha()
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
     }*/
function fnAccionesAlta(){
   if (document.all.Action.value==1){
      
             var pstrCadena = "../../Utilerias/RegresaFechaActual.jsp";
             window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');
       
     }
}
function fnActualizaFechaActual(pFecha){
document.all.FechaApAsist.value = pFecha;			
}

/*function fnDesactivaH(){
if (document.all.Hombre.value==1)
{
document.all.MujerC.checked=false;
document.all.IndistintoC.checked=false;
document.all.Mujer.value=0;
document.all.Indistinto.value=0;
}}
function fnDesactivaM(){
if (document.all.Mujer.value==1)
{
document.all.HombreC.checked=false;
document.all.IndistintoC.checked=false;
document.all.Hombre.value=0;
document.all.Indistinto.value=0;
}

}
function fnDesactivaI(){
if (document.all.Indistinto.value==1)
{
document.all.MujerC.checked=false;
document.all.HombreC.checked=false;
document.all.Mujer.value=0;
document.all.Hombre.value=0;
}
}*/

//función antes de guardar
function fnAntesGuardar(){
    if (document.all.clEstatus.value==10 ) {
       // if (document.all.FechaC.value==0 ) { msgVal = msgVal + " Fecha Confirmada";}
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
     //document.all.FechaC.value=fnFechaID(document.all.FechaC.value);
     document.all.FechaD.value=fnFechaID(document.all.FechaD.value);
     //document.all.FechaI.value=fnFechaID(document.all.FechaI.value);
     //document.all.FechaO.value=fnFechaID(document.all.FechaO.value);
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
/*function fnLimpiaFechas(){
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
    
}   */
        </script>
        <script type="text/javascript">
    initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
        </script>        
    </body>
</html>