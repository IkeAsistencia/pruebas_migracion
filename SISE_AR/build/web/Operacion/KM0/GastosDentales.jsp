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
          
          return;      
     } 
    ResultSet rs3 = UtileriasBDF.rsSQLNP( "Select convert(varchar(20),getdate(),120) FechaApertura ");  
    if (rs3.next()){
       StrFecha = rs3.getString("FechaApertura");
    }  
    
StrSql1.append("Select G.clExpediente, ");
StrSql1.append(" coalesce(convert(varchar(20), G.FechaApertura,120),'') as FechaApertura, ");
StrSql1.append(" coalesce(convert(varchar(20), G.FechaRegistro,120),'') as FechaRegistro, ");
StrSql1.append(" coalesce(G.NombrePaciente,'') as NombrePaciente, ");
StrSql1.append(" G.clParentesco, ");
StrSql1.append(" coalesce(P.dsParentesco,'') as dsParentesco, ");
StrSql1.append(" substring(G.PadecimientoAct,1,1500) as PadecimientoAct, ");
StrSql1.append(" coalesce(G.EdadPaciente,'') as EdadPaciente, ");
StrSql1.append(" coalesce(G.MedicoTratante,'') as MedicoTratante, ");
StrSql1.append(" coalesce(G.Tel1MedicoTrat,'') as Tel1MedicoTrat,  ");
StrSql1.append(" coalesce(G.Tel2MedicoTrat,'') as Tel2MedicoTrat, ");
StrSql1.append(" G.GastosEstimados as GastosEstimados, ");
StrSql1.append(" substring(G.Diagnostico,1,1500) as Diagnostico, ");
StrSql1.append(" substring(G.Tratamiento,1,1500) as Tratamiento, ");
StrSql1.append(" G.CostoFinal as CostoFinal ");
StrSql1.append(" From ");
StrSql1.append(" GastosDentales G ");
StrSql1.append(" left join cParentesco P ON (G.clParentesco=P.clParentesco) ");
StrSql1.append(" Where G.clExpediente =").append(StrclExpediente); 
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());   
    StrSql1.delete(0,StrSql1.length());
    %>
      <script>fnOpenLinks()</script>
    <%  
       StrclPaginaWeb = "158";       
       MyUtil.InicializaParametrosC(158,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    %>
      <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
      <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="GastosDentales.jsp?'>"%>
      <%
       if (rs.next()) { 
      %>
            <script>document.all.btnAlta.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            
            <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura",rs.getString("FechaApertura"),false,false,270,430,StrFecha,true,true,22)%>                
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR",rs.getString("FechaRegistro"),false,false,420,430,"",false,true,22)%>                
            <%=MyUtil.ObjInput("Nombre del Paciente","NombrePaciente",rs.getString("NombrePaciente"),true,true,30,70,"",false,false,70)%>
            <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco",rs.getString("dsParentesco"),true,true,420,70,"","Select clParentesco, dsParentesco From cParentesco ","","",100,false,false)%>
            <%=MyUtil.ObjTextArea("Padecimiento Actual","PadecimientoAct",rs.getString("PadecimientoAct"),"74","4",true,true,30,110,"",false,false)%>
            <%=MyUtil.ObjInput("Edad del Paciente","EdadPaciente",rs.getString("EdadPaciente"),true,true,30,190,"",false,false,10,"fnRango(document.all.EdadPaciente,0,150)")%> 
            <%=MyUtil.ObjInput("Médico Tratante","MedicoTratante",rs.getString("MedicoTratante"),true,true,170,190,"",false,false,75)%> 
            <%=MyUtil.ObjInput("Teléfono 1 Médico Trat.","Tel1MedicoTrat",rs.getString("Tel1MedicoTrat"),true,true,30,230,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Teléfono 2 Médico Trat.","Tel2MedicoTrat",rs.getString("Tel2MedicoTrat"),true,true,220,230,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Gastos Estimados","GastosEstimados",rs.getString("GastosEstimados"),true,true,420,230,"",true,true,25,"EsNumerico(document.all.GastosEstimados)")%> 
            <%=MyUtil.ObjTextArea("Diagnóstico","Diagnostico",rs.getString("Diagnostico"),"74","4",true,true,30,270,"",false,false)%>
            <%=MyUtil.ObjTextArea("Tratamiento","Tratamiento",rs.getString("Tratamiento"),"74","4",true,true,30,350,"",false,false)%> 
            <%=MyUtil.ObjInput("Costo Final","CostoFinal",rs.getString("CostoFinal"),true,true,30,430,"",true,true,15,"EsNumerico(document.all.CostoFinal)")%>  
      <%
      }  
       else {
      %>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
	    <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura","",false,false,270,430,StrFecha,true,true,22)%>
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR","",false,false,420,430,"",false,true,22)%>                

            <%=MyUtil.ObjInput("Nombre del Paciente","NombrePaciente","",true,true,30,70,"",false,false,70)%>
            <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco","",true,true,420,70,"","Select clParentesco, dsParentesco From cParentesco ","","",100,false,false)%>
            <%=MyUtil.ObjTextArea("Padecimiento Actual","PadecimientoAct","","74","4",true,true,30,110,"",false,false)%>
            <%=MyUtil.ObjInput("Edad del Paciente","EdadPaciente","",true,true,30,190,"",false,false,10,"fnRango(document.all.EdadPaciente,0,150)")%> 
            <%=MyUtil.ObjInput("Médico Tratante","MedicoTratante","",true,true,170,190,"",false,false,75)%> 
            <%=MyUtil.ObjInput("Teléfono 1 Médico Trat.","Tel1MedicoTrat","",true,true,30,230,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Teléfono 2 Médico Trat.","Tel2MedicoTrat","",true,true,220,230,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Gastos Estimados","GastosEstimados","",true,true,420,230,"",true,true,25,"EsNumerico(document.all.GastosEstimados)")%> 
            <%=MyUtil.ObjTextArea("Diagnóstico","Diagnostico","","74","4",true,true,30,270,"",false,false)%>
            <%=MyUtil.ObjTextArea("Tratamiento","Tratamiento","","74","4",true,true,30,350,"",false,false)%>
            <%=MyUtil.ObjInput("Costo Final","CostoFinal","",true,true,30,430,"",true,true,15,"EsNumerico(document.all.CostoFinal)")%> 
       <%
       } 
       %>
        <%=MyUtil.DoBlock("Detalle de Gastos Dentales",-35,0)%>    
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
        StrclUsrApp=null;
        StrclPaginaWeb=null;
        StrFecha =null;
        
%>

<script>
     document.all.NombrePaciente.maxLength=80;   
     document.all.EdadPaciente.maxLength=3;   
     document.all.MedicoTratante.maxLength=100;   
     document.all.Tel1MedicoTrat.maxLength=20;   
     document.all.Tel2MedicoTrat.maxLength=20;    
</script>

</body>
</html>
