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
    String StrclDelitoEvento = "0";    
    
    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     }  
    if (request.getParameter("clDelitoEvento") != null)
    {
      StrclDelitoEvento = request.getParameter("clDelitoEvento");
    }    

    StringBuffer StrSql = new StringBuffer();
   
    StrSql.append("select DE.clDelitoEvento, DE.clDelito, case D.Privativo when 1 then coalesce(D.dsDelito,'') else '' end as dsDelitoPriv, case D.Privativo when 0 then coalesce(D.dsDelito,'') else '' end as dsDelitoNoPriv ");
    StrSql.append(" From DelitoEvento DE " );
    StrSql.append(" Inner Join cDelito D ON (DE.clDelito = D.clDelito) " );
    StrSql.append(" Where DE.clDelitoEvento=").append(StrclDelitoEvento);
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());

       String StrclPaginaWeb = "251";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       MyUtil.InicializaParametrosC(251,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       
       %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","")%>
       <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DelitoEvento.jsp?'>"%><%
       
       if (rs.next()) {
            // El siguiente campo llave no se mete con MyUtil.ObjInput
            %><script>document.all.btnAlta.disabled=true;</script>
            <INPUT id='clDelitoEvento' name='clDelitoEvento' type='hidden' value='<%=StrclDelitoEvento%>'>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'> 
            <INPUT id='clDelito' name='clDelito' type='hidden' value='<%=rs.getString("clDelito")%>'>

            <%=MyUtil.ObjComboC("Delito/Queja/Demanda/Denuncia Privativos","clDelitoP",rs.getString("dsDelitoPriv"),true,true,30,120,"","Select clDelito, dsDelito from (Select clDelito, dsDelito From cDelito Where Privativo=1) hh ","fnPrivat(1)","",100,false,false)%>
            <%=MyUtil.ObjComboC("Delito/Queja/Demanda/Denuncia No Privativos","clDelitoNoP",rs.getString("dsDelitoNoPriv"),true,true,30,160,"","Select clDelito, dsDelito from (Select clDelito, dsDelito From cDelito Where Privativo=0) hh ","fnPrivat(2)","",100,false,false)%><%
//            out.println(MyUtil.ObjComboC("Delito/Queja/Demanda/Denuncia No Privativos","clDelitoNoP",rs.getString("dsDelitoNoPriv"),true,true,30,160,"","Select clDelito, dsDelito from (Select clDelito, dsDelito From cDelito Where CodEnt='" + rs2.getString("CodEnt") +  "' and Privativo=0) hh Where hh.clDelito not in(select DE.clDelito From DelitoEvento DE Where DE.clExpediente=" + StrclExpediente + ")","fnPrivat(2)","",100,false,false));
        }
       else { %> 
            <INPUT id='clDelitoEvento' name='clDelitoEvento' type='hidden' value='<%=StrclDelitoEvento%>'>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <INPUT id='clDelito' name='clDelito' type='hidden' value=''>
            <%=MyUtil.ObjComboC("Delito/Queja/Demanda/Denuncia Privativos","clDelitoP","",true,true,30,120,"","Select clDelito, dsDelito from (Select clDelito, dsDelito From cDelito Where Privativo=1) hh Where hh.clDelito not in(select DE.clDelito From DelitoEvento DE Where DE.clExpediente=" + StrclExpediente + ")","fnPrivat(1)","",100,false,false)%>
            <%=MyUtil.ObjComboC("Delito/Queja/Demanda/Denuncia No Privativos","clDelitoNoP","",true,true,30,160,"","Select clDelito, dsDelito from (Select clDelito, dsDelito From cDelito Where Privativo=0) hh Where hh.clDelito not in(select DE.clDelito From DelitoEvento DE Where DE.clExpediente=" + StrclExpediente + ")","fnPrivat(2)","",100,false,false)%><%
         } %>           
          <%=MyUtil.DoBlock("Detalle del Delito del Evento",500,20)%>                         
          <%=MyUtil.GeneraScripts()%><%
          rs.close();
          rs=null;
          StrclUsrApp=null;
          StrclExpediente = null;
          StrclDelitoEvento = null;    
          StrSql = null;
          
%>
<script>
  function fnPrivat(Tipo)
   { 
   if (Tipo=="1")
   {
       document.all.clDelitoNoP.value="0";
       document.all.clDelitoNoPC.value="";
       document.all.clDelito.value=document.all.clDelitoP.value;
   }
   else
   {
      document.all.clDelitoP.value="0";   
      document.all.clDelitoPC.value="";   
      document.all.clDelito.value=document.all.clDelitoNoP.value;
   }
 }
   
</script>
</body>
</html>

