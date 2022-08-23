<%@page import="com.ike.asistencias.to.InfoAdicionalKM0"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="com.ike.asistencias.DAOAsistenciaVial,com.ike.asistencias.to.AsistenciaVial,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<%@ page import="ar.com.ike.geo.Geolocalizacion" %>
<%@ page import="java.sql.ResultSet" %>

<html>
    <head>
        <title>ArrastreGrua</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/ModalDialog.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
        
    </head>
    <body class="cssBody" >
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAuto.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilCalendario.js'></script>
        <script type="text/javascript" src="../../Geolocalizacion/modernizr-custom.js"></script>
        <script type="text/javascript" src="../../Geolocalizacion/js/jquery.js"></script>
        <script type="text/javascript" src="../../Geolocalizacion/js/mapUtils.js"></script>
        <script type="text/javascript" src='../../Utilerias/v1/validaciones.js'></script>
        <script type="text/javascript" src='../../Utilerias/v1/Bootstrap/respond.min.js'></script>
        <!-- BIBLIOTECAS AJAX -->
        <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>            
 
        <%
            System.out.println("Arrastre Grua. Paso 1");
            String StrclUsrApp = "0";
            String StrclExpediente = "0";
            String StrclPaginaWeb = "186";
            String StrclInfoAdicKMO = "0";
            String StrclSubServicio = session.getAttribute("clSubServicio").toString();
            
            //  DATOS DE LA UBICACION ORIGEN, VIENEN DEL EXPEDIENTE EN SESION
            String StrclPais = "";
            String StrdsPais = "";
            String StrdsEntFed = "";
            String StrCodEnt = "";
            String StrdsMunDel = "";
            String StrCodMD = "";

            //  DATOS DE LA UBICACION DESTINO
            String StrclPaisDest = "";
            String StrdsEntFedDest = "";
            String StrCodEntDest = "";
            String StrdsMunDelDest = "";
            String StrCodMDDest = "";

            String StrclMarcaAuto = "0";
            String StrclCuenta = "0";
            String StrClave = "";

            //  DATOS DEL AFILIADO
            String StrCalleNum = "";
            String StrModelo = "";
            String StrColor = "";
            String StrPlacas = "";
            String StrDescAuto = "";

            // DATOS DEL AUTO INFOAUTO
            String StrCodigoMarca = "";
            String StrClaveAMIS = "";
            String StrDsTipoAuto = "";
            
            // DATOS GEO
            String sLatLong="";
            String sLatLongDest="";

            // DATOS ADICIONALES
		String clUbicacionAuto="";
		String clUbicacionAutoGaraje="";
		String aNivelAbierto="";
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
                String vehiculoLiberado = "";
                String servicioProgramado="";
                String estadoVehiculo    = "";
                String distTierraFirme   = "";
                String compraBateria     = "";
                String fechaProgramado   = "";
                String horaDesdeProg     = "";
                String horaHastaProg     = "";
                String peajesCubiertos   = "";
                Boolean coberturaTotalPeaje = false;
                String montoCubierto     = "";
                String clEstacionamiento = "";
                String kmAsistencia      = "";
                
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

            ResultSet cdr = UtileriasBDF.rsSQLNP( "sp_DetalleExpediente " + StrclExpediente );
            if (cdr.next()) {
                StrCodEnt   = cdr.getString("CodEnt");
                StrdsEntFed = cdr.getString("dsEntFed");
                StrCodMD    = cdr.getString("CodMD");
                StrdsMunDel = cdr.getString("dsMunDel");
                
                //Se obtienen desde la base y no desde session. verificar:
                StrclCuenta = cdr.getString("clCuenta");
                StrClave = cdr.getString("Clave");
                
                cdr.close();
                cdr = null;
            }
            else {
                out.println("ERROR NO SE PUEDE OBTENER DATOS DEL EXPEDIENTE");
                return;
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %>Fuera de Horario<%
                return;
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
                sLatLong = AV!=null ? AV.getGeoLatLong() :"";
                //  DATOS DE LA UBICACION DESTINO
                StrclPaisDest = AV != null ? AV.getClPaisD() : "0";
                StrCodEntDest = AV != null ? AV.getCodEntD() : "";
                StrdsMunDelDest = AV != null ? AV.getDsMunDelD() : "";
                StrdsEntFedDest = AV != null ? AV.getDsEntFedD() : "";
                StrCodMDDest = AV != null ? AV.getCodMDD() : "";
                sLatLongDest = AV!=null ? AV.getGeoLatLongD() :"";
                StrclMarcaAuto = AV != null ? AV.getClMarca() : "0";
                if (StrclPaisDest.equalsIgnoreCase("")) {
                    StrclPaisDest = "10";
                }

                /** Si tiene información adicional,
                 realizo la lectura
                */
                if ( AV != null && AV.getClInfoAdicKMO() > 0 ) {
                    StrclInfoAdicKMO = String.valueOf(AV.getClInfoAdicKMO());
                    infoAdicAV = daoAV.getInfoAdicAsistenciaVial( String.valueOf( AV.getClInfoAdicKMO() ) );
                    System.out.println(infoAdicAV);

                } else {
                    StrclInfoAdicKMO = "0";
                    System.out.println("Sin datos asociados");
                }
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
	clTipoFalla = (infoAdicAV != null?String.valueOf(infoAdicAV.getClTipoFalla()) :"");
	detalleFalla = (infoAdicAV != null?infoAdicAV.getDetalleFalla() :"");
	automatico = (infoAdicAV != null?String.valueOf(infoAdicAV.getAutomatico()) :"");
	ruedaBloqueada = (infoAdicAV != null?String.valueOf(infoAdicAV.getRuedaBloqueada()) :"");
	cantBloqueadas = (infoAdicAV != null?String.valueOf(infoAdicAV.getCantBloqueadas()) :"");
	tieneCarga = (infoAdicAV != null?String.valueOf(infoAdicAV.getTieneCarga()) :"");
        vehiculoLiberado = (infoAdicAV != null?String.valueOf(infoAdicAV.getVehiculoLiberado())  :"");


	clCantPersona = (infoAdicAV != null?String.valueOf(infoAdicAV.getClCantPersona()) :"");
	cedulaVerdeVig = (infoAdicAV != null?String.valueOf(infoAdicAV.getCedulaVerdeVig()) :"");
	ruedasDuales = (infoAdicAV != null?String.valueOf(infoAdicAV.getRuedasDuales()) :"");
        dsUbicacionAuto = (infoAdicAV != null?infoAdicAV.getDsUbicacionAuto() :"");
        dsUbicacionAutoGaraje = (infoAdicAV != null?infoAdicAV.getDsUbicacionAutoGaraje():"");
        if ( infoAdicAV != null ) {
            if ( infoAdicAV.getClModifAuto() > 0 ) {
                tieneModif = "1";
            } else {
                tieneModif = "0";
            }
        } 
        servicioProgramado  = (infoAdicAV != null?String.valueOf(infoAdicAV.getServicioProgramado()) :"");
        fechaProgramado     = (infoAdicAV != null?String.valueOf(infoAdicAV.getFechaProgramado()) :"");
        horaDesdeProg       = (infoAdicAV != null?String.valueOf(infoAdicAV.getHoraDesdeProg()) :"");
        horaHastaProg       = (infoAdicAV != null?String.valueOf(infoAdicAV.getHoraHastaProg()) :"");
        clEstacionamiento   = (infoAdicAV != null?String.valueOf(infoAdicAV.getClEstacionamiento()) :"");
  //    peajesCubiertos     = (infoAdicAV != null?String.valueOf(infoAdicAV.getPeajesCubiertos() ) :"");
  //    CoberturaTotalPeaje = (infoAdicAV != null?String.valueOf(infoAdicAV.getCoberturaTotalPeaje() ) :"");
  //    montoCubierto       = (infoAdicAV != null?String.valueOf(infoAdicAV.getMontoCubierto() ) :"");
        kmAsistencia        = (infoAdicAV != null?String.valueOf(infoAdicAV.getKmAsistencia() ) :"");

        StrSql.append(" st_getDatosAfiliadoGral '").append(StrClave).append("','").append(StrclCuenta).append("'");
            System.out.println(StrSql);
            ResultSet rsDatosAfil = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            if (rsDatosAfil.next()) {
                StrCalleNum = rsDatosAfil.getString("callenum");
                StrModelo = rsDatosAfil.getString("anio");
                StrColor = rsDatosAfil.getString("color");
                StrPlacas = rsDatosAfil.getString("placas");
                StrDescAuto = rsDatosAfil.getString("descauto");
                StrCodigoMarca = rsDatosAfil.getString("CodigoMarca");
                StrClaveAMIS = rsDatosAfil.getString("ClaveAMIS");
                StrDsTipoAuto = rsDatosAfil.getString("DsTipoAuto");
            }

            StrSql.append("st_getInfoCoberturaPeaje '").append(StrclCuenta).append("'");
            System.out.println(StrSql);
            ResultSet rsDatosPeajeCubiertos = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rsDatosPeajeCubiertos.next()) {
                coberturaTotalPeaje = rsDatosPeajeCubiertos.getBoolean("CoberturaTotalPeaje");
                montoCubierto = rsDatosPeajeCubiertos.getString("MontoCubiertoPeaje");
                peajesCubiertos = coberturaTotalPeaje || Integer.parseInt(montoCubierto) > 0 ? "1" : "0" ;
            }

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            String sTmpDirA = ( StrdsEntFed.equals("") && StrdsMunDel.equals("") ? "": StrdsEntFed + ", " + StrdsMunDel + ", " + (AV != null ? AV.getCalleO() : "") );
        %>
        <script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(186, Integer.parseInt(StrclUsrApp));
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
                strMenu.append("fnValLugar();fnLlenaComboAuto();fnHabilitar();");
                strMenu.append("\" ></input><input");

                if (MyUtil.blnAccess[blnCambio] == false) {
                    strMenu.append(" disabled=true ");
                }

                strMenu.append(" type=\"button\" id=\"btnCambio\" value=\"Cambio\" onClick=\"this.disabled=true;document.all.Action.value=2;document.all.btnGuarda.disabled=false;document.all.btnCancela.disabled=false;document.all.btnAlta.disabled=true;document.all.btnElimina.disabled=true;fnHabilitaC();");
                strMenu.append("fnHabilitar();");
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
            //MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "fnValLugar();fnLlenaComboAuto();fnHabilitar();","fnHabilitar();", "fnGuardarInfoAdicional();")
        %>
        <input id="btnCob" name="btnCob" class='cBtn' type='button' value='Cobertura' onClick="fnMuestraCoberturas();">

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="ArrastreGrua.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='clInfoAdicKMO' name='clInfoAdicKMO' type='hidden' value='<%=StrclInfoAdicKMO%>'>
        <% 
            String tmpCalleOri = (AV!=null?AV.getCalleO():"");
            int iRowPx = 80; 
            int coordYImagen = 0; 
            int coordXImagen = 590;
        %>
        <!-- PLANTILLA ARRIBA -->
       <%
        //230
        iRowPx = iRowPx + 10;
        %>
         <%=MyUtil.ObjInput("Modelo", "Modelo", AV != null ? AV.getModelo() : "", true, true, 300, iRowPx, StrModelo, true, true, 6, "if(this.readOnly==false){fnValidaModelo(this)}")%>
        <%=MyUtil.ObjInput("Color", "Color", AV != null ? AV.getColor() : "", true, true, 380, iRowPx, StrColor, true, true, 10)%>
        <%=MyUtil.ObjInput("Patente", "Placas", AV != null ? AV.getPatente() : "", true, true, 480, iRowPx, StrPlacas, true, true, 8)%>

        <%
        iRowPx = iRowPx + 38;
        %>
         <%=MyUtil.ObjComboC("Marca de Auto", "CodigoMarca", AV != null ? AV.getDsMarca() : "", true, true, 35, iRowPx -38, StrCodigoMarca, "st_getMarcaAutoKM " + StrclExpediente, "fnLlenaTipoAutoAjax(this.value,'ClaveAMIS','Tipo de Auto','TipoAutoDiv','',2);", "", 50, true, false)%>
        <%=MyUtil.ObjComboCDiv("Tipo de Auto", "ClaveAMIS", AV != null ? AV.getDsTipoAuto() : "", true, true, 35, iRowPx, "", "st_getTipoAutoKM '" + StrclMarcaAuto + "'," + StrclExpediente, "", "", 9550, true, false, "TipoAutoDiv")%>
        <%=MyUtil.ObjComboC("Lugar", "clLugarEvento", AV != null ? AV.getDsLugar() : "", false, false, 420, iRowPx, "", "select clLugarEvento, dsLugarEvento from cLugarEvento order by dsLugarEvento", "", "", 20, false, false)%>
        <INPUT id='ClaveAMISVTR' name='ClaveAMISVTR' type='hidden' value=''>
        
 
        <%
        iRowPx = iRowPx + 38;
        %>
        <%=MyUtil.ObjComboC("¿Dónde se encuentra el vehículo?", "clUbicacionAuto", infoAdicAV != null ? infoAdicAV.getDsUbicacionAuto() : "", true, true, 35, iRowPx , "", "st_ListaUbicAutoMovida 0", "fnCambiaUbicacion(this.value);fnCartelAutopista();fnCartelRuta();", "", 50, true, false)%>
        <div id="divGaraje"  style="visibility: 'hidden'">
            <%=MyUtil.ObjComboC("Garage", "clUbicacionAutoGaraje", infoAdicAV != null ? infoAdicAV.getDsUbicacionAutoGaraje() : "", true, true, 255, iRowPx , "", "st_ListaUbicAutoMovida 1", "fnSeteaUbicacion(this.value);", "", 50, false, false)%>
            <div id="divSubsuelo"  style="visibility: 'hidden'">
                <%=MyUtil.ObjComboC("Subsuelo", "nivelSubsuelo", infoAdicAV != null ? String.valueOf(infoAdicAV.getNivelSubsuelo()) : "", true, true, 455, iRowPx , "", "st_constNivelSubsuelo", "fnSeteaNivel(this.value);", "", 50, false, false)%>
            </div>
            
            <div id="divANivel"  style="visibility: 'hidden'">
                <%=MyUtil.ObjComboC("A nivel", "aNivelAbierto", infoAdicAV != null ? (infoAdicAV.getaNivelAbierto()==0?"ABIERTO":"CERRADO") : "", true, true, 455, iRowPx , "", "st_constANivelEstado", "fnAbiertoCerrado(this.value);", "", 50, false, false)%>
            </div>
        </div>
        <div id="divEstacionamiento"  style="visibility: 'hidden'">
            <%=MyUtil.ObjComboC("Estacionamiento", "clEstacionamiento", (infoAdicAV != null) ?(infoAdicAV.getClEstacionamiento()==1?"PEAJE":(infoAdicAV.getClEstacionamiento()==2?"ESTACION DE SERVICIO":"SOBRE AUTOPISTA")): "", true, true, 255, iRowPx , "", "st_constEstacionamiento", "", "", 50, false, false)%>
        </div>
        <%
        iRowPx = iRowPx + 38;
        %>

        <%=MyUtil.ObjComboC("Qué falla tiene el vehículo", "clTipoFalla", infoAdicAV != null ? infoAdicAV.getDsTipoFalla() : "", true, true, 35, iRowPx , "", "st_ListaTipoFallaMovida", "fnFallaVehiculo(this.value);", "", 50, true, false)%>
        
        <div id="divAutomatico" class='VTable' style='position:absolute; z-index:100; left:263px; top:<%= iRowPx%>px; ' >
            <p style="display: inline; text-align: left; width:auto; ">¿El vehículo es automático?&nbsp;&nbsp;</p>
            <input class='VTable' id="esAutomatico" type="radio"  name="chkAutomatico" value="1"  onclick="fnValorRadioAutoManual();document.all.automatico.value=this.value;">SI
            <input class='VTable' id="esManual"     type="radio"  name="chkAutomatico" value="0"  onclick="fnValorRadioAutoManual();document.all.automatico.value=this.value;">NO
            <input type="hidden" name="automatico" id="automatico" value="<%=automatico%>" >
        </div> 
        <%
        iRowPx = iRowPx + 38;
        %>
        <div id="divTipoFalla"  style="visibility: 'hidden'">    
        <%=MyUtil.ObjTextArea("Detalle de falla", "detalleFalla", infoAdicAV != null ? infoAdicAV.getDetalleFalla() : "", "35", "2", true, true, 35, iRowPx, "", false, false)%>
        </div>
        <div id="divVehiculoLiberadoAccidente"  style="visibility: 'hidden'">    
            <div id="divVehiculoLiberado" class='VTable' style='position:absolute; z-index:100; left:35px; top:<%= iRowPx%>px; ' >
                <p style="display: inline; text-align: left; width:auto; ">¿El vehículo esta liberado?&nbsp;&nbsp;</p>
                <input class='VTable' id="liberado" type="radio"  name="chkLiberado" value="1"  onclick="document.all.vehiculoLiberado.value=this.value;fnLiberado(this.value);">SI
                <input class='VTable' id="noLiberado" type="radio"  name="chkLiberado" value="0"  onclick="document.all.vehiculoLiberado.value=this.value;fnLiberado(this.value);">NO
                <input type="hidden" name="vehiculoLiberado" id="vehiculoLiberado" value="<%=vehiculoLiberado%>" >
            </div> 
        </div>
        <div id="divRuedaBloqueada" class='VTable' style='position:absolute; z-index:100; left:263px; top:<%= iRowPx %>px; ' >
            <p style="display: inline; text-align: left; width:auto; ">¿Hay una rueda bloqueada?&nbsp;&nbsp;</p>
            <input class='VTable' id="estaBloqueada"   type="radio"  name="chkBloqueada" value="1"  onclick="fnValorRadioBloqueada(this.value);document.all.ruedaBloqueada.value=this.value;">SI
            <input class='VTable' id="noEstaBloqueada" type="radio"  name="chkBloqueada" value="0"  onclick="fnValorRadioBloqueada(this.value);document.all.ruedaBloqueada.value=this.value;">NO
            <input class='VTable' id="todasBloqueadas" type="radio"  name="chkBloqueada" value="1"  onclick="fnValorRadioBloqueada(this.value);fnRuedaBloqueadaTodas();document.all.ruedaBloqueada.value=this.value;">TODAS
            <input type="hidden" name="ruedaBloqueada" id="ruedaBloqueada" value="<%=ruedaBloqueada%>" >
        </div> 
        
        <div id="divRuedasBloqueadas"  style="visibility: 'hidden'">     
            <%
                coordYImagen = iRowPx-10;
                coordXImagen = 575;
                %>
            <a id="carImage" name="ruedasBloqueadas" style="position: absolute; z-index: 555; left: <%= coordXImagen-40 %>px; top: <%= coordYImagen+25 %>px;">
                <img src="../../Imagenes/ruedasBloqueadas.png" width='140' height='80' alt="Ruedas Bloqueadas">
            </a>
            <%=MyUtil.ObjChkBox("DI", "delanteraIzq", infoAdicAV != null ? String.valueOf(infoAdicAV.getDelanteraIzq()) : "", true, true,coordXImagen+10-20 , coordYImagen, "",  "fnRuedaBloqueada();")%>
            <%=MyUtil.ObjChkBox("TI", "traseraIzq", infoAdicAV != null ? String.valueOf(infoAdicAV.getTraseraIzq()) : "", true, true,coordXImagen+80-20  , coordYImagen, "",  "fnRuedaBloqueada();")%>
            <%=MyUtil.ObjChkBox("DD", "delanteraDer", infoAdicAV != null ? String.valueOf(infoAdicAV.getDelanteraDer()) : "", true, true, coordXImagen+10-20, coordYImagen+110, "",  "fnRuedaBloqueada();")%>
            <%=MyUtil.ObjChkBox("TD", "traseraDer", infoAdicAV != null ? String.valueOf(infoAdicAV.getTraseraDer()) : "", true, true,coordXImagen+80-20  , coordYImagen+110, "",  "fnRuedaBloqueada();")%>

        </div>
        
        <!--SUBMODULO DATOS DE LA CARGA -->
        <%
        iRowPx = iRowPx + 78;
        %>
        <div id="divTieneCarga" class='VTable' style='position:absolute; z-index:100; left:35px; top:<%= iRowPx %>px; ' >
            <p style="display: inline; text-align: left; width:auto; ">¿Tiene carga?&nbsp;&nbsp;</p>
            <input class='VTable' id="siTieneCarga"   type="radio"  name="chkCarga" value="1"  onclick="fnValorRadioCarga(this.value);document.all.tieneCarga.value=this.value;">SI
            <input class='VTable' id="noTieneCarga"  type="radio"  name="chkCarga" value="0" onclick="fnValorRadioCarga(this.value);document.all.tieneCarga.value=this.value;">NO
            <input type="hidden" name="tieneCarga" id="tieneCarga" value="<%=tieneCarga%>" >
            
        </div> 
        <div id="divDatosCarga"  style="visibility: 'hidden'">
            <%=MyUtil.ObjInput("Peso Aprox. (Kg)", "pesoCarga", infoAdicAV != null ? String.valueOf(infoAdicAV.getPesoCarga() ) : "", true, true, 205, iRowPx, "", false, false, 5)%>  
            <%=MyUtil.ObjInput("Tipo de Carga", "tipoCarga", infoAdicAV != null ? infoAdicAV.getTipoCarga() : "", true, true, 315, iRowPx, "", false, false, 25)%>  
        </div>

        
        
        <!--SUBMODULO QUIEN RECIBE -->
        <%
        iRowPx = iRowPx + 58;
        %>
         <%=MyUtil.ObjComboC("Cuantas personas lo acompañan", "clCantPersona", infoAdicAV != null ? infoAdicAV.getDsCantPersona() : "", true, true, 35, iRowPx , "", "st_ListaCantidadPersonas", "fnCantPersonas();document.all.clCantPersona.value=this.value;", "", 50, true, false)%>
        <div id="divQuienRecibe"  style="visibility: 'hidden'">
            <%=MyUtil.ObjInput("Nombre quien recibe", "recibeNombre", infoAdicAV != null ? infoAdicAV.getRecibeNombre(): "", true, true, 255, iRowPx, "", true, true, 35)%>  
            <%=MyUtil.ObjInput("Teléfono quien recibe", "recibeCodArea", infoAdicAV != null ? String.valueOf(infoAdicAV.getRecibeCodArea()) : "", true, true, 475, iRowPx, "", true, true, 5)%>  
            <%=MyUtil.ObjInput(" ", "recibeNroTelef", infoAdicAV != null ? String.valueOf(infoAdicAV.getRecibeNroTelef()) : "", true, true, 525, iRowPx, "", true, true, 14)%>  
        </div>
        
        <%
        iRowPx = iRowPx + 38;
        %>
        <div id="divVigente"  style="visibility: 'hidden'">
            <div id="divCedulaVerde" class='VTable' style='position:absolute; z-index:100; left:35px; top:<%= iRowPx %>px; ' >
                <p style="display: inline; text-align: left; width:auto; ">¿La cédula verde está vigente?&nbsp;&nbsp;</p>
                <input class='VTable' id="estaVigente"   type="radio"  name="chkVigente" value="1"  onclick="fnCedulaVerde(this.value);document.all.cedulaVerdeVig.value=this.value;">SI
                <input class='VTable' id="noEstaVigente"  type="radio"  name="chkVigente" value="0" onclick="fnCedulaVerde(this.value);document.all.cedulaVerdeVig.value=this.value;">NO
                <input type="hidden" name="cedulaVerdeVig" id="cedulaVerdeVig" value="<%=cedulaVerdeVig%>" >
            </div> 
        </div>
                    <%
        iRowPx = iRowPx + 38;
        %>
        <div id="divRuedasDuales" class='VTable' style='position:absolute; z-index:100; left:335px; top:<%= iRowPx %>px; ' >
            <p style="display: inline; text-align: left; width:auto; ">¿Tiene ruedas duales?&nbsp;&nbsp;</p>
            <input class='VTable' id="tieneDuales"   type="radio"  name="chkDuales" value="1"  onclick="fnValorRadioDuales(this.value);document.all.ruedasDuales.value=this.value;">SI
            <input class='VTable' id="noTieneDuales"  type="radio"  name="chkDuales" value="0" onclick="fnValorRadioDuales(this.value);document.all.ruedasDuales.value=this.value;">NO
            <input type='hidden' name='ruedasDuales' id='ruedasDuales' value="<%=ruedasDuales%>" >
        </div> 
        
        <!--SUBMODULO MOFIDICACIONES VEHÍCULO -->
        <div id="divModificacionesVehiculo" class='VTable' style='position:absolute; z-index:100; left:35px; top:<%= iRowPx %>px; ' >
            <p style="display: inline; text-align: left; width:auto; ">¿El vehículo tiene alguna modificación?&nbsp;&nbsp;</p>
            <input class='VTable' id="tieneModificaciones"   type="radio"  name="chkModifAuto" value="1"  onclick="fnValorRadioModificacion(this.value);document.all.tieneModif.value=this.value;">SI
            <input class='VTable' id="noTieneModificaciones"  type="radio"  name="chkModifAuto" value="0" onclick="fnValorRadioModificacion(this.value);document.all.tieneModif.value=this.value">NO
            <input type='hidden' name='tieneModif' id='tieneModif' value="<%=tieneModif%>" >
        </div> 
        <%
        iRowPx = iRowPx + 38;
        %>
        <div id="divModificaciones"  style="visibility: 'hidden'">
            <%=MyUtil.ObjComboC("¿Cuál es a modificación?", "clModifAuto", infoAdicAV != null ? infoAdicAV.getDsModifAuto() : "", true, true, 35, iRowPx , "", "st_ListaModifAuto", "fnCambiaSeleccion();", "", 50, false, false)%>
             <%
                iRowPx = iRowPx + 38;
            %>
            <div id="divDetalleModif"  style="visibility: 'hidden'">
             <%=MyUtil.ObjInput("Detalle", "detalleModif", infoAdicAV != null ? infoAdicAV.getDetalleModif() : " ", true, true, 35, iRowPx, "", false, false, 25)%>  
            </div>            
            <div id="divDistanciaPiso"  style="visibility: 'hidden'">
                <%=MyUtil.ObjInput("Distancia piso (CM)", "distanciaPiso", infoAdicAV != null ? String.valueOf(infoAdicAV.getDistanciaPiso()) : "", true, true, 35, iRowPx, "", false, false, 5)%>  
            </div>
            <div id="divMedidas1"  style="visibility: 'hidden'">
                <%=MyUtil.ObjInput("Largo (M)", "largo", infoAdicAV != null ? String.valueOf(infoAdicAV.getLargo()) : "", true, true, 35, iRowPx, "", false, false, 5)%>  
                <%=MyUtil.ObjInput("Alto (M)", "alto", infoAdicAV != null ? String.valueOf(infoAdicAV.getAlto()) : "", true, true, 105, iRowPx, "", false, false, 5)%>  
            </div>
            
          
           

        </div>
        <%
        iRowPx = iRowPx + 48;
        %>   
        
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

                  <%=MyUtil.ObjInputFNAC("Fecha Cita (AAAA-MM-DD)", "Fecha", fechaProgramado, true, true, 30, iRowPx, "", false, false, 15, 2, "fnValidaFechaActual(this);")%>
                  <%=MyUtil.ObjInput("Hora Desde (HH:MM)", "HoraD", horaDesdeProg, true, true, 190, iRowPx, "", false, false, 5,"fnHrsD(this);")%>
                  <%=MyUtil.ObjInput("Hora Hasta (HH:MM)", "HoraH", horaHastaProg, true, true, 330, iRowPx, "", false, false, 5,"fnHrsH(this);fnHrsCita();")%>

          </div>
                   <%
                  iRowPx = iRowPx + 48;
                  %> 
        <div id="divPeajesCubiertos"  class='VTable' style='position:absolute; z-index:100; left:30px; top:<%= iRowPx%>px; ' >
            <p style="display: inline; text-align: left; width:auto; ">¿Tiene cobertura total en peajes?&nbsp;&nbsp;</p>
            <input class='VTable' id="cubiertos"   type="radio"  name="chkPeajeCub" value="1" disabled >SI
            <input class='VTable' id="noCubiertos" type="radio"  name="chkPeajeCub" value="0" disabled >NO
            <input type="hidden" name="peajesCubiertos" id="peajesCubiertos" value="<%=peajesCubiertos%>" >
            <input type="hidden" name="coberturaTotalPeaje" id="coberturaTotalPeaje" value="<%=coberturaTotalPeaje? 1 : 0%>" >
        </div> 
                  
        <div id="divMontoCubierto" style="visibility: 'hidden'">
            <%=MyUtil.ObjInput("Monto cubierto", "montoCubierto", montoCubierto, false, false, 330, iRowPx, "", true, false, 3,"")%>
        </div>
         <%
        iRowPx = iRowPx + 48;
        %> 

        
        <%=MyUtil.DoBlock("Detalle de Arrastre de Grua  ", 80, 40)%>


        <!-- GEOLOC TARGET LOCAL-->
        <%
        iRowPx = iRowPx + 130;
        %>
        <%=MyUtil.ObjComboMem("Pais", "clPais", StrdsPais, StrclPais, cbPais.GeneraHTML(20, StrdsPais), false, false, 30, iRowPx, StrclPais, "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
        <%
        iRowPx = iRowPx + 30;
        %>
        <!-- %=MyUtil.ObjInput("Direccion", "DireccionA", sTmpDirA ,  true, true,  30,iRowPx, "", true, true, 90 )% -->
        <div class='VTable' style='position:absolute; z-index:100; left:540px; top:<%= iRowPx + 19 %>px;'>
            <INPUT id="MapaOrig" type='button' VALUE='Mapa' onClick='openMap("DireccionA", "LatLong","CalleNum","dsMunDel","dsEntFed","CodMDOrigen","CodEntOrigen");return false;' class='cBtn'>
        </div>
        <input type="hidden" name="DireccionA" id="DireccionA" value="<%=sTmpDirA%>" >
        <%
        //iRowPx = iRowPx + 30;
        %>
        <%//PROVINCIA y LOCALIDAD- EDITABLES EN ALTA ESTABAN EN FALSE%>
        <%=MyUtil.ObjInput("Provincia", "dsEntFed", StrdsEntFed, true, true, 30, iRowPx, StrdsEntFed, false, false, 48)%>
        <%=MyUtil.ObjInput("Localidad", "dsMunDel", StrdsMunDel, true, true, 285, iRowPx, StrdsMunDel, false, false, 50)%>
        <input type="hidden" id="CodMDOrigen" name="CodMDOrigen" value="<%=StrCodMD%>">
        <input type="hidden" id="CodEntOrigen" name="CodEntOrigen" value="<%=StrCodEnt%>">

        <%
        iRowPx = iRowPx + 30;
        %>
        <%=MyUtil.ObjInput("Calle", "CalleNum",AV != null ? AV.getCalleO() : "", true, true, 30, iRowPx, StrCalleNum, false, false, 62)%>
        <%=MyUtil.ObjInput("Latitud y Longitud", "LatLong", sLatLong, true, true, 350, iRowPx, "", false, false, 36)%>

        <%
        iRowPx = iRowPx + 30;
        %>
        <%=MyUtil.ObjTextArea("Referencias Visuales", "Referencias", AV != null ? AV.getReferenciasO() : "", "105", "1", true, true, 30, iRowPx, StrDescAuto, false, false)%>
        <%=MyUtil.DoBlock("Ubicación del Evento", 80, 40)%>
        
        <%
        iRowPx = iRowPx + 170;
        %>
        <%=MyUtil.ObjComboMem("Pais Destino", "clPaisDest", AV != null ? AV.getDsPaisD() : "ARGENTINA", AV != null ? AV.getClPaisD() : "10", cbPais.GeneraHTML(20, AV != null ? AV.getDsPaisD() : "ARGENTINA"), false, false, 30, iRowPx, StrclPais, "fnLlenaEntidadAjaxFnDest(this.value);", "", 20, false, false)%>
        <%
            String tmpCalleDest = (AV!=null?AV.getCalleD():"");
            String sTmpDirB = (StrdsEntFedDest.equals("") && StrdsMunDelDest.equals("") ?"": StrdsEntFedDest + ", " + StrdsMunDelDest + ", " + tmpCalleDest);
        //iRowPx = iRowPx + 30;
        %>
        <!-- %=MyUtil.ObjInput("Direccion", "DireccionB", sTmpDirB , true, true, 30, iRowPx, StrCodEnt,  false, false, 90)% -->
        <input type="hidden" name="DireccionB" id="DireccionB" value="<%=sTmpDirB%>" >
        <a href="../../../src/Utilerias/EjecutaGuardaBtaView.java"></a>
        <%
        iRowPx = iRowPx + 30;
        %>
        <div class='VTable' style='position:absolute; z-index:100; left:540px; top:<%= iRowPx + 19 %>px; '>
            <INPUT id="MapaDest" type='button' VALUE='Mapa' id="btn2" onClick='openMap("DireccionB", "LatLongDest","CalleNumDest","dsMunDelDest","dsEntFedDest","CodMDDest","CodEntDest");return false;' class='cBtn'>
        </div> 
        <%
        //iRowPx = iRowPx + 30;
        %>
        <%=MyUtil.ObjInput("Provincia", "dsEntFedDest", StrdsEntFedDest, true, true, 30, iRowPx, "", false, false, 48)%>
        <%=MyUtil.ObjInput("Localidad", "dsMunDelDest", StrdsMunDelDest, true, true, 285, iRowPx, "",false, false,50)%>
        <input type="hidden" id="CodMDDest" name="CodMDDest" value="<%=StrCodMDDest%>">
        <input type="hidden" id="CodEntDest" name="CodEntDest" value="<%=StrCodEntDest%>">
        <%
        iRowPx = iRowPx + 30;
        %>
        <%=MyUtil.ObjInput("Calle", "CalleNumDest", tmpCalleDest, true, true, 30, iRowPx, tmpCalleDest, false, false, 62)%>
        <%=MyUtil.ObjInput("Latitud y Longitud", "LatLongDest", sLatLongDest, false, false, 350, iRowPx, "", false, false, 36)%>
        <input type="hidden" id="localidadOrigen" name="localidadOrigen" value="<%=StrdsMunDel%>">
        <input type="hidden" id="calleOrigen" name="calleOrigen" value="<%=tmpCalleOri%>">
        <input type="hidden" id="localidadDestino" name="localidadDestino" value="<%=StrdsMunDelDest%>">
        <input type="hidden" id="calleDestino" name="calleDestino" value="<%=tmpCalleDest%>">

        <%
        iRowPx = iRowPx + 35;
        %>
        <%=MyUtil.ObjTextArea("Referencias Visuales", "ReferenciasDest", AV != null ? AV.getReferenciasD() : "", "105", "1", true, true, 30, iRowPx, "", false, false)%>
        
        <%=MyUtil.DoBlock("Destino", 80, 40)%>
        
        
         
        <!-- Test Dialog -->
        
        <%=MyUtil.GeneraScripts()%>
        


            
        <input name='ModeloMsk'  id='ModeloMsk' type='hidden' value='VN09VN09VN09VN09'>
              
        <script>
            /*Seteo los mÃ¡ximos permitidos para ciertos campos*/
            document.all.detalleFalla.maxLength = 60;
            document.all.pesoCarga.maxLength = 5;
            document.all.tipoCarga.maxLength = 20;
            document.all.recibeNombre.maxLength = 60;
            document.all.recibeCodArea.maxLenght = 5;
            document.all.recibeNroTelef.maxLenght= 8;
            document.all.alto.maxLenght = 3;
            document.all.largo.maxLenght = 3;
            document.all.distanciaPiso.maxLenght = 2;
            document.all.detalleModif.maxLenght = 60;
            
            
            /*Configuro el resto de la pantalla*/
            var elementUG = document.getElementById("clUbicacionAutoGarajeC");
            var elementNS = document.getElementById("nivelSubsueloC");
            var elementAC = document.getElementById("aNivelAbiertoC");
            var elementES = document.getElementById("clEstacionamientoC");
            elementUG.disabled = true;
            elementNS.disabled = true;
            elementAC.disabled = true;
            elementES.disabled = true;
           
            document.all.delanteraIzqC.disabled = true;
            document.all.delanteraDerC.disabled = true;
            document.all.traseraIzqC.disabled = true;
            document.all.traseraDerC.disabled = true;
            
            document.all.esAutomatico.disabled = true;
            document.all.esManual.disabled = true;
            document.all.estaBloqueada.disabled = true;
            document.all.noEstaBloqueada.disabled = true;
            document.all.todasBloqueadas.disabled = true;
            document.all.siTieneCarga.disabled = true;
            document.all.noTieneCarga.disabled = true;
            document.all.estaVigente.disabled = true;
            document.all.noEstaVigente.disabled = true;
            document.all.tieneModificaciones.disabled = true;
            document.all.noTieneModificaciones.disabled = true;
            document.all.tieneDuales.disabled = true;
            document.all.noTieneDuales.disabled = true;
            document.all.liberado.disabled = true;
            document.all.noLiberado.disabled = true;
            document.all.tieneModificaciones.disabled = true;
            document.all.esProgramado.disabled = true;
            document.all.noEsProgramado.disabled = true;
            document.all.cubiertos.disabled = true;
            document.all.noCubiertos.disabled=true;

            document.all.divRuedasBloqueadas.style.visibility = 'hidden';
            document.all.divGaraje.style.visibility = 'hidden';
            document.all.divSubsuelo.style.visibility = 'hidden';
            document.all.divANivel.style.visibility = 'hidden';
            document.all.divVigente.style.visibility = 'hidden';
            document.all.divQuienRecibe.style.visibility = 'hidden';
            document.all.divModificaciones.style.visibility = 'hidden';
            document.all.divDistanciaPiso.style.visibility = 'hidden';
            document.all.divMedidas1.style.visibility = 'hidden';
            document.all.divDetalleModif.style.visibility = 'hidden';
            document.all.divDatosCarga.style.visibility = 'hidden';   
            document.all.divTipoFalla.style.visibility = 'hidden';
            document.all.divVehiculoLiberadoAccidente.style.visibility = 'hidden';    
            document.all.divEstacionamiento.style.visibility = 'hidden';
           // document.all.divMontoCubierto.style.visibility = 'hidden';
            
            /*Cargo los datos*/
            var cambio = <%=StrclInfoAdicKMO%>;
            if ( cambio.toString() !== '0' ) {
                
                fnCambiaUbicacion(<%=clUbicacionAuto%>);
                var combobox  = document.getElementById("clUbicacionAutoC");
                var ubicacion = combobox.options[combobox.selectedIndex].text;

                if ( ubicacion.toString().toUpperCase() === 'AUTOPISTA' ) {
                    var elementES = document.getElementById("clEstacionamientoC")
                    elementES.disabled = true;
                    document.all.divEstacionamiento.style.visibility = 'visible';
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
                                document.all.divANivel.style.visibility = 'visible';

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
                document.all.siTieneCarga.checked= document.all.tieneCarga.value === '1'?true:false;
                document.all.noTieneCarga.checked= document.all.tieneCarga.value === '1'?false:true;
                document.all.estaVigente.checked= document.all.cedulaVerdeVig.value === '1'?true:false;
                document.all.noEstaVigente.checked= document.all.cedulaVerdeVig.value === '1'?false:true;
                document.all.tieneModificaciones.checked= document.all.tieneModif.value === '1'?true:false;
                document.all.noTieneModificaciones.checked= document.all.tieneModif.value === '1'?false:true;
                document.all.tieneDuales.checked= document.all.ruedasDuales.value === '1'?true:false;
                document.all.noTieneDuales.checked= document.all.ruedasDuales.value === '1'?false:true;
                //Pedido Ayelen 22/06/21 Agregar vehiculo liberado para accidentes
                document.all.liberado.checked   = document.all.vehiculoLiberado.value === '1'?true:false;
                document.all.noLiberado.checked = document.all.vehiculoLiberado.value === '1'?false:true;
                document.all.esProgramado.checked   = document.all.servicioProgramado.value === '1'?true:false;
                document.all.noEsProgramado.checked = document.all.servicioProgramado.value === '1'?false:true;
                
                
                fnServicioProgramado(document.all.servicioProgramado.value);

                
                var combobox = document.getElementById("clCantPersonaC");
                var cantidadPersonas = combobox.options[combobox.selectedIndex].text;
                /* Para obtener el texto */
                if (cantidadPersonas.toString().toUpperCase() === 'VH VIAJA SOLO') {
                    /**Viaja solo*/
                    document.all.estaVigente.enabled = true;
                    document.all.noEstaVigente.enabled = true;
                    document.all.divVigente.style.visibility = 'visible';
                    document.all.divQuienRecibe.style.visibility = 'visible';
                } else {
                    //poner en null los valores relacionados a quien recibe
                    document.all.estaVigente.enabled = false;
                    document.all.noEstaVigente.enabled = false;
                    document.all.divVigente.style.visibility = 'hidden';
                    document.all.divQuienRecibe.style.visibility = 'hidden';
                    document.all.recibeNombre.value = ' ';
                    document.all.recibeCodArea.value = 0;
                    document.all.recibeNroTelef.value = 0;
                    document.all.cedulaVerdeVig.value = 0;
                }

                if (document.all.tieneModificaciones.checked) {
                    document.all.divModificaciones.style.visibility = 'visible';
                        var combobox  = document.getElementById("clModifAutoC");
                        var tipoModificacion = combobox.options[combobox.selectedIndex].text;
                        document.all.divDistanciaPiso.style.visibility = 'hidden';
                        document.all.divMedidas1.style.visibility = 'hidden';
                        if ( tipoModificacion.toString().toUpperCase() === 'SUSPENSIÓN BAJA') {
                            document.all.divDistanciaPiso.style.visibility = 'visible';
                            document.all.divMedidas1.style.visibility = 'hidden';
                            document.all.divDetalleModif.style.visibility = 'hidden';
                        } else {
                            if ( tipoModificacion.toString().toUpperCase() === 'CAJA MUDANCERA' ||
                                    tipoModificacion.toString().toUpperCase() === 'CAJA TÉRMICA') {
                                        document.all.divMedidas1.style.visibility = 'visible';
                                        document.all.divDistanciaPiso.style.visibility = 'hidden';
                                        document.all.divDetalleModif.style.visibility = 'hidden';
                            } else {
                                if ( tipoModificacion.toString().toUpperCase() === 'OTRO' ) {
                                    document.all.divMedidas1.style.visibility = 'hidden';
                                    document.all.divDistanciaPiso.style.visibility = 'hidden';
                                    document.all.divDetalleModif.style.visibility = 'visible';
                                } else {
                                    document.all.divMedidas1.style.visibility = 'hidden';
                                    document.all.divDistanciaPiso.style.visibility = 'hidden';
                                    document.all.divDetalleModif.style.visibility = 'hidden';
                                }
                            }
                        }

                }
                //(document.all.tieneCarga.value);
                if ( document.all.tieneCarga.value === '1') {
                   document.all.divDatosCarga.style.visibility = 'visible';
                } else {
                   document.all.divDatosCarga.style.visibility = 'hidden';
                }
                fnFallaVehiculo(document.all.clTipoFalla);
               
            }
            
            
            $(document).ready(function() {

                
                <!-- define que boton va habilitado o no al inicio -->
                document.all.btnAlta.disabled = <%=(AV != null?"true":"false")%>;
                document.all.btnCambio.disabled = <%=(AV == null?"true":"false")%>;
                document.all.MapaOrig.disabled = true; 
                document.all.MapaDest.disabled = true;
                $("#cubiertos").prop("checked", $("#coberturaTotalPeaje").val() === '1');
                $("#noCubiertos").prop("checked", $("#coberturaTotalPeaje").val() !== '1');
                if ( $("#coberturaTotalPeaje").val() == 0) {
                   document.all.divMontoCubierto.style.visibility = 'visible';
                } else {
                   document.all.divMontoCubierto.style.visibility = 'hidden';
                }
                $("#btnCambio").click(function() {
                    document.getElementById("DireccionA").disabled = false; 
                    document.getElementById("DireccionB").disabled = false; 
                    document.all.MapaOrig.disabled = false; 
                    document.all.MapaDest.disabled = false;
                    document.all.montoCubierto.value = <%=montoCubierto%>;
                });
                $("#btnAlta").click(function() {
                    document.getElementById("DireccionA").disabled = false; 
                    document.getElementById("DireccionB").disabled = false; 
                    document.all.MapaOrig.disabled = false; 
                    document.all.MapaDest.disabled = false;
                    document.all.montoCubierto.value = <%=montoCubierto%>;
                });
                $("#CalleNum").change(function() {
                    document.getElementById("LatLong").value = "";
                });
                $("#CalleNumDest").change(function() {
                    document.getElementById("LatLongDest").value = "";
                });
                
             });

            var placeSearch, autocomplete,autocompleteB;
            var componentForm = {
              street_number: 'short_name',
              route: 'long_name',
              locality:'long_name',
              administrative_area_level_1: 'long_name',
              administrative_area_level_2: 'long_name'
            };
            
            // ------- AUTOCOMPLETADO CAMPO "LUGAR" evento ratón -------
            $(document).ready(function(){
                            $(document).mousemove(function(event){
                   var capi = 'CAPITAL FEDERAL';
                                //TOMA VALORES DE LOS CAMPOS Origen y Destino POR CADA MOV. DEL RATÓN
                                var destino1 = $(document.getElementById('dsEntFed')).val();
                                var destino2 = $(document.getElementById('dsEntFedDest')).val();
                                var destino3 = $(document.getElementById('dsMunDel')).val();
                                var destino4 = $(document.getElementById('dsMunDelDest')).val();   
                                //ELIGE UNA OPCION DEL COMBOBOX COMPARANDO VALORES OBTENIDOS
                                if (destino3.toUpperCase()!= destino4.toUpperCase()) {
                                    if (destino1.toUpperCase() == capi && destino2.toUpperCase() == capi){
                            var opcion = '2';
                                        $(document.getElementById('clLugarEvento')).val(opcion);
                                        $(document.getElementById('clLugarEventoC')).val(opcion);
                                    }else{
                            var opcion = '1';
                                        $(document.getElementById('clLugarEvento')).val(opcion);
                                        $(document.getElementById('clLugarEventoC')).val(opcion);}
                                }else {
                   var opcion = '2';
                                $(document.getElementById('clLugarEvento')).val(opcion);
                                    $(document.getElementById('clLugarEventoC')).val(opcion);}
                                    });
				});
                    // ------------------------------------------------------------------
            /*
             * Cierra el diálogo de 
             * vehículo con carga*/
            function fnConfirmaCarga(peso,tipo) {
                alert(peso);
            }
            
            
            function setupClickListener(id) {
              var button = document.getElementById(id);
              button.addEventListener('click', function() {
                fillInAddress();
              });
            }

            function initMap() {
                document.getElementById("DireccionA").disabled = true; 
                document.getElementById("DireccionB").disabled = true; 
                /*
                google.maps.event.addDomListener(window, 'load', function () {
                    autocomplete = new google.maps.places.Autocomplete(document.getElementById('DireccionA'), {types: ['address']});
                    autocomplete.setComponentRestrictions( {'country': ['ar']});
                    autocomplete.addListener('place_changed', fillInAddressAux);
                    autocompleteB = new google.maps.places.Autocomplete(document.getElementById('DireccionB'), {types: ['address']});
                    autocompleteB.setComponentRestrictions( {'country': ['ar']});
                    autocompleteB.addListener('place_changed', fillInAddressAuxB);
                });
                */
            }
            
            function fillInAddressAux() { 
                //console.log(autocomplete.getPlace());
                fillInAddressGeneric(autocomplete.getPlace(),"CalleNum", "LatLong",  "dsMunDel", "dsEntFed","CodMDOrigen", "CodEntOrigen");
            }
            function fillInAddressAuxB() {
                fillInAddressGeneric(autocompleteB.getPlace(),"CalleNumDest", "LatLongDest", "dsMunDelDest", "dsEntFedDest", "CodMDDest", "CodEntDest");
            }

            function openMap(campo, latLong, calle, localidad, provincia,codMD, codEnt) {
                direccion = document.getElementById(campo).value;
                geo = window.open('../../Geolocalizacion/gmap3.jsp?dire='+ direccion +'&dDir=' + campo + '&dLatLon=' + latLong
                 + '&fCalle=' + calle + "&fLoc=" + localidad + "&fPro=" + provincia + "&fCodMD=" + codMD + "&fCodEnt=" + codEnt, 'GEO', 
                    'modal=yes,resizable=yes,menubar=0,status=0,toolbar=0,height=820,width=1200,screenX=1,screenY=1');
                   
                geo.focus();

            }
    
            function fnBuscaGeo() {
                var pstrCadena = "/SISE_AR_QA/Geolocalizacion/showMap.jsp";
                window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=900,height=800');
            }
           
            document.all.Modelo.maxLength = 4;
            function fnLlenaEntidadAjaxFn(cod) {  /// Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion
                IDCombo = 'CodEnt';
                Label = 'Provincia';
                IdDiv = 'CodEntDiv';
                FnCombo = 'fnLLenaComboMDAjax(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion=" + cod + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnValLugar() {
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
                document.all.siTieneCarga.disabled = false;
                document.all.noTieneCarga.disabled = false;
                document.all.estaVigente.disabled = false;
                document.all.noEstaVigente.disabled = false;
                document.all.tieneModificaciones.disabled = false;
                document.all.noTieneModificaciones.disabled = false;
                document.all.tieneDuales.disabled = false;
                document.all.noTieneDuales.disabled = false;
                document.all.liberado.disabled = false;
                document.all.noLiberado.disabled = false;
                document.all.tieneModificaciones.disabled = false;
                document.all.esProgramado.disabled = false;
                document.all.noEsProgramado.disabled = false;
                
                
            }
            
            
            function fnLlenaComboAuto() {
                /*20160406 Se agrega para llenar las opciones de la marca seleccionada*/
                fnLlenaTipoAutoAjax(document.all.CodigoMarca.value, 'ClaveAMIS', 'Tipo de Auto', 'TipoAutoDiv', '', 2);
                cadenaTexto = '<%=StrDsTipoAuto%>';
                var nuevaOpc = document.createElement("OPTION");
                nuevaOpc.text = cadenaTexto.toString();
                nuevaOpc.value = "<%=StrClaveAMIS%>";
                forma.ClaveAMISC.add(nuevaOpc);
                document.all.ClaveAMISC.value = '<%=StrClaveAMIS%>'
                document.all.ClaveAMIS.value = '<%=StrClaveAMIS%>'
            }
            
            
             /*Muestra el cartel
              * de autoposta
             */
            function fnCartelAutopista() {
                
                var combobox  = document.getElementById("clUbicacionAutoC");
                var ubicacion = combobox.options[combobox.selectedIndex].text;
                if ( ubicacion.toString().toUpperCase() === 'AUTOPISTA') {
                    alert("Recuerde que debe comunicarse con la asistencia de la autopista.");
                }
            }
            
            /*Muestra un cartel en caso de que
             * el auto este en la ruta
             */
            function fnCartelRuta() {
                var combobox  = document.getElementById("clUbicacionAutoC");
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
            function fnCambiaUbicacion(idUbicacion) {
                
                var combobox  = document.getElementById("clUbicacionAutoC");
                var ubicacion = combobox.options[combobox.selectedIndex].text;
                var elementUG = document.getElementById("clUbicacionAutoGarajeC");
                var elementNS = document.getElementById("nivelSubsueloC");
                var elementAC= document.getElementById("aNivelAbiertoC");
                var elementES= document.getElementById("clEstacionamientoC");
                elementUG.disabled = true; 
                elementNS.disabled = true;
                elementAC.disabled = true;
                elementES.disabled = true;
                
                if ( ubicacion.toString().toUpperCase() === 'AUTOPISTA') {
                    //alert("Recuerde que debe comunicarse con la asistencia de la autopista.");
                    elementES.disabled = false;
                    elementUG.disabled = true; 
                    elementNS.disabled = true;
                    elementAC.disabled = true;
                    elementUG.value = '';
                    elementNS.value = '';
                    elementAC.value = '';
                   
                    document.all.divGaraje.style.visibility = 'hidden';
                    document.all.divSubsuelo.style.visibility = 'hidden';
                    document.all.divANivel.style.visibility = 'hidden';
                    document.all.divEstacionamiento.style.visibility = 'visible';
                    return;
                }
                
                if ( ubicacion.toString().toUpperCase() === 'GARAJE/ESTACIONAMIENTO' ) {
                    elementUG.disabled = false;
                    elementES.disabled = false;
                    elementES.value = '';
                    document.all.divGaraje.style.visibility = 'visible';
                    document.all.divSubsuelo.style.visibility = 'hidden';
                    document.all.divANivel.style.visibility = 'hidden';
                    document.all.divEstacionamiento.style.visibility = 'hidden';
                } else {
                    
                    elementUG.disabled = true; 
                    elementNS.disabled = true;
                    elementAC.disabled = true;
                    elementES.disabled = true;
                    elementUG.value = '';
                    elementNS.value = '';
                    elementAC.value = '';
                    elementES.value = '';
                    document.all.divGaraje.style.visibility = 'hidden';
                    document.all.divSubsuelo.style.visibility = 'hidden';
                    document.all.divANivel.style.visibility = 'hidden';
                    document.all.divEstacionamiento.style.visibility = 'hidden';
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
                       alert("Recuerda informar al usuario que el vehículo debe encontrarse sobre la vía pública. Si esto no es posible, valida la cobertura de extracción.");
                             
                    } else {
                        elementNS.disabled = false;
                        elementAC.disabled = true;
                        elementAC.value = '';
                        document.all.divSubsuelo.style.visibility = 'visible';
                        document.all.divANivel.style.visibility = 'hidden';
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
                
                var combobox  = document.getElementById("aNivelAbiertoC");
                var abiertoCerrado = combobox.options[combobox.selectedIndex].text;
                
                /*if ( abiertoCerrado.toString().toUpperCase() === 'ABIERTO') {
                    alert("Recuerda verificar cobertura de extracción.");
                    return;
                }*/
                
            }
            /**Radio button automatico/manual*/
            function fnValorRadioAutoManual() {
                
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
            
            /*
             * Tiene cobertura de peajes
             */
//            function fnPeajesCubiertos(peajesCubiertos) {
//                if ( peajesCubiertos === '1' ) {
//                    document.all.divMontoCubierto.style.visibility = 'visible';
//                } else {
//                    document.all.divMontoCubierto.style.visibility = 'hidden';
//                    document.all.montoCubierto.value = ' ';
//                }
//      
//            }
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
                    document.all.divVehiculoLiberadoAccidente.style.visibility = 'hidden';
                } else {
                    document.all.divTipoFalla.style.visibility = 'hidden';
                    document.all.divVehiculoLiberadoAccidente.style.visibility = 'visible';
                    document.all.detalleFalla.disabled = true;
                    document.all.detalleFalla.value = '';
                    
                    //PGM: Reunion 050521: queda pendiente de analisis
                    //alert("Recuerde preguntar al usuario si se encuentra bien.");
                    return;
                }
            }
         
            /**Radio button tiene carga*/
            function fnValorRadioCarga(estaCargado) {
                
                if ( estaCargado === '1') {
                   alert("Recuerda informar al usuario que el vehículo debe estar descargado al llegar la grúa.");
                   document.all.divDatosCarga.style.visibility = 'visible';
                } else {
                   document.all.divDatosCarga.style.visibility = 'hidden';
                   document.all.pesoCarga.value = 0;
                   document.all.tipoCarga.value = ' ';
                }
                
            }
            
            /*Si no esta liberado, tengo
             * que mostrar un aviso
             */
            function fnLiberado(estaLiberado) {
                if ( estaLiberado === '0' ) {
                    alert("Recuerda informar al usuario que el vehículo debe estar liberado al momento en que llegue el prestador.");
                }
            }
            
            /**Actualizar el peso*/
            function fnActualizarCarga(peso,tipo) {
                alert(peso);
                /**Dejar invisible panel tipo de carga*/
                //fnCloseModal('modalTipoCarga','');
               
            }
            
            /**Radio tton tiene ruedas duales*/
            function fnValorRadioDuales(ruedasDuales) {
                
            }
            
            /**
             * Si el vehículo tiene modificaciones,
             * hay que cargar algunos campos para
             * determinarlas.
             */
            function fnValorRadioModificacion(autoModificado) {
                if ( autoModificado === '1') {
                    document.all.divModificaciones.style.visibility = 'visible';
                } else {
                   document.all.divModificaciones.style.visibility = 'hidden';
                   document.all.divDetalleModif.style.visibility   = 'hidden';
                   document.all.divDistanciaPiso.style.visibility  = 'hidden';
                   document.all.divMedidas1.style.visibility       = 'hidden';
    
                   document.all.clModifAuto.value = '';
                   document.all.distanciaPiso.value = '0';
                   document.all.alto.value = '0';
                   document.all.largo.value = '0';
                   document.all.detalleModif.value = ' ';                    
                }
            }
            
            /**
             * Tiene o no tiene la 
             * cedule verde habilitada
             */
            function fnCedulaVerde(cedulaVerde) {
                if ( cedulaVerde === '1') {
                   //    
                } else {
                    alert("Recuerde que para que el vehículo viaje solo, debe contar con la documentación vigente");
                }
            }
            
            /**Combo cantidad de personas*/
            function fnCantPersonas() {
                var combobox = document.getElementById("clCantPersonaC");
                var cantidadPersonas = combobox.options[combobox.selectedIndex].text;
 
                /* Para obtener el texto */
                if (cantidadPersonas.toString().toUpperCase() === 'VH VIAJA SOLO') {
                        /**Viaja solo*/
                    document.all.estaVigente.enabled = true;
                    document.all.noEstaVigente.enabled = true;
                    document.all.divVigente.style.visibility = 'visible';
                    document.all.divQuienRecibe.style.visibility = 'visible';
                } else {
                    /*Alerta mientras dure COVID*/
                    if ( cantidadPersonas.toString().toUpperCase() !== 'VIAJA EN OTRO VH') {
                        alert("Recuerda informar al usuario que por la contingencia del COVID-19, el vehículo posiblemente deba viajar sin acompañantes. Esta sujeto al criterio del prestador. Recuerda verificar la cobertura de remis/traslado de acompañantes.");
                    }
                    //poner en null los valores relacionados a quien recibe
                    document.all.estaVigente.enabled = false;
                    document.all.noEstaVigente.enabled = false;
                    document.all.divVigente.style.visibility = 'hidden';
                    document.all.divQuienRecibe.style.visibility = 'hidden';
                    if ( cantidadPersonas.toString().toUpperCase() === 'MÁS DE 2') {
                        alert("Recuerde que máximo pueden viajar 2 personas en la cabina simple. Revisar cobertura de traslado de acompañantes");
                    }
                    document.all.recibeNombre.value = ' ';
                    document.all.recibeCodArea.value = 0;
                    document.all.recibeNroTelef.value = 0;
                    document.all.cedulaVerdeVig.value = 0;
                }
            }
            
           /**
             * Tipo de falla, si es
             * avería, hay que habilitar
             * el detalle 
             */
            function fnCambiaSeleccion() {
                var combobox  = document.getElementById("clModifAutoC");
                var tipoModificacion = combobox.options[combobox.selectedIndex].text;
                document.all.divDistanciaPiso.style.visibility = 'hidden';
                document.all.divMedidas1.style.visibility = 'hidden';
                if ( tipoModificacion.toString().toUpperCase() === 'SUSPENSIÓN BAJA') {
                    document.all.divDistanciaPiso.style.visibility = 'visible';
                    document.all.divMedidas1.style.visibility = 'hidden';
                    document.all.divDetalleModif.style.visibility = 'hidden';
                    document.all.largo.value = '0';
                    document.all.alto.value = '0';
                    document.all.detalleModif.value = ' ';
                    document.all.distanciaPiso.value = '';
                } else {
                    if ( tipoModificacion.toString().toUpperCase() === 'CAJA MUDANCERA' ||
                            tipoModificacion.toString().toUpperCase() === 'CAJA TÉRMICA') {
                                document.all.divMedidas1.style.visibility = 'visible';
                                document.all.divDistanciaPiso.style.visibility = 'hidden';
                                document.all.divDetalleModif.style.visibility = 'hidden';
                                document.all.distanciaPiso.value = '0';
                                document.all.detalleModif.value = ' ';
                                document.all.largo.value = '';
                                document.all.alto.value = '';
                                
                    } else {
                        if ( tipoModificacion.toString().toUpperCase() === 'OTRO' ) {
                            document.all.divMedidas1.style.visibility = 'hidden';
                            document.all.divDistanciaPiso.style.visibility = 'hidden';
                            document.all.divDetalleModif.style.visibility = 'visible';
                            document.all.distanciaPiso.value = '0';
                            document.all.largo.value = '0';
                            document.all.alto.value = '0';
                            document.all.detalleModif.value = '';
                            
                                                 
                        } else {
                            document.all.divMedidas1.style.visibility = 'hidden';
                            document.all.divDistanciaPiso.style.visibility = 'hidden';
                            document.all.divDetalleModif.style.visibility = 'hidden';
                            document.all.distanciaPiso.value = '0';
                            document.all.largo.value = '0';
                            document.all.alto.value = '0';
                            document.all.detalleModif.value = ' ';
                            
                        }
                    }
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
                
                

                
                var clInfoAdicKMO = <%=StrclInfoAdicKMO%>;
		var clExpediente  = <%=StrclExpediente%>;
                /*vehículo automatico
                si es accidente : liberado o o liberado
                si hay rueda bloqueada
                si tiene carga
                si tiene modificacion
                si tiene ruedas duales*/
                var clUbicacionAuto       =(document.all.clUbicacionAutoC.value ==null || document.all.clUbicacionAutoC.value =='')?0:document.all.clUbicacionAutoC.value;
		var clUbicacionAutoGaraje =(document.all.clUbicacionAutoGarajeC.value == null || document.all.clUbicacionAutoGarajeC.value == '' )?0:document.all.clUbicacionAutoGarajeC.value;
		var aNivelAbierto         =(document.all.aNivelAbiertoC.value==null || document.all.aNivelAbiertoC.value=='')?0:document.all.aNivelAbiertoC.value;
		var nivelSubsuelo         =(document.all.nivelSubsueloC.value==null || document.all.nivelSubsueloC.value=='')?0:document.all.nivelSubsueloC.value;
		var clTipoFalla           =document.all.clTipoFallaC.value==null?0:document.all.clTipoFallaC.value;
		var detalleFalla          =document.all.detalleFalla.value==null?" ":document.all.detalleFalla.value;
		var automatico            =document.all.automatico.value==null?'':document.all.automatico.value;
		var ruedaBloqueada        =document.all.ruedaBloqueada.value==null?'':document.all.ruedaBloqueada.value;
		var vehiculoLiberado      =(document.all.vehiculoLiberado.value==null )?'':document.all.vehiculoLiberado.value;
                var tieneCarga            =document.all.tieneCarga.value==null?'':document.all.tieneCarga.value;
                var tieneModif            =document.all.tieneModif.value==null?'':document.all.tieneModif.value;
		var ruedasDuales          =document.all.ruedasDuales.value==null?'':document.all.ruedasDuales.value;

		/*Ruedas bloqueadas*/
		var delanteraIzq   = document.all.delanteraIzqC.checked?1:0;
		var delanteraDer   = document.all.delanteraDerC.checked?1:0;
		var traseraIzq     = document.all.traseraIzqC.checked?1:0;
		var traseraDer     = document.all.traseraDerC.checked?1:0;
                var cantBloqueadas = delanteraIzq+delanteraDer+traseraIzq+traseraDer;
                
		var pesoCarga      =(document.all.pesoCarga.value==null || document.all.pesoCarga.value=='')?0:document.all.pesoCarga.value;
		var tipoCarga      =(document.all.tipoCarga.value==null || document.all.tipoCarga.value=='')?" ":document.all.tipoCarga.value;
		var clCantPersona  =(document.all.clCantPersonaC.value==null)?0:document.all.clCantPersonaC.value;
		var cedulaVerdeVig =document.all.cedulaVerdeVig.value==null?'':document.all.cedulaVerdeVig.value;
		var recibeNombre   =(document.all.recibeNombre.value==null || document.all.recibeNombre.value=='')?" ":document.all.recibeNombre.value;
		var recibeCodArea  =(document.all.recibeCodArea.value==null || document.all.recibeCodArea.value=='')?0:document.all.recibeCodArea.value;
		var recibeNroTelef =(document.all.recibeNroTelef.value==null || document.all.recibeNroTelef.value=='')?0:document.all.recibeNroTelef.value;
		var clModifAuto    =(document.all.clModifAuto.value==null || document.all.clModifAuto.value=='')?0:document.all.clModifAuto.value;
		var distanciaPiso  =(document.all.distanciaPiso.value==null || document.all.distanciaPiso.value=='')?0:document.all.distanciaPiso.value;
		var largo          =(document.all.largo.value==null || document.all.largo.value=='')?0:document.all.largo.value;
		var alto           =(document.all.alto.value==null || document.all.alto.value=='')?0:document.all.alto.value;
		var detalleModif   =(document.all.detalleModif.value==null || document.all.detalleModif.value=='')?" ":document.all.detalleModif.value;
                var clUsrApp       = <%=Integer.parseInt(StrclUsrApp)%>
                var clEstacionamiento =(document.all.clEstacionamientoC.value==null || document.all.clEstacionamientoC.value=='')?0:document.all.clEstacionamientoC.value;
                var cambiosOrigenDest = "";
                var estadoVehiculo = " ";
                var distTierraFirme = 0;
                var compraBateria = 0;
                var servicioProgramado = document.all.servicioProgramado.value==null?'':document.all.servicioProgramado.value;;
                var fechaProgramado = document.all.Fecha.value==null?' ':document.all.Fecha.value;
                var horaDesdeProg = document.all.HoraD.value==null?' ':document.all.HoraD.value;
                var horaHastaProg = document.all.HoraH.value==null?' ':document.all.HoraH.value;
                var coberturaTotalPeaje = document.all.coberturaTotalPeaje.value==null?'0':document.all.coberturaTotalPeaje.value;
                var peajesCubiertos = document.all.peajesCubiertos.value==null?'':document.all.peajesCubiertos.value;
                var montoCubierto = document.all.montoCubierto.value==null?'':document.all.montoCubierto.value;
                //var kmAsistencia  = document.all.kmAsistencia.value==null?'':document.all.kmAsistencia.value;
                var kmAsistencia  = 0;
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
                if ( tieneCarga.toString() === '' ) {
                     msgVal = msgVal + " Falta opción tiene carga";
                }
                if ( tieneModif.toString() === '' ) {
                     msgVal = msgVal + " Falta opción tiene modificaciones";
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
                if ( peajesCubiertos.toString() === '' ) {
                     msgVal = msgVal + " Falta opción peajes cubiertos";
                }
                if ( coberturaTotalPeaje === '0' && peajesCubiertos.toString() === '1' ) {
                    if ( isNaN(montoCubierto.toString() ) ) {
                        msgVal = msgVal + " El monto cubierto debe ser un número";
                    } else {
                        var valorMonto = parseInt(montoCubierto.toString());
                        if ( valorMonto <0 && valorMonto >999 ) {
                            msgVal = msgVal + " El monto cubierto debe estar entre 0 y 999";
                        }
                    }
                } else {
                    montoCubierto = 0;
                }
                
                if ( isNaN(montoCubierto.toString() ) ) {
                    msgVal = msgVal + " Los kilometros debe ser un número";
                } else {
                    var valorMonto = parseInt(montoCubierto.toString());
                    if ( valorMonto <0 && valorMonto >9999 ) {
                        msgVal = msgVal + " Los kilómetros estar entre 0 y 9999";
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
                               
                /*Control de los
                 * campos cuando viaja solo
                 */
                var comboboxp = document.getElementById("clCantPersonaC");
                var cantidadPersonas = comboboxp.options[comboboxp.selectedIndex].text;
 
                if (cantidadPersonas.toString().toUpperCase() === 'VH VIAJA SOLO') {
                    if ( document.all.recibeNombre.value==null || document.all.recibeNombre.value=='' ) {
                        msgVal = msgVal + " Debe ingresar el nombre de quien recibe.";
                    }
                    if ( document.all.recibeCodArea.value === null || 
                            document.all.recibeCodArea.value === '' ||
                            document.all.recibeCodArea.value === '0' ||
                            isNaN(document.all.recibeCodArea.value)  ) {
                        msgVal = msgVal + " Debe ingresar el código de área de quien recibe.";
                    }
                    if ( document.all.recibeNroTelef.value === null || 
                            document.all.recibeNroTelef.value === '' ||
                            document.all.recibeNroTelef.value === '0' ||
                            isNaN(document.all.recibeNroTelef.value) ) {
                        msgVal = msgVal + " Debe ingresar el número de teléfono de quien recibe.";
                    }
                    if ( cedulaVerdeVig.toString() === '' ) {
                         msgVal = msgVal + " Debe ingresar cedula verde vig";
                    }
                } else {
                    /*
                     * En caso que no sea viaja solo
                     * pongo cedula verde vigente
                     * en cero
                     */
                    cedulaVerdeVig = 0;
                }
                
                /*Control de los campos
                 * del tipo de carga
                 */

                /*Solicitado por Ayelen 22-06
                 * Si tiene carga, igualmente
                 * permitir que no tenga ni 
                 * peso ni tipo de carga
                 */
               
                /**
                 * En caso de tiene modificaciones
                 * tengo que controlar los datos
                 */
                if ( tieneModif.toString() === '1' &&
                    (clModifAuto === null || 
                        clModifAuto.toString() === '' ||
                        clModifAuto.toString() === '0')) {
                        msgVal = msgVal + "Debe ingresar un tipo de modificación";
                }
                    
                if ( clModifAuto !== null && 
                        clModifAuto.toString() !== '' &&
                        clModifAuto.toString() !== '0' ) {
                        
                    var comboboxm  = document.getElementById("clModifAutoC");
                    var tipoModificacion = comboboxm.options[comboboxm.selectedIndex].text;
                    if ( tipoModificacion.toString().toUpperCase() === 'SUSPENSIÓN BAJA') {
                        if ( document.all.distanciaPiso.value === null || 
                            document.all.distanciaPiso.value === '' ||
                            document.all.distanciaPiso.value === '0' ||
                            isNaN(document.all.distanciaPiso.value) ) {
                            msgVal = msgVal + "Debe ingresar la distancia desde el piso.";
                        }
                    }
                    
                    if ( tipoModificacion.toString().toUpperCase() === 'CAJA MUDANCERA' ||
                            tipoModificacion.toString().toUpperCase() === 'CAJA TÉRMICA') {
                        
                        if ( document.all.alto.value === null || 
                            document.all.alto.value === '' || 
                            document.all.alto.value === '0' ||
                            isNaN(document.all.alto.value) ) {
                            msgVal = msgVal + "Debe ingresar la altura.";
                        }
                        if ( document.all.largo.value === null || 
                            document.all.largo.value === '' ||
                            document.all.largo.value === '0' ||
                            isNaN(document.all.largo.value) ) {
                            msgVal = msgVal + "Debe ingresar el largo.";
                        }
                    }
                    
                    if ( tipoModificacion.toString().toUpperCase() === 'OTRO' ) {
                        if ( document.all.detalleModif.value === null || 
                            document.all.detalleModif.value === '' ||
                            document.all.detalleModif.value === ' ' ||
                            document.all.detalleModif.value === '0') {
                            msgVal = msgVal + "Debe ingresar el detalle de la modificación.";
                        }
                    }
                }
                
                if (clTipoFalla > 0 ) {
                    var combo = document.getElementById("clTipoFallaC");
                    var str = combo.options[combo.selectedIndex].text;
                    if ( str.toString().toUpperCase() === 'ACCIDENTE') {
                        if ( vehiculoLiberado === '') {
                            msgVal = msgVal + "Falta opción vehículo liberado";
                        }
                    } else {
                        /*
                         * Si no es accidente, tengo que poner
                         * en cero la marca de vehículo
                         * liberado
                         */
                        vehiculoLiberado = 0;
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
                
                /*Si no tiene errores, guardo la planilla*/
//                document.all.forma.action = "../../servlet/Utilerias.EjecutaAccionAsist";
//                document.all.forma.submit();
                /*
                 * Control de cambios de la dirección
                 * solemente en el caso de 
                 * modificaciones
                 */
                 var cambio = <%=StrclInfoAdicKMO%>;
                 if ( cambio.toString() !== '0' ) {
                     var localOrigen = document.all.localidadOrigen.value;
                     var calleOrigen = document.all.calleOrigen.value;
                     var localDest   = document.all.localidadDestino.value;
                     var calleDest   = document.all.calleDestino.value;
                     
                     var localOriNew  = document.all.dsMunDel.value;
                     var calleOriNew  = document.all.CalleNum.value;
                     var localDestNew = document.all.dsMunDelDest.value;
                     var calleDestNew = document.all.CalleNumDest.value;
                     
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
                     if ( localDest.toString() !== localDestNew.toString() ) {
                         var localDestDet = localDest===''?'S/D':localDest;
                         var localDestNewDet = localDestNew===''?'S/D':localDestNew;
                         detCambiosDireccion = detCambiosDireccion.concat(' / CAMBIO LOC. DEST: '+ localDestDet + " -> "+localDestNewDet);
                     }
                     if ( calleDest.toString() !== calleDestNew.toString() ) {
                         var calleDestDet = calleDest===''?'S/D':calleDest;
                         var calleDestNewDet = calleDestNew===''?'S/D':calleDestNew;
                         detCambiosDireccion = detCambiosDireccion.concat(' / CAMBIO CALLE DEST: '+ calleDestDet + " -> "+calleDestNewDet);
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
                var detExpediente = '[* UBICACION: ' + ubicacion;
                
                if ( ubicacion.toString().toUpperCase() === 'AUTOPISTA' ) {
                    var comboboxes  = document.getElementById("clEstacionamientoC");
                    var estacionadoEn = comboboxes.options[comboboxes.selectedIndex].text;
                    detExpediente = detExpediente.concat(' - ' + estacionadoEn);
                }
                
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

               	if (clTipoFalla > 0 ) {
                    var combo = document.getElementById("clTipoFallaC");
                    var str = combo.options[combo.selectedIndex].text;
                    detExpediente = detExpediente.concat(' - FALLA : ' +str);
                    if ( str.toString().toUpperCase() === 'ACCIDENTE') {
                        if ( vehiculoLiberado === '1') {
                            detExpediente = detExpediente.concat(' -  VEHICULO LIBERADO');
                        } else {
                            detExpediente = detExpediente.concat(' -  VEHICULO NO LIBERADO');
                        }
                    } else {
                        detExpediente = detExpediente.concat(' DESC. FALLA: ' + detalleFalla);
                    }
                }
                
                if ( automatico === '1' ) {
                    detExpediente = detExpediente.concat(' -  CAJA AUTOMATICA ');
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
                


                
                if ( clCantPersona > 0 ) {
                    var combo = document.getElementById("clCantPersonaC");
                    var str = combo.options[combo.selectedIndex].text;
                    detExpediente = detExpediente.concat(' - CANT PERSONAS : ' + str);
                    
                    if (cantidadPersonas.toString().toUpperCase() === 'VH VIAJA SOLO') {
                        detExpediente = detExpediente.concat(' - RECIBE NOMBRE : ');
                        detExpediente = detExpediente.concat( recibeNombre +', TELEFONO : ' + recibeCodArea + ' ' + recibeNroTelef);
                        if ( cedulaVerdeVig === 1 ) {
                            detExpediente = detExpediente.concat(' - CEDULA VERDE VIG.');
                        }
                    }
                    
                }
                
                if ( ruedasDuales === '1' ) {
                    detExpediente = detExpediente.concat(' - TIENE RUEDAS DUALES ');
                }

                if ( tieneCarga === '1' ) {
                    detExpediente = detExpediente.concat(' / CARGA: ' + tipoCarga + ' PESO: ' + pesoCarga);
                }
                
                if ( clModifAuto > 0 ) {
                    if ( detExpediente === '' ) {
                       detExpediente = detExpediente.concat(' / MODIF: ');
                    } else {
                       detExpediente = detExpediente.concat('- MODIF: ');
                    }
                    var comboboxm  = document.getElementById("clModifAutoC");
                    var tipoModificacion = comboboxm.options[comboboxm.selectedIndex].text;
                    
                    
                    if ( tipoModificacion.toString().toUpperCase() === 'SUSPENSIÓN BAJA') {
                        detExpediente = detExpediente.concat('SUSPENSION BAJA, DIST.PISO: ' + distanciaPiso.toString() + ' CM.');
                    }
                    
                    if ( tipoModificacion.toString().toUpperCase() === 'CAJA MUDANCERA' ||
                            tipoModificacion.toString().toUpperCase() === 'CAJA TÉRMICA') {
                        
                        if ( tipoModificacion.toString().toUpperCase() === 'CAJA MUDANCERA' ) {
                            detExpediente = detExpediente.concat('CAJA MUDANCERA, ');
                        } else {
                            detExpediente = detExpediente.concat('CAJA TERMICA, ');
                        }
                        detExpediente = detExpediente.concat('ALTO: ' + alto.toString() + ' M. ' +
                                'LARGO: ' + largo.toString() + ' M.');
                    }
                    
                    if ( tipoModificacion.toString().toUpperCase() === 'OTRO' ) {
                        detExpediente = detExpediente.concat(detalleModif);
                    }

                }
                if ( servicioProgramado.toString() === '1') {
                    var FechaC = fechaProgramado.toString().substring(0, 10); 
                    detExpediente = detExpediente.concat(' - SERVICIO PROGRAMADO:' );
                    detExpediente = detExpediente.concat(' FECHA : ' + FechaC);
                    detExpediente = detExpediente.concat(' HORA DESDE : ' + horaDesdeProg);
                    detExpediente = detExpediente.concat(' HORA HASTA : ' + horaHastaProg);
                }
               
                if (coberturaTotalPeaje === '1' || peajesCubiertos.toString() === '1' ) {
                    detExpediente = detExpediente.concat(' - PEAJES CUBIERTOS :' );
                    var montoString = '';
                    montoString = coberturaTotalPeaje === '1'? 'COBERTURA TOTAL' : montoCubierto;
                    detExpediente = detExpediente.concat(' TOPE PESOS : ' + montoString);
                }
                /*detExpediente = detExpediente.concat(' - DISTANCIA KM : ' + kmAsistencia);*/
                detExpediente = detExpediente.concat(' *]');
                
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
                lugarEncajado : 0,
                lucesEncienden : 0,
		ruedaAuxEnCond : 0,
		tuercaSeguridad : 0,
		llaveTuercaSeg : 0,
		clTipoGasolina : 0,
		clCantLitros : 0,
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
                coberturaTotalPeaje: coberturaTotalPeaje,
                peajesCubiertos : peajesCubiertos,
                montoCubierto : montoCubierto,
                clEstacionamiento : clEstacionamiento,
                cambiosOrigenDest : cambiosOrigenDest,
                kmAsistencia : kmAsistencia};
            $.when(
		$.ajax({
			type: "POST",
			url: "./InsertInfoAdicionalKM0.jsp",
			//crossDomain: false,
			//cache: false,
                        async:false,
			data: datos,
			dataType: 'json',
			success: function(responseData, status, xhr) {
                        var nuevaClave = responseData.clave.toString();
                        
                        fnOpenWindow();
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
					alert("Error grabando InfoAdicional:  " + error);
				}
			}
		})).then( successFunc(), failureFunc() );
	
            }            


                

                
        </script>
         <!-- script async defer src="//maps.googleapis.com/maps/api/js?libraries=places&key=<//%=//ar.com.ike.geo.Geolocalizacion.GOOGLE_API_KEY%>&callback=initMap" / -->
    </body>
        <%
            daoAV = null;
            AV = null;
            rs.close();
            rs = null;
            rsDatosAfil.close();
            rsDatosAfil = null;
        %>
</html>