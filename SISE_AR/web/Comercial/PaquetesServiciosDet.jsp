<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<script src='../Utilerias/UtilServicio.js' ></script>
<%  
    String StrclPaquete = "0";
    String StrdsPaquete="";
    String StrclUsrApp="0";
    String StrclSubServicio="0";
    String StrclSubservxPaq="0";
    
    if (session.getAttribute("clUsrApp")!= null) 
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    
    

    if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) 
     {%>
       Fuera de Horario
       <%
       
       return;
     } 
    
    if (request.getParameter("clSubservxPaq") != null)
    {
      StrclSubservxPaq = request.getParameter("clSubservxPaq");
    }    


     if (request.getParameter("clPaquete")!= null)
      	{
            StrclPaquete= request.getParameter("clPaquete").toString(); 
       	}  
      if(StrclPaquete.compareToIgnoreCase("0")==0){
            if (session.getAttribute("clPaquete")!= null)
            {
                StrclPaquete= session.getAttribute("clPaquete").toString(); 
            }  
        }
      session.setAttribute("clPaquete",StrclPaquete); 
      
       StringBuffer StrSql2 = new StringBuffer();
        
       StrSql2.append("select P.dsPaquete ");
       StrSql2.append(" From cPaquete P ");
       StrSql2.append(" Where P.clPaquete=").append(StrclPaquete);

       ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql2.toString());
       StrSql2.delete(0,StrSql2.length());
       
       if (rs2.next()) {
           StrdsPaquete=rs2.getString("dsPaquete");
       }
       
       StringBuffer StrSql = new StringBuffer();
       
       StrSql.append("select P.clPaquete, P.dsPaquete, S.dsServicio, SS.dsSubServicio, S.clServicio, SS.clSubServicio,  coalesce(SP.LimiteMonto,'') as LimiteMonto, coalesce(SP.LimiteEventos,'') as LimiteEventos, coalesce(SP.PtosImportantes,'') as PtosImportantes, coalesce(SP.Exclusiones,'') as Exclusiones ");
       StrSql.append(" From SubServicioxPaquete SP Inner Join cPaquete P ON (SP.clPaquete=P.clPaquete) Inner Join cServicio S ON(S.clServicio=SP.clServicio) Inner Join cSubServicio SS ON(SS.clSubServicio=SP.clSubServicio) ");
       StrSql.append(" Where SP.clSubservxPaq=").append(StrclSubservxPaq);
       StrSql.append(" Order By SP.clServicio");

       ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
       StrSql.delete(0,StrSql.length());

       String StrclPaginaWeb = "22";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %>
        <script>fnOpenLinks(window.parent.frames.InfoRelacionada.height) </script>
       <%
       MyUtil.InicializaParametrosC( 22,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       %>
       <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
      <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="PaquetesServiciosDet.jsp?'>"%>
       <%
       if (rs.next()) {
            // El siguiente campo llave no se mete con MyUtil.ObjInput
           %>
            <INPUT id='clPaquete' name='clPaquete' type='hidden' value='<%=StrclPaquete%>'>
            <INPUT id='clSubservxPaq' name='clSubservxPaq' type='hidden' value='<%=StrclSubservxPaq%>'>
            <%=MyUtil.ObjInput("Paquete","dsPaquete",rs.getString("dsPaquete"),false,false,20,80,StrdsPaquete,false,false,73)%>
            <%=MyUtil.ObjComboC("Servicio","clServicio",rs.getString("dsServicio"),true,false,20,120,"","Select clServicio,dsServicio From cServicio Order by dsServicio","fnLlenaSubServiciosPaq()","",60,true,false)%>
            <%=MyUtil.ObjComboC("SubServicio","clSubServicio",rs.getString("dsSubServicio"),true,true,20,160,"","Select clSubServicio, dsSubServicio From cSubServicio Where clServicio=" + rs.getString("clServicio") + " Order by dsSubServicio","","",160,true,false)%>
            <%=MyUtil.ObjInput("Límite Monto","LimiteMonto",rs.getString("LimiteMonto"),true,true,20,200,"",false,false,10,"EsNumerico(document.all.LimiteMonto)")%>
            <%=MyUtil.ObjInput("Límite Eventos","LimiteEventos",rs.getString("LimiteEventos"),true,true,160,200,"",false,false,10,"EsNumerico(document.all.LimiteEventos)")%>
            <%=MyUtil.ObjTextArea("Puntos Importantes","PtosImportantes",rs.getString("PtosImportantes"),"80","7",true,true,20,240,"",false,false)%>
            <%=MyUtil.ObjTextArea("Exclusiones","Exclusiones",rs.getString("Exclusiones"),"80","7",true,true,20,350,"",false,false)%>
            <%
         } 
       else {
           %>
            <INPUT id='clPaquete' name='clPaquete' type='hidden' value='<%=StrclPaquete%>'>
            <INPUT id='clSubservxPaq' name='clSubservxPaq' type='hidden' value='<%=StrclSubservxPaq%>'>
            <%=MyUtil.ObjInput("Paquete","dsPaquete",StrdsPaquete,false,false,20,80,StrdsPaquete,false,true,73)%>
            <%=MyUtil.ObjComboC("Servicio","clServicio","",true,false,20,120,"","Select clServicio, dsServicio From cServicio Order by dsServicio","fnLlenaSubServiciosPaq()","",60,true,false)%>
            <%=MyUtil.ObjComboC("SubServicio","clSubServicio","",true,true,20,160,"","","","",160,true,false)%>
            <%=MyUtil.ObjInput("Límite Monto","LimiteMonto","",true,true,20,200,"",false,false,10,"EsNumerico(document.all.LimiteMonto)")%>
            <%=MyUtil.ObjInput("Límite Eventos","LimiteEventos","",true,true,160,200,"",false,false,10,"EsNumerico(document.all.LimiteEventos)")%>
            <%=MyUtil.ObjTextArea("Puntos Importantes","PtosImportantes","","55","7",true,true,20,240,"",false,false)%>
            <%=MyUtil.ObjTextArea("Exclusiones","Exclusiones","","80","7",true,true,20,350,"",false,false)%>
            <%
        }           
        StrclPaquete=null;
        StrdsPaquete=null;
        StrclUsrApp=null;
        StrclSubServicio=null;
        StrclSubservxPaq=null;
        StrSql2=null;
        StrSql=null;
        rs.close();
        rs=null;
        
        %>
        <%=MyUtil.DoBlock("Subservicios del Paquete",170,100)%>
        <%=MyUtil.GeneraScripts()%>
       <br><br><br><br><br><br><br><br><br><br>
<script>
     document.all.LimiteEventos.maxLength=3;
</script>

 <script>
    function fnSubServicio(){
        location.href='PaquetesServicios.jsp';
    }
 </script>


</body>
</html>
