<%@page contentType="text/html" pageEncoding="ISO-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC, Utilerias.ResultList"%>
<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Bootstrap/bootstrap.min.css" rel="stylesheet"  type="text/css">
        <link href="../../StyleClasses/UsuariosNRM.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/AlertaNRM.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <%
            String StrclUsrApp = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp, 10)) != true) {
        %>Fuera de Horario<%
                StrclUsrApp = null;
                return;
            }

            String StrclPaginaWeb = "790";

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb, 10), Integer.parseInt(StrclUsrApp, 10));
        %>
        <div class="container-fluid">
            <div id="botonera" class="row">
                <button id="btnGuardar" class="btn btn-secondary" onclick="fn_nrm_GuardarConfiguracion(); return false;">Guardar</button>
            </div>
            <div class="row">
                <div class="col-sm-12 col-md-6 col-lg-6 col-xl-6">
                    <form id="controlPanel">
                        <fieldset style="border-color: #507fb3 !important;">
                            <legend>Proceso de Subscripcion</legend>
                            <div class="row">
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12">
                                    <input type="radio" class="form-check-input" id="automatico" style="left: 40px; top: -3px;" name="subscripcion">
                                    <label class="form-check-label" for="automatico">Automatica</label>              
                                    <input type="radio" class="form-check-input" id="manual" style="left: 141px; top: -3px;" name="subscripcion">
                                    <label class="form-check-label" for="manual">Manual</label>
                                </div>
                            </div>
                        </fieldset>
                    </form>
                </div>
                <div class="col-sm-12 col-md-6 col-lg-6 col-xl-6">
                    <form id="controlPanel">
                        <fieldset style="border-color: #507fb3 !important;">
                            <legend>Busqueda del Afiliado</legend>
                            <div class="row">
                                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12">
                                    <input type="radio" class="form-check-input" id="nombreVin" style="left: 40px; top: -3px;" name="busqAfiliado">
                                    <label class="form-check-label" for="nombreVin">Nombre y VIN</label>              
                                    <input type="radio" class="form-check-input" id="correoVin" style="left: 158px; top: -3px;" name="busqAfiliado">
                                    <label class="form-check-label" for="correoVin">Correo y VIN</label>
                                    <input type="radio" class="form-check-input" id="nombreCorreoVin" style="left: 267px; top: -3px;" name="busqAfiliado">
                                    <label class="form-check-label" for="nombreCorreoVin">Nombre, Correo y VIN</label>
                                </div>
                            </div>
                        </fieldset>
                    </form>
                </div>
            </div>
        </div>
        <div id="process" class="alerta" style="z-index: 300;">
            <!-- Modal content -->
            <div style="text-align: center; margin: auto;">
                <!--<span id="alerta-close-tracking" class="alerta-close">&times;</span>-->
                <!--<progress max="100">Procesando...</progress>-->
                <img src="../../Imagenes/Loading.gif" style="position: static;">
                <p style="color: white; font-size: x-large;">Su peticion se esta procesando...</p>
            </div>
        </div>
         <div id="alertControlPanel" class="alerta" style="z-index: 300">
            <!-- Modal content -->
            <div class="alerta-content" style="text-align: center;border: 16px solid #062f67;">
                <span id="alertaCloseControlPanel" class="alerta-close">&times;</span>
                <h3 style="text-align:center;color: red;">Notificacion</h3>
                <p style="text-align:center;background-color: #afc3e0;color: #062f67;">Informacion</p>
                <div style="overflow-x:auto;">
                    <p id="messageControlPanel"></p>
                </div>  
                <br>
            </div>
        </div>
        <script src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/v1/Bootstrap/respond.min.js' charset="UTF-8" ></script>
        <script src='../../Utilerias/v1/Ajax.js'></script> 
        <script src='js/ControlPanelNRM.js'></script> 
        <script>
            fn_nrm_ConsultarConfiguracion('panel', "../../");
        </script>  
    </body>
</html>
