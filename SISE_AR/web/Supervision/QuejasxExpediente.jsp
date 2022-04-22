 <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title></title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head> 
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<%  
    String StrclUsrApp="0";
    String StrclPaginaWeb="0";
    String StrFecha =""; 
    String StrCodEnt="0";
    String StrdsGerencia = ""; 
    String strclSupervision = "0";
    String StrclQuejaxSupervision = "0";
    String strStatus = "0";
    String StrclExpediente = "0";
    
    
   
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
     
      
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {%>
       Fuera de Horario
      <% return;  
     }    
     
    if (session.getAttribute("clSupervision")!= null)
     {
       strclSupervision = session.getAttribute("clSupervision").toString(); 
     } 

    if (request.getParameter("clQuejaxSupervision")!= null)
        {
            StrclQuejaxSupervision= request.getParameter("clQuejaxSupervision").toString(); 
        }  
      session.setAttribute("clQuejaxSupervision", StrclQuejaxSupervision);
      
        if (request.getParameter("clExpediente")!= null)
        {
            StrclExpediente= request.getParameter("clExpediente").toString(); 
        }  
        else{
            if (session.getAttribute("clExpediente")!= null)
            {
                StrclExpediente= session.getAttribute("clExpediente").toString(); 
            }  
        }
      session.setAttribute("clExpediente", StrclExpediente);
      
    
      StringBuffer StrSql = new StringBuffer();
         
      StrSql.append("Select coalesce(Q.dsQueja,'') as dsQueja, EQ.dsEstatusQueja, " );
      StrSql.append(" coalesce(EsQueja,0) as EsQueja, coalesce(ObservacionesSup,'')  ObservacionesSup, ");
      StrSql.append(" coalesce(ObservacionesArea,'') ObservacionesArea, ");
      StrSql.append(" coalesce(Solucion,'') Solucion, " );
      StrSql.append(" coalesce(convert(varchar(16),FechaIngreso,120),'') FechaIngreso, ");
      StrSql.append(" coalesce(convert(varchar(16),FechaSolucion,120),'') FechaSolucion ");
      StrSql.append(" From QuejasxSupervision QS ");
      StrSql.append(" Left Join cQueja Q On (Q.clQueja=QS.clQueja)" );
      StrSql.append(" Left Join cEstatusQueja EQ On (EQ.clEstatusQueja=QS.clEstatusQueja)");
      StrSql.append(" Where QS.clQuejaxSupervision=").append(StrclQuejaxSupervision);
 
       ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());    
       StrSql.delete(0,StrSql.length()); 
        %> 
       
       <script>fnOpenLinks()</script>
  
<%     StrclPaginaWeb = "466";
       MyUtil.InicializaParametrosC(466,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);%> 

   <%  
       if (rs.next()) { %>
            
            <INPUT id='clQuejaxSupervision' name='clQuejaxSupervision' type='hidden' value='<%=StrclQuejaxSupervision%>'>
            <%=MyUtil.ObjComboC("Queja","clQuejaVTR",rs.getString("dsQueja"),true,false,30,70,"","Select clQueja, dsQueja from cQueja","","",50,true,true)%>
            <%=MyUtil.ObjComboC("Estatus  de la Queja","clEstatusQuejaVTR",rs.getString("dsEstatusQueja"),false,true,300,70,"1","Select clEstatusQueja,dsEstatusQueja from cEstatusQueja","","", 45,true,true)%>
            <%=MyUtil.ObjChkBox("Queja o Inconformidad","EsQuejaVTR",rs.getString("EsQueja"), true,true,550,65,"0","Queja","Inconformidad","")%>
            <%=MyUtil.ObjTextArea("Observaciones de Supervisor","ObservacionesSupVTR",rs.getString("ObservacionesSup"),"80","3",true,true,30,120,"",true,true)%>
            <%=MyUtil.ObjTextArea("Observaciones de Area","ObservacionesAreaVTR",rs.getString("ObservacionesArea"),"80","3",false,true,30,190,"",false,false)%>
            <%=MyUtil.ObjTextArea("Solucion","SolucionVTR",rs.getString("Solucion"),"80","3",false,true,30,260,"",false,false)%>
            <%=MyUtil.ObjInput("Fecha de Ingreso<BR>AAAA/MM/DD HH:MM","FechaIngresoVTR",rs.getString("FechaIngreso"),false,false,30,330,"",true,true,22)%>
            <%=MyUtil.ObjInput("Fecha de Solucion<BR>AAAA/MM/DD HH:MM","FechaSolucionVTR",rs.getString("FechaSolucion"),false,false,300,330,"",false,false,22,"")%>
            <%=MyUtil.DoBlock("Modulo de Quejas",50,25)%>
    <%
        } 
       else {   %>
       No Existe la Queja             
    <%
        }  %>
        <%=MyUtil.GeneraScripts()%>
<script> 
</script>
</body>
</html>
