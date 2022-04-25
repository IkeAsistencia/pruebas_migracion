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
    String StrclExpediente="0";    
    String StrclPaginaWeb="0";
    String StrFecha ="";   
    String StrclNUInfoCard ="0";       
    String StrclInfoConfidencial = "0";   
    //String StrclRFC2 = "";     
    String StrclInfoCard =""; 
    
    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     }  
    if (session.getAttribute("clNUInfoCard")!= null)
     {
       StrclNUInfoCard = session.getAttribute("clNUInfoCard").toString(); 
     } 
    if (request.getParameter("clInfoConfidencial")!= null)   //expediente viene como parámetro aqui
     {
       StrclInfoConfidencial = request.getParameter("clInfoConfidencial").toString();
     }         
    if (session.getAttribute("InfoCard")!= null)
     {
       StrclInfoCard = session.getAttribute("InfoCard").toString(); 
     }     
    StringBuffer StrSql = new StringBuffer();    
    
    StrSql.append(" Select clNUInfoCard from NUInfoCard Where clInfoCard ='").append(StrclInfoCard).append("'");
    
    
    ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());  
    StrSql.delete(0,StrSql.length());  
    
    if (rs2.next()){   
    
    }    
    else {
    out.println("<script>  alert ('Necesita Informar Datos Generales INFOCARD'); </script>");
    out.println("<script>location.href='InfocardNU.jsp?';</script>");
    }
    
    StrSql.append("Select  I.clInfoConfidencial, I.clNUInfoCard,");
    StrSql.append(" coalesce(TI.dsInformacion,'') dsInformacion, I.clTipoInformacionResg, ");
    StrSql.append(" coalesce(I.Institucion,'') as Institucion, ");
    StrSql.append(" coalesce(I.SerieDoc,'') as SerieDoc ");
    StrSql.append(" From InfoConfidencial I ");
    StrSql.append(" inner join cTipoInformacionResg TI ON (TI.clTipoInformacionResg=I.clTipoInformacionResg) ");
    StrSql.append(" Where I.clInfoConfidencial =").append(StrclInfoConfidencial);

    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
        %>
       <script>fnOpenLinks()</script>
       <%
       StrclPaginaWeb = "381";       
       MyUtil.InicializaParametrosC(381,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
 
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %>
       <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","")%>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="InfoConfRegistro.jsp?'>"%>
       <%
       if (rs.next()) { 
            // El siguiente campo llave no se mete con MyUtil.ObjInput 
           %>
            <INPUT id='clInfoConfidencial' name='clInfoConfidencial' type='hidden' value='<%=StrclInfoConfidencial%>'>
            <INPUT id='clNUInfoCard' name='clNUInfoCard' type='hidden' value='<%=StrclNUInfoCard%>'>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

            <%=MyUtil.ObjComboC("Información Resguardada","clTipoInformacionResg",rs.getString("dsInformacion"),true,true,30,70,"","Select clTipoInformacionResg, dsInformacion From cTipoInformacionResg Order by dsInformacion","","",70,true,true)%>
            <%=MyUtil.ObjInput("Institución","Institucion",rs.getString("Institucion"),true,true,30,110,"",true,true,100)%>
            <%=MyUtil.ObjInput("Serie Documento","SerieDoc",rs.getString("SerieDoc"),true,true,550,110,"",true,true,35)%>
            <%=MyUtil.DoBlock("Información Confidencial",20,0)%>
            <%

      } 
       else { 
            // El siguiente campo llave no se mete con MyUtil.ObjInput 
           %>
            <INPUT id='clInfoConfidencial' name='clInfoConfidencial' type='hidden' value=''>
            <INPUT id='clNUInfoCard' name='clNUInfoCard' type='hidden' value='<%=StrclNUInfoCard%>'>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

            <%=MyUtil.ObjComboC("Información Resguardada","clTipoInformacionResg","",true,true,30,70,"","Select clTipoInformacionResg, dsInformacion From cTipoInformacionResg Order by dsInformacion","","",70,true,true)%>
            <%=MyUtil.ObjInput("Institución","Institucion","",true,true,30,110,"",true,true,100)%>
            <%=MyUtil.ObjInput("Serie Documento","SerieDoc","",true,true,550,110,"",true,true,35)%>
            <%=MyUtil.DoBlock("Información Confidencial",20,0)%>
            <%
       }  
        rs.close();
        rs2.close();
        rs=null;
        rs2=null;
        StrSql = null; 
        StrclExpediente=null;    
        StrclPaginaWeb=null;
        StrFecha =null;   
        StrclNUInfoCard =null;       
        StrclInfoConfidencial = null;   
        StrclUsrApp=null;
        StrclInfoCard=null;
        
%>
        <%=MyUtil.GeneraScripts()%>
<script>
     document.all.Institucion.maxLength=100; 
     document.all.SerieDoc.maxLength=30;   
</script>
</body>
</html>

