<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="com.ike.asistencias.DAOAsistenciaTraslado,com.ike.asistencias.to.AsistenciaTransladoRestos,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF"%>

<html>
    <head>
        <title>ArrastreGrua</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>

    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../../Utilerias/Util.js'></script>
        <script src='../../Utilerias/UtilAjax.js'></script>
        <script src='../../Utilerias/UtilMask.js'></script>

        <%
            String StrclUsrApp = "0";
            String StrclExpediente = "0";
            String StrclPaginaWeb = "6106";
            int StrClTrasladoRestos = 0;

            String StrclPais = "";
            String StrdsPais = "";
            String StrdsEntFed = "";
            String StrCodEnt = "";
            String StrdsMunDel = "";
            String StrCodMD = "";

            String StrclPaisDest = "0";
            String StrdsEntFedDest = "";
            String StrCodEntDest = "";
            String StrdsMunDelDest = "";
            String StrCodMDDest = "";
            String FechaCita = "";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }
            if (session.getAttribute("clPais") != null) {
                StrclPais = session.getAttribute("clPais").toString();
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

            DAOAsistenciaTraslado daoAsistenciaTraslado = new DAOAsistenciaTraslado();
            AsistenciaTransladoRestos asistenciaTransladoRestos = new AsistenciaTransladoRestos();

            StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs.next()) {
                asistenciaTransladoRestos = daoAsistenciaTraslado.getDetalleAsistenciaTraslado(StrclExpediente);
                if (asistenciaTransladoRestos != null) {
                    StrclPaisDest = asistenciaTransladoRestos.getClPaisDestino();
                    StrClTrasladoRestos = asistenciaTransladoRestos.getClAsistenciaTraslado();
                    StrCodEntDest = asistenciaTransladoRestos.getCodEntDestino();
                    StrdsEntFedDest = asistenciaTransladoRestos.getDsCodEntDestino();
                    StrCodMDDest = asistenciaTransladoRestos.getCodMDODestino();
                    StrdsMunDelDest = asistenciaTransladoRestos.getDsCodMDDestino();
                    StrdsPais = asistenciaTransladoRestos.getDsPaisOrigen();
                    StrdsEntFed = asistenciaTransladoRestos.getDsCodEntOrigen();
                    StrCodEnt = asistenciaTransladoRestos.getCodEntOrigen();
                    StrdsMunDel = asistenciaTransladoRestos.getDsCodMDOrigen();
                    StrCodMD = asistenciaTransladoRestos.getCodMDOrigen();
                    System.out.println("::::: " + asistenciaTransladoRestos.getFechaCita());
                    if (asistenciaTransladoRestos.getFechaCita() != null) {
                        FechaCita = asistenciaTransladoRestos.getFechaCita();
                    }
                }
            }
            //System.out.println("asistenciaTransladoRestos.getFechaCita(): " + asistenciaTransladoRestos.getFechaCita());
            /**
             * BETA. Sirve para que el tama�o del doBlock sea automatico XD.
             * NOTA: Poner codigo en un clase para mandar a llamar y no poner a
             * cada vez el codigo a utilizar =D
             */
            int Valor = 0, Valor2 = 0;
            if (asistenciaTransladoRestos != null) {
                StrSql.append("select  top 1 len(dsMunDel) [Valor], ").append("(select  top 1 len(dsMunDel) [Valor] from cMunDel where CodEnt =").append(StrCodEntDest).append("order by 1 desc) [Valor2]");
                StrSql.append("from cMunDel where CodEnt =").append(StrCodEnt).append("order by 1 desc");
                ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql.toString());
                StrSql.delete(0, StrSql.length());
                if (rs2.next()) {
                    Valor = (-80 + (5 * rs2.getInt("Valor")));
                    Valor2 = (-80 + (5 * rs2.getInt("Valor2")));
                }
                rs.close();
            }
            /*-------------------------------------------------------------------------------------*/

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(6106, Integer.parseInt(StrclUsrApp));%>

        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "fnFecha()", "fnFecha()", "")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="TrasladoRestos.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='clTrasladoRestos' name='clTrasladoRestos' type='hidden' value='<%=StrClTrasladoRestos%>'>

        <%=MyUtil.ObjComboMem("Pais", "clPaisOrigen", StrdsPais, StrclPais, cbPais.GeneraHTML(20, StrdsPais), true, true, 30, 80, StrclPais, "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
        <%=MyUtil.ObjComboMemDiv("Provincia", "codEntOrigen", StrdsEntFed, StrCodEnt, cbEntidad.GeneraHTML(40, StrdsEntFed, Integer.parseInt(StrclPais)), true, true, 30, 120, StrCodEnt, "fnLLenaComboMDAjax(this.value);", "", 20, false, false, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "codMDOrigen", StrdsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(40, StrCodEnt, StrdsMunDel), true, true, 415, 120, StrCodMD, "", "", 20, false, false, "LocalidadDiv")%>
        <%=MyUtil.ObjInput("Calle y N�mero", "direccionOrigen", asistenciaTransladoRestos != null ? asistenciaTransladoRestos.getDireccionOrigen() : "", true, true, 30, 160, "", false, false, 106)%>
        <%=MyUtil.ObjTextArea("Referencias Visuales", "ReferenciaVisualOrigen", asistenciaTransladoRestos != null ? asistenciaTransladoRestos.getReferenciaVisualOrigen() : "", "105", "5", true, true, 30, 200, "", false, false)%>
        <%=MyUtil.DoBlock("Ubicaci�n del Evento", Valor, 40)%>

        <%=MyUtil.ObjInput("Nombre del Titular", "nombreTitular", asistenciaTransladoRestos != null ? asistenciaTransladoRestos.getNombreTitular() : "", true, true, 30, 330, "", true, true, 35)%>
        <%=MyUtil.ObjInput("Fecha del Deceso", "fechaDeceso", asistenciaTransladoRestos != null ? asistenciaTransladoRestos.getFechaDeceso() : "", true, true, 255, 330, "", true, true, 23, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjTextArea("Observaciones", "observaciones", asistenciaTransladoRestos != null ? asistenciaTransladoRestos.getObservaciones() : "", "70", "4", true, true, 30, 380, "", false, false)%>
        <%=MyUtil.DoBlock("Detalle De la Asistencia", -25, 25)%>

        <%=MyUtil.ObjComboMem("Pais Destino", "clPaisDestino", asistenciaTransladoRestos != null ? asistenciaTransladoRestos.getDsPaisDestino() : "", StrclPaisDest, cbPais.GeneraHTML(20, asistenciaTransladoRestos != null ? asistenciaTransladoRestos.getDsPaisDestino() : ""), true, true, 30, 500, "0", "fnLlenaEntidadAjaxFnDest(this.value);", "", 20, true, true)%>
        <%=MyUtil.ObjComboMemDiv("Provincia Destino", "codEntDestino", StrdsEntFedDest, StrCodEntDest, cbEntidad.GeneraHTML(40, StrdsEntFedDest, Integer.parseInt(StrclPaisDest)), true, true, 30, 540, StrdsEntFedDest, "fnLLenaComboMDAjaxDest(this.value);", "", 20, true, true, "CodEntDivDest")%>
        <%=MyUtil.ObjComboMemDiv("Localidad Destino", "codMDDestino", StrdsMunDelDest, StrCodMDDest, cbEntidad.GeneraHTMLMD(40, StrCodEntDest, StrdsMunDelDest), true, true, 415, 540, "", "", "", 20, true, true, "LocalidadDivDest")%>
        <%=MyUtil.ObjInput("Calle y N�mero", "direccionDestino", asistenciaTransladoRestos != null ? asistenciaTransladoRestos.getDireccionDestino() : "", true, true, 30, 580, "", false, false, 106)%>
        <%=MyUtil.ObjTextArea("Referencias Visuales", "ReferenciaVisualDestino", asistenciaTransladoRestos != null ? asistenciaTransladoRestos.getReferenciaVisualDestino() : "", "105", "5", true, true, 30, 625, "", false, false)%>
        <%=MyUtil.DoBlock("Ubicaci�n de Destino", Valor2, 40)%>

        <%=MyUtil.ObjChkBox("Cita", "cita", asistenciaTransladoRestos != null ? asistenciaTransladoRestos.getCita() : "", false, false, 465, 330, "1", "SI", "NO", "fnFecha();")%>
        <%=MyUtil.ObjInput("Fecha Cita<br>aaaa/mm/dd hh:mm", "fechaCita", FechaCita, false, false, 550, 330, "", false, false, 25, "")%>
        <%=MyUtil.DoBlock("Programaci�n de Cita", 0, 20)%>

        <%=MyUtil.GeneraScripts()%>

        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <script>

            function fnLlenaEntidadAjaxFn(cod) {  /// Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion
                IDCombo = 'codEntOrigen';
                Label = 'Provincia';
                IdDiv = 'CodEntDiv';
                FnCombo = 'fnLLenaComboMDAjax(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion=" + cod + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjax(value) {
                IDCombo = 'codMDOrigen';
                Label = 'Localidad';
                IdDiv = 'LocalidadDiv';
                FnCombo = '';
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion=" + value + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLlenaEntidadAjaxFnDest(cod) {  /// Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion
                IDCombo = 'codEntDestino';
                Label = 'Provincia Destino';
                IdDiv = 'CodEntDivDest';
                FnCombo = 'fnLLenaComboMDAjaxDest(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion=" + cod + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjaxDest(value) {
                IDCombo = 'codMDDestino';
                Label = 'Localidad Destino';
                IdDiv = 'LocalidadDivDest';
                //FnCombo = 'fnValLugar()';                                                         //Valor de funcion que pasa ara que vuelva a construir utileria...
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion=" + value + "&IdCombo=" + IDCombo + "&Label=" + Label;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnFecha() {
                //alert(document.all.cita.value)
                if (document.all.cita.value == 0) {
                    // document.all.D13.style.display = "none";
                }
                if (document.all.cita.value == 1) {
                    //document.all.D13.style.display = "block";
                }
                //validaFecha();
            }


            function validaFecha() {
                //alert("entro validaFecha")
                //alert(document.all.fechaCita.value)
                value = /^[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] [0-2][0-9]:[0-5][0-9]$/

                if (document.all.cita.value == 1 && document.getElementById("fechaCita").value != "") {
                    if (!value.exec(document.getElementById("fechaCita").value))
                    {
                        alert("La fecha no tiene formato AAAA-MM-DD HH:MM:SS")
                        document.getElementById("fechaCita").focus();
                    }
                } else {
                    document.getElementById("fechaCita").value = "";
                }
            }

            document.all.btnElimina.disabled = true;
        </script>

        <%
            if (asistenciaTransladoRestos != null) {
                //si hay asiistencia
        %>
        <script>
            document.all.btnAlta.disabled = true;
        </script>
        <%
        } else {
        %>
        <script>
            document.all.btnCambio.disabled = true;
        </script>
        <%
            } %>

    </body>
    <%
        daoAsistenciaTraslado = null;
        asistenciaTransladoRestos = null;

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


    %>
</html>