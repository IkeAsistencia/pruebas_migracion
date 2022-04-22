<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="com.ike.asistencias.DAOALineaMarron,com.ike.asistencias.to.DetalleALineaMarron,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF"%>

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

        <%
                    String StrclUsrApp = "";
                    String StrclExpediente = "";
                    String StrclPaginaWeb = "170";

                    //  DATOS DE LA UBICACION ORIGEN, VIENEN DEL EXPEDIENTE EN SESION
                    String StrclPais = "";
                    String StrdsPais = "";
                    String StrCodEnt = "";
                    String StrdsEntFed = "";
                    String StrCodMD = "";
                    String StrdsMunDel = "";

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
                        StrCodEnt = null;
                        StrdsEntFed = null;
                        StrCodMD = null;
                        StrdsMunDel = null;
                        return;
                    }

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
        %>

        <script>fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(170, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "", "fnValGuardado();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="LineaMarron.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjTextArea("Tipo de Electrodoméstico", "tipoElectrodomestico", LM != null ? LM.getTipoElectrodomestico() : "", "50", "5", true, true, 30, 80, "", true, true)%>
        <%=MyUtil.ObjTextArea("Descripción de la Falla", "DescripcionFalla", LM != null ? LM.getDescripcionFalla() : "", "50", "5", true, true, 380, 80, "", true, true)%>
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", LM != null ? LM.getObservaciones() : "", "50", "6", true, true, 30, 170, "", false, false)%>
        <%=MyUtil.ObjChkBox("Cita Programada", "EsProgramado", LM != null ? LM.getEsProgramado() : "", true, true, 380, 170, "0", "fnValidaFecha()")%>
        <div class='VTable' id='divFechaProgMom'>
            <%=MyUtil.ObjInputF("Fecha Programada (AAAA-MM-DD)", "FechaProgMom", LM != null ? LM.getFechaProgMom() : "", true, true, 380, 220, "", false, false, 20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};")%>
        </div>
        <%=MyUtil.DoBlock("Datos Generales de la Asistencia - Línea Marrón", 100, 0)%>

        <%=MyUtil.ObjComboMem("Pais", "clPais", StrdsPaisOtro, StrclPaisOtro, cbPais.GeneraHTML(20, StrdsPaisOtro), true, true, 30, 320, StrclPais, "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", StrdsEntFedOtro, StrCodEntOtro, cbEntidad.GeneraHTML(40, StrdsEntFed, Integer.parseInt(StrclPais)), true, true, 30, 360, StrCodEnt, "fnLLenaComboMDAjax(this.value);", "", 20, false, false, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", StrdsMunDelOtro, StrCodMDOtro, cbEntidad.GeneraHTMLMD(40, StrCodEnt, StrdsMunDel), true, true, 30, 400, StrCodMD, "", "", 20, false, false, "LocalidadDiv")%>
        <%=MyUtil.ObjTextArea("Referencias Visuales", "Referencias", LM != null ? LM.getReferencias() : "", "65", "5", true, true, 30, 440, "", false, false)%>
        <%=MyUtil.DoBlock("Domicilio", 230, 40)%>

        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <%=MyUtil.GeneraScripts()%>

        <%
                    rs.close();
                    rs = null;

                    daoLM = null;
                    LM = null;

                    StrclUsrApp = null;
                    StrclExpediente = null;
                    StrclPaginaWeb = null;
                    StrclPais = null;
                    StrCodEnt = null;

        %>

        <script type="text/javascript">

            function fnOnload(){
                if(document.all.EsProgramado.value == "1"){
                    document.all.divFechaProgMom.style.visibility="visible";
                }
                else{
                    document.all.divFechaProgMom.style.visibility="hidden";
                }
            }

            function fnLlenaEntidadAjaxFn(cod){  /// Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion
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

            function fnValidaFecha(){
                if(document.all.EsProgramado.value == "1"){
                    document.all.divFechaProgMom.style.visibility="visible";
                }
                else{
                    document.all.divFechaProgMom.style.visibility="hidden";
                    document.all.FechaProgMom.value = ""
                }
            }

            function fnValGuardado(){
                if(document.all.EsProgramado.value == "1" && document.all.FechaProgMom.value == ""){
                    msgVal=msgVal + " Fecha Programada. ";
                    document.all.btnGuarda.disabled= false;
                    document.all.btnCancela.disabled= false;
                }
            }

        </script>
    </body>
</html>

