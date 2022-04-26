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
     {
       %><%="Fuera de Horario"%><%
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
    StringBuffer StrSql1 = new StringBuffer();
    StrSql1.append(" Select E.TieneAsistencia,E.codEnt From Expediente E");
    StrSql1.append(" Where E.clExpediente=").append(StrclExpediente);
    ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql1.toString());
    StrSql1.delete(0,StrSql1.length());
    
    if (rs2.next())  
     { 
         StrCodEnt = rs2.getString("CodEnt");
        // StrCodEnt = request.getParameter("CodEnt").toString(); 
/*     if (Integer.parseInt(rs2.getString("TieneAsistencia")) == 1)  
       {
          
          out.println("Ya existe una asistencia registrada para el expediente: (" + StrclExpediente + ") " + rs2.getString("dsSubServicio") );   
       }
*/     }   
    else
     {
          %><%="El expediente no existe"%><%
          rs2.close();
          rs2=null;
          StrclExpediente = null;
          StrclPaginaWeb=null;
          StrCodEnt=null;
          StrdsGerencia=null;
          StrclUsrApp=null;        
          return;      
     } 
    
     StrSql1.append(" select ge.clgerenciareg, gr.dsgerencia from gciaregxentidad ge ");
     StrSql1.append(" left join cgerenciaregional gr on (gr.clgerenciareg=ge.clgerenciareg)");
     StrSql1.append(" where ge.codEnt ='").append(StrCodEnt).append("'");
     ResultSet rs5 = UtileriasBDF.rsSQLNP( StrSql1.toString());  
     StrSql1.delete(0,StrSql1.length());
     if (rs5.next()){
        StrdsGerencia = rs5.getString("dsgerencia");
     }
    
      
    //out.println(StrclSubservicio);
StrSql1.append(" Select LR.DescripcionLugar,");
StrSql1.append(" coalesce(RC.Foraneo,'') as Foraneo,");
StrSql1.append(" coalesce(TC.dsContacto,'') as dsContacto,");
StrSql1.append(" coalesce(RC.DescripcionRobado,'') as DescripcionRobado,");
StrSql1.append(" coalesce(RC.MontoRobado,'') as MontoRobado,");
StrSql1.append(" coalesce(RC.PersonaContacta,'') as PersonaContacta,");
StrSql1.append(" coalesce(RC.ProbableResponsable,'') as ProbableResponsable,");
StrSql1.append(" coalesce(SR.DescripcionSituacion,'') as DescripcionSituacion,");
StrSql1.append(" coalesce(RC.AveriguacionPrev,'') as AveriguacionPrev,");
StrSql1.append(" coalesce(EF.dsEntFed,'') as dsEntFed,");
StrSql1.append(" coalesce(MD.dsMunDel,'') as dsMunDel,");
StrSql1.append(" coalesce(RC.CodMDRobo,'') as CodMDRobo,");
StrSql1.append(" coalesce(RC.AgenciaMP,'') as AgenciaMP,");
StrSql1.append(" coalesce(RC.Juzgado,'') as Juzgado,");
StrSql1.append(" coalesce(RC.CausaPenal,'') as CausaPenal,");
StrSql1.append(" coalesce(RC.Observaciones,'') as Observaciones,");
StrSql1.append(" coalesce(RC.FechaApertura,'') as FechaApertura,");
StrSql1.append(" coalesce(RC.FechaRegistro,'') as FechaRegistro ");
StrSql1.append(" from RoboComercioCasa RC");
StrSql1.append(" Left Join cLugarRobo LR ON (LR.clLugarRobo=RC.clLugarRobo)");
StrSql1.append(" Left Join cTipoContactoLegal TC ON (TC.clTipoContacto=RC.clTipoContacto)");
StrSql1.append(" Left Join cSituacionResp SR ON (SR.clSituacionResp=RC.clSituacionResp)");
StrSql1.append(" Left Join cMundel MD on (RC.CodEntRobo=MD.CodEnt and RC.CodMDRobo=MD.CodMD)");
StrSql1.append(" Left Join cEntFed EF on (RC.CodEntRobo=EF.CodEnt)");
StrSql1.append(" Where clExpediente=").append(StrclExpediente); 
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());
    StrSql1.delete(0,StrSql1.length()); 

    
       StrSql1.append("Select convert(varchar(19),getdate(),120) fechaEt ");
        ResultSet rs4 = UtileriasBDF.rsSQLNP( StrSql1.toString());  
        StrSql1.delete(0,StrSql1.length()); 
        if (rs4.next()){}  
               
       //out.println("<script>fnCloseLinks(window.parent.frames.InfoRelacionada.height) </script>");				
       out.println("<script>fnOpenLinks()</script>");				
       StrclPaginaWeb = "317";       
       MyUtil.InicializaParametrosC(317,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);
       %>
       <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
       
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="RoboComercioCasa.jsp?'>"%>
       
       <%
       if (rs.next()) { 
        %>
            <script>document.all.btnAlta.disabled=true;</script>
            <script>document.all.btnElimina.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
      
             <%=MyUtil.ObjComboC("Lugar donde ocurrio el robo","clLugarRobo",rs.getString("DescripcionLugar"),true,true,30,70,"","Select clLugarRobo,DescripcionLugar from cLugarRobo","","",30,true,true)%>
             <%=MyUtil.ObjChkBox("Foraneo","Foraneo",rs.getString("Foraneo"), true,true,240,70,"1","Foraneo","Local","")%>
             <%=MyUtil.ObjComboC("Tipo de Contacto","clTipoContacto",rs.getString("dsContacto"),true,true,30,110,"","Select clTipoContacto,dsContacto from cTipoContactoLegal","","",30,true,true)%>
             <%=MyUtil.ObjTextArea("Descripcion de lo Robado","DescripcionRobado",rs.getString("DescripcionRobado"),"80","3",true,true,240,110,"",true,true)%>
             <%=MyUtil.ObjInput("Monto de lo Robado","MontoRobado",rs.getString("MontoRobado"),true,true,30,170,"",true,true,10,"EsNumerico(document.all.MontoRobado)")%>
             <%=MyUtil.ObjInput("Persona con quien se Contacta","PersonaContacta",rs.getString("PersonaContacta"),true,true,240,170,"",true,true,40)%>
             <%=MyUtil.ObjInput("Nombre del probable responsable","ProbableResponsable",rs.getString("ProbableResponsable"),true,true,30,210,"",false,false,40)%>
             <%=MyUtil.ObjComboC("Situacion del probable responsable","clSituacionResp",rs.getString("DescripcionSituacion"),true,true,270,210,"","Select clSituacionResp,DescripcionSituacion from cSituacionResp","","",30,true,true)%>
             <%=MyUtil.ObjInput("Averiguacion Previa","AveriguacionPrev",rs.getString("AveriguacionPrev"),true,true,30,250,"",true,true,25)%>
             <%=MyUtil.ObjComboC("Entidad","CodEntRobo",rs.getString("dsEntFed"),true,true,30,290,"","Select CodEnt,dsEntFed From cEntFed Order by dsEntFed","fnLlenaMunicipios()","",70,true,true)%>
             <%=MyUtil.ObjComboC("Municipio","CodMDRobo",rs.getString("dsMunDel"),true,true,270,290,"","Select CodMD,dsMunDel  FROM cMunDel WHERE CodMD='"+ rs.getString("CodMDRobo") +"' Order by dsMunDel","","",160,true,true)%>
             <%=MyUtil.ObjInput("Agencia MP","AgenciaMP",rs.getString("AgenciaMP"),true,true,30,330,"",true,true,25)%>
             <%=MyUtil.ObjInput("Juzgado","Juzgado",rs.getString("Juzgado"),true,true,240,330,"",true,true,25)%>
             <%=MyUtil.ObjInput("Causa Penal","CausaPenal",rs.getString("CausaPenal"),true,true,430,330,"",true,true,25)%>
             <%=MyUtil.ObjInput("Gerencia Regional","clGerenciaRegVTR",StrdsGerencia,false,false,30,370,"",false,false,25)%>
             <%=MyUtil.ObjTextArea("Observaciones","Observaciones",rs.getString("Observaciones"),"80","3",true,true,240,370,"",false,false)%>
             <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura",rs.getString("FechaApertura"),false,false,30,450,rs4.getString("fechaEt"),false,false,25)%>
             <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR",rs.getString("FechaRegistro"),false,false,240,450,"",false,false,25)%>
             
            <%=MyUtil.DoBlock("Robo a Comercio y/o Casa Habitación",80,10)%>
            <%
      } 
      else {
            %>
            <script>document.all.btnCambio.disabled=true;</script>
            <script>document.all.btnElimina.disabled=true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'> 

             <%=MyUtil.ObjComboC("Lugar donde ocurrio el robo","clLugarRobo","",true,true,30,70,"","select clLugarRobo,DescripcionLugar from cLugarRobo","","",30,true,true)%>
             <%=MyUtil.ObjChkBox("Foraneo","Foraneo","", true,true,240,70,"1","Foraneo","Local","")%>
             <%=MyUtil.ObjComboC("Tipo de Contacto","clTipoContacto","",true,true,30,110,"","Select clTipoContacto,dsContacto from cTipoContactoLegal","","",30,true,true)%>
             <%=MyUtil.ObjTextArea("Descripcion de lo Robado","DescripcionRobado","","80","3",true,true,240,110,"",true,true)%>
             <%=MyUtil.ObjInput("Monto de lo Robado","MontoRobado","",true,true,30,170,"",true,true,10,"EsNumerico(document.all.MontoRobado)")%>
             <%=MyUtil.ObjInput("Persona con quien se Contacta","PersonaContacta","",true,true,240,170,"",true,true,40)%>
             <%=MyUtil.ObjInput("Nombre del probable responsable","ProbableResponsable","",true,true,30,210,"",false,false,40)%>
             <%=MyUtil.ObjComboC("Situacion del probable responsable","clSituacionResp","",true,true,270,210,"","Select clSituacionResp,DescripcionSituacion from cSituacionResp","","",30,true,true)%>
             <%=MyUtil.ObjInput("Averiguacion Previa","AveriguacionPrev","",true,true,30,250,"",true,true,25)%>
             
             <%=MyUtil.ObjComboC("Entidad","CodEntRobo","",true,false,30,290,"","Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","fnLlenaMunicipios()","",70,true,true)%>
             <%=MyUtil.ObjComboC("Municipio","CodMDRobo","",true,false,270,290,"","Select CodMD, dsMunDel From cMunDel Where CodEnt='DF' Order by dsMunDel","","",160,true,true)%>
             
             <%=MyUtil.ObjInput("Agencia MP","AgenciaMP","",true,true,30,330,"",true,true,25)%>
             <%=MyUtil.ObjInput("Juzgado","Juzgado","",true,true,240,330,"",true,true,25)%>
             <%=MyUtil.ObjInput("Causa Penal","CausaPenal","",true,true,430,330,"",true,true,25)%>
             <%=MyUtil.ObjInput("Gerencia Regional","clGerenciaRegVTR",StrdsGerencia,false,false,30,370,StrdsGerencia,false,false,25)%>
             <%=MyUtil.ObjTextArea("Observaciones","Observaciones","","80","3",true,true,240,370,"",false,false)%>
             <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura","",false,false,30,450,rs4.getString("fechaEt"),false,false,25)%>
             <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR","",false,false,240,450,"",false,false,25)%>
             <%=MyUtil.DoBlock("Robo a Comercio y/o Casa Habitación",80,10)%>
            <%
      }
        rs2.close();
        rs5.close();
        rs4.close();
        rs.close();
        rs2=null;
        rs5=null;
        rs4=null;
        rs=null;
        StrclExpediente = null;
        StrSql1 = null; 
        StrclPaginaWeb=null;
        StrCodEnt=null;
        StrdsGerencia=null;
        StrclUsrApp=null;
        
       %>
        <%=MyUtil.GeneraScripts()%>
<%        
%>

<script>
document.all.PersonaContacta.maxLength=100; 
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
