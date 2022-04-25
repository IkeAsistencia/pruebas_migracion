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
    
StrSql1.append( "Select H.clExpediente, ");
StrSql1.append(" coalesce(H.NombrePaciente,'') as NombrePaciente, ");
StrSql1.append(" H.clParentesco, ");
StrSql1.append(" coalesce(P.dsParentesco,'') as dsParentesco,");
StrSql1.append(" substring(H.Diagnostico,1,1500) as Diagnostico, ");
StrSql1.append(" coalesce(H.NombreHospital,'') as NombreHospital, ");
StrSql1.append(" coalesce(H.TelHospital,'') as TelHospital, ");
StrSql1.append(" coalesce(H.TiempoHospitalizacion,'') as TiempoHospitalizacion, ");
StrSql1.append(" coalesce(H.MedicoTrata,'') as MedicoTrata, ");
StrSql1.append(" coalesce(H.TelMedicoTrata,'') as TelMedicoTrata, ");
StrSql1.append(" coalesce(PA.dsPais,'') as dsPais, ");
StrSql1.append(" coalesce(Ci.dsCiudad,'') as dsCiudad, ");
StrSql1.append(" H.clPais, ");
StrSql1.append(" coalesce(H.CalleNumActual,'') as CalleNumActual, ");
StrSql1.append(" coalesce(H.NombreHotel,'') as NombreHotel, ");
StrSql1.append(" coalesce(H.ReservacionA,'') as ReservacionA, ");
StrSql1.append(" coalesce(convert(varchar(10),H.Desde,120),'') as Desde, ");
StrSql1.append(" coalesce(convert(varchar(10),H.Hasta,120),'') as Hasta, ");
StrSql1.append(" coalesce(H.NumHabitReservadas,'') as NumHabitReservadas, ");
StrSql1.append(" coalesce(H.NumHabitacion,'') as NumHabitacion, ");
StrSql1.append(" H.clTipoHabitacion, ");
StrSql1.append(" coalesce(TA.dsTipoHabitacion,'') as dsTipoHabitacion, ");
StrSql1.append(" H.CostoDiaHabitacion as CostoDiaHabitacion, ");
StrSql1.append(" H.CostoCotizacion as CostoCotizacion, ");
StrSql1.append(" H.CostoFinal as CostoFinal, ");
StrSql1.append(" coalesce(convert(varchar(20), H.FechaApertura,120),'') as FechaApertura, ");
StrSql1.append(" coalesce(convert(varchar(20), H.FechaRegistro,120),'') as FechaRegistro ");
StrSql1.append(" From ");
StrSql1.append(" HotelConvalece H ");
StrSql1.append(" left join cParentesco P ON (H.clParentesco=P.clParentesco) ");
StrSql1.append(" left join cPais PA ON (H.clPais=PA.clPais) ");
StrSql1.append(" left join cCiudad Ci ON (H.clCiudad=Ci.clCiudad and Ci.clPais=H.clPais) ");
StrSql1.append(" left join cTipoHabitacion TA ON (TA.clTipoHabitacion=H.clTipoHabitacion) ");
StrSql1.append(" Where H.clExpediente =").append(StrclExpediente); 
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());
    StrSql1.delete(0,StrSql1.length());
    %>
     <script>fnOpenLinks()</script>
     <%
       
       StrclPaginaWeb = "154";       
       MyUtil.InicializaParametrosC(154,Integer.parseInt(StrclUsrApp)); 
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
     %>
       <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>         
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="HotelConvalece.jsp?'>"%>
     <% 
       if (rs.next()) { 
            %>
            <script>document.all.btnAlta.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjInput("Nombre del Paciente","NombrePaciente",rs.getString("NombrePaciente"),true,true,30,70,"",false,false,70)%>
            <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco",rs.getString("dsParentesco"),true,true,480,70,"","Select clParentesco, dsParentesco From cParentesco ","","",100,false,false)%>
            <%=MyUtil.DoBlock("Detalle de Hotel por Convalecencia",-15,0)%>    
            <%=MyUtil.ObjTextArea("Diagnóstico","Diagnostico",rs.getString("Diagnostico"),"74","4",true,true,30,150,"",false,false)%>
            <%=MyUtil.ObjInput("Nombre del Hospital","NombreHospital",rs.getString("NombreHospital"),true,true,30,240,"",false,false,98)%> 
            <%=MyUtil.ObjInput("Teléfono del Hospital","TelHospital",rs.getString("TelHospital"),true,true,30,280,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Tiempo de Hospitalización","TiempoHospitalizacion",rs.getString("TiempoHospitalizacion"),true,true,200,280,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Médico Tratante","MedicoTrata",rs.getString("MedicoTrata"),true,true,30,320,"",false,false,70)%> 
            <%=MyUtil.ObjInput("Teléfono Médico Trat.","TelMedicoTrata",rs.getString("TelMedicoTrata"),true,true,490,320,"",false,false,20)%> 
            <%=MyUtil.ObjComboC("País de su Ubicación Actual","clPais",rs.getString("dsPais"),true,true,30,360,"","Select clPais, dsPais From cPais Order by dsPais","fnLlenaCiudades()","",70,false,false)%>
            <%=MyUtil.ObjComboC("Ciudad de su Ubicación Actual","clCiudad",rs.getString("dsCiudad"),true,true,300,360,"","Select clCiudad, dsCiudad From cCiudad Where clPais=" + rs.getString("clPais") + " Order by dsCiudad","","",60,false,false)%>
            <%=MyUtil.ObjInput("Calle y número de su Ubicación Actual","CalleNumActual",rs.getString("CalleNumActual"),true,true,30,400,"",false,false,60)%> 
            <%=MyUtil.DoBlock("Detalle del Hospital",-25,0)%>                
            <%=MyUtil.ObjInput("Nombre del Hotel","NombreHotel",rs.getString("NombreHotel"),true,true,30,480,"",false,false,98)%> 
            <%=MyUtil.ObjInput("Reservación a Nombre de","ReservacionA",rs.getString("ReservacionA"),true,true,30,520,"",false,false,98)%> 
            <%=MyUtil.ObjInput("Desde el día","Desde",rs.getString("Desde"),true,true,30,560,"",true,true,20,"if(this.readOnly==false){fnValMask(this,document.all.DesdeMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Hasta el día (aaaa-mm-dd)","Hasta",rs.getString("Hasta"),true,true,180,560,"",true,true,20,"if(this.readOnly==false){fnValMask(this,document.all.HastaMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Núm. Habit. Reservadas","NumHabitReservadas",rs.getString("NumHabitReservadas"),true,true,370,560,"",false,false,10,"EsNumerico(document.all.NumHabitReservadas)")%> 
            <%=MyUtil.ObjInput("Núm. Habitación","NumHabitacion",rs.getString("NumHabitacion"),true,true,30,600,"",false,false,10)%> 
            <%=MyUtil.ObjComboC("Tipo de Habitación","clTipoHabitacion",rs.getString("dsTipoHabitacion"),true,true,180,600,"","Select clTipoHabitacion, dsTipoHabitacion From cTipoHabitacion Order by dsTipoHabitacion","","",10,false,false)%>
            <%=MyUtil.ObjInput("Costo Diario x Habitación","CostoDiaHabitacion",rs.getString("CostoDiaHabitacion"),true,true,370,600,"",true,true,25,"EsNumerico(document.all.CostoDiaHabitacion)")%> 
            <%=MyUtil.ObjInput("Costo de Cotización","CostoCotizacion",rs.getString("CostoCotizacion"),true,true,30,640,"",true,true,15,"EsNumerico(document.all.CostoCotizacion)")%> 
            <%=MyUtil.ObjInput("Costo Final","CostoFinal",rs.getString("CostoFinal"),true,true,180,640,"",true,true,15,"EsNumerico(document.all.CostoFinal)")%> 
            <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura",rs.getString("FechaApertura"),false,false,350,640,StrFecha,true,true,25)%>                
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR",rs.getString("FechaRegistro"),false,false,498,640,"",false,true,25)%>                
            <%=MyUtil.DoBlock("Detalle del Hotel",-33,0)%> 
            <%
      } 
       else { 
           %>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%= StrclExpediente%>'>
            <%=MyUtil.ObjInput("Nombre del Paciente","NombrePaciente","",true,true,30,70,"",false,false,70)%>
            <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco","",true,true,480,70,"","Select clParentesco, dsParentesco From cParentesco ","","",100,false,false)%>
            <%=MyUtil.DoBlock("Detalle de Hotel por Convalecencia",-15,0)%>    
            <%=MyUtil.ObjTextArea("Diagnóstico","Diagnostico","","74","4",true,true,30,150,"",false,false)%>
            <%=MyUtil.ObjInput("Nombre del Hospital","NombreHospital","",true,true,30,240,"",false,false,98)%> 
            <%=MyUtil.ObjInput("Teléfono del Hospital","TelHospital","",true,true,30,280,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Tiempo de Hospitalización","TiempoHospitalizacion","",true,true,200,280,"",false,false,50)%> 
            <%=MyUtil.ObjInput("Médico Tratante","MedicoTrata","",true,true,30,320,"",false,false,70)%> 
            <%=MyUtil.ObjInput("Teléfono Médico Trat.","TelMedicoTrata","",true,true,490,320,"",false,false,20)%> 
            <%=MyUtil.ObjComboC("País de su Ubicación Actual","clPais","",true,true,30,360,"","Select clPais, dsPais From cPais Order by dsPais","fnLlenaCiudades()","",70,false,false)%>
            <%=MyUtil.ObjComboC("Ciudad de Ubicación Actual","clCiudad","",true,true,300,360,"","","","",60,false,false)%>
            <%=MyUtil.ObjInput("Calle y número de su Ubicación Actual","CalleNumActual","",true,true,30,400,"",false,false,60)%> 
            <%=MyUtil.DoBlock("Detalle del Hospital",-25,0)%>                
            <%=MyUtil.ObjInput("Nombre del Hotel","NombreHotel","",true,true,30,480,"",false,false,98)%> 
            <%=MyUtil.ObjInput("Reservación a Nombre de","ReservacionA","",true,true,30,520,"",false,false,98)%> 
            <%=MyUtil.ObjInput("Desde el día","Desde","",true,true,30,560,"",true,true,20,"if(this.readOnly==false){fnValMask(this,document.all.DesdeMsk.value,this.name)}")%> 
            <%=MyUtil.ObjInput("Hasta el día (aaaa-mm-dd)","Hasta","",true,true,180,560,"",true,true,20,"if(this.readOnly==false){fnValMask(this,document.all.HastaMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Núm. Habit. Reservadas","NumHabitReservadas","",true,true,370,560,"",false,false,10,"EsNumerico(document.all.NumHabitReservadas)")%> 
            <%=MyUtil.ObjInput("Núm. Habitación","NumHabitacion","",true,true,30,600,"",false,false,10)%> 
            <%=MyUtil.ObjComboC("Tipo de Habitación","clTipoHabitacion","",true,true,180,600,"","Select clTipoHabitacion, dsTipoHabitacion From cTipoHabitacion Order by dsTipoHabitacion","","",10,false,false)%>
            <%=MyUtil.ObjInput("Costo Diario x Habitación","CostoDiaHabitacion","",true,true,370,600,"",true,true,25,"EsNumerico(document.all.CostoDiaHabitacion)")%> 
            <%=MyUtil.ObjInput("Costo de Cotización","CostoCotizacion","",true,true,30,640,"",true,true,15,"EsNumerico(document.all.CostoCotizacion)")%> 
            <%=MyUtil.ObjInput("Costo Final","CostoFinal","",true,true,180,640,"",true,true,15,"EsNumerico(document.all.CostoFinal)")%> 
	    <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura","",false,false,350,640,StrFecha,true,true,25)%>                
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR","",false,false,498,640,"",false,true,25)%>                
        <%=MyUtil.DoBlock("Detalle del Hotel",-33,0)%>   
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
<input name='DesdeMsk' id='DesdeMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
<input name='HastaMsk' id='HastaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
<script>
     document.all.NombrePaciente.maxLength=80; 
     document.all.TiempoHospitalizacion.maxLength=50;   
     document.all.NombreHospital.maxLength=100;   
     document.all.TelHospital.maxLength=20;   
     document.all.MedicoTrata.maxLength=80;   
     document.all.TelMedicoTrata.maxLength=20;   
     document.all.CalleNumActual.maxLength=60;  
     document.all.NombreHotel.maxLength=100;   
     document.all.ReservacionA.maxLength=100;  
     document.all.NumHabitReservadas.maxLength=2;  
     document.all.NumHabitacion.maxLength=10;  
</script>

</body>
</html>
