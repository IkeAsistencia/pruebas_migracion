<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" import="Combos.cbTipoBenef,Combos.cbTipoContactante,Combos.cbPais,Combos.cbEntidad,Combos.cbEstatus,java.sql.ResultSet,Utilerias.UtileriasBDF" %>
<%@ page import="com.ike.asistencias.DAOExpediente,com.ike.asistencias.to.Expediente,Validacion.DAOExpPermisos,Validacion.to.PermisosExp,Seguridad.SeguridadC" %>
<html>
    <head>
        <title>Detalle del Expediente</title>
        <meta http-equiv='X-UA-Compatible' content='IE=9'/>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" OnLoad="fnVaciarFechaCita();fnDivCalidad();fnMuestraDivs();">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilDireccion.js'></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <script src='../Utilerias/UtilAjax.js'></script>
        <script src='../Utilerias/dhtmlwindowExp.js'></script>
        <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <link href="../StyleClasses/dhtmlwindow.css" rel="stylesheet" type="text/css">
        <%
            String strclUsr = "0";
            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();      }
            if(SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true){
                %><font color="white"  style="font-family:Verdana,Arial,Helvetica,sans-serif; background-color:red;" size=3>LA SESION EXPIRO</font><%  
                strclUsr=null;
                return;
                }
            String StrclExpediente = "0";
            String strclEstatus = "0";
            String strclUsrAppAut = "";
            String supervision = "";
            String strAlertaApp = "0";
            String strLatitud = "";
            String strLongitud = "";
            String CodEnt = "";
            String dsEntFed = "";
            String dsMunDel = "";
            String StrCodMD = "";
            String clCuenta = "0";
            String Clave = "";
            String StrPermiteEnvioCobro = "";
            String StrRevisadoCalidad = "0";
            String StrdsPais = "";
            String StrclPaginaWeb = "155";
            int StrclPais = 10; //Pais default:  Argentina
            String StrTieneAsist = "0";
            String StrclServicio = "0";
            String StrclSubServicio = "0";
            String StrEsDeApp = "0";
            String StrMotivoAutoriza = "";
            if (request.getParameter("clExpediente") != null) {
                StrclExpediente = request.getParameter("clExpediente").toString();
            } else if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();         }
            if (session.getAttribute("alertaApp") != null) {
                strAlertaApp = session.getAttribute("alertaApp").toString();         }
            if(session.getAttribute("clCuenta")!=null){
                clCuenta = session.getAttribute("clCuenta").toString();          }
            session.setAttribute("clExpediente", StrclExpediente);
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <script>fnOpenLinks();</script>
        <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(strclUsr));%>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccionExp", "fnAccionesAlta();fnPaisDefault();", "", "fnValidaPaisEF();validaCorreoAntesGuardar();")%>
        <%
            PermisosExp per = null;
            DAOExpPermisos daoper = null;
            if (session.getAttribute("PermisosExp") == null) {
                per = new PermisosExp();
                daoper = new DAOExpPermisos();
                per = daoper.getPermisosExp(strclUsr);
                session.setAttribute("PermisosExp", "1");
                session.setAttribute("PermiteDuplicar", per.getPermiteDuplicar());
                session.setAttribute("PermiteCotizar", per.getPermiteCotizar());
                session.setAttribute("PermiteMarcaCita", per.getPermiteMarcaCita());
                session.setAttribute("PermiteSMS", per.getPermiteSMS());
                session.setAttribute("PermiteCobertura", per.getPermiteCobertura());
            }
            per = null;
            daoper = null;
            /* VERIFICA PERMISOS PARA REVISAR EXPEDIENTES */
            StringBuffer sf = new StringBuffer();
            sf.append(" st_PermisoCalidad ").append(strclUsr);
            ResultSet cdr = UtileriasBDF.rsSQLNP(sf.toString());
            if (cdr.next()) {    supervision = cdr.getString("supervison");         }
            cdr.close();
            cdr = null;
            Expediente exp = null;
            DAOExpediente daoexp = null;
            if (Integer.parseInt(StrclExpediente) > 0) {
                exp = new Expediente();
                daoexp = new DAOExpediente();
                exp = daoexp.getExpediente(StrclExpediente);
            }
            if (exp != null) {
                CodEnt = exp.getCodEnt();
                dsEntFed = exp.getDsEntFed();
                dsMunDel = exp.getDsMunDel();
                StrCodMD = exp.getCodMD();
                clCuenta = exp.getClCuenta();
                Clave = exp.getClave();
                StrPermiteEnvioCobro = exp.getPermiteEnvioACobro();
                strclUsr = exp.getClUsrApp(); // si existe el usuario en base lo traigo para que no sobrescriba el ejecutaacción al modificar el expediente.
                strclUsrAppAut = exp.getClUsrAppAut();
                StrclPais = Integer.valueOf(exp.getClPais());
                StrdsPais = exp.getDsPais();
                StrRevisadoCalidad = exp.getRevCalidad();
                strLatitud = exp.getLatitud();
                strLongitud = exp.getLongitud();
                strclEstatus = exp.getClEstatus();
                StrTieneAsist = exp.getTieneAsistencia();
                StrclServicio = exp.getClServicio();
                StrclSubServicio = exp.getClSubServicio();
                StrEsDeApp = exp.getEsDeApp();
                StrMotivoAutoriza = exp.getMotivoAut();
            }
            session.setAttribute("clPais", StrclPais);
            session.setAttribute("dsPais", StrdsPais);
            session.setAttribute("CodEnt", CodEnt);
            session.setAttribute("dsEntFed", dsEntFed);
            session.setAttribute("dsMunDel", dsMunDel);
            session.setAttribute("CodMD", StrCodMD);
            session.setAttribute("clCuenta", clCuenta);
            session.setAttribute("Clave", Clave);
            session.setAttribute("clEstatus", strclEstatus);
            session.setAttribute("TieneAsist", StrTieneAsist);
            session.setAttribute("clServicio", StrclServicio);
            session.setAttribute("clSubServicio", StrclSubServicio);
            if (request.getParameter("irASeguimiento") != null) { %>
                <a id="link_seguimiento" href="Seguimiento.jsp?clExpediente=0&Apartado=S" target="Contenido"></a>
                <script>document.getElementById('link_seguimiento').click();</script><%
                }
            if (request.getParameter("irABitacora") != null) {%>
                <a id="link_bitacora" href="BitacoraExpediente.jsp?clExpediente=0&Apartado=S" target="Contenido"></a>
                <script>document.getElementById('link_bitacora').click();</script>
                <% } %>
        <input id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>DetalleExpediente.jsp?'/>
        <input id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='155'/>
        <input id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'/>
        <input id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'/>
        <input id='supervision' name = 'supervision' type = 'hidden' value ='<%=supervision%>'/>
        <input id='clUsrAppAut' type='hidden' name='clUsrAppAut' value="<%=strclUsrAppAut%>"/>
        <input id='ClaveMsk' name='ClaveMsk'  type='hidden' value=''/>
        <input id='ClaveMskUsr' name='ClaveMskUsr'  type='hidden' value=''/>
        <input id='FechaSiniestroMsk' name='FechaSiniestroMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'/>
        <input id='AgenteMsk' name='AgenteMsk'  type='hidden' value='VN09VN09VN09VN09'/>
        <input id="VIP" name="VIP" type="hidden"/>
        <input id="NombreBanco" name="NombreBanco" type="hidden"/>
        <input id="ExisteBin" name="ExisteBin" type="hidden"/>
        <input id="WarmTransfer" name="WarmTransfer" type="hidden"/>
        <input id="ICABin" name="ICABin" type="hidden"/>
        <input id="ICABusinessName" name="ICABusinessName" type="hidden"/>
        <input id="ICACode" name="ICACode" type="hidden"/>
        <input id="ICACountry" name="ICACountry" type="hidden"/>
        <input id="ICALegalName" name="ICALegalName" type="hidden"/>
        <input id="ICARegion" name="ICARegion" type="hidden"/>
        <input id="ICAState" name="ICAState" type="hidden"/>
        <input id="ParentICACode" name="ParentICACode" type="hidden"/>
        <input id="ProdTod" name="ProdTod" type="hidden"/>
        <input id="BenTod" name="BenTod" type="hidden"/>
        <input id="WSALS" name="WSALS" type="hidden"/>
        <input id="prod" name="prod" type="hidden"/>
        <input id="ProductName" name="ProductName" type="hidden"/>    
        <input id='clCuenta' name='clCuenta' type='hidden'  value="<%=exp != null ? exp.getClCuenta() : ""%>" />
        <input id='clDerechoHab' name='clDerechoHab' type='hidden' value="<%=exp != null ? exp.getClDerechoHab() : ""%>"/>
        <%=MyUtil.ObjInput("Expediente", "ExpedienteVTR", exp != null ? exp.getClExpediente() : "", false, false, 25, 92, "", false, false, 12)%>
        <%=MyUtil.ObjInput("Fecha Apertura", "FechaApertura", exp != null ? exp.getFechaApertura() : "", false, false, 105, 92, "", false, true, 22)%>
        <%=MyUtil.ObjInput("Fecha Registro", "FechaRegistroVTR", exp != null ? exp.getFechaRegistro() : "", false, false, 235, 92, "", false, true, 22)%>
        <%=MyUtil.ObjInput("Fecha Siniestro<BR>AAAA/MM/DD HH:MM", "FechaSiniestro", exp != null ? exp.getFechaSiniestro() : "", true, false, 365, 80, "", true, true, 22, "if(this.readOnly==false){fnValMask(this.value,document.all.FechaSiniestroMsk.value,this.name)}")%>
        <%=MyUtil.ObjComboMem("Estatus", "clEstatus", exp != null ? exp.getDsEstatus() : "", exp != null ? exp.getClEstatus() : "", cbEstatus.GeneraHTML(50, exp != null ? exp.getDsEstatus() : ""), false, false, 500, 92, "0", "", "", 50, false, false)%>
        <%=MyUtil.ObjComboMem("Tipo Quien Reporta", "clTipoContactante", exp != null ? exp.getDsTipoContactante() : "", exp != null ? exp.getClTipoContactante() : "", cbTipoContactante.GeneraHTML(50, exp != null ? exp.getDsTipoContactante() : ""), true, true, 25, 140, "15", "fnValidaNU(this.value);", "", 50, false, false)%>
        <%=MyUtil.ObjInput("Quien Reporta", "Contacto", exp != null ? exp.getContacto() : "", true, true, 365, 140, "", true, true, 40, "")%>
        <%=MyUtil.ObjComboC("Tipo Servicio", "clTipoServicio", exp != null ? exp.getDsTipoServicio() : "", true, true, 630, 140, "1", "sp_GetTipoServicio " + strclUsr, "", "", 50, true, true)%>
        <%=MyUtil.ObjComboC("Excepción", "clExcepcion", exp != null ? exp.getDsExcepcion() : "", true, true, 840, 140, "1", "select * from cTipoExcepcion " , "", "", 50, true, true)%>
        <%=MyUtil.ObjInput("Código", "Lada1", exp != null ? exp.getLada1() : "", true, true, 25, 180, "", false, false, 8)%>
        <%=MyUtil.ObjInput("Telefono", "Telefono1", exp != null ? exp.getTelefono1() : "", true, true, 100, 180, "", false, false, 25, "VerificaNumerico(document.all.Telefono1);")%>
        <%=MyUtil.ObjInput("Código", "Lada2", exp != null ? exp.getLada2() : "", true, true, 365, 180, "", false, false, 8)%>
        <%=MyUtil.ObjInput("Telefono Alterno", "Telefono2", exp != null ? exp.getTelefono2() : "", true, true, 430, 180, "", false, false, 25)%>
        <%=MyUtil.ObjInput("Email", "Email", exp != null ? exp.getEmail() : "", true, true, 630, 180, "", false, false, 50, "validaCorreo();")%>
        <% if (exp != null) {
                if (Integer.parseInt(session.getAttribute("PermiteDuplicar").toString()) > 0) {%>
                <input class='cBtn' type='button' value='Duplicar' onClick='location.href = "../Operacion/DuplicaExp.jsp?clExpediente=<%=StrclExpediente%>"'>      <% }
            if (Integer.parseInt(session.getAttribute("PermiteCotizar").toString()) > 0) {%>
                <input class='cBtn' type='button' value='Cotizar' onClick="window.open('MarcarCotizado.jsp?&clExpediente=<%=StrclExpediente%>', '', 'resizable=no,menubar=0,status=0,toolbar=0,height=450,width=800,screenX=-50,screenY=0')">  <% }
            if (Integer.parseInt(session.getAttribute("PermiteMarcaCita").toString()) > 0) {%>
                <input class='cBtn' type='button' value='Marcar Cita' onClick="window.open('MarcarCita.jsp?&clExpediente=<%=StrclExpediente%>', '', 'resizable=no,menubar=0,status=0,toolbar=0,height=150,width=350,screenX=-50,screenY=0')">  <% }
            if (Integer.parseInt(session.getAttribute("PermiteSMS").toString()) > 0) { %>
                <input class='cBtn' id="SMS" name="SMS" type='button' value='Enviar mensaje SMS' onclick="window.open('../SMS/SMSManual.jsp', 'SMS', 'scrollbars=no,status=no,width=670,height=170');">   <% }
            if ((strAlertaApp.equalsIgnoreCase("1")) && (!strLatitud.equalsIgnoreCase("")) && (!strLongitud.equalsIgnoreCase(""))) {%>
                <input class='cBtn' type='button' value='Ubicar' onClick="window.open('https://maps.google.com.mx/?q=<%=strLatitud%>,<%=strLongitud%>', '', 'resizable=yes,menubar=0,status=0,toolbar=0,height=200,width=500,screenX=-50,screenY=0')"/>    <% }
            }
            if (Integer.parseInt(session.getAttribute("PermiteCobertura").toString()) > 0) { %>
        <input id="btnCob" name="btnCob" class='cBtn' type='button' value='Cobertura' onClick="fnMuestraCoberturas();">
        <input id="btnExcepcion" name="btnExcepcion" class='cBtn' type='button' value='Excepciones' onClick="fnMuestraExcepciones();">
            <%}%>
        <%=MyUtil.ObjTextArea("Descripción de lo Ocurrido", "DescripcionOcurrido", exp != null ? exp.getDescripcionOcurrido() : "", "120", "4", true, true, 25, 225, "", false, false)%>
        <%=MyUtil.ObjInput("Cuenta", "Nombre", exp != null ? exp.getNombre() : "", true, false, 25, 300, "", true, true, 40, "if(this.readOnly==false){fnBuscaCuenta()};")%>
        <div id='divLblRevCalidad'>
            <% if (StrRevisadoCalidad.equals("1")) { %>
            <IMG alt="" SRC='../Imagenes/accept5.png' style='position:absolute; z-index:1001; left:770px; top:100px;' WIDTH='18' HEIGHT='18'/>
            <h1 id='lblRevCalidad' class='VTable' style='position:absolute; z-index:1000; left:790px; top:104px;' >REVISADO POR CALIDAD</h1>
            <% } %>
        </div>
        <% if (StrEsDeApp.equalsIgnoreCase("1") && !StrMotivoAutoriza.equalsIgnoreCase("")) {%>
        <div style='position:absolute; z-index:300; left:900px; top:20px;'>
            <p style="color: red; span:hover; background: yellow; color: red; ">
                <font size=5><b><%=StrMotivoAutoriza%></b></font>
            </p>
        </div>
        <% } %>
        <div id='divRevCalidad'>                                                              
            <% if (StrRevisadoCalidad.equals("0")) { %>
                <input id="btndivRevCalidad" name="btndivRevCalidad" class='cBtn' type='button' value='Revisar Expediente' style="position:absolute; z-index:800; left:750px; top:100px;" onclick = 'fnRevisaCalidad()'>   <% } %>
        </div>
        <% if (MyUtil.blnAccess[4] == true) { %>
        <div class='VTable' style='position:absolute; z-index:25; left:250px; top:315px;'>
            <IMG alt=""  SRC='../Imagenes/Lupa.gif' onClick='fnBuscaCuenta();' WIDTH=20 HEIGHT=20>
        </div>
        <% }%>
        <%=MyUtil.ObjInput("Nuestro Usuario", "NuestroUsuario", exp != null ? exp.getNuestroUsuario() : "", true, true, 365, 300, "", true, true, 40, "if(this.readOnly==false){fnBuscaClienteVIP()}")%>
        <% if (MyUtil.blnAccess[4] == true) {%>
        <div class='VTable' style='position:absolute; z-index:25; left:585px; top:315px;'>
                <IMG alt=""  SRC='../Imagenes/Lupa.gif' onClick='fnBuscaAfiliado();' WIDTH=20 HEIGHT=20>
            </div>
            <% }%>
        <%=MyUtil.ObjInput("Clave", "Clave", exp != null ? exp.getClaveMask() : "", true, false, 680, 300, "", true, true, 30, "if(this.readOnly==false){if (fnValMask(this,document.all.ClaveMsk.value,this.name)){fnBuscaClave();}}")%>
        <%=MyUtil.ObjComboC("Ingresó por WhatsApp", "clTipoBeneficiario", exp != null ? exp.getDsTipoBeneficiario() : "", true, true, 660, 220, "4", "Select clTipoBeneficiario, dsTipoBeneficiario from cTipoBeneficiario where clTipoBeneficiario in(4,5)", "", "", 50, true, true)%>
        <div id='divCiaMarsh'>
            <%=MyUtil.ObjInput("Compañia", "Compania", exp != null ? exp.getCompania() : "", false, false, 660, 260, "", false, false, 25, "")%>
        </div>
        
        <div id='divComboCia'>
            <%=MyUtil.ObjComboC("Compañia", "clCodigoCompania", exp != null ? exp.getDsCodigo(): "", true, true, 800, 260, "", "st_CodigoCia " + clCuenta, "", "", 50, false, false)%>
        </div>
        <div id='divBtnMercantil'>
            <input class='cBtn' type='button' value='Buscar en Mercantil' onClick='javascript:fnBusquedaMercantil();' style="position:absolute; z-index:800; left:870px; top:310px;">
        </div>
        
        <div id='divNoSiniestro'>
            <%=MyUtil.ObjInput("Nro. Siniestro", "noSiniestro", exp != null ? exp.getNoSiniestro() : "", true, true, 660, 260, "", false, false, 25, "VerificaNumerico(document.all.noSiniestro);")%>
        </div>
        <% if (StrPermiteEnvioCobro.equalsIgnoreCase("1")) {
                if (!strclEstatus.equalsIgnoreCase("10")) {%>
        <%=MyUtil.ObjChkBox("Se Manda Cobro", "SeMandaCobro", exp != null ? exp.getSeMandaCobro() : "", false, true, 800, 92, "0", "ENVIAR", "NO ENVIAR", "")%>
        <% } else {%>
        <%=MyUtil.ObjChkBox("Se Manda Cobro", "SeMandaCobro", exp != null ? exp.getSeMandaCobro() : "", false, false, 800, 92, "0", "ENVIAR", "NO ENVIAR", "")%>
        <% }
            }%>
        <%=MyUtil.DoBlock("Datos Generales", 80, -5)%>

        <%=MyUtil.ObjComboMem("Pais", "clPais", exp != null ? exp.getDsPais() : "", exp != null ? exp.getClPais() : "", cbPais.GeneraHTML(20, exp != null ? exp.getDsPais() : ""), true, true, 25, 385, "0", "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
        <%=MyUtil.ObjInput("Ciudad", "CiudadExt", exp != null ? exp.getCiudadExt() : "", true, true, 250, 385, "", false, false, 50)%>
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", dsEntFed, CodEnt, cbEntidad.GeneraHTML(20, dsEntFed, StrclPais), true, true, 25, 425, "", "fnLLenaComboMDAjax(this.value);", "", 20, true, true, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", dsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(30, CodEnt, dsMunDel), true, true, 250, 425, "", "", "", 20, true, true, "LocalidadDiv")%>
        <%=MyUtil.DoBlock("Ubicación", 100, 0)%>

        <%=MyUtil.ObjChkBox("Cita", "CitaVTR", exp != null ? exp.getCita() : "", false, false, 580, 385, "0", "")%>
        <%=MyUtil.ObjInput("Fecha Cita<br>aaaa/mm/dd hh:mm", "FechaCitaVTR", exp != null ? exp.getFechaCita() : "", false, false, 680, 385, "", false, false, 25)%>
        <%=MyUtil.DoBlock("Programación de Cita", 0, 20)%>

        <%=MyUtil.ObjChkBox("", "chckAlerta", exp != null ? exp.getChckAlerta() : "", false, true, 650, 510, "0", "CDS", "CDS", "")%>
        <%=MyUtil.ObjChkBox("", "chckAlertaPVD", exp != null ? exp.getChckAlertaPVD() : "", false, true, 650, 550, "0", "PVD", "PVD", "")%>  
        <%=MyUtil.ObjTextArea("Observaciones", "ObserAlerta", exp != null ? exp.getObserAlerta() : "", "40", "5", false, true, 725, 515, "", false, false)%>
        <%=MyUtil.DoBlock("Caso Conflictivo", 50, 50)%>

        <%=MyUtil.ObjInput("Usuario que Registró el Servicio ", "UsrReg", exp != null ? exp.getUsrReg() : "", false, false, 25, 515, "", false, false, 60)%>
        <%=MyUtil.ObjInput("Usuario que Autorizó el Servicio ", "UsrAut", exp != null ? exp.getUsrAut() : "", false, false, 25, 555, "", false, false, 60)%>
        <%=MyUtil.ObjInput("Fecha de Autorización", "FecAut", exp != null ? exp.getFechaAut() : "", false, false, 370, 555, "", false, false, 30)%>
        <%=MyUtil.ObjTextArea("Motivo de Autorización", "MotivoAut", exp != null ? exp.getMotivoAut() : "", "80", "3", false, false, 25, 595, "", false, false)%>
        <%=MyUtil.DoBlock("Seguridad", 50, 30)%>
        <% //HAY QUE QUITAR TODO ESTO!!!
            ResultSet rsSMS1 = UtileriasBDF.rsSQLNP("st_SMSValidaEnvioAsigancion " + StrclExpediente);
            if (rsSMS1.next()) {
                if (rsSMS1.getString("Enviar").equalsIgnoreCase("1")) { %>
        <!--script>document.all.SMS.disabled = false;</script-->
        <% }
        }
        rsSMS1.close();
        %>
        <%=MyUtil.GeneraScripts()%>
        <div id="ConfirmacionBins"  name="ConfirmacionBins" style='position:absolute; z-index:3000; left:800px; top:300px; visibility:hidden'>
            <table class='Table' border='0' cellpadding='0' >
                <tr class = 'TTable'>
                    <td colspan="1">
                <center>
                    <table class="TTable" border="0" width="650">
                        <tr>
                            <td>
                        <center>Alerta de mensagem</center>
                        </td>
                        </tr>
                    </table>
                </center>
                </td>
                <td>
                    <table width="5">
                        <tr>
                            <td>
                                <img src="../../Imagenes/Exit.png" alt="Cerrar Alerta" onclick="fnCloseAlert();">
                            </td>
                        </tr>
                    </table>
                </td>
                </tr>
                <tr class="R1Table" >
                    <td colspan="2">
                        <br>
                <center><table width="600"><tr><td id="T_AlertaMsg"><label id="AlertaMsg" </td></tr></label></table></center>
                <p>
                    </td>
                    </tr>
                <tr class="R1Table" >
                    <td colspan="3">
                        <br>
                <center><table width="600"><tr><td id="AlertaMsgNuevo"><label id="AlertaMsgNuevo" </td></tr></label></table></center>
                <p>
                    </td>
                    </tr>
            </table>
        </div>
        <script>
//------------------------------------------------------------------------------
            top.document.all.DatosExpediente.src = "DatosExpediente.jsp";
            document.all.Email.maxLength = 100;
            document.all.divCiaMarsh.style.visibility = "hidden";
            document.all.divBtnMercantil.style.visibility = "hidden";
            document.all.divNoSiniestro.style.visibility = "hidden";
            document.all.divComboCia.style.visibility = "hidden";
            var nav4 = window.Event ? true : false;
            var Mail = window.Event ? true : false;
            top.document.all.rightPO.rows = "70,*";
//------------------------------------------------------------------------------
            function fnBusquedaMercantil() {
                var url = "../Operacion/KM0/lma/consultaPatente.jsp";
                window.open(url, 'newWin', 'scrollbars=yes,status=yes,width=500,height=350');
            }
//------------------------------------------------------------------------------
            function fnPaisDefault() {
                document.all.clPais.value = 10;
                document.all.clPaisC.value = 10;
                fnLlenaEntidadAjaxFn(10); // Carga Entidades de Argentina Por Default
            }
//------------------------------------------------------------------------------
            function actualizar() {           location.reload();            }
//------------------------------------------------------------------------------
            function fnActualizaNU() {
                if (document.all.NuestroUsuario.value == '') {
                    document.all.NuestroUsuario.value = document.all.Contacto.value;
                    }
                }
//------------------------------------------------------------------------------
            function fnBuscaClienteVIP() {
                if (document.all.NuestroUsuario.value != '') {
                    var pstrCadena = "BuscaClienteVIP.jsp?strSQL=sp_BuscaClienteVIP";
                    pstrCadena = pstrCadena + "&Nombre=" + document.all.NuestroUsuario.value;
                    window.open(pstrCadena, 'newVIP', 'scrollbars=yes,status=yes,width=640,height=300');
                    }
                }
//------------------------------------------------------------------------------                
            /*Busca un cliente vip por clave,Para la opcion de la búsqueda por la lupita sin datos de
             * nuestro usuario en el input @returns {undefined}  */
            function fnBuscaClienteVIPPorClave(DNI,Placas) {                
                var datos = {dni: DNI, placas: Placas};
                $.when(
                     $.ajax({
                             type: "GET",
                             url: "./BuscarClienteVipPorClave.jsp",
                             async:false,
                             data: datos,
                             dataType: 'json',
                             success: function(responseData, status, xhr) {
                             var nuevaClave = responseData.Clave.toString();
                                alert('CLIENTE VIP : ' + nuevaClave);
                                if ( nuevaClave != '' ) {
                                    document.all.DescripcionOcurrido.value = document.all.DescripcionOcurrido.value + 'CLIENTE VIP : ' + nuevaClave + ' ';
                                }
                             },
                             error: function(req, status, error) {
                                if ( req.status === 500 ) {
                                   alert("Error leyendo informacion cliente vip: " + error);
                                }
                             }
                     })).then( successFunc(), failureFunc() );

            }
//------------------------------------------------------------------------------            
            /*  Test guardar información */
            function successFunc() { }
//------------------------------------------------------------------------------           
            function failureFunc() {  }
//------------------------------------------------------------------------------           
            function fnValidaPaisEF() {
                if (document.all.clPais.value == '' && document.all.CodEnt.value == '') {
                    msgVal = "Debe informar país o Provincia";
                    document.all.btnGuarda.disabled = false;
                    document.all.btnCancela.disabled = false;
                    }
                if (document.all.CodEnt.value != '' && document.all.CodMD.value == '') {
                    msgVal = "Si informa Provincia debe informar Localidad";
                    document.all.btnGuarda.disabled = false;
                    document.all.btnCancela.disabled = false;
                    }
                }
//------------------------------------------------------------------------------
            function fnSubmitOK(pclUsr, pMotivo) {
                document.all.clUsrAppAut.value = pclUsr;
                document.all.MotivoAut.value = pMotivo;
                document.all.forma.action = "../servlet/Utilerias.EjecutaAccionExp";
                document.all.forma.submit();
                }
//------------------------------------------------------------------------------
            function fnAccionesAlta() {
                document.all.clUsrApp.value =<%=session.getAttribute("clUsrApp")%>;
                top.document.all.rightPO.rows = "0,*";
                document.all.forma.action = "../servlet/Utilerias.ValidaCondNU";
                if (document.all.Action.value == 1) {
                    document.all.CodMD.value = "";
                    document.all.CodEnt.value = "";
                    document.all.clCuenta.value = "";
                    var pstrCadena = "../Utilerias/RegresaFechaActual.jsp";
                    window.open(pstrCadena, 'newWin', 'width=10,height=10,left=1500,top=2000');
                    }
                fnMuestraDivs();
                }
//------------------------------------------------------------------------------
            function fnActualizaFechaActual(pFecha) {
                document.all.FechaApertura.value = pFecha;
                document.all.FechaSiniestro.value = pFecha;
                }
//------------------------------------------------------------------------------
            function fnBuscaCuenta() {
                if (document.all.Nombre.value != '') {
                    if (document.all.Action.value == 1) {
                        var pstrCadena = "../Utilerias/FiltrosCuenta.jsp?strSQL=sp_WebBuscaCuenta ";
                        pstrCadena = pstrCadena + "&Cuenta= " + document.all.Nombre.value;
                        document.all.clCuenta.value = '';
                        window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=700,height=500');
                        }
                } else {    document.all.btnCob.style.visibility = "hidden";        }
                }
//------------------------------------------------------------------------------
            function fnBuscaClave() {
                if (document.all.Nombre.value != '') {
                    if (document.all.Action.value == 1) {
                        var pstrCadena = "../Utilerias/FiltrosClave.jsp?strSQL=sp_WebBuscaClaveGpo ";
                        pstrCadena = pstrCadena + "&Clave= " + document.all.Clave.value + "&clCuenta= " + document.all.clCuenta.value;
                        WindowClave = window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=500,height=500');
                        }
                } else {
                    if (document.all.Action.value == 1) {
                        var pstrCadena = "../Utilerias/FiltrosClave.jsp?strSQL=sp_WebBuscaClave ";
                        pstrCadena = pstrCadena + "&Clave= " + document.all.Clave.value;
                        WindowClave = window.open(pstrCadena, 'newWin2', 'scrollbars=yes,status=yes,width=500,height=500');
                        }
                    }
                }
//------------------------------------------------------------------------------
            function fnActualizaDatosClave(clCuenta, Nombre, Prefijo) {
                document.all.Nombre.value = Nombre;
                document.all.clCuenta.value = clCuenta;
                document.all.Clave.value = Prefijo;
                document.all.btnCob.style.visibility = "visible"; //Habilita boton de Coberturas
                }
//------------------------------------------------------------------------------
            function fnActualizaDatosCuenta(dsCuenta, clCuenta, clTipoVal, Msk, MskUsr, Agentes) {
                if (document.all.Action.value == 1) {////evita el bug de cambiar cuenta usando la ventana de busqueda de cuenta
                    document.all.Nombre.value = dsCuenta;
                    document.all.clCuenta.value = clCuenta;
                    document.all.ClaveMsk.value = Msk;
                    document.all.ClaveMskUsr.value = MskUsr;
                    strclTipoVal = clTipoVal;
                    document.all.btnCob.style.visibility = "visible"; //Habilita boton de Coberturas
                    fnComboCia(clCuenta,false);
                    }
                fnMuestraDivs();
                }
//------------------------------------------------------------------------------
            function fnActualizaDatosNuestroUsrDE(dsNU, Clave, pclCuenta, pNomCuenta, Compania, DatosLUP, Msk, MskUsr, DatosNUsr, ClaveBeneficiario, VIP,DNI,Placas, correo) {
                document.all.NuestroUsuario.value = dsNU;
                document.all.Clave.value = Clave;
                document.all.clCuenta.value = pclCuenta;
                document.all.Nombre.value = pNomCuenta;
                document.all.Compania.value = Compania;
                document.all.ClaveMsk.value = Msk;
                document.all.ClaveMskUsr.value = MskUsr;
                document.all.VIP.value= VIP;
                if (DatosNUsr != '') {   document.all.DescripcionOcurrido.value = document.all.DescripcionOcurrido.value + DatosNUsr;     }
                document.all.clDerechoHab.value = ClaveBeneficiario;
                document.all.btnCob.style.visibility = "visible"; //Habilita boton de Coberturas
                document.all.Email.value = correo;
                if (DatosLUP != '') {    document.all.DescripcionOcurrido.value = document.all.DescripcionOcurrido.value + DatosLUP;     }
                fnMuestraDivs();
                fnComboCia(pclCuenta,true);
                if (document.all.NuestroUsuario.value !== '') {       fnBuscaClienteVIPPorClave(DNI,Placas);         }
                }
//------------------------------------------------------------------------------
            function fnActualizaDatosNuestroUsrNrm(dsNU,Clave, pclCuenta, pNomCuenta, Msk, MskUsr, DatosNUsr, ClaveBeneficiario, pEmail, pTelefono2, pInfoBitacora){                    
                if(document.all.Action.value==1){
                    ////evita el bug de cambiar datos (clave, NU, cuenta, etc) usando la ventana de busqueda de nuestro usr 
                    document.all.NuestroUsuario.value = dsNU;
                    document.all.Clave.value = Clave;
                    document.all.clCuenta.value = pclCuenta;
                    document.all.Nombre.value = pNomCuenta;
                    document.all.ClaveMsk.value = Msk;
                    document.all.ClaveMskUsr.innerHTML = MskUsr;
                    document.all.Email.value = pEmail;
                    document.all.Telefono2.value = pTelefono2;                    
                    document.all.DescripcionOcurrido.value= document.all.DescripcionOcurrido.value + DatosNUsr;
                    document.all.clDerechoHab.value=ClaveBeneficiario;
                    }
                }
//------------------------------------------------------------------------------
            function fnValidaClave(clave) {
                if (document.all.Action.value == 1) {
                    var pstrCadena = "../Operacion/ValidaClave.jsp?strSQL=sp_ValidaClave ";
                    pstrCadena = pstrCadena + "&Clave= " + document.all.Clave.value;
                    window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=700,height=500');
                }
                }
//------------------------------------------------------------------------------
            function fnBuscaAfiliado() {
                if (document.all.Action.value == 1) {
                    var pstrCadena = "../Utilerias/FiltrosNuestroUsrDE.jsp?strSQL=sp_WebBuscaNuestroUsrnvoDE 4, ";
                    pstrCadena = pstrCadena + "&Clave= " + document.all.Clave.value + "&clCuenta= " + document.all.clCuenta.value;
                    window.open(pstrCadena, 'newWinBA', 'scrollbars=yes,status=yes,width=1200,height=500,top=200,left=50');
                    }
                }
//------------------------------------------------------------------------------
            function fnDivhide(i) {
                if (document.all) {
                    var ourhelp = eval("document.all." + i);
                    ourhelp.style.visibility = "hidden";
                    }
                }
//------------------------------------------------------------------------------
            function fnDivshow(i) {
                if (document.all) {
                    var ourhelp = eval("document.all." + i);
                    ourhelp.style.visibility = "visible";
                    }
                }
//------------------------------------------------------------------------------
            function fnVaciarFechaCita() {
                if (document.all.FechaCitaVTR.value == "1900-01-01 00:00:00") {     document.all.FechaCitaVTR.value = "";          }
                }
//------------------------------------------------------------------------------
            function acceptNum(evt) {
                // NOTE: Backspace = 8, Enter = 13, '0' = 48, '9' = 57
                var key = nav4 ? evt.which : evt.keyCode;
                return (key <= 13 || (key >= 48 && key <= 57));
                }            
//------------------------------------------------------------------------------
            function validaCorreoAntesGuardar() {
                var Cadena;
                var PosArroba;
                var usuario;
                var dominio;
                if (document.all.Email.value != '') {
                    if (document.all.Email.value.indexOf('@', 0) == -1) {
                        msgVal = msgVal + " La dirección de correo no es valida.";
                        document.all.btnGuarda.disabled = false;
                        document.all.btnCancela.disabled = false;
                    } else {
                        PosArroba = document.all.Email.value.lastIndexOf('@');
                        usuario = document.all.Email.value.substring(0, PosArroba);
                        dominio = document.all.Email.value.substring(PosArroba + 1, Cadena);
                        if (usuario == '' || dominio == '') {
                            msgVal = msgVal + " La dirección de correo no es valida.";
                            document.all.btnGuarda.disabled = false;
                            document.all.btnCancela.disabled = false;
                            }
                        //Valida el nombre de usuario y verifica que no existan dos @
                        if (usuario.indexOf('@', 0) != -1) {
                            msgVal = msgVal + " La dirección de correo no es valida.";
                            document.all.btnGuarda.disabled = false;
                            document.all.btnCancela.disabled = false;
                            }
                        //valida el dominio
                        if (dominio.indexOf('.', 0) == -1 || dominio.indexOf('@', 0) != -1) {
                            msgVal = msgVal + " La dirección de correo no es valida.";
                            document.all.btnGuarda.disabled = false;
                            document.all.btnCancela.disabled = false;
                            }
                        }
                } else {
                    if (document.all.Email.value == '') {
                        var r = confirm("¿Esta seguro que desea dejar el campo de correo en blanco?.");
                        if (r == true) {   return true;
                        } else {
                            msgVal = "Email.";
                            document.all.btnGuarda.disabled = false;
                            document.all.btnCancela.disabled = false;
                            }
                        }
                    }
                }
//------------------------------------------------------------------------------
            function validaCorreo() {
                var Cadena;
                var PosArroba;
                var usuario;
                var dominio;
                if (document.all.Email.value != '') {
                    if (document.all.Email.value.indexOf('@', 0) == -1) {   alert("La dirección de correo no es valida.");
                    } else {
                        PosArroba = document.all.Email.value.lastIndexOf('@');
                        usuario = document.all.Email.value.substring(0, PosArroba);
                        dominio = document.all.Email.value.substring(PosArroba + 1, Cadena);
                        if (usuario == '' || dominio == '') {      alert("La dirección de correo no es valida.");       }
                        //Valida el nombre de usuario y verifica que no existan dos @
                        if (usuario.indexOf('@', 0) != -1) {     alert("La dirección de correo no es valida.");      }
                        //valida el dominio
                        if (dominio.indexOf('.', 0) == -1 || dominio.indexOf('@', 0) != -1) {  alert("La dirección de correo no es valida.");    }
                        }
                    }
                }
//------------------------------------------------------------------------------
            function VerificaNumerico(Campo) {
                if (isNaN(Campo.value) == true) {
                    alert(Campo.name + ' Debe ser numérico');
                    Campo.focus();
                    }
                }
//------------------------------------------------------------------------------
            function fnMuestraCoberturas() {
                var pstrCadena = "VistaCobertura.jsp?";
                pstrCadena = pstrCadena + "&clCuenta=" + document.all.clCuenta.value;
                window.open(pstrCadena, '', 'resizable=1,menubar=0,status=0,toolbar=0,height=800,width=1030,screenX=-50,screenY=0,scrollbars=yes');
                }
//------------------------------------------------------------------------------            
            function fnMuestraExcepciones(){
                var pstrCadena = "VistaExcepciones.jsp?";
                pstrCadena = pstrCadena + "&clCuenta=" + document.all.clCuenta.value;
                window.open(pstrCadena, '', 'resizable=1,menubar=0,status=0,toolbar=0,height=600,width=838,screenX=-50,screenY=0,scrollbars=yes');
                }
//------------------------------------------------------------------------------
            function fnDivCalidad() {
                document.all.divRevCalidad.style.visibility = "hidden";
                var calidad = document.all.supervision.value;
                if (calidad == "ok") {    document.all.divRevCalidad.style.visibility = "visible";         }
                }
//------------------------------------------------------------------------------
            function fnRevisaCalidad() {
                ventana = window.open('RevisadoCalidad.jsp?clexpediente=' + document.all.clExpediente.value, 'newWin', 'scrollbars=yes,status=yes,width=700,height=500');           }
//------------------------------------------------------------------------------
            function fnValidaNU(TipoQR) {
                if (TipoQR == '15') {         document.all.Contacto.value = document.all.NuestroUsuario.value;          }
                }
//------------------------------------------------------------------------------
            function fnMuestraDivs() {
                /*MARSH*/                
                clCuenta=document.getElementById("clCuenta").value;
                if (document.all.Compania.value != '') {
                    document.all.divCiaMarsh.style.visibility = "visible";
                    document.all.divComboCia.style.visibility = "hidden";
                } else {
                    document.all.divCiaMarsh.style.visibility = "hidden";
                    document.all.divComboCia.style.visibility = "hidden";                    
                    if(clCuenta == ''){
                        document.all.divComboCia.style.visibility = "hidden";
                    }else{
                        if((clCuenta == '1320' || clCuenta == '1324' || clCuenta == '1388' || clCuenta == '1389' || clCuenta == '1392'|| clCuenta == '1410' || clCuenta == '1677')){
                            document.all.divComboCia.style.visibility = "visible";      }
                        }
                    }
                /*Boton Busqueda Mercantil*/
                if (clCuenta == '1694' || clCuenta == '1695' || clCuenta == '1696' || clCuenta == '1738' || clCuenta == '1707') {
                    document.all.divBtnMercantil.style.visibility = "visible";                }
                else {            }                
                /*1351 HDI CRI*/
                if (clCuenta == '1351' || clCuenta == '1390' || clCuenta == '1404' || clCuenta == '1405' || clCuenta == '1406') {
                    document.all.divNoSiniestro.style.visibility = "visible";
                } else {              document.all.divNoSiniestro.style.visibility = "hidden";       }
                }
//------------------------------------------------------------------------------
            function fnComboCia(pclCuenta,flag){
                var strConsulta = "st_CodigoCia '"+pclCuenta+"'";
                var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=clCodigoCompaniaC";
                fnOptionxDefault('clCodigoCompaniaC',pstrCadena);
                if ((pclCuenta == '1320' || pclCuenta == '1324' || pclCuenta == '1388' || pclCuenta == '1389' || pclCuenta == '1392'|| pclCuenta == '1410')&& !flag) {
                    document.all.divComboCia.style.visibility = "visible";
                    document.all.divCiaMarsh.style.visibility = "hidden";
                    //desaparacer el campo
                } else {
                    document.all.divComboCia.style.visibility = "hidden";
                    document.all.divCiaMarsh.style.visibility = "visible";
                    }
                }    
//------------------------------------------------------------------------------
            function fnActualizaBinALS(Banco, Otorgar, Mensaje, ICABin, ICACode, ICACountry, ICALegalName, ICARegion, ICAState, ParentICACode, BenTod, WarmTransfer, ExisteBin, ProdTod, prod, ProductName) {
                if (Banco != "0") {     document.all.NombreBanco.value = Banco;             }                
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
                document.all.WSALS.value = '1';
                document.all.prod.value = prod;
                document.all.ProductName.value = ProductName;
                /* ************************Fin de Mastercard Concierge********************/
                if (this.readOnly == false) {
                    if (fnValMask(this, document.all.ClaveMsk.value, this.name)) {      fnBuscaClave();    }
                    }
                if (Otorgar == 0) {                    
                    WindowClave.close();
                    var owd = dhtmlwindow.open("alert", "inline", Mensaje.replace(/<27>/gi, "'"), "Mensaje", "width=500px,height=450px,resize=1,scrolling=1,center=1", "recal");
                    ConfirmacionBins.style.left = "10%";
                    ConfirmacionBins.style.top = "100px";
                    /*
                     #C0C0C0     Gris    Platinum
                     #000000     Negro   Black
                     */
                    if (ProductName == 'Platinum MasterCard') {   T_AlertaMsg.style.backgroundColor = "#C0C0C0";   }
                    if (ProductName == 'MasterCard Black') {                        
                        T_AlertaMsg.style.backgroundColor = "#000000";
                        T_AlertaMsg.style.Color = "#FFFFFF";
                    }
                } else {                    
                    document.all.ConfirmacionBins.style.visibility = "hidden";
                    ConfirmacionBins.style.left = "800px";
                    ConfirmacionBins.style.top = "300px";
                    }
                }
//------------------------------------------------------------------------------                
        </script>
        <%
            exp = null;
            daoexp = null;
            rsSMS1.close();
            rsSMS1 = null;
            StrclExpediente = null;
            strclUsr = null;
            strclEstatus = null;
            StrclPaginaWeb = null;
            clCuenta = null;
            Clave = null;
            CodEnt = null;
            dsEntFed = null;
            dsMunDel = null;
            StrCodMD = null;
            StrPermiteEnvioCobro = null;
            strclUsrAppAut = null;
            supervision = null;
            strAlertaApp = null;
            strLatitud = null;
            strLongitud = null;
            StrRevisadoCalidad = null;
            StrdsPais = null;
        %>
    </body>
</html>