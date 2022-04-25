<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Datos de Vehiculo Involucrado</title>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">

<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackagAL.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>

<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 


<script src='../../Utilerias/Util.js' ></script>
<script src='../../Utilerias/UtilAuto.js' ></script>
<script src='../../Utilerias/UtilMask.js'></script>
<script src='../../Utilerias/UtilDireccion.js' ></script>

<%  
    String StrclUsrApp="0";
    
    

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

    ResultSet rs4 = UtileriasBDF.rsSQLNP( "Select convert(varchar(16),getdate(),120) fechaEt ");  
    if (rs4.next()){
       StrFecha = rs4.getString("fechaEt");
    }    
    
    StringBuffer StrSql = new StringBuffer();
    StrSql.append("Select C.clAseguradora, A.dsAseguradora from Expediente E");
             StrSql.append(" Left join cCuenta C ON (C.clCuenta=E.clCuenta)");
             StrSql.append(" Left join cAseguradora A ON (A.clAseguradora=C.clAseguradora)");
             StrSql.append(" Where clExpediente =").append(StrclExpediente);
    ResultSet rs5 = UtileriasBDF.rsSQLNP( StrSql.toString());  
    StrSql.delete(0,StrSql.length());
    
    if (rs5.next()){
      StrAseguradora = rs5.getString("clAseguradora");
    }
    
    StrSql.append(" Select  EXPED.CodEnt, E.dsEntFed, EXPED.CodMD, D.dsMunDel ");
             StrSql.append(" From Expediente EXPED");
             StrSql.append(" LEFT JOIN cEntFed E ON(E.CodEnt = EXPED.CodEnt) ");
             StrSql.append(" LEFT JOIN cMunDel D ON(E.CodEnt = D.CodEnt and D.CodMD=EXPED.CodMD) ");
             StrSql.append(" Where clExpediente=").append(StrclExpediente);
 
    ResultSet rs3 = UtileriasBDF.rsSQLNP( StrSql.toString());     
    StrSql.delete(0,StrSql.length());
    if (rs3.next()){ 
    
    StrSql.append("Select V.clVehiculo, coalesce(M.dsMarcaAuto,'') as dsMarcaAuto, coalesce(T.dsTipoAuto,'') as dsTipoAuto,  ");
             StrSql.append(" coalesce(V.CodigoMarca,'') as CodigoMarca, coalesce(V.ClaveAMIS,'') as ClaveAMIS,  coalesce(V.Modelo,'') as Modelo,  ");
             StrSql.append(" coalesce(V.Placas,'') as Placas, coalesce(V.Color,'') as Color, coalesce(TV.dsTipoVehiculo,'') as dsTipoVehiculo,  ");
             StrSql.append(" coalesce(V.Serie,'') as Serie, coalesce(V.NoMotor,'') as NoMotor, coalesce(E.dsEstatusUnidad,'') as dsEstatusUnidad, ");
             StrSql.append(" coalesce(convert(varchar(16), V.FechaDetencion,120),'') as FechaDetencion, ");
             StrSql.append(" V.clEstatusUnidad, ");
             StrSql.append(" coalesce(convert(varchar(16), V.FechaLibera,120),'') as FechaLibera, ");
             StrSql.append(" coalesce(V.DanoAjustaNU,0) as DanoAjustaNU, coalesce(V.DanoDictamenNU,0) as DanoDictamenNU, ");
             StrSql.append(" coalesce(V.DanoAjustaCP,0) as DanoAjustaCP, coalesce(V.DanoDictamenCP,0) as DanoDictamenCP, ");
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
    }else{
               rs4.close();
               rs5.close();
               rs3.close();
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
       
       StrclPaginaWeb = "376";       
       MyUtil.InicializaParametrosC(376,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
 
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);  

       %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","","fnAntesGuardar();")%>        
       <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + + 1)%><%="DetalleInvVehNULeg.jsp?'>"%><%
       if (rs.next()) {                          
          
            %><script>top.document.all.DatosExpediente.src='DatosExpediente.jsp';</script> 
            <script>document.all.btnAlta.disabled=true;</script>
            <INPUT id='clVehiculo' name='clVehiculo' type='hidden' value='<%=rs.getString("clVehiculo")%>'>             
            <INPUT id='fechaEt' name='fechaEt' type='hidden' value='"+ rs4.getString("fechaEt") +"'>
            <%=MyUtil.ObjComboC("Marca", "CodigoMarca", rs.getString("dsMarcaAuto"),true,true,30,80,"","Select CodigoMarca, dsMarcaAuto From cMarcaAuto Order by dsMarcaAuto","fnLlenaAMIS()","",60,true,true)%>                        
            <%=MyUtil.ObjComboC("Tipo de Auto", "ClaveAMIS",rs.getString("dsTipoAuto"),true,true,250,80,"","Select ClaveAMIS, dsTipoAuto From cTipoAuto Where CodigoMarca='" + rs.getString("CodigoMarca") + "' Order by dsTipoAuto","fnActualizaAMIS()","",100,true,true)%>
            <%=MyUtil.ObjInput("Clave AMIS","ClaveAMISVTR",rs.getString("ClaveAMIS"), false,false,30,120,"",false,false,15)%>
            <%=MyUtil.ObjInput("Año","Modelo",rs.getString("Modelo"),true,true,140,120,"",false,false,4)%>
            <%=MyUtil.ObjInput("Placas","Placas",rs.getString("Placas"),true,true,250,120,"",false,false,8)%>
            <%=MyUtil.ObjInput("Color","Color",rs.getString("Color"),true,true,400,120,"",false,false,17)%>
            <%=MyUtil.ObjComboC("Tipo de Vehiculo","clTipoVehiculo",rs.getString("dsTipoVehiculo"),true,true,30,160,"","Select clTipoVehiculo, dsTipoVehiculo From cTipoVehiculo ","","",25,true,true)%>
            <%=MyUtil.ObjInput("Serie","Serie",rs.getString("Serie"),true,true,250,160,"",false,false,25)%>
            <%=MyUtil.ObjInput("No. Motor","NoMotor",rs.getString("NoMotor"),true,true,400,160,"",false,false,25)%>
            <%=MyUtil.ObjComboC("Estatus de la Unidad","clEstatusUnidad",rs.getString("dsEstatusUnidad"),true,true,30,210,"","Select clEstatusUnidad, dsEstatusUnidad From cEstatusUnidad","","",60,true,true)%><%
//Verificar Fecha de detencion, Si es nula permite llenarla de lo contrario solo se visualiza sin opcion a ser modificada.
            StrFechaDetencion =rs.getString("FechaDetencion");
                    if (StrFechaDetencion==null){
                         StrFechaDetencion = "";
                        } %>
            <%=MyUtil.ObjInput("Fecha de Detención<br>(aaaa/mm/dd hh:mm)","FechaDetencion",StrFechaDetencion,true,true,250,200,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaDetencionMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Fecha de Liberación<br>(aaaa/mm/dd hh:mm)","FechaLibera",rs.getString("FechaLibera"),true,true,400,200,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaLiberaMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Daños Según Ajustador NU","DanoAjustaNU",rs.getString("DanoAjustaNU"),true,true,30,250,"",false,false,25,"EsNumerico(document.all.DanoAjustaNU)")%>
            <%=MyUtil.ObjInput("Daño Según Dictamen NU","DanoDictamenNU",rs.getString("DanoDictamenNU"),true,true,250,250,"",false,false,25,"EsNumerico(document.all.DanoDictamenNU)")%>
            <%=MyUtil.ObjInput("Daños Según Ajustador CP","DanoAjustaCP",rs.getString("DanoAjustaCP"),true,true,30,300,"",false,false,25,"EsNumerico(document.all.DanoAjustaCP)")%>
            <%=MyUtil.ObjInput("Daño Según Dictamen CP","DanoDictamenCP",rs.getString("DanoDictamenCP"),true,true,250,300,"",false,false,25,"EsNumerico(document.all.DanoDictamenCP)")%>
            <%=MyUtil.DoBlock("Auto Involucrado de Nuestro Usuario",10,0)%>
            <%=MyUtil.ObjComboC("Aseguradora","clAseguradora",rs.getString("dsAseguradora"),true,true,30,390,"","Select clAseguradora, dsAseguradora From cAseguradora ","","",50,true,true)%>
            <%=MyUtil.ObjInput("Número de Siniestro","NoSiniestro",rs.getString("NoSiniestro"),true,true,400,390,"", false,false,25)%>
            <%=MyUtil.ObjInput("Número de Póliza","NoPoliza",rs.getString("NoPoliza"),true,true,550,390,"",false,false,25)%>
            <%=MyUtil.DoBlock("Datos del Seguro",10,0)%><%
       } 
       else { 
         
            %><script>document.all.btnCambio.disabled=true;</script>   
            <INPUT id='clVehiculo' name='clVehiculo' type='hidden' value='0'>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <INPUT id='fechaEt' name='fechaEt' type='hidden' value='<%=rs4.getString("fechaEt")%>'>
            <%=MyUtil.ObjComboC("Marca", "CodigoMarca", "",true,true,30,80,"","Select CodigoMarca, dsMarcaAuto From cMarcaAuto Order by dsMarcaAuto","fnLlenaAMIS()","",60,true,true)%>
            <%=MyUtil.ObjComboC("Tipo de Auto", "ClaveAMIS","",true,true,250,80,"","Select ClaveAMIS, dsTipoAuto From cTipoAuto Where CodigoMarca='0' Order by dsTipoAuto","fnActualizaAMIS()","",100,true,true)%>
            <%=MyUtil.ObjInput("Clave AMIS","ClaveAMISVTR","", false,false,30,120,"",false,false,15)%>
            <%=MyUtil.ObjInput("Año","Modelo","",true,true,140,120,"",false,false,4)%>
            <%=MyUtil.ObjInput("Placas","Placas","",true,true,250,120,"",false,false,8)%> 
            <%=MyUtil.ObjInput("Color","Color","",true,true,400,120,"",false,false,17)%>
            <%=MyUtil.ObjComboC("Tipo de Vehiculo","clTipoVehiculo","",true,true,30,160,"","Select clTipoVehiculo, dsTipoVehiculo From cTipoVehiculo ","","",25,true,true)%>
            <%=MyUtil.ObjInput("Serie","Serie","",true,true,250,160,"",false,false,25)%>
            <%=MyUtil.ObjInput("No. Motor","NoMotor","",true,true,400,160,"",false,false,25)%>
            <%=MyUtil.ObjComboC("Estatus de la Unidad","clEstatusUnidad","",true,true,30,210,"","Select clEstatusUnidad, dsEstatusUnidad From cEstatusUnidad","fnEstatus()","",60,true,true)%>
            <%=MyUtil.ObjInput("Fecha de Detención<br>(aaaa/mm/dd hh:mm)","FechaDetencion","",true,true,250,200,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaDetencionMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Fecha de Liberación<br>(aaaa/mm/dd hh:mm)","FechaLibera","",true,true,400,200,"",false,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaLiberaMsk.value,this.name)}")%>                            
            <%=MyUtil.ObjInput("Daños Según Ajustador NU","DanoAjustaNU","",true,true,30,250,"",false,false,25,"EsNumerico(document.all.DanoAjustaNU)")%>
            <%=MyUtil.ObjInput("Daño Según Dictamen NU","DanoDictamenNU","",true,true,250,250,"",false,false,25,"EsNumerico(document.all.DanoDictamenNU)")%>
            <%=MyUtil.ObjInput("Daños Según Ajustador CP","DanoAjustaCP","",true,true,30,300,"",false,false,25,"EsNumerico(document.all.DanoAjustaCP)")%>
            <%=MyUtil.ObjInput("Daño Según Dictamen CP","DanoDictamenCP","",true,true,250,300,"",false,false,25,"EsNumerico(document.all.DanoDictamenCP)")%>
            <%=MyUtil.DoBlock("Auto Involucrado de Nuestro Usuario",10,0)%>
            
            <%=MyUtil.ObjComboC("Aseguradora","clAseguradora",rs5.getString("dsAseguradora"),true,true,30,390,rs5.getString("clAseguradora"),"Select clAseguradora, dsAseguradora From cAseguradora ","","",50,true,true)%>
            <%=MyUtil.ObjInput("Número de Siniestro","NoSiniestro","",true,true,400,390,"", false,false,25)%>
            <%=MyUtil.ObjInput("Número de Póliza","NoPoliza","",true,true,550,390,"",false,false,25)%>
            
            <%=MyUtil.DoBlock("Datos del Seguro",10,0)%>  
            <script>document.all.clAseguradora.value=<%=rs5.getString("clAseguradora")%>;</script> <%
       }  %>  
        <%=MyUtil.GeneraScripts()%><% 
        rs3.close();
        rs4.close();
        rs5.close();
        rs.close();
        rs=null;
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
        
 %>
<input name='FechaDetencionMsk' id='FechaDetencionMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<input name='FechaLiberaMsk' id='FechaLiberaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>

<script>
     document.all.NoSiniestro.maxLength=30;   
     document.all.NoPoliza.maxLength=15;   
     document.all.Modelo.maxLength=4;   
     document.all.Placas.maxLength=8;   
     document.all.Color.maxLength=20;  
     document.all.Serie.maxLength=20;   
     document.all.NoMotor.maxLength=20;   

     function fnEstatus()
     { 
       // Estatus de la Unidad Detenido
       if (document.all.clEstatusUnidad.value == 2)  
       {
            document.all.FechaDetencion.value = document.all.fechaEt.value;  // Fecha de sql 
       }  
       else
       {
          //document.all.FechaDetencion.value = "";  // se habilita Combo Zona
       }  
     } 
     
   function fnAntesGuardar()
     {
      if (document.all.clEstatusUnidad.value == 2)  
        {
           if(document.all.FechaDetencion.value==""){
            msgVal=msgVal + " Fecha de Detención del Vehículo ";
            }  
         }else{
            if(document.all.clEstatusUnidad.value == 1 &&  document.all.FechaDetencion.value!="" && document.all.FechaLibera.value==""){
                    msgVal=msgVal + " Fecha de Liberacion del Vehículo ";
            /*   if(document.all.FechaLibera.value==""){
                msgVal=msgVal + " Fecha de Liberacion del Vehículo ";
                }
                 if(document.all.FechaDetencion.value==""){
                msgVal=msgVal + " Fecha de Detencion del Vehículo ";
                }*/
            }
        
        }
        
      if (document.all.FechaDetencion.value!="" && document.all.FechaLibera.value!=""){
            if(document.all.FechaLibera.value <= document.all.FechaDetencion.value){
            msgVal=msgVal + " La Fecha de Liberacion del Vehículo debe ser mayor a la de Detencion ";
            }
      }
      
      
      if (document.all.FechaDetencion.value=="" && document.all.FechaLibera.value!="" && document.all.clEstatusUnidad.value == 1){
            msgVal=msgVal + " Fecha de Detencion del Vehículo ";
      }

 
      if (document.all.clEstatusUnidad.value == 2){
            document.all.FechaLibera.value="";
      }

      
    }     
</script>


</body>
</html>



