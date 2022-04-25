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
    String StrclExpediente = "0";   
    String StrCodEnt = " ";     
    String StrclUsrApp="0";
    String StrclPaginaWeb="0";    
    String StrclNUInfoCard="0";  
    String StrclInfocardConsulta= "0";
    String StrQUIEN = "";      
    String StrRFC = "";  
    String StrLugNac = "";      
    String StrNumIntentos="1";  
    
    

    int iNumIntentos=0;  
   
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     }  
    if (request.getParameter("clInfocardConsulta")!= null)   //expediente viene como parámetro aqui
     {
       StrclInfocardConsulta = request.getParameter("clInfocardConsulta").toString();  
     }

    if (session.getAttribute("NumIntentos")!= null)
     {
       StrNumIntentos = session.getAttribute("NumIntentos").toString(); 
     }      
    if (Integer.parseInt(StrNumIntentos)>3)
    {
      session.setAttribute("NumIntentos","1");
      %>
      <script>alert('HA EXCEDIDO EL NÚMERO DE INTENTOS PERMITIDOS');</script>
      <%
      StrclExpediente = null;   
      StrCodEnt = null;     
      StrclUsrApp=null;
      StrclPaginaWeb=null;    
      StrclNUInfoCard=null;  
      StrclInfocardConsulta= null;
      StrQUIEN = null;      
      StrRFC = null;  
      StrLugNac = null;      
      StrNumIntentos=null;  
      
      return; 
    }
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     { %>
       Fuera de Horario
       <%
       StrclExpediente = null;   
       StrCodEnt = null;     
       StrclUsrApp=null;
       StrclPaginaWeb=null;    
       StrclNUInfoCard=null;  
       StrclInfocardConsulta= null;
       StrQUIEN = null;      
       StrRFC = null;  
       StrLugNac = null;      
       StrNumIntentos=null;  
       
       return; 
     }  %>
    <script>fnCloseLinks(window.parent.frames.InfoRelacionada.height) </script>
    <%
    StrclPaginaWeb = "383";       
    MyUtil.InicializaParametrosC(383,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    
    if (request.getParameter("clNUInfoCard")!= null)   //expediente viene como parámetro aqui
     {
       StrclNUInfoCard = request.getParameter("clNUInfoCard").toString();
     }
    if (request.getParameter("StrRegFed")!= null)   //expediente viene como parámetro aqui
     {
       StrRFC = request.getParameter("StrRegFed").toString();
     }
    if (request.getParameter("StrLugar")!= null)   //expediente viene como parámetro aqui
     {
       StrLugNac = request.getParameter("StrLugar").toString(); 
     } 
    
    StringBuffer StrSql = new StringBuffer();
    
    StrSql.append("Select  I.clInfocardConsulta,  ");
    StrSql.append(" coalesce(I.NombreQuienConsulta,'') NombreQuienConsulta,   ");
    StrSql.append(" coalesce(I.Observaciones,'') as Observaciones,  ");
    StrSql.append(" coalesce(convert(varchar(20), I.Fecha,120),'') as Fecha  ");
    StrSql.append(" From InfocardConsulta I ");
    StrSql.append(" Where I.clInfocardConsulta =").append(StrclInfocardConsulta);

    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
        %>
       <script>fnCloseLinks(window.parent.frames.InfoRelacionada.height) </script>
       <%
       StrclPaginaWeb = "383";       
       MyUtil.InicializaParametrosC(383,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
 
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %>
       <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","")%>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="InfocardConsulta.jsp?'>"%>
         <% 
       if (rs.next()) {  
           %>
            <script>fnOpenLinks()</script>
            <script>document.all.btnAlta.disabled=true;</script>
            <INPUT id='clInfocardConsulta' name='clInfocardConsulta' type='hidden' value='<%=StrclInfocardConsulta%>'>
            <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrApp%>'>
            <%=MyUtil.ObjInput("QUIEN CONSULTA","NombreQuienConsulta",rs.getString("NombreQuienConsulta"),true,true,30,80,"",true,true,100)%>
            <%=MyUtil.ObjTextArea("Observaciones","Observaciones",rs.getString("Observaciones"),"80","4",true,true,30,120,"",false,false)%>
            <%=MyUtil.ObjInput("FECHA","fechaVTR",rs.getString("fecha"),false,false,550,80,"",false,false,23)%>
            <%
      } 
       else { 
            // El siguiente campo llave no se mete con MyUtil.ObjInput 
           %>
            <INPUT id='clInfocardConsulta' name='clInfocardConsulta' type='hidden' value=''>
            <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrApp%>'>
             
            <%=MyUtil.ObjInput("QUIEN CONSULTA","NombreQuienConsulta","",true,true,30,80,"",true,true,100)%>
            <%=MyUtil.ObjTextArea("Observaciones","Observaciones","","80","4",true,true,30,120,"",false,false)%>
            <%=MyUtil.ObjInput("FECHA","fechaVTR","",false,false,550,80,"",false,false,23)%>
          <%
       }
        rs.close();
        rs=null;
        StrclExpediente = null;   
        StrSql = null; 
        StrCodEnt = null;     
        StrclUsrApp=null;
        StrclPaginaWeb=null;    
        StrclNUInfoCard=null;  
        StrclInfocardConsulta= null;
        StrQUIEN = null;      
        StrRFC = null;  
        StrLugNac = null;      
        StrNumIntentos=null;  
        
%>
        <%=MyUtil.DoBlock("Consulta de Infocard",-50,30)%>
        <%=MyUtil.GeneraScripts()%>
<script>
     document.all.NombreQuienConsulta.maxLength=80; 
</script>
</body>
</html>
