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
<script src='../../Utilerias/UtilMask.js' ></script>
<script src='../../Utilerias/UtilDireccion.js'></script>
<%  
    com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
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
    String StrclExpConcluido = "0";   
    String StrclPaginaWeb="0";
    String StrFecha ="";   
    String StrRFCInfo ="";   
    String StrLugNacInfo ="";       
    String StrclInfoCard ="";

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
    
    if (rs2.next())  { }
    else
     { %>
          El expediente no existe
          <%
          rs2.close();
          rs2=null;
          StrclExpediente = null;   
          StrclExpConcluido = null;   
          StrSql = null; 
          StrclPaginaWeb=null;
          StrFecha =null;   
          StrRFCInfo =null;   
          StrLugNacInfo =null; 
          StrclInfoCard=null;
          StrclUsrApp=null;      
          
          return;      
     } 

    StrSql.append("Select clExpediente from Seguimiento where clExpediente=" + StrclExpediente + " and clEstatus=10");
    ResultSet rs3 = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
    
    if (rs3.next()){
       StrclExpConcluido = rs3.getString("clExpediente");
    }
    if (StrclExpConcluido.equals(StrclExpediente))
    { %>
        El expediente ya está concluido
        <%
        rs2.close();
        rs2=null;        
        rs3.close();
        rs3=null;
        StrclExpediente = null;   
        StrclExpConcluido = null;   
        StrSql = null; 
        StrclPaginaWeb=null;
        StrFecha =null;   
        StrRFCInfo =null;   
        StrLugNacInfo =null; 
        StrclInfoCard=null;
        StrclUsrApp=null;      
        
        return;
    }
        
    StrSql.append("Select I.clInfoCard as clInfoC, I.clExpediente, ");
    StrSql.append(" coalesce(I.RFC,'') RFC, ");
    StrSql.append(" coalesce(ENac.dsEntFed,'') as dsEntFedNac, I.CodEntNacimiento ");
    StrSql.append(" From InfoCard I ");
    StrSql.append(" inner join cEntFed ENac ON (ENac.CodEnt=I.CodEntNacimiento) ");
    StrSql.append(" Where I.clExpediente=").append(StrclExpediente);

    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
        %>
       <script>fnOpenLinks()</script>
       <%
       StrclPaginaWeb = "380";       
       MyUtil.InicializaParametrosC(380,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
 
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %>
       <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
      <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="InfocardRegistro.jsp?'>"%>
       <%
       if (rs.next()) {  
            // El siguiente campo llave no se mete con MyUtil.ObjInput 
           %>
            <script>document.all.btnAlta.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <INPUT id='StrRFC' name='StrRFC' type='hidden' value='<%=StrRFCInfo%>'>
            <INPUT id='StrLugNac' name='StrLugNac' type='hidden' value='<%=StrLugNacInfo%>'>
            <INPUT id='clInfoCard' name='clInfoCard' type='hidden' value='<%=StrclInfoCard%>'>
            <%
            StrRFCInfo =rs.getString("RFC");   
            StrclInfoCard=rs.getString("clInfoC");
            StrLugNacInfo =rs.getString("CodEntNacimiento");
            %>
            <%=MyUtil.ObjInput(i18n.getMessage("message.title.rfc"),"RFC",StrRFCInfo,true,true,30,80,"",true,true,20)%>
            <%=MyUtil.ObjComboC("Lugar de Nacimiento","CodEntNacimiento",rs.getString("dsEntFedNac"),true,true,350,80,"","Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","","",70,true,true)%>
          <%
            session.setAttribute("RFCInfo",StrRFCInfo);
            session.setAttribute("LugNacInfo",StrLugNacInfo);
            session.setAttribute("InfoCard",StrclInfoCard);
            %>
            <%=MyUtil.DoBlock("Claves de Seguridad",180,0)%>
            <%
      } 
       else { 
            // El siguiente campo llave no se mete con MyUtil.ObjInput 
           %>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <INPUT id='StrRegFed' name='StrRegFed' type='hidden' value=''>
            <INPUT id='StrLugar' name='StrLugar' type='hidden' value=''>
            <INPUT id='clInfoCard' name='clInfoCard' type='hidden' value=''>
            <%
            session.setAttribute("RFCInfo","");
            session.setAttribute("LugNacInfo","");
            session.setAttribute("InfoCard","");
            session.setAttribute("clNUInfoCard","0");
            %>
            <%=MyUtil.ObjInput(i18n.getMessage("message.title.rfc"),"RFC","",true,true,30,80,"",true,true,20)%>
           <%=MyUtil.ObjComboC("Lugar de Nacimiento","CodEntNacimiento","",true,true,350,80,"","Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","","",70,true,true)%>
           <%=MyUtil.DoBlock("Claves de Seguridad",180,0)%>
            <%
       }  
        rs2.close();
        rs3.close();
        rs.close();
        rs2=null;
        rs3=null;
        rs=null;
        StrclExpediente = null;   
        StrclExpConcluido = null;   
        StrSql = null; 
        StrclPaginaWeb=null;
        StrFecha =null;   
        StrRFCInfo =null;   
        StrLugNacInfo =null;
        StrclInfoCard=null;
        StrclUsrApp=null;      
        
%>
          <%=MyUtil.GeneraScripts()%>
<script>
     document.all.RFC.maxLength=20; 
</script>
</body>
</html>
