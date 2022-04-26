<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Ambulancia</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <%  
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        String StrclUsrApp="0";
        
        
        
        if (session.getAttribute("clUsrApp")!= null)
        {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)
        {
        %>
        Fuera de Horario
        <%
        StrclUsrApp=null;
        return;
        }
        String StrclExpediente = "0";
        String StrclPaginaWeb="0";
        String StrCodEnt="";
        String StrdsGerencia = "";
        String StrFecha = "";
        
        if (session.getAttribute("clExpediente")!= null)
        {
            StrclExpediente = session.getAttribute("clExpediente").toString();
        }
        
        StringBuffer StrSql = new StringBuffer();
        // checar si ya existe asistencia para el expediente, si existe, ya no procede la alta
        StrSql.append(" Select E.TieneAsistencia, CodEnt ");
        StrSql.append(" From Expediente E");
        StrSql.append(" Where E.clExpediente=").append(StrclExpediente);
        
        ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        if (rs2.next())
        {
            StrCodEnt=rs2.getString("CodEnt");
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
        StrdsGerencia = null;
        StrFecha = null;
        StrclUsrApp=null;
        return;
        }
        
        
        StrSql.append(" Select ge.clgerenciareg, gr.dsgerencia from gciaregxentidad ge ");
        StrSql.append(" left join cgerenciaregional gr on (gr.clgerenciareg=ge.clgerenciareg)");
        StrSql.append(" where ge.codEnt ='").append(StrCodEnt).append("'");
        
        ResultSet rs4 = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        if (rs4.next())
        {
            StrdsGerencia = rs4.getString("dsgerencia");
        }
        
        ResultSet rs5 = UtileriasBDF.rsSQLNP( "Select convert(varchar(20),getdate(),120) fechaEt ");
        
        if (rs5.next())
        {
            StrFecha = rs5.getString("fechaEt");
        }
        
        
        StrSql.append("Select coalesce(D.dsDelito,'') as dsDelito, coalesce(R.LugarRobo, '') LugarRobo, coalesce(R.NombreTienda, '') NombreTienda, ");
        StrSql.append(" R.Foraneo as Foraneo, coalesce(TC.dsTipoContacto,'') as dsTipoContacto,  ");
        StrSql.append(" coalesce(R.CargoNoReconocido,'') as CargoNoReconocido, ");
        StrSql.append(" coalesce(R.MontoRobado,'') as MontoRobado,  ");
        StrSql.append(" coalesce(R.PersonaContacto,'') PersonaContacto, ");
        StrSql.append(" coalesce(R.ProbableResponsable,'') ProbableResponsable, ");
        StrSql.append(" coalesce(SR.DescripcionSituacion,'') DescripcionSituacion, ");
        StrSql.append(" coalesce(R.AveriguacionPrev,'') AveriguacionPrev, ");
        StrSql.append(" coalesce(E.dsEntFed,'') dsEntFed, ");
        StrSql.append(" coalesce(M.dsMunDel,'') dsMunDel, ");
        StrSql.append(" coalesce(R.CodMDRobo,'') CodMDRobo, ");
        StrSql.append(" coalesce(R.CodEntRobo,'') CodEntRobo, ");
        StrSql.append(" coalesce(R.AgenciaMP,'') AgenciaMP,  ");
        StrSql.append(" coalesce(R.Juzgado,'') Juzgado, coalesce(R.CausaPenal,'') CausaPenal, coalesce(convert(varchar(20),FechaApertura,120),'') as FechaApertura, coalesce(convert(varchar(19),FechaRegistro,120),'') as FechaRegistro ");
        StrSql.append(" From RoboTarjeta R  ");
        StrSql.append(" Left Join cDelitosEspeciales D ON (R.clDelito = D.clDelito)  ");
        StrSql.append(" Left join ctipocontacto TC on (TC.clTipoContacto=R.clTipoContacto) ");
        StrSql.append(" Left join csituacionresp SR on (SR.clSituacionResp=R.clSituacionResp) ");
        StrSql.append(" Left Join cMundel M on (R.CodEntRobo=M.CodEnt and R.CodMDRobo=M.CodMD)  ");
        StrSql.append(" Left join cEntFed E on (R.CodEntRobo=E.CodEnt) ");
        StrSql.append(" Where R.clExpediente = ").append(StrclExpediente);
        
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        %>
        <script>fnOpenLinks()</script>
        <%
        StrclPaginaWeb = "318";
        MyUtil.InicializaParametrosC(318,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="RoboTarjeta.jsp?'>"%>
        <%
        if (rs.next())
        {  
        %>
        <script>document.all.btnAlta.disabled=true;</script>
        <script>document.all.btnElimina.disabled=true;</script>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        
        <%=MyUtil.ObjComboC("Delito","clDelito",rs.getString("dsDelito"),true,true,30,110,"","Select clDelito, dsDelito From cDelitosEspeciales Where clSubServicio=285","","",50,true,true)%>
        <%=MyUtil.ObjInput("Lugar donde Ocurrió el Robo","LugarRobo",rs.getString("LugarRobo"),true,true,30,170,"",true,true,50)%>
        <%=MyUtil.ObjInput("Nombre de la tienda","NombreTienda",rs.getString("NombreTienda"),true,true,310,170,"",true,true,50)%>
        <%=MyUtil.ObjChkBox("Foraneo","Foraneo",rs.getString("Foraneo"), true,true,30,225,"0","FORANEO","LOCAL","")%>
        <%=MyUtil.ObjComboC("Tipo de Contacto","clTipoContacto",rs.getString("dsTipoContacto"),true,true,130,230,"","Select clTipoContacto, dsTipoContacto From ctipocontacto ","","",30,true,true)%>
        <%=MyUtil.ObjInput("Descripción del Cargo no Reconocido","CargoNoReconocido",rs.getString("CargoNoReconocido"),true,true,310,230,"",true,true,50)%>
        <%=MyUtil.ObjInput("Monto de lo Robado","MontoRobado",rs.getString("MontoRobado"),true,true,600,230,"",true,true,10,"EsNumerico(document.all.MontoRobado)")%>
        <%=MyUtil.ObjInput("Persona con quien se Contacta","PersonaContacto",rs.getString("PersonaContacto"),true,true,30,290,"",true,true,50)%>
        <%=MyUtil.ObjInput("Nombre del probable Responsable","ProbableResponsable",rs.getString("ProbableResponsable"),true,true,310,290,"",false,false,50)%>
        <%=MyUtil.ObjComboC("Situación del Probable Responsable","clSituacionResp",rs.getString("DescripcionSituacion"),true,true,600,290,"","Select clSituacionResp, DescripcionSituacion From csituacionresp ","","",30,true,true)%>
        <%=MyUtil.ObjInput("Averiguación Previa","AveriguacionPrev",rs.getString("AveriguacionPrev"),true,true,30,350,"",true,true,30)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEntRobo",rs.getString("dsEntFed"),true,true,210,350,"","Select CodEnt,dsEntFed From cEntFed Order by dsEntFed","fnLlenaMunicipios()","",70,true,true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMDRobo",rs.getString("dsMunDel"),true,true,400,350,"","Select CodMD,dsMunDel  FROM cMunDel WHERE CodEnt='"+ rs.getString("CodEntRobo") +"' Order by dsMunDel","","",160,true,true)%>
        <%=MyUtil.ObjInput("Agencia del M.P","AgenciaMP",rs.getString("AgenciaMP"),true,true,30,410,"",true,true,30)%>
        <%=MyUtil.ObjInput("Juzgado","Juzgado",rs.getString("Juzgado"),true,true,210,410,"",true,true,30)%>
        <%=MyUtil.ObjInput("Causa Penal","CausaPenal",rs.getString("CausaPenal"),true,true,400,410,"",true,true,30)%>
        <%=MyUtil.ObjInput("Gerencia Regional","GerenciaRegionalVTR",StrdsGerencia,false,false,600,410,"",false,false,30)%>
        <%=MyUtil.ObjInput("Fecha de Apertura<br>(AAAA/MM/DD HH:MM)","FechaApertura",rs.getString("FechaApertura"),false,false,30,470,rs5.getString("fechaEt"),true,true,25)%>
        <%=MyUtil.ObjInput("Fecha de Registro<br>(AAAA/MM/DD HH:MM)","FechaRegistrovtr",rs.getString("FechaRegistro"),false,false,210,470,"",false,false,30)%>
        <%=MyUtil.DoBlock("Robo de Tarjeta",100,0)%>
        <%
        }
        else
        {  
        %>
        <script>document.all.btnCambio.disabled=true;</script>
        <script>document.all.btnElimina.disabled=true;</script>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        
        <%=MyUtil.ObjComboC("Delito","clDelito","",true,true,30,110,"","Select clDelito, dsDelito From cDelitosEspeciales Where clSubServicio=285","","",50,true,true )%>
        <%=MyUtil.ObjInput("Lugar donde Ocurrió el Robo","LugarRobo","",true,true,30,170,"",true,true,50)%>
        <%=MyUtil.ObjInput("Nombre de la tienda","NombreTienda","",true,true,310,170,"",true,true,50)%>
        <%=MyUtil.ObjChkBox("Foraneo","Foraneo","", true,true,30,225,"0","FORANEO","LOCAL","")%>
        <%=MyUtil.ObjComboC("Tipo de contacto","clTipoContacto","",true,true,130,230,"","Select clTipoContacto, dsTipoContacto From ctipocontacto ","","",30,true,true)%>
        <%=MyUtil.ObjInput("Descripción del Cargo no Reconocido","CargoNoReconocido","",true,true,310,230,"",true,true,50)%>
        <%=MyUtil.ObjInput("Monto de lo Robado","MontoRobado","",true,true,600,230,"",true,true,10,"EsNumerico(document.all.MontoRobado)")%>
        <%=MyUtil.ObjInput("Persona con quien se Contacta","PersonaContacto","",true,true,30,290,"",true,true,50)%>
        <%=MyUtil.ObjInput("Nombre del probable Responsable","ProbableResponsable","",true,true,310,290,"",false,false,50)%>
        <%=MyUtil.ObjComboC("situación del Probable Responsable","clSituacionResp","",true,true,600,290,"","Select clSituacionResp, DescripcionSituacion From csituacionresp ","","",30,true,true)%>
        <%=MyUtil.ObjInput("Averiguación Previa","AveriguacionPrev","",true,true,30,350,"",true,true,30)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEntRobo","",true,true,210,350,"","Select CodEnt,dsEntFed from cEntFed order by dsEntFed","fnLlenaMunicipios()","",20,true,true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMDRobo","",true,true,400,350,"","SELECT CodMD,dsMunDel  FROM cMunDel WHERE CodMD='' ORDER BY dsMunDel","","",20,true,true)%>
        
        <%=MyUtil.ObjInput("Agencia del M.P","AgenciaMP","",true,true,30,410,"",true,true,30)%>
        <%=MyUtil.ObjInput("Juzgado","Juzgado","",true,true,210,410,"",true,true,30)%>
        <%=MyUtil.ObjInput("Causa Penal","CausaPenal","",true,true,400,410,"",true,true,30)%>
        <%=MyUtil.ObjInput("Gerencia Regional","GerenciaRegionalVTR",StrdsGerencia,false,false,600,410,StrdsGerencia,false,false,30)%>
        <%=MyUtil.ObjInput("Fecha de Apertura<br>(AAAA/MM/DD HH:MM)","FechaApertura",StrFecha,false,false,30,470,rs5.getString("fechaEt"),true,true,25)%>
        <%=MyUtil.ObjInput("Fecha de Registro<br>(AAAA/MM/DD HH:MM)","FechaRegistrovtr","",false,false,210,470,"",false,false,30)%>
        <%=MyUtil.DoBlock("Robo de Tarjeta",100,0)%>
        <%
        }
        rs2.close();
        rs4.close();
        rs5.close();
        rs.close();
        rs2=null;
        rs4=null;
        rs5=null;
        rs=null;
        
        StrclExpediente = null;
        StrSql = null;
        StrclPaginaWeb=null;
        StrCodEnt=null;
        StrdsGerencia = null;
        StrFecha = null;
        StrclUsrApp=null;
        %>
        <%=MyUtil.GeneraScripts()%>
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
