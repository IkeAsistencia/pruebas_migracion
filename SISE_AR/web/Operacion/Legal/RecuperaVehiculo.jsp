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
        {
        %><%="Fuera de Horario"%><%
        StrclUsrApp=null;
        return;
        }
        String StrclExpediente = "0";
        String StrclPaginaWeb="0";
        String StrFecha ="";
        String StrCodEnt="0";
        String StrdsGerencia = "";
        
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
        {   StrCodEnt=rs2.getString("CodEnt");  }
        else
        {
        %><%="El expediente no existe"%><% 
        rs2.close();
        rs2=null;
        StrclExpediente = null;
        StrclPaginaWeb=null;
        StrFecha =null;
        StrCodEnt=null;
        StrdsGerencia = null;
        StrclUsrApp=null;
        return;
        }
        
        StrSql1.append("Select convert(varchar(20),getdate(),120) FechaApertura ");
        ResultSet rs3 = UtileriasBDF.rsSQLNP( StrSql1.toString());
        StrSql1.delete(0,StrSql1.length());
        if (rs3.next())
        {
            StrFecha = rs3.getString("FechaApertura");
        }
        
        StrSql1.append(" select ge.clgerenciareg, gr.dsgerencia from gciaregxentidad ge ");
        StrSql1.append(" left join cgerenciaregional gr on (gr.clgerenciareg=ge.clgerenciareg)");
        StrSql1.append(" where ge.codEnt ='").append(StrCodEnt).append("'");
        ResultSet rs4 = UtileriasBDF.rsSQLNP( StrSql1.toString());
        StrSql1.delete(0,StrSql1.length());
        if (rs4.next())
        {
            StrdsGerencia = rs4.getString("dsgerencia");
        }
        
        //out.println(StrSql);
        
        StrSql1.append(" Select coalesce(D.dsDelito,'') as dsDelito, ");
        StrSql1.append(" coalesce(EFD.dsEntFed,'') as dsEntFedDelito, coalesce(MDD.dsMunDel,'') as dsMunDelDelito, RV.CodEntDelito,");
        StrSql1.append(" coalesce(EFR.dsEntFed,'') as dsEntFedRecupero, coalesce(MDR.dsMunDel,'') as dsMunDelRecupero, RV.CodEntRecupero,");
        StrSql1.append(" coalesce(EFC.dsEntFed,'') as dsEntFedContacto, RV.CodEntContacto,coalesce(MDC.dsMunDel,'') as dsMunDelContacto, RV.CodMDContacto,");
        StrSql1.append(" coalesce(RV.ColoniaContacto,'') as ColoniaContacto,");
        StrSql1.append(" coalesce(RV.CalleNumContacto,'') as CalleNumContacto, ");
        StrSql1.append(" coalesce(RV.ReferenContacto,'') as ReferenContacto, ");
        StrSql1.append(" coalesce(UA.dsUbicacionAuto,'') as dsUbicacionAuto, ");
        StrSql1.append(" coalesce(CL.dsContacto,'') as dsContacto,RV.TipoLiberacion,");
        StrSql1.append(" RV.Foraneo,RV.FacturaOriginal, RV.AveriguaPrevia, RV.IdentificaOficial,");
        StrSql1.append(" coalesce(RV.AveriguacionPrev,'') as AveriguacionPrev,");
        StrSql1.append(" RV.CausaPenal, RV.MinisterioPub, RV.Juzgado, coalesce(RV.CobroExpediente,'0') as CobroExpediente, ");
        StrSql1.append(" convert(varchar(10),RV.FechaRecupVeh,120) as FechaRecupVeh,convert(varchar(16),RV.FechaApertura,120) as FechaApertura,");
        StrSql1.append(" convert(varchar(16),RV.FechaRegistro,120) as FechaRegistro");
        StrSql1.append(" FROM RecuperaVehiculo RV ");
        StrSql1.append(" Inner Join cDelitosEspeciales D ON(D.clDelito=RV.clDelito) ");
        StrSql1.append(" Left Join cEntFed EFD ON (EFD.CodEnt=RV.CodEntDelito) ");
        StrSql1.append(" Left Join cMunDel MDD ON (MDD.CodEnt=RV.CodEntDelito and MDD.CodMD=RV.CodMDDelito) ");
        StrSql1.append(" Left Join cEntFed EFR ON (EFR.CodEnt=RV.CodEntRecupero) ");
        StrSql1.append(" Left Join cMunDel MDR ON (MDR.CodEnt=RV.CodEntRecupero and MDR.CodMD=RV.CodMDRecupero) ");
        StrSql1.append(" Left Join cEntFed EFC ON (EFC.CodEnt=RV.CodEntContacto) ");
        StrSql1.append(" Left Join cMunDel MDC ON (MDC.CodEnt=RV.CodEntContacto and MDC.CodMD=RV.CodMDContacto) ");
        StrSql1.append(" Left Join cUbicacionAuto UA ON (RV.clUbicacionAuto=UA.clUbicacionAuto) ");
        StrSql1.append(" Left Join cTipoContactoLegal CL ON (RV.clTipoContacto=CL.clTipoContacto) ");
        StrSql1.append(" Where RV.clExpediente=").append(StrclExpediente);
        
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());
        StrSql1.delete(0,StrSql1.length());    %>
        <script>fnOpenLinks()</script>
        <%
        StrclPaginaWeb = "319";
        MyUtil.InicializaParametrosC(319,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
        %>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","fnLimpiaExtraContacto()")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%= "RecuperaVehiculo.jsp?'>"%>
        <%
        if (rs.next())
        {
            // El siguiente campo llave no se mete con MyUtil.ObjInput
        %>
        <script>document.all.btnAlta.disabled=true;document.all.btnElimina.disabled=true;</script>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        
        <%=MyUtil.ObjComboC("Delito", "clDelito",rs.getString("dsDelito"),true,true,30,70,"","Select clDelito,dsDelito from cDelitosEspeciales Where clSubServicio=282","","",140,true,true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad") + " donde Ocurrió Delito","CodEntDelito",rs.getString("dsEntFedDelito"),true,true,30,110,"","Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","fnLlenaMunDelito()","",70,true,true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio") + " donde Ocurrió Delito","CodMDDelito",rs.getString("dsMunDelDelito"),true,true,250,110,"","Select CodMD, dsMunDel From cMunDel Where CodEnt='" + rs.getString("CodEntDelito") + "' Order by dsMunDel","","",160,true,true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad") + " donde se Recuperó Veh.","CodEntRecupero",rs.getString("dsEntFedRecupero"),true,true,30,150,"","Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","fnLlenaMunRecupero()","",70,true,true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio") + " donde se Recuperó Vehículo","CodMDRecupero",rs.getString("dsMunDelRecupero"),true,true,250,150,"","Select CodMD, dsMunDel From cMunDel Where CodEnt='" + rs.getString("CodEntRecupero") + "' Order by dsMunDel","","",160,true,true)%>
        <%=MyUtil.DoBlock("Detalle de Recuperación de Vehículo",240,0)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"dsEntFedContacto",rs.getString("dsEntFedContacto"),false,false,30,230,"",true,true,50)%>                
        <INPUT id='CodEntContacto' name='CodEntContacto' type='hidden' value='<%=rs.getString("CodEntContacto")%>'>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"dsMunDelContacto",rs.getString("dsMunDelContacto"),false,false,380,230,"",true,true,50)%>                
        <INPUT id='CodMDContacto' name='CodMDContacto' type='hidden' value='<%=rs.getString("CodMDContacto")%>'>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"ColoniaContacto",rs.getString("ColoniaContacto"),false,false,30,270,"",true,true,40)%>                
        <%=MyUtil.ObjInput("Calle y Número","CalleNumContacto",rs.getString("CalleNumContacto"),true,true,380,270,"",true,true,50)%>                
        <div class='VTable' style='position:absolute; z-index:25; left:280px; top:280px;'>
        <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaContacto();' class='cBtn'></div>
        <%=MyUtil.ObjTextArea("Referencias Visuales","ReferenContacto",rs.getString("ReferenContacto"),"120","4",true,true,30,310,"",true,true)%>
        <%=MyUtil.DoBlock("Ubicación A Dirigir el Abogado (Lugar de Contacto)",110,30)%>   
        
        <%=MyUtil.ObjComboC("Ubicación del Vehículo","clUbicacionAuto",rs.getString("dsUbicacionAuto"),true,true,30,430,"","Select clUbicacionAuto, dsUbicacionAuto From cUbicacionAuto Order by dsUbicacionAuto","","",70,true,true)%>
        <%=MyUtil.ObjComboC("Tipo de Contacto","clTipoContacto",rs.getString("dsContacto"),true,true,280,430,"","Select clTipoContacto, dsContacto From cTipoContactoLegal Order by dsContacto","","",70,true,true)%>
        <%=MyUtil.ObjChkBox("Tipo Liberación Veh.","TipoLiberacion",rs.getString("TipoLiberacion"), true,true,450,420,"0","En Depósito","En Posesión","")%>     
        <%=MyUtil.ObjChkBox("Foráneo/Local","Foraneo",rs.getString("Foraneo"), true,true,30,470,"0","Foráneo","Local","")%>     
        <%=MyUtil.ObjChkBox("Factura Original","FacturaOriginal",rs.getString("FacturaOriginal"), true,true,160,470,"0","SI","NO","")%>     
        <%=MyUtil.ObjChkBox("Averiguación Previa","AveriguaPrevia",rs.getString("AveriguaPrevia"), true,true,300,470,"0","SI","NO","")%>     
        <%=MyUtil.ObjChkBox("Identificación Oficial","IdentificaOficial",rs.getString("IdentificaOficial"), true,true,450,470,"0","SI","NO","")%>     
        <%=MyUtil.ObjInput("Averiguación Previa","AveriguacionPrev",rs.getString("AveriguacionPrev"),true,true,30,520,"",true,true,50)%>                
        <%=MyUtil.ObjInput("Causa Penal","CausaPenal",rs.getString("CausaPenal"),true,true,400,520,"",true,true,50)%>                
        <%=MyUtil.ObjInput("Ministerio Público","MinisterioPub",rs.getString("MinisterioPub"),true,true,30,560,"",true,true,50)%>                
        <%=MyUtil.ObjInput("Juzgado","Juzgado",rs.getString("Juzgado"),true,true,400,560,"",true,true,50)%>                
        <%=MyUtil.ObjInput("Gerencia Regional","clGerenciaRegVTR",StrdsGerencia,false,false,30,610,"",false,false,30)%>                
        <%=MyUtil.ObjInput("Cobro Expediente %","CobroExpediente",rs.getString("CobroExpediente"),true,true,250,610,"",true,true,5,"fnRango(document.all.CobroExpediente,0,100)")%>                
        <%=MyUtil.ObjInput("Fecha de Recuperación<br> Vehículo (AAAA/MM/DD)","FechaRecupVeh",rs.getString("FechaRecupVeh"),true,true,400,600,"",true,true,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura",rs.getString("FechaApertura"),false,false,30,650,StrFecha,false,false,25)%>                
        <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR",rs.getString("FechaRegistro"),false,false,250,650,"",false,false,25)%>                
        <%=MyUtil.DoBlock("Detalle de Recuperación de Vehículo",40,0)%> 
        <%
        }
        else
        {  
        %>
        <script>document.all.btnCambio.disabled=true;</script>
        <script>document.all.btnElimina.disabled=true;</script>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%= StrclExpediente%>'>
        <%=MyUtil.ObjComboC("Delito", "clDelito","",true,true,30,70,"","Select clDelito,dsDelito from cDelitosEspeciales Where clSubServicio=282","","",140,true,true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad") + " donde Ocurrió Delito","CodEntDelito","",true,true,30,110,"","Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","fnLlenaMunDelito()","",70,true,true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio") + " donde Ocurrió Delito","CodMDDelito","",true,true,250,110,"","","","",160,true,true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad") + " donde se Recuperó Veh.","CodEntRecupero","",true,true,30,150,"","Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","fnLlenaMunRecupero()","",70,true,true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio") + " donde se Recuperó Vehículo","CodMDRecupero","",true,true,250,150,"","","","",160,true,true)%>
        <%=MyUtil.DoBlock("Detalle de Recuperación de Vehículo",240,0)%>
        
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"dsEntFedContacto","",false,false,30,230,"",true,true,50)%>                
        <INPUT id='CodEntContacto' name='CodEntContacto' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"dsMunDelContacto","",false,false,380,230,"",true,true,50)%>                
        <INPUT id='CodMDContacto' name='CodMDContacto' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"ColoniaContacto","",false,false,30,270,"",true,true,40)%>                
        <%=MyUtil.ObjInput("Calle y Número","CalleNumContacto","",true,true,380,270,"",true,true,50)%>                
        <div class='VTable' style='position:absolute; z-index:25; left:280px; top:280px;'>
        <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaContacto();' class='cBtn'></div>
        <%=MyUtil.ObjTextArea("Referencias Visuales","ReferenContacto","","120","4",true,true,30,310,"",true,true)%>
        <%=MyUtil.DoBlock("Ubicación A Dirigir el Abogado (Lugar de Contacto)",110,30)%>   
        
        <%=MyUtil.ObjComboC("Ubicación del Vehículo","clUbicacionAuto","",true,true,30,430,"","Select clUbicacionAuto, dsUbicacionAuto From cUbicacionAuto Order by dsUbicacionAuto","","",70,true,true)%>
        <%=MyUtil.ObjComboC("Tipo de Contacto","clTipoContacto","",true,true,280,430,"","Select clTipoContacto, dsContacto From cTipoContactoLegal Order by dsContacto","","",70,true,true)%>
        <%=MyUtil.ObjChkBox("Tipo Liberación Veh.","TipoLiberacion","", true,true,450,420,"0","En Depósito","En Posesión","")%>     
        <%=MyUtil.ObjChkBox("Foráneo/Local","Foraneo","", true,true,30,470,"0","Foráneo","Local","")%>     
        <%=MyUtil.ObjChkBox("Factura Original","FacturaOriginal","", true,true,160,470,"0","SI","NO","")%>     
        <%=MyUtil.ObjChkBox("Averiguación Previa","AveriguaPrevia","", true,true,300,470,"0","SI","NO","")%>     
        <%=MyUtil.ObjChkBox("Identificación Oficial","IdentificaOficial","", true,true,450,470,"0","SI","NO","")%>     
        <%=MyUtil.ObjInput("Averiguación Previa","AveriguacionPrev","",true,true,30,520,"",true,true,50)%>                
        <%=MyUtil.ObjInput("Causa Penal","CausaPenal","",true,true,400,520,"",true,true,50)%>                
        <%=MyUtil.ObjInput("Ministerio Público","MinisterioPub","",true,true,30,560,"",true,true,50)%>                
        <%=MyUtil.ObjInput("Juzgado","Juzgado","",true,true,400,560,"",true,true,50)%>                
        <%=MyUtil.ObjInput("Gerencia Regional","clGerenciaRegVTR",StrdsGerencia,false,false,30,610,"",false,false,30)%>                
        <%=MyUtil.ObjInput("Cobro Expediente %","CobroExpediente","",true,true,250,610,"",true,true,5,"fnRango(document.all.CobroExpediente,0,100)")%>                
        <%=MyUtil.ObjInput("Fecha de Recuperación<br> Vehículo (AAAA/MM/DD)","FechaRecupVeh","",true,true,400,600,"",true,true,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Fecha Apertura","FechaApertura","",false,false,30,650,StrFecha,false,false,25)%>                
        <%=MyUtil.ObjInput("Fecha Registro","FechaRegistroVTR","",false,false,250,650,"",false,false,25)%>                
        <%=MyUtil.DoBlock("Detalle de Recuperación de Vehículo",40,0)%>
        <%
        }
        rs2.close();
        rs3.close();
        rs4.close();
        rs.close();
        rs2=null;
        rs3=null;
        rs4=null;
        rs=null;
        StrclExpediente = null;
        StrSql1 = null;
        StrclPaginaWeb=null;
        StrFecha =null;
        StrCodEnt=null;
        StrdsGerencia = null;
        StrclUsrApp=null;        
        
        %>
        <%=MyUtil.GeneraScripts()%>
        <%        
        %>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <script> 
     document.all.CalleNumContacto.maxLength=60; 
     document.all.ColoniaContacto.maxLength=60;   
     document.all.ReferenContacto.maxLength=100;   
     document.all.AveriguacionPrev.maxLength=50;        
     document.all.CausaPenal.maxLength=50;        
     document.all.MinisterioPub.maxLength=50;        
     document.all.Juzgado.maxLength=50;        

     function fnLimpiaExtraContacto(){
           if (document.all.Action.value==1){
               document.all.CodMDContacto.value = "";
               document.all.CodEntContacto.value = "";
             }
     }
     
     function fnLlenaMunDelito(){ 
             var strConsulta = "sp_GetMunicipios '" + document.all.CodEntDelito.value + "'";
             var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
             document.all.CodMDDelito.value = '';
             pstrCadena = pstrCadena + "&strName=CodMDDelitoC";		
             fnOptionxDefault('CodMDDelitoC',pstrCadena);
     }
     function fnLlenaMunRecupero(){ 
             var strConsulta = "sp_GetMunicipios '" + document.all.CodEntRecupero.value + "'";
             var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
             document.all.CodMDRecupero.value = '';
             pstrCadena = pstrCadena + "&strName=CodMDRecuperoC";		
             fnOptionxDefault('CodMDRecuperoC',pstrCadena);
     }

    //Abre una página para realizar la búsqueda de una colonia (Aplica para una segunda dirección en la misma página sin código postal, solo colonia)
    function fnBuscaColoniaContacto(){ 
            if (document.all.btnGuarda.disabled==false){ 
               var pstrCadena = "../../Utilerias/FiltrosDireccion.jsp?strSQL=sp_WebBuscaDir 5,'','" + document.all.ColoniaContacto.value + "','" + document.all.CodEntContacto.value + "'";
               pstrCadena = pstrCadena + "&ColoniaContacto=&CodMDContacto=&dsMunDelContacto=&CodEntContacto=&dsEntFedContacto=&Tipo=5";
               window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=1,height=1');
              } 
            }
     
            
          function fnActualizaDatosContacto(CP,ColoniaContacto, CodMDContacto, dsMunDelContacto, CodEntContacto, dsEntFedContacto){
              document.all.ColoniaContacto.value = ColoniaContacto;			
              document.all.CodMDContacto.value = CodMDContacto;
              document.all.dsMunDelContacto.value = dsMunDelContacto;
              document.all.CodEntContacto.value = CodEntContacto;
              document.all.dsEntFedContacto.value = dsEntFedContacto;
        }
        </script>
    </body>
</html>

