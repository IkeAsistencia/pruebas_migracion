<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Consulta Teléfonica</title>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">

<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>

<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<script src='../../Utilerias/UtilDireccion.js' ></script>

<%  

    String StrclExpediente = "0";   
    String StrclUsrApp="0";
    String StrclPaginaWeb="0";
    
    

   
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {
       %><%="Fuera de Horario"%><% 
       return;  
     }    
     
    if (session.getAttribute("clExpediente")!= null) 
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     }  

    
    StringBuffer StrSql = new StringBuffer();
    StrSql.append(" Select E.TieneAsistencia "); 
    StrSql.append(" From Expediente E");
    StrSql.append(" Where E.clExpediente=").append(StrclExpediente);
        
    ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
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
      
    StrSql.append("Select CT.clExpediente,coalesce(CT.Paciente,'') as Paciente, coalesce(CT.Edad, 0) Edad, coalesce(CT.PesoKg, 0) PesoKg, ");
    StrSql.append(" coalesce(P.dsParentesco,'') as dsParentesco, coalesce(CT.Padecimiento,'') Padecimiento, ");
    StrSql.append(" coalesce(CT.TiempoEvolucion,'') as TiempoEvolucion, coalesce(CT.Antecedentes,'') Antecedentes, ");
    StrSql.append(" coalesce(CT.TratamientosPrevios,'') TratamientosPrevios, coalesce(CT.EstudiosPrevios,'') EstudiosPrevios, ");
    StrSql.append(" coalesce(CT.RecomendaMedico,'') RecomendaMedico ");
    StrSql.append(" From ConsultaTelefonica CT  ");
    StrSql.append(" Left Join cParentesco P ON (P.clParentesco = CT.clParentesco)  ");
    StrSql.append(" Where CT.clExpediente = ").append(StrclExpediente);



    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());



%> <script>fnOpenLinks()</script>
<%
       StrclPaginaWeb = "224";       
       MyUtil.InicializaParametrosC(224,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
 
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);

    %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
      <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="ConsultaTelefonica.jsp?'>"%><%

       if (rs.next()) { 
           
          %><script>document.all.btnAlta.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            
          <%=MyUtil.ObjInput("Nombre del Paciente","Paciente",rs.getString("Paciente"),true,true,30,110,"",true,true,60)%>
          <%=MyUtil.ObjInput("Edad","Edad",rs.getString("Edad"),true,true,370,110,"",false,false,10,"fnRango(document.all.Edad,0,150)")%>
          <%=MyUtil.ObjInput("Peso (Kgs.)","PesoKg",rs.getString("PesoKg"),true,true,450,110,"",false,false,10,"EsNumerico(document.all.PesoKg)")%>
          <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco",rs.getString("dsParentesco"),true,true,530,110,"","Select clParentesco, dsParentesco From cParentesco ","","",30,true,true)%>
          <%=MyUtil.DoBlock("Servicio de Consulta Médica Telefónica",-30,0)%>
            
          <%=MyUtil.ObjInput("Padecimiento","Padecimiento",rs.getString("Padecimiento"),true,true,30,200,"",true,true,50)%>
          <%=MyUtil.ObjInput("Tiempo de Evolucion","TiempoEvolucion",rs.getString("TiempoEvolucion"),true,true,310,200,"",false,false,50)%>
          <%=MyUtil.ObjTextArea("Antecedentes","Antecedentes",rs.getString("Antecedentes"),"105","4",true,true,30,240,"",false,false)%>
          <%=MyUtil.ObjTextArea("Tratamientos Previos","TratamientosPrevios",rs.getString("TratamientosPrevios"),"105","2",true,true,30,315,"",false,false)%>
          <%=MyUtil.ObjTextArea("Estudios Previos","EstudiosPrevios",rs.getString("EstudiosPrevios"),"105","2",true,true,30,365,"",false,false)%>
          <%=MyUtil.ObjTextArea("RecomendaMedico","RecomendaMedico",rs.getString("RecomendaMedico"),"105","4",true,true,30,415,"",false,false)%>
            
          <%=MyUtil.DoBlock("Datos de la Evaluación",105,35)%><%
            
        
      } 
      else {   
          %><script>document.all.btnCambio.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
     
          <%=MyUtil.ObjInput("Nombre del Paciente","Paciente","",true,true,30,110,"",true,true,60)%>
          <%=MyUtil.ObjInput("Edad","Edad","",true,true,370,110,"",false,false,10,"fnRango(document.all.Edad,0,150)")%>
          <%=MyUtil.ObjInput("Peso (Kgs.)","PesoKg","",true,true,450,110,"",false,false,10,"EsNumerico(document.all.PesoKg)")%>
          <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco","",true,true,530,110,"","Select clParentesco, dsParentesco From cParentesco ","","",30,true,true)%>
          <%=MyUtil.DoBlock("Servicio de Consulta Médica Telefónica",-30,0)%>
           
          <%=MyUtil.ObjInput("Padecimiento","Padecimiento","",true,true,30,200,"",true,true,50)%>
          <%=MyUtil.ObjInput("Tiempo de Evolucion","TiempoEvolucion","",true,true,310,200,"",false,false,50)%>
          <%=MyUtil.ObjTextArea("Antecedentes","Antecedentes","","105","4",true,true,30,240,"",false,false)%>
          <%=MyUtil.ObjTextArea("Tratamientos Previos","TratamientosPrevios","","105","2",true,true,30,315,"",false,false)%>
          <%=MyUtil.ObjTextArea("Estudios Previos","EstudiosPrevios","","105","2",true,true,30,365,"",false,false)%>
          <%=MyUtil.ObjTextArea("RecomendaMedico","RecomendaMedico","","105","4",true,true,30,415,"",false,false)%>
            
          <%=MyUtil.DoBlock("Datos de la Evaluación",105,35)%><%
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
     document.all.PesoKg.maxLength=7;   
     document.all.Padecimiento.maxLength=50;   
     document.all.TiempoEvolucion.maxLength=50;      
     document.all.Antecedentes.maxLength=500;      
     document.all.TratamientosPrevios.maxLength=200;          
     document.all.EstudiosPrevios.maxLength=200;      
     document.all.RecomendaMedico.maxLength=500;          
</script>

</body>
</html>
