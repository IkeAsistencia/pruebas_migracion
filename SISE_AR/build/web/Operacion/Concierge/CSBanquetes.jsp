<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.concierge.DAOConciergeBanquete,com.ike.concierge.to.Conciergebanquete,Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
    <head><title>Banquetes y Eventos Privados</title>

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
        <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <script src='../../Utilerias/UtilMask.js'></script>         
        <script src='../../Utilerias/UtilCalendarioV.js'></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Banquetes y Eventos Privados </i></b>  <br> </p></div>
        <div class='VTable' style='position:absolute; z-index:25; left:570px; top:93px;'><p align="center"><font color="navy" face="Arial" size="2" ><b><i>Automatica </i></b>  <br> </p></div>
        <%  
        String StrclConcierge = "";
        String StrclSubservicio = "";
        String StrclAsistencia = "0";
        String strclUsr = "";
        String StrSelLlamada = "0";
       

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


        DAOConciergeBanquete daos=null;
        Conciergebanquete conciergebanquete=null;
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
            System.out.println("StrclAsistencia RQ(CSBanquetes):  "+StrclAsistencia);
        } else{
            if (session.getAttribute("clAsistencia")!= null) {
                StrclAsistencia= session.getAttribute("clAsistencia").toString();
                System.out.println("StrclAsistencia SES(CSBanquetes):  "+StrclAsistencia);
            }
        }
        if (request.getParameter("clSubservicio")!= null) {
            StrclSubservicio= request.getParameter("clSubservicio").toString();
        } else{
            if (session.getAttribute("clSubservicio")!= null) {
                StrclSubservicio= session.getAttribute("clSubservicio").toString();
            }
        }
       
        
        if (request.getParameter("SelLlamada")!= null) {
            StrSelLlamada = request.getParameter("SelLlamada").toString();
             System.out.println("StrSelLlamada RQ(CSBanquetes):  "+StrSelLlamada);
        }       

        session.setAttribute("clAsistencia",StrclAsistencia);
        session.setAttribute("clSubservicio",StrclSubservicio);
        String StrclPaginaWeb = "713";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        
        if(strclUsr!=null){
            daos = new DAOConciergeBanquete();
            conciergebanquete= daos.getCSBanquete(StrclAsistencia);
            
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
        <%MyUtil.InicializaParametrosC(713,Integer.parseInt(strclUsr));%>
        <%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaBanquete","fnAccionesAlta();","fnReqCampo();fnAntesGuardar();")%>




        <%--.....................................33333333333333333333333333333--%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>'>
        <INPUT id='Pregunta' name='Pregunta' type='hidden' value="<%=StrPreguntaEncuesta%>">               
        <INPUT id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubservicio%>'>
        <INPUT id='clStrURL' name='clStrURL' type='hidden' value='<%=StrURL%>'>
        <INPUT id='clStrNomPag' name='clStrNomPag' type='hidden' value='<%=StrNomPag%>'>
        <%--.....................................33333333333333333333333333333--%>


        <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=StrclConcierge%>'>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=StrclAsistencia%>'>
        <INPUT id='FechaApAsist' name='FechaApAsist' type='hidden' value=''>
        
        <% String strEstatus = conciergebanquete!=null ? conciergebanquete.getDsEstatus() : ""; %>
        
        <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergebanquete!=null ? conciergebanquete.getDsEstatus(): "",false,false,30,80,"0","sp_GetCSstatus","","",30,false,false)%>
        <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,350,80,"",false,false,10)%>
        <%=MyUtil.ObjInput("fecha de alta","FechaRegistro",conciergebanquete!=null ? conciergebanquete.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
        
        <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios",conciergebanquete!=null ? conciergebanquete.getComentarios().trim() : "","83","3",true,true,30,120,"",true,true)%>
        <%=MyUtil.DoBlock("Datos Generales del Evento ",20,10)%>
        
        <%=MyUtil.ObjInput("Evento","Evento",conciergebanquete!=null ? conciergebanquete.getEvento().trim() : "",true,true,30,220,"",true,true,50)%>
        <%=MyUtil.ObjInput("No.Invitados","Invitados",conciergebanquete!=null ? conciergebanquete.getInvitadMos().trim() : "",true,true,350,220,"",true,true,10,"EsNumerico(this)")%>
        
        <%=MyUtil.ObjInputF("Fecha del Evento","FechaEventoI",conciergebanquete!=null ? conciergebanquete.getFechaEventoI().trim() : "",true,true,30,255,"",true,true,20, 2, "")%>  <!--/div-->
        <%=MyUtil.ObjInputF("Fecha Fin del Evento","FechaEventoF",conciergebanquete!=null ? conciergebanquete.getFechaEventoF().trim() : "",true,true,350,255,"",true,true,20, 2, "")%>  <!--/div-->
        <%=MyUtil.ObjTextArea("Ubicación del Evento","Ubicacion",conciergebanquete!=null ? conciergebanquete.getUbicacion().trim() : "","83","3",true,true,30,300,"",true,true)%>
        <%=MyUtil.ObjInput("Ciudad","Ciudad",conciergebanquete!=null ? conciergebanquete.getCiudad().trim() : "",true,true,30,365,"",false,false,50)%>
        <%=MyUtil.ObjInput("Estado","Estado",conciergebanquete!=null ? conciergebanquete.getEstado().trim() : "",true,true,350,365,"",false,false,50)%>
        <%=MyUtil.ObjInput("Pais","Pais",conciergebanquete!=null ? conciergebanquete.getPais().trim() : "",true,true,650,365,"",false,false,50)%>
        <%=MyUtil.ObjInput("Telefono","Telefono",conciergebanquete!=null ? conciergebanquete.getTelefono().trim() : "",true,true,30,405,"",false,false,25)%>
        <%=MyUtil.ObjInput("Celular","Celular", conciergebanquete!=null ? conciergebanquete.getCelular().trim() : "",true,true,350,405, "",false,false,25)%>
        <%=MyUtil.DoBlock("Datos Generales del Evento",100,5)%>
       
        <%=MyUtil.ObjInput("Costo por Hora","CostoH",conciergebanquete!=null ? conciergebanquete.getCostoH().trim() : "",true,true,30,500,"",false,false,10,"EsNumerico(this)")%>
        <%=MyUtil.ObjInput("Horas Conf.:","HorasC",conciergebanquete!=null ? conciergebanquete.getHorasC().trim() : "",true,true,150,500,"",false,false,5,"EsNumerico(this)")%>
        <%=MyUtil.ObjInput("Cargo Total:","CargoT",conciergebanquete!=null ? conciergebanquete.getCargoT().trim() : "",true,true,350,500,"",false,false,10,"EsNumerico(this)")%>
        <%=MyUtil.ObjInput("Costo por Pax:","CostoP",conciergebanquete!=null ? conciergebanquete.getCostoP().trim(): "",true,true,30,540,"",false,false,10,"EsNumerico(this)")%>
        <%=MyUtil.ObjInput("Otros Cargos:","CargosO",conciergebanquete!=null ? conciergebanquete.getCargosO().trim() : "",true,true,150,540,"",false,false,10)%>
        <%=MyUtil.ObjInput("Nombre del Banco:","NomBanco",conciergebanquete!=null ? conciergebanquete.getNomBanco().trim() : "",true,true,350,540,"",false,false,40)%>
        <!--%=MyUtil.ObjComboC("Tipo de Pago","clTipoPago",conciergebanquete!=null ? conciergebanquete.getDsTipoPago().trim() : "",true,true,30,585,"2","select clTipoPago,dsTipoPago from CSTipoPago","fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar()","",30,false,false)%!-->
        <%=MyUtil.ObjComboC("Tipo de Pago","clTipoPago",conciergebanquete!=null ? conciergebanquete.getDsTipoPago() : "",true,true,30,585,"","select clTipoPago,dsTipoPago from CSTipoPago","fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();","",30,false,false)%>
        <%=MyUtil.ObjInput("Nombre en TC:","NombreTC",conciergebanquete!=null ? conciergebanquete.getNombreTC().trim() : "",false,false,350,585,"",false,false,40,"")%>
        <%=MyUtil.ObjInput("Numero de TC:","NumeroTC",conciergebanquete!=null ? conciergebanquete.getNumeroTC().trim() : "",false,false,30,620,"",false,false,50,"if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        <%=MyUtil.ObjInput("Exp.D.:(MM/AA)","ExpiraVTR",conciergebanquete!=null ? conciergebanquete.getExpira().trim() : "",false,false,350,620,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)}fnFechVen(this.value);")%>
        <input type="hidden" name="Expira" id="Expira" value="<%=conciergebanquete!=null ? conciergebanquete.getExpira2().trim() : ""%>">
        <%=MyUtil.ObjInput("Sec.C.:","SecC",conciergebanquete!=null ? conciergebanquete.getSecC().trim().trim() : "",false,false,440,620,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Otra Forma de Pago","PagoO",conciergebanquete!=null ? conciergebanquete.getPagoO().trim() : "",true,true,30,655,"",false,false,50)%>
        <%=MyUtil.ObjInput("Confirmo","Confirmo",conciergebanquete!=null ? conciergebanquete.getConfirmo().trim() : "",true,true,350,655,"",false,false,30)%>
        <%=MyUtil.ObjInput("No.Conf.:","NConfirmo",conciergebanquete!=null ? conciergebanquete.getNConfirmo().trim() : "",true,true,600,655,"",false,false,30,"")%>
        <%=MyUtil.ObjInput("Pol.Cancelación","PCancel",conciergebanquete!=null ? conciergebanquete.getPCancel().trim() : "",true,true,30,695,"",false,false,50)%>
        <%=MyUtil.ObjChkBox("N/U inf.:","NuInf",conciergebanquete!=null ? conciergebanquete.getNuInf().trim() : "",true,true,350,695,"0","SI","NO","")%>

        <%=MyUtil.DoBlock("Costos del Evento",100,20)%>
        
        <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F'>
        <input name='FechaProgMskI' id='FechaProgMskI' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F'>
        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value=''>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>
        <input name='FechaIniMsk' id='FechaIniMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F'>


        
    <%@ include file="csVentanaFlotante.jspf" %>

        
        <%
        //StrclConcierge = null;
        //StrclSubservicio = null;
        //StrclSubservicio=null;
        StrclAsistencia = null;
        daos=null;
        conciergebanquete=null;
        daosg=null;
        conciergeg=null;

         daoRef=null;
         ref=null;
        %>
        <%=MyUtil.GeneraScripts()%>
        
<script>

		  top.document.all.DatosExpediente.src="Operacion/Concierge/CSDatosConcierge.jsp";
		  top.document.all.rightPO.rows="0,80,*";
				  
////////////////////////////////////////////
    function fnValidaFecha()    {
     if (document.all.FechaEventoI.value!='' && document.all.FechaEventoF.value!= '')   {
        if (document.all.FechaEventoF.value <= document.all.FechaEventoI.value) {
           msgVal = msgVal + " La Fecha de Fin de Evento debe ser mayor a la de Inicio. "
           document.all.btnGuarda.disabled = false;
           document.all.btnCancela.disabled = false;       
        }
     }
}
////////////////////////////////////////////////
function fnAccionesAlta(){
   if (document.all.Action.value==1){
             var pstrCadena = "../../Utilerias/RegresaFechaActual.jsp";
             window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');
     }
  }
  //////////////////////////////////////////////
function fnActualizaFechaActual(pFecha){
document.all.FechaApAsist.value = pFecha;			
}


////////////////////////////////////////Función para quitarle los cero a la fecha
function fnVerificaFecha() {
     document.all.FechaEventoI.value=fnFechaID(document.all.FechaEventoI.value);
     document.all.FechaEventoF.value=fnFechaID(document.all.FechaEventoF.value);
}

/////////////////////////////////////////////función que regresa la fecha sin hora
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
//////////////////////////  función antes de guardar
function fnAntesGuardar(){
    if (document.all.clEstatus.value==10 ) {
        if (document.all.HorasC.value==0 ) { msgVal = msgVal + " Horas Confrimadas";}
        if (document.all.CostoH.value==0 ) { msgVal = msgVal + " Costo por Hora";}
        if (document.all.CargoT.value==0 ) { msgVal = msgVal + " Cargo Total";}
         document.all.btnGuarda.disabled=false;
         document.all.btnCancela.disabled=false;
        }

       //..........................................44444444444444444444444444
        fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);
       //..........................................44444444444444444444444444
}               
        </script>
        <script type="text/javascript">
            initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
        </script>

    </body>
</html>