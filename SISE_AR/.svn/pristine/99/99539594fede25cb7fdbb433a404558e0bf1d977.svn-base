<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="com.ike.asistencias.DAOAsistenciaMoto,com.ike.asistencias.to.AsistenciaMoto,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Guardería de Moto</title>
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
            String StrclExpediente = "0";
            String StrclUsrApp = "0";
            String StrclPaginaWeb = "0";
            String StrModelo = "";
            String StrColor = "";
            String StrPlacas = "";
            int StrclAsistenciaMoto = 0;
            String StrclMarcaAuto = "";
            String StrclPais = "";
            String StrdsPais = "";
            String StrdsEntFed = "";
            String StrCodEnt = "";
            String StrdsMunDel = "";
            String StrCodMD = "";
            String StrCodigoMarca = "0";
            String StrClaveAMIS = "";
            String StrDsTipoAuto = "";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }
            if (session.getAttribute("CodigoMarca") != null) {
                StrCodigoMarca = session.getAttribute("CodigoMarca").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
                StrclExpediente = null;
                StrclUsrApp = null;
                StrclPaginaWeb = null;
                return;
            }

            DAOAsistenciaMoto daoAsistenciaMoto = new DAOAsistenciaMoto();
            AsistenciaMoto asistenciaMoto = new AsistenciaMoto();
            if (StrclExpediente != null) {
                asistenciaMoto = daoAsistenciaMoto.getDetalleAsistenciaMoto(StrclExpediente);
                if (asistenciaMoto != null) {
                    StrCodEnt = asistenciaMoto.getCodEnt();
                    StrCodigoMarca = asistenciaMoto.getCodigoMarca();
                    StrDsTipoAuto = asistenciaMoto.getDsTipoMoto();
                    StrClaveAMIS = asistenciaMoto.getClaveAMIS();
                    StrclAsistenciaMoto = asistenciaMoto.getClAsistenciaMoto();
                    StrCodMD = asistenciaMoto.getCodMD();

                }

            } else {
        %> El expediente no existe <%
                StrclExpediente = null;
                StrclUsrApp = null;
                StrclPaginaWeb = null;
                return;
            }
            /**
             * BETA. Sirve para que el tamaño del doBlock sea automatico en esta
             * caso solo aplica en el pimer DoBlock, ya que el segundo DoBlock
             * no respeta los tamaños que se le asigna mediante el Query, toma
             * los valores del primer DoBlock, siendo que son valores
             * independientes. NOTA: Esto puede ser causa a que los Combos se
             * llenan de diferenre manera
             */
            StringBuffer StrSql = new StringBuffer();
            int ValorTipoMoto = 0;
            StrSql.append("select  top 1 len(dsTipoAuto) [ValorTipoMoto] from cTipoAuto where codigomarca = ");
            StrSql.append(StrCodigoMarca).append(" and activo=1 order by 1 desc");
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            if (rs.next()) {
                ValorTipoMoto = (-85 + (4 * rs.getInt("ValorTipoMoto")));
            }
            rs.close();
            /*-------------------------------------------------------------------------------------*/

        %>
        <script type="text/javascript">fnOpenLinks()</script>

        <%            StrclPaginaWeb = "6105";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

            MyUtil.InicializaParametrosC(6105, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "fnLlenaComboAuto();", "")%>

        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='6105'>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="GuarderiaMoto.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='clAsistenciaMoto' name='clAsistenciaMoto' type='hidden' value='<%=StrclAsistenciaMoto%>'>

        <%=MyUtil.ObjComboC("Marca de Moto", "CodigoMarca", asistenciaMoto != null ? asistenciaMoto.getDsMarca() : "", true, true, 30, 80, StrCodigoMarca, "st_getMarcaAutoKM " + StrclExpediente, "fnLlenaTipoAutoAjax(this.value,'ClaveAMIS','Tipo de Auto','TipoAutoDiv','',2);", "", 50, true, false)%>
        <%=MyUtil.ObjComboCDiv("Tipo de Moto", "ClaveAMIS", asistenciaMoto != null ? asistenciaMoto.getDsTipoMoto() : "", true, true, 220, 80, "", "st_getTipoAutoKM '" + StrCodigoMarca + "'," + StrclExpediente, "", "", 50, true, false, "TipoAutoDiv")%>
        <%=MyUtil.ObjInput("Modelo", "Modelo", asistenciaMoto != null ? asistenciaMoto.getModelo() : "", true, true, 30, 120, StrModelo, true, true, 7, "if(this.readOnly==false){fnValidaModelo(this)}")%>
        <%=MyUtil.ObjInput("Color", "Color", asistenciaMoto != null ? asistenciaMoto.getColor() : "", true, true, 130, 120, StrColor, true, true, 11)%>
        <%=MyUtil.ObjInput("Patente", "Placas", asistenciaMoto != null ? asistenciaMoto.getPlacas() : "", true, true, 250, 120, StrPlacas, true, true, 9)%>

        <%=MyUtil.ObjInputF("Fecha/Hora Entrada", "FechaEntrada", asistenciaMoto != null ? asistenciaMoto.getFechaEntrada() : "", true, false, 30, 170, "", true, false, 20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInputF("Fecha/Hora Salida", "FechaSalida", asistenciaMoto != null ? asistenciaMoto.getFechaSalida() : "", true, false, 220, 170, "", true, false, 20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjTextArea("Dirección", "Direccion", asistenciaMoto != null ? asistenciaMoto.getDireccion() : "", "65", "4", true, true, 30, 230, "", false, false)%>
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", asistenciaMoto != null ? asistenciaMoto.getObservaciones() : "", "65", "6", true, true, 30, 310, "", false, false)%>
        <%=MyUtil.DoBlock("Guardería de Moto", ValorTipoMoto, 70)%>


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
            if (asistenciaMoto != null) {
                //si hay asiistencia
        %>
        <script>
            document.all.btnAlta.disabled = true;
        </script>
        <%
        } else {
        %>
        <script>
            document.all.btnCambio.disabled = false;
        </script>
        <%
            } %>
    </body>


    <%
        StrclExpediente = null;
        StrclUsrApp = null;
        StrclPaginaWeb = null;

        daoAsistenciaMoto = null;
        asistenciaMoto = null;
    %>
</html>
