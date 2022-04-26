<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="com.ike.asistencias.DAOGiantAssist,com.ike.asistencias.to.GiantAssist,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF;"%>

<html>
     <head>
        <title>Línea Bici</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>

    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>

        <%
            String StrclUsrApp = "0";
            String StrclExpediente = "0";
            String StrclPaginaWeb = "6086";
            
            String StrclPais = "10";
            String StrdsPais = "";
            String StrdsEntFed = "";
            String StrCodEnt = "";
            String StrdsMunDel = "";
            String StrCodMD = "";
            String StrclTipoBici = "";
            String StrdsTipoBici = "";
            String StrclTipoReparacionB = "";
            String StrdsReparacionB = "";
            
            String StrclCuenta = "0";
            String StrClave = "";
            
            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
                        
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
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
                StrclTipoBici = null;
                StrdsTipoBici = null;
                StrclTipoReparacionB = null;
                StrdsReparacionB = null;
                StrclCuenta = null;
                StrClave = null;
                
                return;  
            }    
     
            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }            
            
            StringBuffer StrSql = new StringBuffer();

            DAOGiantAssist daoGA = null;
            GiantAssist GA  = null;

            StrSql.append("st_TieneAsistenciaExp '").append(StrclExpediente).append("'");
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs.next()) {
                daoGA = new DAOGiantAssist();
                GA = daoGA.getGiantAssist(StrclExpediente);     
                
                StrclPais = GA != null ? GA.getClPais().toString() : "10";
                StrdsPais = GA != null ? GA.getDsPais() : "";
                StrCodEnt = GA != null ? GA.getCodEnt().toString() : "";                
                StrdsEntFed = GA != null ? GA.getDsEntFed() : "";
                StrCodMD = GA != null ? GA.getCodMD().toString() : "";                
                StrdsMunDel = GA != null ? GA.getDsMunDel() : "";
                StrclTipoBici  = GA != null ? GA.getClTipoBici(): "";
                StrdsTipoBici  = GA != null ? GA.getDsTipoBici(): "";
                StrclTipoReparacionB = GA != null ? GA.getClTipoReparacionB() : "";
                StrdsReparacionB = GA != null ? GA.getTipoReparacionB() : "";
                                
            } else {
        %> El expediente no existe <%

                rs.close();
                rs = null;
                
                StrclUsrApp = null;
                StrclExpediente = null;
                StrclPaginaWeb = null;
                StrclPais = null;
                StrdsPais = null;
                StrdsEntFed = null;
                StrCodEnt = null;
                StrdsMunDel = null;
                StrCodMD = null;
                StrclTipoBici = null;
                StrdsTipoBici = null;
                StrclTipoReparacionB = null;
                StrdsReparacionB = null;
                StrclCuenta = null;
                StrClave = null;
                return;
            }

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(6086, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "fnAdd();", "")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="LineaBici.jsp?"%>'>
       <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjComboMem("Pais", "clPais", StrdsPais, StrclPais, cbPais.GeneraHTML(20, StrdsPais), true, true, 30, 80, StrclPais, "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", StrdsEntFed, StrCodEnt, cbEntidad.GeneraHTML(40, StrdsEntFed, Integer.parseInt(StrclPais)), true, true, 30, 120, StrCodEnt, "fnLLenaComboMDAjax(this.value);", "", 20, false, false, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", StrdsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(40, StrCodEnt, StrdsMunDel), true, true, 415, 120, StrCodMD, "", "", 20, false, false, "LocalidadDiv")%>

        <%=MyUtil.ObjInput("Calle y Número", "CalleNum", GA != null ? GA.getCalleNum(): "", true, true, 30, 160, "", false, false, 106)%>
        <%=MyUtil.ObjTextArea("Referencias Visuales", "referenciasVisuales", GA != null ? GA.getReferenciasVisuales(): "", "105", "5", true, true, 30, 200, "", false, false)%>
        <%=MyUtil.DoBlock("Ubicación del Evento", 110, 40)%>
       
        <%=MyUtil.ObjComboC("Tipo de Bici", "clTipoBici", StrdsTipoBici, true, true, 30, 330, StrclTipoBici, "select clTipoBici,dsTipoBici from cTipoBici", "", "", 50, true, true)%>
        <%=MyUtil.ObjComboC("Tipo de Reparacion", "clTipoReparacionB", StrdsReparacionB, true, true, 400, 330, StrclTipoReparacionB, "select clTipoReparacionB,tipoReparacionB from ctipoReparaBici", "", "", 50, true, true)%>
        <%=MyUtil.ObjTextArea("Observaciones", "observaciones", GA != null ? GA.getObservaciones(): "", "105", "5", true, true, 30, 368, "", false, false)%>
   
        <%=MyUtil.DoBlock("Línea BICI", 100, 50)%>

        <%=MyUtil.GeneraScripts()%>
        
        <%
            daoGA = null;
            GA = null;

            rs.close();
            rs = null;

            StrclUsrApp = null;
            StrclExpediente = null;
            StrclPaginaWeb = null;
            StrclPais = null;
            StrdsPais = null;
            StrdsEntFed = null;
            StrCodEnt = null;
            StrdsMunDel = null;
            StrCodMD = null;
            StrclTipoBici = null;
            StrdsTipoBici = null;
            StrclTipoReparacionB = null;
            StrdsReparacionB = null;
            StrclCuenta = null;
            StrClave = null;

        %>

        <script type="text/javascript">

            function fnLlenaEntidadAjaxFn(cod) {  
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
            
            function fnAdd(){
                document.all.clTipoBici.value = "";
                document.all.clTipoBiciC.value = "";
                document.all.clTipoReparacionB.value = "";
                document.all.clTipoReparacionBC.value = "";
            }            
        </script>
    </body>
</html>