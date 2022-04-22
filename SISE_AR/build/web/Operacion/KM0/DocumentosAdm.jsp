<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<script src='../../Utilerias/UtilMask.js'></script>
<%  
    String StrclUsrApp="0";
    String StrclPaginaWeb="0";
    String StrclExpediente="0";
    String StrclDocumentoADM="0";
    
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }
    
    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     }
    
    if (request.getParameter("clDocumentoADM")!= null)
     {
       StrclDocumentoADM = request.getParameter("clDocumentoADM").toString(); 
     } 

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)  
     {
       %><%="Fuera de Horario"%><%
       StrclUsrApp=null;
       
       return;  
     }   
     
    StringBuffer StrSql1 = new StringBuffer();
    // checar si ya existe asistencia para el expediente, si existe, ya no procede la alta
    StrSql1.append("Select clDocumentoADM," );
    StrSql1.append(" coalesce(TipoDocumento,'') as TipoDocumento, coalesce(Institucion,'') as  Institucion, " );
    StrSql1.append(" coalesce(NoFolio,'') as NoFolio, coalesce(NombreDocumento,'') as NombreDocumento, " );
    StrSql1.append(" coalesce(InfoProporcionada,'')  as InfoProporcionada" ); 
    StrSql1.append(" From ADMDocumento " );
    StrSql1.append(" Where clDocumentoADM =").append(StrclDocumentoADM); 
    
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());
    StrSql1.delete(0,StrSql1.length()); 
       %>
      <script>fnOpenLinks()</script>
       <%
       StrclPaginaWeb = "626";       
       MyUtil.InicializaParametrosC(626,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
       %>
       <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","")%>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DocumentosAdm.jsp?'>"%>
       <%
       if (rs.next()) { 
       %>   
            <script>document.all.btnElimina.disabled=true;</script>
            <INPUT id='clDocumentoADM' name='clDocumentoADM' type='hidden' value='<%=StrclDocumentoADM%>'>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjInput("Tipo de Documento","TipoDocumento",rs.getString("TipoDocumento"),true,true,30,70,"",false,false,50)%>
            <%=MyUtil.ObjInput("Institución Emisora","Institucion",rs.getString("Institucion"),true,true,30,110,"",false,false,50)%>
            <%=MyUtil.ObjInput("Número Documento","NoFolio",rs.getString("NoFolio"),true,true,30,150,"",false,false,30)%>
            <%=MyUtil.ObjInput("Nombre en Documento","NombreDocumento",rs.getString("NombreDocumento"),true,true,30,190,"",false,false,40)%>  
            <%=MyUtil.ObjTextArea("Información Proporcionada ","InfoProporcionada",rs.getString("InfoProporcionada"),"50","4",true,true,30,230,"",false,false)%>
       <%
       }
       else {
       %>
            <script>document.all.btnElimina.disabled=true;</script>
            <INPUT id='clDocumentoADM' name='clDocumentoADM' type='hidden' value='0'>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjInput("Tipo de Documento","TipoDocumento","",true,true,30,70,"",false,false,50)%>
            <%=MyUtil.ObjInput("Institución Emisora","Institucion","",true,true,30,110,"",false,false,50)%>
            <%=MyUtil.ObjInput("Número Documento","NoFolio","",true,true,30,150,"",false,false,30)%>
            <%=MyUtil.ObjInput("Nombre en Documento","NombreDocumento","",true,true,30,190,"",false,false,40)%>  
            <%=MyUtil.ObjTextArea("Información Proporcionada ","InfoProporcionada","","50","4",true,true,30,230,"",false,false)%>
       <%
       }
       %>
        <%=MyUtil.DoBlock("Documento Extraviado",350,30)%>
        <%=MyUtil.GeneraScripts()%>
        <%
        rs.close();
        rs=null;
        StrclExpediente = null;   
        StrclDocumentoADM = null;
        StrSql1 = null; 
        StrclPaginaWeb=null;
        StrclUsrApp=null;
 %>

<script>
  
</script>

</body>
</html>