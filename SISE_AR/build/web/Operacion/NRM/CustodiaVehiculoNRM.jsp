<%@page contentType="text/html, charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC, Utilerias.ResultList"%>
<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Bootstrap/bootstrap.min.css" rel="stylesheet"  type="text/css">
        <link href="../../StyleClasses/UsuariosNRM.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/AlertaNRM.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/MapStyles.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <%
            String StrclUsrApp = "0";
            String clExpediente = "";
            String clVinTspPseudo = "";
            String vinTspPseudo = "";
            String espejo = "0";
            String clPais = "0";
            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp, 10)) != true) {
        %>Fuera de Horario<%
                StrclUsrApp = null;
                return;
            }

            if (request.getParameter("clExpediente") != null) {
                clExpediente = request.getParameter("clExpediente").toString();
                System.out.println("El clExpediente que llego es: " + clExpediente);
            }

            if (request.getParameter("clVinTspPseudo") != null) {
                clVinTspPseudo = request.getParameter("clVinTspPseudo").toString();
                System.out.println("El clVinTspPseudo que llego es: " + clVinTspPseudo);
            }

            if (request.getParameter("vinTspPseudo") != null) {
                vinTspPseudo = request.getParameter("vinTspPseudo").toString();
                System.out.println("El vinTspPseudo que llego es: " + vinTspPseudo);
            }

            if (request.getParameter("espejo") != null) {
                espejo = request.getParameter("espejo").toString();
                System.out.println("El espejo que llego es: " + espejo);
            }

            if (request.getParameter("clPais") != null) {
                clPais = request.getParameter("clPais").toString();
                System.out.println("El clPais que llego es: " + clPais);
            }

            String StrclPaginaWeb = "6178";
            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb, 10), Integer.parseInt(StrclUsrApp, 10));
        %>
        <div class="container-fluid">
            <div id="botonera" class="row">

                <%if (espejo.equals("1")) {%>
                <button class="btn btn-secondary" onclick="fn_nrm_RedirectListaExpedientes(); return false;">Regresar</button> 
                <%} else {%>
                <button class="btn btn-secondary" onclick="fn_nrm_RedirectTracking(<%=clExpediente%>, <%=clVinTspPseudo%>, '<%=vinTspPseudo%>', <%=clPais%>); return false;">Regresar</button> 
                <%}%>
                <button class="btn btn-secondary" onclick="fn_nrm_GuardarCustodia(<%=StrclUsrApp%>, <%=clExpediente%>); return false;">Guardar</button>
                <!--<button class="btn btn-secondary" onclick="">Actualizar</button>-->
                <%if (espejo.equals("1")) {%>
                <button class="btn btn-secondary" onclick="fn_nrm_RedirectListaExpedientes(); return false;">Cancelar</button> 
                <%} else {%>
                <!--<button class="btn btn-secondary" onclick="fn_nrm_RedirectListaUsuarios(); return false;">Cancelar</button>-->
                <%}%>
                <button id="btnSeguimiento" class="btn btn-primary" onclick="window.open('MonitoreoTrackingNRM.jsp?tiempo=30&clexpediente=<%=clExpediente%>', '', 'location=no,resizable=yes,menubar=0,scrollbars=no,left=0,status=0,toolbar=0,height=650,width=1280,top=0');">Seguimiento</button> 
                <button class="btn btn-primary" onclick="fn_nrm_LoadMapTrack();">Rastreo</button> 
                <button class="btn btn-primary" onclick="fn_nrm_Fotografico(<%=clVinTspPseudo%>);
                        return false;" style="width: 15%;">Registro Fotografico</button> 
                <button class="btn btn-primary" onclick="fn_nrm_Inventario(<%=clVinTspPseudo%>); return false;">Inventario</button> 
                <button id="btnActualiza" class="btn btn-warning" onclick="fn_nrm_ActualizaStatus(<%=clExpediente%>, <%=clVinTspPseudo%>, <%=StrclUsrApp%>); return false;">Actualiza Estatus</button> 
                <button id="btnActualizaTodo" class="btn btn-warning" onclick="fn_nrm_ActualizaTodo(); return false;">Actualiza Todo</button>
            </div>

            <form id="infoUsuario">
                <div class="row">
                    <div class="col-sm-3 col-md-3 col-lg-3 col-xl-3">
                        <label for="expediente">NO EXPEDIENTE IKE</label>
                        <input type="text" class="form-control" id="expediente" value="<%=clExpediente%>" readonly="true">
                    </div>
                </div>
                <fieldset style="border-color: #507fb3 !important;">
                    <legend>Ultima Ubicacion del Vehiculo:</legend>
                    <div class="row">
                        <div class="col-sm-12 col-md-2 col-lg-2 col-xl-2">
                            <label for="latitud">Latitud</label>
                            <input type="text" class="form-control" id="latitud" readonly="true">
                        </div>
                        <div class="col-sm-12 col-md-2 col-lg-2 col-xl-2">
                            <label for="longitud">Longitud</label>
                            <input type="text" class="form-control" id="longitud" readonly="true">
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-6 col-xl-6">
                            <label for="direccionUltimoPunto">Direccion</label>
                            <input type="text" class="form-control" id="direccionUltimoPunto" readonly="true">
                        </div>
                        <div class="col-sm-12 col-md-1 col-lg-1 col-xl-1" style="line-height: 75px;">
                            <button class="btn btn-warning" onclick="fn_nrm_UltimaUbicacion(<%=clVinTspPseudo%>); return false;" style="font-size: 12px;">Actualizar</button> 
                        </div>
                    </div>
                </fieldset>
                <fieldset style="border-color: #507fb3 !important;">
                    <legend>Ubicacion en la que Inicia el Monitoreo del Vehiculo:</legend>
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-2 col-xl-2">
                            <label>Monitoreo Exitoso?</label>
                            <br>
                            <div class="row">
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: center;">
                                    <input type="radio"id="siTracking" name="tracking" disabled="true">
                                    <label for="siTracking">Si</label>
                        </div>
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: left;">
                                    <input type="radio" id="noTracking" name="tracking" disabled="true">
                                    <label for="noTracking">No</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-12 col-lg-4 col-xl-4">
                            <label>Estatus Monitoreo del Vehiculo</label>
                            <br>
                            <label id="porcentajeMonitoreo"></label>
                        </div>
                        
                        <%if (espejo.equals("1")) {%>
                        <div class="col-sm-12 col-md-12 col-lg-6 col-xl-6">
                            <label for="inicioTracking">Ubicacion del Vehiculo</label>
                            <input type="text" class="form-control" id="inicioTracking" maxlength="150" value=''>
                        </div>
                        <%}%>

                    </div>
                    <%if (espejo.equals("1")) {%>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="fechaInicioRegistro">Fecha y Hora del Registro</label>
                            <input type="datetime-local" class="form-control" name="fechaInicioRegistro" id="fechaInicioRegistro" style="margin: auto; font-size: 14px !important;">
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="estatusInicioServicio">Estatus del Servicio</label>
                            <!--<select class="form-control" id="estatusInicioServicio"></select>-->
                            <input type="text" class="form-control" id="estatusInicioServicio" maxlength="20" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="velocidadInicio">Velocidad</label>
                            <input type="text" class="form-control" id="velocidadInicio" maxlength="20" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="estatusInicioArranque">Estado del Vehiculo</label>
                            <select class="form-control" id="estatusInicioArranque"></select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="nivelInicioBateria">Nivel de Bateria</label>
                            <input type="text" class="form-control" id="nivelInicioBateria" maxlength="20" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="kilometrajeInicio">Kilometraje</label>
                            <input type="text" class="form-control" id="kilometrajeInicio" maxlength="20" value=''>
                        </div>
                        <div id="folio911Div" class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="folio911">Folio Reporte 911</label>
                            <input type="text" class="form-control" id="folio911" maxlength="20" value=''>
                        </div>
                        <div id="folioRepuveDiv" class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="folioRepuve">Folio Reporte REPUVE</label>
                            <input type="text" class="form-control" id="folioRepuve" maxlength="20" value=''>
                        </div>
                    </div>
                    <div class="row">
                        <div id="portanArmasDiv" class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label>Portan Armas?</label> 
                            <br>
                            <div class="row">
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: center;">
                                    <input type="radio" id="siArmas" name="armas">
                                    <label for="siArmas">Si</label>
                        </div>
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: left;">
                                    <input type="radio" id="noArmas" name="armas">
                                    <label for="noArmas">No</label>
                                </div>
                            </div>
                        </div>
                        <div id="tipoArmaDiv" class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="tipoArma">Tipo de Arma</label>
                            <select class="form-control" id="tipoArma"></select>
                        </div>
                        <div id="noAsaltantesDiv" class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="noAsaltantes">No. de Asaltantes</label>
                            <input type="number" class="form-control" id="noAsaltantes" maxlength="20" value=''>
                        </div>
                    </div>
                    <%}%>
                </fieldset>
                <fieldset style="border-color: #507fb3 !important;">
                    <legend>Informacion del Custodio:</legend>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="noFolio">No. de Folio</label>
                            <input type="text" class="form-control" id="noFolio" maxlength="20" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="escoltaAsignado">Escolta Asignado</label>
                            <input type="text" class="form-control" id="escoltaAsignado" maxlength="150" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="lada">Lada</label>
                            <input type="number" class="form-control" id="lada" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="telefono">Telefono</label>
                            <input type="number" class="form-control" id="telefono" value=''>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="pais">Pais</label>
                            <select onchange="fn_nrm_LlenaEntidadFederativa()" class="form-control" id="pais"></select>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="estado">Estado</label>
                            <select onchange="fn_nrm_LlenaMunicipioDelegacion()" class="form-control" id="estado"></select>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="municipioAlcaldia">Municpio / Alcaldia</label>
                            <select class="form-control" id="municipioAlcaldia"></select>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="colonia">Colonia</label>
                            <input type="text" class="form-control" id="colonia" maxlength="20" value=''>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-6 col-xl-6">
                            <label for="fechaAsignacion">Fecha y Hora de Asignacion</label>
                            <input type="datetime-local" class="form-control" name="fechaAsignacion" id="fechaAsignacion" style="margin: auto; font-size: 14px !important;">
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-6 col-xl-6">
                            <label for="tiempoArribo">Tiempo Estimado de  Arribo</label>
                            <select class="form-control" id="tiempoArribo"></select>
                        </div>
                    </div>
                </fieldset>

                <fieldset style="border-color: #507fb3 !important;">
                    <legend>Seguimiento del Custodio:</legend>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="estatus">Estatus</label>
                            <select class="form-control" id="estatus"></select>
                        </div>

                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label>Llegada de Custodio?</label>
                            <br>
                            <div class="row">
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: center;">
                                    <input type="radio" id="siLlegadaCustodio" name="llegadaCustodio">
                                    <label for="siLlegadaCustodio">Si</label>
                        </div>
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: left;">
                                    <input type="radio" id="noLlegadaCustodio" name="llegadaCustodio">
                                    <label for="noLlegadaCustodio">No</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label>Vehiculo en la Ubicacion?</label>
                            <br>
                            <div class="row">
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: center;">
                                    <input type="radio" id="siVehiculoUbicacion" name="vehiculoUbicacion">
                                    <label for="siVehiculoUbicacion">Si</label>
                        </div>
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: left;">
                                    <input type="radio" id="noVehiculoUbicacion" name="vehiculoUbicacion">
                                    <label for="noVehiculoUbicacion">No</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label>Reporta a las Autoridades?</label>
                            <br>
                            <div class="row">
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: center;">
                                    <input type="radio" id="siAutoridades" name="reporteAutoridad">
                                    <label for="siAutoridades">Si</label> 
                        </div>
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: left;">
                                    <input type="radio" id="noAutoridades" name="reporteAutoridad">
                                    <label for="noAutoridades">No</label>
                    </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label>Zona Accesible para la Autoridad?</label>
                            <br>
                            <div class="row">
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: center;">
                                    <input type="radio" id="siAccesible" name="accesibleAutoridad">
                                    <label for="siAccesible">Si</label>
                        </div>
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: left;">
                                    <input type="radio" id="noAccesible" name="accesibleAutoridad">
                                    <label for="noAccesible">No</label>
                        </div>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="tipoUbicacion">Tipo Ubicacion</label>
                            <select class="form-control" id="tipoUbicacion" onchange="fn_nrm_ValidaTipoUbicacion()"></select>
                        </div>
                        <div id="divNivel" class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="nivel">Nivel</label>
                            <input type="number" class="form-control" id="nivel" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="tipoPropiedad">Tipo de Propiedad</label>
                            <select class="form-control" id="tipoPropiedad"></select>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label>Llegada de las Autoridades?</label>
                            <br>
                            <div class="row">
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: center;">
                                    <input type="radio" id="siLlegadaAutoridades" name="llegadaAutoridades">
                                    <label for="siLlegadaAutoridades">Si</label>
                        </div>
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: left;">
                                    <input type="radio" id="noLlegadaAutoridades" name="llegadaAutoridades">
                                    <label for="noLlegadaAutoridades">No</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="fechaAutoridades">Fecha y Hora LLegada Autoridades</label>
                            <input type="datetime-local" class="form-control" name="fechaAutoridades" id="fechaAutoridades" style="margin: auto; font-size: 14px !important;">
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="autoridadPresente">Autoridad que se Presenta</label>
                            <select class="form-control" id="autoridadPresente"></select>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="noOficiales">Numero de Oficiales</label>
                            <input type="number" class="form-control" id="noOficiales" value=''>
                        </div>
                    </div>
                    <div class="row">

                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="idPatrulla">ID de Patrulla en la Ubicacion</label>
                            <input type="text" class="form-control" id="idPatrulla" maxlength="20" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label>Realiza Inventario?</label>
                            <br>
                            <div class="row">
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: center;">
                                    <input type="radio"id="siInventario" name="inventario">
                                    <label for="siInventario">Si</label>
                        </div>
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: left;">
                                    <input type="radio" id="noInventario" name="inventario">
                                    <label for="noInventario">No</label>
                                </div>
                            </div>
                        </div>
                        <div id="divFolioInventario" class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="folioInventario">No Folio Inventario</label>
                            <input type="text" class="form-control" id="folioInventario" maxlength="20" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="condicionesVehiculo">Condiciones del Vehiculo</label>
                            <select class="form-control" id="condicionesVehiculo"></select>
                        </div>
                    </div>
                    <div class="row">

                        <div class="col-sm-12 col-md-12 col-lg-3 col-xl-3">
                            <label for="disposicionAutoridad">A Disposicion de Autoridad</label>
                            <select class="form-control" id="disposicionAutoridad"></select>
                        </div>
                        <div class="col-sm-12 col-md-12 col-lg-9 col-xl-9">
                            <label for="infoAdicional">Informacion Adicional</label>
                            <input type="text" class="form-control" id="infoAdicional" value=''>
                        </div>

                        </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-4 col-xl-4" style="text-align: center;">
                            <label>Solicita Bloqueo del Vehiculo?</label>
                            <br>
                            <div class="row">
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: right;">
                                    <input type="radio"  id="siBloqueo"  name="solBloqueo">
                                    <label  for="siBloqueo" >Si</label>
                    </div>
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: left;">
                                    <input type="radio"  id="noBloqueo"  name="solBloqueo">
                                    <label  for="noBloqueo">No</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-4 col-xl-4" style="text-align: center;">
                            <label>Solicita Desbloqueo del Vehiculo?</label>
                            <br>
                    <div class="row">
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: right;">
                                    <input type="radio" id="siDesbloqueo" name="desbloqueo">
                                    <label for="siDesbloqueo" >Si</label>  
                        </div>
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: left;">
                                    <input type="radio" id="noDesbloqueo" name="desbloqueo">
                                    <label for="noDesbloqueo">No</label>
                    </div>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-4 col-xl-4" style="text-align: center;">
                            <label>Solicita Desmonitoreo del Vehiculo?</label>
                            <br>
                            <div class="row">
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: right;">
                                    <input type="radio" id="siUntracking" name="untracking">
                                    <label for="siUntracking">Si</label>
                                </div>
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: left;">
                                    <input type="radio" id="noUntracking" name="untracking">
                                    <label for="noUntracking">No</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="text-align: center;">
                        <div class="col-sm-12 col-md-12 col-lg-4 col-xl-4">
                            <br>
                            <label>Estatus Bloqueo del Vehiculo</label>
                            <br>
                            <label id="porcentajeBloqueo"></label>
                        </div>
                        <div class="col-sm-12 col-md-12 col-lg-4 col-xl-4">
                            <br>
                            <label>Estatus Desbloqueo del Vehiculo</label>
                            <br>
                            <label id="porcentajeDesbloqueo"></label>
                        </div>
                        <div class="col-sm-12 col-md-12 col-lg-4 col-xl-4">
                            <br>
                            <label>Estatus Desmonitoreo del Vehiculo</label>
                            <br>
                            <label id="porcentajeDesmonitoreo"></label>
                        </div>
                    </div>
                </fieldset>

                <fieldset style="border-color: #507fb3 !important;">
                    <legend>Destino del Vehiculo</legend>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-4 col-xl-4">
                            <label>Traslado por Autoridad?</label>
                            <br>
                            <div class="row">
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: center;">
                                    <input type="radio" id="siTraslado" name="traslado">
                                    <label for="siTraslado">Si</label>  
                        </div>
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: left;">
                                    <input type="radio" id="noTraslado" name="traslado">
                                    <label for="noTraslado">No</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-4 col-xl-4">
                            <label for="tipoDestino">Tipo de Destino</label>
                            <select class="form-control" id="tipoDestino"></select>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-4 col-xl-4">
                            <label for="estadoDestino">Estado</label>
                            <select onchange="fn_nrm_LlenaMunicipioDelegacionDestino('estadoDestino', 'municipioDestino')" class="form-control" id="estadoDestino"></select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-4 col-xl-4">
                            <label for="municipioDestino">Municipio / Alcaldia</label>
                            <select class="form-control" id="municipioDestino"></select>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-4 col-xl-4">
                            <label for="coloniaDestino">Colonia</label>
                            <input type="text" class="form-control" id="coloniaDestino" maxlength="20" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-4 col-xl-4">
                            <label for="cpDestino">C.P.</label>
                            <input type="number" class="form-control" id="cpDestino" value=''>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-4 col-xl-4">
                            <label for="calleNumeroDestino">Calle y Numero</label>
                            <input type="text" class="form-control" id="calleNumeroDestino" maxlength="20" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-4 col-xl-4">
                            <label for="refVisualesDestino">Referencias Visuales</label>
                            <input type="text" class="form-control" id="refVisualesDestino" maxlength="20" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-4 col-xl-4">
                            <label>Ingreso a Resguardo Oficial?</label>
                            <br>
                            <div class="row">
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: center;">
                                    <input type="radio" id="siResguardo" name="resguardo">
                                    <label for="siResguardo">Si</label>  
                        </div>
                                <div class="col-sm-6 col-md-6 col-lg-6 col-xl-6" style="text-align: left;">
                                    <input type="radio" id="noResguardo" name="resguardo">
                                    <label for="noResguardo">No</label>
                    </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>

        <!-- Alerta falta de datos informacion usuario -->
        <div id="alertInfoCustodia" class="alerta" style="z-index: 300">
            <!-- Modal content -->
            <div class="alerta-content" style="text-align: center;border: 16px solid #062f67;overflow-y: auto; max-height: 400px;">
                <span id="alertaCloseInfoCustodia" class="alerta-close">&times;</span>
                <h3 style="text-align:center;color: red;">Alerta</h3>
                <p style="text-align:center;background-color: #afc3e0;color: #062f67;"> La siguiente informacion es requerida:</p>
                <div style="overflow-x:auto;">
                    <table id="tablaFaltaInfo">
                    </table>
                </div>  
                <br>
            </div>
        </div>

        <!-- Alerta de Tracking -->
        <!--        <div id="process" class="alerta" style="z-index: 300;">
                     Modal content 
                    <div class="alerta-content" style="text-align: center;border: 16px solid #062f67;">
                        <span id="alerta-close-tracking" class="alerta-close">&times;</span>
                        <progress max="100">Procesando...</progress>
                    </div>
                </div>-->

        <div id="process" class="alerta" style="z-index: 300;">
            <!-- Modal content -->
            <div style="text-align: center; margin: auto;">
                <!--<span id="alerta-close-tracking" class="alerta-close">&times;</span>-->
                <!--<progress max="100">Procesando...</progress>-->
                <img src="../../Imagenes/Loading.gif" style="position: static;">
                <p style="color: white; font-size: x-large;">Su peticion se esta procesando...</p>
            </div>
        </div>

        <!-- Alerta de Tracking -->
        <div id="alertCustodia" class="alerta" style="z-index: 300">
            <!-- Modal content -->
            <div class="alerta-content" style="text-align: center;border: 16px solid #062f67;">
                <span id="alertaCloseCustodia" class="alerta-close">&times;</span>
                <h3 style="text-align:center;color: red;">Notificacion</h3>
                <p style="text-align:center;background-color: #afc3e0;color: #062f67;">Informacion</p>
                <div style="overflow-x:auto;">
                    <p id="messageCustodia"></p>
                </div>  
                <br>
            </div>
        </div>

        <div  class="modal-opacity" id="mModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" scrolling="no">
            <div id="clobtn"  class="buttons red-buttons fas fa-close" scrolling="no">X</div> 
            <iframe class="int-content" id="urlmT" name="urlmT" class="" src="" scrolling="no" frameborder="0" value="0"></iframe>
        </div>

        <script src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/v1/Bootstrap/respond.min.js' charset="UTF-8" ></script>
        <script src='../../Utilerias/v1/Ajax.js'></script> 
        <script src='js/CustodiaVehiculoNRM.js'></script> 
        <script src='../../Utilerias/LoadMapNRM.js'></script>
        <script>
                                fn_nrm_ActualizaStatus(<%=clExpediente%>, <%=clVinTspPseudo%>, <%=StrclUsrApp%>);
                                fn_nrm_OcultarElementos();
                                fn_nrm_ConsumeCombo("[st_nrm_GetTipoArma]", "tipoArma");
                                fn_nrm_ConsumeCombo("[st_nrm_GetServiceState]", "estatusInicioServicio");
                                fn_nrm_ConsumeCombo("[st_nrm_GetVehicleState]", "estatusInicioArranque");
                                fn_nrm_ConsumeCombo("[st_nrm_GetTiempoArribo]", "tiempoArribo");
                                fn_nrm_ConsumeCombo("[st_nrm_GetEstatusCustodio]", "estatus");
                                fn_nrm_ConsumeCombo("[st_nrm_GetAutoridad]", "autoridadPresente");
                                fn_nrm_ConsumeCombo("[st_nrm_GetAutoridad]", "disposicionAutoridad");
                                fn_nrm_ConsumeCombo("[st_nrm_GetTipoUbicacion]", "tipoUbicacion");
                                fn_nrm_ConsumeCombo("[st_nrm_GetCondicionesVehiculo]", "condicionesVehiculo");
                                fn_nrm_ConsumeCombo("[st_nrm_GetTipoPropiedad]", "tipoPropiedad");
                                fn_nrm_ConsumeCombo("[st_nrm_GetTipoDestini]", "tipoDestino");
                                fn_nrm_ConsumeCombo("[st_CatalogoEntidadFederativa]", "estado");
                                fn_nrm_ConsumeCombo("[st_CatalogoEntidadFederativa]", "estadoDestino");
                                fn_nrm_ConsumeCombo("[st_nrm_Paises]", "pais");
                                fn_nrm_ConsultarTrackingGuardado(<%=clExpediente%>, <%=clVinTspPseudo%>, '<%=vinTspPseudo%>', <%=StrclUsrApp%>);
                                fn_nrm_ConsultarSeguimientoCustodioGuardado(<%=clExpediente%>);
                                fn_nrm_ConsultarInfoCustodioGuardado(<%=clExpediente%>, <%=clPais%>);
                                fn_nrm_ConsultarDestinoVehiculoGuardado(<%=clExpediente%>);
                                fn_nrm_UltimaUbicacion(<%=clVinTspPseudo%>);
                                if (<%=espejo%> === 1) {
                                    fn_nrm_ConsultarAsistenciaGuardada(<%=clExpediente%>);
                                }
                                function fn_nrm_LoadMapTrack() {
                                    console.dir('Cargando Mapa Monitoreo...');
                                    fn_nrm_CreateJsonTracking(<%=clExpediente%>);
                                }

                                function fn_nrm_ActualizaTodo() {
                                    fn_nrm_ActualizaStatus(<%=clExpediente%>, <%=clVinTspPseudo%>, <%=StrclUsrApp%>);
                                    fn_nrm_ConsultarTrackingGuardado(<%=clExpediente%>, <%=clVinTspPseudo%>, '<%=vinTspPseudo%>', <%=StrclUsrApp%>);
                                    fn_nrm_ConsultarSeguimientoCustodioGuardado(<%=clExpediente%>);
                                    fn_nrm_ConsultarInfoCustodioGuardado(<%=clExpediente%>);
                                    fn_nrm_ConsultarDestinoVehiculoGuardado(<%=clExpediente%>);
                                    fn_nrm_UltimaUbicacion(<%=clVinTspPseudo%>);
                                }
        </script>
    </body>
</html>
