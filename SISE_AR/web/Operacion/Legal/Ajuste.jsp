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
<script src='../../Utilerias/UtilAuto.js' ></script>

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
    String StrclPaginaWeb="0";
    String StrFecha=""; 
    
    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     }  
    
    StringBuffer StrSql = new StringBuffer();
    StrSql.append("Select TieneAsistencia From Expediente Where clExpediente=").append(StrclExpediente);
    ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
    
    if (rs2.next()) { }    
    else
     {
          %>El expediente no existe<% 
          StrclExpediente=null;   
          StrSql=null; 
          StrclPaginaWeb=null;
          StrFecha=null; 
          StrclUsrApp=null;
          
          return;      
     } 
     rs2.close();
     rs2=null;
    StrSql.append("Select convert(varchar(20),getdate(),120) FechaApertura ");
    ResultSet rs3 = UtileriasBDF.rsSQLNP( StrSql.toString());  
    StrSql.delete(0,StrSql.length());
    if (rs3.next()){ 
       StrFecha = rs3.getString("FechaApertura");
    }    
    
    StrSql.append("Select A.clExpediente, coalesce(A.ClaveAMIS,'') as ClaveAMIS, coalesce(TA.dsTipoAuto,'') as dsTipoAuto, ");
    StrSql.append("coalesce(A.CodigoMarca,'') as CodigoMarca, coalesce(MA.dsMarcaAuto,'') as dsMarcaAuto, ");
    StrSql.append(" coalesce(A.Placas,'') as Placas, coalesce(A.Serie,'') as Serie, ");
    StrSql.append(" coalesce(A.Modelo,'') as Modelo, coalesce(A.Color,'') as Color, ");
    StrSql.append(" coalesce(A.NombreConductor,'') as NombreConductor, coalesce(A.NumSiniestro,'') as NumSiniestro, ");
    StrSql.append(" coalesce(convert(varchar(20), A.FechaApertura,120),'') as FechaApertura, coalesce(convert(varchar(20), A.FechaRegistro,120),'') as FechaRegistro ");
    StrSql.append(" From ");  
    StrSql.append(" Ajuste A ");
    StrSql.append(" left join cTipoAuto TA ON (TA.ClaveAMIS=A.ClaveAMIS and TA.CodigoMarca=A.CodigoMarca) ");
    StrSql.append(" left join cMarcaAuto MA ON (MA.CodigoMarca=A.CodigoMarca) ");    
    StrSql.append(" Where A.clExpediente =").append(StrclExpediente); 
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());    
    StrSql.delete(0,StrSql.length());
        
       %><script>fnOpenLinks()</script><%				
       
       StrclPaginaWeb = "347";       
       MyUtil.InicializaParametrosC(347,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
 
       session.setAttribute("clPaginaWebP",StrclPaginaWeb); 

       %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>         
       <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="Ajuste.jsp?'>"%><%
       if (rs.next()) { 
            // El siguiente campo llave no se mete con MyUtil.ObjInput  
            %><script>document.all.btnAlta.disabled=true;</script>   
              <script>document.all.btnElimina.disabled=true;</script>              
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>  
            <%=MyUtil.ObjComboC("Marca de Auto","CodigoMarca",rs.getString("dsMarcaAuto"),true,true,30,70,"","Select CodigoMarca, dsMarcaAuto From cMarcaAuto Order by dsMarcaAuto","fnLlenaAMIS()","",70,false,false)%>
            <%=MyUtil.ObjInput("Clave AMIS","ClaveAMISVTR",rs.getString("ClaveAMIS"),false,false,190,70,"",false,false,10)%>
            <%=MyUtil.ObjComboC("Tipo de Auto","ClaveAMIS",rs.getString("dsTipoAuto"),true,true,270,70,"","Select ClaveAMIS, dsTipoAuto From cTipoAuto Where CodigoMarca='" + rs.getString("CodigoMarca") + "' Order by dsTipoAuto","fnActualizaAMIS()","",160,false,false)%>
            <%=MyUtil.ObjInput("Modelo","Modelo",rs.getString("Modelo"),true,true,30,110,"",false,false,4,"EsNumerico(document.all.Modelo)")%>
            <%=MyUtil.ObjInput("Patente","Placas",rs.getString("Placas"),true,true,90,110,"",false,false,10)%>
            <%=MyUtil.ObjInput("Color","Color",rs.getString("Color"),true,true,190,110,"",false,false,20)%>
            <%=MyUtil.ObjInput("Serie","Serie",rs.getString("Serie"),true,true,320,110,"",false,false,30)%>
            <%=MyUtil.ObjInput("Número de Siniestro","NumSiniestro",rs.getString("NumSiniestro"),true,true,30,150,"",false,false,20)%>
            <%=MyUtil.ObjInput("Nombre Conductor","NombreConductor",rs.getString("NombreConductor"),true,true,190,150,"",false,false,70)%>
            <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura",rs.getString("FechaApertura"),false,false,30,190,"",true,true,25)%>
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR",rs.getString("FechaRegistro"),false,false,190,190,"",false,true,25)%><%
       } 
       else {  
            %><script>document.all.btnElimina.disabled=true;</script>               
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjComboC("Marca de Auto","CodigoMarca","",true,true,30,70,"","Select CodigoMarca, dsMarcaAuto From cMarcaAuto Order by dsMarcaAuto","fnLlenaAMIS()","",70,false,false)%>
            <%=MyUtil.ObjInput("Clave AMIS","ClaveAMISVTR","",false,false,190,70,"",false,false,10)%>
            <%=MyUtil.ObjComboC("Tipo de Auto","ClaveAMIS","",true,true,270,70,"","","fnActualizaAMIS()","",160,false,false)%>
            <%=MyUtil.ObjInput("Modelo","Modelo","",true,true,30,110,"",false,false,4,"EsNumerico(document.all.Modelo)")%>
            <%=MyUtil.ObjInput("Patente","Placas","",true,true,90,110,"",false,false,10)%>
            <%=MyUtil.ObjInput("Color","Color","",true,true,190,110,"",false,false,20)%>
            <%=MyUtil.ObjInput("Serie","Serie","",true,true,320,110,"",false,false,30)%>
            <%=MyUtil.ObjInput("Número de Siniestro","NumSiniestro","",true,true,30,150,"",false,false,20)%>
            <%=MyUtil.ObjInput("Nombre Conductor","NombreConductor","",true,true,190,150,"",false,false,70)%>
	    <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura","",false,false,30,190,StrFecha,true,true,25)%>                
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR","",false,false,190,190,"",false,true,25)%><%              
        }   %>           
        <%=MyUtil.DoBlock("Datos Vehículo (Ajuste)",100,0)%>     
        <%=MyUtil.GeneraScripts()%><% 
        rs3.close();
        rs.close();
        rs3=null;
        rs=null;
        StrclUsrApp=null;
        StrclExpediente = null;   
        StrSql = null; 
        StrclPaginaWeb=null;
        StrFecha=null; 
        
%>

<script>
     document.all.Modelo.maxLength=4; 
     document.all.Placas.maxLength=7;   
     document.all.Color.maxLength=20;   
     document.all.Serie.maxLength=30;   
     document.all.NumSiniestro.maxLength=20;   
     document.all.NombreConductor.maxLength=70;  
</script>

</body>
</html>


