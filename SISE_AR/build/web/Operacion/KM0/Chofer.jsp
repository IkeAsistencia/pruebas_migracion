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

<%  
    String StrclUsrApp="0";
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)  
     {
         %>
       <%="Fuera de Horario"%>
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
         %>
          <%="El expediente no existe"%>
          <%
          rs2.close();
          rs2=null;
          StrclExpediente = null;   
          StrclPaginaWeb=null;
          StrFecha =null;   
          StrclUsrApp=null;
          
          return;      
     } rs2.close();
       rs2=null;

    ResultSet rs3 = UtileriasBDF.rsSQLNP( "Select convert(varchar(20),getdate(),120) FechaApertura ");  
    if (rs3.next()){
       StrFecha = rs3.getString("FechaApertura");
    } 
    
    StrSql1.append("Select coalesce(convert(varchar(20), F.FechaApertura,120),'') as FechaApertura, coalesce(convert(varchar(20), F.FechaRegistro,120),'') as FechaRegistro, " );
StrSql1.append(" coalesce(F.AgenciaTaller,'') as AgenciaTaller, coalesce(F.TelAgenciaTaller,'') as TelAgenciaTaller, " );
StrSql1.append(" coalesce(EChof.dsEntFed,'') as dsEntFed, coalesce(MChof.dsMunDel,'') as dsMunDel, F.CodMD, F.CodEnt, " );
StrSql1.append(" coalesce(F.CalleNumActual,'') as CalleNumActual, substring(F.ReferVisuales,1,1500) as ReferVisuales, " );
StrSql1.append(" coalesce(ERes.dsEntFed,'') as dsEntFedResid, coalesce(MRes.dsMunDel,'') as dsMunDelResid, F.CodMDResid, F.CodEntResid, " );
StrSql1.append(" coalesce(F.CalleNumResid,'') as CalleNumResid, coalesce(F.TelContacto,'') as TelContacto,  " ); 
StrSql1.append(" coalesce(F.CostoCotizacion,0) as CostoCotizacion, coalesce(F.CostoFinal,0) as CostoFinal, " );
StrSql1.append(" F.clExpediente " );
StrSql1.append(" From " );
StrSql1.append(" Chofer F " );
StrSql1.append(" left join cEntFed ERes ON (ERes.CodEnt=F.CodEntResid) " ); 
StrSql1.append(" left join cMunDel MRes ON (MRes.CodMD=F.CodMDResid and MRes.CodEnt=F.CodEntResid) " );
StrSql1.append(" left join cEntFed EChof ON (EChof.CodEnt=F.CodEnt) " );
StrSql1.append(" left join cMunDel MChof ON (MChof.CodMD=F.CodMD and MChof.CodEnt=F.CodEnt) " );
StrSql1.append(" Where F.clExpediente =").append(StrclExpediente);  
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());
    StrSql1.delete(0,StrSql1.length());
%>
       <script>fnOpenLinks()</script>
<%       
       StrclPaginaWeb = "147";       
       MyUtil.InicializaParametrosC(147,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
%>
       <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="Chofer.jsp?'>"%>
       <%
       if (rs.next()) { 
%>
            <script>document.all.btnAlta.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%= StrclExpediente %>'>
                 
            <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura",rs.getString("FechaApertura"),false,false,290,360,StrFecha,true,true,25)%>                
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR",rs.getString("FechaRegistro"),false,false,440,360,"",false,true,25)%>                
            <%=MyUtil.ObjInput("Agencia o Taller","AgenciaTaller",rs.getString("AgenciaTaller"),true,true,30,70,"",false,false,50)%>
            <%=MyUtil.ObjInput("Teléfono Agencia o Taller","TelAgenciaTaller",rs.getString("TelAgenciaTaller"),true,true,370,70,"",false,false,20)%>
            <%=MyUtil.ObjComboC("Entidad de su Ubicación Actual","CodEnt",rs.getString("dsEntFed"),true,true,30,110,"","Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","fnLlenaMunicipiosOper()","",70,false,false)%>
            <%=MyUtil.ObjComboC("Municipio de su Ubicación Actual","CodMD",rs.getString("dsMunDel"),true,true,250,110,"","Select CodMD, dsMunDel From cMunDel Where CodEnt='" + rs.getString("CodEnt") + "' Order by dsMunDel","","",160,false,false)%>
            <%=MyUtil.ObjInput("Calle y Número de su Ubicación Actual","CalleNumActual",rs.getString("CalleNumActual"),true,true,30,150,"",false,false,60)%>
            <%=MyUtil.ObjTextArea("Referencias Visuales","ReferVisuales",rs.getString("ReferVisuales"),"58","4",true,true,30,190,"",false,false)%>
            <%=MyUtil.ObjComboC("Entidad del Destino","CodEntResid",rs.getString("dsEntFedResid"),true,true,30,280,"","Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","fnLlenaMunResiden()","",70,false,false)%>
            <%=MyUtil.ObjComboC("Municipio del Destino","CodMDResid",rs.getString("dsMunDelResid"),true,true,250,280,"","Select CodMD, dsMunDel From cMunDel Where CodEnt='" + rs.getString("CodEntResid") + "' Order by dsMunDel","","",160,false,false)%>
            <%=MyUtil.ObjInput("Calle y Número del Destino","CalleNumResid",rs.getString("CalleNumResid"),true,true,30,320,"",false,false,60)%>
            <%=MyUtil.ObjInput("Teléfono de Contacto","TelContacto",rs.getString("TelContacto"),true,true,420,320,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Costo de Cotización","CostoCotizacion",rs.getString("CostoCotizacion"),true,true,30,360,"",true,true,15,"EsNumerico(document.all.CostoCotizacion)")%> 
            <%=MyUtil.ObjInput("Costo Final","CostoFinal",rs.getString("CostoFinal"),true,true,170,360,"",true,true,15,"EsNumerico(document.all.CostoFinal)")%> 
            <%
      }  
       else {    
           %>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%= StrclExpediente %>'>
            
	    <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura","",false,false,290,360,StrFecha,true,true,25)%>                
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR","",false,false,440,360,"",false,true,25)%>                
            <%=MyUtil.ObjInput("Agencia o Taller","AgenciaTaller","",true,true,30,70,"",false,false,50)%>
            <%=MyUtil.ObjInput("Teléfono Agencia o Taller","TelAgenciaTaller","",true,true,370,70,"",false,false,20)%>
            <%=MyUtil.ObjComboC("Entidad de su Ubicación Actual","CodEnt","",true,true,30,110,"","Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","fnLlenaMunicipiosOper()","",70,false,false)%>
            <%=MyUtil.ObjComboC("Municipio de su Ubicación Actual","CodMD","",true,true,250,110,"","","","",160,false,false)%>
            <%=MyUtil.ObjInput("Calle y Número de su Ubicación Actual","CalleNumActual","",true,true,30,150,"",false,false,60)%>
            <%=MyUtil.ObjTextArea("Referencias Visuales","ReferVisuales","","58","4",true,true,30,190,"",false,false)%>
            <%=MyUtil.ObjComboC("Entidad del Destino","CodEntResid","",true,true,30,280,"","Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","fnLlenaMunResiden()","",70,false,false)%>
            <%=MyUtil.ObjComboC("Municipio del Destino","CodMDResid","",true,true,250,280,"","","","",160,false,false)%>
            <%=MyUtil.ObjInput("Calle y Número del Destino","CalleNumResid","",true,true,30,320,"",false,false,60)%>
            <%=MyUtil.ObjInput("Teléfono de Contacto","TelContacto","",true,true,420,320,"",false,false,20)%> 
            <%=MyUtil.ObjInput("Costo de Cotización","CostoCotizacion","",true,true,30,360,"",true,true,15,"EsNumerico(document.all.CostoCotizacion)")%> 
            <%=MyUtil.ObjInput("Costo Final","CostoFinal","",true,true,170,360,"",true,true,15,"EsNumerico(document.all.CostoFinal)")%> 
        <%
        } 
        %>
        
        <%=MyUtil.DoBlock("Detalle de Conductor o Chofer",-35,0)%>    
        <%=MyUtil.GeneraScripts()%>   
<%       
        //rs2.close();
        rs3.close();
        rs.close();
        rs3=null;
        rs=null;
        StrclExpediente = null;   
        StrSql1 = null; 
        StrclPaginaWeb=null;
        StrFecha =null;   
        StrclUsrApp=null;
        
%>
 
<script>
     document.all.AgenciaTaller.maxLength=50; 
     document.all.TelAgenciaTaller.maxLength=20;   
     document.all.CalleNumActual.maxLength=60;   
     document.all.CalleNumResid.maxLength=60;   
     document.all.TelContacto.maxLength=20;        
</script>

</body>
</html>
