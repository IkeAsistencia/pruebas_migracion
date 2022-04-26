<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.asistencias.DAOAsistLegFun,com.ike.asistencias.to.LegFun,com.ike.model.DAOTieneAsistencia,com.ike.model.to.TieneAsistenciaExp,Combos.cbEntidad" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>JSP Page</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css"> 
    </head>
    <body class="cssBody"> 
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../../Utilerias/UtilCalendario.js'></script>
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <script src='../../Utilerias/UtilDireccion.js'></script>
        <%  
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        String StrclUsrApp="0";
        String strTieneAsistencia = "0";
        String StrclExpediente = "0";
        String StrclPaginaWeb="0";
        String StrdsEntFedU = "";
        String StrCodEntU = "";
        String StrdsMunDelU = "";
        String StrCodMDU = "";
        String StrdsEntFedF = "";
        String StrCodEntF = "";
        String StrdsMunDelF = "";
        String StrCodMDF = "";
        
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
        
        if (session.getAttribute("clExpediente")!= null)
        {
            StrclExpediente = session.getAttribute("clExpediente").toString();
        }
        
        DAOTieneAsistencia daoTieneAsistencia = null;
        TieneAsistenciaExp  ExpedienteTA = null;
        if (StrclExpediente.compareToIgnoreCase("0")!=0)
        {
            daoTieneAsistencia = new DAOTieneAsistencia();
            ExpedienteTA = daoTieneAsistencia.getExpediente(StrclExpediente.toString());
        }
        
        strTieneAsistencia = ExpedienteTA != null ? ExpedienteTA.getTieneAsistencia() : "X";
        
        
        DAOAsistLegFun daoAsistLegalFun = null;
        LegFun legfun = null;
        if (StrclExpediente.compareToIgnoreCase("0")!=0)
        {
            daoAsistLegalFun = new DAOAsistLegFun();
            legfun = daoAsistLegalFun.getLegfun(StrclExpediente);
        }
        %><script>fnOpenLinks()</script><%				
        
        StrclPaginaWeb = "630";
        MyUtil.InicializaParametrosC(630,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        
        %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
        
        <%
        if (strTieneAsistencia.compareToIgnoreCase("1")==0)
        {
        %>
        <script>document.all.btnAlta.disabled=true;</script>
        <%      
        }
        else
        {
        %>
        <script>document.all.btnCambio.disabled=true;</script>
        <%      
        }
        %>
        
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="LegalFuneraria.jsp?'>"%><%
               
               StrdsEntFedU = legfun != null ? legfun.getDsEntfed() : "";
               StrCodEntU = legfun != null ? legfun.getCodEntU() : "";
               StrdsMunDelU = legfun != null ? legfun.getDsMunDel() : "";
               StrCodMDU = legfun != null ? legfun.getCodMDU() : "";
               
               StrdsEntFedF = legfun != null ? legfun.getDsEntfedF() : "";
               StrCodEntF = legfun != null ? legfun.getCodEntF() : "";
               StrdsMunDelF = legfun != null ? legfun.getDsMunDelF() : "";
               StrCodMDF = legfun != null ? legfun.getCodMDF() : "";
               %>
               
               <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
               <%=MyUtil.ObjInput("Quien Reporta","PersonaReporta",legfun != null ? legfun.getPersonaReporta() : "",true,true,20,70,"",true,true,50)%>
               <%=MyUtil.ObjInput("Parentesco","Parentesco",legfun != null ? legfun.getParentesco() : "",true,true,300,70,"",false,false,20)%>
               <%=MyUtil.ObjInput("Teléfono Contacto","TelConU",legfun != null ? legfun.getTelconU() : "",true,true,450,70,"",true,true,20)%>
               <%=MyUtil.ObjInput("Teléfono Movil","TelMovil",legfun != null ? legfun.getTelMovil() : "",true,true,20,110,"",false,false,20)%>
               <%=MyUtil.ObjInput("Nombre de Usuario","Usuario",legfun != null ? legfun.getUsuario() : "",true,true,150,110,"",true,true,50)%>
               <%=MyUtil.ObjInput("Póliza","Poliza",legfun != null ? legfun.getPoliza() : "",true,true,450,110,"",true,true,20)%>
               <%=MyUtil.DoBlock("Datos Generales",100,0)%> 
               
               <%=MyUtil.ObjComboMem(i18n.getMessage("message.title.entidad"),"CodEntU",StrdsEntFedU,StrCodEntU,cbEntidad.GeneraHTML(20,StrdsEntFedU),true,true,20,200,"","fnLlenaMunicipiosU()","",20,false,false)%>
               <%=MyUtil.ObjComboMem(i18n.getMessage("message.title.municipio"),"CodMDU",StrdsMunDelU,StrCodMDU,cbEntidad.GeneraHTMLMD(40,StrCodEntU,StrdsMunDelU),true,true,190,200,StrdsMunDelU,"","",20,false,false)%>    
               
               <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"ColoniaU",legfun != null ? legfun.getColoniaU() : "",true,true,20,240,"",false,false,50)%>
               <%=MyUtil.ObjInput("Calle y Número","CalleU",legfun != null ? legfun.getCalleU() : "",true,true,320,240,"",false,false,60)%>
               <%=MyUtil.ObjTextArea("Referencias","ReferenciasU",legfun != null ? legfun.getReferenciasU() : "","90","3",true,true,20,280,"",false,false)%>
               <%=MyUtil.DoBlock("Ubicación del Cuerpo",150,20)%>
               
               <%=MyUtil.ObjComboC("Causa de la Muerte","CausaMuerte",legfun != null ? legfun.getDsCausaMuerte() : "",true,true,20,390,"","Select clCausaMuerte,dsCausaMuerte from cCausaMuerte order by dsCausaMuerte","","",25,true,true)%>
               <%=MyUtil.ObjComboC("Lugar del Fallecimiento","LugarMuerte",legfun != null ? legfun.getDsLugarFallecimiento() : "",true,true,200,390,"","Select clLugarFallecimiento,dsLugarFallecimiento from cLugarFallecimiento order by dsLugarFallecimiento","","",25,true,true)%>               
               <%=MyUtil.ObjInputF("Fecha y Hora (AAAA-MM-DD HH:MM)","FechaF",legfun != null ? legfun.getFechaF() : "",true,true,390,390,"",false,false,20,2,"if(this.readOnly==false){fnValMask(this,document.all.FechaMskH.value,this.name)}")%> 
               
               <%=MyUtil.ObjComboMem(i18n.getMessage("message.title.entidad"),"CodEntF",StrdsEntFedF,StrCodEntF,cbEntidad.GeneraHTML(20,StrdsEntFedF),true,true,20,450,"","fnLlenaMunicipiosF()","",20,false,false)%>
               <%=MyUtil.ObjComboMem(i18n.getMessage("message.title.municipio"),"CodMDF",StrdsMunDelF,StrCodMDF,cbEntidad.GeneraHTMLMD(40,StrCodEntF,StrdsMunDelF),true,true,200,450,StrdsMunDelF,"","",20,false,false)%>    
               
               <%=MyUtil.DoBlock("Información del Fallecimiento",30,0)%>
               
               <%=MyUtil.ObjInput("Persona a Cargo","PersonaCargo",legfun != null ? legfun.getPersonaCargo() : "",true,true,20,540,"",false,false,50)%>
               <%=MyUtil.ObjInput("Teléfono Contacto","Telcontacto",legfun != null ? legfun.getTelcontacto() : "",true,true,350,540,"",false,false,20)%>
               <%=MyUtil.ObjInput("Averiguación Previa","Averiguacion",legfun != null ? legfun.getAveriguacion() : "",true,true,20,580,"",false,false,20)%>
               <%=MyUtil.ObjInput("Ministerio Publico","MinisterioP",legfun != null ? legfun.getMinisterioP() : "",true,true,350,580,"",false,false,20)%>
               <%=MyUtil.ObjChkBox("Se requiere para obtener certificado de defunción ante la Secretaria de Salud","CertificadoD",legfun != null ? legfun.getCertificadoD() : "", true,true,20,620,"0","")%>
               <%=MyUtil.ObjChkBox("Se requiere para obtener acta de defunción ante registro civil","ActaD",legfun != null ? legfun.getActaD() : "", true,true,20,635,"0","")%>
               <%=MyUtil.ObjChkBox("Se requiere para obtener dispensa de Necropsia","DispensaN",legfun != null ? legfun.getDispensaN() : "", true,true,20,650,"0","")%>
               <%=MyUtil.ObjChkBox("Se requiere para orientar sobre tramites relacionados con el trslado del cuerpo","TrasladoC",legfun != null ? legfun.getTrasladoC() : "", true,true,20,665,"0","")%>
               <%=MyUtil.ObjChkBox("Se requiere para orientar sobre tramites funerarios","TramitesF",legfun != null ? legfun.getTramitesF() : "", true,true,20,680,"0","")%>
               <%=MyUtil.ObjChkBox("Se requiere asesoria para presentar demanda en contra del responsable","DemandaR",legfun != null ? legfun.getDemandaR() : "", true,true,20,695,"0","")%>
               <%=MyUtil.ObjChkBox("Se requiere para notificar a acredores para liberación de deudas","AcreedoresL",legfun != null ? legfun.getAcreedoresL() : "", true,true,20,710,"0","")%>
               <%=MyUtil.ObjChkBox("Se requiere para liberar el cuerpo ante el ministerio publico","CuerpoM",legfun != null ? legfun.getCuerpoM() : "", true,true,20,725,"0","")%>
               <%=MyUtil.ObjChkBox("Se requiere para liberar el cuerpo ante Medico Forense","MedicoF",legfun != null ? legfun.getMedicoF() : "", true,true,20,740,"0","")%>
               <%=MyUtil.ObjChkBox("Otro","Otro",legfun != null ? legfun.getOtro() : "", true,true,20,775,"0","fnOtro(this.value)")%>
               <%=MyUtil.ObjInput("Cual","Cual",legfun != null ? legfun.getCual() : "",true,true,80,765,"",false,false,100)%>
               <%=MyUtil.ObjComboC("Como concluye la asistencia","clConcluyeAsistencia",legfun != null ? legfun.getDsConcluyeAsistencia() : "",true,true,20,820,"","select clConcluyeAsistencia,dsConcluyeAsistencia from cConcluyeAsistencia","","",200,false,true)%>
               <%=MyUtil.ObjTextArea("Referencias","ObservacionesFin",legfun != null ? legfun.getObservacionesFin() : "","90","3",true,true,20,860,"",false,false)%>
               <%=MyUtil.DoBlock("Información del Servicio",150,20)%>
               
               <%=MyUtil.GeneraScripts()%>
               <%
               StrclUsrApp=null;
               StrclExpediente = null;
               StrclPaginaWeb=null;
               %>
               <input name='FechaMskH' id='FechaMskH' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F   VN09VN09F:::VN09VN09'>      
        <script>
    fnCual()
    function fnCual()
    {
     document.all.Cual.disabled=true
    }
    function fnOtro()
    {
     if (document.all.Otro.value==1)
     {
      document.all.Cual.disabled=false
     }
     else
     {
      document.all.Cual.value=""
      document.all.Cual.disabled=true
     }
    }
            
        </script>
    </body>
</html>


