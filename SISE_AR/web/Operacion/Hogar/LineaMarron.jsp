<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.asistencias.DAOALineaMarron,com.ike.asistencias.to.DetalleALineaMarron,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
    <head>
        <title>Detalle Línea Marrón</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="fnOnload();">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilDireccion.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilCalendarioV.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src="../../Geolocalizacion/js/jquery.js"></script>
        <%
                    String StrclUsrApp = "0";
                    if (session.getAttribute("clUsrApp") != null) {
                        StrclUsrApp = session.getAttribute("clUsrApp").toString();                    }
                    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                        %>LA SESION EXPIRO<%
                        StrclUsrApp = null;
                        return;
                    }
                    String StrclExpediente = "";
                    String StrclPaginaWeb = "170";
                    String StrclServicio = "";
                    String StrclSubServicio = "";                   
                    //  DATOS DE LA UBICACION ORIGEN, VIENEN DEL EXPEDIENTE EN SESION
                    String StrclPais = "";
                    String StrdsPais = "";
                    String StrCodEnt = "";
                    String StrdsEntFed = "";
                    String StrCodMD = "";
                    String StrdsMunDel = "";                   
                    if (session.getAttribute("clExpediente") != null) {
                        StrclExpediente = session.getAttribute("clExpediente").toString();                    }
                    if (session.getAttribute("clPais") != null) {
                        StrclPais = session.getAttribute("clPais").toString();                    }
                    if (session.getAttribute("dsPais") != null) {
                        StrdsPais = session.getAttribute("dsPais").toString();                    }
                    if (session.getAttribute("CodEnt") != null) {
                        StrCodEnt = session.getAttribute("CodEnt").toString();                    }
                    if (session.getAttribute("dsEntFed") != null) {
                        StrdsEntFed = session.getAttribute("dsEntFed").toString();                    }
                    if (session.getAttribute("CodMD") != null) {
                        StrCodMD = session.getAttribute("CodMD").toString();                    }
                    if (session.getAttribute("dsMunDel") != null) {
                        StrdsMunDel = session.getAttribute("dsMunDel").toString();                    }
                    if (session.getAttribute("clServicio") != null) {
                        StrclServicio = session.getAttribute("clServicio").toString();                    }
                    if (session.getAttribute("clSubServicio") != null) {
                        StrclSubServicio = session.getAttribute("clSubServicio").toString();                    }
                    //  DATOS DE UBICACION
                    String StrclPaisOtro = "";
                    String StrdsPaisOtro = "";
                    String StrCodEntOtro = "";
                    String StrdsEntFedOtro = "";
                    String StrCodMDOtro = "";
                    String StrdsMunDelOtro = "";
                    StringBuffer StrSql = new StringBuffer();
                    DAOALineaMarron daoLM = null;
                    DetalleALineaMarron LM = null;
                    StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
                    ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
                    StrSql.delete(0, StrSql.length());
                    if (rs.next()) {
                        daoLM = new DAOALineaMarron();
                        LM = daoLM.getDetalleALineaMarron(StrclExpediente);
                        //  DATOS DE LA UBICACION
                        StrclPaisOtro = LM != null ? LM.getClPais() : "";
                        StrdsPaisOtro = LM != null ? LM.getDsPais() : "";
                        StrCodEntOtro = LM != null ? LM.getCodEnt() : "";
                        StrdsEntFedOtro = LM != null ? LM.getDsEntFed() : "";
                        StrCodMDOtro = LM != null ? LM.getCodMD() : "";
                        StrdsMunDelOtro = LM != null ? LM.getDsMunDel() : "";
                    } else {
                        %> El expediente no existe <%
                        rs.close();
                        rs = null;
                        StrclPais = null;
                        StrdsPais = null;
                        StrCodEnt = null;
                        StrdsEntFed = null;
                        StrCodMD = null;
                        StrdsMunDel = null;
                        return;
                    }
                    session.setAttribute("clPaginaWebP", StrclPaginaWeb);
                    int iRowPx = 80;
        %>

        <script>fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(170, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "fnAccionesAlta();", "fnValGuardado();")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="LineaMarron.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <% if ( StrclSubServicio.equals("471") ) { %>
            <%=MyUtil.ObjComboC("Tipo de falla", "clTipoFallaH", LM != null ? LM.getDsTipoFallaH() : "", true, true, 30, iRowPx, "", "st_getTipoFalla ".concat("0").concat(", ").concat(StrclSubServicio), "fnMostrarFrigorias();", "", 50, true, true)%>
            <div id="frigoriasContainer" style="visibility: hidden">
                <%=MyUtil.ObjInput("Frigorias", "Frigorias", LM != null ? LM.getFrigorias() : "", true, true, 250, iRowPx, "", false, false, 25)%>                                             
            </div>
            <%=MyUtil.DoBlock("Aire Acondicionado", 40, 0)%>
        <% } else { %>
        <%=MyUtil.ObjTextArea("Tipo de Electrodoméstico", "tipoElectrodomestico", LM != null ? LM.getTipoElectrodomestico() : "", "50", "5", true, true, 30, iRowPx, "", true, true)%>
        <%=MyUtil.ObjTextArea("Descripción de la Falla", "DescripcionFalla", LM != null ? LM.getDescripcionFalla() : "", "50", "5", true, true, 380, iRowPx, "", true, true)%>
        <%  iRowPx = iRowPx + 90;    %>
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", LM != null ? LM.getObservaciones() : "", "50", "6", true, true, 30, iRowPx, "", false, false)%>
        <%=MyUtil.ObjChkBox("Cita Programada", "EsProgramado", LM != null ? LM.getEsProgramado() : "", true, true, 380, iRowPx, "0", "fnValidaFecha()")%>
        <%  iRowPx = iRowPx + 50;    %>
        <div class='VTable' id='divFechaProgMom'>
            <%=MyUtil.ObjInputF("Fecha Programada (AAAA-MM-DD)", "FechaProgMom", LM != null ? LM.getFechaProgMom() : "", true, true, 380, iRowPx, "", false, false, 20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};")%>
        </div>
        <%=MyUtil.DoBlock("Datos Generales de la Asistencia - Línea Marrón", 100, 0)%>
        <% } %>
        <%  iRowPx = iRowPx + 100;    %>
        <%=MyUtil.ObjComboMem("Pais", "clPais", StrdsPaisOtro, StrclPaisOtro, cbPais.GeneraHTML(20, StrdsPaisOtro), true, true, 30, iRowPx, StrclPais, "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
        <%  iRowPx = iRowPx + 40;    %>
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", StrdsEntFedOtro, StrCodEntOtro, cbEntidad.GeneraHTML(40, StrdsEntFed, Integer.parseInt(StrclPais)), true, true, 30, iRowPx, StrCodEnt, "fnLLenaComboMDAjax(this.value);", "", 20, false, false, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", StrdsMunDelOtro, StrCodMDOtro, cbEntidad.GeneraHTMLMD(40, StrCodEnt, StrdsMunDel), true, true, 250, iRowPx, StrCodMD, "", "", 20, false, false, "LocalidadDiv")%>
        <% if (StrclSubServicio.equals("471")) {%>
            <%  iRowPx = iRowPx + 40;   %>
            <%=MyUtil.ObjInput("Piso", "Piso", LM != null ? LM.getPiso() : "", true, true, 30, iRowPx, "", false, false, 3)%>
            <%=MyUtil.ObjInput("Departamento", "Departamento", LM != null ? LM.getDepartamento(): "", true, true, 250, iRowPx, "", false, false, 8)%>
        <% } %>
        <%  iRowPx = iRowPx + 40;    %>
        <%=MyUtil.ObjTextArea("Referencias Visuales", "Referencias", LM != null ? LM.getReferencias() : "", "65", "5", true, true, 30, iRowPx, "", false, false)%>
        <%=MyUtil.DoBlock("Domicilio", 40, 40)%>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <%=MyUtil.GeneraScripts()%>

        <%
                    rs.close();
                    rs = null;
                    daoLM = null;
                    LM = null;
                    StrclPaginaWeb = null;
                    StrclPais = null;
                    StrCodEnt = null;
        %>
        <script type="text/javascript">
//------------------------------------------------------------------------------
            function fnOnload(){
                if(document.all.EsProgramado.value == "1"){
                    document.all.divFechaProgMom.style.visibility="visible";
                }else{
                    document.all.divFechaProgMom.style.visibility="hidden";     }
            }   
//------------------------------------------------------------------------------
            $(document).ready(function() {
                fnMostrarFrigorias();
            })
//------------------------------------------------------------------------------
            function fnLlenaEntidadAjaxFn(cod){  /// Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion
                IDCombo= 'CodEnt';
                Label='Provincia';
                IdDiv='CodEntDiv';
                FnCombo='fnLLenaComboMDAjax(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion="+cod+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }
//------------------------------------------------------------------------------
            function fnLLenaComboMDAjax(value){
                IDCombo= 'CodMD';
                Label='Localidad';
                IdDiv='LocalidadDiv';
                FnCombo='';
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion="+value+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }
//------------------------------------------------------------------------------
            function fnValidaFecha(){
                if(document.all.EsProgramado.value == "1"){
                    document.all.divFechaProgMom.style.visibility="visible";
                }else{
                    document.all.divFechaProgMom.style.visibility="hidden";
                    document.all.FechaProgMom.value = ""
                }
            }
//------------------------------------------------------------------------------
            function fnEsPisoValido() {
                var piso = $("#Piso").val();
                //No es campo obligatorio
                if (piso.length === 0) return true;
                var esPisoValido = isNaN(piso) ? piso.toString().toUpperCase() === "PB" : piso > -16 && piso < 101;
                if (!esPisoValido) {
                    msgVal = msgVal + ' El piso debe expresarse de forma númerica entre -15 y 100. En caso de ser planta baja también puede escribir "pb".';
                }
                return esPisoValido;
            }
//------------------------------------------------------------------------------
            function fnEsDepartamentoValido() {
                var depto = $("#Departamento").val();
                //No es campo obligatorio
                if (depto.length === 0) return true;
                var esDeptoValido = depto.length <= 8;
                if (!esDeptoValido) {
                    msgVal = msgVal + ' El campo departamento debe tener como máximo 8 caracteres.';     }
                return esDeptoValido;
            }
//------------------------------------------------------------------------------
            function fnEsfrigoriasValidas() {
                var frigorias = $("#Frigorias").val();
                var validaFrigorias = !isNaN(frigorias) && frigorias > 0;
                if (!validaFrigorias) msgVal = msgVal + ' Las frigorias deben ser mayor a 0 y expresadas con números.';
                return validaFrigorias;
            }
//------------------------------------------------------------------------------
            function fnValGuardado(){
                var clSubServicio = <%=StrclSubServicio%>;
                if (clSubServicio !== 471){
                    if(document.all.EsProgramado.value == "1" && document.all.FechaProgMom.value == ""){
                        msgVal=msgVal + " Fecha Programada. ";
                        document.all.btnGuarda.disabled= false;
                        document.all.btnCancela.disabled= false;
                    }
                }else {
                    var falla = $("#clTipoFallaHC").children(":selected").text();
                    var frigoriasInvalidas = falla === "Instalación" && !fnEsfrigoriasValidas();
                    var PisoODeptoInvalidos = !fnEsPisoValido() || !fnEsDepartamentoValido();
                    if (frigoriasInvalidas || PisoODeptoInvalidos) {
                        document.all.btnGuarda.disabled= false;
                        document.all.btnCancela.disabled= false;
                        return;
                    }
                    fnGuardaSeguimiento();
                }
            }
//------------------------------------------------------------------------------
            function fnMostrarFrigorias() {
                var combobox  = document.getElementById("clTipoFallaHC");
                var lugarOU = combobox.options[combobox.selectedIndex].text;
                if (lugarOU.toString().toUpperCase() === "INSTALACIÓN") {
                    document.getElementById("frigoriasContainer").style.visibility = "visible";
                    document.getElementById("Frigorias").disabled = false;        
                }else {
                    document.getElementById("Frigorias").disabled = true;
                    document.getElementById("frigoriasContainer").style.visibility = "hidden";
                }
            }
//------------------------------------------------------------------------------
            function fnAccionesAlta() {
                var clServicio = <%=StrclServicio%>;
                var clSubServicio = <%=StrclSubServicio%>;
                if (clServicio === 3 && clSubServicio === 471) {
                    alert("Recuerde que si es una instalación en altura pueden variar los costos.");             }
            }
//------------------------------------------------------------------------------
            function fnGuardaSeguimiento() {                
                var falla = $("#clTipoFallaHC").children(":selected").text();
                var frigorias = falla === "Instalación" ? $("#Frigorias").val() : ""; 
                var detalleExp = 'Problema: ' + falla;
                if (falla === "Instalación") {
                    detalleExp = detalleExp + '; Frigorias: ' + frigorias;                }
                var clExpediente = <%=StrclExpediente%>;
                var clUsrApp = <%=Integer.parseInt(StrclUsrApp)%>;               
                var datos = {
                    clExpediente: clExpediente,
                    clUsrApp: clUsrApp,
                    descripcionOcurrido: detalleExp,
                }
                $.when(
                    $.ajax({
                        type: "POST",
                        url: "./InsertInfoAdicionalHogar.jsp",
                        async: false,
                        data: datos,
                        dataType: 'Json',
                        success: function(responseData, status, xhr) {},
                        error: function(req, status, error) {},
                    }));                
            }
//------------------------------------------------------------------------------
        </script>
    </body>
</html>

