<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOConciergeRentayate,com.ike.concierge.to.Conciergerentayate,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
    <head><title>Renta de Yate Privado</title>
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
         <!--script src='../../Utilerias/UtilCalendarioV.js'--><!--/script-->
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Renta de Yate Privado </i></b>  <br> </p></div>
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

        DAOConciergeRentayate daos=null;
        Conciergerentayate conciergerentayate=null;
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
        String StrclPaginaWeb = "738";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);        
        if(StrclAsistencia!=null){
            daos = new DAOConciergeRentayate();            
            conciergerentayate= daos.getCSRentaYate(StrclAsistencia); 
            
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
        MyUtil.InicializaParametrosC(738,Integer.parseInt(strclUsr)); 
        %><%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaYate","fnAccionesAlta();","fnAntesGuardar();fnReqCampo();")%>

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
        <%String strEstatus = conciergerentayate!=null ? conciergerentayate.getDsEstatus() : ""; %>
        <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergerentayate!=null ? conciergerentayate.getDsEstatus(): "",false,false,30,80, "0","sp_GetCSstatus","","",30,false,false)%>
        <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,350,80, "",false,false,10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios",conciergerentayate!=null ? conciergerentayate.getComentarios() : "","83","3",true,true,30,120,"",true,true)%>
        <%=MyUtil.ObjInput("fecha de alta","FechaRegistro",conciergerentayate!=null ? conciergerentayate.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
        <%=MyUtil.DoBlock("Datos Generales del Usuario",10,10)%>
        
        <%=MyUtil.ObjInput("Embarcación","Embarcacion",conciergerentayate!=null ? conciergerentayate.getEmbarcacion() :"",true,true,30,220,"",true,true,50)%>
        <%=MyUtil.ObjInput("Pasajeros","Pasajeros",conciergerentayate!=null ? conciergerentayate.getPasajeros() :"",true,true,350,220,"",true,true,10)%>
        <%=MyUtil.ObjInput("Ubicación/Muelle","Ubicacion",conciergerentayate!=null ? conciergerentayate.getUbicacion() :"",true,true,30,255,"",false,false,50)%>
        <%=MyUtil.ObjInput("Camarotes","Camarotes",conciergerentayate!=null ? conciergerentayate.getCamarotes() :"",true,true,350,255,"",true,true,10)%>
        <%=MyUtil.ObjInput("Ciudad","Ciudad",conciergerentayate!=null ? conciergerentayate.getCiudad() :"",true,true,30,295,"",true,true,50)%>
        <%=MyUtil.ObjInput("Estado","Estado",conciergerentayate!=null ? conciergerentayate.getEstado() :"",true,true,350,295,"",true,true,50)%>
        <%=MyUtil.ObjInput("Pais","Pais",conciergerentayate!=null ? conciergerentayate.getPais() :"",true,true,650,295,"",true,true,50)%>
        <%=MyUtil.ObjInputF("Fecha de Salida <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaS",conciergerentayate!=null ? conciergerentayate.getFechaS() :"",true,true,30,335,"",true,true,20, 2, "")%>  </div>    
        <%=MyUtil.ObjInputF("Fecha de Regreso <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaR",conciergerentayate!=null ? conciergerentayate.getFechaR() :"",true,true,350,335,"",true,true,20, 2, "")%>  </div>    
        <%=MyUtil.ObjInput("Costo por Hora","CostoH", conciergerentayate!=null ? conciergerentayate.getCostoH() :"",true,true,30,375,"",false,false,10,"EsNumerico(this)")%>
        <%=MyUtil.ObjInput("Hrs./PERNOCTAS:","HorasP",conciergerentayate!=null ? conciergerentayate.getHorasP() :"",true,true,200,375,"",false,false,5,"EsNumerico(this)")%>
        <%=MyUtil.ObjInput("Cargo Total:","CargoT",conciergerentayate!=null ? conciergerentayate.getCargoT() :"",true,true,350,375,"",false,false,10,"EsNumerico(this)")%>    
        <%=MyUtil.ObjInput("Hotel & Tel.:","Hotel",conciergerentayate!=null ? conciergerentayate.getHotel() :"",true,true,30,415,"",false,false,75)%>
        <%=MyUtil.ObjInputF("Check-In <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaI",conciergerentayate!=null ? conciergerentayate.getFechaI() :"",true,true,450,415,"",false,false,20, 2,"fnVerificaFecha();")%>  </div>
        <%=MyUtil.ObjInput("Rva. a nombre","Reservacion",conciergerentayate!=null ? conciergerentayate.getReservacion() :"",true,true,30,455,"",false,false,75)%>
        <%=MyUtil.ObjInputF("Check-Out <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaO",conciergerentayate!=null ? conciergerentayate.getFechaO() :"",true,true,450,455,"",false,false,20, 2,"fnVerificaFecha();")%>  </div>        
        <%=MyUtil.ObjComboC("Forma de Pago:","clTipoPago",conciergerentayate!=null ? conciergerentayate.getDsTipoPago() : "",true,true,30,495,"","select clTipoPago,dsTipoPago from CSTipoPago","fnLimpiaTar();fnTipoPago(this.value);if(document.all.NumeroTC.value!=''){fnValidaPrefijoTC(document.all.NumeroTC.value)};fnLimpiaTar();","",30,false,false)%>
        <%=MyUtil.ObjInput("Nombre del Banco:","NomBanco",conciergerentayate!=null ? conciergerentayate.getNomBanco() :"",false,false,200,495,"",false,false,40)%>
        <%=MyUtil.ObjInput("Nombre en TC:","NombreTC",conciergerentayate!=null ? conciergerentayate.getNombreTC() :"",false,false,450,495,"",false,false,30)%>
        <%=MyUtil.ObjInput("Numero de TC:","NumeroTC",conciergerentayate!=null ? conciergerentayate.getNumeroTC() :"",false,false,30,535,"",false,false,30,"if(this.readOnly==false){fnValMask(this,document.all.NumeroTCMsk.value,this.name)};fnValidaPrefijoTC(this.value);")%>
        <%=MyUtil.ObjInput("Exp.D.:(MM/AA)","ExpiraVTR",conciergerentayate!=null ? conciergerentayate.getExpira():"",false,false,250,535,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.ExpiraMsk.value,this.name)};fnFechVen(this.value);")%>
        <input type="hidden" name="Expira" id="Expira" value="<%=conciergerentayate!=null ? conciergerentayate.getExpira2() :""%>">
        <%=MyUtil.ObjInput("Sec.C.:","SecC",conciergerentayate!=null ? conciergerentayate.getSecC() :"",false,false,350,535,"",false,false,10,"if(this.readOnly==false){fnValMask(this,document.all.SecCMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Confirmo","Confirmo",conciergerentayate!=null ? conciergerentayate.getConfirmo() : "",true,true,30,575,"",false,false,30)%>
        <%=MyUtil.ObjInput("No.Conf.:","NConfirmo",conciergerentayate!=null ? conciergerentayate.getNConfirmo() :"",true,true,350,575,"",false,false,30,"")%>
        <%=MyUtil.ObjInput("Pol.Cancelación","PCancel",conciergerentayate!=null ? conciergerentayate.getPCancel() : "",true,true,30,615,"",false,false,50)%>
        <%=MyUtil.ObjChkBox("N/U inf.:","NuInf", conciergerentayate!=null ? conciergerentayate.getNuInf():"",true,true,350,615,"" ,"SI","NO","")%>
        <%=MyUtil.DoBlock("renta de Yate Privado",100,0)%>
        
        <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <input name='FechaProgMskI' id='FechaProgMskI' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <input name='NumeroTCMsk' id='NumeroTCMsk' type='hidden' value=''>
        <input name='ExpiraMsk' id='ExpiraMsk' type='hidden' value='VN09VN09F-/-VN09VN09'>
        <input name='SecCMsk' id='SecCMsk' type='hidden' value=''>
        <input name='FechaIniMsk' id='FechaIniMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        
        <%@ include file="csVentanaFlotante.jspf" %>
        <%
        //Aqui estaban los las variables nuleadas
        
        %>
        <%=MyUtil.GeneraScripts()%>        
                
        <script>
            
            function fnValidaFecha() {
                if (document.all.FechaI.value!='' && document.all.FechaO.value!= ''){
                    if (document.all.FechaO.value <= document.all.FechaI.value) {
                        msgVal = msgVal + " Check-Out debe de ser mayor a Check-In. "
                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    }
                }

                if (document.all.FechaS.value!='' && document.all.FechaR.value!= ''){
                    if (document.all.FechaR.value <= document.all.FechaS.value){
                        msgVal = msgVal + " La fecha de Regreso debe de ser mayor a la fecha de Salida  "
                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    }
                }
            }

            function fnAccionesAlta(){
               if (document.all.Action.value==1){
                    var pstrCadena = "../../Utilerias/RegresaFechaActual.jsp";
                    window.open(pstrCadena,'newWin','width=10,height=10,left=1500,top=2000');
                    //document.all.FechaI.value="";
                    //document.all.Embarcacion.value="";
                    // document.forms[0].accion = '';
               }
            }

            function fnActualizaFechaActual(pFecha){
                document.all.FechaApAsist.value = pFecha;
            }

            //  función antes de guardar
            function fnAntesGuardar(){
                if (document.all.clEstatus.value==10 ) {
                    if (document.all.Ubicacion.value==0 ) { msgVal = msgVal + " Ubicación/Muelle";}
                    if (document.all.CostoH.value==0 ) { msgVal = msgVal + " Costo por Hora";}
                    if (document.all.HorasP.value==0 ) { msgVal = msgVal + " Hrs./Pernoctas";}
                    if (document.all.CargoT.value==0 ) { msgVal = msgVal + " Cargo Total";}
                    if (document.all.FechaI.value==''){
                        miFecha = new Date();
                        document.all.FechaI.value=miFecha.getYear()+"-"+(miFecha.getMonth()+1)+"-"+miFecha.getDate();
                    }
                }
                //..........................................44444444444444444444444444                
                fnPregunta(document.all.clConcierge.value,document.all.clSubservicio.value,document.all.clStrURL.value,document.all.clStrNomPag.value);                
                //..........................................44444444444444444444444444
            }

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

            //Función para quitarle los cero a la fecha
            function fnVerificaFecha() {
                 //document.all.FechaS.value=fnFechaID(document.all.FechaS.value);
                 //document.all.FechaR.value=fnFechaID(document.all.FechaR.value);
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
        </script>
        <script type="text/javascript">
             initFloatingWindowWithTabs('window4',Array('Nuestro Usuario','Referencias'),350,250,700,20,false,false,true,true,false);
        </script>
        <%
        StrclConcierge = null;
        StrclSubservicio = null;
        StrclAsistencia = null;
        daos=null;
        conciergerentayate=null;
        daosg=null;
        conciergeg=null;
        daoRef=null;
        ref=null;
        %>
    </body>
</html>