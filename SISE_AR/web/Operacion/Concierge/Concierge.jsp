<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,com.ike.concierge.DAOConciergeAltaNU,com.ike.concierge.Conciergealtanu" errorPage="" %>
<html>
    <head>
        <title>Concierge</title>
        <meta http-equiv='X-UA-Compatible' content='IE=9'/>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/dhtmlwindow.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="../../Utilerias/overlib.js"></script>
        <script src='../../Utilerias/dhtmlwindow.js'></script>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilCalendario.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilConciergeAsistencias.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>
        <script type="text/javascript" >
            overlib_pagedefaults(WIDTH, 250, FGCOLOR, '#BED2EA', BGCOLOR, 'blue', TEXTFONT, "Arial, Helvetica, Verdana", TEXTSIZE, ".8em");
        </script>
        <style type="text/css">
            .Negro{background-color: #000000}
            .Gris{background-color: #9E9E9E}
            .Amarillo{background-color: #FFFF21}
            .UsuarioVIP{background-color: #FFFF00}
            .Texto1{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold; color: #FF9900; text-transform: uppercase; text-align:center;}
        </style>
    </head>

    <%
        String StrclPaginaWeb = "709";
        String StrclConcierge = "0";
        String strclUsr = "";
        String StrWarmTransfer = "";
        String StrclPaisFactura = "";
        String StrdsEntFedFact = "";
        String StrCodEntFact = "";
        String StrdsMunDelFact = "";
        String StrCodMDFact = "";
        String StrctrlDiv = "0";
        String clCuenta = "";
        String Clave = "";
        String StrclPaisOrigen = "";
        String strclPaisBIN = "";
        String strDocumento = "";

        DAOConciergeAltaNU daos = null;
        Conciergealtanu CA = null;

        if (session.getAttribute("clUsrApp") != null) {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }

        if (request.getParameter("clConcierge") != null) {
            StrclConcierge = request.getParameter("clConcierge").toString();
        } else {
            if (session.getAttribute("clConcierge") != null) {
                StrclConcierge = session.getAttribute("clConcierge").toString();
            }
        }
        session.setAttribute("clConcierge", StrclConcierge);
        session.setAttribute("clPaginaWebP", StrclPaginaWeb);
    %>

    <body class="cssBody" OnLoad="fnHabilitaAsistencia();
            fnChkHistorial(<%=StrclConcierge%>);">


        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>

        <script>fnOpenLinks()</script>

        <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(strclUsr));

            if (strclUsr != null) {

                daos = new DAOConciergeAltaNU();
                CA = daos.getConciergeNU(StrclConcierge);

                if (StrclPaisFactura.equalsIgnoreCase("")) {
                    StrclPaisFactura = "10";
                } else {
                    StrclPaisFactura = CA != null ? CA.getClPaisFactura() : "";
                }

                StrCodEntFact = CA != null ? CA.getCodEntFactura() : "";
                session.setAttribute("CodEnt", StrCodEntFact);

                StrdsEntFedFact = CA != null ? CA.getDsEntFedFactura() : "";
                session.setAttribute("dsEntFed", StrdsEntFedFact);

                StrdsMunDelFact = CA != null ? CA.getDsMunDelFactura() : "";
                session.setAttribute("dsMunDel", StrdsMunDelFact);

                StrCodMDFact = CA != null ? CA.getCodMDFactura() : "";
                session.setAttribute("CodMD", StrCodMDFact);
                //System.out.println("Pais:" + StrclPaisFactura + ", StrCodEntFact: " + StrCodEntFact + ", StrdsEntFedFact:" + StrdsEntFedFact + ", StrdsMunDelFact:" + StrdsMunDelFact + ", StrCodMDFact:" + StrCodMDFact);
            }
        %>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionConcierge", "fnAccionAlta();fnValUssVIP();", "fnValUssVIP();", "fnValidaAfiliado();")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>Concierge.jsp?'>
        <%

            clCuenta = CA != null ? CA.getClCuenta().trim() : "";
            session.setAttribute("clCuenta", clCuenta);

            Clave = CA != null ? CA.getClave().trim() : "";
            StrWarmTransfer = CA != null ? CA.getWarmTransfer() : "";
            StrclPaisOrigen = CA != null ? CA.getClPaisOrigenNU() : "";
            strclPaisBIN = CA != null ? CA.getClPaisBIN() : "";

            session.setAttribute("Clave", Clave);
            session.setAttribute("clAsistencia", null);
            session.setAttribute("clSubservicio", null);
            session.setAttribute("clTipoUsConcierge", (CA != null ? CA.getClTipoUsConcierge() : "0"));
            session.setAttribute("dsTUC", (CA != null ? CA.getdsTipoUsConcierge() : ""));

            //System.out.println("WarmTransfer: " + StrWarmTransfer + ", Cuenta: " + clCuenta);

        %>

        <div class='VTable' id="btnAsist" style="position:absolute; z-index:25; left:15px; top:45px; visibility:hidden">
            <input class='cBtn' type='button' value='Nuevo Evento' onClick="fnNuevoEvento();">
        </div>
        <div class='VTable' id="btnHist" style="position:absolute; z-index:25; left:190px; top:45px; visibility:hidden">
            <input class='cBtn' type='button' value='Listado de Eventos Solicitados' onClick="fnAbrirHistorialNU();">
        </div>
        <div class='VTable' id="btnCober" style="position:absolute; z-index:25; left:480px; top:45px; visibility:hidden">
            <input class='cBtn' type='button' value='Cobertura' onClick="fnGetCobertura();">
        </div>
        <div class='VTable' id="btnCambios" style="position:absolute; z-index:25; left:640px; top:45px; visibility:hidden">
            <input class='cBtn' type='button' value='Historico de Cambios' onClick="fnAbrirBitacoraNU();">
        </div>

        <INPUT id='clConcierge' name='clConcierge' type='hidden' value='<%=CA != null ? CA.getClConcierge().trim() : ""%>'>
        <INPUT id='clAfiliado' name='clAfiliado' type='hidden' value=''>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr.toString()%>'>
        <INPUT id='clCuenta' name='clCuenta' type='hidden' value="<%=CA != null ? CA.getClCuenta().trim() : ""%>">
        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='hidden' value="<%=StrclPaginaWeb%>">
        
        <%=MyUtil.ObjInput("Cuenta", "NombreVTR", CA != null ? CA.getDsCuenta().trim() : "", true, false, 25, 90, "", true, false, 40, "if(this.readOnly==false){fnBuscaCuenta();}")%>
        <% if (MyUtil.blnAccess[4] == true) {%>
        <div class='VTable' style='position:absolute; z-index:25; left:244px; top:100px;'>
            <IMG alt="Haz clic aquí para realizar una búsqueda." SRC='../../Imagenes/Lupa.gif' onClick='fnBuscaCuenta();' WIDTH=20 HEIGHT=20></div>
            <% }%>
        <div onmouseover="return overlib('Favor de Capturar el Nombre(s) Completo + Apellido Paterno + Apellido Materno.', CENTER);" onmouseout="return nd();">
            <%=MyUtil.ObjInput("Nuestro Usuario", "NuestroUsuario", CA != null ? CA.getNuestroUsuario().trim() : "", true, false, 290, 90, "", true, true, 40, "if(this.readOnly==false){fnBuscaClienteVIP()}")%>
            <% if (MyUtil.blnAccess[4] == true) {%>
            <div class='VTable' style='position:absolute; z-index:25; left:510px; top:100px;'>
                <IMG alt="Haz clic aquí para realizar una búsqueda."  SRC='../../Imagenes/Lupa.gif' onClick='fnBuscaAfiliado();' WIDTH=20 HEIGHT=20></div>
                <%}%>
        </div>
        <%=MyUtil.ObjInput("Clave", "Clave", CA != null ? CA.getClave().trim() : "", true, false, 555, 90, "", true, true, 28, "fnValidaBin(this);fnValidaClaveBCP(this);")%>

        <%=MyUtil.ObjInput("Documento", "dsTipoDocumento", CA != null ? CA.getDsTipoDocumento().trim() : "", true, true, 725, 90, "", false, false, 25, "fnValidaDoc();")%>
        <%=MyUtil.ObjInputFA("Fecha Nacimiento (AAAA-MM-DD)", "FechaNacNU", CA != null ? CA.getFechaNacNU().trim() : "", true, true, 25, 135, "", false, false, 20, 2, "fnFechaNac();if(this.readOnly==false){fnValMask(this,document.all.FechNacMsk.value,this.name)};")%>
        <%=MyUtil.ObjComboC("Sexo", "clSexo", CA != null ? CA.getDsSexo().trim() : "", true, true, 250, 135, "", "select clSexo, dsSexo from cSexo", "", "", 5, true, true)%>
        <%=MyUtil.ObjComboC("Título", "clTitulo", CA != null ? CA.getDsTitulo().trim() : "", true, true, 420, 135, "", "select clTipoPersona, dsTipoPersona from CSTipoPersona", "", "", 5, true, true)%>
        <%=MyUtil.ObjInput("Pertenece al banco:", "NombreBanco", CA != null ? CA.getNomBancoBIN().trim() : "", false, false, 590, 135, "", false, false, 52, "")%>
        <%=MyUtil.ObjComboC("País de Origen", "clPaisOrigenNU", CA != null ? CA.getDsPaisOrigenNU().trim() : "", true, true, 25, 180, "", "st_CSPaisOrigen", "fnLlenaCiudadOrigen();", "", 5, true, true)%>
        <%=MyUtil.ObjComboC("Ciudad de Origen", "clCiudadOrigenNU", CA != null ? CA.getDsCiudadOrigenNU().trim() : "", true, true, 190, 180, "", "st_CSCiudadOrigen " + StrclPaisOrigen, "", "", 5, true, true)%>
        <%=MyUtil.ObjChkBox("Típo Usuario Activo ", "TUConciergeAct", CA != null ? CA.getTUConciergeAct() : "", true, true, 420, 180, "0", "SI", "NO", "fnValidaTUC()")%>
        <%=MyUtil.ObjComboC("Típo de Usuario", "clTipoUsConcierge", CA != null ? CA.getdsTipoUsConcierge() : "", true, true, 570, 180, "", "select clTipoUsConcierge,dsTipoUsConcierge from cTipoUsConcierge ", "", "", 5, false, false)%>
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", CA != null ? CA.getObservaciones().trim() : "", "70", "5", true, true, 25, 225, "", false, false, "", "")%>
        <%=MyUtil.DoBlock("Datos del Contacto", -37, 40)%>

        <%=MyUtil.ObjInput("Teléfono Hogar", "TelHogarNU", CA != null ? CA.getTelHogarNU().trim() : "", true, true, 25, 355, "", false, false, 25)%>
        <div onmouseover="return overlib('Favor de capturar el Teléfono Celular sin espacios ni guiones a 10 números.', CENTER);" onmouseout="return nd();">
            <%=MyUtil.ObjInput("Teléfono Celular", "TelCelularNU", CA != null ? CA.getTelCelularNU().trim() : "", true, true, 180, 355, "", false, false, 25, "fnEsNumerico(this);")%>
        </div>
        <%=MyUtil.ObjInput("Teléfono Oficina", "TelOficinaNU", CA != null ? CA.getTelOficinaNU().trim() : "", true, true, 335, 355, "", false, false, 25)%>
        <%=MyUtil.ObjInput("Otro Teléfono", "TelOtroNU", CA != null ? CA.getTelOtroNU().trim() : "", true, true, 25, 395, "", false, false, 25)%>
        <%=MyUtil.ObjInput("Teléfono Alterno", "TelAlternoNU", CA != null ? CA.getTelAlternoNU().trim() : "", true, true, 180, 395, "", false, false, 25)%>
        <%=MyUtil.ObjInput("Fax", "FaxNU", CA != null ? CA.getFaxNU().trim() : "", true, true, 335, 395, "", false, false, 25)%>
        <%=MyUtil.ObjInput("E-mail Comercial", "EmailComercialNU", CA != null ? CA.getEmailComercialNU().trim() : "", true, true, 25, 445, "", false, false, 45, "validarEmail(this);")%>
        <%=MyUtil.ObjInput("E-mail Personal", "EmailPersonalNU", CA != null ? CA.getEmailPersonalNU().trim() : "", true, true, 280, 445, "", false, false, 45, "validarEmail(this);")%>
        <%=MyUtil.ObjInput("E-mail Alterno", "EmailAlternoNU", CA != null ? CA.getEmailAlternoNU().trim() : "", true, true, 25, 485, "", false, false, 45, "validarEmail(this);")%>
        <%=MyUtil.ObjInput("E-mail Otro", "EmailOtroNU", CA != null ? CA.getEmailOtroNU().trim() : "", true, true, 280, 485, "", false, false, 45, "validarEmail(this);")%>
        <%=MyUtil.DoBlock("Datos del Contacto", 10, -10)%>

        <%=MyUtil.ObjComboC("Usuario Concierge", "clUsrConcierge", CA != null ? CA.getDsUsrConcierge().trim() : "", true, true, 565, 355, "", "select clUsrConcierge,dsUsrConcierge from cCSUsrConcierge where Activo=1", "", "", 10, false, false)%>
        <%=MyUtil.ObjComboC("Usuario Alterno", "clUsrConciergeAlterno", CA != null ? CA.getDsUsrConciergeAlterno().trim() : "", true, true, 565, 395, "", "select clUsrConcierge,dsUsrConcierge from cCSUsrConcierge where Activo=1", "", "", 10, false, false)%>
        <%=MyUtil.DoBlock("Usuario Concierge / Seguimiento", 30, -1)%>

        <%=MyUtil.ObjInput("Nombre", "NombreAsis", CA != null ? CA.getNombreAsis().trim() : "", true, true, 25, 565, "", false, false, 45)%>
        <%=MyUtil.ObjInput("Parentesco / Título", "TituloAsis", CA != null ? CA.getTituloAsis().trim() : "", true, true, 280, 565, "", false, false, 25)%>
        <%=MyUtil.ObjInputF("Fecha Nacimiento (AAAA-MM-DD)", "FechaNacAsis", CA != null ? CA.getFechaNacAsis().trim() : "", true, true, 440, 565, "", false, false, 20, 2, "fnFechaNac();if(this.readOnly==false){fnValMask(this,document.all.FechNacMsk.value,this.name)};")%>
        <%=MyUtil.ObjInput("Teléfono Oficina", "TelOficinaAsis", CA != null ? CA.getTelOficinaAsis().trim() : "", true, true, 25, 605, "", false, false, 25)%>
        <%=MyUtil.ObjInput("Teléfono Celular", "TelCelularAsis", CA != null ? CA.getTelCelularAsis().trim() : "", true, true, 180, 605, "", false, false, 25)%>
        <%=MyUtil.ObjInput("E-mail Personal", "EmailPersonalAsis", CA != null ? CA.getEmailPersonalAsis().trim() : "", true, true, 335, 605, "", false, false, 35, "validarEmail(this);")%>
        <%=MyUtil.ObjInput("Otro Teléfono", "TelOtroAsis", CA != null ? CA.getTelOtroAsis().trim() : "", true, true, 25, 645, "", false, false, 25)%>
        <%=MyUtil.ObjInput("E-mail Otro", "EmailOtroAsis", CA != null ? CA.getEmailOtroAsis().trim() : "", true, true, 335, 645, "", false, false, 35, "validarEmail(this);")%>
        <%=MyUtil.DoBlock("Datos de Persona Autorizada / Asistente", 25, -5)%>

        <%=MyUtil.ObjComboMem("País", "clPaisFactura", CA != null ? CA.getDsPaisFactura() : "", CA != null ? CA.getClPaisFactura() : "", cbPais.GeneraHTML(20, CA != null ? CA.getDsPaisFactura() : ""), true, true, 25, 730, "0", "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEntFactura", StrdsEntFedFact, StrCodEntFact, cbEntidad.GeneraHTML(40, StrdsEntFedFact, Integer.parseInt(StrclPaisFactura)), true, true, 25, 770, "", "fnLLenaComboMDAjax(this.value);", "", 20, false, false, "CodEntDivFac")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMDFactura", StrdsMunDelFact, StrCodMDFact, cbEntidad.GeneraHTMLMD(40, StrCodEntFact, StrdsMunDelFact), true, true, 410, 770, "", "", "", 20, false, false, "LocalidadDivFac")%>
        <%=MyUtil.ObjInput("Ciudad", "CiudadFactura", CA != null ? CA.getCiudadFactura().trim() : "", true, true, 330, 730, "", false, false, 50)%>
        <%=MyUtil.ObjInput("Calle y Número", "CalleFactura", CA != null ? CA.getCalleFactura().trim() : "", true, true, 25, 810, "", false, false, 50)%>
        <%=MyUtil.ObjInput("C.P.", "CPFactura", CA != null ? CA.getCPFactura().trim() : "", true, true, 300, 810, "", false, false, 15)%>
        <%=MyUtil.DoBlock("Dirección de Facturación", 10, -5)%>

        <% if (StrWarmTransfer.equals("1") && (clCuenta.equals("1353") || clCuenta.equals("1354")) && !strclPaisBIN.equals("0")) {%>
        <% StrctrlDiv = "1";%>
        <div id="TipoUsuarioDIV" style="position:absolute; z-index:1031; left:590px; top:460px; border-style:outset; border-width:medium; width:150px; height:70px; visibility:hidden" class="Negro">
            <p class='Texto1' align="center">WarmTransfer<br><br><b><strong><big><%=CA != null ? CA.getDsPaisBIN() : ""%></big></strong></b></p>
        </div>
        <% } else {
            if (StrWarmTransfer.equals("0") && (clCuenta.equals("1353") || clCuenta.equals("1354")) && !strclPaisBIN.equals("0")) {%>
        <% StrctrlDiv = "1";%>
        <div id="TipoUsuarioDIV" style="position:absolute; z-index:1033; left:590px; top:460px; border-style:outset; border-width:medium; width:150px; height:70px; visibility:hidden" class="Gris">
            <p class='FTable' align="center"><br><br><b><strong><big><%=CA != null ? CA.getDsPaisBIN() : ""%></big></strong></b></p>
        </div>
        <% } else {
            if (StrWarmTransfer.equals("2") && (clCuenta.equals("1353") || clCuenta.equals("1354")) && !strclPaisBIN.equals("0")) {%>
        <% StrctrlDiv = "1";%>
        <div id="TipoUsuarioDIV" style="position:absolute; z-index:1033; left:590px; top:460px; border-style:outset; border-width:medium; width:150px; height:70px; visibility:hidden" class="Amarillo">
            <p class='FTable' align="center"><br><br><b><strong><big><%=CA != null ? CA.getDsPaisBIN() : ""%></big></strong></b></p>
        </div>
        <% } else { %>
        <div id="TipoUsuarioDIV">    
        </div>
        <%    }
                }
            }
        %>

        <div id="UsuarioVIP" style="position:absolute; z-index:1033; left:790px; top:460px;border-style:outset;border-width:medium ;width:150px; height:70px; visibility:hidden" class="UsuarioVIP">
            <!--p class='FTable' align="center"><br><br><b><strong><big><blink>USUARIO VIP</blink></big></strong></b></p MARIO-->
            <p class='FTable' align="center"><br><br><b><strong><big>USUARIO VIP</big></strong></b></p>
        </div>
        <%=MyUtil.GeneraScripts()%>

        <div class='FTable' style='position:absolute; z-index:30; left:410px; top:120px;'>
            <!--p class='FTable' readonly name='ClaveMskUsr' id='ClaveMskUsr'></p MARIO-->
            <p class='FTable' id='ClaveMskUsr'></p>
        </div>
        <input id='clUsrAppAut' type='hidden' name='clUsrAppAut'>
        <input id='MotivoAut' type='hidden' name='MotivoAut'>

        <input name='ClaveMsk' id='ClaveMsk' type='hidden' value=''>
        <input name='FlagAfil' id='FlagAfil' type='hidden' value='0'>
        <input name='AgenteMsk' id='AgenteMsk' type='hidden' value='VN09VN09VN09VN09'>
        <input name='FechNacMsk' id='FechNacMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <input name="ExisteBin" id="ExisteBin" type="hidden" value="">
        <input name="UsrVIP" id="UsrVIP" type="hidden" value="<%=CA != null ? CA.getUsrAppVIP().trim() : ""%>">
        <input name="WarmTransfer" id="WarmTransfer" type="hidden" value="<%=StrWarmTransfer%>">
        <input name="dsTUC" id="dsTUC" type="hidden" value="<%=CA != null ? CA.getdsTipoUsConcierge().trim() : ""%>">
        <input name="ICABin" id="ICABin" type="hidden" value=""/>
        <input name="ICABusinessName" id="ICABusinessName" type="hidden" value=""/>
        <input name="ICACode" id="ICACode" type="hidden" value=""/>
        <input name="ICACountry" id="ICACountry" type="hidden" value=""/>
        <input name="ICALegalName" id="ICALegalName" type="hidden" value=""/>
        <input name="ICARegion" id="ICARegion" type="hidden" value=""/>
        <input name="ICAState" id="ICAState" type="hidden" value=""/>
        <input name="ParentICACode" id="ParentICACode" type="hidden" value=""/>
        <input id="ProdTod" name="ProdTod" type="hidden" value="0"/>
        <input name="BenTod" id="BenTod" type="hidden" value=""/>

        <!--    MENSAJE DE ALERTA CON EL PRODUCTO CORRESPONDIENTE AL BIN    -->
        <div id="ConfirmacionBins"  style='position:absolute; z-index:3000; left:300px; top:300px; visibility:hidden'>
            <table class='Table' border='0' cellpadding='0' >
                <tr class = 'TTable'>
                    <td colspan="1">
                <center><table class="TTable" border="0" width="650"><tr><td><center>Mensaje de Alerta</center></td></tr></table></center>
                </td>
                <td>
                    <table width="5"><tr><td><img src="../../Imagenes/Exit.png" alt="Cerrar Alerta" onclick="fnCloseAlert();"></td></tr></table>
                </td>
                </tr>
                <tr class="R1Table" >
                    <td colspan="2">
                <br><center><table width="600"><tr><td id="T_AlertaMsg"><label id="AlertaMsg"></label></td></tr></table></center><p>
                    </td>
                    </tr>
            </table>
        </div>

        <script type="text/javascript" >

            //fnNewBitacora(2);
            document.all.EmailComercialNU.maxLength = 100;

            function fnLlenaEntidadAjaxFn(cod) {  /// Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion
                IDCombo = 'CodEntFactura';
                Label = 'Provincia';
                IdDiv = 'CodEntDivFac';
                FnCombo = 'fnLLenaComboMDAjax(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion=" + cod + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjax(value) {
                IDCombo = 'CodMDFactura';
                Label = 'Localidad';
                IdDiv = 'LocalidadDivFac';
                FnCombo = '';
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion=" + value + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnBuscaClienteVIP() {
                if (document.all.NuestroUsuario.value != '') {
                    var pstrCadena = "../BuscaClienteVIP.jsp?strSQL=sp_BuscaClienteVIP";
                    pstrCadena = pstrCadena + "&Nombre=" + document.all.NuestroUsuario.value;
                    window.open(pstrCadena, 'newVIP', 'scrollbars=yes,status=yes,width=640,height=300');
                }
            }

            function fnBuscaCuenta() {
                if (document.all.NombreVTR.value != '') {
                    if (document.all.Action.value == 1) {
                        var pstrCadena = "../../Utilerias/FiltrosCuenta.jsp?strSQL=sp_WebBuscaCuenta ";
                        pstrCadena = pstrCadena + "&Cuenta= " + document.all.NombreVTR.value;
                        document.all.clCuenta.value = '';
                        window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=700,height=500');
                    }
                }
            }

            // SE COMENTA ESTA FN para implementyar la validacion de ALS
            /*function fnValidaBin(clave) {
             if (document.all.Action.value == 1) {
             var pstrCadena = "CSValidaBins.jsp?";
             pstrCadena = pstrCadena + "ClaveBin= " + clave.value + "&clCuenta=" + document.all.clCuenta.value;
             window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=1,height=1');
             }
             
             if (document.all.clCuenta.value == '1353' || document.all.clCuenta.value == '1354') {
             var ClaveBin = clave.value;
             fnEsNumerico(clave);
             if (ClaveBin.length != 6) {
             alert('La ' + clave.label + ' debe ser de 6 dígitos.');
             clave.value = '';
             clave.focus();
             document.all.NombreBanco.value = '';
             }
             }
             }*/
    //Modificacion para BCP 
            function fnValidaClaveBCP(pClave){
                var expreg = /^[a-zA-Z0-9]+$/;
                
                clCuenta = document.all.clCuenta.value;
                if(clCuenta == '1618'){   
                    if(!expreg.test(pClave)){
                        alert("La Cuenta debe ser Alfanumerica");}
                }
            }
                
    
            function fnValidaBin(pclave) {

                var clave = pclave.value;
                //alert("clave antes : " + clave);
                clave = clave.replace(/-/gi, "");
                //alert("clave despues : " + clave);
                
                if (pclave.readOnly == false) {
                    if (clave != '') {
                        
                    clCuenta2 = document.all.clCuenta.value;
                        if(clCuenta2 == '1618'){
                            pclave.value = clave;
                            fnValidaClaveBCP();
                        } else {
                        if (isNaN(clave)) {
                            alert('Clave debe ser numerico');
                            document.all.Clave.focus();
                        } else {
                            pclave.value = clave;

                            clCuenta = document.all.clCuenta.value;
                            if (clCuenta == '1353' || clCuenta == '1354') {
                                if (document.all.Action.value == 1) {
                                    var pstrCadena = "../../Operacion/Concierge/CSValidaBinsD.jsp?";
                                    pstrCadena = pstrCadena + "ClaveBin=" + clave + "&clCuenta=" + clCuenta;
                                    WindowBin = window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=1,height=1');
                                }

                            } else {
                                if(clCuenta == '1596' || clCuenta == '1597'){
                                    //alert("TABLA");
                                    if (document.all.Action.value == 1) {
                                        var pstrCadena = "../../Operacion/Concierge/CSValidaBins.jsp?";
                                        pstrCadena = pstrCadena + "ClaveBin= " + clave + "&clCuenta=" + document.all.clCuenta.value;
                                        window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=1,height=1');
                                    }
                                }
                            }
                        }
                    }
                    }
                }
            }

            function fnActualizaBin(Banco, Otorgar, Mensaje, WarmTransfer, ExisteBin, Pais) {
                document.all.NombreBanco.value = Banco;
                //alert('entra fnActualizaBin');
                document.all.WarmTransfer.value = WarmTransfer;
                if (Pais != 0) {
                    document.all.clPaisOrigenNUC.value = Pais;
                    document.all.clPaisOrigenNU.value = Pais;
                    fnLlenaCiudadOrigen();
                }

                if (this.readOnly == false) {
                    if (fnValMask(this, document.all.ClaveMsk.value, this.name)) {
                        fnBuscaClave();
                    }
                }

                if (Otorgar == 0) {
                    document.getElementById("AlertaMsg").innerHTML = Mensaje;
                    document.all.ConfirmacionBins.style.visibility = "visible";
                    ConfirmacionBins.style.left = "10%";
                    ConfirmacionBins.style.top = "100px";
                    if (WarmTransfer == 0) {
                        T_AlertaMsg.style.backgroundColor = "#9E9E9E";    //  GRIS    PLATINUM
                        T_AlertaMsg.style.color = "#FFFFFF";              //  BLANCO
                    }

                    if (WarmTransfer == 1) {
                        T_AlertaMsg.style.backgroundColor = "#000000";    //  NEGRO   BLACK
                        T_AlertaMsg.style.color = "#FFFFFF";              //  BLANCO
                    }

                    if (WarmTransfer == 2) {
                        T_AlertaMsg.style.backgroundColor = "#FFFF21";    //  AMARILLO
                        T_AlertaMsg.style.color = "#000000";              //  BLANCO
                    }
                } else {
                    document.all.ConfirmacionBins.style.visibility = "hidden";
                    ConfirmacionBins.style.left = "800px";
                    ConfirmacionBins.style.top = "300px"
                }
            }

            function fnActualizaBinD(Banco, Otorgar, Mensaje, ICABin, ICACode, ICACountry, ICALegalName, ICARegion, ICAState, ParentICACode, BenTod, WarmTransfer, ExisteBin, ProdTod) {

                document.all.NombreBanco.value = Banco;
                document.all.ExisteBin.value = ExisteBin;
                //Sin esto no guardaba 
                document.all.WarmTransfer.value = 0;

                /* *************************Mastercard Concierge********************/
                document.all.ICABin.value = ICABin;
                document.all.ICABusinessName.value = Banco;
                document.all.ICACode.value = ICACode;
                document.all.ICACountry.value = ICACountry;
                document.all.ICALegalName.value = ICALegalName;
                document.all.ICARegion.value = ICARegion;
                document.all.ICAState.value = ICAState;
                document.all.ParentICACode.value = ParentICACode;
                document.all.ProdTod.value = ProdTod;
                document.all.BenTod.value = BenTod;
                /* ************************Fin de Mastercard Concierge********************/
                if (this.readOnly == false) {
                    if (fnValMask(this, document.all.ClaveMsk.value, this.name)) {
                        fnBuscaClave();
                    }
                }

                if (Otorgar == 0) {
                    WindowBin.close();
                    var owd = dhtmlwindow.open("alert", "div", Mensaje.replace(/<27>/gi, "'"), "Mensaje", "width=500px,height=450px,resize=1,scrolling=1,center=1", "recal");
                    ConfirmacionBins.style.left = "10%";
                    ConfirmacionBins.style.top = "100px";
                    if (WarmTransfer == '0') {
                        T_AlertaMsg.style.backgroundColor = "#C0C0C0";
                    }
                    if (WarmTransfer == '1') {
                        T_AlertaMsg.style.backgroundColor = "#000000";
                        T_AlertaMsg.style.Color = "#FFFFFF";
                    }
                } else {
                    document.all.ConfirmacionBins.style.visibility = "hidden";
                    ConfirmacionBins.style.left = "800px";
                    ConfirmacionBins.style.top = "300px";
                }
            }

            function fnCloseAlert() {
                document.all.ConfirmacionBins.style.visibility = "hidden";
                ConfirmacionBins.style.left = "800px";
                ConfirmacionBins.style.top = "300px"
            }

            //  SE UTILIZA EN fnActualizaBin
            function fnBuscaClave() {
                if (document.all.NombreVTR.value != '') {
                    if (document.all.Action.value == 1) {
                        var pstrCadena = "../../Utilerias/FiltrosClave.jsp?strSQL=sp_WebBuscaClaveGpo ";
                        pstrCadena = pstrCadena + "&Clave= " + document.all.Clave.value + "&clCuenta= " + document.all.clCuenta.value;
                        window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=500,height=500');
                    }
                } else {
                    if (document.all.Action.value == 1) {
                        var pstrCadena = "../../Utilerias/FiltrosClave.jsp?strSQL=sp_WebBuscaClave ";
                        pstrCadena = pstrCadena + "&Clave= " + document.all.Clave.value;
                        window.open(pstrCadena, 'newWin2', 'scrollbars=yes,status=yes,width=500,height=500');
                    }
                }
            }

            //  SE UTILIZA EN FILTRO DE CUENTA
            function fnActualizaDatosCuenta(dsCuenta, clCuenta, clTipoVal, Msk, MskUsr, Agentes) {
                document.all.NombreVTR.value = dsCuenta;
                document.all.clCuenta.value = clCuenta;
                document.all.ClaveMsk.value = Msk;
                document.all.ClaveMskUsr.innerHTML = MskUsr;
                strclTipoVal = clTipoVal;
                document.all.Clave.value = '';
            }

            //  SE UTILIZA EN FILTRO DE NU
            function fnActualizaDatosNuestroUsr(dsNU, Clave, pclCuenta, pNomCuenta, Msk, MskUsr, DatosNUsr, ClaveBeneficiario, UsrVIP) {
                document.all.NuestroUsuario.value = dsNU;
                document.all.Clave.value = Clave;
                document.all.clCuenta.value = pclCuenta;
                document.all.NombreVTR.value = pNomCuenta;
                document.all.ClaveMsk.value = Msk;
                document.all.ClaveMskUsr.innerHTML = MskUsr;
                if (UsrVIP == '1') {
                    document.all.UsrVIP.value = UsrVIP;
                    if (document.all.UsrVIP.value == '1') {
                        document.all.UsuarioVIP.style.visibility = 'visible';
                    }
                }
            }

            TimeFillMD = 5;

            function fnValidaClave(clave) {
                if (document.all.Action.value == 1) {
                    var pstrCadena = "../../Operacion/ValidaClave.jsp?strSQL=sp_ValidaClave ";
                    pstrCadena = pstrCadena + "&Clave= " + document.all.Clave.value;
                    window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=700,height=500');
                }
            }

            function fnBuscaAfiliado() {
                if (document.all.Action.value == 1) {
                    var pstrCadena = "../../Utilerias/FiltrosNuestroUsr.jsp?strSQL=sp_WebBuscaNuestroUsr ";
                    pstrCadena = pstrCadena + "&Clave= " + document.all.Clave.value + "&clCuenta= " + document.all.clCuenta.value;
                    window.open(pstrCadena, 'newWinBA', 'scrollbars=yes,status=yes,width=1200,height=500,top=200,left=50');
                }
            }

            function fnHabilitaAsistencia() { //alert ("valor check: " + document.all.TUConciergeAct.value.toString()  + "  valor combo: " + document.all.clTipoUsConcierge.value.toString());
                if (document.all.Clave.value != "") {
                    document.all.btnAsist.style.visibility = 'visible';
                    document.all.btnHist.style.visibility = 'visible';
                    document.all.btnCober.style.visibility = 'visible';
                    document.all.btnCambios.style.visibility = 'visible';
                } else {
                    document.all.btnAsist.style.visibility = 'hidden';
                    document.all.btnHist.style.visibility = 'hidden';
                    document.all.btnCober.style.visibility = 'hidden';
                    document.all.btnCambios.style.visibility = 'hidden';
                }
            }

            function fnAccionAlta() {
                document.all.forma.action = "../../servlet/Utilerias.ValidaCondNUConcierge";
                document.all.btnAsist.style.visibility = 'hidden';
                document.all.btnHist.style.visibility = 'hidden';
                document.all.btnCober.style.visibility = 'hidden';
                document.all.btnCambios.style.visibility = 'hidden';
                document.all.UsrVIP.value = '0';
                document.all.WarmTransfer.value = '';
                //document.all.").append(pName).append("C.disabled=false;
                if (document.all.Action.value == '1' && <%=StrctrlDiv%> == '1') {
                    document.all.TipoUsuarioDIV.style.visibility = 'hidden';
                }

                if (document.all.UsrVIP.value != '1') {
                    document.all.UsuarioVIP.style.visibility = 'hidden';
                }
            }

            function fnChkHistorial(clConcierge) {
                if (clConcierge != "") {
                    window.open('CSChkHistorial.jsp?clConcierge=' + document.all.clConcierge.value, 'ChHist', 'scrollbars=yes,status=yes,width=50,height=50');
                    document.all.btnHist.style.visibility = 'hidden';
                }
            }

            function fnAbrirHistorialNU(clConcierge) {
                if (clConcierge != "") {
                    window.open('CSAbrirHistorialNU.jsp?clConcierge=' + document.all.clConcierge.value, 'Hist', 'scrollbars=yes,status=yes,width=650,height=300');
                }
            }

            function fnAbrirBitacoraNU(clConcierge) {
                if (clConcierge != "") {
                    window.open('CSAbrirBitacoraNU.jsp?clConcierge=' + document.all.clConcierge.value, 'Bita', 'scrollbars=yes,status=yes,width=1250,height=300');
                }
            }

            function fnNuevoEvento() {
                if (document.all.clCuenta.value != "" && document.all.clCuenta.value != "0" && document.all.clCuenta.value != null) {
                    var pstrCadena = "CSNuevoEvento.jsp?clCuenta=" + document.all.clCuenta.value + "&clTipoUsConcierge=" + document.all.clTipoUsConcierge.value
                            + "&dsTUC=" + document.all.dsTUC.value;
                    window.open(pstrCadena, 'newWinNA', 'scrollbars=yes,status=yes,width=400,height=530,top=200,left=50');
                } else {
                    alert("Debe de Ingresar los datos del Usuario");
                }
            }

            function fnAbrirAsistencia(NombrePaginaWeb, clAsistencia, clConcierge, clSubservicio) {
                top.Contenido.location.href = NombrePaginaWeb + "&clAsistencia=" + clAsistencia + "&clConcierge=" + document.all.clConcierge.value + "&clSubservicio=" + clSubservicio;
            }

            function fnAbrirNuevoEvento(STRclSubservicio) {
                top.Contenido.location.href = "CSSeleccionaServicio.jsp?clSubservicio=" + STRclSubservicio;
            }

            function fnVerificaAfil() {
                var pstrCadena = "CSBuscaClaveConcierge.jsp?clAfiliado=" + document.all.clAfiliado.value;
                window.open(pstrCadena, 'newWinBA', 'scrollbars=yes,status=yes,width=1200,height=500,top=200,left=50');
            }

            function fnVerificaClave(ParamS) {
                if (ParamS == 1) {
                    document.all.FlagAfil.value = 1;
                }
            }

            function fnValidaAfiliado() {
                if (document.all.FlagAfil.value == 1) {
                    msgVal = msgVal + "El Afiliado ya Existe Favor de Consultar a su Administrador."
                    document.all.btnGuarda.disabled = false;
                    document.all.btnCancela.disabled = false;
                }

                if (document.all.TUConciergeAct.value != '0' && document.all.clTipoUsConcierge.value == '') {
                    msgVal = msgVal + " Debe seleccionar Tipo de Usuario"
                    document.all.btnGuarda.disabled = false;
                    document.all.btnCancela.disabled = false;
                }
				//Validacion para hacer obligatorio el campo Documento.
                var clcuenta=document.getElementById("clCuenta").value;
                if((clcuenta==1577 || clcuenta==1578) && document.getElementById("Action").value==1){
                    if (document.getElementById("dsTipoDocumento").value == '' ) {
                        msgVal = msgVal + " Documento";
                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    }
                }                 
            }
            
            function fnValidaDoc(){
                //var StrDocumento = document.getElementById("dsTipoDocumento").value;
                var clCuenta=document.getElementById("clCuenta").value;
                if ((clCuenta==1577 || clCuenta==1578) && (document.getElementById("dsTipoDocumento").value.length <= 6)) {
                        alert('El Documento debe ser mayor a 7 dígitos.');
                        //alert('El ' + document.getElementById("dsTipoDocumento").value + ' debe ser mayor a 7 dígitos.');
                        }
                    }

            function fnFechaNac() {
                var StrFechNac = document.all.FechaNacNU.value;
                if (StrFechNac != "") {
                    document.all.FechaNacNU.value = StrFechNac.substring(0, 10);
                }
            }         

            function fnSubmitOK(pclUsr, pMotivo) {
                document.all.clUsrAppAut.value = pclUsr;
                document.all.MotivoAut.value = pMotivo;
                document.all.forma.action = "../../servlet/Utilerias.EjecutaAccionConcierge";
                document.all.forma.submit();
            }

            function fnGetCobertura() {
                var pstrCadena = "ConciergeFrameCobertura.jsp?clConcierge=" + document.all.clConcierge.value;
                window.open(pstrCadena, 'newWinNA', 'scrollbars=yes,status=yes,width=890,height=700,top=200,left=250');
            }

            if (document.all.clCuenta.value == 1353 || document.all.clCuenta.value == 1354) {
                document.all.TipoUsuarioDIV.style.visibility = 'visible';
            }

            if (document.all.UsrVIP.value == '1') {
                document.all.UsuarioVIP.style.visibility = 'visible';
            }

            function fnLlenaCiudadOrigen() {
                var strConsulta = "st_CSCiudadOrigen '" + document.all.clPaisOrigenNUC.value + "'";
                var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=clCiudadOrigenNUC";
                fnOptionxDefault('clCiudadOrigenNUC', pstrCadena);
            }

            function fnValUssVIP() {

                document.all.TUConciergeActC.disabled = true;
                document.all.clTipoUsConciergeC.disabled = true;

                /******valida TUC******/
                var varcls = ['1','3927','3982','4648','4464','4430','4505','4452'];
                for (var i = 0; i < varcls.length; i += 1) {
                    if (document.all.clUsrApp.value == varcls[i]) {
                        //alert("entro prendo " + document.all.clUsrApp.value + " val contador " + varcls[i])
                        document.all.TUConciergeActC.disabled = false;
                        //document.all.clTipoUsConciergeC.disabled=false;
                        return;
                    }
                }
            }

            function fnValidaTUC() {
                //alert ("valor check: " + document.all.TUConciergeAct.value.toString()  + "  valor combo: " + document.all.clTipoUsConcierge.value.toString());
                if (document.all.TUConciergeAct.value != '0') {
                    alert("Debe seleccionar Tipo de Usuario ");
                    document.all.clTipoUsConciergeC.disabled = false;
                } else {
                    document.all.clTipoUsConciergeC.disabled = true;
                    document.all.TUConciergeAct.value = '0'
                    document.all.clTipoUsConciergeC.value = '';
                    document.all.clTipoUsConcierge.value = '0';
                }
            }
            
//-----------------------VALIDA EMAIL-------------------------------------------
            function validarEmail(pCampo) {
                if(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test(pCampo.value)){
                    }else{
                        //pCampo.value = '';
                        alert("La dirección de email es incorrecta.");
                    }
            }
//------------------------------------------------------------------------------


        </script>
        <%
            StrclPaginaWeb = null;
            StrclConcierge = null;
            strclUsr = null;
            StrWarmTransfer = null;
            StrclPaisFactura = null;
            StrdsEntFedFact = null;
            StrCodEntFact = null;
            StrdsMunDelFact = null;
            StrCodMDFact = null;
            StrctrlDiv = null;
            clCuenta = null;
            Clave = null;
            StrclPaisOrigen = null;
            strclPaisBIN = null;

            daos = null;
            CA = null;
        %>
    </body>
</html>