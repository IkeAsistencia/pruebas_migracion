<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Datos de Vehiculo Involucrado</title>
    <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody" onLoad="fnGNPInfo();fnVaciarFechas()">
    
    <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackagAL.BeanClassName" /> --%>
    <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
    
    <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
    
    <script src='../../Utilerias/Util.js' ></script>
    <script src='../../Utilerias/UtilAuto.js' ></script>
    <script src='../../Utilerias/UtilMask.js'></script>
    <script src='../../Utilerias/UtilDireccion.js' ></script>
    
    <%  
    String StrclUsrApp="0";
    com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
    
    
    
    if (session.getAttribute("clUsrApp")!= null)
    {
        StrclUsrApp = session.getAttribute("clUsrApp").toString();
    }
    
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)
    {
    %>Fuera de Horario<%
    StrclUsrApp=null;
    
    return;
    }
    String StrclExpediente = "0";
    String StrclVehiculo = "0";
    String StrclPaginaWeb="0";
    String StrFecha = "";
    String StrAseguradora="";
    String StrFechaDetencion="";
    String StrFechaDetConduc="";
    
    if (session.getAttribute("clExpediente")!= null)
    {
        StrclExpediente = session.getAttribute("clExpediente").toString();
    }
    
    StringBuffer StrSql = new StringBuffer();
    StrSql.append("Select clExpediente From AsistenciaLegal Where clExpediente =").append(StrclExpediente);
    ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
    
    if (rs2.next())
    {
        // bien, si existe!!!
    }
    else
    {
    %>No existe Aistencia Legal, debe crearla primero!<%
    rs2.close();
    rs2=null;
    StrclExpediente = null;
    StrclVehiculo = null;
    StrSql = null;
    StrclPaginaWeb=null;
    StrFecha = null;
    StrAseguradora=null;
    StrFechaDetencion=null;
    StrFechaDetConduc=null;
    StrclUsrApp=null;
    
    return;
    }
    
    ResultSet rs4 = UtileriasBDF.rsSQLNP( "Select convert(varchar(16),getdate(),120) fechaEt ");
    
    if (rs4.next())
    {
        StrFecha = rs4.getString("fechaEt");
    }
    
    StrSql.append("Select C.clAseguradora, A.dsAseguradora from Expediente E");
    StrSql.append(" Left join cCuenta C ON (C.clCuenta=E.clCuenta)");
    StrSql.append(" Left join cAseguradora A ON (A.clAseguradora=C.clAseguradora)");
    StrSql.append(" Where clExpediente =").append(StrclExpediente);
    ResultSet rs5 = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
    
    if (rs5.next())
    {
        StrAseguradora = rs5.getString("clAseguradora");
    }
    
    StrSql.append(" Select  EXPED.CodEnt, E.dsEntFed, EXPED.CodMD, D.dsMunDel ");
    StrSql.append(" From Expediente EXPED");
    StrSql.append(" LEFT JOIN cEntFed E ON(E.CodEnt = EXPED.CodEnt) ");
    StrSql.append(" LEFT JOIN cMunDel D ON(E.CodEnt = D.CodEnt and D.CodMD=EXPED.CodMD) ");
    StrSql.append(" Where clExpediente=").append(StrclExpediente);
    
    ResultSet rs3 = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
    if (rs3.next())
    {
        
        StrSql.append("Select V.clVehiculo, coalesce(M.dsMarcaAuto,'') as dsMarcaAuto, coalesce(T.dsTipoAuto,'') as dsTipoAuto,  ");
        StrSql.append(" coalesce(V.CodigoMarca,'') as CodigoMarca, coalesce(V.ClaveAMIS,'') as ClaveAMIS,  coalesce(V.Modelo,'') as Modelo,  ");
        StrSql.append(" coalesce(V.Placas,'') as Placas, coalesce(V.Color,'') as Color, coalesce(TV.dsTipoVehiculo,'') as dsTipoVehiculo,  ");
        StrSql.append(" coalesce(V.Serie,'') as Serie, coalesce(V.NoMotor,'') as NoMotor, coalesce(E.dsEstatusUnidad,'') as dsEstatusUnidad, ");
        StrSql.append(" V.clEstatusUnidad, ");
        StrSql.append(" coalesce(convert(varchar(16), V.FechaDetencion,120),'') as FechaDetencion, ");
        StrSql.append(" coalesce(convert(varchar(16), V.FechaAcredProp,120),'') as FechaAcredProp, ");
        StrSql.append(" coalesce(convert(varchar(16), V.FechaOficioLibera,120),'') as FechaOficioLibera, ");
        StrSql.append(" coalesce(V.DanoAjustaNU,0) as DanoAjustaNU, coalesce(V.DanoDictamenNU,0) as DanoDictamenNU, ");
        StrSql.append(" coalesce(convert(varchar(16), V.FechaLibera,120),'') as FechaLibera, ");
        StrSql.append(" coalesce(convert(varchar(16), V.FechaPresQuerella,120),'') as FechaPresQuerella, ");
        StrSql.append(" coalesce(V.DanoAjustaCP,0) as DanoAjustaCP, coalesce(V.DanoDictamenCP,0) as DanoDictamenCP, coalesce (V.MotivoNoLiberacion,'') as MotivoNoLiberacion ,");
        StrSql.append(" coalesce(V.Conductor,'') as Conductor, coalesce(EP.dsEstatusPersona,'') as dsEstatusConduc,  ");
        StrSql.append(" coalesce(convert(varchar(16), V.FechaDetConduc,120),'') as FechaDetConduc, ");
        StrSql.append(" V.clEstatusConduc, ");
        StrSql.append(" coalesce(convert(varchar(16), V.FechaLibConduc,120),'') as FechaLibConduc, ");
        StrSql.append(" coalesce(V.Colonia,'')Colonia, coalesce(V.CalleNum,'')CalleNum,");
        StrSql.append(" coalesce (cast(V.Referencias as varchar(8000)),'') Referencias, ");
        StrSql.append(" EFD.dsEntFed, DD.dsMunDel, V.CodMDDest, V.CodEntDest, coalesce(V.ColoniaDest,'')ColoniaDest, coalesce(V.CalleNumDest,'')CalleNumDest, ");
        StrSql.append(" coalesce (cast(V.ReferenciasDest as varchar(8000)),'') ReferenciasDest, ");
        StrSql.append(" coalesce(A.dsAseguradora,'') as dsAseguradora,  coalesce(V.NoSiniestro,'') as NoSiniestro, ");
        StrSql.append(" coalesce(V.NoPoliza,'') as NoPoliza,  ");
        StrSql.append(" EFD.CodEnt,  DD.CodMD");
        StrSql.append(" From VehiculoInvNU V ");
        StrSql.append(" left join cAseguradora A ON (A.clAseguradora = V.clAseguradora) ");
        StrSql.append(" left join cEstatusUnidad E ON (E.clEstatusUnidad = V.clEstatusUnidad) ");
        StrSql.append(" left join cEstatusPersona EP ON (EP.clEstatusPersona = V.clEstatusConduc) ");
        StrSql.append(" left join cMarcaAuto M ON (M.CodigoMarca = V.CodigoMarca) ");
        StrSql.append(" left join cTipoAuto T ON (T.CodigoMarca = V.CodigoMarca AND T.ClaveAMIS = V.ClaveAMIS) ");
        StrSql.append(" left join cTipoVehiculo TV ON (TV.clTipoVehiculo = V.clTipoVehiculo) ");
        StrSql.append(" LEFT JOIN cEntFed EFD ON(EFD.CodEnt = V.CodEntDest) ");
        StrSql.append(" LEFT JOIN cMunDel DD ON(EFD.CodEnt = DD.CodEnt and DD.CodMD=V.CodMDDest) ");
        StrSql.append(" Where V.clExpediente =").append(StrclExpediente);
    }
    else
    {
        
        rs2.close();
        rs4.close();
        rs5.close();
        rs3.close();
        rs2=null;
        rs4=null;
        rs5=null;
        rs3=null;
        StrclExpediente = null;
        StrclVehiculo = null;
        StrSql = null;
        StrclPaginaWeb=null;
        StrFecha = null;
        StrAseguradora=null;
        StrFechaDetencion=null;
        StrFechaDetConduc=null;
        StrclUsrApp=null;
        
        return;
    }
    
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
    
    %><script>fnOpenLinks()</script><%
    
    StrclPaginaWeb = "181";
    MyUtil.InicializaParametrosC(181,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
    
    session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
    
    %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","","fnGNPInfoObli();fnAntesGuardar();fndeshabilita();")%>
    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleInvVehNU.jsp?'>"%><%
           if (rs.next())
           {
        
        StrSql.append(" select EX.clCuenta, EX.NuestroUsuario From Expediente EX " );
        StrSql.append(" where EX.clExpediente =").append(StrclExpediente);
        ResultSet rs7 = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        
        if (rs7.next())
        {
            String StrclCuenta = rs7.getString("clCuenta");
            String StrNuestroUsuario = rs7.getString("NuestroUsuario"); 
           
           %><script>top.document.all.DatosExpediente.src='DatosExpediente.jsp';</script>
    <script>document.all.btnAlta.disabled=true;</script>
    <INPUT id='clVehiculo' name='clVehiculo' type='hidden' value='<%=rs.getString("clVehiculo")%>'>             
    <INPUT id='fechaEt' name='fechaEt' type='hidden' value='<%=StrFecha%>'>
    <INPUT id='clCuentaVTR' name='clCuentaVTR' type='hidden' value='<%=StrclCuenta%>'>
    <%=MyUtil.ObjComboC("Marca", "CodigoMarca", rs.getString("dsMarcaAuto"),true,true,30,80,"","Select CodigoMarca, dsMarcaAuto From cMarcaAuto Order by dsMarcaAuto","fnLlenaAMIS()","",60,true,true)%>                       
    <div style='position:absolute; z-index:25; left:185px; top:98px;' name='DAstMarca' id='DAstMarca'><img alt="Campo obligatorio para GNP" src="../../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
    <%=MyUtil.ObjComboC("Tipo de Auto", "ClaveAMIS",rs.getString("dsTipoAuto"),true,true,250,80,"","Select ClaveAMIS, dsTipoAuto From cTipoAuto Where CodigoMarca='" + rs.getString("CodigoMarca") + "' Order by dsTipoAuto","fnActualizaAMIS()","",100,true,true)%>
    <div style='position:absolute; z-index:25; left:580px; top:98px;' name='DAstTipoAuto' id='DAstTipoAuto'><img alt="Campo obligatorio para GNP" src="../../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
    <%=MyUtil.ObjInput("Clave AMIS","ClaveAMISVTR",rs.getString("ClaveAMIS"), false,false,30,120,"",false,false,15)%> 
    <%=MyUtil.ObjInput("Año","Modelo",rs.getString("Modelo"),true,true,140,120,"",false,false,4)%>
    <div style='position:absolute; z-index:25; left:180px; top:138px;' name='DAstModelo' id='DAstModelo'><img alt="Campo obligatorio para GNP" src="../../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
    <%=MyUtil.ObjInput("Placas","Placas",rs.getString("Placas"),true,true,250,120,"",false,false,8)%>
    <div style='position:absolute; z-index:25; left:310px; top:138px;' name='DAstPlacas' id='DAstPlacas'><img alt="Campo obligatorio para GNP" src="../../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
    <%=MyUtil.ObjInput("Color","Color",rs.getString("Color"),true,true,400,120,"",false,false,17)%>
    <div style='position:absolute; z-index:25; left:505px; top:138px;' name='DAstColor' id='DAstColor'><img alt="Campo obligatorio para GNP" src="../../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
    <%=MyUtil.ObjComboC("Tipo de Vehiculo","clTipoVehiculo",rs.getString("dsTipoVehiculo"),true,true,30,160,"","Select clTipoVehiculo, dsTipoVehiculo From cTipoVehiculo ","","",25,false,false)%>
    <%=MyUtil.ObjInput("Serie","Serie",rs.getString("Serie"),true,true,250,160,"",false,false,25)%>
    <%=MyUtil.ObjInput("No. Motor","NoMotor",rs.getString("NoMotor"),true,true,400,160,"",false,false,25)%>
    <%=MyUtil.ObjComboC("Estatus de la Unidad","clEstatusUnidad",rs.getString("dsEstatusUnidad"),true,true,30,210,"","Select clEstatusUnidad, dsEstatusUnidad From cEstatusUnidad","fnfechVal()","",60,true,true)%>
    <div style='position:absolute; z-index:25; left:185px; top:228px;' name='DAstEstatusUnidad' id='DAstEstatusUnidad'><img alt="Campo obligatorio para GNP" src="../../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div>     
    <%
    //Verificar Fecha de detencion, Si es nula permite llenarla de lo contrario solo se visualiza sin opcion a ser modificada.
    StrFechaDetencion =rs.getString("FechaDetencion");
    if (StrFechaDetencion==null)
    {
        StrFechaDetencion = "";
    }
    %><%=MyUtil.ObjInput("Fecha de Detención<br>(aaaa/mm/dd hh:mm)","FechaDetencion",StrFechaDetencion,true,true,250,200,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaDetencionMsk.value,this.name);fnVaciarFechaDeten()}")%>
    <%=MyUtil.ObjInput("Acreditación Propiedad<br>(aaaa/mm/dd hh:mm)","FechaAcredProp",rs.getString("FechaAcredProp"),true,true,440,200,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaDetencionMsk.value,this.name)}")%>
    <%=MyUtil.ObjInput("Oficio Liberación<br>(aaaa/mm/dd hh:mm)","FechaOficioLibera",rs.getString("FechaOficioLibera"),true,true,635,200,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaDetencionMsk.value,this.name)}")%>
    <%=MyUtil.ObjInput("Daños Según Ajustador NU","DanoAjustaNU",rs.getString("DanoAjustaNU"),true,true,30,250,"",false,false,25,"EsNumerico(document.all.DanoAjustaNU)")%>
    <%=MyUtil.ObjInput("Daño Según Dictamen NU","DanoDictamenNU",rs.getString("DanoDictamenNU"),true,true,250,250,"",false,false,25,"EsNumerico(document.all.DanoDictamenNU)")%>
    <%=MyUtil.ObjInput("Fecha de Liberación<br>(aaaa/mm/dd hh:mm)","FechaLibera",rs.getString("FechaLibera"),true,true,440,250,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaDetencionMsk.value,this.name)}")%>            
    <%=MyUtil.ObjInput("Presentación Querella<br>(aaaa/mm/dd hh:mm)","FechaPresQuerella",rs.getString("FechaPresQuerella"),true,true,635,250,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaDetencionMsk.value,this.name)}")%>            
    <%=MyUtil.ObjInput("Daños Según Ajustador CP","DanoAjustaCP",rs.getString("DanoAjustaCP"),true,true,30,300,"",false,false,25,"EsNumerico(document.all.DanoAjustaCP)")%>
    <%=MyUtil.ObjInput("Daño Según Dictamen CP","DanoDictamenCP",rs.getString("DanoDictamenCP"),true,true,250,300,"",false,false,25,"EsNumerico(document.all.DanoDictamenCP)")%>
    <%=MyUtil.ObjTextArea("Motivos de no Liberación","MotivoNoLiberacion",rs.getString("MotivoNoLiberacion"),"68","5",true,true,30,350,"",false,false)%>
    <%=MyUtil.DoBlock("Auto Involucrado de Nuestro Usuario",10,50)%>
    
    <%=MyUtil.ObjInput("Nombre del Conductor","Conductor",rs.getString("Conductor"),true,true,30,490,StrNuestroUsuario, true,true,55)%> 
    <div style='position:absolute; z-index:25; left:325px; top:508px;' name='DAstNombre' id='DAstNombre'><img alt="Campo obligatorio para GNP" src="../../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
    <%=MyUtil.ObjComboC("Estatus del Conductor ","clEstatusConduc",rs.getString("dsEstatusConduc"),true,true,450,490,"","Select clEstatusPersona, dsEstatusPersona From cEstatusPersona ","fnfechValPer()","",25,true,true)%>
    <div style='position:absolute; z-index:25; left:505px; top:508px;' name='DAstEstatusConductor' id='DAstEstatusConductor'><img alt="Campo obligatorio para GNP" src="../../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
    <%
    StrFechaDetConduc =rs.getString("FechaDetConduc");
    if (StrFechaDetConduc==null)
    {
        StrFechaDetConduc = "";
    } %>
    <%=MyUtil.ObjInput("Fecha de Detención<br>(aaaa/mm/dd hh:mm)","FechaDetConduc",StrFechaDetConduc,true,true,30,540,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaDetencionMsk.value,this.name)}")%>                     
    <%=MyUtil.ObjInput("Fecha de Liberación<br>(aaaa/mm/dd hh:mm)","FechaLibConduc",rs.getString("FechaLibConduc"),true,true,180,540,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaLiberaMsk.value,this.name)}")%>                                 
    <%=MyUtil.DoBlock("Datos del Conductor",0,0)%>
    
    <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEntEX",rs3.getString("dsEntFed"),true,true,30,630,rs3.getString("dsEntFed"),"Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","fnLlenaMunicipiosKM()","",40,false,false)%>
    <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMDEX",rs3.getString("dsMunDel"),true,true,320,630,rs3.getString("dsMunDel"),"Select CodMD, dsMunDel from cMunDel where CodMD='" + rs3.getString("CodMD") + "' and CodEnt='"+ rs3.getString("CodEnt") +"' order by dsMunDel ","","",40,false,false)%>
    <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia",rs.getString("Colonia"),true,true,30,680,"",false,false,50)%>             
    <%=MyUtil.ObjInput("Calle y Número","CalleNum",rs.getString("CalleNum"),true,true,320,680,"",false,false,50)%>
    <%=MyUtil.ObjTextArea("Referencias Visuales","Referencias",rs.getString("Referencias"),"105","5",true,true,30,720,"",false,false)%>
    <%=MyUtil.DoBlock("Ubicación del Evento",90,50)%>
    
    <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEntDest",rs.getString("dsEntFed"),true,true,30,860,"","Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","fnLlenaMunicipiosKMDest()","",40,false,false)%>
    <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMDDest",rs.getString("dsMunDel"),true,true,320,860,"","Select CodMD, dsMunDel from cMunDel where CodMD='" + rs.getString("CodMDDest") + "' and CodEnt='"+ rs.getString("CodEntDest") +"' order by dsMunDel ","","",40,false,false)%>
    <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"ColoniaDest",rs.getString("ColoniaDest"),true,true,30,900,"",false,false,50)%>                
    <%=MyUtil.ObjInput("Calle y Número","CalleNumDest",rs.getString("CalleNumDest"),true,true,320,900,"",false,false,50)%>
    <%=MyUtil.ObjTextArea("Referencias Visuales","ReferenciasDest",rs.getString("ReferenciasDest"),"105","5",true,true,30,940,"",false,false)%>
    <%=MyUtil.DoBlock("Lugar de Contacto",90,50)%>
    
    <%=MyUtil.ObjComboC("Aseguradora","clAseguradora",rs.getString("dsAseguradora"),true,true,30,1080,"","Select clAseguradora, dsAseguradora From cAseguradora ","","",50,true,true)%>
    <%=MyUtil.ObjInput("Número de Siniestro","NoSiniestro",rs.getString("NoSiniestro"),true,true,400,1080,"", false,false,25)%>
    <%=MyUtil.ObjInput("Número de Póliza","NoPoliza",rs.getString("NoPoliza"),true,true,550,1080,"",false,false,25)%>
    <%=MyUtil.DoBlock("Datos del Seguro",10,0)%><%
        }
        rs7.close();
        rs7 = null;
           }
           else
           {
        
        StrSql.append(" select EX.clCuenta, EX.NuestroUsuario From Expediente EX " );
        StrSql.append(" where EX.clExpediente =").append(StrclExpediente);
        ResultSet rs7 = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        
        if (rs7.next())
        {
            String StrclCuenta = rs7.getString("clCuenta");
            String StrNuestroUsuario= rs7.getString("NuestroUsuario");
    %><script>document.all.btnCambio.disabled=true;</script>
    <INPUT id='clVehiculo' name='clVehiculo' type='hidden' value='0'>
    <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>                
    <INPUT id='fechaEt' name='fechaEt' type='hidden' value='<%=StrFecha%>'>
    <INPUT id='clCuentaVTR' name='clCuentaVTR' type='hidden' value='<%=StrclCuenta%>'>
    <%=MyUtil.ObjComboC("Marca", "CodigoMarca", "",true,true,30,80,"","Select CodigoMarca, dsMarcaAuto From cMarcaAuto Order by dsMarcaAuto","fnLlenaAMIS();fnGNPInfo()","",60,true,true)%>                        
    <div style='position:absolute; z-index:25; left:185px; top:98px;' name='DAstMarca' id='DAstMarca'><img alt="Campo obligatorio para GNP" src="../../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
    <%=MyUtil.ObjComboC("Tipo de Auto", "ClaveAMIS","",true,true,250,80,"","Select ClaveAMIS, dsTipoAuto From cTipoAuto Where CodigoMarca='0' Order by dsTipoAuto","fnActualizaAMIS()","",100,true,true)%>
    <div style='position:absolute; z-index:25; left:580px; top:98px;' name='DAstTipoAuto' id='DAstTipoAuto'><img alt="Campo obligatorio para GNP" src="../../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
    <%=MyUtil.ObjInput("Clave AMIS","ClaveAMISVTR","", false,false,30,120,"",false,false,15)%>
    <%=MyUtil.ObjInput("Año","Modelo","",true,true,140,120,"",false,false,4)%>
    <div style='position:absolute; z-index:25; left:180px; top:138px;' name='DAstModelo' id='DAstModelo'><img alt="Campo obligatorio para GNP" src="../../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
    <%=MyUtil.ObjInput("Placas","Placas","",true,true,250,120,"",false,false,8)%>
    <div style='position:absolute; z-index:25; left:310px; top:138px;' name='DAstPlacas' id='DAstPlacas'><img alt="Campo obligatorio para GNP" src="../../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
    <%=MyUtil.ObjInput("Color","Color","",true,true,400,120,"",false,false,17)%>
    <div style='position:absolute; z-index:25; left:505px; top:138px;' name='DAstColor' id='DAstColor'><img alt="Campo obligatorio para GNP" src="../../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
    <%=MyUtil.ObjComboC("Tipo de Vehiculo","clTipoVehiculo","",true,true,30,160,"","Select clTipoVehiculo, dsTipoVehiculo From cTipoVehiculo ","","",25,false,false)%>
    <%=MyUtil.ObjInput("Serie","Serie","",true,true,250,160,"",false,false,25)%> 
    <%=MyUtil.ObjInput("No. Motor","NoMotor","",true,true,400,160,"",false,false,25)%>                       
    <%=MyUtil.ObjComboC("Estatus de la Unidad","clEstatusUnidad","",true,true,30,210,"","Select clEstatusUnidad, dsEstatusUnidad From cEstatusUnidad","fnEstatus()","",60,true,true)%>
    <div style='position:absolute; z-index:25; left:185px; top:228px;' name='DAstEstatusUnidad' id='DAstEstatusUnidad'><img alt="Campo obligatorio para GNP" src="../../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
    <%=MyUtil.ObjInput("Fecha de Detención<br>(aaaa/mm/dd hh:mm)","FechaDetencion","",true,true,250,200,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaDetencionMsk.value,this.name);fnVaciarFechaDeten()}")%>
    <%=MyUtil.ObjInput("Acreditación Propiedad<br>(aaaa/mm/dd hh:mm)","FechaAcredProp","",true,true,440,200,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaDetencionMsk.value,this.name);}")%>
    <%=MyUtil.ObjInput("Oficio Liberación<br>(aaaa/mm/dd hh:mm)","FechaOficioLibera","",true,true,635,200,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaDetencionMsk.value,this.name);}")%>
    <%=MyUtil.ObjInput("Daños Según Ajustador NU","DanoAjustaNU","",true,true,30,250,"",false,false,25,"EsNumerico(document.all.DanoAjustaNU)")%>
    <%=MyUtil.ObjInput("Daño Según Dictamen NU","DanoDictamenNU","",true,true,250,250,"",false,false,25,"EsNumerico(document.all.DanoDictamenNU)")%>
    <%=MyUtil.ObjInput("Fecha de Liberación<br>(aaaa/mm/dd hh:mm)","FechaLibera","",true,true,440,250,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaDetencionMsk.value,this.name);}")%>            
    <%=MyUtil.ObjInput("Presentación Querella<br>(aaaa/mm/dd hh:mm)","FechaPresQuerella","",true,true,635,250,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaDetencionMsk.value,this.name)}")%>     
    <%=MyUtil.ObjInput("Daños Según Ajustador CP","DanoAjustaCP","",true,true,30,300,"",false,false,25,"EsNumerico(document.all.DanoAjustaCP)")%>
    <%=MyUtil.ObjInput("Daño Según Dictamen CP","DanoDictamenCP","",true,true,250,300,"",false,false,25,"EsNumerico(document.all.DanoDictamenCP)")%>
    <%=MyUtil.ObjTextArea("Motivos de no Liberación","MotivoNoLiberacion","","68","5",true,true,30,350,"",false,false)%>
    <%=MyUtil.DoBlock("Auto Involucrado de Nuestro Usuario",10,50)%>
    
    <%=MyUtil.ObjInput("Nombre del Conductor","Conductor",StrNuestroUsuario,true,true,30,490,StrNuestroUsuario, true,true,55)%>
    <div style='position:absolute; z-index:25; left:325px; top:508px;' name='DAstNombre' id='DAstNombre'><img alt="Campo obligatorio para GNP" src="../../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
    <%=MyUtil.ObjComboC("Estatus del Conductor ","clEstatusConduc","",true,true,350,490,"","Select clEstatusPersona, dsEstatusPersona From cEstatusPersona ","fnEstatusCond()","",25,true,true)%>                      <%=MyUtil.ObjInput("Fecha de Detención<br>(aaaa/mm/dd hh:mm)","FechaDetConduc","",true,true,30,540,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaDetencionMsk.value,this.name)}")%>
    <div style='position:absolute; z-index:25; left:505px; top:508px;' name='DAstEstatusConductor' id='DAstEstatusConductor'><img alt="Campo obligatorio para GNP" src="../../Imagenes/AsteriscoGNP.gif" width="10" height="10" ></div> 
    <%=MyUtil.ObjInput("Fecha de Liberación<br>(aaaa/mm/dd hh:mm)","FechaLibConduc","",true,true,180,540,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaLiberaMsk.value,this.name)}")%>                                
    <%=MyUtil.DoBlock("Datos del Conductor",60,0)%>
    
    <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEntEX",rs3.getString("dsEntFed"),false,false,30,630,"","Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","","",40,false,false)%>
    <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMDEX",rs3.getString("dsMunDel"),false,false,320,630,"","Select CodMD, dsMunDel from cMunDel where CodMD='" + rs3.getString("CodMD") + "' and CodEnt='" + rs3.getString("CodEnt") + "' order by dsMunDel ","","",40,false,false)%>
    <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia","",true,true,30,680,"",false,false,50)%>                
    <%=MyUtil.ObjInput("Calle y Número","CalleNum","",true,true,320,680,"",false,false,50)%>                
    <%=MyUtil.ObjTextArea("Referencias Visuales","Referencias","","105","5",true,true,30,720,"",false,false)%>                
    <%=MyUtil.DoBlock("Ubicación del Evento",90,50)%>
    
    <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEntDest","",true,true,30,860,"","Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","fnLlenaMunicipiosKMDest()","",40,false,false)%>
    <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMDDest","",true,true,320,860,"","Select CodMD, dsMunDel from cMunDel where CodMD='' and CodEnt='' order by dsMunDel ","","",40,false,false)%>
    <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"ColoniaDest","",true,true,30,900,"",false,false,50)%>               
    <%=MyUtil.ObjInput("Calle y Número","CalleNumDest","",true,true,320,900,"",false,false,50)%>                
    <%=MyUtil.ObjTextArea("Referencias Visuales","ReferenciasDest","","105","5",true,true,30,940,"",false,false)%>                
    <%=MyUtil.DoBlock("Lugar de Contacto",90,50)%>
    
    <%=MyUtil.ObjComboC("Aseguradora","clAseguradora",rs5.getString("dsAseguradora"),true,true,30,1080,rs5.getString("clAseguradora"),"Select clAseguradora, dsAseguradora From cAseguradora ","","",50,true,true)%>
    <%=MyUtil.ObjInput("Número de Siniestro","NoSiniestro","",true,true,400,1080,"", false,false,25)%>
    <%=MyUtil.ObjInput("Número de Póliza","NoPoliza","",true,true,550,1080,"",false,false,25)%>
    
    <%=MyUtil.DoBlock("Datos del Seguro",10,0)%>  
    <script>document.all.clAseguradora.value=<%=rs5.getString("clAseguradora")%>;</script><% 
        }
        rs7.close();
        rs7 = null;
           } %>    
    <%=MyUtil.GeneraScripts()%><%  
    rs.close();
    rs2.close();
    
    rs5.close();
    rs3.close();
    rs=null;
    rs2=null;
    
    rs5=null;
    rs3=null;
    StrclExpediente = null;
    StrclVehiculo = null;
    StrSql = null;
    StrclPaginaWeb=null;
    StrFecha = null;
    StrAseguradora=null;
    StrFechaDetencion=null;
    StrFechaDetConduc=null;
    StrclUsrApp=null;   
    
    %>
    <input name='FechaDetencionMsk' id='FechaDetencionMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
    <input name='FechaLiberaMsk' id='FechaLiberaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
    
    <script>
     document.all.Conductor.maxLength=100; 
     document.all.NoSiniestro.maxLength=30;   
     document.all.NoPoliza.maxLength=15;   
     document.all.Modelo.maxLength=4;   
     document.all.Placas.maxLength=8;   
     document.all.Color.maxLength=20;  
     document.all.Serie.maxLength=20;   
     document.all.NoMotor.maxLength=20;   

     var vars; 
     vars= document.all.clEstatusUnidadC.value; 

    
     function fndeshabilita(){
     document.all.btnGuarda.disabled=true;   
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
     
     
     function fnEstatusCond()
     { 
       // Estatus de la Unidad Detenido
       if (document.all.clEstatusConduc.value == 2)  
       {
            document.all.FechaDetConduc.value = document.all.fechaEt.value;  // Fecha de sql 
            document.all.FechaLibConduc.value ="";
            document.all.FechaDetConduc.readOnly = false;
       }  
       else
       {
         if (document.all.clEstatusConduc.value == 7)
            {
                if  (document.all.FechaDetConduc.value == "")
                  {
                    //document.all.clEstatusConduc.value = "2";
                    document.all.clEstatusConducC.value = 2;
                    document.all.FechaDetConduc.value = document.all.fechaEt.value;
                    alert ("Primero Necesita Ingresar Fecha de Detencion del Conductor");
                    return;
                  }
                else
                  {
                    document.all.FechaLibConduc.value =document.all.fechaEt.value;
                    
                    document.all.FechaDetConduc.readOnly = true;
                  }
            }
          else
              {
                if (document.all.clEstatusConduc.value == 5)
                  {
                  document.all.FechaDetConduc.value = "";
                  document.all.FechaLibConduc.value = "";
                  document.all.FechaDetConduc.readOnly = true;
                  document.all.FechaLibConduc.readOnly = true;
                  }
              }
          //document.all.FechaDetencion.value = "";  // se habilita Combo Zona
       }  
     } 
     
   function fnAntesGuardar()
     {
      
       
        if (document.all.clEstatusConduc.value == 2){
            document.all.FechaLibConduc.value="";
        }

        if (document.all.clEstatusUnidad.value == 2){
            document.all.FechaOficioLibera.value="";
            document.all.FechaLibera.value="";
        }
        
    
      if (document.all.clEstatusConduc.value == 2)  
       {
            if(document.all.FechaDetConduc.value==""){
            msgVal=msgVal + " Fecha de Detención del Conductor ";
            }
       }else{
            if(document.all.clEstatusConduc.value == 7 &&  document.all.FechaDetConduc.value!="" && document.all.FechaLibConduc.value==""){
                    msgVal=msgVal + " Fecha de Liberacion del Conductor ";
           /*     if(document.all.FechaLibConduc.value==""){
                msgVal=msgVal + " Fecha de Liberacion del Conductor ";
                }
                if(document.all.FechaDetConduc.value==""){
                    msgVal=msgVal + " Fecha de Detención del Conductor ";
                }*/
            }
        
        }
       
        //Verifica que traigan datos los campos ----------------------------------------------------------                
                        
        if (document.all.clEstatusUnidad.value == 2)  
        {
            if(document.all.FechaDetencion.value==""){ msgVal=msgVal + " Fecha de Detención del Vehículo "; }  
        }

        if (document.all.clEstatusUnidad.value == 1)  
        {
        
            if(document.all.FechaDetencion.value==""){ msgVal=msgVal + " Fecha de Detención del Vehículo "} 
        
            if(document.all.FechaAcredProp.value==""){ msgVal=msgVal + " Fecha Acreditación del Vehículo "}
        
            if(document.all.FechaOficioLibera.value==""){ msgVal=msgVal + " Fecha de Oficio de Liberación del Vehículo "}

            if(document.all.FechaLibera.value==""){ msgVal=msgVal + " Fecha de Liberación del Vehículo "}
 
        }            
                
         
        //Verifica Orden Cronológico------------------------------------------------------------------------------
        if (document.all.FechaDetencion.value!="" && document.all.FechaAcredProp.value!=""){
            //alert(document.all.FechaDetencion.value +'-'+document.all.FechaAcredProp.value);
            if(document.all.FechaDetencion.value >= document.all.FechaAcredProp.value){
            msgVal=msgVal + " La Fecha de Acreditación de Propiedad del Vehículo debe ser mayor a la de Detencion !!!!!";            
            } 
        }        

        if (document.all.FechaAcredProp.value!="" && document.all.FechaOficioLibera.value!=""){
            if(document.all.FechaAcredProp.value >= document.all.FechaOficioLibera.value){
            msgVal=msgVal + " La Fecha de Oficio de Liberación del Vehículo debe ser mayor a la de Acreditación !!!!!";
            }
        }              

        if (document.all.FechaOficioLibera.value!="" && document.all.FechaLibera.value!=""){
            if(document.all.FechaOficioLibera.value > document.all.FechaLibera.value){
            msgVal=msgVal + " La Fecha de Liberación del Vehículo debe ser mayor o igual a la de Oficio de Liberación !!!!!";
            }
        }      
                  
      
      ///  Datos Conductor ------                
                               
      if (document.all.FechaDetConduc.value!="" && document.all.FechaLibConduc.value!=""){
            if(document.all.FechaLibConduc.value <= document.all.FechaDetConduc.value){
            msgVal=msgVal + " La Fecha de Liberacion del Conductor debe ser mayor a la de Detencion ";
            }
      }           
      
      if (document.all.FechaDetConduc.value=="" && document.all.FechaLibConduc.value!="" && document.all.clEstatusConduc.value == 5){
            msgVal=msgVal + " Fecha de Detencion del Conductor ";
      }
            
     fnHabilitaBtn();    
    }     
    
    
    function fnHabilitaBtn()
    {
       document.all.btnGuarda.disabled= false;
       document.all.btnCancela.disabled= false;
    }
           
    
    
    
    function fnfechVal()
      {
        if (document.all.clEstatusUnidad.value == 3) //Libre
        {
            if(confirm("¿Seguro que Desea cambiar a Estatus Libre? Debido a que se Eliminaran las Fechas Capturadas ")==true )
            {                                                           
            document.all.FechaDetencion.value = "";
            document.all.FechaAcredProp.value = "";
            document.all.FechaOficioLibera.value = "";
            document.all.FechaLibera.value = "";              
            document.all.FechaDetencion.readOnly = true;
            document.all.FechaAcredProp.readOnly = true;
            document.all.FechaOficioLibera.readOnly = true; 
            document.all.FechaLibera.readOnly = true;     
            vars= document.all.clEstatusUnidadC.value;
            }
            else{
                document.all.clEstatusUnidadC.value = vars;
                document.all.clEstatusUnidad.value = vars;///
                return;
                }                        
        }     
 
        if (document.all.clEstatusUnidad.value == 2) //Detenido
        {        
            if (document.all.FechaDetencion.value =="")
            {document.all.FechaDetencion.value = document.all.fechaEt.value; }

            else {if (confirm("¿Seguro que Desea cambiar a Estatus Detenido? Debido a que se Eliminaran las Fechas Capturadas ")==true){vars= document.all.clEstatusUnidadC.value;}
                    else {
                        document.all.clEstatusUnidadC.value = vars;
                        document.all.clEstatusUnidad.value = vars;///
                        return;
                         }
                 }

            document.all.FechaOficioLibera.value = "";
            document.all.FechaLibera.value = "";              
            document.all.FechaDetencion.readOnly = false;
            document.all.FechaAcredProp.readOnly = false;
            document.all.FechaOficioLibera.readOnly = true; 
            document.all.FechaLibera.readOnly = true;    
            vars= document.all.clEstatusUnidadC.value;
        }  
        

        if (document.all.clEstatusUnidad.value == 1) //Liberada
        {   
        
            if (document.all.FechaDetencion.value =="")
                {alert("Debe Ingresar Fecha de Detencion");
                document.all.FechaDetencion.value = document.all.fechaEt.value;
                document.all.clEstatusUnidadC.value=2; document.all.clEstatusUnidad.value = 2;///          
                document.all.FechaOficioLibera.value = ""; 
                document.all.FechaLibera.value = ""; 
                document.all.FechaDetencion.readOnly = false;
                document.all.FechaAcredProp.readOnly = false;            
                document.all.FechaOficioLibera.readOnly = true; 
                document.all.FechaLibera.readOnly = true; 
                vars= document.all.clEstatusUnidadC.value;
                return;
                }

            if (document.all.FechaDetencion.value !="" && document.all.FechaAcredProp.value =="")
                {alert("Debe Ingresar Fecha de Acreditación");
                //document.all.FechaAcredProp.value = document.all.fechaEt.value;
                document.all.clEstatusUnidadC.value=2; document.all.clEstatusUnidad.value = 2; ///                 
                document.all.FechaOficioLibera.value = ""; 
                document.all.FechaLibera.value = "";
                document.all.FechaOficioLibera.readOnly = true; 
                document.all.FechaLibera.readOnly = true;  
                vars= document.all.clEstatusUnidadC.value;
                return;
                }    

            document.all.FechaOficioLibera.value = document.all.fechaEt.value; 
            document.all.FechaLibera.value = document.all.fechaEt.value;              
            document.all.FechaDetencion.readOnly = true;
            document.all.FechaAcredProp.readOnly = true;
            document.all.FechaOficioLibera.readOnly = false; 
            document.all.FechaLibera.readOnly = false;   
            vars= document.all.clEstatusUnidadC.value;
        }  
      }
      
      
    function fnfechValPer()
      {
        if (document.all.clEstatusConduc.value == 7)
          {
              if (document.all.FechaDetConduc.value=="")
                {
                  alert ("Primero Necesita Ingresar Fecha de Detencion del Conductor");
                  return;
                }
              else
              {
                document.all.FechaLibConduc.value =document.all.fechaEt.value;
                document.all.FechaDetConduc.readOnly = true;
              }
          }
        else
          {
            if  (document.all.clEstatusConduc.value == 2)
              {
                if(document.all.FechaDetConduc.value == "")
                {
                  document.all.FechaDetConduc.value =document.all.fechaEt.value;
                  document.all.FechaDetConduc.readOnly = false;
                }
                else
                  {
                    if (confirm("¿Seguro que Desea cambiar a Estatus Detenido?")==true )
                      {
                        document.all.FechaDetConduc.readOnly = false;
                        document.all.FechaLibConduc.value ="";
                      }
                  }              
              }
            else
              {
                if (document.all.clEstatusConduc.value == 5)
                  {
                    if(document.all.FechaDetConduc.value == "" && document.all.FechaLibConduc.value == "")
                      {
                       
                          document.all.FechaDetConduc.value = "";
                          document.all.FechaLibConduc.value = "";
                          document.all.FechaDetConduc.readOnly = true;
                          document.all.FechaLibConduc.readOnly = true;
                        
                      }
                    else
                      {
                         if (confirm("¿Seguro que Desea Cambiar a Estatus Libre?")==true )
                          {
                            document.all.FechaDetConduc.value = "";
                            document.all.FechaLibConduc.value = "";
                            document.all.FechaDetConduc.readOnly = true;
                            document.all.FechaLibConduc.readOnly = true;
                          }
                      }
                  }
              }
          }
      }
      
    function fnGNPInfo(){
        if  (document.all.clCuentaVTR.value=="113") {
            fnDivshow("DAstMarca");
            fnDivshow("DAstTipoAuto");
            fnDivshow("DAstModelo");
            fnDivshow("DAstPlacas");
            fnDivshow("DAstColor"); 
            fnDivshow("DAstEstatusUnidad");
            fnDivshow("DAstNombre");
            fnDivshow("DAstEstatusConductor");
            if (document.all.NoMotor.value=="") { document.all.NoMotor.value="SD";}
            if (document.all.Serie.value=="") { document.all.Serie.value="SD"; }
            if ((document.all.Action.value=="1")||(document.all.Action.value=="2")){
            document.all.Placas.className='FReq';
            document.all.Color.className='FReq';
            }            
            }    
          else {
            fnDivhide("DAstMarca");
            fnDivhide("DAstTipoAuto");
            fnDivhide("DAstModelo");
            fnDivhide("DAstPlacas");
            fnDivhide("DAstColor");
            fnDivhide("DAstEstatusUnidad");
            fnDivhide("DAstNombre");
            fnDivhide("DAstEstatusConductor");
            if ((document.all.Action.value=="1")||(document.all.Action.value=="2")){
            document.all.MotivoNoLiberacion.className='FReq'
            }
                }
    }
    
    function fnGNPInfoObli(){
    if  (document.all.clCuentaVTR.value=="113"){
        if (document.all.Placas.value=="") msgVal=msgVal + " Placas. "
        if (document.all.Color.value=="") msgVal=msgVal + " Color. "
        if (document.all.Modelo.value=="") msgVal=msgVal + " Año. "
        document.all.btnGuarda.disabled=false;
        document.all.btnCancela.disabled=false;
        }   
     else{
        if (document.all.MotivoNoLiberacion.value=="") msgVal=msgVal + " Motivo de no Liberación. "
        if (document.all.clTipoVehiculo.value=="") msgVal=msgVal + " Tipo de Vehículo. "
        if (document.all.CodEntDest.value=="") msgVal=msgVal + " <%=i18n.getMessage("message.title.entidad")%> (Lugar de Contacto). "
        if (document.all.CodMDDest.value=="") msgVal=msgVal + " <%=i18n.getMessage("message.title.municipio")%> (Lugar de Contacto). "
        }
    }
    
    function fnDivhide(i) {
        if (document.all) {
        var ourhelp = eval ("document.all."+ i)
        ourhelp.style.visibility="hidden";
        }
    }

    function fnDivshow(i) {
        if (document.all) {
        var ourhelp = eval ("document.all."+ i)
        ourhelp.style.visibility="visible";
        }
    }
    
   function fnVaciarFechas() {
        if (document.all.FechaDetencion.value=="1900-01-01 00:00") {document.all.FechaDetencion.value=""}
        if (document.all.FechaAcredProp.value=="1900-01-01 00:00") {document.all.FechaAcredProp.value=""}
        if (document.all.FechaOficioLibera.value=="1900-01-01 00:00") {document.all.FechaOficioLibera.value=""}
        if (document.all.FechaLibera.value=="1900-01-01 00:00") {document.all.FechaLibera.value=""}
        if (document.all.FechaPresQuerella.value=="1900-01-01 00:00") {document.all.FechaPresQuerella.value=""}
    }
    
   function fnVaciarFechaDeten() {
        if (document.all.FechaDetencion.value=="1900-01-01 00:00") {document.all.FechaDetencion.value=""}
    }
    
    
    </script>
    <%
    rs4.close();
    rs4=null;
    %>
    
</body>
</html>


