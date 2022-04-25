<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Intervenciones</title>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">

<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackagAL.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>

<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 

<script src='../../Utilerias/Util.js' ></script>
<script src='../../Utilerias/UtilMask.js' ></script>

<%  
    String StrclUsrApp="0";
    
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)
     {
      %>Fuera de Horario<%
      StrclUsrApp=null; 
      
      return;  
     }    
    String StrclExpediente = "0";    
    String StrclProcesoCivil = "0"; 
    String StrclPaginaWeb="0";  
     
    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString();        
     }  
  
     if (request.getParameter("clProcesoCivil")!= null)
      	{
            StrclProcesoCivil= request.getParameter("clProcesoCivil").toString(); 
       	}  
    

    StringBuffer StrSql = new StringBuffer();
    StrSql.append(" Select clProcesoCivil,clExpediente,");
    StrSql.append("coalesce(NoJuzgado,'') NoJuzgado,");
    StrSql.append("coalesce(NoExpediente,'')NoExpediente,");
    StrSql.append("coalesce(FechaDemanda,'')FechaDemanda,");
    StrSql.append("coalesce(Demandante,'')Demandante,");
    StrSql.append("coalesce(Demandado,'')Demandado,");
    StrSql.append("coalesce(MontoDemanda,'0')MontoDemanda,");
    StrSql.append("coalesce(MotivosDemanda,'')MotivosDemanda ");
    StrSql.append("From ProcesoCivil "); 
    StrSql.append(" Where clExpediente =").append(StrclExpediente); 
  
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());     
    StrSql.delete(0,StrSql.length());
        
       %><script>fnOpenLinks()</script><%
        
       StrclPaginaWeb = "600";       
       MyUtil.InicializaParametrosC(600,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
 
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 

       %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","")%>
       <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="ProcesoCivil.jsp?'>"%><%   
       if (rs.next()) { 
            // El siguiente campo llave no se mete con MyUtil.ObjInput 
            %>
            <INPUT id='clProcesoCivil' name='clProcesoCivil' type='hidden' value='<%=rs.getString("clProcesoCivil")%>'>                                 
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>                
                        
            <%=MyUtil.ObjInput("Número de Juzgado","NoJuzgado",rs.getString("NoJuzgado"),false,false,30,80,"",false,false,19)%>
            <%=MyUtil.ObjInput("Número de Expediente","NoExpediente",rs.getString("NoExpediente"),false,false,300,80,"",false,false,19)%>
            <%=MyUtil.ObjInput("Fecha Demanda","FechaDemanda",rs.getString("FechaDemanda"),false,false,30,120,"",false,false,19)%>
            <%=MyUtil.ObjInput("Nombre Demandante","Demandante",rs.getString("Demandante"),false,false,300,120,"",false,false,45)%>
            <%=MyUtil.ObjInput("Nombre Demandado","Demandado",rs.getString("Demandado"),false,false,30,160,"",false,false,45)%>
            <%=MyUtil.ObjInput("Monto Demanda","MontoDemanda",rs.getString("MontoDemanda"),false,false,300,160,"",false,false,45)%>
            <%=MyUtil.ObjTextArea("Motivo de la Demanda","MotivoDema",rs.getString("MotivosDemanda"),"90","4",true,true,30,200,"",true,true)%>            
            <%=MyUtil.DoBlock("Datos Generales del Proceso Civil",70,20)%>
        
 <%            
       } 
       else { 
            %><script>document.all.btnCambio.disabled=true;</script>
            <INPUT id='clProcesoCivil' name='clProcesoCivil' type='hidden' value='0'>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjInput("Número de Juzgado","NoJuzgado","",false,false,30,80,"",false,false,19)%>
            <%=MyUtil.ObjInput("Número de Expediente","NoExpediente","",false,false,300,80,"",false,false,19)%>
            <%=MyUtil.ObjInput("Fecha Demanda","FechaDemanda","",false,false,30,120,"",false,false,19)%>
            <%=MyUtil.ObjInput("Nombre Demandante","Demandante","",false,false,300,120,"",false,false,45)%>
            <%=MyUtil.ObjInput("Nombre Demandado","Demandado","",false,false,30,160,"",false,false,45)%>
            <%=MyUtil.ObjInput("Monto Demanda","MontoDemanda","",false,false,300,160,"",false,false,45)%>
            <%=MyUtil.ObjTextArea("Motivo de la Demanda","MotivoDema","","90","4",true,true,30,200,"",true,true)%>            
            <%=MyUtil.DoBlock("Datos Generales del Proceso Civil",70,20)%>

<%       }   %> 
        <%=MyUtil.DoBlock("Proceso Civil",150,30)%>
        <%=MyUtil.GeneraScripts()%><%    
        rs.close();
        rs=null;
        StrclExpediente = null;    
        StrSql = null; 
        StrclPaginaWeb=null;  
        StrclUsrApp=null;
        StrclProcesoCivil=null;
 %>
<input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>  
</body>
</html>

