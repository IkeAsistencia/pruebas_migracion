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
    
StrSql1.append("Select G.clExpediente, ");
StrSql1.append(" coalesce(G.NombrePaciente,'') as NombrePaciente, ");
StrSql1.append(" coalesce(P.dsParentesco,'') as dsParentesco, ");
StrSql1.append(" coalesce(U.dsUbicacion,'') as dsUbicacion, "); 
StrSql1.append(" coalesce(G.NumHabitacion,'') as NumHabitacion, ");
StrSql1.append(" G.EdadPaciente, ");
StrSql1.append(" coalesce(G.NombreHospHotel,'') as NombreHospHotel, ");
StrSql1.append(" coalesce(PA.dsPais,'') as dsPais, ");
StrSql1.append(" coalesce(Ci.dsCiudad,'') as dsCiudad,");
StrSql1.append(" G.clPais, ");            
StrSql1.append(" coalesce(G.CalleNum,'') as CalleNum, ");
StrSql1.append(" coalesce(G.TelHospHotel,'') as TelHospHotel, ");           
StrSql1.append(" substring(G.PadecimientoAct,1,1500) as PadecimientoAct, ");
StrSql1.append(" coalesce(G.MedicoTratante,'') as MedicoTratante, ");
StrSql1.append(" coalesce(G.TelMedicoTrata1,'') as TelMedicoTrata1, ");
StrSql1.append(" coalesce(G.TelMedicoTrata2,'') as TelMedicoTrata2, ");
StrSql1.append(" coalesce(convert(varchar(10),G.FechaIngreso,120),'') as FechaIngreso, ");            
StrSql1.append(" substring(G.Diagnostico,1,1500) as Diagnostico, ");
StrSql1.append(" coalesce(G.GastosEstimados,'') as GastosEstimados, ");
StrSql1.append(" G.CostoFinal as CostoFinal, ");
StrSql1.append(" coalesce(convert(varchar(20), G.FechaApertura,120),'') as FechaApertura, ");
StrSql1.append(" coalesce(convert(varchar(20), G.FechaRegistro,120),'') as FechaRegistro ");
StrSql1.append(" From ");
StrSql1.append(" GtosMedicosxAccEnf G ");
StrSql1.append(" left join cParentesco P ON (G.clParentesco=P.clParentesco) ");
StrSql1.append(" left join cPais PA ON (G.clPais=PA.clPais) ");
StrSql1.append(" left join cCiudad Ci ON (G.clCiudad=Ci.clCiudad and Ci.clPais=G.clPais) ");
StrSql1.append(" left join cUbicacion U ON (U.clUbicacion=G.clUbicacionActual) ");
StrSql1.append(" Where G.clExpediente =").append(StrclExpediente); 
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());
    StrSql1.delete(0,StrSql1.length());
%>
  <script>fnOpenLinks()</script>
<%       
       StrclPaginaWeb = "171";       
       MyUtil.InicializaParametrosC(171,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
%>
  <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="GtosMedicosxAccEnf.jsp?'>"%>
       <%
       if (rs.next()) { 
       %>
            <script>document.all.btnAlta.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjInput("Nombre del Paciente","NombrePaciente",rs.getString("NombrePaciente"),true,true,30,70,"",false,false,70)%>
            <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco",rs.getString("dsParentesco"),true,true,480,70,"","Select clParentesco, dsParentesco From cParentesco ","","",100,false,false)%>
            <%=MyUtil.DoBlock("Detalle de Gastos Médicos por Accidente o Enfermedad",-15,0)%>     
            <%=MyUtil.ObjComboC("Ubicación Actual del Paciente","clUbicacionActual",rs.getString("dsUbicacion"),true,true,30,150,"","Select clUbicacion, dsUbicacion From cUbicacion Order by dsUbicacion","","",10,false,false)%>
            <%=MyUtil.ObjInput("Número Habitación","NumHabitacion",rs.getString("NumHabitacion"),true,true,250,150,"",false,false,10)%> 
            <%=MyUtil.ObjInput("Edad del Paciente","EdadPaciente",rs.getString("EdadPaciente"),true,true,390,150,"",true,true,10,"fnRango(document.all.EdadPaciente,0,150)")%>
            <%=MyUtil.ObjInput("Nombre del Hospital u Hotel","NombreHospHotel",rs.getString("NombreHospHotel"),true,true,30,190,"",false,false,98)%> 
            <%=MyUtil.ObjComboC("País de su Ubicación Actual","clPais",rs.getString("dsPais"),true,true,30,230,"","Select clPais, dsPais From cPais Order by dsPais","fnLlenaCiudades()","",70,false,false)%>
            <%=MyUtil.ObjComboC("Ciudad de su Ubicación Actual","clCiudad",rs.getString("dsCiudad"),true,true,320,230,"","Select clCiudad, dsCiudad From cCiudad Where clPais=" + rs.getString("clPais") + " Order by dsCiudad","","",60,false,false)%>
            <%=MyUtil.ObjInput("Calle y número de su Ubicación Actual","CalleNum",rs.getString("CalleNum"),true,true,30,270,"",false,false,60)%> 
            <%=MyUtil.ObjInput("Tel. Hospital u Hotel","TelHospHotel",rs.getString("TelHospHotel"),true,true,420,270,"",false,false,20)%> 
            <%=MyUtil.ObjTextArea("Padecimiento Actual","PadecimientoAct",rs.getString("PadecimientoAct"),"74","4",true,true,30,310,"",false,false)%> 
            <%=MyUtil.ObjInput("Médico Tratante","MedicoTratante",rs.getString("MedicoTratante"),true,true,30,400,"",false,false,70)%> 
            <%=MyUtil.ObjInput("Tel. 1 Médico Trat.","TelMedicoTrata1",rs.getString("TelMedicoTrata1"),true,true,30,440,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Tel. 2 Médico Trat.","TelMedicoTrata2",rs.getString("TelMedicoTrata2"),true,true,200,440,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Fecha de Ingreso","FechaIngreso",rs.getString("FechaIngreso"),true,true,370,440,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaIngresoMsk.value,this.name)}")%>   
            <%=MyUtil.ObjTextArea("Diagnóstico","Diagnostico",rs.getString("Diagnostico"),"74","4",true,true,30,480,"",false,false)%>
            <%=MyUtil.ObjInput("Gastos Estimados","GastosEstimados",rs.getString("GastosEstimados"),true,true,30,570,"",true,true,25,"EsNumerico(document.all.GastosEstimados)")%> 
            <%=MyUtil.ObjInput("Costo Final","CostoFinal",rs.getString("CostoFinal"),true,true,220,570,"",true,true,15,"EsNumerico(document.all.CostoFinal)")%> 
            <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura",rs.getString("FechaApertura"),false,false,350,570,StrFecha,true,true,22)%>                
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR",rs.getString("FechaRegistro"),false,false,498,570,"",false,true,22)%>                
            <%=MyUtil.DoBlock("Detalle del Hospital u Hotel",-32,0)%>    
      <%
      } 
       else {  
      %>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjInput("Nombre del Paciente","NombrePaciente","",true,true,30,70,"",false,false,70)%>
            <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco","",true,true,480,70,"","Select clParentesco, dsParentesco From cParentesco ","","",100,false,false)%>
            <%=MyUtil.DoBlock("Detalle de Gastos Médicos por Accidente o Enfermedad",-15,0)%>     
            <%=MyUtil.ObjComboC("Ubicación Actual del Paciente","clUbicacionActual","",true,true,30,150,"","Select clUbicacion, dsUbicacion From cUbicacion Order by dsUbicacion","","",10,false,false)%>
            <%=MyUtil.ObjInput("Número Habitación","NumHabitacion","",true,true,250,150,"",false,false,10)%> 
            <%=MyUtil.ObjInput("Edad del Paciente","EdadPaciente","",true,true,390,150,"",true,true,10,"fnRango(document.all.EdadPaciente,0,150)")%>
            <%=MyUtil.ObjInput("Nombre del Hospital u Hotel","NombreHospHotel","",true,true,30,190,"",false,false,98)%> 
            <%=MyUtil.ObjComboC("País de su Ubicación Actual","clPais","",true,true,30,230,"","Select clPais, dsPais From cPais Order by dsPais","fnLlenaCiudades()","",70,false,false)%>
            <%=MyUtil.ObjComboC("Ciudad de su Ubicación Actual","clCiudad","",true,true,320,230,"","","","",60,false,false)%>
            <%=MyUtil.ObjInput("Calle y número de su Ubicación Actual","CalleNum","",true,true,30,270,"",false,false,60)%> 
            <%=MyUtil.ObjInput("Tel. Hospital u Hotel","TelHospHotel","",true,true,420,270,"",false,false,20)%> 
            <%=MyUtil.ObjTextArea("Padecimiento Actual","PadecimientoAct","","74","4",true,true,30,310,"",false,false)%> 
            <%=MyUtil.ObjInput("Médico Tratante","MedicoTratante","",true,true,30,400,"",false,false,70)%> 
            <%=MyUtil.ObjInput("Tel. 1 Médico Trat.","TelMedicoTrata1","",true,true,30,440,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Tel. 2 Médico Trat.","TelMedicoTrata2","",true,true,200,440,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Fecha de Ingreso","FechaIngreso","",true,true,370,440,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaIngresoMsk.value,this.name)}")%>             
            <%=MyUtil.ObjTextArea("Diagnóstico","Diagnostico","","74","4",true,true,30,480,"",false,false)%>
            <%=MyUtil.ObjInput("Gastos Estimados","GastosEstimados","",true,true,30,570,"",true,true,25,"EsNumerico(document.all.GastosEstimados)")%> 
            <%=MyUtil.ObjInput("Costo Final","CostoFinal","",true,true,220,570,"",true,true,15,"EsNumerico(document.all.CostoFinal)")%> 
            <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura","",false,false,350,570,StrFecha,true,true,22)%>                
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR","",false,false,498,570,"",false,true,22)%>                
            <%=MyUtil.DoBlock("Detalle del Hospital u Hotel",-32,0)%>    
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
<input name='FechaIngresoMsk' id='FechaIngresoMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
<script>
     document.all.NombrePaciente.maxLength=80; 
     document.all.EdadPaciente.maxLength=3;      
     document.all.NombreHospHotel.maxLength=100;   
     document.all.NumHabitacion.maxLength=10;   
     document.all.CalleNum.maxLength=60;  
     document.all.TelHospHotel.maxLength=20;   
     document.all.MedicoTratante.maxLength=80;   
     document.all.TelMedicoTrata1.maxLength=20;   
     document.all.TelMedicoTrata2.maxLength=20;   
</script>

</body>
</html>

