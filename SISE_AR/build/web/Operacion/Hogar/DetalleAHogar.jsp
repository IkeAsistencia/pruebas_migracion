
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.asistencias.DAOAsistenciaHogar,com.ike.asistencias.to.DetalleAsistenciaHogar,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
    <head>
        <title>Detalle Asistencia Hogar</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
        <!--link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@3/dark.css"--><!-- Swal, Alertas personalizadas, SOLO FUNCIONA CON CHROME, CAMBIAR CUANDO SE MIGRE A ÉL POR COMPLETO JOA-->
    </head>
    <!--body class="cssBody" onload="fnValidaOption()" --><!-- original joa -->
    <body class="cssBody" onload="fnValidaOption()" >
        
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAuto.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>
        <script type="text/javascript" src="../../Geolocalizacion/modernizr-custom.js"></script>
        <script type="text/javascript" src="../../Geolocalizacion/js/jquery.js"></script>
        <script type="text/javascript" src="../../Geolocalizacion/js/mapUtils.js"></script>
        <script type="text/javascript" src='../../Utilerias/UtilCalendario.js'></script>
        <!--script src="https://cdn.jsdelivr.net/npm/sweetalert2@9/dist/sweetalert2.min.js"></script--><!-- Swal, Alertas personalizadas, SOLO FUNCIONA CON CHROME, CAMBIAR CUANDO SE MIGRE A ÉL POR COMPLETO JOA-->
        <%
            String StrclUsrApp = "0";
            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();        }
          if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %>LA SESION EXPIRO<%
                return;
                }
            String StrclExpediente = "";
            String StrclPaginaWeb = "162";
            //  DATOS DE LA UBICACION ORIGEN, VIENEN DEL EXPEDIENTE EN SESION
            String StrdsEntFed = "";
            String StrCodEnt = "";
            String StrdsMunDel = "";
            String StrCodMD = "";
            String StrCalleNum = "";
            String StrclCuenta = "0";
            String StrClave = "";
            String StrclServicio = "";
            String StrdsSubServicio = "";
            String StrLimiteMonto = "";
            String StrclSubServicio = "0";
            String fechaProgramado = "";
            String StrSubServ = "";
            String provisorio = "";
            String strNuestroUsuario = "";
            boolean esHDICri = false;
            String StrContacto = "";
            String horaCita    = "";  
            String StrOtroTipoContactante = "";
            String StrOtraUbica = "";   //JOA
            String StrOtroMotivoSiniestro = "";
            String StrOtroTipoCristal = "";
            String StrCambioCalle= "";
            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();            }
            if (session.getAttribute("clCuenta") != null) {
                StrclCuenta = session.getAttribute("clCuenta").toString();            }
            if (session.getAttribute("Clave") != null) {
                StrClave = session.getAttribute("Clave").toString();            }
            if (session.getAttribute("clServicio") != null) {
            StrclServicio = session.getAttribute("clServicio").toString();            }
            if (session.getAttribute("clSubServicio") != null) {
                StrSubServ = session.getAttribute("clSubServicio").toString();            }
            if (session.getAttribute("dsSubServicio") != null) {
                StrdsSubServicio = session.getAttribute("dsSubServicio").toString();            }
            ResultSet cdr = UtileriasBDF.rsSQLNP( "sp_DetalleExpediente " + StrclExpediente );
            if (cdr.next()) {
                StrCodEnt   = cdr.getString("CodEnt");
                StrdsEntFed = cdr.getString("dsEntFed");
                StrCodMD    = cdr.getString("CodMD");
                StrdsMunDel = cdr.getString("dsMunDel");
                strNuestroUsuario = cdr.getString("NuestroUsuario");
                StrContacto = cdr.getString("Contacto");
            }else {
                out.println("ERROR NO SE PUEDE OBTENER DATOS DEL EXPEDIENTE");
                return;
                }
            StringBuffer StrSql = new StringBuffer();
            StringBuffer StrSql2 = new StringBuffer();
            StringBuffer StrSql3 = new StringBuffer();
            DAOAsistenciaHogar daoAH = null;
            DetalleAsistenciaHogar AH = null;
            StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            if (rs.next()) {
                daoAH = new DAOAsistenciaHogar();
                AH = daoAH.getDetalleAsistenciaHogar(StrclExpediente);
                fechaProgramado = (AH != null?String.valueOf(AH.getFechaSiniestro()) :"");
                provisorio      = (AH != null?String.valueOf(AH.getNecesitaProvisorio()) :"");
                horaCita        = (AH != null?String.valueOf(AH.getHoraCita()) :"");
                StrOtroTipoContactante = (AH != null?String.valueOf(AH.getOtroTipoContactante()) :"");
                StrOtraUbica = (AH != null?String.valueOf(AH.getStrOtraUbica()) :"");   //JOA
                StrOtroMotivoSiniestro = (AH != null?String.valueOf(AH.getOtroMotivoSiniestro()) :"");
                StrOtroTipoCristal     = (AH != null?String.valueOf(AH.getOtroTipoCristal()) :"");

            } else {
                %> El expediente no existe <%
                rs.close();
                rs = null;
                return;
            }
            //Para Cobertura
            StrSql2.append(" st_getDatosCobertura ").append(StrclCuenta).append(",'").append(StrdsSubServicio).append("'");
            ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql2.toString());
            StrSql2.delete(0, StrSql2.length());
            if (rs2.next()) {
                StrLimiteMonto = rs2.getString("LimiteMonto");
                StrclSubServicio = rs2.getString("clSubservicio");
                if ( StrclSubServicio.equalsIgnoreCase("494") ) {
                    /*SI es Hdi, es cambpo obligatorio*/
                    esHDICri = true;
                }   
            } else{
                rs2.close();
                rs2 = null;
            }   

            StrSql = new StringBuffer();
            StrSql.append(" st_getDatosAfiliadoGral '").append(StrClave).append("','").append(StrclCuenta).append("'");
            ResultSet rsDatosAfil = UtileriasBDF.rsSQLNP(StrSql.toString());
            if (rsDatosAfil.next()) {
                StrCalleNum = rsDatosAfil.getString("calleNum");     
             //System.out.println("jomu dato StrCalleNum    "+StrCalleNum);

            }else{
            System.out.println("No hay datos de Domicilio en Base");
                }

            /*Lectura de datos para la opcion de     alta hdi cri     */
            String strCobertura = "";
            String strCoberturaFinanciera= "";
            String strPoliza = "";
            if ( AH == null ) {
                StrSql3.append("st_getCoberturaAfiliadoCRI '").append(StrClave).append("'");
                ResultSet rs3 = UtileriasBDF.rsSQLNP(StrSql3.toString());
                StrSql3.delete(0, StrSql3.length());
                if (rs3.next()) {
                    strCobertura = rs3.getString("Cobertura");
                    strCoberturaFinanciera = rs3.getString("CoberturaFinanciera");
                    strPoliza = rs3.getString("Poliza");
                    } 
                rs3.close();
                rs3 = null;
                }
            /*Continuo con el proceso normal*/
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            int iRowPxOri = 80;
            int iRowPx = 0;
        %>
        <script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(162, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "fnAccionesAlta();","fnAccionesCambio();", "fnAccionesGuardado();")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleAHogar.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='InfoFinal' name='InfoFinal' type='hidden' value='<%=AH!=null?AH.getInformeF():"0"%>'>
        <input id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubServicio%>'>
        <input id='dsSubservicio' name='dsSubservicio' type='hidden' value='<%=StrdsSubServicio%>'>
        <input id='subServicio' name="subServicio" type='hidden' value="<%=StrSubServ%>" >
        
        
        
        <!-- GEOLOC TARGET LOCAL-->
        <% String sTmpDirA = new String( StrdsEntFed + ", " + StrdsMunDel + ", " + (AH != null ? AH.getCalle(): "") );   %>  
        <% Boolean esSubServicioModificado = StrclServicio.equals("3")  && (StrdsSubServicio.equals("Plomería") || StrdsSubServicio.equals("Cerrajería") || StrdsSubServicio.equals("Electricidad") || StrdsSubServicio.equals("Gas")  || StrdsSubServicio.equals("Vidriería")); %>
        <% if ( !esHDICri ) { %>
            <div id="divNoHDICri"  style="visibility: 'visible'">
                <%  iRowPx = iRowPxOri; %>
                <input type="hidden" name="calle" id="DireccionA" value="<%=sTmpDirA%>" >
                <div class='VTable' style='position:absolute; z-index:20; left:510px; top:<%=iRowPx+16%>px; '>
                    <input id="MapaOrig" name="MapaOrig" type='button' VALUE='Mapa' onClick='openMap("DireccionA", "LatLong","Calle","dsMunDel","dsEntFed","CodMD","CodEnt");return false;' class='cBtn'/>
                </div>
                <%=MyUtil.ObjInput("Provincia", "dsEntFed", StrdsEntFed, false, false, 30, iRowPx, StrdsEntFed, false, false, 45)%>
                <%=MyUtil.ObjInput("Localidad", "dsMunDel", StrdsMunDel, false, false, 280, iRowPx, StrdsEntFed, false, false, 45)%>
                <input type="hidden" id="CodMD" name="CodMD" value="<%=StrCodMD%>">
                <input type="hidden" id="CodEnt" name="CodEnt" value="<%=StrCodEnt%>">
                <%  iRowPx = iRowPx + 30;      %>
                <%=MyUtil.ObjInput("Calle", "Calle",AH != null ? AH.getCalle() : "", true, true, 30, iRowPx, StrCalleNum, false, false, 58)%>
                <%=MyUtil.ObjInput("Latitud y Longitud", "LatLong", AH != null ? AH.getLatLong(): "", true, true, 330, iRowPx, "", false, false, 34)%>
                <% if (esSubServicioModificado) {%>
                <%  iRowPx = iRowPx + 30;   %>
                <%=MyUtil.ObjInput("Piso", "Piso", AH != null ? AH.getPiso() : "", true, true, 30, iRowPx, "", false, false, 3)%>
                    <%=MyUtil.ObjInput("Departamento", "Departamento", AH != null ? AH.getDepartamento(): "", true, true, 330, iRowPx, "", false, false, 8)%>
                    <% } %>
                <%  iRowPx = iRowPx + 30;   %>
                <%=MyUtil.ObjTextArea("Referencias Visuales", "Referencias", AH != null ? AH.getReferencias() : "", "75", "5", true, true, 30, iRowPx, "", false, false)%>
                <%=MyUtil.DoBlock("Domicilio", 80, 40)%>

                <%iRowPx = iRowPx + 130;    %>
                
                <% if (esSubServicioModificado) { %>
                    <%=MyUtil.ObjComboC("Ubicación de falla", "clUbFallaH", AH != null ? AH.getDsUbFallaH() : "", true, true, 30, iRowPx, "", "st_getUbicacionFallaHogar ".concat(StrclServicio).concat(", ").concat(StrdsSubServicio), "fnOtraUbicacion();", "", 50, true, true)%>
                    <%=MyUtil.ObjTextArea("Describa la falla", "DescripcionOtro", AH != null ? AH.getDescripcionOtro() : "", "50", "5", true, true, 230, iRowPx, "", true, false)%>
                    <%  iRowPx = iRowPx + 30;    %>
                    <div id="otraUbicacionContainer" style="visibility: hidden">
                        <%=MyUtil.ObjInput("Especifique ubicación", "UbicacionOtro", AH != null ? AH.getUbicacionOtro() : "", true, true, 30, iRowPx, "", false, false, 25)%>                                             
                    </div>
                    <%=MyUtil.DoBlock("Detalle de " + StrdsSubServicio, 100, 20)%>
                <% } else { %>
                    <%=MyUtil.ObjComboC("Ubicacion de falla", "clUbFallaH", AH != null ? AH.getDsUbFallaH() : "", true, true, 30, iRowPx, "", "st_getUbicacionF ", "", "", 50, true, true)%>
                    <%=MyUtil.ObjComboC("Tipo de falla", "clTipoFallaH", AH != null ? AH.getDsTipoFallaH(): "", true, true, 230, iRowPx, "", " st_getTipoFalla ", "", "", 50, true, true)%>
                    <%=MyUtil.DoBlock("Detalle de " + StrdsSubServicio, 100, 20)%>
                <% } %>
                
                <%  iRowPx = iRowPx + 110;    %>
                
                <%=MyUtil.ObjTextArea("Observaciones Informe", "ObsInfo", AH != null ? AH.getObsInfo(): "", "50", "5", true, true, 30, iRowPx, "", false,false)%>
                <%=MyUtil.ObjInput("Cobertura", "Cobertura", AH != null ? AH.getCobertura(): "", false, false, 350, iRowPx, StrLimiteMonto, false, false, 20)%>
                <%=MyUtil.ObjInput("Fuera de Zona:", "FueraZona", AH != null ? AH.getFueraZona(): "", true, true, 500, iRowPx, "", false, false, 20)%>
                <%    iRowPx = iRowPx + 30;   %>
                <%=MyUtil.ObjInput("Costo:", "Costo", AH != null ? AH.getCosto() : "", true, true, 350, iRowPx, "", false, false, 20)%>
                <%=MyUtil.ObjInput("Visita / Verificación:", "VisitasVer", AH != null ? AH.getVisitasVer(): "", true, true, 500, iRowPx, "", false,false, 20)%>
                <%  iRowPx = iRowPx + 30;    %>
                <%=MyUtil.ObjChkBox("Informe Final", "InformeF", AH != null ? AH.getInformeF(): "", true, true, 150, iRowPx+10, "0", "fnAlertaInfoFinal()")%>
                <%=MyUtil.ObjComboC("Garantia", "clGarantiaHogar", AH != null ? AH.getDsGarantiaHogar() : "", true, true, 300, iRowPx, "", "SELECT clGarantiaHogar, dsGarantiaHogar FROM cGarantiaHogar", "", "", 50, false, false)%>
                <%=MyUtil.ObjInput("Gestión / Movida / Fijo:", "GestionF", AH != null ? AH.getGestionF(): "", true, true, 500, iRowPx, "", false, false, 20)%>
                <%=MyUtil.DoBlock("Informe", 0,0)%>
                <%=MyUtil.GeneraScripts()%>
            </div>
        <%} else {%>
            <div  id="divSiHDICri"  style="visibility: 'visible' ">
                
                <% iRowPx = iRowPxOri; %>
                <%=MyUtil.ObjInput("NU", "NuestroUsuarioH", strNuestroUsuario, false, false, 10, iRowPx, strNuestroUsuario, false, false, 30)%>
                <%=MyUtil.ObjInput("Cobertura $", "Cobertura", (AH != null && AH.getCobertura() != null && AH.getCobertura() != "0") ? AH.getCobertura(): strCobertura, false, false, 210, iRowPx, strCobertura, false, false, 20,"")%>
                <%=MyUtil.ObjInput("Cobertura Financiera", "CoberturaFin", AH != null ? AH.getCoberturaFin(): strCoberturaFinanciera, false, false, 350, iRowPx, strCoberturaFinanciera, false, false, 30)%>
                <%=MyUtil.ObjInput("Poliza", "Poliza", AH != null ? AH.getPoliza() : strPoliza, false, false, 560, iRowPx, strPoliza, false, false, 20)%>
                <%  iRowPx = iRowPx+48;    %>
                <%=MyUtil.ObjInput("Nombre y apellido de la persona que se comunica", "QuienSeComunica", AH != null ? AH.getQuienSeComunica(): StrContacto, true, true, 10, iRowPx, "", esHDICri, esHDICri, 90)%>
                <%=MyUtil.ObjComboC("Cargo", "clTipoContactante", AH != null ? AH.getDsTipoContactante() : "", true, true, 550, iRowPx, "", "sp_GetTipoContactanteH", "fnCambioContactante();", "", 50, esHDICri, esHDICri)%>
                <%  iRowPx = iRowPx+48;   %>
                <%=MyUtil.ObjInput("Domicilio del siniestro", "Calle",AH != null ? AH.getCalle() : StrCalleNum, true, true, 10, iRowPx, "", esHDICri, esHDICri, 90)%>
                
                <input type="hidden" id="CambioCalle" name="CambioCalle" value="0">
                
                <div id="divOtroTipoContactante"  style="visibility: 'visible'">
                   <%=MyUtil.ObjInput("Otro Cargo", "OtroTipoContactante", AH != null ? AH.getOtroTipoContactante(): StrOtroTipoContactante, true, true, 550, iRowPx, "", esHDICri, esHDICri, 30)%>
                </div>                
                <%  iRowPx = iRowPx+48;   %>
                <input id="FechaProgMomAux" name="FechaProgMomAux" value="FechaProgMom" type="hidden"/>       
                <input name='FechaProgMomMsk' id='FechaProgMomMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F'/>
                <%=MyUtil.ObjInputFNAC("Fecha del Siniestro (AAAA-MM-DD)", "fechaSiniestro", fechaProgramado, true, true, 30, iRowPx, "", esHDICri, esHDICri, 15, 2, "fnValidaFechaActual(this);")%>
                <!--%=MyUtil.ObjInput("Hora Cita (HH:MM)", "horaCita", horaCita, true, true, 260, iRowPx, "", esHDICri, esHDICri, 5,"fnHrsD(this);")%-->
                <%  iRowPx = iRowPx + 58;  %>
                
                <%=MyUtil.ObjComboC("Ubicacion del siniestro", "clUbFallaH", AH != null ? AH.getDsUbFallaH() : "", true, true, 30, iRowPx, "", "st_getUbicacionSiniestroH", "fnCambioUbicacion();", "", 50, esHDICri, esHDICri)%>
                <div id="divOtroTipoLugar"  style="visibility: 'hidden'">
                    <%=MyUtil.ObjComboC("Ubicacion del vidrio", "clUbFallaHLugar", AH != null ? AH.getDsUbFallaHLugar(): " ", true, true, 230, iRowPx, "", "st_getUbicacionMontajeH", "", "", 50, esHDICri, esHDICri)%>
                </div>
                
                <div id="divOtraUbic"  style="visibility: 'hidden'">
                   <%=MyUtil.ObjInput("Otra Ubicacion", "StrOtraUbica", AH != null ? AH.getStrOtraUbica(): StrOtraUbica, true, true, 430, iRowPx, "", esHDICri, esHDICri, 50)%>
                </div>
                

                <% iRowPx = iRowPx + 48;   %>
                <%=MyUtil.ObjComboC("Tipo de cristal", "clTipoCristalH", AH != null ? AH.getDsTipoCristalH() : "", true, true, 30, iRowPx, "", "st_getTipoCristalH", "fnCambioTipoCristal();", "", 50, esHDICri, esHDICri)%>
                <%=MyUtil.ObjComboC("Estado del vidrio", "clTipoFallaH", AH != null ? AH.getDsTipoFallaH() : "", true, true, 230, iRowPx, "", "st_getEstadoVidrioH", "", "", 50, esHDICri, esHDICri)%>
                <%  iRowPx = iRowPx + 48;   %>
                <div id="divOtroTipoCristal"  style="visibility: 'visible'">
                   <%=MyUtil.ObjInput("Otro tipo Cristal", "OtroTipoCristal", AH != null ? AH.getOtroTipoCristal(): StrOtroTipoCristal, true, true, 30, iRowPx, "", esHDICri, esHDICri, 30)%>
                </div>
                <%iRowPx = iRowPx + 48;%>
                <%=MyUtil.ObjComboC("¿Cómo ocurrió el siniestro?", "clMotivoSiniestroH", AH != null ? AH.getDsMotivoSiniestroH(): "", true, true, 30, iRowPx, "", "st_getMotivoSiniestroH", "fnCambioMotivoSiniestro();", "", 50, esHDICri, esHDICri)%>
                <div id="divProvisorio" class='VTable' style='position:absolute; z-index:100; left:230px; top:<%= iRowPx%>px; ' >
                    <p style="display: inline; text-align: left; width:auto; ">¿Necesita provisorio?&nbsp;&nbsp;</p>
                    <input class='VTable' id="necesita" type="radio"  name="chkNecesita" value="1"  onclick="document.all.NecesitaProvisorio.value=this.value;">SI
                    <input class='VTable' id="noNecesita" type="radio"  name="chkNecesita" value="0"  onclick="document.all.NecesitaProvisorio.value=this.value;">NO
                    <input type="hidden" name="NecesitaProvisorio" id="NecesitaProvisorio" value="<%=provisorio%>" >
                </div>   
                <%iRowPx = iRowPx + 48;%>    
                <div id="divOtroMotivoSiniestro"  style="visibility: 'visible'">
                    <%=MyUtil.ObjInput("Otro motivo siniestro", "OtroMotivoSiniestro", AH != null ? AH.getOtroMotivoSiniestro(): StrOtroMotivoSiniestro, true, true, 30, iRowPx, "", esHDICri, esHDICri, 30)%>
                </div>
                <%=MyUtil.DoBlock("Detalle de Vidrieria", 0,0)%>
                <%=MyUtil.GeneraScripts()%>
            </div>
        <%  }        
        rs.close();
        rs = null;
        daoAH = null;
        AH = null;
        %>
        <input name='FechaProgMomMsk' id='FechaProgMomMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>

        <script type="text/javascript" >
            
            /* 
             * SE COMPILAN LOS DATOS NECESARIOS PARA MOSTRAR EN LA BITÁCORA
            SE CONECTA Y ENVÍA ESTO SDATOS A    url: "./InsertInfoAdicionalKM0.jsp",
            EN ESTA JSP SE HACE LA CONEXIÓN AL SP   st_InsertInfoAdicionalKM0 Y LO IMPORTANTE ES QUE AFECTA A LA TABLA 
            "Seguimiento ", QUE ES LA TABLA DE LA QUE SE ALIMENTA EL BitacoraExpediente.jsp
    
            */
            
//------------------------------------------------------------------------------
           $(document).ready(function() {
                $("#btnCambio").click(function() {    document.getElementById("DireccionA").disabled = false;      });
                $("#btnAlta").click(function() {   document.getElementById("DireccionA").disabled = false;        });
                $("#CalleNum").change(function() {     document.getElementById("LatLong").value = "";         });
                $("#DescripcionOtro").css("resize", "none");
		fnOtraUbicacion();
                });
//------------------------------------------------------------------------------
            /*Cambio contactante, control otro*/
            if (document.all.subServicio.value.toString() === '494') document.all.divOtroTipoContactante.style.visibility = 'hidden';
            function fnCambioContactante(){
                var comboboxTipoContactante  = document.getElementById("clTipoContactanteC");
                var tipoContactante = comboboxTipoContactante.options[comboboxTipoContactante.selectedIndex].text;
                if ( tipoContactante.toString().toUpperCase() === 'OTRO' ) {
                    document.all.divOtroTipoContactante.style.visibility = 'visible';
                    document.all.OtroTipoContactante.value = '';
                } else {
                    document.all.divOtroTipoContactante.style.visibility = 'hidden';
                    document.all.OtroTipoContactante.value = ' ';
                }               
            }
            
            //------------------------------------------------------------------------------
            /*Cambio UBICACION SINESTRO JOA*/
            if (document.all.subServicio.value.toString() === '494'){
                document.all.divOtroTipoLugar.style.visibility = 'hidden';
                document.all.divOtraUbic.style.visibility = 'hidden';
            } // Combo OTRA UBICACION escondido en ALTA
            function fnCambioUbicacion(){
                    var UbiSin = document.getElementById("clUbFallaHC").value;
                    var elementHF= document.getElementById("clUbFallaHLugarC");  // Valor catual del subcombo
                    var elementOU= document.getElementById("StrOtraUbica");      // Valor catual del TEXT INPUT
                    if ( UbiSin=== '22' || UbiSin=== '25' || UbiSin=== '26' || UbiSin=== '27'  ){
                    document.all.divOtroTipoLugar.style.visibility = 'visible';
                    document.all.divOtraUbic.style.visibility = 'hidden';
                    elementHF.disabled = false; //CAMBIA A MODO HABILITADO PARA EDICIÓN
                    elementHF.value = '31'; // ELIGE UN  VALOR POR DEFECTO 
                    elementOU.disabled = false;
                    elementOU.value = 'Vidriera'; // AÑADE UN VALOR POR DEFECTO PARA EL TEXT INPUT
                } else if( UbiSin === '1032'  ){ // OTRO
                    document.all.divOtraUbic.style.visibility = 'visible';
                    document.all.divOtroTipoLugar.style.visibility = 'hidden';
                    elementOU.disabled = false;
                    elementOU.value = ' ';
                    elementHF.disabled = true;
                    elementHF.value = '31';
                } else {
                    document.all.divOtroTipoLugar.style.visibility = 'hidden';
                    document.all.divOtraUbic.style.visibility = 'hidden';
                    elementHF.disabled = true; 
                    elementHF.value = '31';
                    elementOU.disabled = true;
                    elementOU.value = '31';
                }               
            }
            
//------------------------------------------------------------------------------            
            function fnCambioTipoCristal() {
                var comboboxTipoCristal  = document.getElementById("clTipoCristalHC");
                var tipoCristal = comboboxTipoCristal.options[comboboxTipoCristal.selectedIndex].text;
                if ( tipoCristal.toString().toUpperCase() === 'OTRO' ) {
                    document.all.divOtroTipoCristal.style.visibility = 'visible';
                    document.all.OtroTipoCristal.value = '';
                } else {
                    document.all.divOtroTipoCristal.style.visibility = 'hidden';
                    document.all.OtroTipoCristal.value = ' ';
                }                    
            }
//------------------------------------------------------------------------------
            function fnCambioMotivoSiniestro() {
                var comboboxMotivoSiniestro  = document.getElementById("clMotivoSiniestroHC");
                var motivoSiniestro = comboboxMotivoSiniestro.options[comboboxMotivoSiniestro.selectedIndex].text;
                if ( motivoSiniestro.toString().toUpperCase() === 'OTRO' ) {
                    document.all.divOtroMotivoSiniestro.style.visibility = 'visible';
                    document.all.OtroMotivoSiniestro.value = '';
                    
                } else {
                    document.all.divOtroMotivoSiniestro.style.visibility = 'hidden';
                    document.all.OtroMotivoSiniestro.value = ' ';
                }                 
            }
//------------------------------------------------------------------------------
            /*Verifico carga del checkbox*/
            function fnValidaCheckbox() {              
               if ( document.all.subServicio.value.toString() === '494' ) {
                    var necesita =document.all.NecesitaProvisorio.value===null?'':document.all.NecesitaProvisorio.value;
                    if ( necesita.toString() === '' ) {
                        msgVal = msgVal + " Falta opción Necesita provisorio";       }
                    }
                }
//------------------------------------------------------------------------------
            /*Funiciones para validar front end*/
            function fnValidaOption() {
                var joaco = document.all.NecesitaProvisorio.value.toString() ;
                if ( document.all.subServicio.value.toString() === '494' ) {
                    if ( document.all.NecesitaProvisorio.value !== '1' || document.all.NecesitaProvisorio.value !== '2' ) {
                        document.all.NecesitaProvisorio.value = '2' //Valor por defecto (NoNecesita) JOA
                        document.all.necesita.checked  = false;
                        document.all.noNecesita.checked  = true;
                        document.all.necesita.disabled = false; //comentado JOA PREGUNTAR SI QUEDA ASI 
                       document.all.noNecesita.disabled = false;  //comentado JOA PREGUNTAR SI QUEDA ASI 
                    } if ( document.all.NecesitaProvisorio.value === '1' ) {
                        document.all.necesita.checked  = true;
                        document.all.noNecesita.checked= false; 
                    }
                    else if ( document.all.NecesitaProvisorio.value === '2' ) {
                        document.all.necesita.checked  = false;
                        document.all.noNecesita.checked= true;
                    }
               //     document.all.necesita.disabled = true; //comentado JOA PREGUNTAR SI QUEDA ASI 
               //     document.all.noNecesita.disabled = true;  //comentado JOA PREGUNTAR SI QUEDA ASI 
                
                    
                    //SUBCOMBO UBICACION SINIESTRO 
                    var comboboxTipoCristal  = document.getElementById("clTipoCristalHC");
                    var tipoCristal = comboboxTipoCristal.options[comboboxTipoCristal.selectedIndex].text;
                    if ( tipoCristal.toString().toUpperCase() === 'OTRO' ) {
                        document.all.divOtroTipoCristal.style.visibility = 'visible';
                    } else {
                        document.all.divOtroTipoCristal.style.visibility = 'hidden';
                    }
                     
                    var comboboxMotivoSiniestro  = document.getElementById("clMotivoSiniestroHC");
                    var motivoSiniestro = comboboxMotivoSiniestro.options[comboboxMotivoSiniestro.selectedIndex].text;
                    if ( motivoSiniestro.toString().toUpperCase() === 'OTRO' ) {
                        document.all.divOtroMotivoSiniestro.style.visibility = 'visible';
                    } else {
                        document.all.divOtroMotivoSiniestro.style.visibility = 'hidden';
                    }             
                } else {
                    //document.all.divNoHDICri.style.visibility = 'visible';
                    //document.all.divSiHDICri.style.visibility = 'hidden';
                    document.all.QuienSeComunica.value = ' ';
                    document.all.clTipoContactante.value = 0;
                    //document.all.CalleH.value = ' '
                    //document.all.clUbFallaHCRI.value = 0;
                    document.all.clTipoCristalH.value = 0;
                    //document.all.clTipoFallaHCRI.value = 0;
                    document.all.clMotivoSiniestroH.value = 0;
                    document.all.OtroMotivoSiniestro.value = ' ';
                    document.all.OtroTipoCristal.value = ' ';
                    document.all.OtroTipoContactante.value = ' ';
                    document.all.divOtraUbic.value = ' ';   //JOA
                }
            }
//------------------------------------------------------------------------------            
            /*Ingreso de fecha programada*/
            function fnValidaFechaActual(campo){  
                var anio =  parseInt(campo.value.substring(0),10);
                var nva_fecha = new Date();
                var anio_mas_uno = parseInt(nva_fecha.getFullYear()) + 1;
                var FechaC1 = document.getElementById("fechaSiniestro").value;
                var FechaC = FechaC1.substring(0, 10); 
                campo.value=FechaC;
            }       
//------------------------------------------------------------------------------            
            /*Valido fecha*/
            function fnHrsD(campo){
                var StrHoraDL=(document.getElementById("HoraD").value.length);                
                    if(StrHoraDL <= 2){                   
                        var StrHoraDV=(document.getElementById("HoraD").value);
                        var min=":00";
                        var res = StrHoraDV.concat(min);
                        campo.value=res;
                }
                validaHora(campo);
            }
//------------------------------------------------------------------------------            
            /*Valida hora*/
             function validaHora(campo){
                var patt =/^\d{2}:\d{2}/g
                if(!patt.test(campo.value)){
                    campo.value="";
                    alert("Formato 24 Hrs (hh:mm)");
                }else{
                    var agr=campo.value.split(":");
                    if(parseInt(agr[0])>24||parseInt(agr[1])>59){
                        campo.value="";
                        alert("Formato 24 Hrs (hh:mm)");
                    }
                }
            }
//------------------------------------------------------------------------------            
            /*Valida minutos*/
            function devolverMinutos(horaMinutos){
                var horass=((horaMinutos.split(":")[0])*60);
                var minutoss=(horaMinutos.split(":")[1]);               
                var sumHM= (1*horass+ minutoss*1);              
                return sumHM;
            }     
//------------------------------------------------------------------------------
            function isValidDate(d) {          return d instanceof Date && !isNaN(d);            }
//------------------------------------------------------------------------------
            /*Continuo con el resto de las funciones*/
            function setupClickListener(id) {
              var button = document.getElementById(id);
              button.addEventListener('click', function() {     fillInAddress();    });
            }
//------------------------------------------------------------------------------
            function openMap(campo, latLong, calle, localidad, provincia,codMD, codEnt) {
                direccion = document.getElementById(campo).value;
                geo = window.open('../../Geolocalizacion/gmap3.jsp?dire='+ direccion +'&dDir=' + campo + '&dLatLon=' + latLong
                + '&fCalle=' + calle + "&fLoc=" + localidad + "&fPro=" + provincia + "&fCodMD=" + codMD + "&fCodEnt=" + codEnt, 'GEO',
                'modal=yes,resizable=yes,menubar=0,status=0,toolbar=0,height=820,width=1200,screenX=1,screenY=1');
                geo.focus();
            }
//------------------------------------------------------------------------------    
            function fnBuscaGeo() {
                var pstrCadena = "/SISE_AR/Geolocalizacion/showMap.jsp";
                window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=900,height=800');
            }
//------------------------------------------------------------------------------            
            function fnAlertaInfoFinal(){               
                if (document.getElementById("InformeF").value === 1) {
                   if ( confirm('¿Este es el informe final?') ) {        return 1;
                   } else {  return 0;  }
                }else {   return 0;  }
            }
//------------------------------------------------------------------------------            
            function fnAccionesAlta() {   //JOA
                var clServicio = <%=StrclServicio%>;
                var dsSubServicio = '<%=StrdsSubServicio%>';
                if (clServicio === 3) {
                    switch (dsSubServicio) {
                        case 'Electricidad':
                            alert("Recuerde indicarle al usuario verificar que es un problema del domicilio y no del barrio/edificio.");
                            break;
                        case 'Vidriería': 
                            alert("Recuerde consultar si el vidrio se partió o esta rajado. \n ¿Corre riesgo la seguridad del domicilio?");
                            break;
                        case 'Gas':
                            alert("Recuerde que por su seguridad el ente regulador nos obliga a notificar en el caso de que usted decida no realizar el arreglo o no se permita anular la fuga del equipo.");
                            break;
                        default:
                    }
                }
                if ( document.all.subServicio.value.toString() === '494' &&
                        (document.getElementById("Action").value === 2 || 
                        document.getElementById("Action").value === 1)) {
                    document.all.necesita.disabled = false;
                    document.all.noNecesita.disabled = false;
                }
               if ( document.all.subServicio.value.toString() === '494' ) { 
                   if ( document.getElementById("Action").value === 2 || 
                        document.getElementById("Action").value === 1) {
                    document.all.necesita.disabled = false;
                    document.all.noNecesita.disabled = false;
                    }
                    document.all.QuienSeComunica.value = '<%=StrContacto%>';
                    document.all.Calle.value = '<%=StrCalleNum%>'; 
                        $("#Calle").change(function(){
                            alert('Recuerda avisar NU que si se modifica la dirección registrada en base, debemos pedir autorización al seguro antes de coordinar servicio.');
                            //SWAL SOLO FUNCIONA CON CHROME, CAMBIAR CUANDO SE MIGRE A ÉL POR COMPLETO
                            //Swal.fire(
                                //'Advertencia',
                                //'Recuerda avisar NU que si se modifica la dirección registrada en base, debemos pedir autorización al seguro antes de coordinar servicio.',
                               //)
                           document.all.CambioCalle.value = '1';  // Informo que la dirección fue cambiada
                        });
                }
            }
//------------------------------------------------------------------------------            
            function fnAccionesCambio() {  
                if ( document.all.subServicio.value.toString() === '494' ) {
                    document.all.necesita.disabled = false;
                    document.all.noNecesita.disabled = false;
                } else {
                    if (document.getElementById("Action").value === 2 &&  document.getElementById("InfoFinal").value === 1) { 
                        document.getElementById("ObsInfo").disabled=true;
                        document.getElementById("Cobertura").disabled=true;
                        document.getElementById("Costo").disabled=true;
                        document.getElementById("FueraZona").disabled=true;
                        document.getElementById("VisitasVer").disabled=true;
                        document.getElementById("GestionF").disabled=true;
                        document.getElementById("InformeFC").disabled=true;
                        document.getElementById("clGarantiaHogarC").disabled=true;
                    }
                }
            }
            //============================INICIO DE FUNCIONES DE WALTER=====================
            function fnEsPlantillaModificada () {
                var dsSubServicio = '<%=StrdsSubServicio%>';
                var arraySubServicios = ["Plomería", "Cerrajería", "Electricidad", "Gas", "Vidriería"];
                return jQuery.inArray(dsSubServicio, arraySubServicios) >= 0;
            }
            function fnOtraUbicacion() {
                var combobox  = document.getElementById("clUbFallaHC");
                var lugarOU = combobox.options[combobox.selectedIndex].text;
                if (lugarOU.toString().toUpperCase() === "OTRO") {
                    document.getElementById("otraUbicacionContainer").style.visibility = "visible";
                    document.getElementById("UbicacionOtro").disabled = false;        
                }
                else {
                    document.getElementById("UbicacionOtro").disabled = true;
                    document.getElementById("otraUbicacionContainer").style.visibility = "hidden";
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
                    msgVal = msgVal + ' El campo departamento debe tener como máximo 8 caracteres.';
                }
                return esDeptoValido;
            }
//------------------------------------------------------------------------------
            function fnGuardaSeguimiento() {
                var selectLugar = $("#clUbFallaHC").children(":selected").text();
                var lugar = selectLugar === 'OTRO'? $("#UbicacionOtro").val() : selectLugar;
                var descProblema = $("#DescripcionOtro").val(); 
                var detalleExp = 'Ubicación: ' + lugar + '; Problema: ' + descProblema;
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
            function fnEsDescripcionValida() {
                var descValida = $("#DescripcionOtro").val().length > 9;
                if (!descValida) {
                    msgVal = msgVal + ' El campo departamento debe tener como mínimo 10 caracteres.';
                }
                return descValida;
            }
//------------------------------------------------------------------------------
            function fnAccionesGuardado() {
                fnValidaCheckbox();
                if (fnEsPlantillaModificada()){
                    if (!fnEsPisoValido() || !fnEsDepartamentoValido() || !fnEsDescripcionValida()) {
                        document.all.btnGuarda.disabled= false;
                        document.all.btnCancela.disabled= false;
                        return;
                    }                   
                    fnGuardaSeguimiento();
                }
            }
//=====================FIN DE FUNCIONES DE WALTER===============================
        //poliza
        var salida_1 = document.all.Poliza.value ;
        if (  salida_1  === 'null'  || salida_1 === '' ){
           salida_1 = '--';
        }else{
        }        
        //nuestro usuario
        var salida_2 = document.all.NuestroUsuarioH.value ;
        if (  salida_2  === 'null'  || salida_2 === '' ){
           salida_2 = '--';
        }else{
        }
        //QuienSeComunica
        var salida_3 = document.all.QuienSeComunica.value ;
        if (  salida_3  === 'null'  || salida_3 === '' ){
           salida_3 = '--';
        }else{
        }                                
//------------------------------------------------------------------------------                              
        // INFO ADICIONAL QUE SE GUARDA EN Expedientes y Seguimiento                     
        const botonGDR = document.querySelector("#btnGuarda");
        // Agregar listener
        botonGDR.addEventListener("click", function(evento){	
            // Aquí todo el código que se ejecuta cuando se dá click al botón GUARDAR solo si es por subservicio VIDRIERIA CRI
            if ( document.all.subServicio.value.toString() === '494' ) { 
                var clUsrApp   = <%=Integer.parseInt(StrclUsrApp)%>;
                var Expediente = <%=StrclExpediente%>;                
                var Cober      =(document.all.Cobertura.value ===null || document.all.Cobertura.value ==='')?0:document.all.Cobertura.value;
                var CobFin     =(document.all.CoberturaFin.value ===null || document.all.CoberturaFin.value ==='')?0:document.all.CoberturaFin.value;
                var detExp = "\'[* Cobertura: " + Cober +" - Cobertura Financiera:"+CobFin;                
                var cargo = clTipoContactanteC.options[clTipoContactanteC.selectedIndex].text;
                if ( cargo === 'Otro'){
                    var otroCarg =(document.all.OtroTipoContactante.value ===null || document.all.OtroTipoContactante.value ==='')?0:document.all.OtroTipoContactante.value;
                    detExp = detExp.concat(' - QUIEN REPORTA : ' +otroCarg);
                }else{
                    detExp = detExp.concat(' - QUIEN REPORTA  : ' +cargo);
                     }
                var siniestr = clUbFallaHC.options[clUbFallaHC.selectedIndex].text;
                    if ( siniestr.toString().toUpperCase() === 'HALL DE ENTRADA' || siniestr.toString().toUpperCase() === 'HABITACION' || siniestr.toString().toUpperCase() === 'TERRAZA' || siniestr.toString().toUpperCase() === 'BALCON'){
                        var soport = clUbFallaHLugarC.options[clUbFallaHLugarC.selectedIndex].text;
                        detExp = detExp.concat(' - UBICACION_SINIESTRO : ' +siniestr+ '/'+soport);
                        var elementHF= document.getElementById("clUbFallaHLugarC");
                        elementHF.disabled = false;
                        elementHF.value = '';
                    }else if ( siniestr.toString().toUpperCase() === 'OTRO'){   //JOA
                        var otraUbi =(document.all.OtraUbic.value ===null || document.all.OtraUbic.value ==='')?0:document.all.OtraUbic.value;
                        detExp = detExp.concat(' - UBICACION_SINIESTRO : ' +otraUbi);
                    }else{
                        detExp = detExp.concat(' - UBICACION_SINIESTRO : ' +siniestr);
                        document.all.divOtroTipoLugar.style.visibility = 'hidden';
                        var elementHF= document.getElementById("clUbFallaHLugarC");
                        elementHF.disabled = true; 
                        elementHF.value = '31';
                    }
                var tipo = clTipoCristalHC.options[clTipoCristalHC.selectedIndex].text;
                if ( tipo === 'Otro'){
                    var otrotip =(document.all.OtroTipoCristal.value ===null || document.all.OtroTipoCristal.value ==='')?0:document.all.OtroTipoCristal.value;
                    detExp = detExp.concat(' - TIPO_CRISTAL : ' +otrotip);
                }else{
                    detExp = detExp.concat(' - TIPO_CRISTAL : ' +tipo);
                    }
                var estado = clTipoFallaHC.options[clTipoFallaHC.selectedIndex].text;
                detExp = detExp.concat(' - ESTADO_del_VIDRIO : ' +estado);
                var motiv = clMotivoSiniestroHC.options[clMotivoSiniestroHC.selectedIndex].text;
                if ( motiv === 'Otro'){
                    var otro =(document.all.OtroMotivoSiniestro.value ===null || document.all.OtroMotivoSiniestro.value ==='')?0:document.all.OtroMotivoSiniestro.value;
                    detExp = detExp.concat(' - MOTIVO : ' +otro);
                }else{
                    detExp = detExp.concat(' - MOTIVO : ' +motiv);
                     }
                if (document.getElementById('necesita').checked){
                    detExp = detExp.concat(" - NECESITA_PROVISORIO : SI *]\'");
                }else{
                    detExp = detExp.concat(" - NECESITA_PROVISORIO : NO *]\'");
                     } 
            var elementCalle= document.getElementById("CambioCalle");       
            var datosCRI ={
                clUsrApp : clUsrApp,
                Expediente : Expediente,
                detExp : detExp  }; //ORIGINAL JOA FUNCIONA
//-----------------------------------------------------------------------------------------------------------    
                $.when(
		$.ajax({
			type: "POST",
			url: "./InsertInfAddCRI.jsp",
                        async:false,
			data: datosCRI,
			dataType: 'json',                        
			error: function(req, status, error) {				
				if ( req.status === 413 ) {
					alert("Largo de "+error+" inválido.");				}
				if ( req.status === 403 ) {
					alert("Código de "+error+" inválido.Debe verificar el dato ingresado.");				}
				if ( req.status === 500 ) {	}
                            }
                        }));
                    }  //FIN IF 
                });  // FIN addEventListener
//------------------------------------------------------------------------------ 
        </script>
  
    </body>
</html>