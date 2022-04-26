<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage=""  pageEncoding="iso-8859-1"%>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC, com.ike.asistencias.DAOCostos, com.ike.asistencias.to.Costos" %>
<%@page import="com.google.common.base.Strings,org.jfree.util.StringUtils,com.ike.asistencias.DAODatosFactDetAsistencia,com.ike.asistencias.to.DatosFactDetAsistencia"%>
<%@page import="com.ike.asistencias.DAODomicilioFacturacion,com.ike.asistencias.to.DomicilioFacturacion,com.ike.asistencias.DAOParamCostos,com.ike.asistencias.to.ParamCostos"%>
<html>
    <head>
        <title>Costos</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="fnValidaTmp();fnMuestraKMS();fnValorRadioInicial();">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" />
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js' ></script>
        <script src='../Utilerias/UtilCostos.js' ></script>
        <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>            
        <%
            String StrclUsrApp = "0";
            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();        }
            if(SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
                %><font color="white"  style="font-family:Verdana,Arial,Helvetica,sans-serif; background-color:red;" size=3>LA SESION EXPIRO</font><%  
                StrclUsrApp=null;
                return;
                }
            String StrclExpediente = "0";
            StringBuffer StrSql = new StringBuffer();
            String StrclPaginaWeb = "239";
            String StrclCosto = "0";
            String StrclServicio = "";
            String StrTieneTmp = "0";
            String StrComrpobanteTmp = "";
            String StrExisteCosto = "0";
            String StrclCuenta = "0";
            boolean editableNombre = false;
            boolean editableDomicilio = false;
            boolean editableDniCuil = true;
            boolean editableMail = false;
            boolean editableProvincia = false;
            boolean editableLocalidad = false;
            boolean editableCosto = false;
            boolean editableConcepto = false;
            String labelNombre = "Nombre y Apellido";
            String labelTipoDocumento = "DNI";
            String comprobanteDefault = "B";
            boolean enableCambiarMP = false;
            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();            }
            if (request.getParameter("clCosto") != null) {
                StrclCosto = request.getParameter("clCosto").toString();            }
            if (session.getAttribute("clServicio") != null) {
                StrclServicio = session.getAttribute("clServicio").toString();            }
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp));
            StrSql.append("st_getPagoProveedor ").append(StrclCosto);
            ResultSet rsPago = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            StrSql.append("st_ValidaCostosTmp ").append(StrclExpediente).append(",").append(StrclCosto);
            ResultSet rsCostoTmp = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            StrSql = null;
            if (rsCostoTmp.next()) {
                StrTieneTmp = rsCostoTmp.getString("TieneTmp");
                StrExisteCosto = rsCostoTmp.getString("ExisteCosto");
                StrclCuenta = rsCostoTmp.getString("clCuenta");
                if (StrTieneTmp.equalsIgnoreCase("1")) {
                    StrComrpobanteTmp = rsCostoTmp.getString("Comprobante");
                }
            }
            rsCostoTmp.close();
            rsCostoTmp = null;
            Costos costo = null;
            DAOCostos daoCosto = null;
            if (StrExisteCosto.equalsIgnoreCase("1")) {
                costo = new Costos();
                daoCosto = new DAOCostos();
                costo = daoCosto.getCostos(StrclCosto);
                if (StrTieneTmp.equalsIgnoreCase("0")) {
                    StrComrpobanteTmp = costo.getComprobante();                }               
                }
            /*Busco los datos del domicilio para su futura facturacion por parte del sector de cobranzas PGM: 10/02/2021 */
            DomicilioFacturacion domicilioFacturacion = null;
            DAODomicilioFacturacion dAODomicilioFacturacion = null;
            if ( !StrclExpediente.equalsIgnoreCase("0") ) {
                dAODomicilioFacturacion = new DAODomicilioFacturacion();
                domicilioFacturacion = dAODomicilioFacturacion.getDomicilioFacturacion(StrclExpediente);
            } else {              domicilioFacturacion = new DomicilioFacturacion();         }
            /* Busco datos para la facturaci�n desde el  detalle de asistencia     */
            DatosFactDetAsistencia datosFactDetAsistencia = null;
            DAODatosFactDetAsistencia dAODatosFactDetAsistencia = null;
            if ( !StrclExpediente.equalsIgnoreCase("0") ) {
                dAODatosFactDetAsistencia = new DAODatosFactDetAsistencia();
                datosFactDetAsistencia = dAODatosFactDetAsistencia.getDatosFactDetAsistencia(StrclExpediente);
            }
            /* Dependiendo de los que venga de la base de datos, completo la informaci�n para el alta */
            if ( datosFactDetAsistencia != null ) { 
                /*Datos que salen del expediente en caso de cliente dentro o fuera de base*/
                String nombre = Strings.isNullOrEmpty(domicilioFacturacion.getNombre()) ? datosFactDetAsistencia.getDetAsistUsuarioExpediente() : domicilioFacturacion.getNombre();
                String correo = Strings.isNullOrEmpty(domicilioFacturacion.getCorreo()) ? datosFactDetAsistencia.getDetAsistEmailExpediente() : domicilioFacturacion.getCorreo();
                domicilioFacturacion.setNombre(nombre);
                domicilioFacturacion.setCorreo(correo);
                String direccion = Strings.isNullOrEmpty(domicilioFacturacion.getDireccion()) ? datosFactDetAsistencia.getDetAsistCalle() : domicilioFacturacion.getDireccion();
                String localidad = Strings.isNullOrEmpty(domicilioFacturacion.getLocalidad()) ? datosFactDetAsistencia.getDetAsistLocalidad() : domicilioFacturacion.getLocalidad();
                String provincia = Strings.isNullOrEmpty(domicilioFacturacion.getProvincia()) ? datosFactDetAsistencia.getDetAsistProvincia() : domicilioFacturacion.getProvincia();
                domicilioFacturacion.setDireccion(direccion);
                domicilioFacturacion.setLocalidad(localidad);
                domicilioFacturacion.setProvincia(provincia);
            }
            /* Seteo los labels para:     Nombre y Apellido o Razon social, tipo de comprobante DNI/CUIT, Dependiendo de DNI/CUIT default del tipo de comprobante  */
            if ( costo != null ) {
                /*Para la opcion modificacion, tomo los datos del costo*/
                if ( costo.getDniCuil() != null && costo.getDniCuil().trim().length() > 0 ) {
                    if (costo.getDniCuil().trim().length() == 11 ) {
                        if ( costo.getDniCuil().startsWith("2") ) {
                            //Personas fisicas 20,23,24,27
                            labelNombre = "Nombre y Apellido";
                            labelTipoDocumento = "CUIL";
                            comprobanteDefault = "B";
                        }
                        if ( costo.getDniCuil().startsWith("3") ) {
                            //Empresas
                            labelNombre = "Razon social";
                            labelTipoDocumento = "CUIT";
                            comprobanteDefault = "A";
                        }
                    } else {
                        labelNombre = "Nombre y Apellido";
                        labelTipoDocumento = "DNI";
                        comprobanteDefault = "B";
                    }
                }
            } else {
                /*Para la opcion de alta, tomo los datos del afiliado*/
                if ( domicilioFacturacion != null &&
                            domicilioFacturacion.getDni() != null && 
                                domicilioFacturacion.getDni().trim().length() > 0 ) {
                    if (domicilioFacturacion.getDni().trim().length() == 11 ) {
                        if ( domicilioFacturacion.getDni().startsWith("2") ) {
                            //Personas fisicas 20,23,24,27
                            labelNombre = "Nombre y Apellido";
                            labelTipoDocumento = "CUIL";
                            comprobanteDefault = "B";
                        }
                        if ( domicilioFacturacion.getDni().startsWith("3") ) {
                            //Empresas
                            labelNombre = "Razon social";
                            labelTipoDocumento = "CUIT";
                            comprobanteDefault = "A";
                        }
                    } else {
                        labelNombre = "Nombre y Apellido";
                        labelTipoDocumento = "DNI";
                        comprobanteDefault = "B";
                    }
                }
            }
            /*Cuando es un cambio y el medio de pago es mercado pago, no tienen que poder modificar proveedor, concepto, comprobante y costo nu*/
            if ( costo != null && 
                    costo.getClCosto() != null &&
                    !costo.getClCosto().equalsIgnoreCase("0") &&
                    costo.getClMedioPago().equalsIgnoreCase("2") ) {
                enableCambiarMP = false;
            } else {
                enableCambiarMP = true;
            }
            //OBTENGO LOS PARAMETROS GUARDADOS PARA MOSTRARLOS ( JOA )
            ParamCostos ParamC = null;
            DAOParamCostos daoParam = null;
            ParamC = new ParamCostos();
            daoParam = new DAOParamCostos();
            ParamC = daoParam.getParamC();
            String GestionCat =ParamC != null ? ParamC.getGestionCat() : "000";
            String PorcentajeRec =ParamC != null ? ParamC.getPorcentajeRec() : "000";
            //Calculo de costo final  -JOA-
            Double CFinal;
            Double GC = Double.parseDouble(GestionCat);
            Double numDOU = 3.5;
            CFinal = (numDOU + Double.parseDouble(GestionCat)) * Double.parseDouble(PorcentajeRec);
            Double GesCat =Double.parseDouble(GestionCat);
            Double PorcRec = Double.parseDouble(PorcentajeRec) ;
        %>
        <script>fnOpenLinks()</script>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "fnBorraCosto();fnAccionesAlta()", "fnExcepcion();", "fnGuarda();fnAntesGuarda();fnKMS();")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>Costos.jsp?'>
        <% if (rsPago.next()) { if (rsPago.getString("clPagoProveedor").equalsIgnoreCase("0")) { %>
        <script>
            document.all.btnElimina.disabled = false;
            document.all.btnCambio.disabled = false;
        </script>
        <% } else { %>
        <script>
            document.all.btnElimina.disabled = true;
            document.all.btnCambio.disabled = true;
        </script>
        <% }
            }
            rsPago.close();
            rsPago = null;
        %>
        <INPUT id='clCosto' name='clCosto' type='hidden' value='<%=costo != null ? costo.getClCosto() : '0'%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='clUsrAppRegistra' name='clUsrAppRegistra' type='hidden' value='<%=StrclUsrApp%>'>
        <input id='clUsrAppAut' type='hidden' name='clUsrAppAut' value='<%=costo != null ? costo.getClUsrAppAut() : '0'%>'>
        <input id='MotivoAut' type='hidden' name='MotivoAut' value='<%=costo != null ? costo.getMotivoAut() : '0'%>'>
        <input id='clServicio' type='hidden' name='clServicio' value='<%=StrclServicio%>'>
        <INPUT id='Nomina' name='Nomina' type='hidden' value='0'>
        <INPUT id='clCostoxSubservxEF' name='clCostoxSubservxEF' type='hidden' value=''>
        <INPUT id='clCostoXProvXSubserv' name='clCostoXProvXSubserv' type='hidden' value=''>
        <INPUT id='PorcentajeDesc' name='PorcentajeDesc' type='hidden' value=''>
        <INPUT id='CostoRealSEA' name='CostoRealSEA' type='hidden' value=''>       
        <input id='TieneTmp' type='hidden' name='TieneTmp' value='<%=StrTieneTmp%>'>
        <input id='ComprobanteTmp' type='hidden' name='ComprobanteTmp' value='<%=StrComrpobanteTmp%>'>
        <input id='clCategoria' type='hidden' name='clCategoria' value='<%=costo != null ? costo.getClCategoria() : '0'%>'>
        <input id='KmRecorridos' type='hidden' name='KmRecorridos' value=''>
        <input id='clGrupoCuenta' type='hidden' name='clCuenta' value='<%=StrclCuenta%>'>
        <!--Estos input son provisorios, hasta que pueda crear la tabla cTipoFactura-->
        <div id="DivTipoPago" style="visibility: 'hidden'">
            <%=MyUtil.ObjInput("Opcion Pago", "chckOpcPago", costo != null ? costo.getChckOpcPago() : "0", true, true, 345, 150, "0", false, false, 7, "")%>                
        </div>        
        <%=MyUtil.ObjComboC("Proveedor", "clProveedor", costo != null ? costo.getDsProveedor() : "", true, enableCambiarMP, 30, 70, "", "sp_LlenaComboProvxExp " + StrclExpediente, "", "", 50, true, true)%>
        <%=MyUtil.ObjComboC("Concepto", "clConcepto", costo != null ? costo.getDsConcepto() : "", true, enableCambiarMP, 30, 110, "", "sp_LlenaConceptos " + StrclExpediente + "," + StrclCosto, "fnRegresaCosto(),cargaCostoParaFact()", "", 50, true, true)%>
        <%=MyUtil.ObjComboC("Medio de pago", "clMedioPago", costo != null ? costo.getDsMedioPago() : "", true, false, 420, 110, "3", "select clMedioPago,dsMedioPago from cMedioPago where Activo = 1", "/*fnCostoT(),*/fnLinkPos()", "", 50, true, false)%>
        <%=MyUtil.ObjInput("Concepto (otro)", "Concepto", costo != null ? costo.getConcepto() : "", true, true, 30, 150, "", false, false, 50)%>
        <%=MyUtil.ObjChkBox("Excepcion", "Excepcion", costo != null ? costo.getExcepcion() : "", true, true, 480, 60, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjInput("Costo Convenido", "CostoConv", costo != null ? costo.getCostoConv() : "", false, false, 30, 201, "0", false, false, 7, "")%>
        <%=MyUtil.ObjInput("Paga IKE", "CostoSEA", costo != null ? costo.getCostoSEA() : "", true, true, 160, 201, "0", true, true, 7, "fnTotaliza()/*,fnCostoT()*/")%>
        <%=MyUtil.ObjInput("Paga NU<BR>(SIN IVA)", "CostoNU", costo != null ? costo.getCostoNU() : "", true, enableCambiarMP, 250, 190, "0", false, false, 7, "fnTotaliza()/*,fnCostoT()*/")%>                
        <div id="DVKMS" style="visibility: 'hidden'">
            <%=MyUtil.ObjInput("KM NU", "KMExcedente", costo != null ? costo.getKMExcedente() : "0", true, true, 340, 201, "0", false, false, 7, "")%>                
        </div>
        <div id="DivCIA" style="visibility: 'hidden'">
            <%=MyUtil.ObjInput("Costo CIA", "CostoCIA", costo != null ? costo.getCostoCIA() : "0", true, true, 345, 150, "0", false, false, 7, "")%>                
        </div>
        <%=MyUtil.ObjInput("Excedente (informativo)", "CostoExced", costo != null ? costo.getCostoExced() : "", false, false, 420, 201, "0", false, false, 7)%>
        <div class='VTable' style='position:absolute; z-index:25; left:250px; top:80px;'>
            <INPUT type='button' VALUE='Registro de Pago' onClick='this.disabled = true; fnRegistraPago();' class='cBtn'>
        </div>
        <div id="LaPos" style="visibility:'hidden'">             
            <%=MyUtil.ObjInput("Comprobante:", "Comprobante", (costo != null && !Strings.isNullOrEmpty( costo.getComprobante() )) ? costo.getComprobante() : " ", true, enableCambiarMP, 430, 150, "", false, false, 25, "maxLength=\"\" ;")%>    
            <a id="linkPosImage" name="linkPos" href="https://www.mercadopago.com.ar/ "  target="_blank" style="position: absolute; z-index: 555; left: 590px; top: 80px;">
                <img src="../Imagenes/logoMercadoPago.png" border="1" width='165' height='110' alt="Mercado Pago">
            </a>
        </div>
        <div id="divTipoPagoMP" class='VTable' style='position:absolute; z-index:555; left:590px; top:195px;' >
            <input class='VTable' id="MercadoPago0" type="radio"  name="MercadoPagoFP" value="0"  checked ="true" onclick="fnValorRadio()">Pago manual
            <input class='VTable' id="MercadoPago1" type="radio"  name="MercadoPagoFP" value="1"  onclick="fnValorRadio()">Link de pago
            <input id='MercadoPago' type='hidden' name='MercadoPago' <%--type='hidden'--%>/>
            <input id='estatus' type='hidden' name='Estatus' value='<%=(costo != null && !Strings.isNullOrEmpty( costo.getEstatus() )) ? costo.getEstatus() : "76"%>'>
        </div> 
        <div class='VTable' style='position:absolute; z-index:35; left:710px; top:195px;'>
            <INPUT name ='btnAgregar' type='button' VALUE='Agregar' id="btnAgregar" class='cBtn' onclick ="document.all.btnCancela.disabled = true;
                    document.all.btnAlta.disabled = true;
                    document.all.btnCambio.disabled = true;
                    document.all.btnElimina.disabled = true;
                    fnValida();
                    fnGuarda();
                    fnAntesGuarda();
                    fnKMS();
                    if (msgVal == '') {
                        fnAgrega();
                    } else {
                        alert('Falta informar: ' + msgVal)
                    }" >
        </div>
        <input name='ComprobanteMsk' id='ComprobanteMsk' type='hidden' value='VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09'>
        <BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
        <iframe name="Listado de Costos" id="ListadoCostos" src="ListaCostosTmp.jsp" align="left" width="100%" height="50%"></iframe>
        <%=MyUtil.DoBlock("Costo", 130, 10)%>
        <div id="Facturacion" style="visibility:'visible'">
           <%=MyUtil.ObjInput(labelNombre, "Nombre", costo != null ? costo.getNombre() : "", editableNombre, editableNombre, 30, 305, domicilioFacturacion != null ? domicilioFacturacion.getNombre():"", true, true, 40)%>
           <%=MyUtil.ObjInput("Domicilio", "Domicilio", costo != null ? costo.getDomicilio():  "", editableDomicilio, editableDomicilio, 30, 345, domicilioFacturacion != null ? domicilioFacturacion.getDireccion():"", true, true, 60)%>  
           <%=MyUtil.ObjInput("Concepto", "dsConcepto", costo != null ? costo.getDsConcepto() : "", editableConcepto, editableConcepto, 30, 385, costo != null ? costo.getDsConcepto() : "", true, true, 35)%>  
           <%=MyUtil.ObjInput(labelTipoDocumento, "DniCuil", costo != null ? costo.getDniCuil().trim() : "", editableDniCuil, editableDniCuil, 300, 305, domicilioFacturacion != null ? domicilioFacturacion.getDni().trim():"", true, true, 25, "fnValidarDocumento();")%>  
           <%=MyUtil.ObjInput("Mail", "Mail", costo != null ? costo.getMail() : "", editableMail, editableMail, 490, 305, domicilioFacturacion != null ? domicilioFacturacion.getCorreo():"", true, true, 32)%>  
           <%=MyUtil.ObjInput("Provincia", "Provincia", costo != null ? costo.getProvincia() : "", editableProvincia, editableProvincia, 380, 345, domicilioFacturacion != null ? domicilioFacturacion.getProvincia():"", true, true, 25)%>  
           <%=MyUtil.ObjInput("Localidad", "Localidad", costo != null ? costo.getLocalidad() : "", editableLocalidad, editableLocalidad, 560, 345, domicilioFacturacion != null ? domicilioFacturacion.getLocalidad():"", true, true, 25)%>  
           <%=MyUtil.ObjInput("Costo", "CostoMP", costo != null ? costo.getCostoMP() : "", editableCosto, editableCosto, 300, 385, costo != null ? costo.getCostoMP() : "", true, true, 25)%>  
           <%=MyUtil.ObjComboC ("Tipo de Factura", "dsTipoFactura", costo != null ? costo.getDsTipoFactura(): comprobanteDefault, true, false, 500, 385, comprobanteDefault, "st_TiposFactura", "", "", 50, true, true)%>                
           <%=MyUtil.DoBlock("Mercado Pago", 50, 10)%>
           <div class='VTable' style='position:absolute; z-index:25; left:650px; top:400px;'>
            <INPUT name ='btnEnviar' 
                   type='button' 
                   VALUE='Enviar' 
                   onClick='this.disabled = true;' 
                   class='cBtn'>
           </div>
        </div>    
        <%=MyUtil.GeneraScripts()%>
        <script>
//------------------------------------------------------------------------------
            /*Queda anulado porque por ahora, no se esta utilizando. PGM: 22/02/2021  */
            document.all.DivTipoPago.style.visibility = 'hidden';
            document.all.btnAgregar.disabled = true;
            document.all.btnAgregar.style.visibility = 'hidden';
            document.all.btnEnviar.disabled = true;
            document.all.btnEnviar.style.visibility = 'hidden';
            document.all.Facturacion.style.visibility = 'hidden';
            document.all.MercadoPago0.disabled = true;
            document.all.MercadoPago1.disabled = true;
            document.all.divTipoPagoMP.style.visibility = 'hidden';
            /* Como la opcion de pago por default es 3 (), tengo que poner por default, los campos permitidos y bloqueados
             correspondientes a dicha opcion, pero solamente en ALTAS  */
           <%
           if ( costo == null || Strings.isNullOrEmpty( costo.getClCosto() ) ||   costo.getClCosto().equalsIgnoreCase("0") ) {   %>
                    document.all.Comprobante.readOnly = true;
                    document.all.LaPos.style.visibility = 'hidden';
                    document.all.Comprobante.value = ' ';
                    document.all.CostoNU.disabled = true;
                    document.all.CostoNU.value = '0';
                    document.all.CostoMP.value = '0';
                    document.all.CostoSEA.disabled = false;
                    document.all.Facturacion.style.visibility = 'hidden';
                    document.all.MercadoPago0.disabled = true;
                    document.all.MercadoPago1.disabled = true;
                    document.all.divTipoPagoMP.style.visibility = 'hidden';
                    document.all.estatus.value='76';
           <% } %>
//------------------------------------------------------------------------------
           /**COMIENZO CON LA DEFINICION DE FUNCIONES*/
            function fnValidaTmp() {
                if (document.all.TieneTmp.value == '1') {
                    document.all.Action.value = 1;
                    document.all.btnGuarda.disabled = false;
                    document.all.btnCancela.disabled = false;
                    document.all.btnAlta.disabled = true;
                    document.all.btnCambio.disabled = true;
                    document.all.btnElimina.disabled = true;
                    fnHabilitaA();
                    fnAccionesAlta();
                }
            }
            
            /*Pongo en null la variable costos
             * para que no me genere problemas en
             * la opcion en la que dan de alta
             * luego de consultar. AL consultar,
             * costos no es null y eso genera
             * errores
             * @returns {undefined}
             */
            function fnBorraCosto() {
               <%
                costo = null;
               %>
            }
//------------------------------------------------------------------------------
            function fnAccionesAlta() {
                document.all.DivTipoPago.style.visibility = 'hidden';   
                if (document.all.clServicio.value == "1") {    document.all.Concepto.ReadOnly = true;                }
                document.all.btnAgregar.disabled = false;
                document.all.LaPos.style.visibility = 'hidden';
                document.all.Facturacion.style.visibility = 'hidden';
                document.all.CostoNU.disabled = true;
                document.all.CostoNU.value = '0';
                //EL COSTO CIA SE MOSTRARA SOLO PARA ICBC-AIG
                if (document.all.clGrupoCuenta.value != "1579"){     document.all.DivCIA.style.visibility = 'hidden';       }
                fnAplica(false);
            }
//------------------------------------------------------------------------------
            function fnAntesGuarda() {
                if (document.all.clMedioPago.value == "2" && document.all.Comprobante.value == "") {
                    msgVal = msgVal + " Comprobante";
                    document.all.btnGuarda.disabled = false;
                    document.all.btnCancela.disabled = false;
                }
            }
//------------------------------------------------------------------------------
            function fnGuarda() {
                if ((document.all.clServicio.value != "1") && (document.all.Concepto.value == '')) {
                    msgVal = msgVal + " Concepto (otro). ";                }
            }
//------------------------------------------------------------------------------
            function fnSubmitOK(pclUsr, pMotivo) {
                document.all.clUsrAppAut.value = pclUsr;
                document.all.MotivoAut.value = pMotivo;
                document.all.forma.action = "../servlet/Utilerias.EjecutaAccion";
                document.all.forma.submit();
            }
//------------------------------------------------------------------------------
            function fnAgrega() {
                document.all.forma.action = "../servlet/Utilerias.ValidaCostoTmp";
                this.disabled = true;
                document.all.btnCancela.disabled = true;
                document.all.btnAlta.disabled = true;
                document.all.btnCambio.disabled = true;
                document.all.btnElimina.disabled = true;
                fnValida();
                fnGuarda();
                if (msgVal == '') {
                    fnOpenWindow();
                    document.all.forma.submit();
                } else {      alert('Falta informar: ' + msgVal)         }
            }
//------------------------------------------------------------------------------
            function fnPago() {
                alert('Pago Registrado');
                document.all.PendientePagoC.checked = false;
            }
//------------------------------------------------------------------------------
            function fnTotaliza() {
                if (document.all.Action.value != '') {
                    CostoExcedente = eval(parseFloat(document.all.CostoSEA.value) + parseFloat(document.all.CostoNU.value) - parseFloat(document.all.CostoConv.value));
                    if (CostoExcedente < 0) {      CostoExcedente = 0;             }
                    document.all.CostoExced.value = CostoExcedente;
                    /*Seteo el importe para  mercado pago, solamente si es > 0  */
                    if ( parseFloat(document.all.CostoNU.value) > 0 ) {
                        document.all.CostoMP.value = document.all.CostoNU.value;
                        var cuenta = document.all.clCuenta.value;
                        console.log("clcuenta:  " + cuenta);
                        if(cuenta == '1894' || cuenta == '1839'){
                            var GC= <%= Double.parseDouble(GestionCat) %>;
                            var PR= <%= Double.parseDouble(PorcentajeRec) %>;
                            var fin = (parseFloat(document.all.CostoNU.value) + parseFloat(GC) )* parseFloat(PR)/100;
                            document.all.CostoMP.value = parseFloat(fin);
                        }
                    } else {
                        /*Tengo que setear el dato dependiendo de la opcion de medio de pago. Si no es MP, tengo que ponerlo en cero para que lo 
                         * grabe correctamente y no de error de que falta cargar el valor en costo. Pero si es MP y el importe PagaNU es cero, tengo que ponerlo
                         * en blanco para que de error y lo tengan que cargar si o si, ya que este campo, para MP es obligatorio        */
                        if ( document.all.clMedioPago.value == "2" ) {
                            document.all.CostoMP.value = '';
                        } else {
                            document.all.CostoMP.value = '0';
                        }
                    }
                }
            }
//------------------------------------------------------------------------------
            function fnPorcentaje() {
                // Rango 0-100
                if (document.all.PorcentajeDesc.value < 0) {
                    alert('Porcentaje debe ser entre 0 y 100');
                    document.all.PorcentajeDesc.value = 0;
                }
                if (document.all.PorcentajeDesc.value > 100) {
                    alert('Porcentaje debe ser entre 0 y 100');
                    document.all.PorcentajeDesc.value = 0;
                }
                //Calcular porcentaje
                document.all.CostoRealSEA.value = document.all.CostoSEA.value;
                CostoReal = eval(parseFloat(document.all.CostoRealSEA.value) - parseFloat(document.all.CostoRealSEA.value) * parseFloat(document.all.PorcentajeDesc.value) / 100);
                if (CostoReal < 0) {        CostoReal = 0;                }
                document.all.CostoSEA.value = CostoReal;
                CostoExcedente = eval(parseFloat(document.all.CostoSEA.value) + parseFloat(document.all.CostoNU.value) - parseFloat(document.all.CostoConv.value));
                if (CostoExcedente < 0) {                    CostoExcedente = 0;                }
                document.all.CostoExced.value = CostoExcedente;
            }
//------------------------------------------------------------------------------
            function fnLinkPos() {
                if (document.all.clMedioPago.value == "1") {
                    document.all.LaPos.style.visibility = 'hidden';
                    document.all.Comprobante.value = ' ';
                    document.all.Comprobante.readOnly = true;
                    document.all.CostoNU.disabled = false;
                    document.all.CostoMP.value = '0';
                    document.all.Facturacion.style.visibility = 'hidden';
                    document.all.MercadoPago0.disabled = true;
                    document.all.MercadoPago1.disabled = true;
                    document.all.divTipoPagoMP.style.visibility = 'hidden';
                    document.all.CostoSEA.disabled = false;
                    document.all.estatus.value='76';
                    fnAplica(false);
                } else if (document.all.clMedioPago.value == "2") {   <%
                  /**   Solamente dejo modificar los campos   en la opcion de alta, no en cambio.
                  */
                  if ( costo == null ||    costo.getClCosto() == null ||   costo.getClCosto().equalsIgnoreCase("0") ) {
                    /**Los que no son de base, tienen clAfiliado en null o en cero, por lo que es un fuera de base al que hay que cargarle 
                       todos los datos, en caso de mercado pago   */
                    if ( Strings.isNullOrEmpty( domicilioFacturacion.getClAfiliado() ) ||  domicilioFacturacion.getClAfiliado().equalsIgnoreCase("0") ) {  %>                       
                        document.all.Domicilio.readOnly = false;
                        document.all.Localidad.readOnly = false;
                        document.all.Provincia.readOnly = false;
                        document.all.DniCuil.readOnly = false;
                        document.all.Mail.readOnly = false;
                        document.all.Nombre.readOnly = false;
                    <%   } else {
                        /*  Si es un cliente en base y el servicio es del tipo vial, tengo que permitirle modificar el dato de la calle, localidad y provincia. */
                        if ( domicilioFacturacion.getDetalleServicio().equals("ASISTENCIA VIAL") ) {  %>
                            document.all.Domicilio.readOnly = false;
                            document.all.Localidad.readOnly = false;
                            document.all.Provincia.readOnly = false;
                            document.all.DniCuil.readOnly = true;
                            document.all.Mail.readOnly = true;
                            document.all.Nombre.readOnly = true;
                        <%  } else {
                        /*  Para cualquier otro servicio, los campos son   readonly ya que va a quedar la informacion obtenida de la base de datos  */
                        %>
                            document.all.Domicilio.readOnly = true;
                            document.all.Localidad.readOnly = true;
                            document.all.Provincia.readOnly = true;
                            document.all.DniCuil.readOnly = true;
                            document.all.Mail.readOnly = true;
                            document.all.Nombre.readOnly = true;
                        <%  
                        };
                    }
                    /*  Por ultimo, para todos los casos, si no existe el mail, deben cargarlo.   PGM: 18/03/21. Agrego que si es fuera de base, se pueda modificar el mail. */
                    if ( Strings.isNullOrEmpty( domicilioFacturacion.getCorreo() ) || domicilioFacturacion.getClAfiliado().equalsIgnoreCase("0") ) { %>
                        document.all.Mail.readOnly = false;
                    <% } else { %>
                        document.all.Mail.readOnly = true;
                    <% }   %>
                    document.all.LaPos.style.visibility = 'visible';
                    document.all.CostoNU.disabled = false;
                    document.all.Facturacion.style.visibility = 'visible';
                    document.all.MercadoPago0.disabled = false;
                    document.all.MercadoPago1.disabled = false;
                    document.all.divTipoPagoMP.style.visibility = 'visible';
                    document.all.MercadoPago0.ckecked = false;
                    document.all.MercadoPago1.ckecked = true;
                    document.all.estatus.value = '80';  //Mercado Pago y Link de Pago
                    fnValorRadio();
                    fnAplica(true);
                    cargaCostoParaFact();
                 <% } else {    %>
                    document.all.Domicilio.readOnly = true;
                    document.all.Localidad.readOnly = true;
                    document.all.Provincia.readOnly = true;
                    document.all.DniCuil.readOnly = true;
                    document.all.Mail.readOnly = true;
                    document.all.Nombre.readOnly = true;
                    document.all.LaPos.style.visibility = 'visible';
                    document.all.CostoNU.disabled = true;
                    document.all.Facturacion.style.visibility = 'visible';
                    document.all.divTipoPagoMP.style.visibility = 'visible';
                    /* GEA: 10/06/21. Si el estado del costo es  RECHAZADO(84)y el link aun no expiro,  entonces muestro costo = 0   */
                 <% if ( costo.getDsEstatus().equals("MP Monto Rechazado") && !costo.isExpired() ){      %>
                        document.all.CostoMP.value = "0";
                    <% }  %>            
                 <%  }   %>            
                } else if (document.all.clMedioPago.value == "3") {
                    document.all.Comprobante.readOnly = true;
                    document.all.LaPos.style.visibility = 'hidden';
                    document.all.Comprobante.value = ' ';
                    document.all.CostoSEA.disabled = false;
                    document.all.CostoNU.disabled = true;
                    document.all.CostoNU.value = '0';
                    document.all.CostoMP.value = '0';
                    document.all.Facturacion.style.visibility = 'hidden';
                    document.all.MercadoPago0.disabled = true;
                    document.all.MercadoPago1.disabled = true;
                    document.all.divTipoPagoMP.style.visibility = 'hidden';
                    document.all.estatus.value='76';
                    fnAplica(false);
                    fnTotaliza();
                }
            }
//------------------------------------------------------------------------------
            /*Seteo la configuraci�n inicial de los radio button*/
            function fnValorRadioInicial() {
             <% if (costo != null && costo.getClMedioPago().equalsIgnoreCase("2") ) { %>
                    document.all.MercadoPago0.disabled = true;
                    document.all.MercadoPago1.disabled = true;
                    <% if ( costo.getChckOpcPago().equalsIgnoreCase("0") ) { %>
                        document.all.MercadoPago0.checked = true;
                        document.all.MercadoPago1.checked = false;     
                        document.all.estatus.value = '79'; //Mercado pago manual 
                    <% } else { %>
                        document.all.MercadoPago0.checked = false;
                        document.all.MercadoPago1.checked = true; 
                        document.all.estatus.value = '80'; //Mercado pago lin
                    <% } %>
                        fnValorRadio();
                    <%
                } else { %>
                    document.all.MercadoPago0.disabled = false;
                    document.all.MercadoPago1.disabled = false;                           
                    document.all.MercadoPago0.checked = false;
                    document.all.MercadoPago1.checked = true; 
                    //document.all.estatus.value = '80';  //Mercado Pago link
             <% } %>
                 //fnValorRadio();
            }
//------------------------------------------------------------------------------
            /*Seteo el valor de tipo de pago y activo/desactivo componentes */
            function fnValorRadio() {
                    if ( document.all.MercadoPago1.checked ) {
                        document.all.CostoSEA.disabled = true;
                        document.all.MercadoPago.value = '1';
                        document.all.Comprobante.readOnly = true;
                        document.all.linkPosImage.href = 'javascript:void(0)';
                        document.all.linkPosImage.removeAttribute("target");
                        document.all.linkPosImage.style.cursor = 'default';
                        <% if (request.getParameter("clCosto") == null) { %>
                            document.all.Comprobante.value = ' ';            //El comprobante no se carga en esta opcion de link de pago
                        <% } %>
                        document.all.chckOpcPago.value = '1';
                        document.all.estatus.value = '80';  //Mercado Pago link
                    } else {
                        document.all.CostoSEA.disabled = false;
                        document.all.Comprobante.readOnly = false;
                        document.all.linkPosImage.href = 'https://www.mercadopago.com.ar/';
                        if(document.all.clMedioPago.value == "2"){
                            document.all.linkPosImage.target = '_blank';     }
                        document.all.linkPosImage.style.cursor = 'pointer';
                        document.all.MercadoPago.value = '0';
                        document.all.LaPos.style.disabled = false;
                        document.all.LaPos.style.visibility = 'visible';
                        document.all.chckOpcPago.value = '0';
                        document.all.Comprobante.value = document.all.ComprobanteTmp.value;
                        document.all.estatus.value = '79';  //Mercado Pago manual
                    }
            }
//------------------------------------------------------------------------------
            /*Setea los valores del panel de facturacion con el texto NA para los casos en los que no sean pagos por mercado pago
             * checkeado con Diego Montaut PGM: 18/03/2021*/
            function fnAplica(aplica) {
              /**Esta funcion aplica solamente para la opcion de alta*/
           <% if ( costo == null || costo.getClCosto() == null || costo.getClCosto().equalsIgnoreCase("0") ) { %>
                if ( aplica ) {
                    document.all.Nombre.value     = '<%= (domicilioFacturacion != null ? domicilioFacturacion.getNombre():"") %>';
                    document.all.Domicilio.value  = '<%= (domicilioFacturacion != null ? domicilioFacturacion.getDireccion():"") %>';
                    document.all.DniCuil.value    = '<%= (domicilioFacturacion != null ? domicilioFacturacion.getDni():"") %>';
                    document.all.Mail.value       = '<%= (domicilioFacturacion != null ? domicilioFacturacion.getCorreo():"") %>';
                    document.all.Provincia.value  = '<%= (domicilioFacturacion != null ? domicilioFacturacion.getProvincia():"") %>';
                    document.all.Localidad.value  = '<%= (domicilioFacturacion != null ? domicilioFacturacion.getLocalidad():"") %>';
                    document.all.CostoMP.value    = document.all.CostoNU.value;
                    document.all.dsTipoFactura.value = '<%= comprobanteDefault %>';
                    cargaCostoParaFact();   //Carga el concepto
                } else {
                    document.all.Comprobante.value = ' '
                    document.all.Nombre.value = 'NA';
                    document.all.Domicilio.value = 'NA';
                    document.all.dsConcepto.value = 'NA';
                    document.all.DniCuil.value = 'NA';
                    document.all.Mail.value = 'NA';
                    document.all.Provincia.value = 'NA';
                    document.all.Localidad.value = 'NA';
                    document.all.CostoMP.value = '';
                    document.all.dsTipoFactura.value = 'N'; 
                }
           <% } %>
            }
//------------------------------------------------------------------------------
            function fnReload() {   location.reload();            }
//------------------------------------------------------------------------------
            function fnKMS() {
                if (document.all.clCategoria.value != '3') {
                    document.all.KMExcedente.value = '0';
                } else {
                    if (document.all.CostoNU.value != '0' && document.all.CostoNU.value != '0.00' && document.all.CostoNU.value != '') {
                        if (document.all.KMExcedente.value == '0' || document.all.KMExcedente.value == '0.00' || document.all.KMExcedente.value == '') {
                            msgVal = 'KM NU no puede quedar en Cero.';
                            document.all.btnGuarda.disabled = false;
                            document.all.btnCancela.disabled = false;
                        }
                    }
                }
                if (document.all.clCategoria.value == '3' || document.all.clCategoria.value == '4') {
                    if (parseFloat(document.all.CostoConv.value) == '0.00') {
                        msgVal = 'Costo Convenido es igual a 0.';
                    } else {
                        KMRecorridos = eval(parseFloat(document.all.CostoSEA.value) / parseFloat(document.all.CostoConv.value));
                        if (KMRecorridos < 0) {
                            KMRecorridos = 0;
                        }
                        document.all.KmRecorridos.value = KMRecorridos;
                    }
                }
            }
//------------------------------------------------------------------------------
            function fnMuestraKMS() {
                if (document.all.clCategoria.value == '3') {
                    document.getElementById('DVKMS').style.visibility = 'visible';
                } else {
                    document.getElementById('DVKMS').style.visibility = 'hidden';
                }
            }
//------------------------------------------------------------------------------
            function fnExcepcion() {
                if (document.getElementById("Excepcion").value == 1) {
                    document.all.ExcepcionC.disabled = true;
                } else {
                    document.all.ExcepcionC.disabled = false;
                }
                 //EL COSTO CIA SE MOSTRARA SOLO PARA ICBC-AIG
                if (document.all.clGrupoCuenta.value != "1579"){
                    document.all.DivCIA.style.visibility = 'hidden';
                }
            }
//------------------------------------------------------------------------------
            //JOMU. Al quitar el foco se activa la funci�n fnDigitos()
            document.getElementById("Comprobante").onblur=function() {fnDigitos(this)};
            function fnDigitos(element){
                /*Controlar solamente para la  opcion de mercado pago, manual     */
                if ( document.all.MercadoPago.value == '0' ) {
                //Remmplazo de espacios, letras y solo numerales (string) 
                    element.value = element.value.replace(" ","");  
                    element.value = element.value.replace(/[^\d.]/g,'');
                //Advierte si se deja el campo vacio o se introducen caracteres no numerales  
                    NoComprobante = element.value;      
                    NoCaracteres = NoComprobante.length;
                   if(NoCaracteres < 1){  alert('El comprobante debe contener digitos ');           }
                }
            }
//------------------------------------------------------------------------------
            /* Seteo el concepto, solamente para opcion mercado pago */
            function cargaCostoParaFact() { <%
                if ( costo == null || 
                        Strings.isNullOrEmpty( costo.getClCosto() ) ||
                        costo.getClCosto().equalsIgnoreCase("0") ) { %>
                    var combobox = document.getElementById("clConceptoC");
                    var labelMedioPago = combobox.options[combobox.selectedIndex].text;
                    /* Para obtener el texto */
                    if ( combobox.selectedIndex >0 ) {
                        if (document.all.clMedioPago.value === '2') {
                           document.all.dsConcepto.value = labelMedioPago !== null ? labelMedioPago : '';
                        } else {     document.all.dsConcepto.value = 'NA';               }
                    } else {       document.all.dsConcepto.value = '';            }
            <% } %>
            }
 //------------------------------------------------------------------------------
            /*Valido el CUIT solamente para el ingreso*/
            function fnValidarDocumento() {
                var dni = new String(document.all.DniCuil.value);
                if ( dni === null || dni === '' || dni == '0' || isNaN(dni) ) {
                    alert('Debe ingresar el numero sin espacios, puntos o guiones');
                    return;
                }
                if ( dni.length !== 7 && dni.length !== 8 && dni.length !== 11 ) {
                    alert('N�mero incorrecto. El numero de documento debe tener 8 o 11 digitos');
                    return;
                }
                /*Valido el numero de cuit o cuil*/
                if ( dni.length === 11 ) {
                    if ( dni.charAt(0) === '3' ) {
                        fnControlCuitCuil(dni,'CUIT');
                    } else {
                        fnControlCuitCuil(dni,'CUIL');
                    }
                }
                /*Cambio los carteles en pantalla*/
                if ( dni.length === 11 ) {
                    if ( dni.charAt(0) === '3' ) {
                        if ( document.getElementById("D18").getElementsByTagName("P")[0].innerHTML.indexOf("Nombre y Apellido") >=0 ) {
                            /*Modifico el label de nombre por razon social*/
                            var textoNombre = document.all.Nombre.value;
                            document.getElementById("D18").getElementsByTagName("P")[0].innerHTML = 
                            document.getElementById("D18").getElementsByTagName("P")[0].innerHTML.replace("Nombre y Apellido","Raz�n Social");
                            document.all.Nombre.value = textoNombre;
                            document.all.Nombre.maxLength =350;
                            /*Modifico el label de dni por cuil o cuit*/
                            var textoDniCuil = document.all.DniCuil.value;
                            document.getElementById("D21").getElementsByTagName("P")[0].innerHTML = 
                            document.getElementById("D21").getElementsByTagName("P")[0].innerHTML.replace("DNI","CUIT");
                            document.getElementById("D21").getElementsByTagName("P")[0].innerHTML = 
                            document.getElementById("D21").getElementsByTagName("P")[0].innerHTML.replace("CUIL","CUIT");
                            document.all.DniCuil.value = textoDniCuil;
                            document.all.DniCuil.maxLength = 11;
                            /*Seteo el valor de tipo de comprobante en A*/
                            document.getElementById("dsTipoFacturaC").selectedIndex = 1;
                        }
                    }
                    if ( dni.charAt(0) === '2' ) {
                        /*Modifico el label de nombre por Nombre y Apellido*/
                        var textoNombre = document.all.Nombre.value;
                        document.getElementById("D18").getElementsByTagName("P")[0].innerHTML = 
                        document.getElementById("D18").getElementsByTagName("P")[0].innerHTML.replace("Raz�n Social","Nombre y Apellido");
                        document.all.Nombre.value = textoNombre;
                        document.all.Nombre.maxLength = 350;
                        /*Modifico el label de dni o cuit por cuil*/
                        var textoDniCuil = document.all.DniCuil.value;
                        document.getElementById("D21").getElementsByTagName("P")[0].innerHTML = 
                        document.getElementById("D21").getElementsByTagName("P")[0].innerHTML.replace("DNI","CUIL");
                        document.getElementById("D21").getElementsByTagName("P")[0].innerHTML = 
                        document.getElementById("D21").getElementsByTagName("P")[0].innerHTML.replace("CUIT","CUIL");
                        document.all.DniCuil.value = textoDniCuil;
                        document.all.DniCuil.maxLength = 11;
                        /*Seteo el valor de tipo de comprobante en B*/
                        document.getElementById("dsTipoFacturaC").selectedIndex = 2;
                    }
                } else {
                    /*Modifico el label de nombre por Nombre y Apellido*/
                    var textoNombre = document.all.Nombre.value;
                    document.getElementById("D18").getElementsByTagName("P")[0].innerHTML = 
                    document.getElementById("D18").getElementsByTagName("P")[0].innerHTML.replace("Raz�n Social","Nombre y Apellido");
                    document.all.Nombre.value = textoNombre;
                    document.all.Nombre.maxLength = 350;        
                    /*Modifico el label de  cuit o cuil por dni*/
                    var textoDniCuil = document.all.DniCuil.value;
                    document.getElementById("D21").getElementsByTagName("P")[0].innerHTML = 
                    document.getElementById("D21").getElementsByTagName("P")[0].innerHTML.replace("CUIL","DNI");
                    document.getElementById("D21").getElementsByTagName("P")[0].innerHTML = 
                    document.getElementById("D21").getElementsByTagName("P")[0].innerHTML.replace("CUIT","DNI");
                    document.all.DniCuil.value = textoDniCuil;
                    document.all.DniCuil.maxLength = 11;        
                    /*Seteo el valor de tipo de comprobante en B*/
                    document.getElementById("dsTipoFacturaC").selectedIndex = 2;
                }
            }
//------------------------------------------------------------------------------
            function fnControlCuitCuil( pCuitCuil, mensaje ){ 
            var datos ={"pCuitCuil": pCuitCuil };
            $.ajax({
                    type: "GET",
                    url: "../api/v1/util/validarCuitCuil.jsp",
                    crossDomain: false,
                    cache: false,
                    data: datos,
                    contentType: 'application/x-www-form-urlencoded; charset=ISO-8859-1',
                    success: function(responseData, status, xhr) {
                        if ( xhr.status === 200 ) {    }
                    },
                    error: function(req, status, error) {
                        if ( req.status === 413 ) {  alert("Largo de "+mensaje+" invalido.");              }
                        if ( req.status === 403 ) {  alert("Codigo de "+mensaje+" invalido.Debe verificar el dato ingresado.");        }
                        if ( req.status === 500 ) {  alert("Error de servicio verificando el codigo de " + mensaje);           }
                    }
                } )
        }
//------------------------------------------------------------------------------
        </script>
    </body>
</html>