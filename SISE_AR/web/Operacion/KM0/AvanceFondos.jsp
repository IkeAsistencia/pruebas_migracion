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
<script src='../../Utilerias/UtilDireccion.js' ></script>
<script src='../../Utilerias/UtilMask.js'></script> 
<%  
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
    String StrclUsrApp="0";
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)
     {%>
       Fuera de Horario
       <% 
       
       StrclUsrApp=null;
       return;  
     }    
    String StrclExpediente = "0";
    String StrclPaginaWeb="0";
    String StrFecha ="";

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
    
    if (rs2.next())
     {
     }
    else
     { %>
          El expediente no existe
          <%
          rs2.close();
          rs2=null;
          StrclExpediente = null;   
          StrSql = null; 
          StrclPaginaWeb=null;
          StrFecha =null;    
          StrclUsrApp=null;
          
          return;      
     } 
   
  StrSql.append(" Select clAvanceFondo, coalesce(A.PersonaaContactar,'') as PersonaaContactar, ");
  StrSql.append(" coalesce(CP.dsParentesco,'') as dsParentesco, ");
  StrSql.append(" coalesce(PA.dsPais,'') as dsPais, ");
  StrSql.append(" coalesce(CI.dsCiudad,'') as dsCiudad, ");
  StrSql.append(" coalesce(PA.clPais,'') as clPais, ");
  StrSql.append(" coalesce(A.CalleNum,'') as CalleNum, coalesce(A.Referencias,'') as Referencias, ");
  StrSql.append(" coalesce(A.Lada1,'') as Lada1, coalesce(A.Telefono1,'') as Telefono1, ");
  StrSql.append(" coalesce(A.Lada2,'') as Lada2, coalesce( A.Telefono2,'') as Telefono2, ");
  StrSql.append(" coalesce(A.Monto,'') as Monto, coalesce(TM.dsTipoMoneda,'') as dsTipoMoneda  ");
  StrSql.append(" From AvanceFondo A ");
  StrSql.append(" left join cparentesco CP ON (CP.clParentesco=A.clParentesco) ");
  StrSql.append(" left join cPais PA ON (PA.clPais=A.clPais) ");
  StrSql.append(" left join cCiudad CI ON (CI.clCiudad=A.clCiudad) ");
  StrSql.append(" left join cTipomoneda TM ON (TM.clTipoMoneda=A.clTipoMoneda) ");
  StrSql.append(" Where A.clExpediente =").append(StrclExpediente);
  
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
     %>
       <script>fnOpenLinks()</script>
       <%
       StrclPaginaWeb = "379";
       MyUtil.InicializaParametrosC(379,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
       %>
       
       <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
    <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="AvanceFondos.jsp?'>"%>

    <%
      if (rs.next()) {  
          %>
           <script>document.all.btnAlta.disabled=true;</script>
           <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
           <INPUT id='clAvanceFondo' name='clAvanceFondo' type='hidden' value='<%=rs.getString("clAvanceFondo")%>'>
            <%=MyUtil.ObjInput("Persona a Contactar","PersonaaContactar",rs.getString("PersonaaContactar"),true,true,30,70,"",true,true,75)%>
            <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco",rs.getString("dsParentesco"),true,true,430,70,"","Select clParentesco, dsParentesco From cParentesco ","","",100,true,true)%>
            <%=MyUtil.ObjComboC("País de su Ubicación Actual","clPais",rs.getString("dsPais"),true,true,30,110,"","Select clPais, dsPais From cPais Order by dsPais","fnLlenaCiudades()","",70,true,true)%>
            <%=MyUtil.ObjComboC("Ciudad de su Ubicación Actual","clCiudad",rs.getString("dsCiudad"),true,true,430,110,"","Select clCiudad, dsCiudad From cCiudad Where clPais=" + rs.getString("clPais") + " Order by dsCiudad","","",60,false,false)%>
            <%=MyUtil.ObjInput("Calle Y Numero","CalleNum",rs.getString("CalleNum"),true,true,30,150,"",true,true,75)%>
            <%=MyUtil.ObjTextArea("Referencias","Referencias",rs.getString("Referencias"),"75","4",true,true,30,190,"",true,true)%>
            <%=MyUtil.ObjInput(i18n.getMessage("message.title.lada") + "1","Lada1",rs.getString("Lada1"),true,true,30,275,"",true,true,5)%>
            <%=MyUtil.ObjInput("Telefono1","Telefono1",rs.getString("Telefono1"),true,true,80,275,"",true,true,20)%>
            <%=MyUtil.ObjInput(i18n.getMessage("message.title.lada") + "2","Lada2",rs.getString("Lada2"),true,true,210,275,"",false,false,5)%>
            <%=MyUtil.ObjInput("Telefono2","Telefono2",rs.getString("Telefono2"),true,true,260,275,"",false,false,20)%>
            <%=MyUtil.ObjInput("Monto a Entregar","Monto",rs.getString("Monto"),true,true,30,320,"",true,true,20,"EsNumerico(document.all.Monto)")%>
            <%=MyUtil.ObjComboC("Tipo de Moneda","clTipoMoneda",rs.getString("dsTipoMoneda"),true,true,200,320,"","Select clTipoMoneda, dsTipoMoneda From ctipomoneda","","",70,false,false)%>
            <%=MyUtil.DoBlock("Detalle de Avance de Fondos",150,0)%>
            <%
      }
       else {
           %>
           <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjInput("Persona a Contactar","PersonaaContactar","",true,true,30,70,"",true,true,75)%>
            <%=MyUtil.ObjComboC("Parentesco con N/U","clParentesco","",true,true,430,70,"","Select clParentesco, dsParentesco From cParentesco ","","",100,true,true)%>
            <%=MyUtil.ObjComboC("País de su Ubicación Actual","clPais","",true,true,30,110,"","Select clPais, dsPais From cPais Order by dsPais","fnLlenaCiudades()","",70,true,true)%>
            <%=MyUtil.ObjComboC("Ciudad de su Ubicación Actual","clCiudad","",true,true,430,110,"","","","",60,false,false)%>
            <%=MyUtil.ObjInput("Calle Y Numero","CalleNum","",true,true,30,150,"",true,true,75)%>
            <%=MyUtil.ObjTextArea("Referencias","Referencias","","75","4",true,true,30,190,"",true,true)%>
            <%=MyUtil.ObjInput(i18n.getMessage("message.title.lada") + "1","Lada1","",true,true,30,275,"",true,true,5)%>
            <%=MyUtil.ObjInput("Telefono1","Telefono1","",true,true,80,275,"",true,true,20)%>
            <%=MyUtil.ObjInput(i18n.getMessage("message.title.lada") + "2","Lada2","",true,true,210,275,"",false,false,5)%>
            <%=MyUtil.ObjInput("Telefono2","Telefono2","",true,true,260,275,"",false,false,20)%>
            <%=MyUtil.ObjInput("Monto a Entregar","Monto","",true,true,30,320,"",true,true,20,"EsNumerico(document.all.Monto)")%>
            <%=MyUtil.ObjComboC("Tipo de Moneda","clTipoMoneda","",true,true,200,320,"","Select clTipoMoneda, dsTipoMoneda From ctipomoneda","","",70,false,false)%>
            <%=MyUtil.DoBlock("Detalle de Avance de Fondos",150,0)%>
            <%
            
       }    rs.close();
            rs=null;
            StrclExpediente = null;   
            StrSql = null; 
            StrclPaginaWeb=null;
            StrFecha =null;    
            StrclUsrApp=null;
            
            %>
    <%=MyUtil.GeneraScripts()%>
<input name='FechaDescesoMsk' id='FechaDescesoMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
<script>
     document.all.PersonaaContactar.maxLength=60; 
     document.all.CalleNum.maxLength=60;   
     document.all.Referencias.maxLength=255;
     document.all.Lada1.maxLength=5;   
     document.all.Telefono1.maxLength=20; 
     document.all.Lada2.maxLength=5;   
     document.all.Telefono2.maxLength=20; 
</script>
</body>
</html>