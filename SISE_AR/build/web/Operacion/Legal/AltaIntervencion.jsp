<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.ActuaInter.DAOAI,com.ike.ActuaInter.to.AIExpediente,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@ page pageEncoding="iso-8859-1"%>
<html>
<head><title>Alta Intervencion</title>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css"> 
            <style type="text/css">
                .Mensaje {
                font-family: Verdana, Arial, Helvetica, sans-serif;
                color: #FFFFFF;
                font-size: 12px;
                background-color: #000080
                }
                .Titulo {
                background-color: #e6f2f9;
                border: 2px solid #000066;
                }
            </style>
</head>
<body class="cssBody" onload="fnLimpiaFechas()">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<script src="../../Utilerias/UtilCalendario.js"></script>
<script src='../../Utilerias/UtilMask.js'></script>
<%
    String strclExpediente = "0";
    String strclAsistencia = "0";
    String strClave = "0";
    String strclUsrApp = "0";
    String strSise = "0";
    String strSelect = "";
    String StrFecha  = "";

//Variables por sistema    
    String strTitulo = "";
    int strCoordx = 0;
    
    if (request.getParameter("clExpediente")!=null)
    {
        strclExpediente = request.getParameter("clExpediente").toString();
    }
    
    if (request.getParameter("clAsistencia")!=null)
    {
        strclAsistencia = request.getParameter("clAsistencia").toString();
    }
    
    if (session.getAttribute("clUsrApp")!=null)
    {
        strclUsrApp = session.getAttribute("clUsrApp").toString();
    }

    if (request.getParameter("Sise")!=null)
    {
        strSise = request.getParameter("Sise").toString();
    }
    
    if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true) 
    {
%>
<b>Fuera de Horario</b>
<%
        strclUsrApp = null;
        return;       
   }

     if (strSise.equalsIgnoreCase("1")){
            strClave = strclExpediente;
        }else{
            strClave = strclAsistencia;
        }
    
 
    DAOAI daoAI = null;
    AIExpediente  Expediente = null;
    
    if (strClave.compareToIgnoreCase("0")!=0)
    {
        daoAI = new DAOAI();
        Expediente = daoAI.getExpediente(strClave);    
    }
   
       String StrclPaginaWeb = "658";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
       MyUtil.InicializaParametrosC(658,Integer.parseInt(strclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 

       strTitulo = "SISE";
       strCoordx = 30;
       
       if (strSise.compareToIgnoreCase("0")!=1)
       {
           strTitulo = "SEA";
       
       }
       ResultSet rs4 = UtileriasBDF.rsSQLNP( "Select convert(varchar(16),getdate(),120) fechaEt ");  

    if (rs4.next()){
       StrFecha = rs4.getString("fechaEt");
    }    
    
%>
    <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaGuardaActuaInt","fnLimpiaFechas();","fnAntesGuardar();fnCronologia();fnValidaCampos();")%>
    <INPUT id='numCar' name='numCar' type='hidden' value='0'>
    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>../../servlet/Utilerias.Lista?P=657'></input>
    <INPUT id='Sise' name='Sise' type='hidden' value='<%=strSise%>'>
    <INPUT id='fechaEt' name='fechaEt' type='hidden' value='<%=StrFecha%>'>
    <%=MyUtil.ObjInput("Expediente","clExpediente",Expediente != null ? Expediente.getclExpediente() : "",false,false,30,70,Expediente != null ? Expediente.getclExpediente() : "",false,false,20)%>
    <%=MyUtil.ObjInput("Fecha de Actualizacion","FechaActualizacion",Expediente != null ? Expediente.getFechaActualizacion() : "",false,false,250,70,Expediente != null ? Expediente.getFechaActualizacion() : "",false,false,25)%>

<%
    if (strSise.compareToIgnoreCase("0")!=1)
    {
%>
    <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%=Expediente != null ? Expediente.getclAsistencia() : ""%>'>
    <%=MyUtil.ObjInput("Asistencia","AsistenciaVTR",Expediente != null ? Expediente.getAsistencia() : "",true,false,150,70,Expediente != null ? Expediente.getAsistencia() : "",false,false,17)%>
<%
    }
%>
    <%=MyUtil.ObjInput("Averiguacion previa","AvPrevia",Expediente != null ? Expediente.getAveriguacionPrevia() : "",true,true,450,70,Expediente != null ? Expediente.getAveriguacionPrevia() : "",false,false,30)%>
    <%=MyUtil.ObjComboC("Proveedor Jurídico","clProveedor","",true,true,30,110,"","st_AILlenaComboProvxExp " + strClave,"","",100,true,false)%>
    <%=MyUtil.ObjComboC("Etapa","clEtapaProcedimiento","",true,false,330,110,"","st_AIObtenEtapasprocedimiento " + strSise,"","",60,true,false)%>
    <%=MyUtil.ObjInputF("Fecha de Tramite", "FechaIntervencion","",true,false,520,110,"",true, false,20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};")%>         
    <%=MyUtil.ObjComboC("Objetivo Legal","clObjetivoLegal","",true,true,30,155,"","st_AIObtenObjetivoLegal " + strSise,"","",80,true,true)%>
    <%=MyUtil.ObjComboC("Estatus de Recuperacion","clEstatusRecupDanos",Expediente != null ? Expediente.getdsEstatusRecupDanos() : "",true,true,30,200,Expediente != null ? Expediente.getdsEstatusRecupDanos() : "0","select clEstatusRecupDanos,dsEstatusRecupDanos from cEstatusRecupDanos","","",80,true,true)%>
    <%=MyUtil.ObjChkBox("Resultado","ObjetivoResultado","", true,true,375,200,"1","SI","NO","")%>     
    <%=MyUtil.ObjComboC("Culpa Según Dictamen","clCulpaDicta",Expediente != null ? Expediente.getdsCulpaDicta() : "",true,true,480,200,Expediente != null ? Expediente.getclCulpaDicta() : "","st_AILlenaComboCulpaDicta " + strClave,"","",30,false,false)%>
    
    <%=MyUtil.ObjInput("Email","Correo",Expediente != null ? Expediente.getEmail() : "",true,true,450,155,Expediente != null ? Expediente.getEmail() : "",false,false,30)%>

    <%=MyUtil.ObjInputF("Fecha proximo tramite", "FechaTramite","",true,false,30,250,"",true, false,20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};")%>    
    <%=MyUtil.ObjInputF("Fecha tentativa conclusión", "FechaTentativa","",true,true,30,316,"",false, false,20,2,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};")%>    

    <%=MyUtil.ObjTextArea("¿Que hice?","QueHice","","80","4",true,false,190,250,"",true,false,"textCounter(document.forma.remLen,190);","textCounter(document.forma.remLen,190);")%>    
    <%=MyUtil.ObjTextArea("¿Para que lo hice?","ParaQueHice","","80","4",true,false,190,325,"",true,false,"textCounter(document.forma.remLen,190);","textCounter(document.forma.remLen,190);")%>        
    <%=MyUtil.ObjTextArea("¿Que resultado obtuve?","ResultadoObtuve","","80","4",true,false,190,400,"",true,false,"textCounter(document.forma.remLen,190);","textCounter(document.forma.remLen,190);")%>        
    <%=MyUtil.ObjTextArea("¿Que sucedera despues?","SucederaDespues","","80","4",true,false,190,475,"",true,false,"textCounter(document.forma.remLen,190);","textCounter(document.forma.remLen,190);")%>            
    <%=MyUtil.ObjInput("CARACTERES","remLen","0",false,false,650,500,"",false,false,4)%>
    <%=MyUtil.ObjComboC("Estatus de la Unidad","clEstatusUnidad",Expediente != null ? Expediente.getdsEstatusUnidad() : "",true,true,30,475,Expediente != null ? Expediente.getclEstatusUnidad() : "","Select clEstatusUnidad, dsEstatusUnidad From cEstatusUnidad","fnEstatus()","",60,true,true)%>
    <%=MyUtil.ObjInputF("Fecha detencion","FechaDetencion",Expediente != null ? Expediente.getFechaDetencion() : "",true,true,30,545,Expediente != null ? Expediente.getFechaDetencion() : "",false,false,20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name);fnComprobacionFecha();};")%>             
    <%=MyUtil.ObjInputF("Fecha Acreditacion Propiedad","FechaAcredProp",Expediente != null ? Expediente.getFechaAcredProp() : "",true,true,220,545,Expediente != null ? Expediente.getFechaAcredProp() : "",false,false,20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name);fnComprobacionFecha();}")%>
    <%=MyUtil.ObjInputF("Fecha oficio liberacion","FechaOficioLibera",Expediente != null ? Expediente.getFechaOficioLibera() : "",true,true,430,545,Expediente != null ? Expediente.getFechaOficioLibera() : "",false,false,20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name);fnComprobacionFecha();};")%>
    <%=MyUtil.ObjInput("Avaluo pericial","MontoAvaluo",Expediente != null ? Expediente.getAvaluoPericial() : "0",true,true,strCoordx,590,Expediente != null ? Expediente.getAvaluoPericial() : "0",false,false,30,"EsNumerico(document.all.MontoAvaluo)")%>
    <%=MyUtil.ObjInputF("Fecha liberacion","FechaLibera",Expediente != null ? Expediente.getFechaLibera() : "",true,true,220,590,Expediente != null ? Expediente.getFechaLibera() : "", false, false,20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};")%>         
    <%=MyUtil.ObjInputF("Fecha Presentacion Querella", "FechaPresQuerella",Expediente != null ? Expediente.getFechaPresQuerella() : "",true,true,430,590,Expediente != null ? Expediente.getFechaPresQuerella() : "", false, false,20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};")%>
<%
    if (strSise.compareToIgnoreCase("0")!=0)
    {
%>
    <%=MyUtil.ObjTextArea("Motivos de no liberacion (Vehiculo)","MotivoNoLiberacion",Expediente != null ? Expediente.getMotivoNoLiberacion() : "","110","3",true,true,30,635,Expediente != null ? Expediente.getMotivoNoLiberacion() : "",true,true)%>
<%
    }
%>
    <%=MyUtil.DoBlock("Actualizacion " + strTitulo,10,30)%>
    
    <!-- <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%//=StrclExpediente%>'>                 
       <INPUT id='clLlamada' name='clLlamada' type='hidden' value='<%//=StrclLlamada%>'>           -->
       <%=MyUtil.ObjInput("Quien Atendio","NombreAtendio","",true,true,220,750,"",false,false,50)%>
       <%=MyUtil.ObjInput("Teléfono","TelefonoLlamada","",true,true,30,795,"",false,false,30)%>
       <%=MyUtil.ObjComboC("Tipo Persona Atiende","clTipoPersAten","",true,true,220,795,"","select clTipoPersAten,dsTipoPersAten from cTipoPersAten ","","",70,false,false)%>
       <%=MyUtil.ObjInput("Fecha Llamada","FechaLlamadaVTR","",false,false,30,750,"",false,false,22)%>
       <%=MyUtil.ObjInput("Proveedor","Proveedor","",true,true,30,840,"",false,false,60,"if(this.readOnly==false){fnBuscaProv();}")%>
	<INPUT id='clProveedorLlamada' name='clProveedorLlamada' type='hidden' value=''><%
                if (MyUtil.blnAccess[4]==true){ %>
                    <div class='VTable' style='position:absolute; z-index:30; left:350px; top:855px;'>
                    <IMG SRC='../../Imagenes/Lupa.gif' class='handM' onClick='fnBuscaProv();' WIDTH=20 HEIGHT=20></div><%
                } %>
       <%=MyUtil.ObjTextArea("Observaciones","Observaciones","", "85","4",true,true,30,880,"",false,false)%>
       <%=MyUtil.DoBlock("Datos de la Llamada",110,30)%>
    
       
    
    <%=MyUtil.GeneraScripts()%>
    <div name="M1" id="M1" class='Mensaje' style='position:absolute; z-index:101; left:550px; top:270px; visibility:hidden;border-style:outset ;border-width:medium ;width:240px; height:100px;' align="center">
        <p class='cssTitDet'>Aviso</p>El texto es demasiado grande, se enviara en dos mensajes.            
    </div>
        <div name="M2" id="M2" class='Mensaje' style='position:absolute; z-index:31; left:550px; top:380px; visibility:hidden;border-style:outset ;border-width:medium ;width:240px; height:100px;' align="center">
            <p class='cssTitDet'>Aviso</p>El mensaje es demasiado largo, unicamente se enviaran 190 caracteres.
        </div>
    <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<script>
    document.all.btnCambio.disabled=true;

    textCounter(document.forma.remLen,190);        
        
    function textCounter(countfield,maxlimit) {

        document.forma.numCar.value = '0';
        countfield.value ='0';
        document.forma.numCar.value =  parseInt(document.forma.numCar.value) + document.forma.QueHice.value.length+document.forma.ParaQueHice.value.length +document.forma.ResultadoObtuve.value.length+document.forma.SucederaDespues.value.length;                                                          
        countfield.value = parseInt(countfield.value) + parseInt(document.forma.numCar.value);              

        if (parseInt(document.forma.numCar.value) <= 43 )
            Oculta(document.all.M1);                           
        if (parseInt(document.forma.numCar.value) <= maxlimit )
            Oculta(document.all.M2);

        if (parseInt(document.forma.numCar.value) > 43 )
            Visible(document.all.M1);
        if (parseInt(document.forma.numCar.value) > maxlimit )
            Visible(document.all.M2);

    }

    function Visible(me){
       if (me.style.visibility=="hidden"){
           me.style.visibility="visible";
       }
    } 

    function Oculta(me){
       if (me.style.visibility=="visible"){
           me.style.visibility="hidden";
       }
    }
    
    
    function fnAntesGuardar()
    {
     if (document.all.NombreAtendio.value != '' || document.all.TelefonoLlamada.value != '' || document.all.clTipoPersAten.value != '' || document.all.Proveedor.value !='' || document.all.clProveedorLlamada.value != '' || document.all.Observaciones.value)
     {
      if (document.all.NombreAtendio.value == '')
      {
       msgVal = msgVal + " Quien Atendio. "
       document.all.btnGuarda.disabled = false;
       document.all.btnCancela.disabled = false;       
      }
      
      if (document.all.TelefonoLlamada.value == '')
      {
       msgVal = msgVal + " Telefono Llamada. "
       document.all.btnGuarda.disabled = false;
       document.all.btnCancela.disabled = false;       
      }

       if (document.all.clTipoPersAten.value == '')
      {
       msgVal = msgVal + " Tipo Persona Atiende. "
       document.all.btnGuarda.disabled = false;
       document.all.btnCancela.disabled = false;       
      }

           if (document.all.Proveedor.value == '' || document.all.clProveedorLlamada.value == '')
      {
       msgVal = msgVal + " Proveedor Llamada. "
       
       document.all.btnGuarda.disabled = false;
       document.all.btnCancela.disabled = false;       
      }
      
           if (document.all.Observaciones.value == '')
      {
       msgVal = msgVal + " Observaciones Llamada. "
       document.all.btnGuarda.disabled = false;
       document.all.btnCancela.disabled = false;       
      }
      
      }
    }

function fnEstatus()
     { 
       if (document.all.clEstatusUnidad.value == 3) //Libre
        {
        document.all.FechaDetencion.value = "";
        document.all.FechaAcredProp.value = "";
        document.all.FechaOficioLibera.value = "";
        document.all.FechaLibera.value = "";              
        document.all.FechaDetencion.readOnly = true;
        document.all.FechaAcredProp.readOnly = true;
        document.all.FechaOficioLibera.readOnly = true; 
        document.all.FechaLibera.readOnly = true;                                  
        }     
            
        if (document.all.clEstatusUnidad.value == 2) //Detenido
        {
            if (document.all.FechaDetencion.value =="")
            {document.all.FechaDetencion.value = document.all.fechaEt.value; }                                                   
            document.all.FechaOficioLibera.value = "";
            document.all.FechaLibera.value = "";              
            document.all.FechaDetencion.readOnly = false;
            document.all.FechaAcredProp.readOnly = false;
            document.all.FechaOficioLibera.readOnly = true; 
            document.all.FechaLibera.readOnly = true;                                  
        }  
                
        if (document.all.clEstatusUnidad.value == 1) //Liberada
        {
            if (document.all.FechaDetencion.value =="")
                {alert("Debe Ingresar Fecha de Detencion");
                document.all.FechaDetencion.value = document.all.fechaEt.value;
                document.all.clEstatusUnidadC.value=2; document.all.clEstatusUnidad.value =2 //
                document.all.FechaOficioLibera.value = ""; 
                document.all.FechaLibera.value = ""; 
                document.all.FechaDetencion.readOnly = false;
                document.all.FechaAcredProp.readOnly = false;            
                document.all.FechaOficioLibera.readOnly = true; 
                document.all.FechaLibera.readOnly = true;            
                return;
                }

            if (document.all.FechaDetencion.value!="" && document.all.FechaAcredProp.value =="")
                {alert("Debe Ingresar Fecha de Acreditación");
                //document.all.FechaAcredProp.value = document.all.fechaEt.value;
                document.all.clEstatusUnidadC.value=2; document.all.clEstatusUnidad.value = 2 //                    
                document.all.FechaOficioLibera.value = ""; 
                document.all.FechaLibera.value = "";
                document.all.FechaOficioLibera.readOnly = true; 
                document.all.FechaLibera.readOnly = true;            
                return;
                }                
                    
        document.all.FechaOficioLibera.value = document.all.fechaEt.value; 
        document.all.FechaLibera.value = document.all.fechaEt.value;              
        document.all.FechaDetencion.readOnly = true;
        document.all.FechaAcredProp.readOnly = true;
        document.all.FechaOficioLibera.readOnly = false; 
        document.all.FechaLibera.readOnly = false;                                          
        }    
     } 
    
    function fnCronologia()
    {
     
     if (document.all.FechaIntervencion.value!='' && document.all.FechaTramite.value!= '')
     {
      if (document.all.FechaIntervencion.value >= document.all.FechaTramite.value)
      {
       msgVal = msgVal + " La Fecha de Proximo Tramite debe ser mayor a la de Tramite. "
       document.all.btnGuarda.disabled = false;
       document.all.btnCancela.disabled = false;       
      }
     }

     if (document.all.FechaDetencion.value!='' && document.all.FechaAcredProp.value!= '')
     {
      if (document.all.FechaDetencion.value >= document.all.FechaAcredProp.value)
      {
       msgVal = msgVal + " La Fecha de Acreditación de Propiedad del Vehículo debe ser mayor a la de Detencion. "
       document.all.btnGuarda.disabled = false;
       document.all.btnCancela.disabled = false;       
      }
     }

     if (document.all.FechaAcredProp.value!= '' && document.all.FechaOficioLibera.value!= '')
     {
      if (document.all.FechaAcredProp.value >= document.all.FechaOficioLibera.value)
      {
       msgVal = msgVal + " La Fecha de Oficio de Liberacion del Vehículo debe ser mayor a la de Acreditacion de Propiedad. "
       document.all.btnGuarda.disabled = false;
       document.all.btnCancela.disabled = false;       
      }
      
      if (document.all.FechaOficioLibera.value!="" && document.all.FechaLibera.value!="")
      {
       if(document.all.FechaOficioLibera.value > document.all.FechaLibera.value)
       {
        msgVal=msgVal + " La Fecha de Liberación del Vehículo debe ser mayor o igual a la de Oficio de Liberación. ";
        document.all.btnGuarda.disabled = false;
        document.all.btnCancela.disabled = false;       

       }
      }      
     }
    }
    
    function fnComprobacionFecha()
    {
    
     if (document.all.FechaAcredProp.value != '' && document.all.FechaDetencion.value=='')
     {
      alert("No se proporciono la Fecha de Detencion");
     }
     
     if (document.all.FechaOficioLibera.value != '' && document.all.FechaAcredProp.value=='')
     {
      alert("No se proporciono la Fecha de Acreditacion de la Propiedad");
     }
     
     if (document.all.FechaLibera.value != '' && document.all.FechaOficioLibera.value=='')
     {
      alert("No se proporciono la Fecha de Oficion de Liberacion");
     }
     

     if (document.all.FechaDetencion.value == '' && (document.all.FechaAcredProp.value != '' || document.all.FechaOficioLibera.value != '' || document.all.FechaLibera.value != ''))
     {
      if(confirm("Las fechas subsecuentes seran eliminadas")==true)
      {
       document.all.FechaAcredProp.value="";
       document.all.FechaOficioLibera.value="";
       document.all.FechaLibera.value="";
      }
      else
      {
       document.all.FechaDetencion.focus();
      }
     }

     if (document.all.FechaAcredProp.value == '' && (document.all.FechaOficioLibera.value != '' || document.all.FechaLibera.value != ''))
     {
      if(confirm("Las fechas subsecuentes seran eliminadas")==true)
      {
       document.all.FechaOficioLibera.value="";
       document.all.FechaLibera.value="";
      }
      else
      {
       document.all.FechaAcredProp.focus();
      }
     }

     if (document.all.FechaOficioLibera.value == '' && document.all.FechaLibera.value != '')
     {
      if(confirm("Las fechas subsecuentes seran eliminadas")==true)
      {
       document.all.FechaLibera.value="";
      }
      else
      {
       document.all.FechaOficioLibera.focus();
      }
     }
   
   }
   
   function fnValidaCampos(){
     if(document.all.MontoAvaluo.value==''){
       msgVal = msgVal + " El Avaluo Pericial no debe esta vacio. ";
       document.all.MontoAvaluo.value = 0;
       document.all.btnGuarda.disabled = false;
       document.all.btnCancela.disabled = false;
    }
   }
   
    function fnValidaError(){
        blnAceptar=0;
        document.all.btnGuarda.disabled=false;
        document.all.btnCancela.disabled=false;
        WSave.close();
    }
    
    function fnLimpiaFechas(){
        if (document.all.FechaDetencion.value=='1900-01-01 00:00') {document.all.FechaDetencion.value=''}
        if (document.all.FechaAcredProp.value=='1900-01-01 00:00') {document.all.FechaAcredProp.value=''}
        if (document.all.FechaOficioLibera.value=='1900-01-01 00:00') {document.all.FechaOficioLibera.value=''}
        if (document.all.FechaLibera.value=='1900-01-01 00:00') {document.all.FechaLibera.value=''}
        if (document.all.FechaPresQuerella.value=='1900-01-01 00:00') {document.all.FechaPresQuerella.value=''}
    }
    
         function fnBuscaProv(){
         var pstrCadena = "../../Utilerias/FiltrosProv.jsp?strSQL=sp_WebBuscaProv ";
         pstrCadena = pstrCadena + "&NombreOpe= " + document.all.Proveedor.value;
         document.all.clProveedorLlamada.value='';
         window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
    }
  
    function fnActualizaProv(pclProveedor, pNombreOperativo){
        document.all.clProveedorLlamada.value = pclProveedor;
        document.all.Proveedor.value = pNombreOperativo;
    }
</script>
</body>
</html>