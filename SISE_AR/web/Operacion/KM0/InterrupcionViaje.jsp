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
    
StrSql1.append("Select IV.clExpediente, ");
StrSql1.append(" coalesce(IV.NombreFinado,'') as NombreFinado, ");
StrSql1.append(" IV.clParentesco, coalesce(P.dsParentesco,'') as dsParentesco, ");
StrSql1.append(" coalesce(convert(varchar(10), IV.FechaDesceso,120),'') as FechaDesceso, ");
StrSql1.append(" IV.CostoEstimado, ");
StrSql1.append(" IV.CostoFinal,  ");
StrSql1.append(" coalesce(convert(varchar(10), IV.FechaVueloProg,120),'') as FechaVueloProg, ");
StrSql1.append(" coalesce(IV.NumVueloProg,'') as NumVueloProg, ");
StrSql1.append(" coalesce(IV.AerolineaProg,'') as AerolineaProg, ");
StrSql1.append(" coalesce(IV.DestinoProg,'') as DestinoProg,  ");
StrSql1.append(" coalesce(convert(varchar(10), IV.FechaProbRegreso,120),'') as FechaProbRegreso, ");
StrSql1.append(" coalesce(IV.NumVueloRegreso,'') as NumVueloRegreso, ");
StrSql1.append(" coalesce(convert(varchar(20), IV.FechaApertura,120),'') as FechaApertura, ");
StrSql1.append(" coalesce(convert(varchar(20), IV.FechaRegistro,120),'') as FechaRegistro,  ");
StrSql1.append(" coalesce(IV.AerolineaRegreso,'') as AerolineaRegreso, ");
StrSql1.append(" coalesce(IV.DestinoRegreso,'') as DestinoRegreso ");
StrSql1.append(" From ");
StrSql1.append(" InterrupcionViaje IV ");
StrSql1.append(" left join cParentesco P ON (P.clParentesco=IV.clParentesco) ");
StrSql1.append(" Where IV.clExpediente =").append(StrclExpediente); 
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());
    StrSql1.delete(0,StrSql1.length());
%>        
  <script>fnOpenLinks()</script>
<%       
       StrclPaginaWeb = "164";       
       MyUtil.InicializaParametrosC(164,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
%>
       <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/")+1)%><%="InterrupcionViaje.jsp?'>"%>
        
       <%
       if (rs.next()) { 
        %>
            <script>document.all.btnAlta.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjInput("Nombre del Finado","NombreFinado",rs.getString("NombreFinado"),true,true,30,70,"",false,false,80)%>
            <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco",rs.getString("dsParentesco"),true,true,30,110,"","Select clParentesco, dsParentesco From cParentesco ","","",100,false,false)%>
            <%=MyUtil.ObjInput("Fecha del Deceso","FechaDesceso",rs.getString("FechaDesceso"),true,true,220,110,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaDescesoMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Costo Estimado","CostoEstimado",rs.getString("CostoEstimado"),true,true,390,110,"",true,true,15,"EsNumerico(document.all.CostoEstimado)")%> 
            <%=MyUtil.ObjInput("Costo Final","CostoFinal",rs.getString("CostoFinal"),true,true,520,110,"",true,true,15,"EsNumerico(document.all.CostoFinal)")%> 
            <%=MyUtil.DoBlock("Detalle de Interrupción de Viaje",-40,0)%>  
            <%=MyUtil.ObjInput("Fecha del Vuelo Programado","FechaVueloProg",rs.getString("FechaVueloProg"),true,true,30,190,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaVueloProgMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Vuelo Programado","NumVueloProg",rs.getString("NumVueloProg"),true,true,220,190,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Aerolínea Programada","AerolineaProg",rs.getString("AerolineaProg"),true,true,30,230,"",false,false,100)%> 
            <%=MyUtil.ObjInput("Destino Programado","DestinoProg",rs.getString("DestinoProg"),true,true,30,270,"",false,false,100)%> 
            <%=MyUtil.DoBlock("Vuelo Programado",260,0)%>  
            <%=MyUtil.ObjInput("Fecha Probable de Regreso","FechaProbRegreso",rs.getString("FechaProbRegreso"),true,true,30,350,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaProbRegresoMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Vuelo de Regreso","NumVueloRegreso",rs.getString("NumVueloRegreso"),true,true,210,350,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura",rs.getString("FechaApertura"),false,false,400,350,StrFecha,true,true,22)%>                
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR",rs.getString("FechaRegistro"),false,false,530,350,"",false,true,22)%>                
            <%=MyUtil.ObjInput("Aerolínea de Regreso","AerolineaRegreso",rs.getString("AerolineaRegreso"),true,true,30,390,"",false,false,100)%> 
            <%=MyUtil.ObjInput("Destino de Regreso","DestinoRegreso",rs.getString("DestinoRegreso"),true,true,30,430,"",false,false,100)%> 
            <%=MyUtil.DoBlock("Vuelo de Regreso",-50,0)%> 
       <%     
       } 
       else { 
       %>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjInput("Nombre del Finado","NombreFinado","",true,true,30,70,"",false,false,80)%>
            <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco","",true,true,30,110,"","Select clParentesco, dsParentesco From cParentesco ","","",100,false,false)%>
            <%=MyUtil.ObjInput("Fecha del Deceso","FechaDesceso","",true,true,220,110,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaDescesoMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Costo Estimado","CostoEstimado","",true,true,390,110,"",true,true,15,"EsNumerico(document.all.CostoEstimado)")%> 
            <%=MyUtil.ObjInput("Costo Final","CostoFinal","",true,true,520,110,"",true,true,15,"EsNumerico(document.all.CostoFinal)")%> 
            <%=MyUtil.DoBlock("Detalle de Interrupción de Viaje",-40,0)%>  
            <%=MyUtil.ObjInput("Fecha del Vuelo Programado","FechaVueloProg","",true,true,30,190,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaVueloProgMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Vuelo Programado","NumVueloProg","",true,true,220,190,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Aerolínea Programada","AerolineaProg","",true,true,30,230,"",false,false,100)%> 
            <%=MyUtil.ObjInput("Destino Programado","DestinoProg","",true,true,30,270,"",false,false,100)%> 
            <%=MyUtil.DoBlock("Vuelo Programado",260,0)%>  
            <%=MyUtil.ObjInput("Fecha Probable de Regreso","FechaProbRegreso","",true,true,30,350,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaProbRegresoMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Número de Vuelo de Regreso","NumVueloRegreso","",true,true,220,350,"",false,false,20)%> 
	    <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura","",false,false,400,350,StrFecha,true,true,22)%>                
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR","",false,false,530,350,"",false,true,22)%>                
            <%=MyUtil.ObjInput("Aerolínea de Regreso","AerolineaRegreso","",true,true,30,390,"",false,false,100)%> 
            <%=MyUtil.ObjInput("Destino de Regreso","DestinoRegreso","",true,true,30,430,"",false,false,100)%> 
            <%=MyUtil.DoBlock("Vuelo de Regreso",-50,0)%>
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
<input name='FechaVueloProgMsk' id='FechaVueloProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
<input name='FechaProbRegresoMsk' id='FechaProbRegresoMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
<script>
     document.all.NombreFinado.maxLength=80;  
     document.all.AerolineaProg.maxLength=100;   
     document.all.NumVueloProg.maxLength=20;   
     document.all.DestinoProg.maxLength=100;   
     document.all.AerolineaRegreso.maxLength=100;    
     document.all.NumVueloRegreso.maxLength=20;   
     document.all.DestinoRegreso.maxLength=100;   
</script>

</body>
</html>
