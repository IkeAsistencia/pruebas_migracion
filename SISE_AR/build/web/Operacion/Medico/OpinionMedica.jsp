<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Segunda Opinión Médica</title>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">

<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<script src='../../Utilerias/UtilDireccion.js' ></script>

<%  

    String StrclExpediente = "0";   
    String StrclUsrApp="0";
    String StrclPaginaWeb="6138";
   
    if (session.getAttribute("clUsrApp")!= null)   {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)    {
       %><%="Fuera de Horario"%><% 
       return;  
     }    
     
    if (session.getAttribute("clExpediente")!= null)      {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     }  

    
    StringBuffer StrSql = new StringBuffer();
    StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
    
        
    ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
    if (rs2.next())  
     { 

       } else     {
        %><%="El expediente no existe"%><%
          rs2.close();
          rs2=null;
          return;      
     } 
      
    StrSql.append(" st_getOpinionMedica ").append(StrclExpediente);
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());

%> <script>fnOpenLinks()</script>
    <%MyUtil.InicializaParametrosC(6138,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);%>
    <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
    <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="OpinionMedica.jsp?'>"%><%
        
       if (rs.next()) { 
           
          %><script>document.all.btnAlta.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            
          <%=MyUtil.ObjInput("Nombre del Paciente","Paciente",rs.getString("Paciente"),true,true,30,110,"",true,true,60)%>
          <%=MyUtil.ObjInput("Edad","Edad",rs.getString("Edad"),true,true,370,110,"",false,false,10,"fnRango(document.all.Edad,0,150)")%>
          <%=MyUtil.DoBlock("Segunda Opinión Médica",-30,0)%>
            
          <%=MyUtil.ObjTextArea("Padecimiento","Padecimiento",rs.getString("Padecimiento"),"105","4",true,true,30,200,"",true,true)%>
          <%=MyUtil.ObjTextArea("Estudios Previos","DiagnosticoDx",rs.getString("DiagnosticoDx"),"105","4",true,true,30,280,"",false,false)%>
          <%=MyUtil.ObjTextArea("Diagnóstico","MedicoAtendio",rs.getString("MedicoAtendio"),"105","4",true,true,30,360,"",false,false)%>
            
          <%=MyUtil.DoBlock("Datos de la Evaluación",400,35)%><%
            
      } 
      else {   
          %><script>document.all.btnCambio.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
     
          <%=MyUtil.ObjInput("Nombre del Paciente","Paciente","",true,true,30,110,"",true,true,60)%>
          <%=MyUtil.ObjInput("Edad","Edad","",true,true,370,110,"",false,false,10,"fnRango(document.all.Edad,0,150)")%>
          <%=MyUtil.DoBlock("Segunda Opinión Médica",-30,0)%>
           
          <%=MyUtil.ObjTextArea("Padecimiento","Padecimiento","","105","4",true,true,30,200,"",true,true)%>
          <%=MyUtil.ObjTextArea("Estudios Previos","DiagnosticoDx","","105","4",true,true,30,280,"",false,false)%>
          <%=MyUtil.ObjTextArea("Diagnóstico","MedicoAtendio","","105","4",true,true,30,360,"",false,false)%>
                           
          <%=MyUtil.DoBlock("Datos de la Evaluación",400,35)%><%
      }   
 
      %><%=MyUtil.GeneraScripts()%><%
        rs2.close();
        rs.close();
        rs2=null;
        rs=null;
        StrSql=null;
        StrclExpediente = null;   
        StrclUsrApp=null;
        StrclPaginaWeb=null;
        
%>

    <script>
         document.all.Paciente.maxLength=50; 
         document.all.Edad.maxLength=3;
         document.all.Padecimiento.maxLength=500;     
         document.all.DiagnosticoDx.maxLength=500;    
         document.all.MedicoAtendio.maxLength=500;          
    </script>

    </body>
</html>
