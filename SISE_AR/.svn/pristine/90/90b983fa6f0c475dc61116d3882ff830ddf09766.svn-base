<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.SL.DAOSL,com.ike.SL.to.SLExpediente,com.ike.SL.to.SLLlamadaEncuesta,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>

<html>
<head><title>Llamada de Seguimiento Legal</title>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css"> 
</head>

<body class="cssBody" onload='fndsHabilitar();'>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<script src='../../Utilerias/UtilAuto.js' ></script>
<script src="../../Utilerias/UtilCalendario.js"></script>
<script src='../../Utilerias/UtilMask.js'></script>

<%
    String strclExpediente = "0";
    String strclUsrApp = "0";
    String strIntentoLlamada ="0";
    String strExtension ="";
    
    if (request.getParameter("clExpediente")!=null)
    {
        strclExpediente = request.getParameter("clExpediente").toString();
    }

    if (session.getAttribute("Extension")!=null)
    {
        strExtension = session.getAttribute("Extension").toString();
    }

    if (session.getAttribute("clUsrApp")!=null)
    {
        strclUsrApp = session.getAttribute("clUsrApp").toString();
    }

    if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true) 
   {
%>
<b>Fuera de Horario</b>
<%
        strclUsrApp = null;
        return;       
   } 
 
 
    DAOSL daoSL = null;
    DAOSL daoSLL = null;
    SLExpediente  Expediente = null;
    if (strclUsrApp.compareToIgnoreCase("0")!=0)
    {
        daoSL = new DAOSL();
        Expediente = daoSL.getclExpediente(strclUsrApp);
    }
    
    
    SLLlamadaEncuesta  LlamadaEncuesta = null;
    if (Expediente!=null)
    {
        strclExpediente = Expediente.getclExpediente();
        daoSL = new DAOSL();
        LlamadaEncuesta = daoSL.getclExpedienteLL(strclExpediente);
    }
    else
    {
%>
<script>alert("NO EXISTEN MAS EXPEDIENTES PARA ENCUESTAR")</script>
<%
    }

       String StrclPaginaWeb = "590";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
       MyUtil.InicializaParametrosC(590,Integer.parseInt(strclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 

       StringBuffer StrSql = new StringBuffer();
       StrSql.append("Select Nombre from cUsrApp where clUsrApp =").append(strclUsrApp);
       ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
%>


    <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaGuardaEncuestaSL","fnHabBtnsTel();","fnAntesGuardar();")%>
    <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="LlamadaSL.jsp?'>"%>
    <%=MyUtil.ObjInput("Expediente","clExpedienteVTR",Expediente!=null ? String.valueOf(Expediente.getclExpediente()) : "",false,true,30,70,Expediente!=null ? String.valueOf(Expediente.getclExpediente()) : "",false,false,11)%>
    <%=MyUtil.ObjInput("Fecha de Registro","FechaRegistroVTR",Expediente!=null ? String.valueOf(Expediente.getFechaRegistro()) : "",false,false,130,70,Expediente!=null ? String.valueOf(Expediente.getFechaRegistro()) : "",false,false,25)%>
    <%=MyUtil.ObjInput("Cuenta","NombreVTR",Expediente!=null ? String.valueOf(Expediente.getCuenta()) : "",false,false,300,70,Expediente!=null ? String.valueOf(Expediente.getCuenta()) : "",false,false,35)%>
    <%=MyUtil.ObjInput("Estatus","dsEstatusVTR",Expediente!=null ? String.valueOf(Expediente.getEstatus()) : "",false,false,520,70,Expediente!=null ? String.valueOf(Expediente.getEstatus()) : "",false,false,24)%>
    <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"dsEntFedVTR",Expediente!=null ? String.valueOf(Expediente.getEstado()) : "",false,false,30,115,Expediente!=null ? String.valueOf(Expediente.getEstado()) : "",false,false,41)%>
    <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipío"),"dsMunDelVTR",Expediente!=null ? String.valueOf(Expediente.getMundel()) : "",false,false,300,115,Expediente!=null ? String.valueOf(Expediente.getMundel()) : "",false,false,68)%>
    <%=MyUtil.ObjInput("Nuestro Usuario","NuestroUsuarioVTR",Expediente!=null ? String.valueOf(Expediente.getNuestroUsuario()) : "",false,false,30,205,Expediente!=null ? String.valueOf(Expediente.getNuestroUsuario()) : "",false,false,41)%>
    <%=MyUtil.ObjInput("Conductor","ContactoVTR",Expediente!=null ? String.valueOf(Expediente.getConductor()) : "",false,false,260,205,Expediente!=null ? String.valueOf(Expediente.getConductor()) : "",false,false,41)%>
    <%=MyUtil.ObjInput("Vehiculo","VehiculoVTR",Expediente!=null ? String.valueOf(Expediente.getVehiculo()) : "",false,false,490,205,Expediente!=null ? String.valueOf(Expediente.getVehiculo()) : "",false,false,30)%>
    <%=MyUtil.ObjInput("Color","ColorVTR",Expediente!=null ? String.valueOf(Expediente.getColor()) : "",false,false,30,250,Expediente!=null ? String.valueOf(Expediente.getColor()) : "",false,false,15)%>
    <%=MyUtil.ObjInput("Placas","PlacasVTR",Expediente!=null ? String.valueOf(Expediente.getPlacas()) : "",false,false,130,250,Expediente!=null ? String.valueOf(Expediente.getPlacas()) : "",false,false,8)%>    
    
    
    <%=MyUtil.ObjInput(i18n.getMessage("message.title.lada"),"Lada1VTR",Expediente!=null ? String.valueOf(Expediente.getLada()) : "",false,false,220,250,Expediente!=null ? String.valueOf(Expediente.getLada()) : "",false,false,8)%>
    <%=MyUtil.ObjInput("Teléfono","Telefono1VTR",Expediente!=null ? String.valueOf(Expediente.getTelefonoCasa()) : "",false,false,285,250,Expediente!=null ? String.valueOf(Expediente.getTelefonoCasa()) : "",false,false,12)%>
    <div class='VTable' style='position:absolute; z-index:40; left:370px; top:260px;'>
    <input class='cBtn' type='button' name='Tel1' id='Tel1' value="Seleccionar" onClick="fnLlenaTelefono(1)"></input>
    </div>

    <%=MyUtil.ObjInput(i18n.getMessage("message.title.lada"),"Lada2VTR",Expediente!=null ? String.valueOf(Expediente.getLada2()) : "",false,false,490,250,Expediente!=null ? String.valueOf(Expediente.getLada2()) : "",false,false,8)%>
    <%=MyUtil.ObjInput("Teléfono","Telefono2VTR",Expediente!=null ? String.valueOf(Expediente.getTelefonoOtro()) : "",false,false,555,250,Expediente!=null ? String.valueOf(Expediente.getTelefonoOtro()) : "",false,false,12)%>

    <div class='VTable' style='position:absolute; z-index:40; left:635px; top:260px;'>
    <input class='cBtn' type='button' name='Tel2' id='Tel2' value="Seleccionar" onClick="fnLlenaTelefono(2)"></input>
    </div>
    <%=MyUtil.ObjInput("Subservicio","dsSubservicioVTR",Expediente!=null ? String.valueOf(Expediente.getSubServicio()) : "",false,false,30,160,Expediente!=null ? String.valueOf(Expediente.getSubServicio()) : "",false,false,41)%>
    <%=MyUtil.ObjInput("Proveedor","NombreOpeVTR",Expediente!=null ? String.valueOf(Expediente.getProveedor()) : "",false,false,300,160,Expediente!=null ? String.valueOf(Expediente.getProveedor()) : "",false,false,68)%>
    <%=MyUtil.DoBlock("Datos del Expediente",0,0)%>
<!--
      <div class='VTable' style='position:absolute; z-index:40; left:490px; top:260px;'>
       <input class='cBtn' type='button' value="Número adicional" onClick="window.open('../TelefonoAdicional.jsp?clExpediente=<%=strclExpediente%>','','resizable=no,menubar=0,status=0,toolbar=0,height=160,width=430,screenX=-50,screenY=0')"></input>
      </div>
 -->
   <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=strclExpediente%>'>
   <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsrApp%>'>
   <%=MyUtil.ObjInput("Intento","IntentoLlamada",LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getIntentoLlamada()) : "",false,false,500,430,"",false,false,8)%>
   <%=MyUtil.ObjInput(i18n.getMessage("message.title.lada"),"Lada",LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getLada()) : "",true,true,30,340,LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getLada()) : "",true,false,8)%>
   <%=MyUtil.ObjInput("Teléfono","Telefono",LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getTelefonoContacto()) : "",true,false,95,340,LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getTelefonoContacto()) : "",true,false,12)%>
   <%=MyUtil.ObjComboC("Indicador de llamada","clIndicador",LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getdsIndicador()) : "",true,false,180,340,"","Select clIndicador,dsIndicador from SLcIndicador","fnHabilitarCampos(this.value);","",40,true,false)%> 
   <%=MyUtil.ObjComboC("Contacto con ","clTipoContactante",LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getTipoContactante()) : "",false,false,30,385,"","sp_SLTipoContactante","fnNU()","",65,false,false)%>         
   <%=MyUtil.ObjInput("Nombre de la persona contactada","NombreContactante",LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getNombreContactante()) : "",true,false,195,385,"",false,false,40)%>   
   <%=MyUtil.ObjComboC("Es el conductor?","EsConductor",LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getTipoContactante()) : "",false,false,425,385,"","Select 1,'SI' union select 0,'NO'","","",60,false,false)%>         
   <%=MyUtil.ObjInput("Fecha de Contacto","FechaLlamada",LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getFechaLlamada()) : "",false,false,425,340,"",false,false,30)%>   
   <%=MyUtil.ObjInput("Realizó llamada","clUsrAppVTR",LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getNombre()) : "",false,false,195,430,"",false,false,41)%>      
   <%=MyUtil.ObjInput("Extensión","Extension",LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getExtension()) : strExtension,true,false,425,430,strExtension,true,false,5)%>   
   <%=MyUtil.ObjInputF("Programar llamada", "FechaProgramada",LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getFechaProgramada()) :  "", true, false, 30, 430, "", false, false,20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaProgramadaMsk.value,this.name)};fnfecha(this);")%>
   <%=MyUtil.ObjTextArea("Observaciones","Observaciones",LlamadaEncuesta!=null ? LlamadaEncuesta.getObservaciones() :  "","100","3",true,false,30,480,LlamadaEncuesta!=null ? LlamadaEncuesta.getObservaciones() :  "",false,false)%>    
   <%=MyUtil.DoBlock("Datos de la Llamada",60,10)%>
       
   <%=MyUtil.ObjComboC("¿Su abogado lo ha mantenido informado de los avances en su asunto?","resp1",LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getresp1()) :  "",false,true,30,580,"","Select 1,'SI' union select 0,'NO'  ","","",10,false,false)%> 
   <%=MyUtil.ObjComboC("¿Ha tenido contacto telefónico o físico con su abogado en los últimos 15 días?","resp2",LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getresp2()) :  "",false,true,30,625,"","Select 1,'SI' union select 0 ,'NO' ","fnHabilitaP3()","",10,false,false)%> 
   <%=MyUtil.ObjComboC("¿Cuando fue la última vez que tuvo contacto con su abogado?","resp3",LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getresp3()) :  "",false,false,30,670,"","select clTiempoContacto,dsTiempocontacto from SLcTiempoContacto","","",20,false,false)%> 
   <%=MyUtil.ObjComboC("¿Existe inconformidad en Nuestro Usuario?","resp4",LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getresp4()) :  "",false,true,30,715,"","Select 1,'SI' union select 0 ,'NO' ","fnInconformidad();","",10,false,false)%> 
   <%=MyUtil.ObjComboC("Inconformidad","resp5",LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getresp5()) :  "",false,true,340,715,"","Select clInconformidad,dsInconformidad from SLcInconformidad where EsInconformidad=1 order by clInconformidad","","",60,false,false)%>    
   <%=MyUtil.ObjComboC("Observacion final","resp6",LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getresp6()) :  "",false,true,30,760,"","Select clInconformidad,dsInconformidad from SLcInconformidad where EsInconformidad=0 order by clInconformidad","","",60,false,false)%>    
   <%=MyUtil.ObjTextArea("Notas","Notas",LlamadaEncuesta!=null ? String.valueOf(LlamadaEncuesta.getNotas()) :  "","100","3",true,true,30,805,"",false,false)%>    
   <%=MyUtil.DoBlock("Encuesta",250,10)%>
  
        <%=MyUtil.GeneraScripts()%>

        <%
          strclExpediente = null;
          strclUsrApp = null;
          strIntentoLlamada = null;
          strExtension = null;
          Expediente = null;
          LlamadaEncuesta = null;
          daoSL = null;
          daoSLL = null;
        %>
        <input name='FechaProgramadaMsk' id='FechaProgramadaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<script>
    
    function fnfecha(fechaelegida)
    {
     if (fechaelegida != "")
     {
      var mydate=new Date();
      var year=mydate.getYear();
      if (year < 1000)
      year+=1900;
      var day=mydate.getDay();                    
      var month=mydate.getMonth()+1;
      if (month<10) month="0"+ month
      var daym=mydate.getDate();
      if (daym<10) daym= "0"+ daym
      var fecha = year+"-"+month+"-"+daym
      if (fechaelegida.value < fecha) 
      {
       alert("La Fecha para Nueva Llamada es anterior a la fecha actual.");
        showCalendarControl(fechaelegida); 
      }
     }
    }
    
    function fnInconformidad()
    {
     if (document.all.resp4.value==1)
     {
      document.all.resp5C.disabled = false;
     }
     else
     {
      document.all.resp5C.disabled = true;
      document.all.resp5C.value = '';
     
     }
    }

    //Habilitar campos segun el indicador de llamada
    function fnHabilitarCampos(valor)
    {
     switch (valor)
     {
      case '1': fnEncuesta(); break
      case '2': fnLlamadaProgramada();break
      case '3': fnNoseEncuentraNU();break
      case '4': fnNoEncuesta();break
      case '5': fnContestoGrabadora();break
      case '6': fnNoContesta();break
      case '7': fnTelefonoOcupado();break
      case '8': fnEquivocadoNoExiste();break
      case '9': fnSuspendido();break
      case '10': fnCambioDomicilio();break
      case '11': fnFallecio();break
     }
    }                   
    
    function fnEncuesta()
    {
     document.all.clTipoContactanteC.disabled = false 
     document.all.NombreContactante.disabled = false 
     document.all.FechaProgramada.disabled = true
     document.all.FechaProgramada.value = ""
     document.all.Observaciones.value = ""
     document.all.Observaciones.disabled = true
     document.all.resp1C.disabled = false
     document.all.resp2C.disabled = false
     document.all.resp4C.disabled = false
     document.all.resp6C.disabled = false
     document.all.Notas.disabled = false
    }
    
    function fnLlamadaProgramada()
    {
     document.all.clTipoContactanteC.disabled = true
     document.all.NombreContactante.disabled = true
     document.all.FechaProgramada.disabled = false
     document.all.Observaciones.disabled = false
         
     fnBorraEncuesta()
    }
    
    function fnNoseEncuentraNU()
    {
     document.all.clTipoContactanteC.disabled = true
     document.all.NombreContactante.disabled = true
     document.all.FechaProgramada.value = ""
     document.all.FechaProgramada.disabled = true
     document.all.Observaciones.disabled = false

     fnBorraEncuesta()
    }
    
    function fnNoEncuesta()
    {
     document.all.clTipoContactanteC.disabled = false
     document.all.NombreContactante.disabled = false
     document.all.FechaProgramada.value = ""
     document.all.FechaProgramada.disabled = true
     document.all.Observaciones.disabled = false

     fnBorraEncuesta()
    }
    
    function fnContestoGrabadora()
    {
     document.all.clTipoContactanteC.disabled = true
     document.all.clTipoContactanteC.value = ""
     document.all.NombreContactante.disabled = true
     document.all.NombreContactante.value = ""
     document.all.EsConductorC.value = ""
     document.all.EsConductorC.disabled = true
     document.all.FechaProgramada.value = ""
     document.all.FechaProgramada.disabled = true
     document.all.Observaciones.disabled = false
     
     fnBorraEncuesta()
    }
    
    function fnNoContesta()
    {
     document.all.clTipoContactanteC.disabled = true
     document.all.clTipoContactanteC.value = ""
     document.all.NombreContactante.disabled = true
     document.all.NombreContactante.value = ""
     document.all.EsConductorC.disabled = true
     document.all.EsConductorC.value = ""
     document.all.FechaProgramada.value = ""
     document.all.FechaProgramada.disabled = true
     document.all.Observaciones.disabled = true

     fnBorraEncuesta()
    }
    
    function fnTelefonoOcupado()
    {
     document.all.clTipoContactanteC.disabled = true
     document.all.clTipoContactanteC.value = ""
     document.all.NombreContactante.disabled = true
     document.all.NombreContactante.value = ""
     document.all.EsConductorC.disabled = true
     document.all.EsConductorC.value = ""
     document.all.FechaProgramada.value = ""
     document.all.FechaProgramada.disabled = true
     document.all.Observaciones.disabled = false

     fnBorraEncuesta()
    }

    function fnEquivocadoNoExiste()
    {
     document.all.clTipoContactanteC.disabled = true
     document.all.clTipoContactanteC.value = ""
     document.all.NombreContactante.disabled = true
     document.all.NombreContactante.value = ""
     document.all.EsConductorC.disabled = true
     document.all.EsConductorC.value = ""
     document.all.FechaProgramada.value = ""
     document.all.FechaProgramada.disabled = true
     document.all.Observaciones.disabled = false

     fnBorraEncuesta()
    }

    function fnSuspendido()
    {
     document.all.clTipoContactanteC.disabled = true
     document.all.clTipoContactanteC.value = ""
     document.all.NombreContactante.disabled = true
     document.all.NombreContactante.value = ""
     document.all.EsConductorC.disabled = true
     document.all.EsConductorC.value = ""
     document.all.FechaProgramada.value = ""
     document.all.FechaProgramada.disabled = true
     document.all.Observaciones.disabled = true
     fnBorraEncuesta()
    }

    function fnCambioDomicilio()
    {
     document.all.clTipoContactanteC.disabled = true
     document.all.clTipoContactanteC.value = ""
     document.all.NombreContactante.disabled = true
     document.all.NombreContactante.value = ""
     document.all.EsConductorC.disabled = true
     document.all.EsConductorC.value = ""
     document.all.FechaProgramada.value = ""
     document.all.FechaProgramada.disabled = true
     document.all.Observaciones.disabled = true

     fnBorraEncuesta()
     }

     function fnFallecio()
     {
      document.all.clTipoContactanteC.disabled = false 
      document.all.NombreContactante.disabled = false 
      document.all.FechaProgramada.value = ""
      document.all.FechaProgramada.disabled = true
      document.all.resp1C.disabled = false
      document.all.resp2C.disabled = false
      document.all.resp4C.disabled = false
      document.all.resp6C.disabled = false
      document.all.Notas.disabled = false
     }
   
     function fnBorraEncuesta()
     {
      document.all.resp1C.disabled = true 
      document.all.resp1C.value = ""
      document.all.resp2C.disabled = true 
      document.all.resp2C.value = ""
      document.all.resp3C.disabled = true 
      document.all.resp3C.value = ""
      document.all.resp4C.disabled = true 
      document.all.resp4C.value = "" 
      document.all.resp5C.disabled = true 
      document.all.resp5C.value = "" 
      document.all.resp6C.disabled = true 
      document.all.resp6C.value = "" 
      document.all.Notas.disabled = true  
      document.all.Notas.value = ""
     }
    
    
     function fnCalculaFecha()
     {
      var mydate = new Date();
      var year = mydate.getYear();
      if (year < 1000)
      year += 1900;
      var day=mydate.getDay();                    
      var month=mydate.getMonth()+1;
      if (month<10) month="0"+ month
      var daym=mydate.getDate() + 1;
      if (daym<10) daym= "0"+ daym
      var fecha = year + "-" + month + "-" + daym + " 00:00"
      return fecha;
     }
    

    function fnNU()
    {
     if (document.all.clTipoContactanteC.value==15)
     {
      document.all.NombreContactante.value=document.all.ContactoVTR.value
      document.all.EsConductorC.disabled=false
     }
     else
     {
      if (document.all.clTipoContactanteC.value==17)
      {
       document.all.EsConductorC.disabled=true
       document.all.EsConductorC.value=""
      }
      else
      {
       document.all.EsConductorC.disabled=false
      }
      document.all.NombreContactante.value=""
     }
    }

    function fndsHabilitar()
    {
     document.all.clTipoContactanteC.disabled = true
     document.all.EsConductorC.disabled = true
     document.all.FechaLlamada.disabled = true
     document.all.FechaProgramada.disabled = true
     document.all.Observaciones.disabled = true
     document.all.NombreContactante.disabled = true 
     document.all.resp1C.disabled = true 
     document.all.resp2C.disabled = true 
     document.all.resp3C.disabled = true 
     document.all.resp4C.disabled = true 
     document.all.resp5C.disabled = true 
     document.all.resp6C.disabled = true             
     document.all.Notas.disabled = true  
     if (document.all.Action.value!=1)
     {
      document.all.Tel1.disabled = true;
      document.all.Tel2.disabled = true;
     }
    }

    function fnHabilitaP3()
    {
     if (document.all.resp2.value==1)
     {
      document.all.resp3C.disabled = true;
      document.all.resp3C.value = "";
     }
     else
     {
      document.all.resp3C.disabled = false;

     }        
    }
    
    function fnLlenaTelefono (tel)
    {
     if (tel==1)
     {
      document.all.Lada.value=document.all.Lada1VTR.value;
      document.all.Telefono.value=document.all.Telefono1VTR.value;
     }
     else
     {
      document.all.Lada.value=document.all.Lada2VTR.value;
      document.all.Telefono.value=document.all.Telefono2VTR.value;

     }
    }

    function fnHabBtnsTel()
    {
         document.all.Tel1.disabled = false;
         document.all.Tel2.disabled = false;
    }
    
    
    //VALIDACION PARA ANTES DE GUARDAR
   function fnAntesGuardar()
   {
    //VALIDACION DE LA LLAMADA
    
    if (document.all.clIndicador.value == 1 || document.all.clIndicador.value == 11 || document.all.clIndicador.value == 4)
    {
     if (document.all.clTipoContactante.value == '')
     {
      msgVal = msgVal + " Contacto con."
      document.all.btnGuarda.disabled = false;
      document.all.btnCancela.disabled = false;
     }
     
     if (document.all.NombreContactante.value=='' || document.all.NombreContactante.value=='  ' || document.all.NombreContactante.value=='   ')
     {
      msgVal = msgVal + " Nombre de la persona contactada."
      document.all.btnGuarda.disabled = false;
      document.all.btnCancela.disabled = false;
     }
     
     if (document.all.clTipoContactante.value == 12 || document.all.clTipoContactante.value== 15)
     {
      if(document.all.EsConductor.value=='' || document.all.EsConductor.value=='')
      {
       msgVal = msgVal + " Es Conductor."
       document.all.btnGuarda.disabled = false;
       document.all.btnCancela.disabled = false;
      }
    
     }
     
     if (document.all.clIndicador.value == 4)
     {
      if (document.all.Observaciones.value == '' || document.all.Observaciones.value == ' ' || document.all.Observaciones.value == '  ')
      {
       msgVal = msgVal + " Observaciones."
       document.all.btnGuarda.disabled = false;
       document.all.btnCancela.disabled = false;
      }
     }
    }
    
    if (document.all.clIndicador.value == 2 || document.all.clIndicador.value == 3 || document.all.clIndicador.value == 5 || document.all.clIndicador.value == 7 || document.all.clIndicador.value == 8)
    {
      if (document.all.Observaciones.value == '' || document.all.Observaciones.value == ' ' || document.all.Observaciones.value == '  ')
      {
       msgVal = msgVal + " Observaciones."
       document.all.btnGuarda.disabled = false;
       document.all.btnCancela.disabled = false;
      }
    }
    
    //VALIDACION DE LA ENCUESTA
    if (document.all.clIndicador.value == 1 || document.all.clIndicador.value == 11)
    {
     if (document.all.resp1.value =='')
     {
      msgVal = msgVal + " Respuesta de la pregunta 1."
      document.all.btnGuarda.disabled = false;
      document.all.btnCancela.disabled = false;
     }
     
     if (document.all.resp2.value =='')
     {
      msgVal = msgVal + " Respuesta de la pregunta 2."
      document.all.btnGuarda.disabled = false;
      document.all.btnCancela.disabled = false;
     }
     else
     {
      if (document.all.resp2.value==0 && document.all.resp3.value == '')
      {
       msgVal = msgVal + " Respuesta de la pregunta 3."
       document.all.btnGuarda.disabled = false;
       document.all.btnCancela.disabled = false;
      }
     }
     
     if (document.all.resp4.value =='')
     {
      msgVal = msgVal + " Respuesta de la pregunta 4."
      document.all.btnGuarda.disabled = false;
      document.all.btnCancela.disabled = false;
     }
     else
     {
      if (document.all.resp4.value == 1)
      {
       if (document.all.resp5.value == '')
       {
        msgVal = msgVal + " Inconformidad."
        document.all.btnGuarda.disabled = false;
        document.all.btnCancela.disabled = false;
       }
      }
     }
        
     if (document.all.resp6.value == '')
     {
      msgVal = msgVal + " Observacion Final."
      document.all.btnGuarda.disabled = false;
      document.all.btnCancela.disabled = false;
      }

     if (document.all.Notas.value == '')
     {
      msgVal = msgVal + " Notas."
      document.all.btnGuarda.disabled = false;
      document.all.btnCancela.disabled = false;
     }

    }
   }
    
</script>
</body>
</html>

