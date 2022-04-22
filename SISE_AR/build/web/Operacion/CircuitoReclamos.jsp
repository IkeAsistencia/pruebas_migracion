<%@ page contentType="text/html; charset=iso-8859-1" language="java"%>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.operacion.DAOCircuitoReclamos, com.ike.operacion.to.CircuitoReclamos;" errorPage="" %>

<html>
    <head>
        <title>Circuito de Reclamos</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>

    <body class="cssBody" onload="fnValidaFunciones();">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" />
        <script type="text/javascript" src='../Utilerias/Util.js' ></script>
        <script type="text/javascript" src='../Utilerias/UtilAjax.js'></script>

        <%
            int StrClReclamo = 0;
            String StrclUsrApp = "0";
            String StrclPaginaWeb = "6051";
            String StrClCuenta = "";
            String StrAplicaReclamo = "";
            
            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %>Fuera de Horario     
                    </body>
                    </html>
                <%
                //StrClReclamo = null;
                StrclUsrApp = null;
                StrclPaginaWeb = null;
                StrClCuenta = null;
                StrAplicaReclamo = null;
                return;
            }

            if (request.getParameter("clReclamo") != null) {
                StrClReclamo = Integer.parseInt(request.getParameter("clReclamo"));
                System.out.println("1");
            }else{
                System.out.println("2");
            }
            
            MyUtil.InicializaParametrosC(6051, Integer.parseInt(StrclUsrApp));
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

            session.setAttribute("clReclamo", StrClReclamo);

            DAOCircuitoReclamos DAOCR = null;
            CircuitoReclamos cr = null;

            if (StrClReclamo > 0) {
                DAOCR = new DAOCircuitoReclamos();
                cr = DAOCR.getReclamo(StrClReclamo);
            }

            StrClCuenta = cr != null ? cr.getClCuenta() : "";
            StrAplicaReclamo = cr != null ? cr.getAplicaReclamo() : "";

            String url = response.encodeURL("AutorizaReclamo.jsp");
        %>
        <script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(6051, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaReclamo", "fnHabilitaLupa();fnValidaFunciones();fnValidaRadioB();", "fnValidaRadioB();", "fnAntesGuardar();")%>

        <input id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="CircuitoReclamos.jsp?"%>'>
        <input id='clCuenta' name='clCuenta' type='hidden' value='<%=StrClCuenta%>'>
        <input id='clAfiliado' name='clAfiliado' type='hidden' value=''>
        <input id='clAfiltmk' name='clAfiltmk' type='hidden' value=''>
        <input id='clUsrAppS' name='clUsrAppS'  type='hidden' value=''>
        <input id='EsAfiliado' name='EsAfiliado'  type='hidden' value='0'>
        <input id='clUsrAppAut' name='clUsrAppAut'  type='hidden' value='0'>

        <%=MyUtil.ObjInput("<b>Folio Reclamo</b>", "clReclamo", cr != null ? cr.getClReclamo() : "", false, false, 30, 82, "", false, false, 15)%>
        <%=MyUtil.ObjComboC("Estatus Reclamo", "clEstatusReclamo", cr != null ? cr.getDsEstatusReclamo() : "", true, true, 153, 83, "3", "st_getStatusReclamo", /*"fnMuestraAplicRec();"*/ "", "", 25, true, true)%>
        <label class='VTable' id="AplicaReclamoL" style='position:absolute; z-index:1000; left:325px; top:80px;'>APLICA RECLAMO</label>
        <div id="divAplicaRec" class='VTable' style='position:absolute; z-index:1001; left:335px; top:90px;'>
            <input class='VTable' id="AplicaReclamoR0" type="radio"  name="AplicaReclamoR" value="0" onclick="fnValorRadio(this.value)">NO
            <input class='VTable' id="AplicaReclamoR1" type="radio"  name="AplicaReclamoR" value="1" onclick="fnValorRadio(this.value)">SI
            <input id='AplicaReclamo' type='hidden' name='AplicaReclamo' <%--type='hidden'--%>/>
        </div>        
        <%=MyUtil.ObjInput("Fecha Reclamo<br>(AAAA/MM/DD)", "FechaAlta", cr != null ? cr.getFechaReclamo() : "", false, false, 444, 70, "", false, false, 18)%>
        <%=MyUtil.ObjInput("Fecha Cierre<br>(AAAA/MM/DD)", "FechaCierre", cr != null ? cr.getFechaCierre() : "", false, false, 570, 70, "", false, false, 18)%>
        <%=MyUtil.ObjChkBox("Autorización Reintegro", "AutorizaReintegro", cr != null ? cr.getAutorizaReintegro() : "", true, true, 700, 70, "0", "SI", "NO", "")%>                
        <%=MyUtil.ObjInput("Nombre del Afiliado", "NombreAfiliado", cr != null ? cr.getAfiliado() : "", true, false, 30, 135, "", false, false, 45)%>
        <%=MyUtil.ObjInput("DNI", "DNI", cr != null ? cr.getDNI() : "", true, false, 285, 135, "", false, false, 25)%>
        <%=MyUtil.ObjInput("Fecha Validación<br>(AAAA/MM/DD)", "FechaValida", cr != null ? cr.getFechaValida() : "", false, false, 444, 123, "", false, false, 18)%>
        <%=MyUtil.ObjInput("Fecha Baja Afiliado<br>(AAAA/MM/DD)", "FechaBaja", cr != null ? cr.getFechaBaja() : "", false, false, 570, 123, "", false, false, 18)%>
        <%=MyUtil.ObjComboC("Grupo de Cuenta", "clGpoCuenta", cr != null ? cr.getDsGrupoCuenta() : "", true, false, 30, 175, "", "st_getGrupoCuentasReclamo", "fnLimpiaValores();", "", 30, false, false)%>
        <%=MyUtil.ObjInput("Clave", "Clave", cr != null ? cr.getClave() : "", true, false, 240, 175, "", false, false, 25, "if(this.readOnly==false){fnBuscaClave()}")%>
        <%if (MyUtil.blnAccess[4] == true) {%>
        <div id="lupa1" class='VTable' style='position:absolute; z-index:100; left:377px; top:187px;'>
            <IMG SRC='../Imagenes/Lupa.gif' class='handM' onClick='fnBuscaClave();' WIDTH=20 HEIGHT=20>
        </div>
        <% }%>
        <%=MyUtil.ObjInput("Canal de Venta", "CanalVenta", cr != null ? cr.getCanalVenta() : "", false, false, 450, 175, "", false, false, 25, "")%>       
        <%=MyUtil.ObjChkBox("Categoria de Reclamos", "CategoriaReclamo", cr != null ? cr.getCategoriaReclamo() : "", true, true, 620, 175, "0", "Urgente", "Normal", "")%>        
        <%=MyUtil.ObjComboC("Sectores (Derivación)", "clSector", cr != null ? cr.getDsSector() : "", true, true, 30, 215, "", "st_getSectoresReclamo " + StrclUsrApp, "", "", 30, true, true)%>
        <%=MyUtil.ObjComboC("Tipificación de Reclamos", "clTipoReclamo", cr != null ? cr.getDstipoReclamo() : "", true, true, 240, 215, "", "st_geTipoReclamo", "", "", 30, true, true)%>
        <%=MyUtil.ObjChkBox("Solicita reintegro", "Reintegro", cr != null ? cr.getReintegro() : "", true, true, 450, 215, "0", "SI", "NO", "fnMuestraMonto()")%>
        <%=MyUtil.ObjInputDiv("Monto", "Monto", cr != null ? cr.getMonto() : "", true, true, 600, 215, "", false, false, 10, "", "divMonto")%> <!--se muestra solos si el cltiporeclamo = 6 Solicita reintegro -->
        <%=MyUtil.ObjInput("Operador de Venta", "Operador", cr != null ? cr.getOpeVenta() : "", true, true, 510, 260, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Validador", "Validador", cr != null ? cr.getValidador() : "", true, true, 510, 310, "", false, false, 30)%>
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", cr != null ? cr.getObservaciones() : "", "90", "7", true, true, 30, 260, "Usuario: " + session.getAttribute("NombreUsuario").toString(), true, true)%>
        <%=MyUtil.DoBlock("Reclamos", -30, 20)%>   

        <%=MyUtil.ObjInput("Tipo Tarjeta", "tipoTarjeta", cr != null ? cr.getTipoTarjeta() : "", true, false, 30, 430, "", false, false, 30)%>
        <%=MyUtil.ObjInput("No. Tarjeta", "noTarjeta", cr != null ? cr.getNoTarjeta() : "", true, false, 280, 430, "", false, false, 30)%>
        <%=MyUtil.ObjInput("No. Cuenta", "noCuenta", cr != null ? cr.getNoCuenta() : "", true, true, 520, 430, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Banco", "banco", cr != null ? cr.getBanco() : "", true, true, 30, 470, "", false, false, 70)%>
        <%=MyUtil.ObjInput("No. CBU", "noCBU", cr != null ? cr.getNoCBU() : "", true, true, 520, 470, "", false, false, 30, "fnValidalongitudCBU(this.value)")%>
        <%=MyUtil.DoBlock("Información Bancaria", 0, 0)%>

        <%=MyUtil.GeneraScripts()%>

        <div class='VTable' style='position:absolute; z-index:25; left:360pxpx; top:16px;' id="divHistorico">
            <input class='cBtn' type='button' value='HISTÓRICO DE CAMBIOS' onClick="window.open('HistoricoReclamos.jsp?&clReclamo=' + document.all.clReclamo.value, '', 'resizable=no,menubar=0,status=0,toolbar=0,height=450,width=1005,screenX=-50,screenY=0,scrollbars=yes')">
        </div>
        <div style='position:absolute; z-index:25; left:590px; top:16px;' id='divBtnCob'>
            <input id="btnCob" name="btnCob" class='cBtn' type='button' value='COBERTURA' onClick="fnMuestraCoberturas();">
        </div>

        <script>
            document.all.divHistorico.style.visibility = "hidden";
            document.all.divBtnCob.style.visibility = "hidden";
            document.all.lupa1.style.visibility = "hidden";
            document.all.divMonto.style.visibility = "hidden";
            //document.all.AplicaReclamoL.style.visibility = "hidden";
            document.all.AplicaReclamoR0.disabled = true;
            document.all.AplicaReclamoR1.disabled = true;

            function fnValidaFunciones() {
                //fnMuestraAplicRec();
                fnMuestraMonto();
                fnValidaHistorico();
                fnValorRadio('<%=StrAplicaReclamo%>');                //evaluar
                fnMuestraDivBtnCob();
            }

            function fnLimpiaValores() {
                /*document.all.NombreAfiliado.value = "";
                 document.all.DNI.value = "";
                 document.all.Clave.value = "";*/
            }

            function fnAntesGuardar() {
                //alert(document.all.EsAfiliado.value);
                if (document.all.NombreAfiliado.value == '') {
                    if (msgVal == "") {
                        msgVal += "Nombre";
                    } else {
                        msgVal += ",Nombre";
                    }
                    document.all.btnGuarda.disabled = false;
                } else {
                    if ((document.all.EsAfiliado.value == 0) && (document.all.Action.value == 1)) {
                        document.all.forma.action = "<%=url%>";
                    }
                    else {
                        document.all.forma.action = "../servlet/Utilerias.EjecutaReclamo";
                    }
                }


                if ((document.all.clEstatusReclamo.value == 4) && (document.all.AplicaReclamo.value == "")) {
                    msgVal += " Aplica Reclamo.";
                    document.all.btnGuarda.disabled = false;
                    document.all.btnCancela.disabled = false;
                }

                fnValidaReintegro();
            }

            function fnSubmitOK(pclUsr) {
                //alert('se envia ' + pclUsr);
                document.all.clUsrAppAut.value = pclUsr;
                document.all.forma.action = "../servlet/Utilerias.EjecutaReclamo";
                //alert(document.all.forma.action);
                document.all.forma.submit();
            }


            function fnValidaReintegro() {
                if (document.all.Reintegro.value == 1) {
                    if (document.all.Monto.value == '') {
                        if (msgVal == "") {
                            msgVal += "Seleccionaste Reintegro, debes ingresar un monto.";
                            document.all.Monto.focus();
                        } else {
                            msgVal += ",Monto del Reintegro.";
                            document.all.Monto.focus();
                        }
                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    }
                }
            }

            function fnValidaHistorico() {
                if (document.all.clReclamo.value != '') {
                    document.all.divHistorico.style.visibility = "visible";
                }
            }

            function fnHabilitaLupa() {
                document.all.lupa1.style.visibility = "visible";
            }

            function fnBuscaClave() {                                                            //Revisar********
                if (document.all.clGpoCuenta.value == '' && document.all.Clave.value != '') {
                    alert("Debe seleccionar un grupo de cuenta...");
                } else {
                    var pstrCadena = "../Utilerias/FiltrosReclamos.jsp?strSQL=st_BuscaClaveAfilReclamo ";
                    pstrCadena = pstrCadena + "&Clave= " + document.all.Clave.value + "&clGpoCuenta= " + document.all.clGpoCuenta.value;
                    window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=700,height=500');
                }
            }

            function fnMuestraMonto() {
                if (document.all.Reintegro.value == 1)
                    document.all.divMonto.style.visibility = "visible";
                else {
                    document.all.divMonto.style.visibility = "hidden";
                    document.all.Monto.value = '';
                }
            }

            function fnRecuperaDatos(pGpoCuenta, pNombre, pclAfiliado, pclafiltmk, pclcuenta, pClave, pDNI, pfechaVal, pfechacanc, pCanalVenta, ptipoTarjeta, noTarjeta) {
                document.all.clGpoCuentaC.value = pGpoCuenta;
                document.all.NombreAfiliado.value = pNombre;
                document.all.clAfiliado.value = pclAfiliado;
                document.all.clAfiltmk.value = pclafiltmk;
                document.all.clCuenta.value = pclcuenta;
                document.all.Clave.value = pClave;
                document.all.DNI.value = pDNI;
                document.all.FechaValida.value = pfechaVal;
                document.all.FechaBaja.value = pfechacanc;
                document.all.CanalVenta.value = pCanalVenta;
                document.all.tipoTarjeta.value = ptipoTarjeta;
                document.all.noTarjeta.value = noTarjeta;
                document.all.EsAfiliado.value = 1;
            }

            function fnValorRadio(val) {
                document.all.AplicaReclamo.value = val;

                if ((document.all.clEstatusReclamo.value != 4)) {
                    document.all.AplicaReclamo.value = "";
                }
                else if ((document.all.clEstatusReclamo.value == 4) && (document.all.AplicaReclamo.value == 0)) {
                    document.all.AplicaReclamoR0.checked = true
                }
                else if ((document.all.clEstatusReclamo.value == 4) && (document.all.AplicaReclamo.value == 1)) {
                    document.all.AplicaReclamoR1.checked = true
                }
            }

            function fnValidaRadioB() {
                if (document.all.Action.value == 1) {
                    document.all.AplicaReclamo.value = ""
                    document.all.AplicaReclamoR0.checked = false
                    document.all.AplicaReclamoR1.checked = false
                    document.all.AplicaReclamoR0.disabled = false;
                    document.all.AplicaReclamoR1.disabled = false;
                }

                if (document.all.Action.value == 2) {
                    document.all.AplicaReclamoR0.disabled = false;
                    document.all.AplicaReclamoR1.disabled = false;
                }
            }

            function fnMuestraDivBtnCob() {    //alert("valor clcuenta " + document.all.clCuenta.value.toString() + " valor clave "  + document.all.Clave.value.toString())
                if ((document.all.clCuenta.value != '') && (document.all.Clave.value != '')) {
                    document.all.divBtnCob.style.visibility = "visible";
                } else {
                    document.all.divBtnCob.style.visibility = "hidden";
                }
            }

            function fnMuestraCoberturas() {
                var pstrCadena = "VistaCobertura.jsp?";
                pstrCadena = pstrCadena + "&clCuenta= " + document.all.clCuenta.value;
                window.open(pstrCadena, '', 'resizable=no,menubar=0,status=0,toolbar=0,height=450,width=1005,screenX=-50,screenY=0,scrollbars=yes');
            }

            function fnValidalongitudCBU(valueCBU) {
                if (!valueCBU.match(/^\d{22}$/)) {
                    alert("El campo CBU debe contener 22 digitos.");
                    document.all.noCBU.value = "";
                }
            }

            <%
                StrclUsrApp = null;
                StrclPaginaWeb = null;
                StrClCuenta = null;
                StrAplicaReclamo = null;
            %>
        </script>
    </body>
</html>
