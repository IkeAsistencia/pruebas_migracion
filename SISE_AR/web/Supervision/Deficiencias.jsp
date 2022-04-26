 <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
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
<script src='../Utilerias/UtilDireccion.js' ></script>
<script src='../Utilerias/UtilMask.js'></script>
<%  
     
    
    String clDeficiencia="0";
   
    String StrclPaginaWeb="0";
    String StrclUsrApp="0";
    String StrclDeficiencia = "0";
    
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {%>
       Fuera de Horario
      <% return;  
     }    
    if (request.getParameter("clDeficiencia")!= null)
     {
       StrclDeficiencia = request.getParameter("clDeficiencia").toString(); 
     } 
    
       
    StringBuffer StrSql = new StringBuffer();
         
      StrSql.append(" select D.dsDeficiencia , AD.dsAreaDefiencia,TD.dsTipoDeficiencia, D.Activa , D.PrefijoDef" );
      StrSql.append(" from cdeficiencias D ");
      StrSql.append(" inner join CAREADEFICIENCIA AD on (D.clAreaDeficiencia=AD.clAreaDeficiencia) ");
      StrSql.append(" inner join CTIPODEFICIENCIA TD on (D.clTipoDeficiencia=TD.clTipoDeficiencia) " );
      StrSql.append(" where clDeficiencia= ").append(StrclDeficiencia);
       ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());    
       StrSql.delete(0,StrSql.length()); 
        %> 
       
       <script>fnOpenLinks()</script>
  
<%     StrclPaginaWeb = "415";        
       MyUtil.InicializaParametrosC(415,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);%> 
       <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","","")%>
       <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1) + "Deficiencias.jsp?"%>'>
         <%
       if (rs.next()) { %>
            
            <INPUT id='clDeficiencia' name='clDeficiencia' type='hidden' value='<%=StrclDeficiencia%>'>
            <%=MyUtil.ObjInput("Deficiencia","dsDeficiencia",rs.getString("dsDeficiencia"),true,true,30,70,"",false,false,120,"")%>
            <%=MyUtil.ObjComboC("área de Deficiencia","clAreaDeficiencia",rs.getString("dsAreaDefiencia"),true,true,30,110,"","Select clAreaDeficiencia, dsAreaDefiencia from CAREADEFICIENCIA","","",140,true,true)%>
            <%=MyUtil.ObjComboC("Tipo de  Deficiencia","clTipoDeficiencia",rs.getString("dsTipoDeficiencia"),true,true,30,150,"","Select clTipoDeficiencia, dsTipoDeficiencia from CTIPODEFICIENCIA","","",140,true,true)%>
            <%=MyUtil.ObjChkBox("Activa","Activa",rs.getString("Activa"), true,true,30,200,"0","Activa","Inactiva","")%>
            <%=MyUtil.ObjInput("PrefijoDef","PrefijoDef",rs.getString("PrefijoDef"),true,true,350,200,"",false,false,20,"")%>
            <%=MyUtil.DoBlock("Catálogo de Deficiencias",150,25)%> 
            
<%           
  
} 
       else {   %>
              <INPUT id='clDeficiencia' name='clDeficiencia' type='hidden' value='<%=StrclDeficiencia%>'>
            <%=MyUtil.ObjInput("Deficiencia","dsDeficiencia","",true,true,30,70,"",false,false,120,"")%>
            <%=MyUtil.ObjComboC("área de Deficiencia","clAreaDeficiencia","",true,true,30,110,"","Select clAreaDeficiencia, dsAreaDefiencia from CAREADEFICIENCIA","","",140,true,true)%>
            <%=MyUtil.ObjComboC("Tipo de  Deficiencia","clTipoDeficiencia","",true,true,30,150,"","Select clTipoDeficiencia, dsTipoDeficiencia from CTIPODEFICIENCIA","","",140,true,true)%>
            <%=MyUtil.ObjChkBox("Activa","Activa","", true,true,30,200,"0","Activa","Inactiva","")%>
            <%=MyUtil.ObjInput("PrefijoDef","PrefijoDef","",true,true,350,200,"",false,false,20,"")%>
            <%=MyUtil.DoBlock("Catálogo de Deficiencias",150,25)%> 
            
<%                      
        }  %>
        <%=MyUtil.GeneraScripts()%>


<input name='FechaSolucionMsk' id='FechaSiniestroMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<script> 

</script>
</body>
</html>