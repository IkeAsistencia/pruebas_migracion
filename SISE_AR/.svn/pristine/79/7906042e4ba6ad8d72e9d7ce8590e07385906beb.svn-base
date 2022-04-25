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
    
StrSql1.append("Select E.clExpediente, coalesce(E.ReclamaANombre,'') as ReclamaANombre, " );
StrSql1.append(" E.clParentesco, coalesce(P.dsParentesco,'') as dsParentesco, coalesce(E.NumMaletas,'') as NumMaletas, " );
StrSql1.append(" coalesce(convert(varchar(10), E.FechaSalida,120),'') as FechaSalida, " );
StrSql1.append(" substring(E.ContenidoyCaract,1,8000) as ContenidoyCaract, coalesce(E.Aerolinea,'') as Aerolinea, " );
StrSql1.append(" coalesce(E.TelAeroSegmto,'') as TelAeroSegmto, " );
StrSql1.append(" substring(E.Ruta,1,8000) as Ruta, coalesce(E.NumVuelos,'') as NumVuelos, coalesce(E.NumTicket,'') as NumTicket, " );
StrSql1.append(" coalesce(E.PresentoReclama,'') as PresentoReclama, coalesce(E.NumReclamacion,'') as NumReclamacion, " );
StrSql1.append(" coalesce(convert(varchar(20), E.FechaApertura,120),'') as FechaApertura, " );
StrSql1.append(" coalesce(convert(varchar(20), E.FechaRegistro,120),'') as FechaRegistro " );
StrSql1.append(" From " ); 
StrSql1.append(" EquipajeRecup E " );
StrSql1.append(" left join cParentesco P ON (P.clParentesco=E.clParentesco) " );
StrSql1.append(" Where E.clExpediente =").append(StrclExpediente); 
ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());
StrSql1.delete(0,StrSql1.length());
       %>
      <script>fnOpenLinks()</script>
       <%
       StrclPaginaWeb = "157";       
       MyUtil.InicializaParametrosC(157,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
       %>
       <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="EquipajeRecup.jsp?'>"%>
       <%
       if (rs.next()) { 
       %>
         <script>document.all.btnAlta.disabled=true;</script>
         <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjInput("Reclamación a nombre de","ReclamaANombre",rs.getString("ReclamaANombre"),true,true,30,70,"",false,false,100)%>
            <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco",rs.getString("dsParentesco"),true,true,30,110,"","Select clParentesco, dsParentesco From cParentesco ","","",100,false,false)%>
            <%=MyUtil.ObjInput("Núm. de Maletas","NumMaletas",rs.getString("NumMaletas"),true,true,270,110,"",false,false,10)%> 
            <%=MyUtil.ObjInput("Fecha de Salida (aaaa-mm-dd)","FechaSalida",rs.getString("FechaSalida"),true,true,420,110,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaSalidaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjTextArea("Contenido y Características","ContenidoyCaract",rs.getString("ContenidoyCaract"),"75","4",true,true,30,150,"",false,false)%>
            <%=MyUtil.ObjInput("Aerolínea","Aerolinea",rs.getString("Aerolinea"),true,true,30,240,"",false,false,75)%> 
            <%=MyUtil.ObjInput("Teléf. Aerolinea","TelAeroSegmto",rs.getString("TelAeroSegmto"),true,true,430,240,"",false,false,20)%> 
            <%=MyUtil.ObjTextArea("Ruta","Ruta",rs.getString("Ruta"),"75","4",true,true,30,280,"",false,false)%>
            <%=MyUtil.ObjInput("Número de Vuelos","NumVuelos",rs.getString("NumVuelos"),true,true,30,370,"",false,false,40)%> 
            <%=MyUtil.ObjInput("Número de Ticket","NumTicket",rs.getString("NumTicket"),true,true,305,370,"",false,false,40)%> 
            <%=MyUtil.ObjChkBox("Presentó Reclamación","PresentoReclama",rs.getString("PresentoReclama"),true,true,30,410,"1","SI","NO","")%>
            <%=MyUtil.ObjInput("Número de Reclamación","NumReclamacion",rs.getString("NumReclamacion"),true,true,180,410,"",false,false,30)%>
            <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura",rs.getString("FechaApertura"),false,false,388,410,StrFecha,true,true,22)%>                
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR",rs.getString("FechaRegistro"),false,false,523,410,"",false,true,22)%>    
       <%
       } 
       else {  
       %>    
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjInput("Reclamación a nombre de","ReclamaANombre","",true,true,30,70,"",false,false,100)%>
            <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco","",true,true,30,110,"","Select clParentesco, dsParentesco From cParentesco ","","",100,false,false)%>
            <%=MyUtil.ObjInput("Núm. de Maletas","NumMaletas","",true,true,270,110,"",false,false,10)%> 
            <%=MyUtil.ObjInput("Fecha de Salida (aaaa-mm-dd)","FechaSalida","",true,true,420,110,"",true,true,22,"if(this.readOnly==false){fnValMask(this,document.all.FechaSalidaMsk.value,this.name)}")%> 
            <%=MyUtil.ObjTextArea("Contenido y Características","ContenidoyCaract","","75","4",true,true,30,150,"",false,false)%>
            <%=MyUtil.ObjInput("Aerolínea","Aerolinea","",true,true,30,240,"",false,false,75)%> 
            <%=MyUtil.ObjInput("Teléf. Aerolinea","TelAeroSegmto","",true,true,430,240,"",false,false,20)%> 
            <%=MyUtil.ObjTextArea("Ruta","Ruta","","75","4",true,true,30,280,"",false,false)%>
            <%=MyUtil.ObjInput("Número de Vuelos","NumVuelos","",true,true,30,370,"",false,false,40)%> 
            <%=MyUtil.ObjInput("Número de Ticket","NumTicket","",true,true,305,370,"",false,false,40)%> 
            <%=MyUtil.ObjChkBox("Presentó Reclamación","PresentoReclama","",true,true,30,410,"0","SI","NO","")%>
            <%=MyUtil.ObjInput("Número de Reclamación","NumReclamacion","",true,true,180,410,"",false,false,30)%>
	    <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura","",false,false,388,410,StrFecha,true,true,22)%>                
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR","",false,false,523,410,"",false,true,22)%>        
       <% 
       } 
       %>
        <%=MyUtil.DoBlock("Detalle de Recuperación de Equipaje",-45,0)%>   
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
<input name='FechaSalidaMsk' id='FechaSalidaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
<script>
     document.all.ReclamaANombre.maxLength=100;  
     document.all.NumMaletas.maxLength=2;   
     document.all.Aerolinea.maxLength=100;   
     document.all.NumVuelos.maxLength=50;   
     document.all.NumTicket.maxLength=50;   
     document.all.NumReclamacion.maxLength=50;  
     document.all.TelAeroSegmto.maxLength=20;   
</script>

</body>
</html>
