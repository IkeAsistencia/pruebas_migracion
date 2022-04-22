<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.asistencias.DAOAsistenciaTrasladosRemis,com.ike.asistencias.to.AsistenciaTrasladosRemis,java.sql.ResultSet,Utilerias.UtileriasBDF,Combos.cbPais,Combos.cbEntidad,Seguridad.SeguridadC" errorPage="" %>
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
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>
        
        <%
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es", "AR");

        String StrclUsrApp = "0";
        String StrclExpediente = "0";
        String StrclPaginaWeb = "148";
        String StrFecha = "";

        String StrclPais = "";
        String StrdsPais = "";
        String StrCodEnt = "";
        String StrdsEntFed = "";
        String StrCodMD = "";
        String StrdsMunDel = "";
        String StrclPaisResid = "";
        String StrdsPaisResid = "";
        String StrCodEntResid = "";
        String StrdsEntFedResid = "";
        String StrCodMDResid = "";
        String StrdsMunDelResid = "";

        if (session.getAttribute("clUsrApp") != null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if (session.getAttribute("clExpediente") != null) {
            StrclExpediente = session.getAttribute("clExpediente").toString();
        }

        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%

            StrclUsrApp = null;
            StrclExpediente = null;
            StrclPaginaWeb = null;
            StrFecha = null;

            StrclPais = null;
            StrdsPais = null;
            StrCodEnt = null;
            StrdsEntFed = null;
            StrCodMD = null;
            StrdsMunDel = null;
            StrclPaisResid = null;
            StrdsPaisResid = null;
            StrCodEntResid = null;
            StrdsEntFedResid = null;
            StrCodMDResid = null;
            StrdsMunDelResid = null;

            return;
        }

        StringBuffer StrSql = new StringBuffer();
        
        DAOAsistenciaTrasladosRemis daoATR = null;
        AsistenciaTrasladosRemis ATR = null ; 
        
        ResultSet rsf = UtileriasBDF.rsSQLNP( "Select convert(varchar(20),getdate(),120) FechaApertura ");
        if (rsf.next()){
            StrFecha = rsf.getString("FechaApertura");
        }
        
        StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0, StrSql.length());

        if (rs.next()) {

            daoATR = new DAOAsistenciaTrasladosRemis();
            ATR = daoATR.getAsistenciaTrasladosRemis(StrclExpediente);

            StrclPais = ATR != null ? ATR.getClPais() : "";
            StrdsPais = ATR != null ? ATR.getDsPais() : "";
            StrCodEnt = ATR != null ? ATR.getCodEnt() : "";
            StrdsEntFed = ATR != null ? ATR.getDsEntFed() : "";
            StrCodMD = ATR != null ? ATR.getCodMD() : "";
            StrdsMunDel = ATR != null ? ATR.getDsMunDel() : "";
            StrclPaisResid = ATR != null ? ATR.getClPaisResid() : "";
            StrdsPaisResid = ATR != null ? ATR.getDsPaisResid() : "";
            StrCodEntResid = ATR != null ? ATR.getCodEntResid() : "";
            StrdsEntFedResid = ATR != null ? ATR.getDsEntFedResid() : "";
            StrCodMDResid = ATR != null ? ATR.getCodMDResid() : "";
            StrdsMunDelResid = ATR != null ? ATR.getDsMunDelResid() : "";
            
            if (StrclPais.equalsIgnoreCase("")) {
                StrclPais = "10";
            }      

            if (StrclPaisResid.equalsIgnoreCase("")) {
                StrclPaisResid = "10";
            }
        }else{
        %>El expediente no existe<%
            rs.close();
            rs = null;
            rsf.close();
            rsf = null;
            
            StrSql = null;

            StrclPais = null;
            StrdsPais = null;
            StrCodEnt = null;
            StrdsEntFed = null;
            StrCodMD = null;
            StrdsMunDel = null;
            StrclPaisResid = null;
            StrdsPaisResid = null;
            StrCodEntResid = null;
            StrdsEntFedResid = null;
            StrCodMDResid = null;
            StrdsMunDelResid = null;

            return;       
        }
        
         session.setAttribute("clPaginaWebP", StrclPaginaWeb);      
        %>         
        
        <script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(148, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "fnLimpiaExtraResid()")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="Taxi.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjInput("Fecha Apertura", "FechaApertura", ATR != null ? ATR.getFechaApertura() : "", false, false, 340, 70, StrFecha, true, true, 25)%>
        <%=MyUtil.ObjInput("Fecha Registro", "FechaRegistroVTR", ATR != null ? ATR.getFechaRegistro() : "", false, false, 510, 70, "", false, true, 25)%>
        <%=MyUtil.ObjInput("Número de Pasajeros", "NumPasajeros", ATR != null ? ATR.getNumPasajeros() : "", true, true, 30, 70, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Número de Maletas", "NumMaletas", ATR != null ? ATR.getNumMaletas() : "", true, true, 190, 70, "", false, false, 10, "EsNumerico(document.all.NumMaletas)")%>
        <%=MyUtil.ObjComboMem("Pais", "clPais", StrdsPais, StrclPais, cbPais.GeneraHTML(20, StrdsPais), false, false, 30, 110, StrclPais, "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", StrdsEntFed, StrCodEnt, cbEntidad.GeneraHTML(40, StrdsEntFed, Integer.parseInt(StrclPais)), true, true, 290, 110, StrCodEnt, "fnLLenaComboMDAjax(this.value);", "", 20, false, false, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", StrdsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(40, StrCodEnt, StrdsMunDel), true, true, 30, 150, StrCodMD, "", "", 20, false, false, "LocalidadDiv")%>
        <%=MyUtil.ObjInput("Calle y Número de su Ubicación Actual", "CalleNumActual", ATR != null ? ATR.getCalleNumActual() : "", true, true, 340, 150, "", false, false, 60)%>
        <%=MyUtil.ObjTextArea("Referencias Visuales", "ReferVisuales", ATR != null ? ATR.getReferVisuales() : "", "74", "4", true, true, 30, 190, "", false, false)%>
        <%=MyUtil.ObjInput("Teléfono de su Ubicación", "TelUbicacion", ATR != null ? ATR.getTelUbicacion() : "", true, true, 30, 270, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Teléfono Celular", "TelCelular", ATR != null ? ATR.getTelCelular() : "", true, true, 230, 270, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Costo de Cotización", "CostoCotizacion", ATR != null ? ATR.getCostoCotizacion() : "", true, true, 390, 270, "", true, true, 15, "EsNumerico(document.all.CostoCotizacion)")%>
        <%=MyUtil.ObjInput("Costo Final", "CostoFinal",ATR != null ? ATR.getCostoFinal() : "", true, true, 560, 270, "", true, true, 15, "EsNumerico(document.all.CostoFinal)")%>
        <%=MyUtil.DoBlock("Detalle del Taxi", -70, 0)%>
      
        <%=MyUtil.ObjComboMem("Pais", "clPaisResid", StrdsPaisResid, StrclPaisResid, cbPais.GeneraHTML(20, StrdsPaisResid), false, false, 30, 360, StrclPaisResid, "fnLlenaEntidadRAjaxFn(this.value);", "", 20, false, false)%>
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEntResid", StrdsEntFedResid, StrCodEntResid, cbEntidad.GeneraHTML(40, StrdsEntFedResid, Integer.parseInt(StrclPaisResid)), true, true, 290, 360, StrCodEntResid, "fnLLenaComboMDRAjax(this.value);", "", 20, false, false, "CodEntResidDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMDResid", StrdsMunDelResid, StrCodMDResid, cbEntidad.GeneraHTMLMD(40, StrCodEntResid, StrdsMunDelResid), true, true, 30, 400, StrCodMDResid, "", "", 20, false, false, "LocalidadResidDiv")%>
        <%=MyUtil.ObjInput("Calle y Número ", "CalleNumResid", ATR != null ? ATR.getCalleNumResid() : "", true, true, 340, 400, "", false, false, 60)%>
        <%=MyUtil.DoBlock("Ubicación del Destino del Taxi", 150, 0)%>
        
        <%=MyUtil.GeneraScripts()%>
        <%
            daoATR = null;
            ATR = null;

            rs.close();
            rs = null;
            rsf.close();
            rsf = null;

            StrclUsrApp = null;
            StrclExpediente = null;
            StrclPaginaWeb = null;
            StrFecha = null;

            StrclPais = null;
            StrdsPais = null;
            StrCodEnt = null;
            StrdsEntFed = null;
            StrCodMD = null;
            StrdsMunDel = null;
            StrclPaisResid = null;
            StrdsPaisResid = null;
            StrCodEntResid = null;
            StrdsEntFedResid = null;
            StrCodMDResid = null;
            StrdsMunDelResid = null;

        %>
        
        <script type="text/javascript">

            function fnLlenaEntidadAjaxFn(cod){  // Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion
                IDCombo= 'CodEnt';
                Label='Provincia';
                IdDiv='CodEntDiv';
                FnCombo='fnLLenaComboMDAjax(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion="+cod+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjax(value){
                IDCombo= 'CodMD';
                Label='Localidad';
                IdDiv='LocalidadDiv';
                FnCombo='';
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion="+value+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLlenaEntidadRAjaxFn() {
                IDCombo= 'CodEntResid';
                Label='Provincia';
                IdDiv='CodEntResidDiv';
                FnCombo='fnLLenaComboMDRAjax(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion="+cod+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDRAjax(value){
                IDCombo= 'CodMDResid';
                Label='Localidad';
                IdDiv='LocalidadResidDiv';
                FnCombo='';
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion="+value+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            document.all.NumPasajeros.maxLength=30;
            document.all.NumMaletas.maxLength=2;
            document.all.CalleNumActual.maxLength=60;
            document.all.TelUbicacion.maxLength=20;
            document.all.TelCelular.maxLength=20;
            document.all.CalleNumResid.maxLength=60;

        </script>
        
    </body>
</html>
