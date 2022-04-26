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
     {%>
       Fuera de Horario
       <%
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

    StringBuffer StrSql = new StringBuffer();
    // checar si ya existe asistencia para el expediente, si existe, ya no procede la alta
    StrSql.append(" Select TieneAsistencia");
    StrSql.append(" From Expediente ");
    StrSql.append(" Where clExpediente=").append(StrclExpediente);
    
    ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
    
    if (rs2.next())  
     {
     }
    else
     {%>
          El expediente no existe
          <%
          rs2.close();
          rs2=null;
          StrclExpediente = null;   
          StrSql = null; 
          StrclPaginaWeb=null;
          StrFecha =null;
          StrclUsrApp=null;
          
          return;      
     } 

    ResultSet rs3 = UtileriasBDF.rsSQLNP( "Select convert(varchar(20),getdate(),120) FechaApertura ");
    
    if (rs3.next()){
       StrFecha = rs3.getString("FechaApertura");
    }     
    
    StrSql.append("Select T.clExpediente, ");
    StrSql.append(" coalesce(T.NombrePaciente,'') as NombrePaciente, ");
    StrSql.append(" coalesce(P.dsParentesco,'') as dsParentesco, ");
    StrSql.append(" coalesce(PA.dsPais,'') as dsPais, ");
    StrSql.append(" coalesce(Ci.dsCiudad,'') as dsCiudad, ");
    StrSql.append(" T.clPais, ");
    StrSql.append(" coalesce(T.TelContacto1,'') as TelContacto1, ");
    StrSql.append(" coalesce(T.CalleNum,'') as CalleNum, ");
    StrSql.append(" coalesce(T.TelContacto2,'') as TelContacto2, ");
    StrSql.append(" substring(T.Diagnostico,1,1500) as Diagnostico, ");
    StrSql.append(" coalesce(T.NombreHospital,'') as NombreHospital, ");
    StrSql.append(" coalesce(T.TelHospital,'') as TelHospital, ");
    StrSql.append(" coalesce(T.TiempoHospitalizacion,'') as TiempoHospitalizacion, ");
    StrSql.append(" coalesce(T.MedicoTratante,'') as MedicoTratante, ");
    StrSql.append(" coalesce(T.TelMedicoTratante,'') as TelMedicoTratante, ");
    StrSql.append(" coalesce(T.ReservacionA,'') as ReservacionA, ");
    StrSql.append(" coalesce(convert(varchar(10),T.FechaProbSalida,120),'') as FechaProbSalida, ");
    StrSql.append(" coalesce(T.NumVuelo,'') as NumVuelo,");
    StrSql.append(" coalesce(T.Aerolinea,'') as Aerolinea, ");
    StrSql.append(" coalesce(T.Destino,'') as Destino, ");
    StrSql.append(" T.CostoEstimBoleto as CostoEstimBoleto, ");
    StrSql.append(" T.CostoCotizacion as CostoCotizacion, ");
    StrSql.append(" T.CostoFinal as CostoFinal, ");
    StrSql.append(" coalesce(convert(varchar(20), T.FechaApertura,120),'') as FechaApertura, ");
    StrSql.append(" coalesce(convert(varchar(20), T.FechaRegistro,120),'') as FechaRegistro ");
    StrSql.append(" From ");
    StrSql.append(" TrasladoFamConvalece T ");
    StrSql.append(" left join cParentesco P ON (T.clParentesco=P.clParentesco) ");
    StrSql.append(" left join cPais PA ON (T.clPais=PA.clPais) ");
    StrSql.append(" left join cCiudad Ci ON (T.clCiudad=Ci.clCiudad and Ci.clPais=T.clPais) ");
    StrSql.append(" Where T.clExpediente =").append(StrclExpediente);
    
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
          %>
       <script>fnOpenLinks()</script>
       <%
       StrclPaginaWeb = "165";       
       MyUtil.InicializaParametrosC(165,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %>
       <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
     <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="TrasladoFamConvalece.jsp?'>"%>
       <%
       if (rs.next()) {  
            // El siguiente campo llave no se mete con MyUtil.ObjInput 
           %>
            <script>document.all.btnAlta.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjInput("Nombre del Paciente","NombrePaciente",rs.getString("NombrePaciente"),true,true,30,70,"",false,false,80)%>
            <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco",rs.getString("dsParentesco"),true,true,540,70,"","Select clParentesco, dsParentesco From cParentesco ","","",100,false,false)%>
            <%=MyUtil.ObjComboC("País de Residencia del Familiar","clPais",rs.getString("dsPais"),true,true,30,110,"","Select clPais, dsPais From cPais Order by dsPais","fnLlenaCiudades()","",70,false,false)%>
            <%=MyUtil.ObjComboC("Ciudad de Residencia del Familiar","clCiudad",rs.getString("dsCiudad"),true,true,300,110,"","Select clCiudad, dsCiudad From cCiudad Where clPais=" + rs.getString("clPais") + " Order by dsCiudad","","",60,false,false)%>
            <%=MyUtil.ObjInput("Teléf. 1 Contacto","TelContacto1",rs.getString("TelContacto1"),true,true,540,110,"",false,false,20)%>
            <%=MyUtil.ObjInput("Calle y número de Residencia del Familiar","CalleNum",rs.getString("CalleNum"),true,true,30,150,"",false,false,70)%>
            <%=MyUtil.ObjInput("Teléf. 2 Contacto","TelContacto2",rs.getString("TelContacto2"),true,true,540,150,"",false,false,20)%>
            <%=MyUtil.DoBlock("Detalle de Traslado de Familiar por Convalecencia",-20,0)%>
        
            <%=MyUtil.ObjTextArea("Diagnóstico","Diagnostico",rs.getString("Diagnostico"),"74","4",true,true,30,230,"",false,false)%>
            <%=MyUtil.ObjInput("Nombre del Hospital","NombreHospital",rs.getString("NombreHospital"),true,true,30,320,"",false,false,100)%>
            <%=MyUtil.ObjInput("Teléfono del Hospital","TelHospital",rs.getString("TelHospital"),true,true,30,360,"",false,false,20)%>
            <%=MyUtil.ObjInput("Tiempo de Hospitalización","TiempoHospitalizacion",rs.getString("TiempoHospitalizacion"),true,true,190,360,"",false,false,55)%>
            <%=MyUtil.ObjInput("Médico Tratante","MedicoTratante",rs.getString("MedicoTratante"),true,true,30,400,"",false,false,80)%>
            <%=MyUtil.ObjInput("Teléfono Médico Trat.","TelMedicoTratante",rs.getString("TelMedicoTratante"),true,true,540,400,"",false,false,20)%>
            <%=MyUtil.DoBlock("Datos del Hospital",-20,0)%>
            
            <%=MyUtil.ObjInput("Reservación a Nombre de","ReservacionA",rs.getString("ReservacionA"),true,true,30,480,"",false,false,100)%>
            <%=MyUtil.ObjInput("Fecha Probable de Salida","FechaProbSalida",rs.getString("FechaProbSalida"),true,true,30,520,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaProbSalidaMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Núm. Vuelo","NumVuelo",rs.getString("NumVuelo"),true,true,200,520,"",false,false,20)%>
            <%=MyUtil.ObjInput("Aerolínea","Aerolinea",rs.getString("Aerolinea"),true,true,30,560,"",false,false,98)%>
            <%=MyUtil.ObjInput("Destino","Destino",rs.getString("Destino"),true,true,30,600,"",false,false,98)%>
            <%=MyUtil.ObjInput("Costo Estimado del Boleto","CostoEstimBoleto",rs.getString("CostoEstimBoleto"),true,true,370,520,"",true,true,25,"EsNumerico(document.all.CostoEstimBoleto)")%>
            <%=MyUtil.ObjInput("Costo de Cotización","CostoCotizacion",rs.getString("CostoCotizacion"),true,true,30,640,"",true,true,15,"EsNumerico(document.all.CostoCotizacion)")%>
            <%=MyUtil.ObjInput("Costo Final","CostoFinal",rs.getString("CostoFinal"),true,true,200,640,"",true,true,15,"EsNumerico(document.all.CostoFinal)")%>
            <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura",rs.getString("FechaApertura"),false,false,370,640,StrFecha,true,true,22)%>
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR",rs.getString("FechaRegistro"),false,false,510,640,"",false,true,22)%>
            <%=MyUtil.DoBlock("Datos del Vuelo",10,0)%>
            <%
      } 
       else { 
           %>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjInput("Nombre del Paciente","NombrePaciente","",true,true,30,70,"",false,false,80)%>
            <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco","",true,true,540,70,"","Select clParentesco, dsParentesco From cParentesco ","","",100,false,false)%>
            <%=MyUtil.ObjComboC("País de Residencia del Familiar","clPais","",true,true,30,110,"","Select clPais, dsPais From cPais Order by dsPais","fnLlenaCiudades()","",70,false,false)%>
            <%=MyUtil.ObjComboC("Ciudad de Residencia del Familiar","clCiudad","",true,true,300,110,"","","","",60,false,false)%>
            <%=MyUtil.ObjInput("Teléf. 1 Contacto","TelContacto1","",true,true,540,110,"",false,false,20)%>
            <%=MyUtil.ObjInput("Calle y número de Residencia del Familiar","CalleNum","",true,true,30,150,"",false,false,70)%>
            <%=MyUtil.ObjInput("Teléf. 2 Contacto","TelContacto2","",true,true,540,150,"",false,false,20)%>
            <%=MyUtil.DoBlock("Detalle de Traslado de Familiar por Convalecencia",-20,0)%>
            
            <%=MyUtil.ObjTextArea("Diagnóstico","Diagnostico","","74","4",true,true,30,230,"",false,false)%>
            <%=MyUtil.ObjInput("Nombre del Hospital","NombreHospital","",true,true,30,320,"",false,false,100)%>
            <%=MyUtil.ObjInput("Teléfono del Hospital","TelHospital","",true,true,30,360,"",false,false,20)%>
            <%=MyUtil.ObjInput("Tiempo de Hospitalización","TiempoHospitalizacion","",true,true,190,360,"",false,false,55)%>
            <%=MyUtil.ObjInput("Médico Tratante","MedicoTratante","",true,true,30,400,"",false,false,80)%>
            <%=MyUtil.ObjInput("Teléfono Médico Trat.","TelMedicoTratante","",true,true,540,400,"",false,false,20)%>
            <%=MyUtil.DoBlock("Datos del Hospital",-20,0)%>
            
            <%=MyUtil.ObjInput("Reservación a Nombre de","ReservacionA","",true,true,30,480,"",false,false,100)%>
            <%=MyUtil.ObjInput("Fecha Probable de Salida","FechaProbSalida","",true,true,30,520,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaProbSalidaMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Núm. Vuelo","NumVuelo","",true,true,200,520,"",false,false,20)%>
            <%=MyUtil.ObjInput("Aerolínea","Aerolinea","",true,true,30,560,"",false,false,98)%>
            <%=MyUtil.ObjInput("Destino","Destino","",true,true,30,600,"",false,false,98)%>
            <%=MyUtil.ObjInput("Costo Estimado del Boleto","CostoEstimBoleto","",true,true,370,520,"",true,true,25,"EsNumerico(document.all.CostoEstimBoleto)")%>
            <%=MyUtil.ObjInput("Costo de Cotización","CostoCotizacion","",true,true,30,640,"",true,true,15,"EsNumerico(document.all.CostoCotizacion)")%>
            <%=MyUtil.ObjInput("Costo Final","CostoFinal","",true,true,200,640,"",true,true,15,"EsNumerico(document.all.CostoFinal)")%>
            <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura","",false,false,370,640,StrFecha,true,true,22)%>
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR","",false,false,510,640,"",false,true,22)%>
            <%=MyUtil.DoBlock("Datos del Vuelo",10,0)%>
            <%
       }    
    rs2.close();
    rs3.close();
    rs.close();
    rs2=null;
    rs3=null;
    rs=null;
    StrclExpediente = null;   
    StrSql = null; 
    StrclPaginaWeb=null;
    StrFecha =null;
    StrclUsrApp=null;
    
            %>
        <%=MyUtil.GeneraScripts()%>
<input name='FechaProbSalidaMsk' id='FechaProbSalidaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
<script>
     document.all.NombrePaciente.maxLength=80; 
     document.all.TiempoHospitalizacion.maxLength=50;   
     document.all.NombreHospital.maxLength=100;   
     document.all.TelHospital.maxLength=20;   
     document.all.MedicoTratante.maxLength=80;   
     document.all.TelMedicoTratante.maxLength=20;   
     document.all.ReservacionA.maxLength=100;  
     document.all.CalleNum.maxLength=60;  
     document.all.TelContacto1.maxLength=20;   
     document.all.TelContacto2.maxLength=20;   
     document.all.Aerolinea.maxLength=100;   
     document.all.NumVuelo.maxLength=20;  
     document.all.Destino.maxLength=100;   
</script>
</body>
</html>