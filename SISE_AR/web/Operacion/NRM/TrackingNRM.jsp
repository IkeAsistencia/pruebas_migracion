<%@page import="com.ike.ws.nrm.to.Tracking"%>
<%@page import="com.ike.ws.nrm.WSTrackingNrm"%>
<%@page import="com.ike.ws.nrm.WSClientsNrm"%>
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
            String clPais = "0";
            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
                 System.out.println("El clUsrApp que llego es: " + StrclUsrApp);
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

            if (request.getParameter("clPais") != null) {
                clPais = request.getParameter("clPais").toString();
                System.out.println("El clPais que llego es: " + clPais);
            }

            String StrclPaginaWeb = "6174";
            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb, 10), Integer.parseInt(StrclUsrApp, 10));
        %>
        <div class="container-fluid">
            <div id="botonera" class="row">
                <button class="btn btn-secondary" onclick="fn_nrm_RedirectDetalleAsistencia(<%=clExpediente%>); return false;">Regresar</button> 
                <button id="btnGuardar" class="btn btn-secondary" onclick="fn_nrm_Guardar(<%=StrclUsrApp%> ,<%=clExpediente%>); return false;">Guardar</button>
                <!--<button id="btnActualizar" class="btn btn-secondary" onclick="">Actualizar</button>-->
                <!--<button id="btnCancelar" class="btn btn-secondary" onclick="fn_nrm_RedirectListaUsuarios(); return false;">Cancelar</button>-->
                <button id="btnTracking" class="btn btn-primary" onclick="fn_nrm_IniciarTracking('tracking' ,'track', <%=StrclUsrApp%> ,<%=clExpediente%>, <%=clVinTspPseudo%>, '<%=vinTspPseudo%>'); return false;">Iniciar Tracking</button> 
                <button id="btnSeguimiento" class="btn btn-primary" onclick="window.open('MonitoreoTrackingNRM.jsp?tiempo=30&clexpediente=<%=clExpediente%>','','location=no,resizable=yes,menubar=0,scrollbars=no,left=0,status=0,toolbar=0,height=650,width=1280,top=0');">Seguimiento</button> 
                <button id="btnRastreo" class="btn btn-primary" onclick="fn_nrm_LoadMapTrack(<%=clExpediente%>); return false;">Rastreo</button> 
                <button id="btnCustodia" class="btn btn-success" onclick="fn_nrm_CustodiaVehiculo(<%=clExpediente%>, <%=clVinTspPseudo%>, '<%=vinTspPseudo%>', <%=clPais%>); return false;">Custodia Vehiculo</button> 
                <button id="btnActualiza" class="btn btn-warning" onclick="fn_nrm_ActualizaStatus(<%=clExpediente%>, <%=clVinTspPseudo%>, <%=StrclUsrApp%>); return false;">Actualiza Estatus</button> 
                <button id="btnActualiza" class="btn btn-warning" onclick="fn_nrm_ActualizaTodo(); return false;">Actualiza Todo</button> 
            </div>

            <form id="infoUsuario">
                <fieldset style="border-color: #507fb3 !important;">
                    <legend>Ubicacion Inicio de Monitoreo</legend>
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12">
                            <label for="inicioTracking">Ubicacion del Vehiculo</label>
                            <input type="text" class="form-control" id="inicioTracking" maxlength="150" value=''>
                        </div>
                    </div>
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
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label style="position: relative;">Monitoreo Exitoso?</label>
                            <input type="radio" class="form-check-input" id="siInicioTracking" style="position: absolute;top: 25px;left: 60px;" name="tracking">
                            <label class="form-check-label" for="siInicioTracking" style="position: absolute;top: 29px;left: 46px;">Si</label>              
                            <input type="radio" class="form-check-input" id="noInicioTracking" style="position: absolute;top: 25px;left: 146px;" name="tracking">
                            <label class="form-check-label" for="noInicioTracking" style="position: absolute;top: 29px;left: 129px;">No</label>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label id="porcentajeMonitoreo" style="position: absolute;top: 20px;"></label>    
                        </div>
                    </div>
                </fieldset>

                <fieldset style="border-color: #507fb3 !important;">
                    <legend>Ubicacion Fin de Monitoreo</legend>
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12">
                            <label for="finTracking">Ubicacion del Vehiculo</label>
                            <input type="text" class="form-control" id="finTracking" maxlength="150" value=''>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="fechaFinRegistro">Fecha y Hora del Registro</label>
                            <input type="datetime-local" class="form-control" name="fechaFinRegistro" id="fechaFinRegistro" style="margin: auto; font-size: 14px !important;">
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="estatusFinServicio">Estatus del Servicio</label>
                            <!--<select class="form-control" id="estatusFinServicio"></select>-->
                            <input type="text" class="form-control" id="estatusFinServicio" maxlength="20" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="velocidadFin">Velocidad</label>
                            <input type="text" class="form-control" id="velocidadFin" maxlength="20" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="estatusFinArranque">Estatus de Arranque</label>
                            <select class="form-control" id="estatusFinArranque"></select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="nivelFinBateria">Nivel de Bateria</label>
                            <input type="text" class="form-control" id="nivelFinBateria" maxlength="20" value=''>
                        </div>
                         <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="kilometrajeFin">Kilometraje</label>
                            <input type="text" class="form-control" id="kilometrajeFin" maxlength="20" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label style="position: relative;">Desmonitoreo Exitoso?</label>
                            <input type="radio" class="form-check-input" id="siUntracking" style="position: absolute;top: 25px;left: 60px;" name="untracking">
                            <label class="form-check-label" for="siUntracking" style="position: absolute;top: 29px;left: 46px;">Si</label>              
                            <input type="radio" class="form-check-input" id="noUntracking" style="position: absolute;top: 25px;left: 147px;" name="untracking">
                            <label class="form-check-label" for="noUntracking" style="position: absolute;top: 29px;left: 129px;">No</label>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label id="porcentajeDesmonitoreo" style="position: absolute;top: 20px;"></label>    
                        </div>
                    </div>
                </fieldset>
                
                <fieldset style="border-color: #507fb3 !important;">
                    <legend>Ubicacion Inicio de Bloqueo</legend>
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12">
                            <label for="inicioBlocking">Ubicacion del Vehiculo</label>
                            <input type="text" class="form-control" id="inicioBlocking" maxlength="150" value=''>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="fechaBlocking">Fecha y Hora del Registro</label>
                            <input type="datetime-local" class="form-control" name="fechaInicioBlocking" id="fechaBlocking" style="margin: auto; font-size: 14px !important;">
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="estatusServicioBlocking">Estatus del Servicio</label>
                            <!--<select class="form-control" id="estatusServicioBlocking"></select>-->
                            <input type="text" class="form-control" id="estatusServicioBlocking" maxlength="20" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="velocidadBlocking">Velocidad</label>
                            <input type="text" class="form-control" id="velocidadBlocking" maxlength="20" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="estatusBlocking">Estatus de Arranque</label>
                            <select class="form-control" id="estatusBlocking"></select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="nivelBateriaBlocking">Nivel de Bateria</label>
                            <input type="text" class="form-control" id="nivelBateriaBlocking" maxlength="20" value=''>
                        </div>
                         <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="kilometrajeBlocking">Kilometraje</label>
                            <input type="text" class="form-control" id="kilometrajeBlocking" maxlength="20" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label style="position: relative;">Bloqueo Exitoso?</label>
                            <input type="radio" class="form-check-input" id="siBlocking" style="position: absolute;top: 25px;left: 60px;" name="blocking">
                            <label class="form-check-label" for="siBlockgin" style="position: absolute;top: 29px;left: 46px;">Si</label>              
                            <input type="radio" class="form-check-input" id="noBlocking" style="position: absolute;top: 25px;left: 146px;" name="blocking">
                            <label class="form-check-label" for="noBlocking" style="position: absolute;top: 29px;left: 129px;">No</label>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label id="porcentajeBloqueo" style="position: absolute;top: 20px;"></label>    
                        </div>
                    </div>
                </fieldset>
                
                <fieldset style="border-color: #507fb3 !important;">
                    <legend>Ubicacion Fin de Bloqueo</legend>
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12">
                            <label for="finBlocking">Ubicacion del Vehiculo</label>
                            <input type="text" class="form-control" id="finBlocking" maxlength="150" value=''>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="fechaFinBlocking">Fecha y Hora del Registro</label>
                            <input type="datetime-local" class="form-control" name="fechaFinBlocking" id="fechaFinBlocking" style="margin: auto; font-size: 14px !important;">
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="estatusServicioFinBlocking">Estatus del Servicio</label>
                            <!--<select class="form-control" id="estatusServicioFinBlocking"></select>-->
                            <input type="text" class="form-control" id="estatusServicioFinBlocking" maxlength="20" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="velocidadFinBlocking">Velocidad</label>
                            <input type="text" class="form-control" id="velocidadFinBlocking" maxlength="20" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="estatusFinBlocking">Estatus de Arranque</label>
                            <select class="form-control" id="estatusFinBlocking"></select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="nivelBateriaFinBlocking">Nivel de Bateria</label>
                            <input type="text" class="form-control" id="nivelBateriaFinBlocking" maxlength="20" value=''>
                        </div>
                         <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="kilometrajeFinBlocking">Kilometraje</label>
                            <input type="text" class="form-control" id="kilometrajeFinBlocking" maxlength="20" value=''>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label style="position: relative;">Desbloqueo Exitoso?</label>
                            <input type="radio" class="form-check-input" id="siFinBlocking" style="position: absolute;top: 25px;left: 60px;" name="unblocking">
                            <label class="form-check-label" for="siFinBlocking" style="position: absolute;top: 29px;left: 46px;">Si</label>              
                            <input type="radio" class="form-check-input" id="noFinBlocking" style="position: absolute;top: 25px;left: 147px;" name="unblocking">
                            <label class="form-check-label" for="noFinBlocking" style="position: absolute;top: 29px;left: 129px;">No</label>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label id="porcentajeDesbloqueo" style="position: absolute;top: 20px;"></label>    
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>

        <!-- Alerta falta de datos informacion usuario -->
        <div id="alertInfoUsuario" class="alerta" style="z-index: 300">
            <!-- Modal content -->
            <div class="alerta-content" style="text-align: center;border: 16px solid #062f67;overflow-y: auto; max-height: 400px;">
                <span id="alertaClose" class="alerta-close">&times;</span>
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
<!--        <div id="process" class="alerta" style="z-index: 300">
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
        <div id="alertTracking" class="alerta" style="z-index: 300">
            <!-- Modal content -->
            <div class="alerta-content" style="text-align: center;border: 16px solid #062f67;">
                <span id="alertaCloseTracking" class="alerta-close">&times;</span>
                <h3 style="text-align:center;color: red;">Notificacion</h3>
                <p style="text-align:center;background-color: #afc3e0;color: #062f67;">Informacion</p>
                <div style="overflow-x:auto;">
                    <p id="messageTracking"></p>
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
        <script src='js/TrackingNRM.js'></script> 
        <script src='../../Utilerias/LoadMapNRM.js'></script>
         <script>
            fn_nrm_ActualizaStatus(<%=clExpediente%>, <%=clVinTspPseudo%>, <%=StrclUsrApp%>);
            fn_nrm_Deshabilitar();
            fn_nrm_ConsumeCombo("[st_nrm_GetServiceState]", "estatusInicioServicio");
            fn_nrm_ConsumeCombo("[st_nrm_GetVehicleState]", "estatusInicioArranque");
            fn_nrm_ConsumeCombo("[st_nrm_GetServiceState]", "estatusFinServicio");
            fn_nrm_ConsumeCombo("[st_nrm_GetVehicleState]", "estatusFinArranque");
            fn_nrm_ConsumeCombo("[st_nrm_GetServiceState]", "estatusServicioBlocking");
            fn_nrm_ConsumeCombo("[st_nrm_GetVehicleState]", "estatusBlocking");
            fn_nrm_ConsumeCombo("[st_nrm_GetServiceState]", "estatusServicioFinBlocking");
            fn_nrm_ConsumeCombo("[st_nrm_GetVehicleState]", "estatusFinBlocking");
            fn_nrm_ConsultarTrackingGuardado(<%=clExpediente%>);
            fn_nrm_ConsultarUnTrackingGuardado(<%=clExpediente%>);
            fn_nrm_ConsultarBlockingGuardado(<%=clExpediente%>);
            fn_nrm_ConsultarUnBlockingGuardado(<%=clExpediente%>);
            fn_nrm_ConsultarTrackingPendiente(<%=clExpediente%>,<%=clVinTspPseudo%>,<%=StrclUsrApp%>);
            fn_nrm_ConsultarUnTrackingPendiente(<%=clExpediente%>,<%=clVinTspPseudo%>,<%=StrclUsrApp%>);
            fn_nrm_ConsultarBlockingPendiente(<%=clExpediente%>,<%=clVinTspPseudo%>,<%=StrclUsrApp%>);
            fn_nrm_ConsultarUnBlockingPendiente(<%=clExpediente%>,<%=clVinTspPseudo%>,<%=StrclUsrApp%>);
            function fn_nrm_LoadMapTrack() {
                console.dir('Cargando Mapa Rastreo...');
                fn_nrm_CreateJsonTracking(<%=clExpediente%>);
            }
            function fn_nrm_ActualizaTodo(){
                fn_nrm_ActualizaStatus(<%=clExpediente%>, <%=clVinTspPseudo%>, <%=StrclUsrApp%>);
                fn_nrm_ConsultarTrackingGuardado(<%=clExpediente%>);
                fn_nrm_ConsultarUnTrackingGuardado(<%=clExpediente%>);
                fn_nrm_ConsultarBlockingGuardado(<%=clExpediente%>);
                fn_nrm_ConsultarUnBlockingGuardado(<%=clExpediente%>);
                fn_nrm_ConsultarTrackingPendiente(<%=clExpediente%>,<%=clVinTspPseudo%>,<%=StrclUsrApp%>);
                fn_nrm_ConsultarUnTrackingPendiente(<%=clExpediente%>,<%=clVinTspPseudo%>,<%=StrclUsrApp%>);
                fn_nrm_ConsultarBlockingPendiente(<%=clExpediente%>,<%=clVinTspPseudo%>,<%=StrclUsrApp%>);
                fn_nrm_ConsultarUnBlockingPendiente(<%=clExpediente%>,<%=clVinTspPseudo%>,<%=StrclUsrApp%>);
            }
        </script>
    </body>
</html>
