<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
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
<script src='../../Utilerias/UtilMask.js'></script>
<%  
    String StrclUsrApp="0";
    String StrclServicio="0";
    String StrclSubServicio="0";
    String StrclExpediente = "0";   
    String StrclPaginaWeb="0";
    
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    
    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     } 
         
    if (session.getAttribute("clSubServicio")!= null)
     {
        StrclSubServicio = session.getAttribute("clSubServicio").toString(); 
        session.setAttribute("clSubServicio",StrclSubServicio);
     }
     
    if (session.getAttribute("clServicio")!= null)
     {
        StrclServicio = session.getAttribute("clServicio").toString(); 
        session.setAttribute("clServicio",StrclServicio);
     }
     
    StringBuffer StrSql1 = new StringBuffer();
    // checar si ya existe asistencia para el expediente, si existe, ya no procede la alta
        StrSql1.append(" Select exped.TieneAsistencia, ");
        StrSql1.append(" EXPED.CodEnt, E.dsEntFed, EXPED.CodMD, D.dsMunDel, EXPED.clCuenta");
        StrSql1.append(" From Expediente EXPED");
        StrSql1.append(" LEFT JOIN cEntFed E ON(E.CodEnt = EXPED.CodEnt) ");
        StrSql1.append(" LEFT JOIN cMunDel D ON(E.CodEnt = D.CodEnt and D.CodMD=EXPED.CodMD) ");
        StrSql1.append(" Where clExpediente=").append(StrclExpediente);
    ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql1.toString());
    StrSql1.delete(0,StrSql1.length());
    if (rs2.next())  
     { 
        
    StrSql1.append("Select " );
    StrSql1.append(" coalesce(TelContacto,'') as TelContacto, coalesce(TelMovil,'') as TelMovil, " );
    StrSql1.append(" coalesce(dsADMAsesoriaMotivo,'') as dsADMAsesoriaMotivo " );
    StrSql1.append(" From " ); 
    StrSql1.append(" ADMAsesoria A" );
    StrSql1.append(" INNER JOIN ADMcAsesoriaMotivo Mo ON (A.clMotivoAsesoriaAdm=Mo.clADMAsesoriaMotivo) " );
    StrSql1.append(" Where clExpediente =").append(StrclExpediente); 
     
   }   
    else
     {
      %><%="El expediente no existe"%><%
          rs2.close();
          rs2=null;
          StrclExpediente = null;   
          StrclPaginaWeb=null;
          StrclUsrApp=null;
          
          return;      
     } 
     

       StrclPaginaWeb = "624";       
    //   MyUtil.InicializaParametrosC(624,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
       %>   <script>fnOpenLinks()</script>
               <%
       	MyUtil.InicializaParametrosC(624,Integer.parseInt(StrclUsrApp)); 
        %>
       <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
     <%   if(rs2.getString("TieneAsistencia").compareToIgnoreCase("1")==0){%>
        <script>document.all.btnAlta.disabled=true;document.all.btnElimina.disabled=true;</script>
        <%
        }else{%>
        <script>document.all.btnCambio.disabled=true;document.all.btnElimina.disabled=true;</script>
        <%
        }
           ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());
        StrSql1.delete(0,StrSql1.length());  %>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="AsesoriaAdm.jsp?'>"%>
 
<%
       if (rs.next()) { 
       %>
         <INPUT id='clExpediente' name='clExpediente' TYPE='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjInput("Teléfono de Contacto","TelContacto",rs.getString("TelContacto"),true,true,30,70,"",true,true,40)%>
            <%=MyUtil.ObjInput("Teléfono Móvil","TelMovil",rs.getString("TelMovil"),true,true,30,110,"",false,false,40)%>
            <%=MyUtil.ObjComboC("Motivo","clMotivoAsesoriaAdm",rs.getString("dsADMAsesoriaMotivo"),true,true,30,150,"","Select clADMAsesoriaMotivo, dsADMAsesoriaMotivo From ADMcAsesoriaMotivo ","","",40,true,true)%>
               
       <%
       } 
       else {  
       %>    
         <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjInput("Teléfono de Contacto","TelContacto","",true,true,30,70,"",true,true,40)%>
            <%=MyUtil.ObjInput("Teléfono Móvil","TelMovil","",true,true,30,110,"",false,false,40)%>
            <%=MyUtil.ObjComboC("Motivo","clMotivoAsesoriaAdm","",true,true,30,150,"","Select clADMAsesoriaMotivo, dsADMAsesoriaMotivo From ADMcAsesoriaMotivo ","","",40,true,true)%>

   
       <% 
       } 

       %>
        <%=MyUtil.DoBlock("Detalle de Asesoría Administrativa / Información de Trámites",200,0)%>   
   
        <%
        rs2.close();
        rs.close();
        rs2=null;
        rs=null;
        StrclExpediente = null;   
        StrSql1 = null; 
        StrclPaginaWeb=null;
        StrclUsrApp=null;   
 %>
 
 <%=MyUtil.GeneraScripts()%>

<script>
  
</script>

</body>
</html>