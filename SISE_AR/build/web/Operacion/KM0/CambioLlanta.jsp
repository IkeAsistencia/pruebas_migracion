<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="com.ike.asistencias.DAOAsistenciaVial,com.ike.asistencias.to.AsistenciaVial,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<%@ page import="ar.com.ike.geo.Geolocalizacion" %>
<html>
    <head>
        <title>Cambio de Neumático</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src="../../Geolocalizacion/modernizr-custom.js"></script>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAuto.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>
        <script type="text/javascript" src="../../Geolocalizacion/js/jquery.js"></script>
        <script type="text/javascript" src="../../Geolocalizacion/js/mapUtils.js"></script>
        <%
            String StrclUsrApp = "0";
            String StrclExpediente = "";
            String StrclPaginaWeb = "199";

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
            String StrCodigoMarca = "";
            String StrClaveAMIS = "";
            String StrDsTipoAuto = "";

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
            }
            else {
                out.println("ERROR NO SE PUEDE OBTENER DATOS DEL EXPEDIENTE");
                return;
            }
            /* NO DEBE SACARLO DE LA SESSION SI YA OBTUVO LOS DATOS DESDE sp_DetalleExpediente                        
            if (session.getAttribute("clCuenta") != null) {
                StrclCuenta = session.getAttribute("clCuenta").toString();
            }
            if (session.getAttribute("Clave") != null) {
                StrClave = session.getAttribute("Clave").toString();
            }
            */
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %>Fuera de Horario<%
                return;
            }

            StringBuffer StrSql = new StringBuffer();
            DAOAsistenciaVial daoAV = null;
            AsistenciaVial AV = null;

            StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            int iRowPx = 0;
            if (rs.next()) {
                daoAV = new DAOAsistenciaVial();
                AV = daoAV.getAsistenciaVial(StrclExpediente);
                StrclMarcaAuto = AV != null ? AV.getClMarca() : "0";
            } else {
                %> El expediente no existe <%
                rs.close();
                rs = null;
                return;
            }

            StrSql.append(" st_getDatosAfiliadoGral '").append(StrClave).append("','").append(StrclCuenta).append("'");
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
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(199, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "fnValLugar();fnLlenaComboAuto();", "fnValLugar();", "")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="CambioLlanta.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <% iRowPx = 80; %>
        <%=MyUtil.ObjComboMem("Pais", "clPais", StrdsPais, StrclPais, cbPais.GeneraHTML(20, StrdsPais), false, false, 30, iRowPx, StrclPais, "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
        <!-- GEOLOC TARGET LOCAL-->
        <% 
        String sTmpDirA = new String( StrdsEntFed + ", " + StrdsMunDel + ", " + (AV != null ? AV.getCalleO(): "") );
        //iRowPx = iRowPx + 30;
        %>
        <!-- %=MyUtil.ObjInput("Direccion", "DireccionA", sTmpDirA ,  false, false, 30,iRowPx, "", true, true, 80 )% -->
        <input type="hidden" name="DireccionA" id="DireccionA" value="<%=sTmpDirA%>" >
        <%        iRowPx = iRowPx + 30;        %>
        <div class='VTable' style='position:absolute; z-index:20; left:510px; top:<%=iRowPx+16%>px; '>
            <INPUT id="MapaOrig" type='button' VALUE='Mapa' onClick='openMap("DireccionA", "LatLong","CalleNum","dsMunDel","dsEntFed","CodMDOrigen","CodEntOrigen");return false;' class='cBtn'>
        </div>
        <%=MyUtil.ObjInput("Provincia", "dsEntFed", StrdsEntFed, false, false, 30, iRowPx, StrdsEntFed, false, false, 45)%>
        <%=MyUtil.ObjInput("Localidad", "dsMunDel", StrdsMunDel, false, false, 280, iRowPx, StrdsMunDel, false, false, 45)%>
        <input type="hidden" id="CodMDOrigen" name="CodMDOrigen" value="<%=StrCodMD%>">
        <input type="hidden" id="CodEntOrigen" name="CodEntOrigen" value="<%=StrCodEnt%>">
        <%
        iRowPx = iRowPx + 30;
        %>
        <%=MyUtil.ObjInput("Calle", "CalleNum",AV != null ? AV.getCalleO() : "", true, true, 30, iRowPx, "", false, false, 58)%>
        <%=MyUtil.ObjInput("Latitud y Longitud", "LatLong", AV != null ? AV.getGeoLatLong(): "", true, true, 330, iRowPx, "", false, false, 34)%>
        <%--
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", StrdsEntFed, StrCodEnt, cbEntidad.GeneraHTML(40, StrdsEntFed, Integer.parseInt(StrclPais)), false, false, 30, 120, StrCodEnt, "fnLLenaComboMDAjax(this.value);", "", 20, false, false, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", StrdsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(40, StrCodEnt, StrdsMunDel), false, false, 415, 120, StrCodMD, "", "", 20, false, false, "LocalidadDiv")%>
        <%=MyUtil.ObjInput("Calle y Número", "CalleNum", AV != null ? AV.getCalleO() : "", true, true, 30, 160, StrCalleNum, false, false, 106)%>
        --%>
        <%
        iRowPx = iRowPx + 30;
        %>
        <%=MyUtil.ObjTextArea("Referencias Visuales", "Referencias", AV != null ? AV.getReferenciasO() : "", "105", "5", true, true, 30, iRowPx, StrDescAuto, false, false)%>
        <%=MyUtil.DoBlock("Ubicación del Evento", 80, 40)%>
        <%
        //iRowPx = 330;
        iRowPx = 300;
        %>
        <%=MyUtil.ObjComboC("Marca de Auto", "CodigoMarca", AV != null ? AV.getDsMarca() : "", true, true, 30, iRowPx, StrCodigoMarca, "st_getMarcaAutoKM " + StrclExpediente, "fnLlenaTipoAutoAjax(this.value,'ClaveAMIS','Tipo de Auto','TipoAutoDiv','',2);", "", 50, true, false)%>
        <%=MyUtil.ObjComboCDiv("Tipo de Auto", "ClaveAMIS", AV != null ? AV.getDsTipoAuto() : "", true, true, 195, iRowPx, StrDsTipoAuto, "st_getTipoAutoKM '" + StrclMarcaAuto + "'," + StrclExpediente, "", "", 50, true, false, "TipoAutoDiv")%>
        <%
        iRowPx = iRowPx + 30;
        %>
        <%=MyUtil.ObjInput("Modelo", "Modelo", AV != null ? AV.getModelo() : "", true, true, 30, iRowPx, StrModelo, true, true, 6, "if(this.readOnly==false){fnValidaModelo(this)}")%>
        <%=MyUtil.ObjInput("Color", "Color", AV != null ? AV.getColor() : "", true, true, 100, iRowPx, StrColor, true, true, 10)%>
        <%=MyUtil.ObjInput("Patente", "Placas", AV != null ? AV.getPatente() : "", true, true, 190, iRowPx, StrPlacas, true, true, 8)%>
        <%//=MyUtil.ObjComboC("Lugar", "clLugarEvento", AV != null ? AV.getDsLugar() : "", true, true, 280, iRowPx, "", "select clLugarEvento, dsLugarEvento from cLugarEvento order by dsLugarEvento", "", "", 20, true, true)//%>
        <%=MyUtil.ObjComboC("Lugar", "clLugarEvento", AV != null ? AV.getDsLugar() : "", false, false, 280, iRowPx, "", "st_LugarEvento", "", "", 20, false, false)%>
        <%=MyUtil.DoBlock("Detalle Cambio de Neumático", 30, -10)%>
        <%=MyUtil.GeneraScripts()%>
        <script type="text/javascript">
            $(document).ready(function() {
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
                //$("#CalleNum").change(function() { document.getElementById("LatLong").value = ""; })
            });
            
            function initMap() {
                document.getElementById("DireccionA").disabled = true; 
                /*
                google.maps.event.addDomListener(window, 'load', function () {
                    autocomplete = new google.maps.places.Autocomplete(document.getElementById('DireccionA'), {types: ['address']});
                    autocomplete.setComponentRestrictions( {'country': ['ar']});
                    autocomplete.addListener('place_changed', fillInAddressAux);
                });
                */
            }
            
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

            function fnLlenaEntidadAjaxFn(cod) {  /// Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion
                IDCombo = 'CodEnt';
                Label = 'Provincia';
                IdDiv = 'CodEntDiv';
                FnCombo = 'fnLLenaComboMDAjax(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion=" + cod + "&IdCombo=" + IDCombo + "&Label=" + Label + "&FnCombo=" + FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
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
            
            function fnValLugar() {
                if (document.all.CodEntOrigen.value.toString() == '002') {
                    document.all.clLugarEventoC.value = 2;
                    document.all.clLugarEvento.value = 2;
                } else {
                    document.all.clLugarEventoC.value = 1;
                    document.all.clLugarEvento.value = 1;
                }
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
        </script>
        <!-- script async defer src="//maps.googleapis.com/maps/api/js?libraries=places&key=<%=ar.com.ike.geo.Geolocalizacion.GOOGLE_API_KEY%>&callback=initMap" / -->
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
