<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody"> 

<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>

<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<script src='../../Utilerias/UtilDireccion.js' ></script>
<script src='../../Utilerias/UtilMask.js'></script> 
<%  
    String StrclUsrApp="0";
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)  
     {
       %><%="Fuera de Horario"%><%
       StrclUsrApp=null;
       
       return;  
     }    
    String StrclExpediente = "0";   
    String StrclPaginaWeb="0";
    String StrFecha ="";    

    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     } 
    StringBuffer StrSql1 = new StringBuffer();
    // checar si ya existe asistencia para el expediente, si existe, ya no procede la alta
    StrSql1.append(" Select TieneAsistencia From Expediente");
    StrSql1.append(" Where clExpediente=").append(StrclExpediente);
    ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql1.toString());
    StrSql1.delete(0,StrSql1.length());
    if (rs2.next())  
     { 
     }   
    else
     {
          %><%="El expediente no existe"%><%
          rs2.close();
          rs2=null;
          StrclExpediente = null;   
          StrclPaginaWeb=null;
          StrFecha =null; 
          StrclUsrApp=null;
          
          return;      
     } 

    ResultSet rs3 = UtileriasBDF.rsSQLNP( "Select convert(varchar(20),getdate(),120) FechaApertura ");  
    if (rs3.next()){
       StrFecha = rs3.getString("FechaApertura");
    }    
    
StrSql1.append("Select R.clExpediente, ");
StrSql1.append(" coalesce(R.NombreFinado,'') as NombreFinado, ");
StrSql1.append(" coalesce(convert(varchar(10),R.FechaDesceso,120),'') as FechaDesceso, ");
StrSql1.append(" substring(R.CausaOrigino,1,1500) as CausaOrigino, ");
StrSql1.append(" coalesce(P.dsParentesco,'') as dsParentesco, ");
StrSql1.append(" coalesce(UC.dsUbicacionCuerpo,'') as dsUbicacionCuerpo, ");
StrSql1.append(" coalesce(R.FunerariauHospital,'') as FunerariauHospital, ");
StrSql1.append(" coalesce(PA.dsPais,'') as dsPais, ");
StrSql1.append(" coalesce(Ci.dsCiudad,'') as dsCiudad, ");
StrSql1.append(" coalesce(R.clPais,'') as clPais, ");
StrSql1.append(" coalesce(R.CalleNum,'') as CalleNum, ");
StrSql1.append(" coalesce(R.Tel1FunerariauHosp,'') as Tel1FunerariauHosp, ");
StrSql1.append(" coalesce(R.Tel2FunerariauHosp,'') as Tel2FunerariauHosp, ");
StrSql1.append(" coalesce(R.Tel1ContactoFamiliar,'') as Tel1ContactoFamiliar, ");
StrSql1.append(" coalesce(R.Tel2ContactoFamiliar,'') as Tel2ContactoFamiliar, ");
StrSql1.append(" coalesce(PR.dsPais,'') as dsPaisResid, ");
StrSql1.append(" coalesce(CR.dsCiudad,'') as dsCiudadResid,");
StrSql1.append(" R.clPaisResid, ");
StrSql1.append(" coalesce(R.CalleNumResid,'') as CalleNumResid, ");
StrSql1.append(" coalesce(R.FunerariaRecibe,'') as FunerariaRecibe, ");
StrSql1.append(" coalesce(R.Tel1FunerariaRecibe,'') as Tel1FunerariaRecibe,");
StrSql1.append(" coalesce(R.Tel2FunerariaRecibe,'') as Tel2FunerariaRecibe,  ");
StrSql1.append(" coalesce(TT.dsTipoTransporte,'') as dsTipoTransporte, ");
StrSql1.append(" coalesce(R.NumVuelo,'') as NumVuelo, ");
StrSql1.append(" coalesce(R.HorarioSalida,'') as HorarioSalida, ");
StrSql1.append(" coalesce(R.HorarioLlegada,'') as HorarioLlegada, ");
StrSql1.append(" coalesce(R.NumGuia,'') as NumGuia, ");
StrSql1.append(" R.CostoEstimado as CostoEstimado, ");
StrSql1.append(" R.CostoFinal as CostoFinal, ");
StrSql1.append(" coalesce(convert(varchar(20), R.FechaApertura,120),'') as FechaApertura, ");
StrSql1.append(" coalesce(convert(varchar(20), R.FechaRegistro,120),'') as FechaRegistro  ");
StrSql1.append(" From ");
StrSql1.append(" RepatriaFallecido R ");
StrSql1.append(" left join cParentesco P ON (R.clParentesco=P.clParentesco) ");
StrSql1.append(" left join cPais PA ON (R.clPais=PA.clPais) ");
StrSql1.append(" left join cCiudad Ci ON (R.clCiudad=Ci.clCiudad) ");
StrSql1.append(" left join cPais PR ON (R.clPaisResid=PR.clPais) ");
StrSql1.append(" left join cCiudad CR ON (R.clCiudadResid=CR.clCiudad) ");
StrSql1.append(" left join cUbicacionCuerpo UC ON (UC.clUbicacionCuerpo=R.clUbicacionCuerpo) ");
StrSql1.append(" left join cTipoTransporte TT ON (TT.clTipoTransporte=R.clTipoTransporte) ");
StrSql1.append(" Where R.clExpediente =").append(StrclExpediente); 
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());     
    StrSql1.delete(0,StrSql1.length());   
%>
 <script>fnOpenLinks()</script>
<%
       StrclPaginaWeb = "163";       
       MyUtil.InicializaParametrosC(163,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
%>
       <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="RepatriaFallecido.jsp?'>"%>
       <%
       if (rs.next()) { 
       %>
         <script>document.all.btnAlta.disabled=true;</script>
         <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
         
            <%=MyUtil.ObjInput("Nombre del Finado","NombreFinado",rs.getString("NombreFinado"),true,true,30,70,"",false,false,75)%>
            <%=MyUtil.ObjInput("Fecha de Deceso","FechaDesceso",rs.getString("FechaDesceso"),true,true,510,70,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaDescesoMsk.value,this.name)}")%> 
            <%=MyUtil.ObjTextArea("Causa que lo Originó","CausaOrigino",rs.getString("CausaOrigino"),"75","4",true,true,30,110,"",false,false)%>
            <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco",rs.getString("dsParentesco"),true,true,30,200,"","Select clParentesco, dsParentesco From cParentesco ","","",100,false,false)%>
            <%=MyUtil.ObjComboC("Ubicación Actual del Fallecido","clUbicacionCuerpo",rs.getString("dsUbicacionCuerpo"),true,true,320,200,"","Select clUbicacionCuerpo, dsUbicacionCuerpo From cUbicacionCuerpo Order by dsUbicacionCuerpo","","",10,false,false)%>
            <%=MyUtil.DoBlock("Detalle de Repatriación por Fallecimiento",-38,0)%>   
            <%=MyUtil.ObjInput("Funeraria u Hospital de su Ubicación Actual","FunerariauHospital",rs.getString("FunerariauHospital"),true,true,30,280,"",false,false,100)%> 
            <%=MyUtil.ObjComboC("País de su Ubicación Actual","clPais",rs.getString("dsPais"),true,true,30,320,"","Select clPais, dsPais From cPais Order by dsPais","fnLlenaCiudades()","",70,false,false)%>
            <%=MyUtil.ObjComboC("Ciudad de su Ubicación Actual","clCiudad",rs.getString("dsCiudad"),true,true,320,320,"","Select clCiudad, dsCiudad From cCiudad Where clPais=" + rs.getString("clPais") + " Order by dsCiudad","","",60,false,false)%>
            <%=MyUtil.ObjInput("Calle y número de su Ubicación Actual","CalleNum",rs.getString("CalleNum"),true,true,30,360,"",false,false,60)%> 
            <%=MyUtil.ObjInput("Tel. 1 Funeraria/Hosp","Tel1FunerariauHosp",rs.getString("Tel1FunerariauHosp"),true,true,30,400,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Tel. 2 Funeraria/Hosp","Tel2FunerariauHosp",rs.getString("Tel2FunerariauHosp"),true,true,185,400,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Tel. 1 Contacto Familiar","Tel1ContactoFamiliar",rs.getString("Tel1ContactoFamiliar"),true,true,342,400,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Tel. 2 Contacto Fam.","Tel2ContactoFamiliar",rs.getString("Tel2ContactoFamiliar"),true,true,508,400,"",false,false,20)%>  
            <%=MyUtil.DoBlock("UBICACIÓN ACTUAL DEL FALLECIDO",-35,0)%>               
            <%=MyUtil.ObjComboC("País de Traslado del Féretro","clPaisResid",rs.getString("dsPaisResid"),true,true,30,480,"","Select clPais, dsPais From cPais Order by dsPais","fnLlenaCiudResiden()","",70,false,false)%>
            <%=MyUtil.ObjComboC("Ciudad de Traslado del Féretro","clCiudadResid",rs.getString("dsCiudadResid"),true,true,320,480,"","Select clCiudad, dsCiudad From cCiudad Where clPais=" + rs.getString("clPaisResid") + " Order by dsCiudad","","",60,false,false)%> 
            <%=MyUtil.ObjInput("Calle y Número de Traslado del Féretro","CalleNumResid",rs.getString("CalleNumResid"),true,true,30,520,"",false,false,60)%> 
            <%=MyUtil.ObjInput("Funeraria que Recibe","FunerariaRecibe",rs.getString("FunerariaRecibe"),true,true,30,560,"",false,false,100)%>
            <%=MyUtil.ObjInput("Tel. 1 Funeraria Recibe","Tel1FunerariaRecibe",rs.getString("Tel1FunerariaRecibe"),true,true,30,600,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Tel. 2 Funeraria Recibe","Tel2FunerariaRecibe",rs.getString("Tel2FunerariaRecibe"),true,true,185,600,"",false,false,20)%> 
            <%=MyUtil.ObjComboC("Tipo de Transporte","clTipoTransporte",rs.getString("dsTipoTransporte"),true,true,340,600,"","Select clTipoTransporte, dsTipoTransporte From cTipoTransporte Where Clasificacion='REPAT' or Clasificacion='TODAS'","","",70,false,false)%> 
            <%=MyUtil.ObjInput("Número de Vuelo","NumVuelo",rs.getString("NumVuelo"),true,true,515,600,"",false,false,20)%>
            <%=MyUtil.ObjInput("Horario de Salida","HorarioSalida",rs.getString("HorarioSalida"),true,true,30,640,"",false,false,20)%>
            <%=MyUtil.ObjInput("Horario de Llegada","HorarioLlegada",rs.getString("HorarioLlegada"),true,true,185,640,"",false,false,20)%>
            <%=MyUtil.ObjInput("Número de Guía","NumGuia",rs.getString("NumGuia"),true,true,340,640,"",false,false,40)%>
            <%=MyUtil.ObjInput("Costo Estimado","CostoEstimado",rs.getString("CostoEstimado"),true,true,30,680,"",true,true,15,"EsNumerico(document.all.CostoEstimado)")%> 
            <%=MyUtil.ObjInput("Costo Final","CostoFinal",rs.getString("CostoFinal"),true,true,185,680,"",true,true,15,"EsNumerico(document.all.CostoFinal)")%> 
            <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura",rs.getString("FechaApertura"),false,false,340,680,StrFecha,true,true,22)%>                
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR",rs.getString("FechaRegistro"),false,false,515,680,"",false,true,22)%>                
            <%=MyUtil.DoBlock("LUGAR DE TRASLADO DEL FÉRETRO",-40,0)%>  
      <%
      } 
       
       else {   
      %>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjInput("Nombre del Finado","NombreFinado","",true,true,31,70,"",false,false,75)%>
            <%=MyUtil.ObjInput("Fecha de Deceso","FechaDesceso","",true,true,510,70,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaDescesoMsk.value,this.name)}")%> 
            <%=MyUtil.ObjTextArea("Causa que lo Originó","CausaOrigino","","75","4",true,true,30,110,"",false,false)%>
            <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco","",true,true,30,200,"","Select clParentesco, dsParentesco From cParentesco ","","",100,false,false)%>
            <%=MyUtil.ObjComboC("Ubicación Actual del Fallecido","clUbicacionCuerpo","",true,true,320,200,"","Select clUbicacionCuerpo, dsUbicacionCuerpo From cUbicacionCuerpo Order by dsUbicacionCuerpo","","",10,false,false)%>
            <%=MyUtil.DoBlock("Detalle de Repatriación por Fallecimiento",-38,0)%>   
            <%=MyUtil.ObjInput("Funeraria u Hospital de su Ubicación Actual","FunerariauHospital","",true,true,30,280,"",false,false,100)%> 
            <%=MyUtil.ObjComboC("País de su Ubicación Actual","clPais","",true,true,30,320,"","Select clPais, dsPais From cPais Order by dsPais","fnLlenaCiudades()","",70,false,false)%>
            <%=MyUtil.ObjComboC("Ciudad de su Ubicación Actual","clCiudad","",true,true,320,320,"","","","",60,false,false)%>
            <%=MyUtil.ObjInput("Calle y número de su Ubicación Actual","CalleNum","",true,true,30,360,"",false,false,60)%> 
            <%=MyUtil.ObjInput("Tel. 1 Funeraria/Hosp","Tel1FunerariauHosp","",true,true,30,400,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Tel. 2 Funeraria/Hosp","Tel2FunerariauHosp","",true,true,185,400,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Tel. 1 Contacto Familiar","Tel1ContactoFamiliar","",true,true,342,400,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Tel. 2 Contacto Fam.","Tel2ContactoFamiliar","",true,true,508,400,"",false,false,20)%>  
            <%=MyUtil.DoBlock("UBICACIÓN ACTUAL DEL FALLECIDO",-35,0)%>                
            <%=MyUtil.ObjComboC("País de Traslado del Féretro","clPaisResid","",true,true,30,480,"","Select clPais, dsPais From cPais Order by dsPais","fnLlenaCiudResiden()","",70,false,false)%>
            <%=MyUtil.ObjComboC("Ciudad de Traslado del Féretro","clCiudadResid","",true,true,320,480,"","","","",60,false,false)%>
            <%=MyUtil.ObjInput("Calle y Número de Traslado del Féretro","CalleNumResid","",true,true,30,520,"",false,false,60)%> 
            <%=MyUtil.ObjInput("Funeraria que Recibe","FunerariaRecibe","",true,true,30,560,"",false,false,100)%>
            <%=MyUtil.ObjInput("Tel. 1 Funeraria Recibe","Tel1FunerariaRecibe","",true,true,30,600,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Tel. 2 Funeraria Recibe","Tel2FunerariaRecibe","",true,true,185,600,"",false,false,20)%> 
            <%=MyUtil.ObjComboC("Tipo de Transporte","clTipoTransporte","",true,true,340,600,"","Select clTipoTransporte, dsTipoTransporte From cTipoTransporte Where Clasificacion='REPAT' or Clasificacion='TODAS'","","",70,false,false)%> 
            <%=MyUtil.ObjInput("Número de Vuelo","NumVuelo","",true,true,515,600,"",false,false,20)%>
            <%=MyUtil.ObjInput("Horario de Salida","HorarioSalida","",true,true,30,640,"",false,false,20)%>
            <%=MyUtil.ObjInput("Horario de Llegada","HorarioLlegada","",true,true,185,640,"",false,false,20)%>
            <%=MyUtil.ObjInput("Número de Guía","NumGuia","",true,true,340,640,"",false,false,40)%>
            <%=MyUtil.ObjInput("Costo Estimado","CostoEstimado","",true,true,30,680,"",true,true,15,"EsNumerico(document.all.CostoEstimado)")%> 
            <%=MyUtil.ObjInput("Costo Final","CostoFinal","",true,true,185,680,"",true,true,15,"EsNumerico(document.all.CostoFinal)")%> 
	    <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura","",false,false,340,680,StrFecha,true,true,22)%>                
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR","",false,false,515,680,"",false,true,22)%>                
            <%=MyUtil.DoBlock("LUGAR DE TRASLADO DEL FÉRETRO",-40,0)%>  
       <%
       } 
       %>
        <%=MyUtil.GeneraScripts()%> 
<%       
        rs2.close();
        rs3.close();
        rs.close();
        rs2=null;
        rs3=null;
        rs=null;
        StrclExpediente = null;   
        StrSql1 = null; 
        StrclPaginaWeb=null;
        StrFecha =null; 
        StrclUsrApp=null;
        
        
%>
<input name='FechaDescesoMsk' id='FechaDescesoMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
<script>
     document.all.NombreFinado.maxLength=80; 
     document.all.FunerariauHospital.maxLength=100;   
     document.all.CalleNum.maxLength=60;   
     document.all.Tel1FunerariauHosp.maxLength=20;   
     document.all.Tel2FunerariauHosp.maxLength=20;   
     document.all.Tel1ContactoFamiliar.maxLength=20;   
     document.all.Tel2ContactoFamiliar.maxLength=20;   
     document.all.CalleNumResid.maxLength=60;   
     document.all.FunerariaRecibe.maxLength=100;  
     document.all.Tel1FunerariaRecibe.maxLength=20;   
     document.all.Tel2FunerariaRecibe.maxLength=20;   
     document.all.NumVuelo.maxLength=20;   
     document.all.HorarioSalida.maxLength=20;  
     document.all.HorarioLlegada.maxLength=20;  
     document.all.NumGuia.maxLength=40;  
</script>

</body>
</html>
