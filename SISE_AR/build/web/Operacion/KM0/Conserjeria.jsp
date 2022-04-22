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
    
    StrSql1.append("Select C.clExpediente, coalesce(convert(varchar(20), C.FechaApertura,120),'') as FechaApertura, coalesce(convert(varchar(20), C.FechaRegistro,120),'') as FechaRegistro, " ); 
StrSql1.append(" C.clTipoInformacion, coalesce(TI.dsTipoInformacion,'') as dsTipoInformacion, " );
StrSql1.append(" substring(C.DescSolicitud,1,8000) as DescSolicitud, " );
StrSql1.append(" coalesce(C.TelContacto1,'') as TelContacto1, coalesce(C.TelContacto2,'') as TelContacto2, " ); 
StrSql1.append(" coalesce(C.Fax,'') as Fax, coalesce(C.Email,'') as Email," );
StrSql1.append(" substring(C.InfProporciona,1,8000) as InfProporciona  " );
StrSql1.append(" From " );
StrSql1.append(" Conserjeria C " );
StrSql1.append(" left join cTipoInformacion TI ON (C.clTipoInformacion=TI.clTipoInformacion) " );
StrSql1.append(" Where C.clExpediente =").append(StrclExpediente); 
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());    
    StrSql1.delete(0,StrSql1.length());        
    %>
       <script>fnOpenLinks()</script>
       <%
       StrclPaginaWeb = "153";       
       MyUtil.InicializaParametrosC(153,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
 
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %>
       <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="Conserjeria.jsp?'>"%>
       <%
       if (rs.next()) { 
           %>
            <script>document.all.btnAlta.disabled=true;</script>
            
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            
            <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura",rs.getString("FechaApertura"),false,false,220,70,StrFecha,true,true,25)%>                
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR",rs.getString("FechaRegistro"),false,false,370,70,"",false,true,25)%>                
            <%=MyUtil.ObjComboC("Tipo de Informaci�n","clTipoInformacion",rs.getString("dsTipoInformacion"),true,true,30,70,"","Select clTipoInformacion, dsTipoInformacion From cTipoInformacion Order by dsTipoInformacion","","",100,false,false)%>
            <%=MyUtil.ObjTextArea("Descripci�n de Solicitud","DescSolicitud",rs.getString("DescSolicitud"),"59","4",true,true,30,110,"",false,false)%>
            <%=MyUtil.ObjInput("Tel�fono de Contacto 1","TelContacto1",rs.getString("TelContacto1"),true,true,30,200,"",false,false,20)%>
            <%=MyUtil.ObjInput("Tel�fono de Contacto 2","TelContacto2",rs.getString("TelContacto2"),true,true,200,200,"",false,false,20)%>
            <%=MyUtil.ObjInput("Fax","Fax",rs.getString("Fax"),true,true,30,240,"",false,false,20)%>
            <%=MyUtil.ObjInput("Email","Email",rs.getString("Email"),true,true,200,240,"",false,false,50)%> 
            <%=MyUtil.ObjTextArea("Informaci�n Proporcionada","InfProporciona",rs.getString("InfProporciona"),"59","4",true,true,30,280,"",false,false)%>
            <%
      } 
       else {
           %>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
	    <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura","",false,false,220,70,StrFecha,true,true,20)%>                
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR","",false,false,370,70,"",false,true,20)%>                
            <%=MyUtil.ObjComboC("Tipo de Informaci�n","clTipoInformacion","",true,true,30,70,"","Select clTipoInformacion, dsTipoInformacion From cTipoInformacion Order by dsTipoInformacion","","",100,false,false)%>
            <%=MyUtil.ObjTextArea("Descripci�n de Solicitud","DescSolicitud","","59","4",true,true,30,110,"",false,false)%>
            <%=MyUtil.ObjInput("Tel�fono de Contacto 1","TelContacto1","",true,true,30,200,"",false,false,20)%>
            <%=MyUtil.ObjInput("Tel�fono de Contacto 2","TelContacto2","",true,true,200,200,"",false,false,20)%>
            <%=MyUtil.ObjInput("Fax","Fax","",true,true,30,240,"",false,false,20)%>
            <%=MyUtil.ObjInput("Email","Email","",true,true,200,240,"",false,false,50)%> 
            <%=MyUtil.ObjTextArea("Informaci�n Proporcionada","InfProporciona","","59","4",true,true,30,280,"",false,false)%>
        <%    
        } 
        %>
        <%=MyUtil.DoBlock("Detalle de Conserjer�a",-25,50)%>   
        <%=MyUtil.GeneraScripts()%>   
        
        <%
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
     document.all.TelContacto1.maxLength=20;   
     document.all.TelContacto2.maxLength=20;   
     document.all.Fax.maxLength=20;   
     document.all.Email.maxLength=50;   
</script>

</body>
</html>
