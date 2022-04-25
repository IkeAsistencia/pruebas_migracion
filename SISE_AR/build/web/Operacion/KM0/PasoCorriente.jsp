<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.asistencias.DAOAsistenciaVial,com.ike.asistencias.to.AsistenciaVial,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<%@ page import="ar.com.ike.geo.Geolocalizacion,com.ike.asistencias.to.InfoAdicionalKM0" %>
<html>
    <head>
        <title>Paso de Corriente</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src="../../Geolocalizacion/modernizr-custom.js"></script>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAuto.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilCalendario.js'></script>
        <script type="text/javascript" src="../../Geolocalizacion/js/jquery.js"></script>
        <script type="text/javascript" src="../../Geolocalizacion/js/mapUtils.js"></script>
        <!-- BIBLIOTECAS AJAX -->
        <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>            
        <%
            String StrclUsrApp = "0";
            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();     }
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %>Fuera de Horario<%
                return;
                }
            String StrclExpediente = "";
            String StrclPaginaWeb = "198";
            String StrSubServ = "";
            String StrclInfoAdicKMO = "0";
            
            //  DATOS DE LA UBICACION ORIGEN, VIENEN DEL EXPEDIENTE EN SESION
            String StrclPais = "";
            String StrdsPais = "";
            String StrdsEntFed = "";
            String StrCodEnt = "";
            String StrdsMunDel = "";
            String StrCodMD = "";
            String StrclMarcaAuto = "";
            String StrclCuenta = "0";
            String StrClave = "";
            //  DATOS DEL AFILIADO
            String StrCalleNum = "";
            String StrModelo = "";
            String StrColor = "";
            String StrPlacas = "";
            String StrDescAuto = "";
            String StrdsSubServicio = "";

            // DATOS ADICIONALES
		String clUbicacionAuto="";
		String clUbicacionAutoGaraje="";
		String aNivelAbierto="";
                String lugarEncajado="";
		String nivelSubsuelo="";
		String clTipoFalla="";
		String detalleFalla="";
		String automatico="";
		String ruedaBloqueada="";
		String cantBloqueadas="";
		String tieneCarga="";
		String clCantPersona="";
		String cedulaVerdeVig="";
		String clModifAuto="0";
		String distanciaPiso="0";
		String largo="0";
		String alto="0";
		String detalleModif="";
		String ruedasDuales="";
                String dsUbicacionAuto = ""; 
                String dsUbicacionAutoGaraje = "";
                String tieneModif = "";
                String lucesEncienden    = "";
                String ruedaAuxEnCond    = "";
                String tuercaSeguridad   = "";
                String llaveTuercaSeg    = "";
                String clTipoGasolina    = "";
                String clCantLitros      = "";
                String servicioProgramado= "";
                String estadoVehiculo    = "";
                String distTierraFirme   = "";
                String compraBateria     = "";
                String fechaProgramado   = "";
                String horaDesdeProg     = "";
                String horaHastaProg     = "";
                String peajesCubiertos   = "";
                String montoCubierto     = "";
   
            int iRowPx = 0;
            int iRowPxOri = 0;

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }
            if (session.getAttribute("clPais") != null) {
                StrclPais = session.getAttribute("clPais").toString();
            }
            if (session.getAttribute("dsPais") != null) {
                StrdsPais = session.getAttribute("dsPais").toString();
            }
            ResultSet cdr = UtileriasBDF.rsSQLNP( "sp_DetalleExpediente " + StrclExpediente );
            if (cdr.next()) {
                StrCodEnt   = cdr.getString("CodEnt");
                StrdsEntFed = cdr.getString("dsEntFed");
                StrCodMD    = cdr.getString("CodMD");
                StrdsMunDel = cdr.getString("dsMunDel");
                //Se obtienen desde la base y no desde session. verificar:
                StrclCuenta = cdr.getString("clCuenta");
                StrClave = cdr.getString("Clave");
                //Se usa como String aunque sea un INT
                StrSubServ = cdr.getString("clSubServicio");
                StrdsSubServicio = cdr.getString("dsSubServicio");
                cdr.close();
                cdr = null;
            }
            else {
                out.println("ERROR NO SE PUEDE OBTENER DATOS DEL EXPEDIENTE");
                return;
            }

            if (session.getAttribute("dsSubServicio") != null) {
                StrdsSubServicio = session.getAttribute("dsSubServicio").toString();
            }

            StringBuffer StrSql = new StringBuffer();
            DAOAsistenciaVial daoAV = null;
            AsistenciaVial AV = null;
            InfoAdicionalKM0 infoAdicAV = null;

            StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            if (rs.next()) {
                daoAV = new DAOAsistenciaVial();
                AV = daoAV.getAsistenciaVial(StrclExpediente);
                StrclMarcaAuto = AV != null ? AV.getClMarca() : "";
                /** Si tiene información adicional,
                 realizo la lectura
                */
                if ( AV != null && AV.getClInfoAdicKMO() > 0 ) {
                    StrclInfoAdicKMO = String.valueOf(AV.getClInfoAdicKMO());
                    infoAdicAV = daoAV.getInfoAdicAsistenciaVial( String.valueOf( AV.getClInfoAdicKMO() ) );
                } else {       StrclInfoAdicKMO = "0";              }

            } else {
                %> El expediente no existe <%
                rs.close();
                rs = null;
                return;
            }
            /**Seteo valores de tabla asociada*/
             clUbicacionAuto = (infoAdicAV != null?String.valueOf(infoAdicAV.getClUbicacionAuto()) :"");
             clUbicacionAutoGaraje = (infoAdicAV != null?String.valueOf(infoAdicAV.getClUbicacionAutoGaraje()) :"");
             aNivelAbierto = (infoAdicAV != null?String.valueOf(infoAdicAV.getaNivelAbierto()) :"");
             nivelSubsuelo = (infoAdicAV != null?String.valueOf(infoAdicAV.getNivelSubsuelo()) :"");
             lugarEncajado = (infoAdicAV != null?String.valueOf(infoAdicAV.getLugarEncajado()) :"");

             clTipoFalla = (infoAdicAV != null?String.valueOf(infoAdicAV.getClTipoFalla()) :"");
             detalleFalla = (infoAdicAV != null?infoAdicAV.getDetalleFalla() :"");
             automatico = (infoAdicAV != null?String.valueOf(infoAdicAV.getAutomatico()) :"");
             ruedaBloqueada = (infoAdicAV != null?String.valueOf(infoAdicAV.getRuedaBloqueada()) :"");
             cantBloqueadas = (infoAdicAV != null?String.valueOf(infoAdicAV.getCantBloqueadas()) :"");
             ruedasDuales = (infoAdicAV != null?String.valueOf(infoAdicAV.getRuedasDuales()) :"");
             dsUbicacionAuto = (infoAdicAV != null?infoAdicAV.getDsUbicacionAuto() :"");
             dsUbicacionAutoGaraje = (infoAdicAV != null?infoAdicAV.getDsUbicacionAutoGaraje():"");
             tieneModif = "0";
            servicioProgramado = (infoAdicAV != null?String.valueOf(infoAdicAV.getServicioProgramado()) :"");
            fechaProgramado    = (infoAdicAV != null?String.valueOf(infoAdicAV.getFechaProgramado()) :"");
            horaDesdeProg      = (infoAdicAV != null?String.valueOf(infoAdicAV.getHoraDesdeProg()) :"");
            horaHastaProg      = (infoAdicAV != null?String.valueOf(infoAdicAV.getHoraHastaProg()) :"");
            estadoVehiculo    = (infoAdicAV != null?String.valueOf(infoAdicAV.getEstadoVehiculo() ) :"");
            lucesEncienden    = (infoAdicAV != null?String.valueOf(infoAdicAV.getLucesEncienden() ) :"");
            compraBateria     = (infoAdicAV != null?String.valueOf(infoAdicAV.getCompraBateria()  ):"");
            ruedaAuxEnCond    = (infoAdicAV != null?String.valueOf(infoAdicAV.getRuedaAuxEnCond() ) :"");
            tuercaSeguridad   = (infoAdicAV != null?String.valueOf(infoAdicAV.getTuercaSeguridad() ) :"");
            llaveTuercaSeg    = (infoAdicAV != null?String.valueOf(infoAdicAV.getLlaveTuercaSeg() ) :"");
            distTierraFirme   = (infoAdicAV != null?String.valueOf(infoAdicAV.getDistTierraFirme() ) :"");

            StrSql.append(" st_getDatosAfiliado '").append(StrClave).append("','").append(StrclCuenta).append("'");
            ResultSet rsDatosAfil = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            if (rsDatosAfil.next()) {
                StrCalleNum = rsDatosAfil.getString("callenum");
                StrModelo = rsDatosAfil.getString("anio");
                StrColor = rsDatosAfil.getString("color");
                StrPlacas = rsDatosAfil.getString("placas");
                StrDescAuto = rsDatosAfil.getString("descauto");
            }
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <script type="text/javascript">fnOpenLinks()</script>
        <%
            MyUtil.InicializaParametrosC(198, Integer.parseInt(StrclUsrApp));
            int blnAlta = 0;
            int blnBaja = 1;
            int blnCambio = 2;
            int blnConsulta = 3;
            int blnEdicion = 4;  
            StringBuilder strMenu = new StringBuilder();
            
            if (MyUtil.blnAccess[blnEdicion] == true) {
                strMenu.append("<form action=\"")
                        .append("../../servlet/Utilerias.EjecutaAccionAsist")
                        .append("\" method=\"post\" target=\"WinSave\" id=\"forma\" name=\"forma\">")
                        .append("<input type=\"hidden\" id=\"Action\" name=\"Action\"></input>")
                        .append(" <input ");

                if (MyUtil.blnAccess[blnAlta] == false) {
                    strMenu.append(" disabled=true ");
                }

                strMenu.append(" type=\"button\" id=\"btnAlta\" value=\"Alta\" onClick=\"this.disabled=true;document.all.Action.value=1;document.all.btnGuarda.disabled=false;document.all.btnCancela.disabled=false;document.all.btnCambio.disabled=true;document.all.btnElimina.disabled=true;fnHabilitaA();");
                strMenu.append("fnValLugar();fnHabilitar();");
                strMenu.append("\" ></input><input");

                if (MyUtil.blnAccess[blnCambio] == false) {
                    strMenu.append(" disabled=true ");
                }

                strMenu.append(" type=\"button\" id=\"btnCambio\" value=\"Cambio\" onClick=\"this.disabled=true;document.all.Action.value=2;document.all.btnGuarda.disabled=false;document.all.btnCancela.disabled=false;document.all.btnAlta.disabled=true;document.all.btnElimina.disabled=true;fnHabilitaC();");
                strMenu.append("fnValLugar();fnHabilitar();");
                strMenu.append("\" ></input><input");


                if (MyUtil.blnAccess[blnBaja] == false) {
                    strMenu.append(" disabled=true ");
                }

                strMenu.append(" type=\"button\" id=\"btnElimina\" value=\"Eliminar\" onClick=\"this.disabled=true;document.all.Action.value=3;document.all.btnGuarda.disabled=false;document.all.btnCancela.disabled=false;document.all.btnAlta.disabled=true;document.all.btnCambio.disabled=true;\" ></input>");
                strMenu.append("  <input disabled=true type=\"button\" id=\"btnGuarda\" value=\"Guardar\" onClick=\"");
                strMenu.append("this.disabled=true;document.all.btnCancela.disabled=true;document.all.btnAlta.disabled=true;document.all.btnCambio.disabled=true;document.all.btnElimina.disabled=true;");
                strMenu.append("fnGuardarInfoAdicional();");

                strMenu.append("if(msgVal !==\'\'){");
                strMenu.append("alert(\'Falta informar: \' + msgVal)}\" ></input>");
                strMenu.append("  <input disabled=true type=\"button\" id=\"btnCancela\" value=\"Cancelar\" onClick=\"this.disabled=true;document.all.btnGuarda.disabled=true;");

                if (MyUtil.blnAccess[blnAlta] == true) {
                    strMenu.append(" document.all.btnAlta.disabled=false;");
                }
                if (MyUtil.blnAccess[blnCambio] == true) {
                    strMenu.append(" document.all.btnCambio.disabled=false;");
                }
                if (MyUtil.blnAccess[blnBaja] == true) {
                    strMenu.append(" document.all.btnElimina.disabled=false;");
                }

                strMenu.append(" location.reload();\"></input>");
            }   
            
            out.println(strMenu.toString());
        %>

        <%
            //MyUtil.doMenuAct("", "fnValLugar();fnHabilitar();", "fnValLugar();fnHabilitar();","fnGuardarInfoAdicional();" )
        %>
        <input id="btnCob" name="btnCob" class='cBtn' type='button' value='Cobertura' onClick="fnMuestraCoberturas();">
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="PasoCorriente.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <input id='dsSubservicio' name='dsSubservicio' type='hidden' value='<%=StrdsSubServicio%>'><%-- AGREGADO JOMU    --%>
        <input id='clInfoAdicKMO' name='clInfoAdicKMO' type='hidden' value='<%=StrclInfoAdicKMO%>'><%-- AGREGADO JOMU    --%>
     
         <% iRowPx = 80; int coordYImagen = 0; int coordXImagen = 590;%>
        <%=MyUtil.ObjComboMem("Pais", "clPais", StrdsPais, StrclPais, cbPais.GeneraHTML(20, StrdsPais), false, false, 30, iRowPx, StrclPais, "fnLlenaEntidadAjaxFn(this.value);", "", 16, false, false)%>

        <!-- GEOLOC TARGET LOCAL-->
        <%
        String sTmpDirA = new String( StrdsEntFed + ", " + StrdsMunDel + ", " + (AV != null ? AV.getCalleO(): "") );
        %>
        <!-- %=MyUtil.ObjInput("Direccion", "DireccionA", sTmpDirA ,  true, true, 30,110, "", true, true, 80 )% -->
        <input type="hidden" name="DireccionA" id="DireccionA" value="<%=sTmpDirA%>" >
        <input type="hidden" name="subServicio" id="subServicio" value="<%=StrSubServ%>" >
        <div class='VTable' style='position:absolute; z-index:20; left:450px; top:128px; '>
            <INPUT  id="MapaOrig" type='button' VALUE='Mapa' onClick='openMap("DireccionA", "LatLong","CalleNum","dsMunDel","dsEntFed","CodMDOrigen","CodEntOrigen");return false;' class='cBtn'>
        </div>
        <%
        iRowPx = iRowPx + 30; 
        %>
        <%=MyUtil.ObjInput("Provincia", "dsEntFed", StrdsEntFed, true, true, 30, iRowPx, StrdsEntFed, false, false, 40)%>
        <%=MyUtil.ObjInput("Localidad", "dsMunDel", StrdsMunDel, true, true, 240, iRowPx, StrdsMunDel, false, false, 35)%>
        <input type="hidden" id="CodMDOrigen" name="CodMDOrigen" value="<%=StrCodMD%>">
        <input type="hidden" id="CodEntOrigen" name="CodEntOrigen" value="<%=StrCodEnt%>">
        <%
        iRowPx = iRowPx + 30; 
        %>
        <%=MyUtil.ObjInput("Calle", "CalleNum",AV != null ? AV.getCalleO() : "", true, true, 30, iRowPx, "", false, false, 58)%>
        <%=MyUtil.ObjInput("Latitud y Longitud", "LatLong", AV != null ? AV.getGeoLatLong(): "", true, true, 320, iRowPx, "", false, false, 24)%>
        <%
        String tmpCalleOri = (AV!=null?AV.getCalleO():"");
        iRowPx = iRowPx + 30; 
        %>      
        <input type="hidden" id="localidadOrigen" name="localidadOrigen" value="<%=StrdsMunDel%>">
        <input type="hidden" id="calleOrigen" name="calleOrigen" value="<%=tmpCalleOri%>">
        
        <%=MyUtil.ObjTextArea("Referencias Visuales", "Referencias", AV != null ? AV.getReferenciasO() : "", "75", "5", true, true, 30, iRowPx, StrDescAuto, false, false)%>
        <%=MyUtil.DoBlock("Ubicación del Evento", -10, 40)%>

        <%
        iRowPx = iRowPx + 130; 
        %>
        <%=MyUtil.ObjComboC("Marca de Auto", "CodigoMarca", AV != null ? AV.getDsMarca() : "", true, true, 30, iRowPx, "", " Select CodigoMarca, dsMarcaAuto from cMarcaAuto order by dsMarcaAuto", "fnLlenaTipoAutoAjax(this.value,'ClaveAMIS','Tipo de Auto','TipoAutoDiv','',2);", "", 50, true, false)%>
        <%=MyUtil.ObjComboCDiv("Tipo de Auto", "ClaveAMIS", AV != null ? AV.getDsTipoAuto() : "", true, true, 195, iRowPx, "", " Select ClaveAMIS, dsTipoAuto from cTipoAuto where CodigoMarca = '" + StrclMarcaAuto + "' order by dsTipoAuto", "", "", 50, true, false, "TipoAutoDiv")%>
        <%
        iRowPx = iRowPx + 38; 
        %>        
        <%=MyUtil.ObjInput("Modelo", "Modelo", AV != null ? AV.getModelo() : "", true, true, 30, iRowPx, StrModelo, true, true, 6, "if(this.readOnly==false){fnValidaModelo(this)}")%>
        <%=MyUtil.ObjInput("Color", "Color", AV != null ? AV.getColor() : "", true, true, 90, iRowPx, StrColor, true, true, 10)%>
        <%=MyUtil.ObjInput("Patente", "Placas", AV != null ? AV.getPatente() : "", true, true, 170, iRowPx, StrPlacas, true, true, 8)%>
        <%--=MyUtil.ObjComboC("Lugar", "clLugarEvento", AV != null ? AV.getDsLugar() : "", true, true, 250, iRowPx, "", "select clLugarEvento, dsLugarEvento from cLugarEvento order by dsLugarEvento", "", "", 20, true, true)--%>
        <%=MyUtil.ObjComboC("Lugar", "clLugarEvento", AV != null ? AV.getDsLugar() : "", false, false, 250, iRowPx, "","st_LugarEvento", "", "", 20, false, false)%>
        <%--<%=MyUtil.DoBlock("Detalle Paso de Corriente", -20, -10)%>--ORIGINAL--%>
        <%
        iRowPxOri = iRowPx + 58;
        %>



    <div id="divExtraccion" style="visibility: 'hidden'"> 
        <%
        iRowPx = iRowPxOri;
        %>
        <%=MyUtil.ObjComboC("¿Dónde se encuentra el vehículo?", "clUbicacionAuto", infoAdicAV != null ? infoAdicAV.getDsUbicacionAuto() : "", true, true, 35, iRowPx , "", "st_ListaUbicAutoArrastre 0", "fnCambiaUbicacion(this.value);", "", 50, false, false)%>
        <div id="divGaraje" style="visibility: 'hidden'">
            <%=MyUtil.ObjComboC("Garage", "clUbicacionAutoGaraje", infoAdicAV != null ? infoAdicAV.getDsUbicacionAutoGaraje() : "", true, true, 280, iRowPx , "", "st_ListaUbicAutoArrastre 1", "fnSeteaUbicacion(this.value);", "", 50, false, false)%>
            <div id="divSubsuelo" style="visibility: 'hidden'">
                <%=MyUtil.ObjComboC("Subsuelo", "nivelSubsuelo", infoAdicAV != null ? String.valueOf(infoAdicAV.getNivelSubsuelo()) : "", true, true, 450, iRowPx , "", "st_constNivelSubsuelo", "fnSeteaNivel(this.value);", "", 50, false, false)%>
            </div>
            
            <div id="divANivel" style="visibility: 'hidden'">
                <%=MyUtil.ObjComboC("A nivel", "aNivelAbierto", infoAdicAV != null ? (infoAdicAV.getaNivelAbierto()==0?"ABIERTO":"CERRADO") : "", true, true, 450, iRowPx , "", "st_constANivelEstado", "fnAbiertoCerrado(this.value);", "", 50, false, false)%>
            </div>
        </div>
            
        <div id="divEncajado" style="visibility: 'hidden'">
            <%=MyUtil.ObjComboC("Encajado", "lugarEncajado", infoAdicAV != null ? (infoAdicAV.getLugarEncajado()==0?"BARRO":"ARENA") : "", true, true, 280, iRowPx , "", "st_constLugarEncajado", "", "", 50, false, false)%>
            <%=MyUtil.ObjInput("Dist. a piso firme (metros)", "distTierraFirme", distTierraFirme, true, true, 450, iRowPx, "", false, false, 3,"")%>

        </div>
        <%
        iRowPx = iRowPx + 38;
        %>
        <div id="divEstadoVh"  style="visibility: 'hidden'">
            <%=MyUtil.ObjInput("Estado del VH", "estadoVehiculo", estadoVehiculo, true, true, 280, iRowPx, "", false, false, 50,"")%>
        </div>
        <%
        iRowPx = iRowPx + 48;
        %>

       
        <div id="divAutomatico" class='VTable' style='position:absolute; z-index:100; left:35px; top:<%= iRowPx%>px; ' >
            <p style="display: inline; text-align: left; width:auto; ">¿EL vehículo es automático?&nbsp;&nbsp;</p>
            <input class='VTable' id="esAutomatico" type="radio"  name="chkAutomatico" value="1"  onclick="fnValorRadioAutoManual();document.all.automatico.value=this.value;">SI
            <input class='VTable' id="esManual"     type="radio"  name="chkAutomatico" value="0"  onclick="fnValorRadioAutoManual();document.all.automatico.value=this.value;">NO
            <input type="hidden" name="automatico" id="automatico" value="<%=automatico%>" >
        </div> 

        <div id="divTipoFalla" style="visibility: 'hidden'">    

        </div>
        <div id="divRuedaBloqueada" class='VTable' style='position:absolute; z-index:100; left:283px; top:<%= iRowPx %>px; ' >
            <p style="display: inline; text-align: left; width:auto; ">¿Hay una rueda bloqueada?&nbsp;&nbsp;</p>
            <input class='VTable' id="estaBloqueada"   type="radio"  name="chkBloqueada" value="1"  onclick="fnValorRadioBloqueada(this.value);document.all.ruedaBloqueada.value=this.value;">SI
            <input class='VTable' id="noEstaBloqueada" type="radio"  name="chkBloqueada" value="0"  onclick="fnValorRadioBloqueada(this.value);document.all.ruedaBloqueada.value=this.value;">NO
            <input class='VTable' id="todasBloqueadas" type="radio"  name="chkBloqueada" value="1"  onclick="fnValorRadioBloqueada(this.value);fnRuedaBloqueadaTodas();document.all.ruedaBloqueada.value=this.value;">TODAS
            <input type="hidden" name="ruedaBloqueada" id="ruedaBloqueada" value="<%=ruedaBloqueada%>" >
        </div> 
        
        <div id="divRuedasBloqueadas" style="visibility: 'hidden'">     
            <%
                coordYImagen = iRowPx+5;
                coordXImagen = 545+45;
                %>
            <a id="carImage" name="ruedasBloqueadas" style="position: absolute; z-index: 555; left: <%= coordXImagen-40 %>px; top: <%= coordYImagen+30 %>px;">
                <img src="../../Imagenes/ruedasBloqueadas.png" width='140' height='80' alt="Ruedas Bloqueadas">
            </a>
            <%=MyUtil.ObjChkBox("DI", "delanteraIzq", infoAdicAV != null ? String.valueOf(infoAdicAV.getDelanteraIzq()) : "", true, true,coordXImagen+10-20 , coordYImagen, "",  "fnRuedaBloqueada();")%>
            <%=MyUtil.ObjChkBox("TI", "traseraIzq", infoAdicAV != null ? String.valueOf(infoAdicAV.getTraseraIzq()) : "", true, true,coordXImagen+80-20  , coordYImagen, "",  "fnRuedaBloqueada();")%>
            <%=MyUtil.ObjChkBox("DD", "delanteraDer", infoAdicAV != null ? String.valueOf(infoAdicAV.getDelanteraDer()) : "", true, true, coordXImagen+10-20, coordYImagen+110, "",  "fnRuedaBloqueada();")%>
            <%=MyUtil.ObjChkBox("TD", "traseraDer", infoAdicAV != null ? String.valueOf(infoAdicAV.getTraseraDer()) : "", true, true,coordXImagen+80-20  , coordYImagen+110, "",  "fnRuedaBloqueada();")%>

        </div>

        <%
        iRowPx = iRowPx + 48;
        %>
        <div id="divRuedasDuales" class='VTable' style='position:absolute; z-index:100; left:35px; top:<%= iRowPx %>px; ' >
            <p style="display: inline; text-align: left; width:auto; ">¿Tiene ruedas duales?&nbsp;&nbsp;</p>
            <input class='VTable' id="tieneDuales"   type="radio"  name="chkDuales" value="1"  onclick="fnValorRadioDuales(this.value);document.all.ruedasDuales.value=this.value;">SI
            <input class='VTable' id="noTieneDuales"  type="radio"  name="chkDuales" value="0" onclick="fnValorRadioDuales(this.value);document.all.ruedasDuales.value=this.value;">NO
            <input type='hidden' name='ruedasDuales' id='ruedasDuales' value="<%=ruedasDuales%>" >
        </div> 

    </div>
        
    <div id="divUML" style="visibility: 'hidden'"> 
        <%
        iRowPx = iRowPxOri;
        %>
        <%=MyUtil.ObjComboC("¿Dónde se encuentra el vehículo?", "clUbicacionAutoUML", infoAdicAV != null ? infoAdicAV.getDsUbicacionAuto() : "", true, true, 35, iRowPx , "", "st_ListaUbicAutoMovida 0", "fnCambiaUbicacionUML(this.value);fnCartelAutopista();fnCartelRuta();", "", 50, false, false)%>
        <div id="divGarajeUML" style="visibility: 'hidden'">
            <%=MyUtil.ObjComboC("Garage", "clUbicacionAutoGarajeUML", infoAdicAV != null ? infoAdicAV.getDsUbicacionAutoGaraje() : "", true, true, 260, iRowPx , "", "st_ListaUbicAutoMovida 1", "fnSeteaUbicacionUML(this.value);", "", 50, false, false)%>
            <div id="divSubsueloUML" style="visibility: 'hidden'">
                <%=MyUtil.ObjComboC("Subsuelo", "nivelSubsueloUML", infoAdicAV != null ? String.valueOf(infoAdicAV.getNivelSubsuelo()) : "", true, true, 460, iRowPx , "", "st_constNivelSubsuelo", "fnSeteaNivelUML(this.value);", "", 50, false, false)%>
            </div>
            
            <div id="divANivelUML" style="visibility: 'hidden'">
                <%=MyUtil.ObjComboC("A nivel", "aNivelAbiertoUML", infoAdicAV != null ? (infoAdicAV.getaNivelAbierto()==0?"ABIERTO":"CERRADO") : "", true, true, 460, iRowPx , "", "st_constANivelEstado", "fnAbiertoCerradoUML(this.value);", "", 50, false, false)%>
            </div>
        </div>
        <div id="divEstacionamientoUML"  style="visibility: 'hidden'">
            <%=MyUtil.ObjComboC("Estacionamiento", "clEstacionamientoUML", (infoAdicAV != null && infoAdicAV.getClEstacionamiento() !=0 ) ? (infoAdicAV.getClEstacionamiento()==1?"PEAJE":(infoAdicAV.getClEstacionamiento()==2?"ESTACION DE SERVICIO":"SOBRE AUTOPISTA")): "", true, true, 260, iRowPx , "", "st_constEstacionamiento", "", "", 50, false, false)%>
        </div>
            
        <%
        iRowPx = iRowPx + 48;
        %>

        <%=MyUtil.ObjComboC("Qué falla tiene el vehículo", "clTipoFallaUML", infoAdicAV != null ? infoAdicAV.getDsTipoFalla() : "", true, true, 35, iRowPx , "", "st_ListaTipoFallaUml", "fnCambioFallaVehiculoUML(this.value);", "", 50, false, false)%>
                   
        <div id="divSuministroCombustible" style="visibility: 'hidden'">
            <%=MyUtil.ObjComboC("Tipo Combustible", "clTipoGasolina", infoAdicAV != null ? infoAdicAV.getDsTipoGasolina() : "", true, true, 260, iRowPx , "", "st_constTipoCombustible", "fnSeteaTipoCombus(this.value);", "", 50, false, false)%>
            <%=MyUtil.ObjComboC("Cantidad de litros", "clCantLitros", infoAdicAV != null ? String.valueOf(infoAdicAV.getClCantLitros()+4) : "", true, true, 460, iRowPx , "", "st_constCantidadLitros", "fnSeteaCantLitros(this.value);", "", 50, false, false)%>
        </div>
        
        <div id="divSinBateria" style="visibility: 'hidden'">
            <div id="divBateria" class='VTable' style='position:absolute; z-index:100; left:268px; top:<%= iRowPx%>px; ' >
                <p style="display: inline; text-align: left; width:auto; ">¿Luces encienden?&nbsp;&nbsp;</p>
                <input class='VTable' id="siEncienden" type="radio"  name="chkLuces" value="1"  onclick="document.all.lucesEncienden.value=this.value;">SI
                <input class='VTable' id="noEncienden"     type="radio"  name="chkLuces" value="0"  onclick="document.all.lucesEncienden.value=this.value;">NO
                <input type="hidden" name="lucesEncienden" id="lucesEncienden" value="<%=lucesEncienden%>" >
            </div> 
            <div id="divCompraBateria" class='VTable' style='position:absolute; z-index:100; left:268px; top:<%= iRowPx+48%>px; ' >
                <p style="display: inline; text-align: left; width:auto; ">¿Compra una batería?&nbsp;&nbsp;</p>
                <input class='VTable' id="siCompra" type="radio"  name="chkCompra" value="1"  onclick="document.all.compraBateria.value=this.value;">SI
                <input class='VTable' id="noCompra"     type="radio"  name="chkCompra" value="0"  onclick="document.all.compraBateria.value=this.value;">NO
                <input type="hidden" name="compraBateria" id="compraBateria" value="<%=compraBateria%>" >
            </div> 
        </div>
        <div id="divRuedaEnCondiciones" style="visibility: 'hidden'">
            <div id="divRueda"  class='VTable' style='position:absolute; z-index:100; left:238px; top:<%= iRowPx%>px; ' >
                <p style="display: inline; text-align: left; width:auto; ">¿Tiene rueda de auxilio en condiciones?&nbsp;&nbsp;</p>
                <input class='VTable' id="enCondiciones" type="radio"  name="chkRuedaAux" value="1"  onclick="document.all.ruedaAuxEnCond.value=this.value;fnRuedaAuxilio(this.value);">SI
                <input class='VTable' id="noEnCondiciones"     type="radio"  name="chkRuedaAux" value="0"  onclick="document.all.ruedaAuxEnCond.value=this.value;fnRuedaAuxilio(this.value);">NO
                <input type="hidden" name="ruedaAuxEnCond" id="ruedaAuxEnCond" value="<%=ruedaAuxEnCond%>" >
            </div> 
            <div id="divTuercaSeg" style="visibility: 'hidden'">
                <%
                iRowPx = iRowPx + 48;
                %>
                <div id="divTuerca"  class='VTable' style='position:absolute; z-index:100; left:238px; top:<%= iRowPx%>px; ' >
                    <p style="display: inline; text-align: left; width:auto; ">¿Tiene tuerca de seguridad?&nbsp;&nbsp;</p>
                    <input class='VTable' id="tieneTuerca" type="radio"  name="chkTuercaSeg" value="1"  onclick="fnValorTieneTuerca(this.value);document.all.tuercaSeguridad.value=this.value;">SI
                    <input class='VTable' id="noTieneTuerca"     type="radio"  name="chkTuercaSeg" value="0"  onclick="fnValorTieneTuerca(this.value);document.all.tuercaSeguridad.value=this.value;">NO
                    <input type="hidden" name="tuercaSeguridad" id="tuercaSeguridad" value="<%=tuercaSeguridad%>" >
                </div> 
            </div>
            <div id="divLlaveTuercaSeg" style="visibility: 'hidden'">
                <%
                iRowPx = iRowPx + 48;
                %>            
                <div id="divLlave"  class='VTable' style='position:absolute; z-index:100; left:238px; top:<%= iRowPx%>px; ' >
                    <p style="display: inline; text-align: left; width:auto; ">¿Tiene llave para tuerca de seguridad?&nbsp;&nbsp;</p>
                    <input class='VTable' id="tieneLlave" type="radio"  name="chkLlaveTuercaSeg" value="1"  onclick="document.all.llaveTuercaSeg.value=this.value;fnLlaveTuerca(this.value);">SI
                    <input class='VTable' id="noTieneLlave"     type="radio"  name="chkLlaveTuercaSeg" value="0"  onclick="document.all.llaveTuercaSeg.value=this.value;fnLlaveTuerca(this.value);">NO
                    <input type="hidden" name="llaveTuercaSeg" id="llaveTuercaSeg" value="<%=llaveTuercaSeg%>" >
                </div> 
            </div>
        </div>

      </div>    
                
      <div id="divServicioProgramado" style="visibility: 'visible'">
            <%
            iRowPx = iRowPx + 48;
            %>            
            <div id="divSegProg"  class='VTable' style='position:absolute; z-index:100; left:30px; top:<%= iRowPx%>px; ' >
                <p style="display: inline; text-align: left; width:auto; ">¿El servicio es programado?&nbsp;&nbsp;</p>
                <input class='VTable' id="esProgramado"   type="radio"  name="chkServProg" value="1"  onclick="document.all.servicioProgramado.value=this.value;fnServicioProgramado(this.value);">SI
                <input class='VTable' id="noEsProgramado" type="radio"  name="chkServProg" value="0"  onclick="document.all.servicioProgramado.value=this.value;fnServicioProgramado(this.value);">NO
                <input type="hidden" name="servicioProgramado" id="servicioProgramado" value="<%=servicioProgramado%>" >
            </div> 
      </div>

      <div id="divFechaProgramada" style="visibility: hidden">
                
            <%
            iRowPx = iRowPx + 48;
            %> 
            <input id="FechaProgMomAux" name="FechaProgMomAux" value="FechaProgMom" type="hidden"/>       
            <input name='FechaProgMomMsk' id='FechaProgMomMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F'/>
    
            <%=MyUtil.ObjInputFC("Fecha Cita (AAAA-MM-DD)", "Fecha", fechaProgramado, true, true, 30, iRowPx, "", false, false, 15, 2, "fnValidaFechaActual(this);")%>
            <%=MyUtil.ObjInput("Hora Desde (HH:MM)", "HoraD", horaDesdeProg, true, true, 190, iRowPx, "", false, false, 5,"fnHrsD(this);")%>
            <%=MyUtil.ObjInput("Hora Hasta (HH:MM)", "HoraH", horaHastaProg, true, true, 330, iRowPx, "", false, false, 5,"fnHrsH(this);fnHrsCita();")%>
       
      </div>


        
        <%=MyUtil.DoBlock("Detalle de " + StrdsSubServicio , -20, -10)%><%----AGREGADO - JOMU--%>
        <%=MyUtil.GeneraScripts()%>
 

        <script type="text/javascript">

            /*Configuro el resto de la pantalla*/
            var elementUG = document.getElementById("clUbicacionAutoGarajeC");
            var elementNS = document.getElementById("nivelSubsueloC");
            var elementAC = document.getElementById("aNivelAbiertoC");
            var elementLE = document.getElementById("lugarEncajadoC");
            var elementUGUML = document.getElementById("clUbicacionAutoGarajeUMLC");
            var elementNSUML = document.getElementById("nivelSubsueloUMLC");
            var elementACUML = document.getElementById("aNivelAbiertoUMLC");
            var elementESUML = document.getElementById("clEstacionamientoUMLC");

            elementUGUML.disabled = true;
            elementNSUML.disabled = true;
            elementACUML.disabled = true;
            elementESUML.disabled = true;
            
            elementUG.disabled = true;
            elementNS.disabled = true;
            elementAC.disabled = true;
            elementLE.disabled = true;    


            
            document.all.delanteraIzqC.disabled = true;
            document.all.delanteraDerC.disabled = true;
            document.all.traseraIzqC.disabled = true;
            document.all.traseraDerC.disabled = true;
            document.all.esAutomatico.disabled = true;
            document.all.esManual.disabled = true;
            document.all.estaBloqueada.disabled = true;
            document.all.noEstaBloqueada.disabled = true;
            document.all.todasBloqueadas.disabled = true;
            document.all.tieneDuales.disabled = true;
            document.all.noTieneDuales.disabled = true;
            
            document.all.siEncienden.disabled = true;
            document.all.noEncienden.disabled = true;
            document.all.siCompra.disabled = true;
            document.all.noCompra.disabled = true;
            document.all.enCondiciones.disabled = true;
            document.all.noEnCondiciones.disabled = true;
            document.all.tieneTuerca.disabled = true;
            document.all.noTieneTuerca.disabled = true;
            document.all.tieneLlave.disabled = true;
            document.all.noTieneLlave.disabled = true;
            document.all.esProgramado.disabled = true;
            document.all.noEsProgramado.disabled = true;
            
        /*Cargo los datos para subservicio EXTRACCION*/
        if ( document.all.dsSubservicio.value.toString() === 'Extracción' ) {
            
 
            document.all.divUML.style.visibility = 'hidden';
            document.all.divExtraccion.style.visibility = 'visible';
            document.all.divGaraje.style.visibility = 'hidden';
            document.all.divEncajado.style.visibility = 'hidden';
            document.all.divEstadoVh.style.visibility = 'hidden';
            document.all.divSubsuelo.style.visibility = 'hidden';
            document.all.divANivel.style.visibility = 'hidden';
            document.all.divEstadoVh.style.visibility='hidden';

            document.all.divRuedasBloqueadas.style.visibility = 'hidden';
            var cambio = <%=StrclInfoAdicKMO%>;
            if ( cambio.toString() !== '0' ) {
                
                fnCambiaUbicacion(<%=clUbicacionAuto%>);
                var combobox  = document.getElementById("clUbicacionAutoC");
                var ubicacion = combobox.options[combobox.selectedIndex].text;

                if ( ubicacion.toString().toUpperCase() === 'ENCAJADO' || 
                        ubicacion.toString().toUpperCase() === 'ZANJA' ||
                        ubicacion.toString().toUpperCase() === 'POZO' ||
                        ubicacion.toString().toUpperCase() === 'VOLCADO' ) {
                    document.all.divEstadoVh.style.visibility = 'visible';
                }
                
                if ( ubicacion.toString().toUpperCase() === 'ENCAJADO' ) {
                    var elementLE = document.getElementById("lugarEncajadoC")
                    elementLE.disabled = true;
                    document.all.divEncajado.style.visibility = 'visible';
                }
                
                if ( ubicacion.toString().toUpperCase() === 'GARAJE/ESTACIONAMIENTO' ) {
                    var elementUG = document.getElementById("clUbicacionAutoGarajeC")
                    elementUG.disabled = true;
                    var combobox  = document.getElementById("clUbicacionAutoGarajeC");
                    var ubicacionDentroDelGaraje = combobox.options[combobox.selectedIndex].text;
                    if ( ubicacionDentroDelGaraje.toString().toUpperCase() == 'SUBSUELO' || 
                            ubicacionDentroDelGaraje.toString().toUpperCase() == 'A NIVEL' ) {

                            var elementNS = document.getElementById("nivelSubsueloC");
                            var elementAC= document.getElementById("aNivelAbiertoC");
                            elementAC.disabled = true;
                            elementNS.disabled = true;
                            if ( ubicacionDentroDelGaraje.toString().toUpperCase() == 'A NIVEL') {
                                document.all.divSubsuelo.style.visibility = 'hidden';
                                document.all.divANivel.style.visibility = 'visible'

                                /*Alerta cuando es a nivel*/

                            } else {
                                document.all.divSubsuelo.style.visibility = 'visible';
                                document.all.divANivel.style.visibility = 'hidden';
                            }
                    }
                }
                document.all.esAutomatico.checked = document.all.automatico.value === '1'?true:false;
                document.all.esManual.checked     = document.all.automatico.value === '1'?false:true;
                document.all.estaBloqueada.checked= document.all.ruedaBloqueada.value === '1'?true:false;
                document.all.noEstaBloqueada.checked= document.all.ruedaBloqueada.value === '1'?false:true;
                
                var cantBloqueadas = <%=infoAdicAV != null?infoAdicAV.getCantBloqueadas():0%>;
                if ( cantBloqueadas.toString() === '4' ) {
                    document.all.todasBloqueadas.checked = true;
                }
                if ( document.all.estaBloqueada.checked || document.all.todasBloqueadas.checked ) {
                    document.all.divRuedasBloqueadas.style.visibility = 'visible';
                }
                document.all.tieneDuales.checked= document.all.ruedasDuales.value === '1'?true:false;
                document.all.noTieneDuales.checked= document.all.ruedasDuales.value === '1'?false:true;
                document.all.esProgramado.checked   = document.all.servicioProgramado.value === '1'?true:false;
                document.all.noEsProgramado.checked = document.all.servicioProgramado.value === '1'?false:true;
                fnServicioProgramado(document.all.servicioProgramado.value);
                //(document.all.clTipoFalla);
               
            }
        }
        /*Cargo los datos para subservicio UML*/
        if ( document.all.dsSubservicio.value.toString() === 'UML' ) {
            /*Seteo los máximos permitidos para ciertos campos*/
            document.all.divExtraccion.style.visibility = 'hidden';
            document.all.divUML.style.visibility = 'visible';
            document.all.divGarajeUML.style.visibility = 'hidden';
            document.all.divSubsueloUML.style.visibility = 'hidden';
            document.all.divANivelUML.style.visibility = 'hidden';
            document.all.divSinBateria.style.visibility = 'hidden';
            document.all.divRuedaEnCondiciones.style.visibility = 'hidden';
            document.all.divTuercaSeg.style.visibility = 'hidden';
            document.all.divLlaveTuercaSeg.style.visibility = 'hidden';
            document.all.divSuministroCombustible.style.visibility = 'hidden';
            document.all.divEstacionamientoUML.style.visibility = 'hidden';

            
            elementUG.value = 0;
            elementNS.value = 0;
            elementAC.value = 0;
            elementLE.value = 0;
            var cambio = <%=StrclInfoAdicKMO%>;
            if ( cambio.toString() !== '0' ) {
                
                fnCambiaUbicacionUML(<%=clUbicacionAuto%>);
                var combobox  = document.getElementById("clUbicacionAutoUMLC");
                var ubicacion = combobox.options[combobox.selectedIndex].text;
                
                if ( ubicacion.toString().toUpperCase() === 'AUTOPISTA' ) {
                    var elementES = document.getElementById("clEstacionamientoUMLC")
                    elementES.disabled = true;
                    document.all.divEstacionamientoUML.style.visibility = 'visible';
                }
                    
               
                if ( ubicacion.toString().toUpperCase() === 'GARAJE/ESTACIONAMIENTO' ) {
                    var elementUG = document.getElementById("clUbicacionAutoGarajeUMLC")
                    elementUG.disabled = true;
                    var combobox  = document.getElementById("clUbicacionAutoGarajeUMLC");
                    var ubicacionDentroDelGaraje = combobox.options[combobox.selectedIndex].text;
                    if ( ubicacionDentroDelGaraje.toString().toUpperCase() == 'SUBSUELO' || 
                            ubicacionDentroDelGaraje.toString().toUpperCase() == 'A NIVEL' ) {

                            var elementNS = document.getElementById("nivelSubsueloUMLC");
                            var elementAC= document.getElementById("aNivelAbiertoUMLC");
                            elementAC.disabled = true;
                            elementNS.disabled = true;
                            if ( ubicacionDentroDelGaraje.toString().toUpperCase() == 'A NIVEL') {
                                document.all.divSubsueloUML.style.visibility = 'hidden';
                                document.all.divANivelUML.style.visibility = 'visible';

                                /*Alerta cuando es a nivel*/

                            } else {
                                document.all.divSubsueloUML.style.visibility = 'visible';
                                document.all.divANivelUML.style.visibility = 'hidden';
                            }
                    }
                }
                

         
               
                fnFallaVehiculoUML(document.all.clTipoFalla);
                document.all.esProgramado.checked   = document.all.servicioProgramado.value === '1'?true:false;
                document.all.noEsProgramado.checked = document.all.servicioProgramado.value === '1'?false:true;
                fnServicioProgramado(document.all.servicioProgramado.value);
            }

        }   
            
            
            
            $(document).ready(function() {
                
                $(document).mousemove(function(event){
                $(document.getElementById('clLugarEvento')).val('2');
                $(document.getElementById('clLugarEventoC')).val('2');
                    });
        
                <!-- define que boton va habilitado o no al inicio -->
                document.getElementById('btnAlta').disabled = <%=(AV != null?"true":"false")%>;
                document.getElementById('btnCambio').disabled = <%=(AV == null?"true":"false")%>;
                document.getElementById('btnElimina').disabled = <%=(AV == null?"true":"false")%>;
                document.all.MapaOrig.disabled = true; 
                $("#btnCambio").click(function() {
                    document.getElementById("DireccionA").disabled = false; 
                    document.all.MapaOrig.disabled = false; 
                });
                $("#btnAlta").click(function() {
                    document.getElementById("DireccionA").disabled = false; 
                    document.all.MapaOrig.disabled = false; 
                });
                // $("#CalleNum").change(function() { document.getElementById("LatLong").value = ""; })
            });

            var placeSearch, autocomplete;
            var componentForm = {
              street_number: 'short_name',
              route: 'long_name',
              locality:'long_name',
              administrative_area_level_1: 'long_name',
              administrative_area_level_2: 'long_name'
            };            
            //--------------------------------------------------------
            function initMap() {
                document.getElementById("DireccionA").disabled = true;             }
            
            function fillInAddressAux() {
                fillInAddressGeneric(autocomplete.getPlace(),"CalleNum", "LatLong", "dsMunDel", "dsEntFed", "CodMDOrigen", "CodEntOrigen");
            }
            
            function openMap(campo, latLong, calle, localidad, provincia,codMD, codEnt) {
                direccion = document.getElementById(campo).value;
                geo = window.open('../../Geolocalizacion/gmap3.jsp?dire='+ direccion +'&dDir=' + campo + '&dLatLon=' + latLong
                + '&fCalle=' + calle + "&fLoc=" + localidad + "&fPro=" + provincia + "&fCodMD=" + codMD + "&fCodEnt=" + codEnt, 'GEO',
                'modal=yes,resizable=yes,menubar=0,status=0,toolbar=0,height=820,width=1200,screenX=1,screenY=1');
                geo.focus();                
            }
            document.all.Modelo.maxLength = 4;
            document.all.Placas.maxLength = 8;
            
            function fnValLugar() {
                if (document.all.CodEntOrigen.value == '002') {
                    document.all.clLugarEventoC.value = 2;
                    document.all.clLugarEvento.value = 2;
                }
                else {
                    document.all.clLugarEventoC.value = 1;
                    document.all.clLugarEvento.value = 1;
                }
                
            }
            
            function fnHabilitar() {
                document.all.delanteraIzqC.disabled = false;
                document.all.delanteraDerC.disabled = false;
                document.all.traseraIzqC.disabled = false;
                document.all.traseraDerC.disabled = false;
                document.all.esAutomatico.disabled = false;
                document.all.esManual.disabled = false;
                document.all.estaBloqueada.disabled = false;
                document.all.noEstaBloqueada.disabled = false;
                document.all.todasBloqueadas.disabled = false;
                document.all.tieneDuales.disabled = false;
                document.all.noTieneDuales.disabled = false;

                document.all.siEncienden.disabled = false;
                document.all.noEncienden.disabled = false;
                document.all.siCompra.disabled = false;
                document.all.noCompra.disabled = false;
                document.all.enCondiciones.disabled = false;
                document.all.noEnCondiciones.disabled = false;
                document.all.tieneTuerca.disabled = false;
                document.all.noTieneTuerca.disabled = false;
                document.all.tieneLlave.disabled = false;
                document.all.noTieneLlave.disabled = false;
                document.all.esProgramado.disabled = false;
                document.all.noEsProgramado.disabled = false;
            }
            
              /**
             * Si es garaje, habilito el combo
             * de ubicacion dentro del garaje.
             * Si no es garaje, deshabilito todos
             * los combos asociados a ubicacion en
             * garage.
             */
            function fnCambiaUbicacion(idUbicacion) {
                
                var combobox  = document.getElementById("clUbicacionAutoC");
                var ubicacion = combobox.options[combobox.selectedIndex].text;
                var elementUG = document.getElementById("clUbicacionAutoGarajeC");
                var elementNS = document.getElementById("nivelSubsueloC");
                var elementAC= document.getElementById("aNivelAbiertoC");
                var elementLE= document.getElementById("lugarEncajadoC");
                elementUG.disabled = true; 
                elementNS.disabled = true;
                elementAC.disabled = true;
                elementLE.disabled = true;
                
                if ( ubicacion.toString().toUpperCase() === 'ENCAJADO' || 
                        ubicacion.toString().toUpperCase() === 'ZANJA' ||
                        ubicacion.toString().toUpperCase() === 'POZO' ||
                        ubicacion.toString().toUpperCase() === 'VOLCADO' ) {
                    document.all.divEstadoVh.style.visibility = 'visible';
                } else {
                    document.all.divEstadoVh.style.visibility = 'hidden';
                    document.all.estadoVehiculo.value = '';
                }
                
                if ( ubicacion.toString().toUpperCase() === 'ENCAJADO') {
                    elementLE.disabled = false;
                    document.all.divGaraje.style.visibility = 'hidden';
                    document.all.divSubsuelo.style.visibility = 'hidden';
                    document.all.divANivel.style.visibility = 'hidden';
                    document.all.divEncajado.style.visibility = 'visible';
                    document.all.divEstadoVh.style.visibility = 'visible';
                    return;
                } else {
                    document.all.distTierraFirme.value = '';
                }
                
                if ( ubicacion.toString().toUpperCase() === 'GARAJE/ESTACIONAMIENTO' ) {
                    elementUG.disabled = false;
                    document.all.divGaraje.style.visibility = 'visible';
                    document.all.divEncajado.style.visibility = 'hidden';
                    document.all.divSubsuelo.style.visibility = 'hidden';
                    document.all.divANivel.style.visibility = 'hidden';
                } else {
                    
                    elementUG.disabled = true; 
                    elementNS.disabled = true;
                    elementAC.disabled = true;
                    elementLE.disabled = true;
                    elementUG.value = '';
                    elementNS.value = '';
                    elementAC.value = '';
                    elementLE.value = '';
                    document.all.divGaraje.style.visibility = 'hidden';
                    document.all.divEncajado.style.visibility = 'hidden';
                    document.all.divSubsuelo.style.visibility = 'hidden';
                    document.all.divANivel.style.visibility = 'hidden';
                }
            }

                  /**
             * Si es garaje, habilito el combo
             * de ubicacion dentro del garaje.
             * Si no es garaje, deshabilito todos
             * los combos asociados a ubicacion en
             * garage.
             */
            function fnCartelAutopista() {
                
                var combobox  = document.getElementById("clUbicacionAutoUMLC");
                var ubicacion = combobox.options[combobox.selectedIndex].text;
                if ( ubicacion.toString().toUpperCase() === 'AUTOPISTA') {
                    alert("Recuerde que debe comunicarse con la asistencia de la autopista.");
                }
            }
            
            /*Muestra un cartel en caso de que
             * el auto este en la ruta
             */
            function fnCartelRuta() {
                var combobox  = document.getElementById("clUbicacionAutoUMLC");
                var ubicacion = combobox.options[combobox.selectedIndex].text;
                if ( ubicacion.toString().toUpperCase() === 'RUTA') {
                    alert("Recuerde que no se realiza una puesta en marcha ni cambio de neumatico en la ruta. Ofrecer traslado.");
                }
            }
            
           /**
             * Si es garaje, habilito el combo
             * de ubicacion dentro del garaje.
             * Si no es garaje, deshabilito todos
             * los combos asociados a ubicacion en
             * garage.
             */
            function fnCambiaUbicacionUML(idUbicacion) {
                
                var combobox  = document.getElementById("clUbicacionAutoUMLC");
                var ubicacion = combobox.options[combobox.selectedIndex].text;
                var elementUG = document.getElementById("clUbicacionAutoGarajeUMLC");
                var elementNS = document.getElementById("nivelSubsueloUMLC");
                var elementAC= document.getElementById("aNivelAbiertoUMLC");
                var elementES= document.getElementById("clEstacionamientoUMLC")
                elementUG.disabled = true; 
                elementNS.disabled = true;
                elementAC.disabled = true;
                elementES.disabled = true;
                
                if ( ubicacion.toString().toUpperCase() === 'AUTOPISTA') {
                    elementES.disabled = false;
                    elementUG.disabled = true; 
                    elementNS.disabled = true;
                    elementAC.disabled = true;
                    elementUG.value = '';
                    elementNS.value = '';
                    elementAC.value = '';
                    document.all.divGarajeUML.style.visibility = 'hidden';
                    document.all.divSubsueloUML.style.visibility = 'hidden';
                    document.all.divANivelUML.style.visibility = 'hidden';
                    document.all.divEstacionamientoUML.style.visibility = 'visible';
                    return;
                }
                
                if ( ubicacion.toString().toUpperCase() === 'GARAJE/ESTACIONAMIENTO' ) {
                    elementUG.disabled = false;
                    elementES.value = '';
                    document.all.divGarajeUML.style.visibility = 'visible';
                    document.all.divSubsueloUML.style.visibility = 'hidden';
                    document.all.divANivelUML.style.visibility = 'hidden';
                    document.all.divEstacionamientoUML.style.visibility = 'hidden';

                } else {
                    
                    elementUG.disabled = true; 
                    elementNS.disabled = true;
                    elementAC.disabled = true;
                    elementES.disabled = true;
                    elementUG.value = '';
                    elementNS.value = '';
                    elementAC.value = '';
                    elementES.value = '';
                    document.all.divGarajeUML.style.visibility = 'hidden';
                    document.all.divSubsueloUML.style.visibility = 'hidden';
                    document.all.divANivelUML.style.visibility = 'hidden';
                    document.all.divEstacionamientoUML.style.visibility = 'hidden';
                }
            }
            
            /**
             * Si el vehículo esta ubicado en un
             * garaje, tengo que seleccionar en que
             * espacio del garaje se encuentra.
             * Si es a nivel, habilito el combo de
             * abierto o cerrado y si es subsuelo,
             * habilito el combo de nivel de subsuelo.
            */
            function fnSeteaUbicacion(idUbicacionDentroDelGaraje) {
                var combobox  = document.getElementById("clUbicacionAutoGarajeC");
                var ubicacionDentroDelGaraje = combobox.options[combobox.selectedIndex].text;
                var elementNS = document.getElementById("nivelSubsueloC");
                var elementAC= document.getElementById("aNivelAbiertoC");
                
                if ( ubicacionDentroDelGaraje.toString().toUpperCase() !== 'A NIVEL' &&
                     ubicacionDentroDelGaraje.toString().toUpperCase() !== 'SUBSUELO' ) {
                    
                    elementNS.disabled = true;
                    elementAC.disabled = true;
                    elementNS.value = '';
                    elementAC.value = '';
                    document.all.divSubsuelo.style.visibility = 'hidden';
                    document.all.divANivel.style.visibility = 'hidden';
                } else {
                
                    if ( ubicacionDentroDelGaraje.toString().toUpperCase() === 'A NIVEL' ) {
                        elementAC.disabled = false;
                        elementNS.disabled = true;
                        elementNS.value = '';
                        document.all.divSubsuelo.style.visibility = 'hidden';
                        document.all.divANivel.style.visibility = 'visible';
                    
                        /*Alerta cuando es a nivel*/
                       //alert("Recuerda informar al usuario que el vehículo debe encontrarse sobre la vía pública. Si esto no es posible.");
                             
                    } 
                    
                    if ( ubicacionDentroDelGaraje.toString().toUpperCase() === 'SUBSUELO' ) {
                        elementNS.disabled = false;
                        elementAC.disabled = true;
                        elementAC.value = '';
                        document.all.divSubsuelo.style.visibility = 'visible';
                        document.all.divANivel.style.visibility = 'hidden';
                    }
                
                }
            
            }

            /**
             * Si el vehículo esta ubicado en un
             * garaje, tengo que seleccionar en que
             * espacio del garaje se encuentra.
             * Si es a nivel, habilito el combo de
             * abierto o cerrado y si es subsuelo,
             * habilito el combo de nivel de subsuelo.
            */
            function fnSeteaUbicacionUML(idUbicacionDentroDelGaraje) {
                var combobox  = document.getElementById("clUbicacionAutoGarajeUMLC");
                var ubicacionDentroDelGaraje = combobox.options[combobox.selectedIndex].text;
                var elementNS = document.getElementById("nivelSubsueloUMLC");
                var elementAC= document.getElementById("aNivelAbiertoUMLC");
                
                if ( ubicacionDentroDelGaraje.toString().toUpperCase() !== 'A NIVEL' &&
                     ubicacionDentroDelGaraje.toString().toUpperCase() !== 'SUBSUELO' ) {
                    
                    elementNS.disabled = true;
                    elementAC.disabled = true;
                    elementNS.value = '';
                    elementAC.value = '';
                    document.all.divSubsueloUML.style.visibility = 'hidden';
                    document.all.divANivelUML.style.visibility = 'hidden';
                } else {
                
                    if ( ubicacionDentroDelGaraje.toString().toUpperCase() === 'A NIVEL' ) {
                        elementAC.disabled = false;
                        elementNS.disabled = true;
                        elementNS.value = '';
                        document.all.divSubsueloUML.style.visibility = 'hidden';
                        document.all.divANivelUML.style.visibility = 'visible';
                    
                        /*Alerta cuando es a nivel*/
                       //alert("Recuerda informar al usuario que el vehículo debe encontrarse sobre la vía pública. Si esto no es posible.");
                             
                    } 
                    
                    if ( ubicacionDentroDelGaraje.toString().toUpperCase() === 'SUBSUELO' ) {
                        elementNS.disabled = false;
                        elementAC.disabled = true;
                        elementAC.value = '';
                        document.all.divSubsueloUML.style.visibility = 'visible';
                        document.all.divANivelUML.style.visibility = 'hidden';
                    }
                
                }
            
            }    
    
            /**
             * Nivel de subsuelo
             */
            function fnSeteaNivel(idAbiertoCerrado) {
            } 
            
            /**
             * A nivel, abierto/cerrado
             */
            function fnAbiertoCerrado(idAbiertoCerrado) {
            }
            
            /**
             * Nivel de subsuelo UML
             */
            function fnSeteaNivelUML(idAbiertoCerrado) {
            } 
            /**
             * A nivel, abierto/cerrado
             */
            function fnAbiertoCerradoUML(idAbiertoCerrado) {
            }
            
            /**Radio button automatico/manual*/
            function fnValorRadioAutoManual() {
                
            }
            
            /**Rueda de auxilio*/
            function fnRuedaAuxilio(tieneRuedaAux) {
                if ( tieneRuedaAux === '0' ) {
                    alert("Ofrecer traslado a gomería más cercana");
                    document.all.divTuercaSeg.style.visibility = 'hidden';
                    document.all.divLlaveTuercaSeg.style.visibility = 'hidden';
                    document.all.tuercaSeguridad.value= '0';
                    document.all.llaveTuercaSeg.value = '0';
                } else {
                    document.all.divTuercaSeg.style.visibility = 'visible';
                }
            }
            
            /**Radio button tuerca de seguridad tiene/no tiene*/
            function fnValorTieneTuerca(tieneTuercaSeg) {
                if ( tieneTuercaSeg === '1' ) {
                    document.all.divLlaveTuercaSeg.style.visibility = 'visible';
                } else {
                    document.all.divLlaveTuercaSeg.style.visibility = 'hidden';
                    document.all.llaveTuercaSeg.value = '0';
                }
            }
            
            function fnLlaveTuerca(tieneLlaveTuerca) {
                if ( tieneLlaveTuerca === '0' ) {
                    alert("Recuerde que debe tener la llave de seguridad para retirar la tuerca");
                }
            }
            
            
            /**Radio button rueda bloqueada/no bloqueada*/
            function fnValorRadioBloqueada(bloqueada) {
                if ( bloqueada === '1' ) {
                    document.all.delanteraIzqC.disabled = false;
                    document.all.delanteraDerC.disabled = false;
                    document.all.traseraIzqC.disabled = false;
                    document.all.traseraDerC.disabled = false;
                    document.all.divRuedasBloqueadas.style.visibility = 'visible';
                } else {
                    document.all.delanteraIzqC.disabled = true;
                    document.all.delanteraDerC.disabled = true;
                    document.all.traseraIzqC.disabled = true;
                    document.all.traseraDerC.disabled = true;
                    document.all.delanteraIzqC.checked = false;
                    document.all.delanteraDerC.checked = false;
                    document.all.traseraIzqC.checked = false;
                    document.all.traseraDerC.checked = false;
                    document.all.divRuedasBloqueadas.style.visibility = 'hidden';
                }
            }
            
            /*Bloquea todas las ruedas*/
            function fnRuedaBloqueadaTodas() {
                document.all.delanteraIzqC.checked = true;
                document.all.delanteraDerC.checked = true;
                document.all.traseraIzqC.checked   = true;
                document.all.traseraDerC.checked   = true;
                
            }
            /*
             * Seteo los hidden
             * de ruedas bloqueadas
             */
            function fnRuedaBloqueada() {
                document.all.delanteraIzq.value = document.all.delanteraIzqC.checked?"1":"0";
                document.all.delanteraDer.value = document.all.delanteraDerC.checked?"1":"0";
                document.all.traseraIzq.value   = document.all.traseraIzqC.checked?"1":"0";
                document.all.traseraDer.value   = document.all.traseraDerC.checked?"1":"0";
            }
            
            /**
             * Tipo de falla, si es
             * avería, hay que habilitar
             * el detalle 
             */
            function fnFallaVehiculo(idTipoFalla) {
                var combobox  = document.getElementById("clTipoFallaC");
                var tipoFalla = combobox.options[combobox.selectedIndex].text;
                
                if ( tipoFalla.toString().toUpperCase() === 'AVERÍA') {
                    document.all.detalleFalla.disabled = false;
                    document.all.divTipoFalla.style.visibility = 'visible';
                } else {
                    document.all.divTipoFalla.style.visibility = 'hidden';
                    document.all.detalleFalla.disabled = true;
                    document.all.detalleFalla.value = '';
                    //PGM: Reunion 050521: queda pendiente de analisis
                    //alert("Recuerde preguntar al usuario si se encuentra bien.");
                    return;
                }
            }
         
            /**
             * Tipo de falla, si es
             * avería, hay que habilitar
             * el detalle 
             */
            function fnFallaVehiculoUML(idTipoFalla) {
                var combobox  = document.getElementById("clTipoFallaUMLC");
                var tipoFalla = combobox.options[combobox.selectedIndex].text;
                var elementTG = document.getElementById("clTipoGasolinaC");
                var elementCL= document.getElementById("clCantLitrosC");
           
                if ( tipoFalla.toString().toUpperCase() === 'SIN BATERÍA') {
                    document.all.divSinBateria.style.visibility = 'visible';
                    document.all.divRuedaEnCondiciones.style.visibility = 'hidden';
                    document.all.divTuercaSeg.style.visibility = 'hidden';
                    document.all.divLlaveTuercaSeg.style.visibility = 'hidden';
                    document.all.divSuministroCombustible.style.visibility = 'hidden';
                    elementTG.value = '';
                    elementCL.value = '';
                    document.all.siEncienden.checked= document.all.lucesEncienden.value === '1'?true:false;
                    document.all.noEncienden.checked= document.all.lucesEncienden.value === '1'?false:true;
                    
                    document.all.siCompra.checked = document.all.compraBateria.value === '1'?true:false;
                    document.all.noCompra.checked = document.all.compraBateria.value === '1'?false:true;
                    
                } 
                
                if ( tipoFalla.toString().toUpperCase() === 'CAMBIO DE NEUMÁTICO') {
                    document.all.divSinBateria.style.visibility = 'hidden';
                    document.all.divRuedaEnCondiciones.style.visibility = 'visible';
                    
                    document.all.enCondiciones.checked= document.all.ruedaAuxEnCond.value === '1'?true:false;
                    document.all.noEnCondiciones.checked= document.all.ruedaAuxEnCond.value === '1'?false:true; 

                    if ( document.all.ruedaAuxEnCond.value === '1' ) {
                        document.all.divTuercaSeg.style.visibility = 'visible';
                        document.all.tieneTuerca.checked= document.all.tuercaSeguridad.value === '1'?true:false; 
                        document.all.noTieneTuerca.checked= document.all.tuercaSeguridad.value === '1'?false:true; 

                        if ( document.all.tuercaSeguridad.value === '1' ) {
                            document.all.divLlaveTuercaSeg.style.visibility = 'visible';
                            document.all.tieneLlave.checked= document.all.llaveTuercaSeg.value === '1'?true:false; 
                            document.all.noTieneLlave.checked= document.all.llaveTuercaSeg.value === '1'?false:true;
                        } else {
                            document.all.divLlaveTuercaSeg.style.visibility = 'hidden';
                        }
                    } else {
                        document.all.divTuercaSeg.style.visibility = 'hidden';
                        document.all.divLlaveTuercaSeg.style.visibility = 'hidden';
                        document.all.tuercaSeguridad.value = '';
                        document.all.llaveTuercaSeg.value  = '';
                        
                    }
                    document.all.divSuministroCombustible.style.visibility = 'hidden';
                    elementTG.value = '';
                    elementCL.value = '';
                } 
                
                if ( tipoFalla.toString().toUpperCase() === 'SUMINISTRO DE COMBUSTIBLE') {
                    document.all.divSinBateria.style.visibility = 'hidden';
                    document.all.divRuedaEnCondiciones.style.visibility = 'hidden';
                    document.all.divTuercaSeg.style.visibility = 'hidden';
                    document.all.divLlaveTuercaSeg.style.visibility = 'hidden';
                    document.all.divSuministroCombustible.style.visibility = 'visible';
                } 
            }
            
             /**
             * Tipo de falla, si es
             * avería, hay que habilitar
             * el detalle 
             */
            function fnCambioFallaVehiculoUML(idTipoFalla) {
                var combobox  = document.getElementById("clTipoFallaUMLC");
                var tipoFalla = combobox.options[combobox.selectedIndex].text;
                var elementTG = document.getElementById("clTipoGasolinaC");
                var elementCL= document.getElementById("clCantLitrosC");
                document.all.siEncienden.checked= false;
                document.all.noEncienden.checked= false;
                document.all.siCompra.checked = false;
                document.all.noCompra.checked = false;
                document.all.enCondiciones.checked= false;
                document.all.noEnCondiciones.checked= false; 
                document.all.tieneTuerca.checked= false; 
                document.all.noTieneTuerca.checked= false; 
                
                if ( document.all.divLlaveTuercaSeg.style.visibility === 'visible' ) {
                    document.all.tieneLlave.checked= false;
                    document.all.noTieneLlave.checked= false; 
                }
                //document.all.detalleFalla.disabled = true;  //En UML no hay detalle falla
                
                elementTG.value = '';
                elementCL.value = '';
                elementTG.disabled = true;
                elementCL.disabled = true;
                if ( tipoFalla.toString().toUpperCase() === 'SIN BATERÍA') {
                    document.all.divSinBateria.style.visibility = 'visible';
                    document.all.divRuedaEnCondiciones.style.visibility = 'hidden';
                    document.all.divLlaveTuercaSeg.style.visibility = 'hidden';
                    document.all.divSuministroCombustible.style.visibility = 'hidden';
                    document.all.divTuercaSeg.style.visibility = 'hidden';
                    document.all.ruedaAuxEnCond.value = '';
                    document.all.tuercaSeguridad.value= '';
                    document.all.llaveTuercaSeg.value = '';
               } 
                
                if ( tipoFalla.toString().toUpperCase() === 'CAMBIO DE NEUMÁTICO') {
                    document.all.divSinBateria.style.visibility = 'hidden';
                    document.all.divRuedaEnCondiciones.style.visibility = 'visible';
                    document.all.divLlaveTuercaSeg.style.visibility = 'hidden';
                    document.all.divSuministroCombustible.style.visibility = 'hidden';
                    document.all.lucesEncienden.value = '';
                    document.all.compraBateria.value = '';
                } 
                
                if ( tipoFalla.toString().toUpperCase() === 'SUMINISTRO DE COMBUSTIBLE') {
                    document.all.divSinBateria.style.visibility = 'hidden';
                    document.all.divRuedaEnCondiciones.style.visibility = 'hidden';
                    document.all.divLlaveTuercaSeg.style.visibility = 'hidden';
                    document.all.divTuercaSeg.style.visibility = 'hidden';
                    document.all.divSuministroCombustible.style.visibility = 'visible';
                    elementTG.disabled = false;
                    elementCL.disabled = false;
                    document.all.ruedaAuxEnCond.value = '';
                    document.all.tuercaSeguridad.value= '';
                    document.all.llaveTuercaSeg.value = '';
                    document.all.lucesEncienden.value = '';
                    document.all.compraBateria.value = '';
                } 
            }

            /**Radio tton tiene ruedas duales*/
            function fnValorRadioDuales(ruedasDuales) {
                
            }
            
            /**Setea tipo de combustible*/
            function fnSeteaTipoCombus(idTipoCombustible) {
            }
            
            /**Setea cantidad de litros*/
            function fnSeteaCantLitros(idSeteaCantLitros) {
            }
            
            function fnServicioProgramado(esServicioProgramado) {
                if ( esServicioProgramado === '1' ) {
                    document.all.divFechaProgramada.style.visibility = 'visible';
                } else {
                    document.all.divFechaProgramada.style.visibility = 'hidden';
                    document.all.Fecha.value = ' ';
                    document.all.HoraD.value = ' ';
                    document.all.HoraH.value = ' ';
                }
            } 
            
            /**
             * Test guardar información
            */
           function successFunc() {
                fnOpenWindow();
                document.all.forma.submit();
           }
           function failureFunc() {
               
           }
           
            function fnMuestraCoberturas() {
                var pstrCadena = "../VistaCobertura.jsp?";
                pstrCadena = pstrCadena + "&clCuenta=<%=StrclCuenta%> ";
                window.open(pstrCadena, '', 'resizable=1,menubar=0,status=0,toolbar=0,height=800,width=1030,screenX=-50,screenY=0,scrollbars=yes');
            }

            /*Ingreso de fecha programada*/
            function fnValidaFechaActual(campo){  
                var anio =  parseInt(campo.value.substring(0),10);
                var nva_fecha = new Date();
                var anio_mas_uno = parseInt(nva_fecha.getFullYear()) + 1;
                var FechaC1 = document.getElementById("Fecha").value;
                var FechaC = FechaC1.substring(0, 10); 
                campo.value=FechaC;
            }          
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
            
            function fnHrsH(campo){
                var StrHoraHL=(document.getElementById("HoraH").value.length);                
                    if(StrHoraHL <= 2){                   
                        var StrHoraHV=(document.getElementById("HoraH").value);
                        var min=":00";
                        var res = StrHoraHV.concat(min);
                        campo.value=res;
                }
                validaHora(campo);
            }
            
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
            
            function devolverMinutos(horaMinutos){
                var horass=((horaMinutos.split(":")[0])*60);
                var minutoss=(horaMinutos.split(":")[1]);               
                var sumHM= (1*horass+ minutoss*1);              
                return sumHM;
            }     
            
            function isValidDate(d) {
                return d instanceof Date && !isNaN(d);
            }
            
            /*Valida que el período no
             * supere las dos horas
             */
            function fnHrsCita(){
                var StrHoraD=devolverMinutos(document.getElementById("HoraD").value);
		var StrHoraH=devolverMinutos(document.getElementById("HoraH").value);
                var StrDifHr = (StrHoraH-StrHoraD);
                
                if(StrHoraH  < StrHoraD && StrHoraD < 1261){
                    alert("Rango no permitido");
                }
                else if(StrDifHr > 120){
                    alert("No se puede ingresar un rango mayor a 2 hs");
                }
                else if(StrDifHr < 0){
                    StrHoraH = (StrHoraH + 1440) - StrHoraD;
                    if(StrHoraH > 180){
                         alert("No se puede ingresar un rango mayor a 2 hs");
                    } 
                }
            }       
            
            /**Insertar datos adicionales
             * antes de guardar la asistencia
             * para luego pasarle el
             * id de InfoAdicionalKM0 a
             * la tabla de AsistenciaKM0*/
            function fnGuardarInfoAdicional() { 
                
                
               
                /**Solo para EXTRACCION Y UML*/
                if ( document.all.dsSubservicio.value.toString() !== 'Extracción' &&
                        document.all.dsSubservicio.value.toString() !== 'UML') {
                    
                     /*Si no da error, grabo la asistencia*/  
                     /*Valido los campos en general*/
                    fnValida(); 
                    
                    /*Si dió algún error, 
                     * salgo del método
                     */
                    if ( msgVal !== '') {
                        document.all.btnGuarda.disabled=false;
                        document.all.btnCancela.disabled=false;
                        return;
                    }
                    /**Grabo los datos*/
                    fnOpenWindow();
                    //document.all.forma.action = "../../servlet/Utilerias.EjecutaAccionAsist";
                    document.all.forma.submit();
                    return;
                }
                
                /**Definición de variables**/
                var clUbicacionAuto       = 0;
		var clUbicacionAutoGaraje = 0;
		var lugarEncajado         = 0;
		var aNivelAbierto         = 0;
		var nivelSubsuelo         = 0;
		var clTipoFalla           = 0;
		var detalleFalla          = " ";
		var automatico            = 0;
		var ruedaBloqueada        = 0;
                var vehiculoLiberado      = 0;
                
 		/*Ruedas bloqueadas*/
		var delanteraIzq   = 0;
		var delanteraDer   = 0;
		var traseraIzq     = 0;
		var traseraDer     = 0;
                var cantBloqueadas = 0;
		var tieneCarga     = 0;
		var pesoCarga      = 0;
		var tipoCarga      = " ";
		var clCantPersona  = 0;
		var cedulaVerdeVig = 0;
		var recibeNombre   = " ";
		var recibeCodArea  = 0;
		var recibeNroTelef = 0;
		var clModifAuto    = 0;
		var distanciaPiso  = 0;
		var largo          = 0;
		var alto           = 0;
		var detalleModif   = " ";
		var ruedasDuales   = 0;               
                var lucesEncienden = 0;
                var ruedaAuxEnCond = 0;
                var tuercaSeguridad = 0;
                var llaveTuercaSeg = 0;
                var clTipoGasolina = 0;
                var clCantLitros = 0;
                var estadoVehiculo = " ";
                var distTierraFirme = " ";
                var compraBateria = 0;
                var servicioProgramado = document.all.servicioProgramado.value==null?'':document.all.servicioProgramado.value;;
                var fechaProgramado = document.all.Fecha.value==null?' ':document.all.Fecha.value;
                var horaDesdeProg = document.all.HoraD.value==null?' ':document.all.HoraD.value;
                var horaHastaProg = document.all.HoraH.value==null?' ':document.all.HoraH.value;
                var peajesCubiertos = 0;
                var montoCubierto = 0; 
                var clEstacionamiento = 0; 
                var cambiosOrigenDest= "";
                var kmAsistencia = 0;
        
                /**Seteo de variables*/
                var clInfoAdicKMO = <%=StrclInfoAdicKMO%>;
		var clExpediente  = <%=StrclExpediente%>;
                var clUsrApp       = <%=Integer.parseInt(StrclUsrApp)%>
                var detExpediente = '';
                
                /**EXTRACCION**/
                if ( document.all.dsSubservicio.value.toString() === 'Extracción' ) {
                    clUbicacionAuto       =(document.all.clUbicacionAutoC.value ==null || document.all.clUbicacionAutoC.value =='')?0:document.all.clUbicacionAutoC.value;
                    clUbicacionAutoGaraje =(document.all.clUbicacionAutoGarajeC.value == null || document.all.clUbicacionAutoGarajeC.value == '' )?0:document.all.clUbicacionAutoGarajeC.value;
                    lugarEncajado         =(document.all.lugarEncajadoC.value==null || document.all.lugarEncajadoC.value=='')?0:document.all.lugarEncajadoC.value;
                    aNivelAbierto         =(document.all.aNivelAbiertoC.value==null || document.all.aNivelAbiertoC.value=='')?0:document.all.aNivelAbiertoC.value;
                    nivelSubsuelo         =(document.all.nivelSubsueloC.value==null || document.all.nivelSubsueloC.value=='')?0:document.all.nivelSubsueloC.value;
                    automatico            =document.all.automatico.value==null?'':document.all.automatico.value;
                    ruedaBloqueada        =document.all.ruedaBloqueada.value==null?'':document.all.ruedaBloqueada.value;
                    ruedasDuales          =document.all.ruedasDuales.value==null?'':document.all.ruedasDuales.value;
                    estadoVehiculo        =document.all.estadoVehiculo.value==null?'':document.all.estadoVehiculo.value;
                    distTierraFirme       =(document.all.distTierraFirme.value==null)?'':document.all.distTierraFirme.value;

                    /*Ruedas bloqueadas*/
                    delanteraIzq   = document.all.delanteraIzqC.checked?1:0;
                    delanteraDer   = document.all.delanteraDerC.checked?1:0;
                    traseraIzq     = document.all.traseraIzqC.checked?1:0;
                    traseraDer     = document.all.traseraDerC.checked?1:0;
                    cantBloqueadas = delanteraIzq+delanteraDer+traseraIzq+traseraDer;
                    
        

                    /*Valido los campos en general*/
                     fnValida();
                    /*Valido reglas*/

                    /*Si selecciona
                     * rueda bloqueada, al
                     * menos tiene que tener 
                     * una rueda.
                     */
                    if ( ruedaBloqueada.toString() === '' ) {
                        msgVal = msgVal + " Falta opción rueda bloqueada";
                    } else {
                        if ( ruedaBloqueada.toString() === '1'
                                && cantBloqueadas.toString() === '0' ) {
                            msgVal = msgVal + " Si tiene ruedas bloqueadas, debe seleccionar al menos una.";
                        }
                    }
                    
                    if ( automatico.toString() === '' ) {
                         msgVal = msgVal + " Falta opción automático";
                    }
                    
                    if ( ruedasDuales.toString() === '' ) {
                        msgVal = msgVal + " Falta opción ruedas duales";
                    }
                    
                    if ( servicioProgramado.toString() === '' ) {
                        msgVal = msgVal + " Falta opción servicio programado";
                    } else {
                        if ( servicioProgramado.toString() === '1') {
                            if (fechaProgramado.toString() === ' ') {
                                msgVal = msgVal + " Falta fecha programada";
                            }
                            if (horaDesdeProg.toString() === ' ') {
                                msgVal = msgVal + " Falta hora desde programada";
                            }
                            if (horaHastaProg.toString() === ' ') {
                                msgVal = msgVal + " Falta hora hasta programada";
                            }
                        }
                    }
                    /*
                     * Debe ingresar una
                     * ubicación
                     */
                     if ( clUbicacionAuto.toString() === '0' ) {
                        msgVal = msgVal + "Debe seleccionar una ubicacion";
                    }

                    /*Si eligen Garaje, tienen que 
                     * seleccionar al menos 
                     * una opcion de garaje
                     */
                    var comboboxu  = document.getElementById("clUbicacionAutoC");
                    var ubicacion = comboboxu.options[comboboxu.selectedIndex].text;
                    
                    if ( ubicacion.toString().toUpperCase() === 'ENCAJADO' || 
                        ubicacion.toString().toUpperCase() === 'ZANJA' ||
                        ubicacion.toString().toUpperCase() === 'POZO' ||
                        ubicacion.toString().toUpperCase() === 'VOLCADO' ) {
                    
                        if ( estadoVehiculo === ' ' || estadoVehiculo === '' ) {
                            msgVal = msgVal + "Debe ingresar el estado del vehículo";
                        }
                    }

                    if ( ubicacion.toString().toUpperCase() === 'GARAJE/ESTACIONAMIENTO' &&
                        clUbicacionAutoGaraje.toString() === '0'    ) {
                        msgVal = msgVal + "Debe seleccionar una ubicacion en garaje";
                    }


                    if ( ubicacion.toString().toUpperCase() === 'ENCAJADO' ) {
                        if ( document.all.lugarEncajadoC.value ==='' ) {
                            msgVal = msgVal + " Debe seleccionar una tipo de lugar encajado";
                        }
                        if ( isNaN(distTierraFirme.toString()) ) {
                            msgVal = msgVal + " Distancia tierra firme, solo números";
                        } else {
                            var valorDistancia = parseInt(distTierraFirme.toString());
                            if ( distTierraFirme.toString() ==='' ||
                                   (valorDistancia <1 && valorDistancia >32000) )  {
                                msgVal = msgVal + " Distancia tierra firme, valor entre 1 y 32000";
                            }
                        }

                    } else {
                        distTierraFirme = 0;
                    }
                    
                    /*Si selecciona a nivel
                     * o subsuelo, debe selecionar
                     * abierto/cerrado o un nivel
                     * de subsuelo, dependiendo de
                     * la opcion precedente
                     */
                    var comboboxug  = document.getElementById("clUbicacionAutoGarajeC");
                    var ubicacionDentroDelGaraje = comboboxug.options[comboboxug.selectedIndex].text;
                    if ( ubicacionDentroDelGaraje.toString().toUpperCase() === 'A NIVEL' &&
                        (document.all.aNivelAbiertoC.value ===null || 
                        document.all.aNivelAbiertoC.value.toString() ==='') ) {

                        msgVal = msgVal + "Debe seleccionar una ubicacion a nivel";

                    }

                    if ( ubicacionDentroDelGaraje.toString().toUpperCase() === 'SUBSUELO' &&
                        (document.all.nivelSubsueloC.value ===null || 
                        document.all.nivelSubsueloC.value.toString() ==='') 
                        ) {

                        msgVal = msgVal + "Debe seleccionar una ubicacion en subsuelo";
                    }



                    /*Si dió algún error, 
                     * salgo del método
                     */
                    if ( msgVal !== '') {
                        document.all.btnGuarda.disabled=false;
                        document.all.btnCancela.disabled=false;
                        return;
                    }
                    
                    /*Si no tiene errores, guardo la planilla
                    document.all.forma.action = "../../servlet/Utilerias.EjecutaAccionAsist";
                    document.all.forma.submit();*/
                     /*
                     * Control de cambios de la dirección
                     * solemente en el caso de 
                     * modificaciones
                     */
                     var cambio = <%=StrclInfoAdicKMO%>;
                     if ( cambio.toString() !== '0' ) {
                         var localOrigen = document.all.localidadOrigen.value;
                         var calleOrigen = document.all.calleOrigen.value;

                         var localOriNew  = document.all.dsMunDel.value;
                         var calleOriNew  = document.all.CalleNum.value;

                         var detCambiosDireccion = '';
                         if ( localOrigen.toString() !== localOriNew ) {
                             var localOrigenDet = localOrigen===''?'S/D':localOrigen;
                             var localOriNewDet = localOriNew===''?'S/D':localOriNew;
                             detCambiosDireccion = detCambiosDireccion.concat(' / CAMBIO LOC. ORIGEN: '+ localOrigenDet + " -> "+localOriNewDet);
                         }
                         if ( calleOrigen.toString() !== calleOriNew ) {
                             var calleOrigenDet = calleOrigen===''?'S/D':calleOrigen;
                             var calleOriNewDet = calleOriNew===''?'S/D':calleOriNew;
                             detCambiosDireccion = detCambiosDireccion.concat(' / CAMBIO CALLE ORIGEN: '+ calleOrigenDet + " -> "+calleOriNewDet);
                         }

                         if ( detCambiosDireccion !== '' ) {
                             cambiosOrigenDest = 'CAMBIO EN DIRECCIONES : ';
                             cambiosOrigenDest = cambiosOrigenDest.concat(detCambiosDireccion);
                         }

                     }
                   
                    /*Armo en mensaje con las
                    * observaciones que van a 
                    * al detalle de expediente
                    */
                    detExpediente = '[* UBICACION: ' + ubicacion;
                    if ( ubicacion.toString().toUpperCase() === 'GARAJE/ESTACIONAMIENTO' ) {
                       var comboboxug  = document.getElementById("clUbicacionAutoGarajeC");
                       var ubicacionDentroDelGaraje = comboboxug.options[comboboxug.selectedIndex].text;
                       detExpediente = detExpediente.concat(' - ' + ubicacionDentroDelGaraje);

                       if ( ubicacionDentroDelGaraje.toString().toUpperCase() === 'A NIVEL' ) {
                           var combo = document.getElementById("aNivelAbiertoC");
                           var str = combo.options[combo.selectedIndex].text;
                           detExpediente = detExpediente.concat(' (' +str+ ') ');
                       }

                       if ( ubicacionDentroDelGaraje.toString().toUpperCase() === 'SUBSUELO' ) {
                           var combo = document.getElementById("nivelSubsueloC");
                           var str = combo.options[combo.selectedIndex].text;
                           detExpediente = detExpediente.concat(' (' +str+') ');
                       }
                     
                    }
                    
                    if ( ubicacion.toString().toUpperCase() === 'ENCAJADO' ) {
                           var combo = document.getElementById("lugarEncajadoC");
                           var str = combo.options[combo.selectedIndex].text;
                           detExpediente = detExpediente.concat(' (' +str+') ');
                           detExpediente = detExpediente.concat(" - DIST PISO FIRME : " + distTierraFirme.toString() );
                    }
                    if ( ubicacion.toString().toUpperCase() === 'ENCAJADO' || 
                        ubicacion.toString().toUpperCase() === 'ZANJA' ||
                        ubicacion.toString().toUpperCase() === 'POZO' ||
                        ubicacion.toString().toUpperCase() === 'VOLCADO' ) {
                        detExpediente = detExpediente.concat(' -ESTADO DEL VH : ' + estadoVehiculo);
                    }
                    if (clTipoFalla > 0 ) {
                        var combo = document.getElementById("clTipoFallaC");
                        var str = combo.options[combo.selectedIndex].text;
                        detExpediente = detExpediente.concat(' - FALLA : ' +str);
                    }
                    
                    if ( automatico  === '1' ) {
                        detExpediente = detExpediente.concat(' -  CAJA AUTOMATICA ');
                    }
                    
                    if ( ruedasDuales === '1' ) {
                         detExpediente = detExpediente.concat(' - TIENE RUEDAS DUALES ');
                    }
                    
                    if ( ruedaBloqueada > 0 ) {
                        detExpediente = detExpediente.concat(' - RUEDAS BLOQUEADAS: ' );
                        if ( cantBloqueadas === 4 ) {
                            detExpediente = detExpediente.concat(' TODAS ' );
                        } else {
                            if ( delanteraIzq === 1 ) {
                                detExpediente = detExpediente.concat(' DI ' );
                            }
                            if ( delanteraDer === 1 ) {
                                detExpediente = detExpediente.concat(' DD ' );
                            }                        

                            if ( traseraIzq === 1 ) {
                                detExpediente = detExpediente.concat(' TI ' );
                            }                        

                            if ( traseraDer === 1 ) {
                                detExpediente = detExpediente.concat(' TD ' );
                            }                        

                        }

                    }
                    if ( servicioProgramado.toString() === '1') {
                        var FechaC = fechaProgramado.toString().substring(0, 10); 
                        detExpediente = detExpediente.concat(' - SERVICIO PROGRAMADO:' );
                        detExpediente = detExpediente.concat(' FECHA : ' + FechaC);
                        detExpediente = detExpediente.concat(' HORA DESDE : ' + horaDesdeProg);
                        detExpediente = detExpediente.concat(' HORA HASTA : ' + horaHastaProg);
                    }
                
                

                    detExpediente = detExpediente.concat(' *]');

                }                

               
                /**UML**/
                if ( document.all.dsSubservicio.value.toString() === 'UML' ) {
                    clUbicacionAuto       =(document.all.clUbicacionAutoUMLC.value ==null || document.all.clUbicacionAutoUMLC.value =='')?0:document.all.clUbicacionAutoUMLC.value;
                    clUbicacionAutoGaraje =(document.all.clUbicacionAutoGarajeUMLC.value == null || document.all.clUbicacionAutoGarajeUMLC.value == '' )?0:document.all.clUbicacionAutoGarajeUMLC.value;
                    aNivelAbierto         =(document.all.aNivelAbiertoUMLC.value==null || document.all.aNivelAbiertoUMLC.value=='')?0:document.all.aNivelAbiertoUMLC.value;
                    nivelSubsuelo         =(document.all.nivelSubsueloUMLC.value==null || document.all.nivelSubsueloUMLC.value=='')?0:document.all.nivelSubsueloUMLC.value;
                    clTipoFalla           =document.all.clTipoFallaUMLC.value==null?0:document.all.clTipoFallaUMLC.value;

                    lucesEncienden        =document.all.lucesEncienden.value==null?'':document.all.lucesEncienden.value;
                    compraBateria         =document.all.compraBateria.value==null?'':document.all.compraBateria.value;
                    ruedaAuxEnCond        =document.all.ruedaAuxEnCond.value==null?'':document.all.ruedaAuxEnCond.value;
                    tuercaSeguridad       =document.all.tuercaSeguridad.value==null?'':document.all.tuercaSeguridad.value;
                    llaveTuercaSeg        =document.all.llaveTuercaSeg.value==null?'':document.all.llaveTuercaSeg.value;
                    
                    clTipoGasolina        =(document.all.clTipoGasolinaC.value==null || document.all.clTipoGasolinaC.value =='')?0:document.all.clTipoGasolinaC.value;
                    clCantLitros          =(document.all.clCantLitrosC.value==null || document.all.clCantLitrosC.value =='')?0:document.all.clCantLitrosC.value;
                    ruedasDuales          = 0;
                    clEstacionamiento     =(document.all.clEstacionamientoUMLC.value==null || document.all.clEstacionamientoUMLC.value=='')?0:document.all.clEstacionamientoUMLC.value;
                    distTierraFirme       = 0;
                    /*Valido los campos en general*/
                     fnValida();
                    /*Valido reglas*/
                    if ( servicioProgramado.toString() === '' ) {
                        msgVal = msgVal + " Falta opción servicio programado";
                    } else {
                        if ( servicioProgramado.toString() === '1') {
                            if (fechaProgramado.toString() === ' ') {
                                msgVal = msgVal + " Falta fecha programada";
                            }
                            if (horaDesdeProg.toString() === ' ') {
                                msgVal = msgVal + " Falta hora desde programada";
                            }
                            if (horaHastaProg.toString() === ' ') {
                                msgVal = msgVal + " Falta hora hasta programada";
                            }
                        }
                    }
                    /*
                     * Debe ingresar una
                     * ubicación
                     */
                     if ( clUbicacionAuto.toString() === '0' ) {
                        msgVal = msgVal + "Debe seleccionar una ubicacion";
                     }

                    /*Si eligen Garaje, tienen que 
                     * seleccionar al menos 
                     * una opcion de garaje
                     */
                    var comboboxu  = document.getElementById("clUbicacionAutoUMLC");
                    var ubicacion = comboboxu.options[comboboxu.selectedIndex].text;

                    if ( ubicacion.toString().toUpperCase() === 'AUTOPISTA' &&
                        clEstacionamiento.toString() === '0'    ) {
                        msgVal = msgVal + "Debe seleccionar un estacionamiento";
                    }
                    
                    if ( ubicacion.toString().toUpperCase() === 'GARAJE/ESTACIONAMIENTO' &&
                        clUbicacionAutoGaraje.toString() === '0'    ) {
                        msgVal = msgVal + "Debe seleccionar una ubicacion en garaje";
                    }


                    /*Si selecciona a nivel
                     * o subsuelo, debe selecionar
                     * abierto/cerrado o un nivel
                     * de subsuelo, dependiendo de
                     * la opcion precedente
                     */
                    var comboboxug  = document.getElementById("clUbicacionAutoGarajeUMLC");
                    var ubicacionDentroDelGaraje = comboboxug.options[comboboxug.selectedIndex].text;
                    if ( ubicacionDentroDelGaraje.toString().toUpperCase() === 'A NIVEL' &&
                        (document.all.aNivelAbiertoUMLC.value ===null || 
                        document.all.aNivelAbiertoUMLC.value.toString() ==='') ) {

                        msgVal = msgVal + "Debe seleccionar una ubicacion a nivel";

                    }

                    if ( ubicacionDentroDelGaraje.toString().toUpperCase() === 'SUBSUELO' &&
                        (document.all.nivelSubsueloUMLC.value ===null || 
                        document.all.nivelSubsueloUMLC.value.toString() ==='') 
                        ) {

                        msgVal = msgVal + "Debe seleccionar una ubicacion en subsuelo";
                    }

                    /*Control de tipo de falla*/
                    if ( clTipoFalla.toString() === '0' || clTipoFalla.toString() === '' ) {
                        msgVal = msgVal + "Debe seleccionar un tipo de falla";
                    }
                    var combobox  = document.getElementById("clTipoFallaUMLC");
                    var tipoFalla = combobox.options[combobox.selectedIndex].text;
                    
                    if ( tipoFalla.toString().toUpperCase() === 'SIN BATERÍA') {
                        ruedaAuxEnCond = 0;
                        tuercaSeguridad= 0;
                        llaveTuercaSeg = 0;
                        
                        if ( document.all.lucesEncienden.value ==null || document.all.lucesEncienden.value =='' ) {
                            msgVal = msgVal + "Debe seleccionar opción luces";
                        }
                        if ( document.all.compraBateria.value ==null || document.all.compraBateria.value =='' ) {
                            msgVal = msgVal + "Debe seleccionar opción compra bateria";
                        }
                    } 
                
                    if ( tipoFalla.toString().toUpperCase() === 'CAMBIO DE NEUMÁTICO') {
                        lucesEncienden = 0;
                        compraBateria  = 0;
                        if ( document.all.ruedaAuxEnCond.value==null || document.all.ruedaAuxEnCond.value=='' ) {
                            msgVal = msgVal + "Debe seleccionar si tiene rueda de auxilio en condiciones";
                        }
                        if ( ruedaAuxEnCond.toString() === '1' ) {
                            if ( document.all.tuercaSeguridad.value==null || document.all.tuercaSeguridad.value=='' ) {
                                msgVal = msgVal + "Debe seleccionar si tiene tuerca de seguridad";
                            }
                            if ( tuercaSeguridad.toString() === '1' ) {
                                if ( document.all.llaveTuercaSeg.value==null || document.all.llaveTuercaSeg.value=='' ) {
                                    msgVal = msgVal + "Debe seleccionar si tiene llave para tuerca de seguridad";
                                }
                            } else {
                                llaveTuercaSeg =0;
                            }
                        } else {
                            tuercaSeguridad= 0;
                            llaveTuercaSeg = 0;
                        }
                    } 
                
                    if ( tipoFalla.toString().toUpperCase() === 'SUMINISTRO DE COMBUSTIBLE') {
                        ruedaAuxEnCond = 0;
                        tuercaSeguridad= 0;
                        llaveTuercaSeg = 0;
                        lucesEncienden = 0;
                        compraBateria  = 0;
                        var elementTG = document.getElementById("clTipoGasolinaC");
                        var elementCL= document.getElementById("clCantLitrosC");
                        if ( elementTG.value.toString() === '0' || elementTG.value.toString() === '') {
                             msgVal = msgVal + "Debe seleccionar tipo de gasolina";
                        }
                        
                        if ( elementCL.value.toString() === '0' || elementCL.value.toString() === '') {
                             msgVal = msgVal + "Debe seleccionar cantidad de litros";
                        }
                    } 


                    /*Si dió algún error, 
                     * salgo del método
                     */
                    if ( msgVal !== '') {
                        document.all.btnGuarda.disabled=false;
                        document.all.btnCancela.disabled=false;
                        return;
                    }
                    
                    /*Si no tiene errores, guardo la planilla
                    document.all.forma.action = "../../servlet/Utilerias.EjecutaAccionAsist";
                    document.all.forma.submit();*/
                    /*
                     * Control de cambios de la dirección
                     * solemente en el caso de 
                     * modificaciones
                     */
                     var cambio = <%=StrclInfoAdicKMO%>;
                     if ( cambio.toString() !== '0' ) {
                         var localOrigen = document.all.localidadOrigen.value;
                         var calleOrigen = document.all.calleOrigen.value;

                         var localOriNew  = document.all.dsMunDel.value;
                         var calleOriNew  = document.all.CalleNum.value;

                         var detCambiosDireccion = '';
                         if ( localOrigen.toString() !== localOriNew.toString() ) {
                             var localOrigenDet = localOrigen===''?'S/D':localOrigen;
                             var localOriNewDet = localOriNew===''?'S/D':localOriNew;
                             detCambiosDireccion = detCambiosDireccion.concat(' / CAMBIO LOC. ORIGEN: '+ localOrigenDet + " -> "+localOriNewDet);
                         }
                         if ( calleOrigen.toString() !== calleOriNew.toString() ) {
                             var calleOrigenDet = calleOrigen===''?'S/D':calleOrigen;
                             var calleOriNewDet = calleOriNew===''?'S/D':calleOriNew;
                             detCambiosDireccion = detCambiosDireccion.concat(' / CAMBIO CALLE ORIGEN: '+ calleOrigenDet + " -> "+calleOriNewDet);
                         }

                         if ( detCambiosDireccion !== '' ) {
                             cambiosOrigenDest = 'CAMBIO EN DIRECCIONES : ';
                             cambiosOrigenDest = cambiosOrigenDest.concat(detCambiosDireccion);
                         }

                     }
                    
                    /*Armo en mensaje con las
                    * observaciones que van a 
                    * al detalle de expediente
                    */
                    detExpediente = '[* UBICACION: ' + ubicacion;
                    
                    if ( ubicacion.toString().toUpperCase() === 'AUTOPISTA' ) {
                        var comboboxes  = document.getElementById("clEstacionamientoUMLC");
                        var estacionadoEn = comboboxes.options[comboboxes.selectedIndex].text;
                        detExpediente = detExpediente.concat(' - ' + estacionadoEn);
                    }
                    
                    if ( ubicacion.toString().toUpperCase() === 'GARAJE/ESTACIONAMIENTO' ) {
                       var comboboxug  = document.getElementById("clUbicacionAutoGarajeUMLC");
                       var ubicacionDentroDelGaraje = comboboxug.options[comboboxug.selectedIndex].text;
                       detExpediente = detExpediente.concat(' - ' + ubicacionDentroDelGaraje);

                       if ( ubicacionDentroDelGaraje.toString().toUpperCase() === 'A NIVEL' ) {
                           var combo = document.getElementById("aNivelAbiertoUMLC");
                           var str = combo.options[combo.selectedIndex].text;
                           detExpediente = detExpediente.concat(' (' +str+ ') ');
                       }

                       if ( ubicacionDentroDelGaraje.toString().toUpperCase() === 'SUBSUELO' ) {
                           var combo = document.getElementById("nivelSubsueloUMLC");
                           var str = combo.options[combo.selectedIndex].text;
                           detExpediente = detExpediente.concat(' (' +str+') ');
                       }
                    }

                    var combo = document.getElementById("clTipoFallaUMLC");
                    var str0 = combo.options[combo.selectedIndex].text;
                    detExpediente = detExpediente.concat(' - FALLA : ' +str0);
                   
                    if ( tipoFalla.toString().toUpperCase() === 'SIN BATERÍA') {
                        detExpediente = document.all.lucesEncienden.value==1?detExpediente.concat(' - LUCES ENCIENDEN '):detExpediente.concat(' - LUCES NO ENCIENDEN ');
                        detExpediente = document.all.compraBateria.value==1?detExpediente.concat(' - COMPRA BATERIA '):detExpediente.concat(' - NO COMPRA BATERIA ');
                    } 
                
                    if ( tipoFalla.toString().toUpperCase() === 'CAMBIO DE NEUMÁTICO') {
                        detExpediente = document.all.ruedaAuxEnCond.value==1?detExpediente.concat(' - RUEDA AUX EN COND. '):detExpediente.concat(' - RUEDA AUX NO ESTA EN COND. ');
                        detExpediente = document.all.tuercaSeguridad.value==1?detExpediente.concat(' - TIENE TUERCA DE SEG. '):detExpediente.concat(' - NO TIENE TUERCA DE SEG. ');
                        if ( tuercaSeguridad.toString() === '1' ) {
                            detExpediente = document.all.llaveTuercaSeg.value==1?detExpediente.concat(' - TIENE LLAVE TUERCA DE SEG. '):detExpediente.concat(' - TIENE LLAVE TUERCA DE SEG. ');
                        }
                    } 
                
                    if ( tipoFalla.toString().toUpperCase() === 'SUMINISTRO DE COMBUSTIBLE') {
                        var combo1 = document.getElementById("clTipoGasolinaC");
                        var str1 = combo1.options[combo1.selectedIndex].text;
                        detExpediente = detExpediente.concat(' - TIPO : ' + str1);
                        
                        var combo2 = document.getElementById("clCantLitrosC");
                        var str2 = combo2.options[combo2.selectedIndex].text;
                        detExpediente = detExpediente.concat(' - CANT. LITROS : ' + str2);

                    } 
                    
                    if ( servicioProgramado.toString() === '1') {
                        var FechaC = fechaProgramado.toString().substring(0, 10); 
                        detExpediente = detExpediente.concat(' - SERVICIO PROGRAMADO:' );
                        detExpediente = detExpediente.concat(' FECHA : ' + FechaC);
                        detExpediente = detExpediente.concat(' HORA DESDE : ' + horaDesdeProg);
                        detExpediente = detExpediente.concat(' HORA HASTA : ' + horaHastaProg);
                    }
                
                    detExpediente = detExpediente.concat(' *]');

                }                
    
    
    
                /*Guardo datos*/
		var datos ={	
                clInfoAdicKMO : clInfoAdicKMO ,
		clExpediente : clExpediente,
		clUbicacionAuto :clUbicacionAuto ,
		clUbicacionAutoGaraje : clUbicacionAutoGaraje ,
		aNivelAbierto : aNivelAbierto ,
		nivelSubsuelo : nivelSubsuelo ,
		clTipoFalla : clTipoFalla ,
		detalleFalla : detalleFalla ,
		automatico : automatico ,
		ruedaBloqueada : ruedaBloqueada ,
		cantBloqueadas : cantBloqueadas ,
		delanteraIzq : delanteraIzq ,
		delanteraDer : delanteraDer ,
		traseraIzq : traseraIzq ,
		traseraDer : traseraDer ,
		tieneCarga : tieneCarga ,
		pesoCarga : pesoCarga ,
		tipoCarga : tipoCarga ,
		clCantPersona : clCantPersona ,
		cedulaVerdeVig : cedulaVerdeVig ,
		recibeNombre : recibeNombre ,
		recibeCodArea : recibeCodArea ,
		recibeNroTelef : recibeNroTelef ,
		clModifAuto : clModifAuto ,
		distanciaPiso : distanciaPiso ,
		largo : largo ,
		alto : alto ,
		detalleModif : detalleModif ,
		ruedasDuales : ruedasDuales ,
                lugarEncajado : lugarEncajado,
                lucesEncienden : lucesEncienden,
		ruedaAuxEnCond : ruedaAuxEnCond,
		tuercaSeguridad : tuercaSeguridad,
		llaveTuercaSeg : llaveTuercaSeg,
		clTipoGasolina : clTipoGasolina,
		clCantLitros : clCantLitros,
                detExpediente : detExpediente,
                vehiculoLiberado : vehiculoLiberado,
                clUsrApp : clUsrApp,
                estadoVehiculo : estadoVehiculo,
                distTierraFirme : distTierraFirme,
                compraBateria : compraBateria,
                servicioProgramado : servicioProgramado,
                fechaProgramado : fechaProgramado,
                horaDesdeProg : horaDesdeProg,
                horaHastaProg : horaHastaProg,
                peajesCubiertos : peajesCubiertos,
                montoCubierto : montoCubierto,
                clEstacionamiento: clEstacionamiento,
                cambiosOrigenDest: cambiosOrigenDest,
                kmAsistencia : kmAsistencia
            };
            $.when(
		$.ajax({
			type: "GET",
			url: "./InsertInfoAdicionalKM0.jsp",
			//crossDomain: false,
			//cache: false,
                        async:false,
			data: datos,
			dataType: 'json',
			success: function(responseData, status, xhr) {
                        var nuevaClave = responseData.clave.toString();
                        
                        if ( clInfoAdicKMO.toString() === '0' ) {
                            //console.log('NUEVO REGISTRO : ' + nuevaClave);
                            document.all.clInfoAdicKMO.value = nuevaClave;
                        } else {
                            //console.log('REGISTRO EXISTENTE : ' + nuevaClave);
                        }
                            
			},
			error: function(req, status, error) {
				
				if ( req.status === 413 ) {
					alert("Largo de "+error+" inválido.");
				}
				if ( req.status === 403 ) {
					alert("Código de "+error+" inválido.Debe verificar el dato ingresado.");
				}
				if ( req.status === 500 ) {
					alert("Error grabando InfoAdicional: " + error);
				}
			}
		})).then( successFunc(), failureFunc() );
	
            }            

          
            
        </script>
        <!-- script async defer src="//maps.googleapis.com/maps/api/js?libraries=places&key=<//%=//ar.com.ike.geo.Geolocalizacion.GOOGLE_API_KEY%>&callback=initMap" / -->
    </body>
    <%
        rs.close();
        rsDatosAfil.close();
        daoAV = null;
        AV = null;
        rs = null;
    %>
</html>
