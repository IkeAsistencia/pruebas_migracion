<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbEstatus,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOConciergeEquipaje,com.ike.concierge.to.Conciergeequipaje,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>
<%@ page import = "java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
    <head><title>Rastreo de Equipaje</title>
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
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>         
        <script src='../../Utilerias/UtilCalendario.js'></script>
        <script src='../../Utilerias/UtilConciergeAsistencias.js'></script>   
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">

        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i> Rastreo de Equipaje </i></b>  <br> </p></div>
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

        DAOConciergeEquipaje daos=null;
        Conciergeequipaje conciergeequipaje=null;
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
        String StrclPaginaWeb = "734";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        if(strclUsr!=null){
            daos = new DAOConciergeEquipaje();
            conciergeequipaje= daos.getCSEquipaje(StrclAsistencia);
            
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
        MyUtil.InicializaParametrosC(734,Integer.parseInt(strclUsr)); 
        %><%=MyUtil.doMenuAct("../../servlet/Concierge.CSAltaEquipaje","fnAccionesAlta();","fnAntesGuardar();fnValidaFecha();")%>

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
        <% String strEstatus = conciergeequipaje!=null ? conciergeequipaje.getDsEstatus() : ""; %>
        <!--%=MyUtil.ObjComboMem("Estatus","clEstatus",strEstatus,conciergeequipaje!=null ? conciergeequipaje.getEstatus() : "",cbEstatus.GeneraHTML(50,strEstatus),false,true,30,80,"0","","",50,false,true)%-->
        <%=MyUtil.ObjComboC("Estatus","clEstatus",conciergeequipaje!=null ? conciergeequipaje.getDsEstatus(): "",false,false,30,80,"0","sp_GetCSstatus","","",30,false,false)%>
        <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",StrclAsistenciaVTR,false,false,350,80,"",false,false,10)%>
        <%=MyUtil.ObjTextArea("Descripcion del Evento","Comentarios", conciergeequipaje!=null ? conciergeequipaje.getComentarios() : "","83","3",true,true,30,120,"",true,true)%>
        <%=MyUtil.ObjInput("fecha de alta","FechaRegistro",conciergeequipaje!=null ? conciergeequipaje.getFechaRegistro():"",false,false,650,80,"",false,false,20)%>
        <%=MyUtil.DoBlock("Datos Generales del Evento",10,10)%>
        <%=MyUtil.ObjInput("Info de Vuelo","Vuelo", conciergeequipaje!=null ? conciergeequipaje.getVuelo() :  "",true,true,30,220,"",true,true,50)%>
        <%=MyUtil.ObjInput("N�mero de Maletas","Maletas",  conciergeequipaje!=null ? conciergeequipaje.getMaletas() : "",true,true,350,220,"",true,true,10,"EsNumerico(this)")%>
        <%=MyUtil.ObjInput("Ciudad de Origen","CiudadO", conciergeequipaje!=null ? conciergeequipaje.getCiudadO() : "",true,true,30,260,"",true,true,50)%>
        <%=MyUtil.ObjInput("Ciudad de Destino","CiudadD", conciergeequipaje!=null ? conciergeequipaje.getCiudadD() : "",true,true,350,260,"",true,true,50)%>
        <%=MyUtil.ObjInput("Apto. de Origen","AptoO", conciergeequipaje!=null ? conciergeequipaje.getAptoO() : "",true,true,30,300,"",true,true,50)%>
        <%=MyUtil.ObjInput("Apto. de Destino","AptoD", conciergeequipaje!=null ? conciergeequipaje.getAptoD() : "",true,true,350,300,"",true,true,50)%>
        <%=MyUtil.ObjInputF("Fecha de Salida<strong>(aaaa/mm/dd hh:mm)</strong>","FechaS", conciergeequipaje!=null ? conciergeequipaje.getFechaS(): "",true,true,30,340,"",true,true,20, 2, "")%>  </div>
        <%=MyUtil.ObjInputF("Fecha de Arribo<strong>(aaaa/mm/dd hh:mm)</strong>","FechaA",  conciergeequipaje!=null ? conciergeequipaje.getFechaA() : "",true,true,350,340,"",true,true,20, 2, "")%>  </div>
        <%=MyUtil.ObjInput("Conexiones","Conexion", conciergeequipaje!=null ? conciergeequipaje.getConexion() : "",true,true,30,380,"",false,false,75)%>
        <%=MyUtil.ObjInput("No. de Reclamo","Reclamo", conciergeequipaje!=null ? conciergeequipaje.getReclamo() : "",true,true,30,420,"",true,true,75)%>
        <%=MyUtil.ObjInput("Hotel & Tel.:","Hotel", conciergeequipaje!=null ? conciergeequipaje.getHotel() : "",true,true,30,460,"",false,false,75)%>
        <%=MyUtil.ObjInputF("Check-In <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaI", conciergeequipaje!=null ? conciergeequipaje.getFechaI() : "",true,true,450,460,"",false,false,20, 2, "fnVerificaFecha();")%>  </div>
        <%=MyUtil.ObjInput("Rva. a nombre","Reservacion", conciergeequipaje!=null ? conciergeequipaje.getReservacion() : "",true,true,30,500,"",false,false,75)%>
        <%=MyUtil.ObjInputF("Check-Out <Strong>(AAAA-MM-DD hh:mm)</Strong>","FechaO", conciergeequipaje!=null ? conciergeequipaje.getFechaO() : "",true,true,450,500,"",false,false,20, 2, "fnVerificaFecha();")%>  </div>
        <%=MyUtil.ObjInputF("Recuperado el <Strong>(AAAA-MM-DD hh:mm)</Strong>","Fechrecupera", conciergeequipaje!=null ? conciergeequipaje.getFechrecupera() : "",true,true,30,540,"",false,false,20, 2, "fnVerificaFecha();")%>  </div>
        <%=MyUtil.ObjInputF("Entregado el <Strong>(AAAA-MM-DD hh:mm)</Strong>","Fechentrega", conciergeequipaje!=null ? conciergeequipaje.getFechentrega() : "",true,true,450,540,"",false,false,20, 2, "fnVerificaFecha();")%>  </div>
        <%=MyUtil.ObjInput("Direccion de Entrega","DireccionE", conciergeequipaje!=null ? conciergeequipaje.getDireccionE() : "",true,true,30,580,"",true,true,75)%>
        <%=MyUtil.DoBlock("Rastreo de Equipaje",100,20)%>
        
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
		
            function fnValidaFecha(){
                if (document.all.FechaI.value!='' && document.all.FechaO.value!= ''){
                    if (document.all.FechaO.value <= document.all.FechaI.value){
                        msgVal = msgVal + " Check-Out debe de ser mayor a Check-In. "
                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    }
                }
                if (document.all.FechaS.value!='' && document.all.FechaA.value!= ''){
                    if (document.all.FechaA.value <= document.all.FechaS.value){
                        msgVal = msgVal + " La fecha de Arribo debe de ser mayor a la fecha de Salida. "
                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    }
                }
                if (document.all.Fechrecupera.value!='' && document.all.Fechentrega.value!= ''){
                    if (document.all.Fechentrega.value <= document.all.Fechrecupera.value){
                        msgVal = msgVal + " La fecha de entrega debe de ser mayor a la fecha de recuperaci�n. "
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

            //funci�n antes de guardar
            function fnAntesGuardar(){
                if (document.all.clEstatus.value==10 ) {
                    if (document.all.Fechrecupera.value==0 ) { msgVal = msgVal + " Recuperado";}
                    if (document.all.Fechentrega.value==0 ) { msgVal = msgVal + " Entregado";}
                    document.all.btnGuarda.disabled=false;
                    document.all.btnCancela.disabled=false;
                }
                /*    if (document.all.FechaI.value==''){
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

            //Funci�n para quitarle los cero a la fecha
            function fnVerificaFecha() {
                // document.all.FechaS.value=fnFechaID(document.all.FechaS.value);
                // document.all.FechaA.value=fnFechaID(document.all.FechaA.value);
                document.all.FechaI.value=fnFechaID(document.all.FechaI.value);
                document.all.FechaO.value=fnFechaID(document.all.FechaO.value);
                document.all.Fechrecupera.value=fnFechaID(document.all.Fechrecupera.value);
                document.all.Fechentrega.value=fnFechaID(document.all.Fechentrega.value);
            }

            //funci�n que regresa la fecha sin hora
            function fnFechaID(Fecha){
                if (Fecha!=""){
                    FechaSinHora=Fecha;
                    FechaSinHora=FechaSinHora.substring(0,10);
                    return FechaSinHora;
                }else {
                  FechaSinHora='';
                  return FechaSinHora;
                }
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
                }else{
                    document.all.FechaO.value=fnFechaID(document.all.FechaO.value);
                }
                if (document.all.Fechrecupera.value=="1900-01-01"){
                    document.all.Fechrecupera.value="";
                }else{
                    document.all.Fechrecupera.value=fnFechaID(document.all.Fechrecupera.value);
                }
                if (document.all.Fechentrega.value=="1900-01-01"){
                    document.all.Fechentrega.value="";
                }else{
                    document.all.Fechentrega.value=fnFechaID(document.all.Fechentrega.value);
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
        conciergeequipaje=null;
        daosg=null;
        conciergeg=null;
        daoRef=null;
        ref=null;
        %>
    </body>
</html>