<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,com.ike.asistencias.DAOEnfermeriaDomicilio,com.ike.asistencias.to.DetalleEnfermeriaDomicilio" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%> 
<html>
    <head><title>Enfermeria a Domicilio</title>
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
        
        String StrclExpediente = "0";
        String StrclUsrApp="0";
        String StrclPaginaWeb = "6137";
        
        String StrclPais = "10";
        String StrdsPais = "";
        String StrdsEntFed = "";
        String StrCodEnt = "";
        String StrdsMunDel = "";
        String StrCodMD = "";
        String StrCalleNum = "";
        String StrclCuenta = "0";
        String StrClave = "";
        String StrdsSubServicio = "";
        String StrLimiteMonto = "";
        String StrclSubServicio = "0";
        String StrclUbFallaH = "0";
        
        
        if (session.getAttribute("clUsrApp")!= null){
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (session.getAttribute("clExpediente")!= null)        {
            StrclExpediente = session.getAttribute("clExpediente").toString();
        }
        
        if (session.getAttribute("clPais") != null) {
                StrclPais = session.getAttribute("clPais").toString();
            }
            
            if (session.getAttribute("dsPais") != null) {
                StrdsPais = session.getAttribute("dsPais").toString();
            }
            
            if (session.getAttribute("CodEnt") != null) {
                StrCodEnt = session.getAttribute("CodEnt").toString();
            }
            
            if (session.getAttribute("dsEntFed") != null) {
                StrdsEntFed = session.getAttribute("dsEntFed").toString();
            }
            
            if (session.getAttribute("CodMD") != null) {
                StrCodMD = session.getAttribute("CodMD").toString();
            }
            
            if (session.getAttribute("dsMunDel") != null) {
                StrdsMunDel = session.getAttribute("dsMunDel").toString();
            }
            
            if (session.getAttribute("clCuenta") != null) {
                StrclCuenta = session.getAttribute("clCuenta").toString();
            }
            
            if (session.getAttribute("Clave") != null) {
                StrClave = session.getAttribute("Clave").toString();
            }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)  {
        %>Fuera de Horario<% 
            StrclUsrApp = null;
            StrclExpediente = null;
            StrclPaginaWeb = null;
            StrclPais = null;
            StrdsPais = null;
            StrdsEntFed = null;
            StrCodEnt = null;
            StrdsMunDel = null;
            StrCodMD = null;
            StrclCuenta = null;
            StrClave = null;
            StrCalleNum = null;
            return;
        }
        
        
        //Verifica si existe asistencia
        StringBuffer StrSql =new StringBuffer();

        DAOEnfermeriaDomicilio daoED = null;
        DetalleEnfermeriaDomicilio ED = null;

        StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0, StrSql.length());     
        
        if (rs.next()){
                daoED = new DAOEnfermeriaDomicilio();
                ED = daoED.getDetalleEnfermeriaDomicilio(StrclExpediente);
            }else{
            %>El expediente no existe<%
            rs.close();
            rs=null;
            
            StrclExpediente = null;
            StrclPaginaWeb = null;
            StrclPais = null;
            StrdsPais = null;
            StrdsEntFed = null;
            StrCodEnt = null;
            StrdsMunDel = null;
            StrCodMD = null;
            StrclCuenta = null;
            StrClave = null;
            StrCalleNum = null;
            
            return;
        }
        
        StrSql.append(" st_getDatosAfiliadoGral '").append(StrClave).append("','").append(StrclCuenta).append("'");
        ResultSet rsDatosAfil = UtileriasBDF.rsSQLNP(StrSql.toString());

        StrSql.delete(0, StrSql.length());

        if (rsDatosAfil.next()) {
            StrCalleNum = rsDatosAfil.getString("calleNum");
        }
        
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
        <script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(6137,Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="EnfermeriaDomicilio.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        
        <%=MyUtil.ObjInput("Nombre del Paciente","Paciente",ED != null ? ED.getPaciente() : "",true,true,30,80,"",true,true,60)%>
        <%=MyUtil.ObjInput("Edad","Edad",ED != null ? ED.getEdad() : "",true,true,370,80,"",false,false,10,"fnRango(document.all.Edad,0,150)")%>
        <%=MyUtil.DoBlock("Servicio de Enfermera/o a Domicilio",-30,0)%>
        
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", StrdsEntFed, StrCodEnt, cbEntidad.GeneraHTML(40, StrdsEntFed, Integer.parseInt(StrclPais)), false, false, 30, 180, StrCodEnt, "fnLLenaComboMDAjax(this.value,2);", "", 20, false, false, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", StrdsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(40, StrCodEnt, StrdsMunDel), false, false, 30, 220, StrCodMD, "", "", 20, false, false, "LocalidadDiv")%>
        <%=MyUtil.ObjInput("Calle y Número", "Calle", ED != null ? ED.getCalle() : "", true, true, 30, 260, StrCalleNum, false, false, 76)%>
        <%=MyUtil.DoBlock("Ubicación del Paciente", 220, 20)%>
        
        <%=MyUtil.ObjInput("Padecimiento","Padecimiento",ED != null ? ED.getPadecimiento() : "",true,true,30,380,"",true,true,50)%> 
        <%=MyUtil.ObjInput("Médico Tratante","MedicoAtendio",ED != null ? ED.getMedicoAtendio(): "",true,true,330,380,"",false,false,50)%>
        <%=MyUtil.ObjTextArea("Diagnóstico","DiagnosticoDx",ED != null ? ED.getDiagnosticoDx(): "","105","2",true,true,30,420,"",false,false)%>
        <%=MyUtil.ObjTextArea("Tratamiento","TratamientoTx",ED != null ? ED.getTratamientoTx() : "","105","2",true,true,30,480,"",false,false)%>
        <%=MyUtil.DoBlock("Datos de la Evaluación",95,20)%>      
        
        <%=MyUtil.GeneraScripts()%>
        
        <%
            rs.close();
            rs=null;

            daoED = null;
            ED = null;
        
            StrSql=null;
            StrclExpediente = null;
            StrclUsrApp=null;
            StrclPaginaWeb=null;
            StrclExpediente = null;
           
            StrclPais = null;
            StrdsPais = null;
            StrdsEntFed = null;
            StrCodEnt = null;
            StrdsMunDel = null;
            StrCodMD = null;
            StrclCuenta = null;
            StrClave = null;
            StrCalleNum = null;
        
        %>
        
        <script>
     document.all.Paciente.maxLength=50; 
     document.all.Edad.maxLength=3;   
     //document.all.PesoKg.maxLength=7;   
     document.all.Calle.maxLength=80;   
     document.all.MedicoAtendio.maxLength=50;   
     document.all.Padecimiento.maxLength=50;   
    // document.all.DiagnosticoDx.maxLength=200;      
    // document.all.TratamientoTx.maxLength=200;           
        </script>
        
    </body>
</html>
