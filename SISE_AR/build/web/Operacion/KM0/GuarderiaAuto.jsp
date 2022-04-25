<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="com.ike.asistencias.DAOAsistenciaVial,com.ike.asistencias.to.AsistenciaVial,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Custodia de Vehiculo</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>
    <body  class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilMask.js' ></script>
        <script src='../../Utilerias/UtilCalendario.js'></script>
        <script src='../../Utilerias/UtilAuto.js'></script>
        <script src='../../Utilerias/UtilAjax.js'></script>

        <%
            String StrclPaginaWeb = "6161";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            
            String StrclExpediente = "0";
            String StrclUsrApp = "0";
            String StrModelo = "";
            String StrColor = "";
            String StrPlacas = "";
            int StrclAsistenciaAuto = 0;
            String StrclMarcaAuto = "";
            String StrclPais = "";
            String StrdsPais = "";
            String StrdsEntFed = "";
            String StrCodEnt = "";
            String StrdsMunDel = "";
            String StrCodMD = "";
            String StrCodigoMarca = "0";
            //String StrDsTipoAuto = "";
            String StrClaveAMIS="";
            String StrDsTipoAuto= "";
            int iRowPx = 80;

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }
            
            /* VALIDAR QUE SE PUEDA TOMAR DIRECTAMENTE DE DAOAsistenciaVial
            if (session.getAttribute("CodigoMarca") != null) {
                StrCodigoMarca = session.getAttribute("CodigoMarca").toString();
            }
            */
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %>Fuera de Horario<%
                return;
            }

            DAOAsistenciaVial daoAsistenciaVial = new DAOAsistenciaVial();
            AsistenciaVial av = new AsistenciaVial();

            if (StrclExpediente != null) {
                av = daoAsistenciaVial.getAsistenciaVial(StrclExpediente);
                if (av != null) {
                    StrCodEnt = av.getCodEntO();
                    StrCodigoMarca = av.getClMarca();
                    StrDsTipoAuto = av.getDsTipoAuto();
                    StrClaveAMIS = av.getClaveAmis();
                    //StrclAsistenciaAuto = asistenciaVial.getClAsistenciaAuto(); //NO EXISTE
                    StrCodMD = av.getCodMDO();
                }

            } else {
                %> El expediente no existe <%
                StrclExpediente = null;
                StrclUsrApp = null;
                StrclPaginaWeb = null;
                return;
            }
            /*-------------------------------------------------------------------------------------*/

        %>
        <script type="text/javascript">fnOpenLinks()</script>

        <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb) , Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "fnLlenaComboAuto();", "")%>

        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='<%=StrclPaginaWeb%>'>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="GuarderiaAuto.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <input id="clLugarEvento" name="clLugarEvento" type="hidden" value="1">

        <%=MyUtil.ObjComboC("Marca de Auto", "CodigoMarca", av != null ? av.getDsMarca() : "", true, true, 30, iRowPx, StrCodigoMarca, "st_getMarcaAutoKM " + StrclExpediente, "fnLlenaTipoAutoAjax(this.value,'ClaveAMIS','Tipo de Auto','TipoAutoDiv','',2);", "", 50, true, false)%>
        <%=MyUtil.ObjComboCDiv("Tipo de Auto", "ClaveAMIS", av != null ? av.getDsTipoAuto() : "", true, true, 195, iRowPx, StrDsTipoAuto, "st_getTipoAutoKM '" + StrclMarcaAuto + "'," + StrclExpediente, "", "", 50, true, false, "TipoAutoDiv")%>
        <%iRowPx = iRowPx + 40;%>
        
        <%=MyUtil.ObjInput("Modelo", "Modelo", av != null ? av.getModelo() : "", true, true, 30, iRowPx, StrModelo, true, true, 7, "if(this.readOnly==false){fnValidaModelo(this)}")%>
        <%=MyUtil.ObjInput("Color", "Color", av != null ? av.getColor() : "", true, true, 130, iRowPx, StrColor, true, true, 11)%>
        <%=MyUtil.ObjInput("Patente", "Placas", av != null ? av.getPatente(): "", true, true, 250, iRowPx, StrPlacas, true, true, 9)%>
        <%iRowPx = iRowPx + 50;%>
        <%=MyUtil.ObjInputF("Fecha/Hora Entrada", "FechaEntrada", av != null ? av.getFechaEntrada(): "", true, false, 30, iRowPx, "", true, false, 20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInputF("Fecha/Hora Salida", "FechaSalida", av != null ? av.getFechaSalida() : "", true, false, 220, iRowPx, "", true, false, 20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%iRowPx = iRowPx + 60;%>
        <%=MyUtil.ObjTextArea("Dirección", "CalleNum", av != null ? av.getCalleO(): "", "65", "4", true, true, 30, iRowPx, "", false, false)%>
        <%iRowPx = iRowPx + 80;%>
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", av != null ? av.getObservaciones(): "", "65", "6", true, true, 30, iRowPx, "", false, false)%>
        <%=MyUtil.DoBlock("Custodia de Vehiculo", 50, 70)%>

        <INPUT id='ClaveAMISVTR' name='ClaveAMISVTR' type='hidden' value=''>
        <%=MyUtil.GeneraScripts()%>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <script>
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

            function fnLlenaComboAuto() {
                /*20160406 Se agrega para llenar las opciones de la marca seleccionada*/
                fnLlenaTipoAutoAjax(document.all.CodigoMarca.value, 'ClaveAMIS', 'Tipo de Auto', 'TipoAutoDiv', '', 2);
                cadenaTexto = '<%=StrDsTipoAuto%>';
                var nuevaOpc = document.createElement("OPTION");
                nuevaOpc.text = cadenaTexto.toString();
                nuevaOpc.value = "<%=StrClaveAMIS%>";
                forma.ClaveAMISC.add(nuevaOpc);
                document.all.ClaveAMISC.value = '<%=StrClaveAMIS%>'
                document.all.ClaveAMIS.value = '<%=StrClaveAMIS%>'
            }
        </script>
        <%
            if (av != null) {                 //si hay asiistencia
            %>
                <script>document.all.btnAlta.disabled = true;</script>
                <% } else {%>
                <script>document.all.btnCambio.disabled = false;</script>
            <%}%>
    </body>
    <%
        StrclExpediente = null;
        StrclUsrApp = null;
        StrclPaginaWeb = null;
        daoAsistenciaVial = null;
        av = null;
    %>
</html>
