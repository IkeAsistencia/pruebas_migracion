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
     { %>
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
     { %>
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
       
    StrSql.append("Select clMensajeUrgente ,coalesce(M.PersonaaContactar,'') as PersonaaContactar, ");
    StrSql.append(" coalesce( M.Lada1,'') as Lada1, coalesce( M.Telefono1,'') as Telefono1, ");
    StrSql.append("coalesce( M.Lada2,'') as Lada2, coalesce( M.Telefono2,'') as Telefono2, ");
    StrSql.append(" coalesce(M.Mensaje,'') as Mensaje, coalesce(M.PersonaRecibe,'') as PersonaRecibe ");
    StrSql.append(" From  Mensajeurgente M ");
    StrSql.append(" Where M.clExpediente =").append(StrclExpediente);
    
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
    %>
       <script>fnOpenLinks()</script>
       <%
       StrclPaginaWeb = "377";
       MyUtil.InicializaParametrosC(377,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
       %>
       <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
      <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="MensajeUrgente.jsp?'>"%>
       <%
       if (rs.next()) { 
            // El siguiente campo llave no se mete con MyUtil.ObjInput 
            %>
            <script>document.all.btnAlta.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <INPUT id='clMensajeUrgente' name='clMensajeUrgente' type='hidden' value='<%=rs.getString("clMensajeUrgente")%>'>
            <%=MyUtil.ObjInput("Persona a Contactar","PersonaaContactar",rs.getString("PersonaaContactar"),true,true,30,70,"",true,true,50)%>
            <%=MyUtil.ObjInput("Lada1","Lada1",rs.getString("Lada1"),true,true,30,110,"",true,true,5)%>
            <%=MyUtil.ObjInput("Telefono1","Telefono1",rs.getString("Telefono1"),true,true,80,110,"",false,false,20)%>
            <%=MyUtil.ObjInput("Lada2","Lada2",rs.getString("Lada2"),true,true,210,110,"",false,false,5)%>
            <%=MyUtil.ObjInput("Telefono2","Telefono2",rs.getString("Telefono2"),true,true,260,110,"",false,false,20)%>
            <%=MyUtil.ObjTextArea("Mensaje a Transmitir","Mensaje",rs.getString("Mensaje"),"58","4",true,true,30,150,"",true,true)%>
            <%=MyUtil.ObjInput("Persona que Recibio el Mensaje","PersonaRecibe",rs.getString("PersonaRecibe"),true,true,30,230,"",true,true,50)%>
            <%
      }  
       else {    
            // El siguiente campo llave no se mete con MyUtil.ObjInput 
           %>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjInput("Persona a Contactar","PersonaaContactar","",true,true,30,70,"",true,true,50)%>
            <%=MyUtil.ObjInput("Lada1","Lada1","",true,true,30,110,"",true,true,5)%>
            <%=MyUtil.ObjInput("Telefono1","Telefono1","",true,true,80,110,"",true,true,20)%>
            <%=MyUtil.ObjInput("Lada2","Lada2","",true,true,210,110,"",false,false,5)%>
            <%=MyUtil.ObjInput("Telefono2","Telefono2","",true,true,260,110,"",false,false,20)%>
            <%=MyUtil.ObjTextArea("Mensaje a Transmitir","Mensaje","","58","4",true,true,30,150,"",true,true)%>
            <%=MyUtil.ObjInput("Persona que Recibio el Mensaje","PersonaRecibe","",true,true,30,230,"",true,true,50)%>
            <%
        }  
        rs2.close();
        rs.close();
        rs2=null;
        rs=null;
        StrclExpediente = null;   
        StrSql = null; 
        StrclPaginaWeb=null;
        StrFecha =null; 
        StrclUsrApp=null;  
        
       %>
        <%=MyUtil.DoBlock("Detalle de Mensajes Urgentes",-30,0)%>
        <%=MyUtil.GeneraScripts()%>
<script>
     document.all.PersonaaContactar.maxLength=60; 
     document.all.Lada1.maxLength=5;   
     document.all.Telefono1.maxLength=20;   
     document.all.Lada2.maxLength=5;   
     document.all.Telefono2.maxLength=20;        
</script>
</body>
</html>