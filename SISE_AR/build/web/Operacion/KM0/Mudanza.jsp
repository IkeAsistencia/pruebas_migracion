<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="com.ike.asistencias.DAOAsistenciaVial,com.ike.asistencias.to.AsistenciaVial,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF;"%>

<html>
    <head>
        <title>Movida</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>

    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAuto.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>

        <%
            String StrclUsrApp = "0";
            String StrclExpediente = "0";
            String StrclPaginaWeb = "6091";

            //  DATOS DE LA UBICACION ORIGEN, VIENEN DEL EXPEDIENTE EN SESION
            String StrclPais = "";
            String StrdsPais = "";
            String StrdsEntFed = "";
            String StrCodEnt = "";
            String StrdsMunDel = "";
            String StrCodMD = "";

            //  DATOS DE LA UBICACION DESTINO
            String StrclPaisDest = "";
            String StrdsEntFedDest = "";
            String StrCodEntDest = "";
            String StrdsMunDelDest = "";
            String StrCodMDDest = "";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            if (session.getAttribute("clExpediente") != null) {
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
 

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
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
                StrclPaisDest = null;
                StrdsEntFedDest = null;
                StrCodEntDest = null;
                StrdsMunDelDest = null;
                StrCodMDDest = null;
                return;
            }

            StringBuffer StrSql = new StringBuffer();

            DAOAsistenciaVial daoAV = null;
            AsistenciaVial AV = null;

            StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs.next()) {
                daoAV = new DAOAsistenciaVial();
                AV = daoAV.getAsistenciaVial(StrclExpediente);

                //  DATOS DE LA UBICACION DESTINO
                StrclPaisDest = AV != null ? AV.getClPaisD() : "";
                StrCodEntDest = AV != null ? AV.getCodEntD() : "";
                StrdsEntFedDest = AV != null ? AV.getDsEntFedD() : "";
                StrCodMDDest = AV != null ? AV.getCodMDD() : "";
                StrdsMunDelDest = AV != null ? AV.getDsMunDelD() : "";
            
                if (StrclPaisDest.equalsIgnoreCase("")) {
                    StrclPaisDest = "10";
                }
            } else {
        %> El expediente no existe <%

                rs.close();
                rs = null;

                StrclPais = null;
                StrdsPais = null;
                StrdsEntFed = null;
                StrCodEnt = null;
                StrdsMunDel = null;
                StrCodMD = null;
                StrclPaisDest = null;
                StrdsEntFedDest = null;
                StrCodEntDest = null;
                StrdsMunDelDest = null;
                StrCodMDDest = null;
                return;
            }

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "", "")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="Mudanza.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <!-- LOS SIGUIENTES CAMPOS SON NECESARIOS PARA LA TABLA AsistenciaKM0-->
        <INPUT id='ClaveAMIS' name='ClaveAMIS' type='hidden' value=''>
        <INPUT id='CodigoMarca' name='CodigoMarca' type='hidden' value=''>
        <INPUT id='clLugarEvento' name='clLugarEvento' type='hidden' value='0'>
        
        
        

        <%=MyUtil.ObjComboMem("Pais", "clPais", StrdsPais, StrclPais, cbPais.GeneraHTML(20, StrdsPais), false, false, 30, 80, StrclPais, "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", StrdsEntFed, StrCodEnt, cbEntidad.GeneraHTML(40, StrdsEntFed, Integer.parseInt(StrclPais)), false, false, 30, 120, StrCodEnt, "fnLLenaComboMDAjax(this.value);", "", 20, false, false, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", StrdsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(40, StrCodEnt, StrdsMunDel), false, false, 415, 120, StrCodMD, "", "", 20, false, false, "LocalidadDiv")%>
        <!--%=MyUtil.ObjInput("Colonia", "Colonia", AV != null ? AV.getColoniaO() : "", true, true, 30, 160, "", false, false, 40)%-->
        <%=MyUtil.ObjInput("Calle y Número", "CalleNum", AV != null ? AV.getCalleO() : "", true, true, 30, 160, "", false, false, 106)%>
        <%=MyUtil.ObjTextArea("Referencias Visuales", "Referencias", AV != null ? AV.getReferenciasO() : "", "105", "5", true, true, 30, 200, "", false, false)%>
        <%=MyUtil.DoBlock("Ubicación del Evento", -10, 40)%>

       <%=MyUtil.ObjInput("Cotizacion Flete", "CotizaFlete", AV != null ? AV.getCotizaFlete(): "", true, true, 30, 330, "", false, false, 50)%>
       <%=MyUtil.ObjInput("Costo Definitivo Flete", "CostoFlete", AV != null ? AV.getCostoFlete(): "", true, true, 30, 360, "", false, false, 50)%>
       <%=MyUtil.DoBlock("Flete", 80, 0)%>

        <%=MyUtil.ObjComboMem("Pais Destino", "clPaisDest", AV != null ? AV.getDsPaisD() : "", AV != null ? AV.getClPaisD() : "", cbPais.GeneraHTML(20, AV != null ? AV.getDsPaisD() : ""), true, true, 30, 450, "0", "fnLlenaEntidadAjaxFnDest(this.value);", "", 20, true, true)%>
        <%=MyUtil.ObjComboMemDiv("Provincia Destino", "CodEntDest", StrdsEntFedDest, StrCodEntDest, cbEntidad.GeneraHTML(40, StrdsEntFedDest, Integer.parseInt(StrclPaisDest)), true, true, 30, 490, "", "fnLLenaComboMDAjaxDest(this.value);", "", 20, true, true, "CodEntDivDest")%>
        <%=MyUtil.ObjComboMemDiv("Localidad Destino", "CodMDDest", StrdsMunDelDest, StrCodMDDest, cbEntidad.GeneraHTMLMD(40, StrCodEntDest, StrdsMunDelDest), true, true, 415, 490, "", "", "", 20, true, true, "LocalidadDivDest")%>
        <!--%=MyUtil.ObjInput("Colonia", "ColoniaDest", AV != null ? AV.getColoniaD() : "", true, true, 30, 530, "", false, false, 40)%-->
        <%=MyUtil.ObjInput("Calle y Número", "CalleNumDest", AV != null ? AV.getCalleD() : "", true, true, 30, 530, "", false, false, 106)%>
        <%=MyUtil.ObjTextArea("Referencias Visuales", "ReferenciasDest", AV != null ? AV.getReferenciasD() : "", "105", "5", true, true, 30, 575, "", false, false)%>
        <%=MyUtil.DoBlock("Destino", -10, 40)%>

        <%=MyUtil.GeneraScripts()%>

        <input name='ModeloMsk'  id='ModeloMsk' type='hidden' value='VN09VN09VN09VN09'>

        <%
            daoAV = null;
            AV = null;

            rs.close();
            rs = null;
        %>

        <script type="text/javascript">
            

            function fnLlenaEntidadAjaxFn(cod) {  /// Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion
                IDCombo = 'CodEnt';
                Label = 'Provincia';
                IdDiv = 'CodEntDiv';
                FnCombo = 'fnLLenaComboMDAjax(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion=" + cod + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjax(value) {
                IDCombo = 'CodMD';
                Label = 'Localidad';
                IdDiv = 'LocalidadDiv';
                FnCombo = '';
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion=" + value + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLlenaEntidadAjaxFnDest(cod) {  /// Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion
                IDCombo = 'CodEntDest';
                Label = 'Provincia Destino';
                IdDiv = 'CodEntDivDest';
                FnCombo = 'fnLLenaComboMDAjaxDest(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion=" + cod + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjaxDest(value) {
                IDCombo = 'CodMDDest';
                Label = 'Localidad Destino';
                IdDiv = 'LocalidadDivDest';
                FnCombo = '';                                                         //Valor de funcion que pasa ara que vuelva a construir utileria...
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion=" + value + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

        </script>
    </body>
</html>