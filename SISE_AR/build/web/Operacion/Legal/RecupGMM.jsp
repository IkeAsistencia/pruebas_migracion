<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.asistencias.DAORGMM,com.ike.asistencias.to.RGMMExpediente,com.ike.model.DAOTieneAsistencia,com.ike.model.to.TieneAsistenciaExp,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,Combos.cbEntidad" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>

<html>
    <head><title>Recuperacion de Gastos Médicos Mayores</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        
    </head>
    
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js'></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        
        <%
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        String strclUsrApp = "0";
        String strclExpediente = "0";
        String strTieneAsistencia = "0";
        String StrdsEntFedH = "";
        String StrCodEntH = "";
        String StrdsMunDelH = "";
        String StrCodMDH = "";
        
        String StrdsEntFedP = "";
        String StrCodEntP = "";
        String StrdsMunDelP = "";
        String StrCodMDP = "";
        
        //Pide clUsrApp para validacion de página
        if (session.getAttribute("clUsrApp")!= null)
        {
            strclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (session.getAttribute("clExpediente")!= null)
        {
            strclExpediente = session.getAttribute("clExpediente").toString();
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true)
        {
        %>
        Fuera de Horario
        <%
        strclUsrApp = null;
        return;
        }
        
        /*       String StrclSubservicio="0";
        if (session.getAttribute("clSubServicio")!= null)
        {
        StrclSubservicio = session.getAttribute("clSubServicio").toString();
        }
         */
        //Verifica si existe asistencia para el expediente
        DAOTieneAsistencia daoTieneAsistencia = null;
        TieneAsistenciaExp  ExpedienteTA = null;
        if (strclExpediente.compareToIgnoreCase("0")!=0)
        {
            daoTieneAsistencia = new DAOTieneAsistencia();
            ExpedienteTA = daoTieneAsistencia.getExpediente(strclExpediente.toString());
        }
        
        //Llamar a DAORGMM
        DAORGMM daoRGMM = null;
        RGMMExpediente  Expediente = null;
        if (strclExpediente.compareToIgnoreCase("0")!=0)
        {
            daoRGMM = new DAORGMM();
            Expediente = daoRGMM.getExpediente(strclExpediente);
        }
        
        strTieneAsistencia = ExpedienteTA != null ? ExpedienteTA.getTieneAsistencia() : "0";
        
        StrdsEntFedH = Expediente != null ? Expediente.getdsEntFedH() : "";
        StrCodEntH = Expediente != null ? Expediente.getCodEntH() : "";
        StrdsMunDelH = Expediente != null ? Expediente.getdsMunDelH() : "";
        StrCodMDH = Expediente != null ? Expediente.getCodMDH() : "";
        
        StrdsEntFedP = Expediente != null ? Expediente.getdsEntFedP() : "";
        StrCodEntP = Expediente != null ? Expediente.getCodEntP() : "";
        StrdsMunDelP = Expediente != null ? Expediente.getdsMunDelP() : "";
        StrCodMDP = Expediente != null ? Expediente.getCodMDP() : "";
        
        
        String StrclPaginaWeb = "628";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        MyUtil.InicializaParametrosC(628,Integer.parseInt(strclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        
        %>
        <script>fnOpenLinks()</script>
        
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>   
        
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
        
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="RecupGMM.jsp?'>"%>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=strclExpediente%>'>
        <%=MyUtil.ObjInput("Poliza","Poliza",Expediente != null ? Expediente.getPoliza() : "",true,false,25,92,"",true,false,12)%>
        <%=MyUtil.ObjInput("No. Siniestro","Siniestro",Expediente != null ? Expediente.getSiniestro() : "",true,false,150,92,"",true,true,22)%>
        <%=MyUtil.ObjInput("Nombre del Paciente","Paciente",Expediente != null ? Expediente.getPaciente(): "",true,true,25,130,"",true,true,60)%>
        <%=MyUtil.ObjInput("Nombre del Medico","Medico",Expediente != null ? Expediente.getMedico() : "",true,true,25,168,"",true,true,60)%>
        <%=MyUtil.ObjInput("Telefono","Telefono",Expediente != null ? Expediente.getTelefono() : "",true,true,25,206,"",true,true,20)%>
        <%=MyUtil.ObjInput("Telefono celular","Celular",Expediente != null ? Expediente.getCelular() : "",true,true,145,206,"",false,false,20)%>
        <%=MyUtil.ObjInput("Telefono movil","Movil",Expediente != null ? Expediente.getMovil(): "",true,true,265,206,"",false,false,20)%>
        <%=MyUtil.DoBlock("Datos Generales",0,0)%>
        
        <%=MyUtil.ObjInput("Nombre del Hospital","Hospital",Expediente != null ? Expediente.getHospital() : "",true,true,25,294,"",true,true,60)%>            
        <%=MyUtil.ObjComboMem(i18n.getMessage("message.title.entidad"),"CodEntH",StrdsEntFedH,StrCodEntH,cbEntidad.GeneraHTML(20,StrdsEntFedH),true,true,25,336,"","fnLlenaMunicipiosRGMMH()","",20,false,false)%>
        <%=MyUtil.ObjComboMem(i18n.getMessage("message.title.municipio"),"CodMDH",StrdsMunDelH,StrCodMDH,cbEntidad.GeneraHTMLMD(40,StrCodEntH,StrdsMunDelH),true,true,230,336,StrdsMunDelH,"","",20,false,false)%>     
        
        
        
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"ColoniaH",Expediente != null ? Expediente.getColoniaH() : "",true,true,25,374,"",false,false,60)%>                
        <%=MyUtil.ObjInput("Calle y Numero","CalleNumH",Expediente != null ? Expediente.getCalleH() : "",true,true,25,412,"",false,false,60)%>                                     
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CPH",Expediente != null ? Expediente.getCPH():"",true,true,25,450,"",false,false,7)%>                                     
        <%=MyUtil.DoBlock("Ubicación",0,0)%>          
        
        <%=MyUtil.ObjInput("Persona de Contacto ","PersonaContacto",Expediente != null ? Expediente.getPersona(): "",true,true,25,540,"",false,false,60)%>
        <%=MyUtil.ObjInput("Telefono Particular","TelefonoP",Expediente != null ? Expediente.getTelefonoP() : "",true,true,350,540,"",false,false,20)%>
        <%=MyUtil.ObjInput("Movil","MovilP",Expediente != null ? Expediente.getMovilP(): "",true,true,490,540,"",false,false,20)%>            
        <%=MyUtil.ObjInput("Nombre del Titular","Titular",Expediente != null ? Expediente.getTitular() : "",true,true,25,578,"",false,false,60)%>
        <%=MyUtil.ObjComboMem(i18n.getMessage("message.title.entidad"),"CodEntP",StrdsEntFedP,StrCodEntP,cbEntidad.GeneraHTML(20,StrdsEntFedP),true,true,25,616,"","fnLlenaMunicipiosRGMMP()","",20,false,false)%>
        <%=MyUtil.ObjComboMem(i18n.getMessage("message.title.municipio"),"CodMDP",StrdsMunDelP,StrCodMDP,cbEntidad.GeneraHTMLMD(40,StrCodEntP,StrdsMunDelP),true,true,350,616,StrdsMunDelP,"","",20,false,false)%>     
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"ColoniaP",Expediente != null ? Expediente.getColoniaP() : "",true,true,25,654,"",false,false,60)%>                
        <%=MyUtil.ObjInput("Calle y Numero","CalleNumP",Expediente != null ? Expediente.getCalleP() : "",true,true,350,654,"",false,false,60)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CPP",Expediente != null ? Expediente.getCPP() : "",true,true,25,692,"",false,false,7)%>                
        <%=MyUtil.ObjTextArea("Padecimiento","Padecimiento",Expediente != null ? Expediente.getPadecimiento() : "","120","4",true,true,25,730,"",true,false)%>
        <%=MyUtil.DoBlock("Seguridad",30,30)%>
        
        <%=MyUtil.GeneraScripts()%>
        
        <script>
       document.all.CPP.maxLength=5;
       document.all.CPH.maxLength=5;
        </script>
    </body>
</html>