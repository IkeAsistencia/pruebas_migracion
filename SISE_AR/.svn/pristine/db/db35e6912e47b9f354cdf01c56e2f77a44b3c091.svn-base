<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS,Seguridad.SeguridadC,com.ike.retencion.to.Retencion, com.ike.retencion.DAORetencion" errorPage="" %>
<html>
    <head>
        <title>Retenciones Generales</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="fnMuestraDivBtnCob();">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilDireccion.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>

        <%
            String StrclRetencTmk = "0";
            String StrclUsrApp = "0";
            String StrclPaginaWeb = "0";
            String StrCodEnt = "";
            String StrDsEntFed = "";
            String StrCodMD = "";
            String StrDsMunDel = "";
            String StrClCuenta = "";
            String StrClMotivoCancela = "";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            if (request.getParameter("clRetencTmk") != null) {
                StrclRetencTmk = request.getParameter("clRetencTmk").toString();
            }

            StrclPaginaWeb = "399";
            MyUtil.InicializaParametrosC(399, Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

            DAORetencion DaoRet = null;
            Retencion ret = null;

            if (!StrclRetencTmk.equalsIgnoreCase("0")) {
                DaoRet = new DAORetencion();
                ret = DaoRet.getRetencion(StrclRetencTmk);

                StrCodEnt = ret != null ? ret.getCodEntDom() : "";
                StrDsEntFed = ret != null ? ret.getDsEntFedDom() : "";
                StrCodMD = ret != null ? ret.getCodMDDom() : "";
                StrDsMunDel = ret != null ? ret.getDsMunDelDom() : "";
                StrClCuenta = ret != null ? ret.getClCuenta() : "";
                StrClMotivoCancela = ret != null ? ret.getClMotivoCancela() : "";
            }
        %>

        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaRetencion", "fnHabilitaLupa(),fnHabilitaDom();fnLimpiar();fnMuestraDivBtnCob();fnCombo();", "fnGuarda();")%>

        <script type="text/javascript" >
            document.all.btnCambio.disabled = true;
            document.all.btnElimina.disabled = true;
        </script>

        <input id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="Retenciones.jsp?"%>'>
        <input id='clAfilTMK' name='clAfilTMK' type='hidden' value=''>
        <input id='clRetencTmk' name='clRetencTmk' type='hidden' value='<%=StrclRetencTmk%>'>
        <input id='clAfiliado' name='clAfiliado' type='hidden' value=''>
        <input id='clUsrAppS' name='clUsrAppS' type='hidden' value='<%=StrclUsrApp%>'>
        <input class='cBtn'  type='button' id='HRetencione'  name='HRetencione'  value='HISTORIAL DE RETENCIONES' onClick="fnRetencionesC()">
        <input id='ClaveMsk' name='ClaveMsk'  type='hidden' value=''>        
        <input id='clCuenta' name='clCuenta' type='hidden' value='<%=StrClCuenta%>'>
        <input id='ClaveHistorico' name='ClaveHistorico' type='hidden' value='<%=ret != null ? ret.getClave() : ""%>'>
        <input id='ClEntFed' name='ClEntFed' type='hidden' value=''>
        <input id='DNI' name='DNI' type='hidden' value=''>

        <%=MyUtil.ObjInput("Folio Retención", "FolioVTR", ret != null ? ret.getClRetencionTmk() : "", false, false, 30, 70, "", false, false, 25)%>
        <%=MyUtil.ObjComboC("Grupo de Cuenta", "clGpoCuenta", ret != null ? ret.getNombreCta() : "", true, true, 200, 70, "", "st_getGrupoCuentasRetenciones", "fnLimpiar();", "", 30, true, true)%> <%--ME--%>
        <%=MyUtil.ObjInput("Fecha (AAAA/MM/DD)", "Fecha", ret != null ? ret.getFechaLlamada() : "", false, false, 460, 70, "", false, false, 25)%>
        <%=MyUtil.ObjInput("Nombre del Afiliado", "Nombre", ret != null ? ret.getNomAfil() : "", false, false, 30, 110, "", false, false, 47)%>
        <%=MyUtil.ObjInput("Clave", "Clave", ret != null ? ret.getClaveMask() : "", false, false, 300, 110, "", true, true, 25, "if(this.readOnly==false){fnBuscaClave()}")%>
        <%if (MyUtil.blnAccess[4] == true) {%>

        <div id="lupa1" class='VTable' style='position:absolute; z-index:30; left:429px; top:119px;'>
            <IMG alt="Buscar Afiliado"  SRC='../../Imagenes/Lupa.gif' class='handM' onClick='fnBuscaClave();' WIDTH=20 HEIGHT=20>
        </div>
        <% }%>

        <%=MyUtil.ObjInput("Canal de Venta ", "CanalVenta", ret != null ? ret.getCanalVenta() : "", false, false, 460, 110, "", false, false, 25)%>
        <%=MyUtil.ObjInput("Persona quien reporta", "PersonaReporta", ret != null ? ret.getPersonaReporta() : "", true, true, 30, 150, "", true, true, 47)%>
        <%=MyUtil.ObjInput("Teléfono", "TelPersonaReporta", ret != null ? ret.getTelefono() : "", true, true, 300, 150, "", false, false, 25)%>
        <%=MyUtil.ObjInput("Cédula", "RFC", ret != null ? ret.getRfc() : "", true, true, 460, 150, "", false, false, 25)%>
        <%=MyUtil.ObjInput("Nombre del Beneficiario", "derechoHab", ret != null ? ret.getBeneficiario() : "", true, true, 30, 190, "", false, false, 47)%> 
        <div id="divChkBoxCompleta" class="Vtable">
            <%=MyUtil.ObjChkBox("Misma Persona que reporta", "ChkBoxCompleta", ret != null ? ret.getChkBCompleta() : "", true, true, 300, 204, "", "fnCompleta();")%>
        </div> 
        <%=MyUtil.ObjComboC("Estatus", "clEstatus", ret != null ? ret.getDsEstatus() : "", true, true, 30, 230, "0", "Select clStatus,dsStatus from cStatusRetencTMK where Activo = 1", "fnRevisaLlenado();", "", 50, true, false)%>
        <%=MyUtil.ObjComboCDiv("Motivo del llamado", "clMotivoCancela", ret != null ? ret.getDsMotivoCancela() : "", true, true, 230, 230, "", "st_getcomboMotivoCan " + StrClMotivoCancela, "fnMotivo()", "", 50, true, false, "MotivoDiv")%> 
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", ret != null ? ret.getObservaciones() : "", "100", "7", true, true, 30, 270, "", false, false)%>
        <%=MyUtil.DoBlock("Retenciones", -30, 60)%>
        
        <%=MyUtil.ObjChkBox("Esquema de Beneficiario", "H1EsquemaBeneficiario", "0", true, true, 680, 70, "", "")%>
        <%=MyUtil.ObjChkBox("Producto Retención", "H2ProductoRetencion", "0", true, true, 680, 90, "", "")%>
        <%=MyUtil.ObjChkBox("50% de descuento x 3 meses", "H3Descuento1", "0", true, true, 680, 110, "", "")%>
        <%=MyUtil.ObjChkBox("X% de descuento x X meses", "H4Descuento2", "0", true, true, 680, 130, "", "")%>
        <%=MyUtil.ObjChkBox("X% de descuento x X meses", "H5Descuento3", "0", true, true, 680, 150, "", "")%>
        <%=MyUtil.ObjChkBox("Tecnológico", "H6Tecnologico", "0", true, true, 680, 170, "", "")%>
        <%=MyUtil.ObjChkBox("Odontológico", "H7Odontologico", "0", true, true, 680, 190, "", "")%>
        
        <%=MyUtil.DoBlock("Herramientas de retención", 50, 0)%>

        <%=MyUtil.ObjTextArea("Dirección", "direccion", ret != null ? ret.getDirOldDom() : "", "107", "3", false, false, 30, 420, "", false, false)%>
        <%=MyUtil.ObjInput("Calle", "calle", ret != null ? ret.getCalleDom() : "", true, false, 30, 480, "", false, false, 107)%>
        <%=MyUtil.ObjInput("No. Calle", "ncalle", ret != null ? ret.getNcalleDom() : "", true, false, 30, 520, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Piso", "nPiso", ret != null ? ret.getNpisoDom() : "", true, false, 110, 520, "", false, false, 10)%>
        <%=MyUtil.ObjInput("No. Depto.", "ndepto", ret != null ? ret.getNdeptoDom() : "", true, false, 190, 520, "", false, false, 10)%>
        <%=MyUtil.ObjInput("C.P.", "cp", ret != null ? ret.getCpDom() : "", true, false, 270, 520, "", false, false, 5)%>
        <%=MyUtil.ObjChkBox("<b>Cambio Domicilio</b>", "ChkBoxCambioDom", ret != null ? ret.getCamDom() : "0", true, true, 330, 525, "", "fnHabilitaDom()")%>

        <img src="../../Imagenes/exclamation.png" style="position:absolute; z-index:26; left:462px; top:528px;">
        <div id="InstDesc" style='position:absolute; z-index:34; left:482px; top:528px;'>
            <p class='vtable'>SELECCIONE PARA CAMBIAR<br>EL DOMICILIO.</p>
        </div>

        <%=MyUtil.ObjInput("Teléfono Casa", "TelCasa", ret != null ? ret.getTelCasaDom() : "", true, false, 30, 560, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Teléfono Oficina", "TelOfi", ret != null ? ret.getTelOfiDom() : "", true, false, 210, 560, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Email", "correo", ret != null ? ret.getCorreoDom() : "", true, false, 400, 560, "", false, false, 40, "fnValidaCorreo()")%>
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", StrDsEntFed, StrCodEnt, cbEntidad.GeneraHTML(40, StrDsEntFed, Integer.parseInt("10")), true, true, 30, 600, StrCodEnt, "fnLLenaComboMDAjax(this.value);", "", 20, false, false, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", StrDsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(40, StrCodEnt, StrDsMunDel), true, true, 440, 600, StrCodEnt, "", "", 20, false, false, "LocalidadDiv")%>
        <%=MyUtil.DoBlock("Domicilio", 20, 0)%>
        <%=MyUtil.GeneraScripts()%>


        <div style='position:absolute; z-index:25; left:630px; top:20px;' id='divBtnCob'>
            <input id="btnCob" name="btnCob" class='cBtn' type='button' value='COBERTURA' onClick="fnMuestraCoberturas();">
        </div>

        <%
            StrclRetencTmk = null;
            StrclUsrApp = null;
            StrclPaginaWeb = null;
            StrCodEnt = null;
            StrDsEntFed = null;
            StrCodMD = null;
            StrDsMunDel = null;
            StrClCuenta = null;
            StrClMotivoCancela = null;

            ret = null;
            DaoRet = null;            
        %>

        <script type="text/javascript">
            document.all.lupa1.style.visibility = "hidden";
            document.all.derechoHab.disabled = true;
            document.all.divChkBoxCompleta.style.visibility = "hidden"

            function fnHabilitaDom() {
                if (document.all.ChkBoxCambioDom.value == 1) {
                    document.all.calle.disabled = false;
                    document.all.ncalle.disabled = false;
                    document.all.nPiso.disabled = false;
                    document.all.ndepto.disabled = false;
                    document.all.cp.disabled = false;
                    document.all.TelCasa.disabled = false;
                    document.all.TelOfi.disabled = false;
                    document.all.correo.disabled = false;
                    document.all.CodEntDiv.disabled = false;
                    document.all.LocalidadDiv.disabled = false;
                } else {
                    document.all.calle.disabled = true;
                    document.all.ncalle.disabled = true;
                    document.all.nPiso.disabled = true;
                    document.all.ndepto.disabled = true;
                    document.all.cp.disabled = true;
                    document.all.TelCasa.disabled = true;
                    document.all.TelOfi.disabled = true;
                    document.all.correo.disabled = true;
                    document.all.CodEntDiv.disabled = true;
                    document.all.LocalidadDiv.disabled = true;
                }
            }

            function fnRevisaLlenado() {
                if (document.all.clCuenta.value == '') {
                    alert("Debe seleccionar un Afiliado.")
                    document.all.clEstatusC.value = "";
                    document.all.clMotivoCancelaC.value = "";
                    document.all.clEstatus.value = "0";
                    document.all.clMotivoCancela.value = "0";
                } else {
                    IDCombo = 'clMotivoCancela';
                    Label = 'Motivo';
                    IdDiv = 'MotivoDiv';
                    FnCombo = 'fnMotivo()';

                    URL = "../../servlet/Utilerias.LlenaCombosAjax?";
                    Cadena = "&strSQL=st_GetMotivoCancela " + document.all.clEstatus.value + "," + document.all.clCuenta.value;
                    Cadena += "&Opcion=" + document.all.clEstatus.value + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                    fnLLenaInput(URL, Cadena, IdDiv);
                }
            }

            function fnHabilitaLupa() {
                document.all.lupa1.style.visibility = "visible";
            }

            function fnLimpiar() {
                document.all.clCuenta.value = '';
                document.all.FolioVTR.value = '';
                document.all.Fecha.value = '';
                document.all.Nombre.value = '';
                document.all.Clave.value = '';
                document.all.CanalVenta.value = '';
                document.all.PersonaReporta.value = '';
                document.all.TelPersonaReporta.value = '';
                document.all.RFC.value = '';
                document.all.derechoHab.value = '';
                document.all.ChkBoxCompleta.value = 0;
                document.all.clEstatus.value = '';
                document.all.clEstatusC.value = '';
                document.all.clEstatusC.disabled = false;
                document.all.clMotivoCancela.value = '';        //***revisar
                document.all.clMotivoCancelaC.value = '';       //***revisar
                document.all.Observaciones.value = '';
                document.all.Observaciones.readOnly = false;
                document.all.clAfiliado.value = '';
                document.all.clAfilTMK.value = '';
                document.all.direccion.value = '';
                document.all.calle.value = '';
                document.all.ncalle.value = '';
                document.all.nPiso.value = '';
                document.all.ndepto.value = '';
                document.all.cp.value = '';
                document.all.ChkBoxCambioDom.value = 0;
                document.all.ClEntFed.value = '';
                document.all.TelCasa.value = '';
                document.all.TelOfi.value = '';
                document.all.correo.value = '';
                document.all.DNI.value = '';
                document.all.CodEnt.value = '';
                document.all.CodEntC.value = '';
                document.all.CodMD.value = '';
                document.all.CodMDC.value = '';
            }

            function fnBuscaClave() {
                if (document.all.clGpoCuenta.value == '') {
                    alert("Debe seleccionar un grupo de cuentas."); //Me
                } else {
                    fnLimpiar();
                    var pstrCadena = "../../Utilerias/FiltrosAfil.jsp?strSQL=sp_WebBuscaClaveAfil ";
                    pstrCadena = pstrCadena + "&Clave= " + document.all.Clave.value + "&clGpoCuenta= " + document.all.clGpoCuenta.value;
                    window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=700,height=500');
                }
            }

            
            function fnActualiza(pClave, pNombre, pclAfiliado, pclAfilTMK, pDireccion, pCalle, pnCalle, pnPiso, pnDepto, pCp, pClEntFed, pTelefonoCasa, pTelefonoOfi, pemail, pHayRetencion, pclCuenta, pCanalVenta, pDNI) {
                //alert(pClave+'*'+pNombre+'*'+pclAfiliado+'*'+pclAfilTMK+'*'+pDireccion+'*'+pCalle+'*'+pnCalle+'*'+pnPiso+'*'+pnDepto+'*'+pCp+'*'+pClEntFed+'*'+pTelefonoCasa+'*'+pTelefonoOfi+'*'+pemail+'*'+pHayRetencion+'*'+pclCuenta+'*'+pCanalVenta+'*'+pDNI);
                document.all.Clave.value = pClave;
                document.all.Nombre.value = pNombre;
                document.all.clAfiliado.value = pclAfiliado;
                document.all.clAfilTMK.value = pclAfilTMK;
                document.all.direccion.value = pDireccion;
                document.all.calle.value = pCalle;
                document.all.ncalle.value = pnCalle;
                document.all.nPiso.value = pnPiso;
                document.all.ndepto.value = pnDepto;
                document.all.cp.value = pCp;
                document.all.ClEntFed.value = pClEntFed;
                document.all.TelCasa.value = pTelefonoCasa;
                document.all.TelOfi.value = pTelefonoOfi;
                document.all.correo.value = pemail;
                document.all.DNI.value = pDNI;
                document.all.clCuenta.value = pclCuenta;
                document.all.CanalVenta.value = pCanalVenta;

                if (pHayRetencion != "0") {
                    document.all.Observaciones.value = pHayRetencion;
                    //alert (document.all.clEstatusC.value);
                    document.all.clEstatus.value = '3';
                    document.all.clEstatusC.value = '3';
                    document.all.clEstatusC.disabled = true;
                    document.all.clMotivoCancela.value = '';
                    document.all.clMotivoCancelaC.value = '';
                    document.all.clMotivoCancelaC.disabled = false;
                    document.all.Observaciones.readOnly = true;
                    fnRevisaLlenado();
                }
                
                fnMuestraDivBtnCob();
            }

            function fnMotivo() {
                if (document.all.clEstatus.value == '') {
                    alert("Debe seleccionar un estatus.");
                    document.all.clEstatusC.value == ''
                    document.all.clEstatus.value == '0'
                } else {
                    if (document.all.clEstatus.value == '2' && document.all.clMotivoCancela.value == '40') {
                        document.all.derechoHab.disabled = false;
                        document.all.divChkBoxCompleta.style.visibility = "visible"
                    } else {
                        document.all.derechoHab.disabled = true;
                        document.all.derechoHab.value = "";
                    }
                }
            }

            function fnGuarda() {
                if (document.all.clEstatusC.value == 1 && document.all.clMotivoCancelaC.value == "") {
                    msgVal = msgVal + "Debe de Informar Motivo de Cancelación";
                    document.all.btnGuarda.disabled = false;
                }
                if (document.all.clEstatusC.value == 2 && document.all.derechoHab.value == "" && document.all.clMotivoCancela.value == 40) {     //me
                    msgVal = msgVal + "Debe Informar un beneficiario";
                    document.all.btnGuarda.disabled = false;
                }
                if (document.all.clEstatusC.value == 2 && document.all.derechoHab.value != "" && document.all.clMotivoCancela.value != 40) {     //me
                    msgVal = msgVal + "El motivo debe ser: " + '"ESQUEMA DE BENEFICIARIOS"';
                    document.all.btnGuarda.disabled = false;
                }
            }

            function fnRetencionesC() {
                var pstrCadena = "../../Utilerias/ValidaRetenciones.jsp?ClaveHistorico=" + document.all.ClaveHistorico.value;
                window.open(pstrCadena, 'newWin2', 'scrollbars=yes,status=yes,width=700,height=500');
            }

            function fnCompleta() {          //me
                seleccionado = document.all.ChkBoxCompleta.value;
                if (((seleccionado == 1) && (document.all.derechoHab.value == "")) && ((document.all.clEstatusC.value == 2) && (document.all.clMotivoCancela.value == 40))) {
                    document.all.derechoHab.value = document.all.PersonaReporta.value;
                } else if ((seleccionado == 1) && (document.all.derechoHab.value != document.all.PersonaReporta.value)) {
                    document.all.derechoHab.value = "";
                    document.all.PersonaReporta.focus();
                }
                else if (seleccionado == 0) {
                    document.all.derechoHab.value = "";
                    document.all.PersonaReporta.focus();
                }
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

            function fnValidaCorreo() {
                var Cadena
                var PosArroba
                var usuario
                var dominio
                if (document.all.correo.value != '') {
                    if (document.all.correo.value.indexOf('@', 0) == -1) {
                        alert("La dirección de correo no es valida.");
                    } else {
                        PosArroba = document.all.correo.value.lastIndexOf('@')
                        usuario = document.all.correo.value.substring(0, PosArroba)
                        dominio = document.all.correo.value.substring(PosArroba + 1, Cadena)

                        if (usuario == '' || dominio == '') {
                            alert("La dirección de correo no es valida.");
                        }
                        //Valida el nombre de usuario y verifica que no existan dos @
                        if (usuario.indexOf('@', 0) != -1) {
                            alert("La dirección de correo no es valida.");
                        }
                        //valida el dominio
                        if (dominio.indexOf('.', 0) == -1 || dominio.indexOf('@', 0) != -1) {
                            alert("La dirección de correo no es valida.");
                        }
                        //alert(usuario + "," + dominio)
                    }
                }
            }

            function fnMuestraDivBtnCob() {
                if ((document.all.clCuenta.value != '') && (document.all.Clave.value != '')) {
                    document.all.divBtnCob.style.visibility = "visible";
                } else {
                    document.all.divBtnCob.style.visibility = "hidden";
                }

            }

            function fnMuestraCoberturas() {
                var pstrCadena = "../VistaCobertura.jsp?";
                pstrCadena = pstrCadena + "&clCuenta= " + document.all.clCuenta.value;
                window.open(pstrCadena, '', 'resizable=no,menubar=0,status=0,toolbar=0,height=450,width=1005,screenX=-50,screenY=0,scrollbars=yes');
            }             
            
            function fnCombo() {
                IDCombo = 'clMotivoCancela';
                Label = 'Motivo';
                IdDiv = 'MotivoDiv';
                FnCombo = 'fnMotivo()';
                
                URL = "../../servlet/Utilerias.LlenaCombosAjax?";
                Cadena = "&strSQL=st_GetMotivoCancela 0,0"
                Cadena += "&Opcion=" + document.all.clEstatus.value + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }
            
        </script>
    </body>
</html>