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
        <style>
            #map_canvas div div div:nth-child(6){
                display: flex !important;
                bottom: -6px !important;
            }
        </style>
    </head>
    <body class="cssBody">
        <%
            String StrclUsrApp = "0";
            String clExpediente = "";
            String StrclServicio = "";
            String StrclSubServicio = "0";
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

            if (session.getAttribute("clServicio") != null) {
                StrclServicio = session.getAttribute("clServicio").toString();
                System.out.println("El clServicio que llego es: " + StrclServicio);
            }
            if (session.getAttribute("clSubServicio") != null) {
                StrclSubServicio = session.getAttribute("clSubServicio").toString();
                System.out.println("El clSubServicio que llego es: " + StrclSubServicio);
            }

            String StrclPaginaWeb = "6176";

            StringBuffer StrSql = new StringBuffer();
            StrSql.append("st_nrm_LoadInfoDetalleAsistencia ").append(clExpediente);
            ResultList rs = new ResultList();
            rs.rsSQL(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            String clVinTspPseudo = "";
            String vechicleBrand = "";
            String modelName = "";
            String vehiclePlateNumber = "";
            String vehicleColor = "";
            String vinTspPseudo = "";
            String serviceCountry = "";
            if (rs.next()) {
                vechicleBrand = rs.getString("vechicleBrand");
                modelName = rs.getString("modelName");
                vehiclePlateNumber = rs.getString("vehiclePlateNumber");
                vehicleColor = rs.getString("vehicleColor");
                vinTspPseudo = rs.getString("vinTspPseudo");
                clVinTspPseudo = rs.getString("clVinTspPseudo");
                serviceCountry = rs.getString("serviceCountry");
            }

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb, 10), Integer.parseInt(StrclUsrApp, 10));
        %>
        <div class="container-fluid">
            <div id="botonera" class="row">
                <!--<button class="btn btn-secondary" onclick="fn_nrm_RedirectInfoUsuario(<%=clVinTspPseudo%>); return false;">Regresar</button>--> 
                <button id="btnGuardar" class="btn btn-secondary" onclick="fn_nrm_GuardarDetalleAsistencia('<%=StrclUsrApp%>', '<%=vinTspPseudo%>', '<%=clVinTspPseudo%>', '<%=clExpediente%>', '<%=StrclServicio%>', '<%=StrclSubServicio%>');
                        return false;">Guardar</button>
                <!--<button id="btnActualizar" class="btn btn-secondary" onclick="">Actualizar</button>-->
                <!--<button id="btnCancelar" class="btn btn-secondary" onclick="fn_nrm_RedirectListaUsuarios(); return false;">Cancelar</button>-->
                <button id="btnTracking" class="btn btn-success" onclick="fn_nrm_RedirectTracking(<%=clExpediente%>, <%=clVinTspPseudo%>, '<%=vinTspPseudo%>');
                        return false;" disabled="true">Tracking</button> 
                <button id="" class="btn btn-success" onclick="fn_nrm_Mapa(<%=clExpediente%>, <%=StrclUsrApp%>);">Mapa</button> 
            </div>

            <form id="infoUsuario">
                <fieldset style="border-color: #507fb3 !important;">
                    <legend>Datos del Vehiculo:</legend>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="marca">Marca</label>
                            <input type="text" class="form-control" id="marca" maxlength="50" value='<%=vechicleBrand%>' readonly="true">
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="subMarca">SubMarca</label>
                            <input type="text" class="form-control" id="subMarca" maxlength="50" value='<%=modelName%>' readonly="true">
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="anio">Anio</label>
                            <input type="text" class="form-control" id="anio" maxlength="4" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="placas">Placas</label>
                            <input type="text" class="form-control" id="placas" maxlength="8" value='<%=vehiclePlateNumber%>' readonly="true">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="color">Color</label>
                            <input type="text" class="form-control" id="color" maxlength="50" value='<%=vehicleColor%>' readonly="true">
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="noMotor">No. Motor</label>
                            <input type="text" class="form-control" id="noMotor" maxlength="8" value=''>
                        </div>
                    </div>
                </fieldset>

                <fieldset style="border-color: #507fb3 !important; height: 130px;">
                    <legend>Datos del Seguro:</legend>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label style="position: relative;">Cuenta con seguro?</label>
                            <input type="radio" class="form-check-input" id="siSeguro" style="position: absolute;top: 25px;left: 60px;" name="seguro">
                            <label class="form-check-label" for="siSeguro" style="position: absolute;top: 29px;left: 46px;">Si</label>              
                            <input type="radio" class="form-check-input" id="noSeguro" style="position: absolute;top: 25px;" name="seguro">
                            <label class="form-check-label" for="noSeguro" style="    position: absolute;top: 29px;left: 129px;">No</label>
                        </div>
                        <div id="aseguradoraDiv" class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="aseguradora">Aseguradora</label>
                            <select class="form-control" id="aseguradora"></select>
                        </div>
                        <div id="noPolizaDiv" class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="noPoliza">No. Poliza</label>
                            <input type="text" class="form-control" id="noPoliza" maxlength="20" value=''>
                        </div>
                        <div id="noSiniestroDiv" class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="noSiniestro">No. Siniestro</label>
                            <input type="text" class="form-control" id="noSiniestro" maxlength="20" value=''>
                        </div>
                    </div>
                </fieldset>

                <fieldset style="border-color: #507fb3 !important;">
                    <legend>Reporte de Robo:</legend>
                    <div class="row" style="height: 50px;">
                        <div class="col-sm-12 col-md-12 col-lg-4 col-xl-4">     
                            <label style="position: relative;">Tipo de Robo?</label>  
                            <input type="radio" class="form-check-input" id="robo" style="position: absolute;top: 25px;left: 60px;" name="tipoRobo">
                            <label class="form-check-label" for="robo" style="position: absolute;top: 29px;left: 46px;">Robo</label>                           
                            <input type="radio" class="form-check-input" id="hurto" style="position: absolute;top: 25px; left: 144px;" name="tipoRobo">
                            <label class="form-check-label" for="hurto" style="    position: absolute;top: 29px;left: 129px;">Hurto</label>
                        </div>
                        <div class="col-sm-12 col-md-12 col-lg-4 col-xl-4">
                            <label style="position: relative;">Reporte al 911?</label>                           
                            <input type="radio" class="form-check-input" id="si911" style="position: absolute;top: 25px;left: 60px;" name="911">
                            <label class="form-check-label" for="si911" style="position: absolute;top: 29px;left: 46px;">Si</label>                           
                            <input type="radio" class="form-check-input" id="no911" style="position: absolute;top: 25px; left: 144px;" name="911">
                            <label class="form-check-label" for="no911" style="    position: absolute;top: 29px;left: 129px;">No</label>
                        </div>
                        <div id="folio911Div" class="col-sm-12 col-md-12 col-lg-4 col-xl-4">
                            <label for="folio911">Folio Reporte 911</label>
                            <input type="text" class="form-control" id="folio911" maxlength="20" value='' style="width: 70%;">
                        </div>
                    </div>  
                    <div class="row" style="height: 50px;">
                        <div class="col-sm-12 col-md-12 col-lg-4 col-xl-4">

                        </div>
                        <div class="col-sm-12 col-md-12 col-lg-4 col-xl-4">
                            <label style="position: relative;">Reporte a REPUVE?</label>                           
                            <input type="radio" class="form-check-input" id="siRepuve" style="position: absolute;top: 25px;left: 60px;" name="repuve">
                            <label class="form-check-label" for="siRepuve" style="position: absolute;top: 29px;left: 46px;">Si</label>                           
                            <input type="radio" class="form-check-input" id="noRepuve" style="position: absolute;top: 25px;" name="repuve">
                            <label class="form-check-label" for="noRepuve" style="    position: absolute;top: 29px;left: 129px;">No</label>
                        </div>
                        <div id="folioRepuveDiv" class="col-sm-12 col-md-12 col-lg-4 col-xl-4">
                            <label for="folioRepuve">Folio Reporte REPUVE</label>
                            <input type="text" class="form-control" id="folioRepuve" maxlength="20" value='' style="width: 70%;">
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-4 col-xl-4">
                            <label for="fechaReporteAutoridades">Fecha y Hora Reporte Autoridades</label>
                            <input type="datetime-local" class="form-control" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}" name="fechaReporteAutoridades" id="fechaReporteAutoridades" style="font-size: 14px !important; width: 70%;">
                        </div>

                    </div>
                </fieldset>

                <fieldset style="border-color: #507fb3 !important;">
                    <legend>Ubicacion del Robo:</legend>
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
                            <label for="municipioAlcaldia">Municipio/Alcaldia</label>
                            <select class="form-control" id="municipioAlcaldia"></select>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="colonia">Colonia</label>
                            <input type="text" class="form-control" id="colonia" maxlength="50" value=''>
                        </div>
                    </div>
                    <div class="row" style="height: 70px;">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="cp">C.P.</label>
                            <input type="number" class="form-control" id="cp" maxlength="8" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="calleNumero">Calle y Numero</label>
                            <input type="text" class="form-control" id="calleNumero" maxlength="80" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-6 col-xl-6">
                            <label for="referencias">Referencias Visuales</label>
                            <input type="text" class="form-control" id="referencias" maxlength="150" value=''>
                        </div>
                    </div>
                </fieldset>

                <fieldset style="border-color: #507fb3 !important;">
                    <legend>Descripcion de lo Ocurrido:</legend>
                    <div class="row" style="height: 50px;">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label style="position: relative;">Robo con Violencia?</label>                           
                            <input type="radio" class="form-check-input" id="siViolencia" style="position: absolute;top: 25px;left: 60px;" name="violencia">
                            <label class="form-check-label" for="siViolencia" style="position: absolute;top: 29px;left: 46px;">Si</label>                           
                            <input type="radio" class="form-check-input" id="noViolencia" style="position: absolute;top: 25px; left: 144px;" name="violencia">
                            <label class="form-check-label" for="noViolencia" style="position: absolute;top: 29px;left: 129px;">No</label>
                        </div>
                        <div id="portanArmasDiv" class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label style="position: relative;">Portan Armas?</label>                           
                            <input type="radio" class="form-check-input" id="siArmas" style="position: absolute;top: 25px;left: 60px;" name="armas">
                            <label class="form-check-label" for="siArmas" style="position: absolute;top: 29px;left: 46px;">Si</label>                           
                            <input type="radio" class="form-check-input" id="noArmas" style="position: absolute;top: 25px; left: 144px;" name="armas">
                            <label class="form-check-label" for="noArmas" style="position: absolute;top: 29px;left: 129px;">No</label>
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
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12" style="text-align: center;">
                            <label for="fechaRobo">Fecha y Hora del Robo</label>
                            <input type="datetime-local" class="form-control" name="fechaRobo" id="fechaRobo" style="width: 17%; margin: auto; font-size: 14px !important; width: 23%;">
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>

        <!-- Alerta falta de datos informacion usuario -->
        <div id="alertInfoDetalle" class="alerta" style="z-index: 300">
            <!-- Modal content -->
            <div class="alerta-content" style="height: 300px; text-align: center;border: 16px solid #062f67;overflow-y: auto;">
                <span id="alertCloseDetalle" class="alerta-close">&times;</span>
                <h3 style="text-align:center;color: red;">Alerta</h3>
                <p style="text-align:center;background-color: #afc3e0;color: #062f67;"> La siguiente informacion es requerida:</p>
                <div style="overflow-x:auto;">
                    <table id="tablaFaltaInfo">
                    </table>
                </div>  
                <br>
            </div>
        </div>

        <!-- Alerta Guardado de Aistencia -->
        <div id="alertGuardadoAsistencia" class="alerta">
            <!-- Modal content -->
            <div class="alerta-content" style="text-align: center;border: 16px solid #062f67;">
                <span id="alertaCloseGuardado" class="alerta-close">&times;</span>
                <h3 style="text-align:center;color: red;">Notificacion</h3>
                <p style="text-align:center;background-color: #afc3e0;color: #062f67;">Informacion</p>
                <div style="overflow-x:auto;">
                    <p id="infoGuardado"></p>
                </div>  
                <br>
            </div>
        </div>

        <!-- Alerta de Tracking -->
        <div id="process" class="alerta" style="z-index: 300;">
            <!-- Modal content -->
            <div style="text-align: center; margin: auto;">
                <!--<span id="alerta-close-tracking" class="alerta-close">&times;</span>-->
                <!--<progress max="100">Procesando...</progress>-->
                <img src="../../Imagenes/Loading.gif" style="position: static;">
                <p style="color: white; font-size: x-large;">Su peticion se esta procesando...</p>
            </div>
        </div>

        <div  class="modal-opacity" id="mModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" scrolling="no">
            <div id="clobtn"  class="buttons red-buttons fas fa-close" scrolling="no">X</div> 
            <iframe class="int-content" id="urlmT" name="urlmT" class="" src="" scrolling="no" frameborder="0" value="0"></iframe>
        </div>

        <script src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/v1/Bootstrap/respond.min.js' charset="UTF-8" ></script>
        <script src='../../Utilerias/v1/Ajax.js'></script> 
        <script src='js/DetalleAsistenciaNRM.js'></script>
        <script src='../../Utilerias/LoadMapNRM.js'></script>
        <script>fnOpenLinks();</script>
        <script>
            fn_nrm_ConsumeCombo('[st_nrm_GetTipoArma]', 'tipoArma');
            fn_nrm_ConsumeCombo('[st_nrm_GetAseguradora]', 'aseguradora');
            fn_nrm_ConsumeCombo('[st_CatalogoEntidadFederativa]', 'estado');
            fn_nrm_ConsumeCombo('[st_nrm_Paises]', 'pais');
            fn_nrm_OcultarElementos();
            fn_nrm_ConsultarDetalleGuardado(<%=clExpediente%>);
        </script>
    </body>
</html>
