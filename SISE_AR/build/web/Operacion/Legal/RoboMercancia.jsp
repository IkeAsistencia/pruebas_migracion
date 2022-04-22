<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Robo a Comercio y/o Casa Habitacion</title>
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
    String StrclPaginaWeb="0";
    String StrCodEnt="";
    String StrdsGerencia="";
     
    if (session.getAttribute("clExpediente")!= null) 
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     }  
    
        StringBuffer StrSql = new StringBuffer();
        
        StrSql.append(" Select E.TieneAsistencia,E.CodEnt ");
        StrSql.append(" From Expediente E");
        StrSql.append(" Where E.clExpediente=").append(StrclExpediente);
        
    ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());     
    StrSql.delete(0,StrSql.length());
    
    if (rs2.next())  
     { 
         StrCodEnt = rs2.getString("CodEnt");
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
          StrCodEnt=null;
          StrdsGerencia=null;
          StrclUsrApp=null;
          return;      
     } 
    
    
     StrSql.append(" Select ge.clgerenciareg, gr.dsgerencia from gciaregxentidad ge ");
     StrSql.append(" left join cgerenciaregional gr on (gr.clgerenciareg=ge.clgerenciareg)");
     StrSql.append(" where ge.codEnt ='").append(StrCodEnt).append("'");
     
     ResultSet rs5 = UtileriasBDF.rsSQLNP( StrSql.toString());  
     StrSql.delete(0,StrSql.length());
    
     if (rs5.next()){
        StrdsGerencia = rs5.getString("dsgerencia");
     }
    
      
    StrSql.append(" Select");
    StrSql.append(" coalesce(D.dsDelito,'') as dsDelito,");
    StrSql.append(" coalesce(RM.LugarRobo,'') as LugarRobo,");
    StrSql.append(" coalesce(RM.NombreTienda,'') as NombreTienda,");
    StrSql.append(" coalesce(RM.Foraneo,'') as Foraneo,");
    StrSql.append(" coalesce(TC.dsContacto,'') as dsContacto,");
    StrSql.append(" coalesce(RM.MercanciaRobada,'') as MercanciaRobada,");
    StrSql.append(" coalesce(RM.MontoRobado,'') as MontoRobado,");
    StrSql.append(" coalesce(EM.dsEstatus,'') as dsEstatus,");
    StrSql.append(" coalesce(convert(varchar(16),RM.FechaRecupMerc,120),'') as FechaRecupMerc,");
    StrSql.append(" coalesce(convert(varchar(16),RM.FechaEntregaMerc,120),'') as FechaEntregaMerc,");
    StrSql.append(" coalesce(RM.PersonaContacto,'') as PersonaContacto,");
    StrSql.append(" coalesce(RM.ProbableResponsable,'') as ProbableResponsable,");
    StrSql.append(" coalesce(SR.DescripcionSituacion,'') as DescripcionSituacion,");
    StrSql.append(" coalesce(RM.AveriguacionPrev,'') as AveriguacionPrev,");
    StrSql.append(" coalesce(EF.dsEntFed,'') as dsEntFed,");
    StrSql.append(" coalesce(MD.dsMunDel,'') as dsMunDel,");
    StrSql.append(" coalesce(RM.CodMDRobo,'') as CodMDRobo,");
    StrSql.append(" coalesce(RM.AgenciaMP,'') as AgenciaMP,");
    StrSql.append(" coalesce(RM.Juzgado,'') as Juzgado,");
    StrSql.append(" coalesce(RM.CausaPenal,'') as CausaPenal,");
    StrSql.append(" coalesce(convert(varchar(16),RM.FechaApertura,120),'') as FechaApertura,");
    StrSql.append(" coalesce(convert(varchar(16),RM.FechaRegistro,120),'') as FechaRegistro");
    StrSql.append(" From RoboMercancia RM");
    StrSql.append(" Left Join cDelitosEspeciales D ON (RM.clDelito=D.clDelito)");
    StrSql.append(" Left Join cTipoContactoLegal TC ON (RM.clTipoContacto=TC.clTipoContacto)");
    StrSql.append(" Left Join cEstatusMercancia EM ON (RM.clEstatusMercan=EM.clEstatus)");
    StrSql.append(" Left Join cSituacionResp SR ON (RM.clSituacionResp=SR.clSituacionResp)");
    StrSql.append(" Left Join cMundel MD on (RM.CodEntRobo=MD.CodEnt and RM.CodMDRobo=MD.CodMD)");
    StrSql.append(" Left Join cEntFed EF on (RM.CodEntRobo=EF.CodEnt)");
    StrSql.append(" Where clExpediente=").append(StrclExpediente);
    
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
    
        ResultSet rs4 = UtileriasBDF.rsSQLNP( "Select convert(varchar(19),getdate(),120) fechaEt ");  
        if (rs4.next()){}  
               
        %>
       <script>fnOpenLinks()</script>
       <%
       StrclPaginaWeb = "328";       
       MyUtil.InicializaParametrosC(328,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %>
       <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
      <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="RoboMercancia.jsp?'>"%>
       <%
       if (rs.next()) {
           %>
            <script>document.all.btnAlta.disabled=true;</script>
            <script>document.all.btnElimina.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

            <%=MyUtil.ObjComboC("Delito","clDelito",rs.getString("dsDelito"),true,true,30,70,"","Select clDelito,dsDelito from cDelitosEspeciales where clSubServicio=283","","",30,true,true)%>
            <%=MyUtil.ObjInput("Lugar donde ocurrio el robo","LugarRobo",rs.getString("LugarRobo"),true,true,280,70,"",true,true,40)%>
            <%=MyUtil.ObjInput("Nombre de la tienda","NombreTienda",rs.getString("NombreTienda"),true,true,520,70,"",true,true,40)%>
            <%=MyUtil.ObjChkBox("Foraneo","Foraneo",rs.getString("Foraneo"), true,true,30,110,"1","Foraneo","Local","")%>
            <%=MyUtil.ObjComboC("Tipo de Contacto","clTipoContacto",rs.getString("dsContacto"),true,true,150,110,"","Select clTipoContacto,dsContacto from cTipoContactoLegal","","",30,true,true)%>
            <%=MyUtil.ObjTextArea("Descripción de la mercancia robada","MercanciaRobada",rs.getString("MercanciaRobada"),"80","3",true,true,330,110,"",true,true)%>
            <%=MyUtil.ObjInput("Monto de lo Robado","MontoRobado",rs.getString("MontoRobado"),true,true,30,190,"",true,true,10,"EsNumerico(document.all.MontoRobado)")%>
            <%=MyUtil.ObjComboC("Estatus de la Mercancia","clEstatusMercan",rs.getString("dsEstatus"),true,true,180,190,"","Select clEstatus,dsEstatus from cEstatusMercancia","","",30,true,true)%>
            <%=MyUtil.ObjInput("Fecha de recuperacion<br>aaaa/mm/dd hh:mm","FechaRecupMerc",rs.getString("FechaRecupMerc"),true,true,380,180,"",true,true,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaSiniestroMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Fecha de entrega a tienda<br>aaaa/mm/dd hh:mm","FechaEntregaMerc",rs.getString("FechaEntregaMerc"),true,true,570,180,"",true,true,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaSiniestroMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Persona con quien se Contacta","PersonaContacto",rs.getString("PersonaContacto"),true,true,30,240,"",true,true,40)%>
            <%=MyUtil.ObjInput("Nombre del probable responsable","ProbableResponsable",rs.getString("ProbableResponsable"),true,true,270,240,"",true,true,40)%>
            <%=MyUtil.ObjComboC("Situacion del probable responsable","clSituacionResp",rs.getString("DescripcionSituacion"),true,true,510,240,"","Select clSituacionResp,DescripcionSituacion from cSituacionResp","","",30,true,true)%>
            <%=MyUtil.ObjInput("Averiguacion Previa","AveriguacionPrev",rs.getString("AveriguacionPrev"),true,true,30,290,"",true,true,25)%>
            <%=MyUtil.ObjComboC("Entidad","CodEntRobo",rs.getString("dsEntFed"),true,false,190,290,"","Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","fnLlenaMunicipios()","",70,true,true)%>
            <%=MyUtil.ObjComboC("Municipio","CodMDRobo",rs.getString("dsMunDel"),true,false,400,290,"","Select CodMD,dsMunDel  FROM cMunDel WHERE CodMD='"+ rs.getString("CodMDRobo") +"' Order by dsMunDel","","",160,true,true)%>
            <%=MyUtil.ObjInput("Agencia MP","AgenciaMP",rs.getString("AgenciaMP"),true,true,30,340,"",true,true,25)%>
            <%=MyUtil.ObjInput("Juzgado","Juzgado",rs.getString("Juzgado"),true,true,190,340,"",true,true,25)%>
            <%=MyUtil.ObjInput("Causa Penal","CausaPenal",rs.getString("CausaPenal"),true,true,350,340,"",true,true,25)%>
            <%=MyUtil.ObjInput("Gerencia Regional","clGerenciaRegVTR",StrdsGerencia,false,false,510,340,"",false,false,25)%>
            <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura",rs.getString("FechaApertura"),false,false,30,390,rs4.getString("fechaEt"),true,true,25)%>
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR",rs.getString("FechaRegistro"),false,false,190,390,"",false,false,25)%>
            <%=MyUtil.DoBlock("Robo de Mercancia",80,10)%>
           <% 
      } 
      else {
          %>
            <script>document.all.btnCambio.disabled=true;</script>
            <script>document.all.btnElimina.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            
            <%=MyUtil.ObjComboC("Delito","clDelito","",true,true,30,70,"","Select clDelito,dsDelito from cDelitosEspeciales where clSubServicio=283","","",30,true,true)%>
            <%=MyUtil.ObjInput("Lugar donde ocurrio el robo","LugarRobo","",true,true,280,70,"",true,true,40)%>
            <%=MyUtil.ObjInput("Nombre de la tienda","NombreTienda","",true,true,520,70,"",true,true,40)%>
            <%=MyUtil.ObjChkBox("Foraneo","Foraneo","", true,true,30,110,"1","Foraneo","Local","")%>
            <%=MyUtil.ObjComboC("Tipo de Contacto","clTipoContacto","",true,true,150,110,"","Select clTipoContacto,dsContacto from cTipoContactoLegal","","",30,true,true)%>
            <%=MyUtil.ObjTextArea("Descripción de la mercancia robada","MercanciaRobada","","80","3",true,true,330,110,"",true,true)%>
            <%=MyUtil.ObjInput("Monto de lo Robado","MontoRobado","",true,true,30,190,"",true,true,10,"EsNumerico(document.all.MontoRobado)")%>
            <%=MyUtil.ObjComboC("Estatus de la Mercancia","clEstatusMercan","",true,true,180,190,"","Select clEstatus,dsEstatus from cEstatusMercancia","","",30,true,true)%>
            <%=MyUtil.ObjInput("Fecha de recuperacion<br>aaaa/mm/dd hh:mm","FechaRecupMerc","",true,true,380,180,"",true,true,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaSiniestroMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Fecha de entrega a tienda<br>aaaa/mm/dd hh:mm","FechaEntregaMerc","",true,true,570,180,"",true,true,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaSiniestroMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Persona con quien se Contacta","PersonaContacto","",true,true,30,240,"",true,true,40)%>
            <%=MyUtil.ObjInput("Nombre del probable responsable","ProbableResponsable","",true,true,270,240,"",true,true,40)%>
            <%=MyUtil.ObjComboC("Situacion del probable responsable","clSituacionResp","",true,true,510,240,"","Select clSituacionResp,DescripcionSituacion from cSituacionResp","","",30,true,true)%>
            <%=MyUtil.ObjInput("Averiguacion Previa","AveriguacionPrev","",true,true,30,290,"",true,true,25)%>
            <%=MyUtil.ObjComboC("Entidad","CodEntRobo","",true,false,190,290,"","Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","fnLlenaMunicipios()","",70,true,true)%>
            <%=MyUtil.ObjComboC("Municipio","CodMDRobo","",true,false,400,290,"","Select CodMD, dsMunDel From cMunDel Where CodEnt='DF' Order by dsMunDel","","",160,true,true)%>
            <%=MyUtil.ObjInput("Agencia MP","AgenciaMP","",true,true,30,340,"",true,true,25)%>
            <%=MyUtil.ObjInput("Juzgado","Juzgado","",true,true,190,340,"",true,true,25)%>
            <%=MyUtil.ObjInput("Causa Penal","CausaPenal","",true,true,350,340,"",true,true,25)%>
            <%=MyUtil.ObjInput("Gerencia Regional","clGerenciaRegVTR",StrdsGerencia,false,false,510,340,StrdsGerencia,false,false,25)%>
            <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura","",false,false,30,390,rs4.getString("fechaEt"),true,true,25)%>
            <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR","",false,false,190,390,"",false,false,25)%>

            <%=MyUtil.DoBlock("Robo de Mercancia",80,10)%>
            <%
      }
        rs5.close();
        rs2.close();
        rs4.close();
        rs.close();
        rs5=null;
        rs2=null;
        rs4=null;
        rs=null;
        StrclExpediente = null;   
        StrSql = null; 
        StrclPaginaWeb=null;
        StrCodEnt=null;
        StrdsGerencia=null;
        StrclUsrApp=null;
        
%>
        <%=MyUtil.GeneraScripts()%>

<input name='FechaSiniestroMsk' id='FechaSiniestroMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
<script>
document.all.PersonaContacto.maxLength=100; 
document.all.ProbableResponsable.maxLength=100; 
document.all.AveriguacionPrev.maxLength=50; 
document.all.AgenciaMP.maxLength=50; 
document.all.Juzgado.maxLength=50; 
document.all.CausaPenal.maxLength=50; 

function fnLlenaMunicipios(){  
		var strConsulta = "sp_GetMunicipios '" + document.all.CodEntRobo.value + "'";
		var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                document.all.CodMDRobo.value = '';
		pstrCadena = pstrCadena + "&strName=CodMDRoboC";		
		fnOptionxDefault('CodMDRoboC',pstrCadena);
	}
</script>
</body>
</html>
