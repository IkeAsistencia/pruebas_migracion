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
    
    StrSql1.append("Select C.clExpediente,  " ); 
StrSql1.append(" C.clInformacionPyme, coalesce(TI.dsInformacionPyme,'') as dsInformacionPyme, " );
StrSql1.append(" substring(C.DescSolicitud,1,8000) as DescSolicitud, " );
StrSql1.append(" substring(C.InfProporciona,1,8000) as InfProporciona  " );
StrSql1.append(" From " );
StrSql1.append(" Conserjeria C " );
StrSql1.append(" left join cInformacionPyme TI ON (C.clInformacionPyme=TI.clInformacionPyme) " );
StrSql1.append(" Where C.clExpediente =").append(StrclExpediente); 



    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());    
    StrSql1.delete(0,StrSql1.length());        
    %>
       <script>fnOpenLinks()</script>
       <%
       StrclPaginaWeb = "629";       
       MyUtil.InicializaParametrosC(629,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
 
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %>
       <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="PyME.jsp?'>"%>
       <%
       if (rs.next()) { 
           %>
            <script>document.all.btnAlta.disabled=true;</script>
            
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>             
            <%=MyUtil.ObjComboC("Información PyME","clInformacionPyme",rs.getString("dsInformacionPyme"),true,true,30,70,"","Select clInformacionPyme, dsInformacionPyme From cInformacionPyme Order by dsInformacionPyme","","",100,true,true)%>
            <%=MyUtil.ObjTextArea("Descripción de Solicitud","DescSolicitud",rs.getString("DescSolicitud"),"80","5",true,true,30,110,"",true,true)%>
            <%=MyUtil.ObjTextArea("Información Proporcionada","InfProporciona",rs.getString("InfProporciona"),"80","5",true,true,30,210,"",true,true)%>
            <%
      } 
       else {
           %>
           <script>document.all.btnCambio.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>           
            <%=MyUtil.ObjComboC("Información PyME","clInformacionPyme","",true,true,30,70,"","Select clInformacionPyme, dsInformacionPyme From cInformacionPyme Order by dsInformacionPyme","","",100,true,true)%>
            <%=MyUtil.ObjTextArea("Descripción de Solicitud","DescSolicitud","","80","5",true,true,30,110,"",true,true)%>
            <%=MyUtil.ObjTextArea("Información Proporcionada","InfProporciona","","80","5",true,true,30,210,"",true,true)%>
        <%    
        } 
        %>
        <%=MyUtil.DoBlock("Asistencia PyME",250,50)%>   
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

</script>

</body>
</html>
