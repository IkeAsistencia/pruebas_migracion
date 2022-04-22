<%@ page contentType="text/html, charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC, Utilerias.ResultList" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <title>InfoPreAfiliado</title>
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Bootstrap/bootstrap.min.css" rel="stylesheet"  type="text/css">
        <link href="../../StyleClasses/UsuariosNRM.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/AlertaNRM.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <%
            String StrclUsrApp = "0";
            String clTspPSeudoVin = "";
            String validar = "";
            String nombreCuenta = "";
            String secretQuestion1 = "";
            String secretAnswer1 = "";
            String secretQuestion2 = "";
            String secretAnswer2 = "";
            String vehicleColor = "";
            String vehiclePlateNumber = "";
            String vinTspPseudo = "";
            String firstName = "";
            String lastName = "";
            String numberPhone = "";
            String vehicleBrand = "";
            String modelName = "";
            String email = "";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp, 10)) != true) {
        %>Fuera de Horario<%
                StrclUsrApp = null;
                return;
            }
            if (request.getParameter("clTspPseudoVin") != null) {
                clTspPSeudoVin = request.getParameter("clTspPseudoVin").toString();
                System.out.println("El clVinTspPseudo que llego es: " + clTspPSeudoVin);
            }

            if (request.getParameter("validar") != null) {
                validar = request.getParameter("validar");
                System.out.println("Se requiere validar");
                StringBuffer StrSqlValida = new StringBuffer();
                StrSqlValida.append("st_nrm_LoadUserInfoValidar ").append(clTspPSeudoVin);
                ResultList rsValida = new ResultList();
                rsValida.rsSQL(StrSqlValida.toString());
                StrSqlValida.delete(0, StrSqlValida.length());

                if (rsValida.next()) {
                    nombreCuenta = rsValida.getString("nombreCuenta");
                    secretQuestion1 = rsValida.getString("secretQuestion1");
                    secretAnswer1 = rsValida.getString("secretAnswer1");
                    secretQuestion2 = rsValida.getString("secretQuestion2");
                    secretAnswer2 = rsValida.getString("secretAnswer2");
                    vehicleColor = rsValida.getString("vehicleColor");
                    vehiclePlateNumber = rsValida.getString("vehiclePlateNumber");
                    email = rsValida.getString("email");
                    vinTspPseudo = rsValida.getString("vinTspPseudo");
                    firstName = rsValida.getString("firstName");
                    lastName = rsValida.getString("lastName");
                    numberPhone = rsValida.getString("phoneNumber");
                    vehicleBrand = rsValida.getString("vechicleBrand");
                    modelName = rsValida.getString("modelName");
                }
            } else {
                System.out.println("VALIDA ES CERO");
                validar = "0";
                StringBuffer StrSql = new StringBuffer();
                StrSql.append("st_nrm_LoadUserInfoResponse ").append(clTspPSeudoVin);
                ResultList rs = new ResultList();
                rs.rsSQL(StrSql.toString());
                StrSql.delete(0, StrSql.length());

                if (rs.next()) {
                    vinTspPseudo = rs.getString("vinTspPseudo");
                    firstName = rs.getString("firstName");
                    lastName = rs.getString("lastName");
                    numberPhone = rs.getString("phoneNumber");
                    vehicleBrand = rs.getString("vechicleBrand");
                    modelName = rs.getString("modelName");
                    email = rs.getString("email");
                    vehicleColor = rs.getString("vehicleColor");
                    vehiclePlateNumber = rs.getString("vehiclePlateNumber");
                }
            }

            String StrclPaginaWeb = "6175";
            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb, 10), Integer.parseInt(StrclUsrApp, 10));

        %>

        <div class="container-fluid">

            <div id="botonera" class="row">
                <button id="btnEnviar" class="btn btn-secondary" onclick="fn_nrm_ForwardUserSettings(<%=clTspPSeudoVin%>, '<%=validar%>'); return false;">Guardar</button>
                <%if (request.getParameter("validar") == null) {%>
                <button class="btn btn-secondary" onclick="fn_nrm_RedirectListaUsuarios(); return false;">Cancelar</button>
                <%}%>
                <!--<button class="btn btn-success" onclick="fn_nrm_RedirectDetalleAsistencia(<%=clTspPSeudoVin%>); return false;">Asistencia</button>-->
            </div>

            <form id="infoUsuario">
                <fieldset style="border-color: #507fb3 !important;">
                    <legend>Informacion del Usuario:</legend>
                    <div class="row" style="height: 70px;">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="cuenta">Cuenta</label>
                            <input type="text" class="form-control" id="cuenta" maxlength="100" style="position: relative; width: 100%;" disabled="true" value="<%=nombreCuenta%>">
                            <!--                        <img src='../../Imagenes/Lupa.gif' onClick='fnBuscaCuenta();' width=20 height=20 alt="Buscar"/>-->
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="vinTspPseudo">Clave (VIN)</label>
                            <input type="text" class="form-control" id="vinTspPseudo" maxlength="36" value='<%=vinTspPseudo%>' readonly="true">
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="mail">Correo Electronico</label>
                            <input type="text" class="form-control" id="mail" maxlength="36" value='<%=email%>' readonly="true">
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="titularServicio">Titular del Servicio</label>
                            <input type="text" class="form-control" id="titularServicio" maxlength="150" value='<%=firstName + " " + lastName%>'>
                        </div>

                    </div>
                    <!--                <div class="row">
                                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                                            <div class="form-group">
                                                <label for="pregunta1">Pregunta Secreta 1</label>
                    <%if (request.getParameter("validar") == null) {%>
                        <select class="form-control" id="pregunta1"></select>
                    <%} else {%>
                        <input type="text" class="form-control" disabled="true" value='<%=secretQuestion1%>'></select>
                    <%}%>
                </div>
            </div>
            <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                <div class="form-group">
                    <label for="confPregunta1">Confirmar Pregunta Secreta 1</label>
                    <%if (request.getParameter("validar") == null) {%>
                    <select class="form-control" id="confPregunta1"></select>
                    <%} else {%>
                        <input type="text" class="form-control" disabled="true" value='<%=secretQuestion1%>'></select>
                    <%}%>
                </div>
            </div>
            <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                <label for="respuestaSecreta1">Respuesta Secreta 1</label>
                    <%if (request.getParameter("validar") == null) {%>
                        <input type="text" class="form-control" id="respuestaSecreta1" maxlength="150">
                    <%} else {%>
                        <input type="text" class="form-control" id="respuestaSecreta1" maxlength="150" value="<%=secretAnswer1%>" disabled="true">
                    <%}%>
                </div>
                <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                    <label for="confRespustaSecreta1">Confirmar Respuesta Secreta 1</label>
                    <%if (request.getParameter("validar") == null) {%>
                        <input type="text" class="form-control" id="confRespustaSecreta1" maxlength="150">
                    <%} else {%>
                    <input type="text" class="form-control" id="confRespustaSecreta1" maxlength="150" value="<%=secretAnswer1%>" disabled="true">
                    <%}%>
                </div>
            </div>-->

                    <!--                <div class="row">
                                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                                            <div class="form-group">
                                                <label for="pregunta1">Pregunta Secreta 2</label>
                    <%if (request.getParameter("validar") == null) {%>
                    <select class="form-control" id="pregunta2"></select>
                    <%} else {%>
                        <input type="text" class="form-control" disabled="true" value='<%=secretQuestion2%>'></select>
                    <%}%>
                    
                </div>
            </div>
            <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                <div class="form-group">
                    <label for="confPregunta2">Confirmar Pregunta Secreta 2</label>
                    <%if (request.getParameter("validar") == null) {%>
                    <select class="form-control" id="confPregunta2"></select>
                    <%} else {%>
                        <input type="text" class="form-control" disabled="true" value='<%=secretQuestion2%>'></select>
                    <%}%>
                </div>
            </div>
            <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                <label for="respuestaSecreta2">Respuesta Secreta 2</label>
                    <%if (request.getParameter("validar") == null) {%>
                        <input type="text" class="form-control" id="respuestaSecreta2" maxlength="150">
                    <%} else {%>
                        <input type="text" class="form-control" id="respuestaSecreta2" maxlength="150" value="<%=secretAnswer2%>" disabled="true">
                    <%}%>
                </div>
                <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                    <label for="confRespustaSecreta2">Confirmar Respuesta Secreta 2</label>
                    <%if (request.getParameter("validar") == null) {%>
                        <input type="text" class="form-control" id="confRespustaSecreta2" maxlength="150">
                    <%} else {%>
                        <input type="text" class="form-control" id="confRespustaSecreta2" maxlength="150" value="<%=secretAnswer2%>" disabled="true">
                    <%}%>
                </div>
            </div>-->

                    <div class="row" style="height: 70px;">
                        <div class="col-sm-12 col-md-6 col-lg-3 col-xl-3">
                            <label for="telefono">Telefono</label>
                            <input type="text" class="form-control" id="telefono" maxlength="20" value='<%=numberPhone%>'>
                        </div>
                        
                    </div>
                </fieldset>
                <fieldset style="border-color: #507fb3 !important;">
                    <legend>Informacion del Vehiculo</legend>
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-3 col-xl-3">
                            <label for="placas">Placas del Vehiculo</label>
                            <input type="text" class="form-control" id="placas" maxlength="100" value="<%=vehiclePlateNumber%>">
                        </div>
                        <div class="col-sm-12 col-md-12 col-lg-3 col-xl-3">
                            <label for="color">Color</label>
                            <input type="text" class="form-control" id="color" maxlength="36" value="<%=vehicleColor%>">
                        </div>
                        <div class="col-sm-12 col-md-12 col-lg-3 col-xl-3"> 
                            <label for="marca">Marca</label>
                            <input type="text" class="form-control" id="marca" maxlength="150" value="<%=vehicleBrand%>" >
                        </div>
                        <div class="col-sm-12 col-md-12 col-lg-3 col-xl-3"> 
                            <label for="modelo">Modelo</label>
                            <input type="text" class="form-control" id="modelo" maxlength="150" value="<%=modelName%>" >
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>

        <!-- Alerta falta de datos informacion usuario -->
        <div id="alertVerifyInfo" class="alerta" >
            <!-- Modal content -->
            <div class="alerta-content" style="height: 300px; text-align: center;border: 16px solid #062f67;overflow-y: auto;">
                <span id="alertCloseVerifyInfo" class="alerta-close">&times;</span>
                <h3 style="text-align:center;color: red;">Alerta</h3>
                <p style="text-align:center;background-color: #afc3e0;color: #062f67;"> La siguiente informacion es requerida:</p>
                <div style="overflow-x:auto;">
                    <table id="tablaFaltaInfo">
                    </table>
                </div>  
                <br>
            </div>
        </div>

        <!-- Alerta User Settings -->
        <div id="alertUserSettings" class="alerta">
            <!-- Modal content -->
            <div class="alerta-content" style="text-align: center;border: 16px solid #062f67;">
                <span id="alertaCloseForward" class="alerta-close">&times;</span>
                <h3 style="text-align:center;color: red;">Notificacion</h3>
                <p style="text-align:center;background-color: #afc3e0;color: #062f67;">Informacion</p>
                <div style="overflow-x:auto;">
                    <h5 id="messageForward" >
                    </h5>
                </div>  
                <br>
            </div>
        </div>

        <!-- Alerta User Request -->
        <div id="alertUserRequestValida" class="alerta">
            <!-- Modal content -->
            <div class="alerta-content" style="text-align: center;border: 16px solid #062f67;">
                <span id="alertCloseRequest" class="alerta-close">&times;</span>
                <h3 style="text-align:center;color: red;">Notificacion</h3>
                <p style="text-align:center;background-color: #afc3e0;color: #062f67;">Sincronizacion de Datos</p>
                <div style="overflow-x:auto;">
                    <h5 id="messageRequestValida">
                    </h5>
                </div>  
                <br>
<!--                <button onclick="fn_nrm_CloseModalValidar(<%=clTspPSeudoVin%>)">ACEPTAR</button>-->
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

        <script src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/v1/Bootstrap/respond.min.js' charset="UTF-8" ></script>
        <script src='../../Utilerias/v1/Ajax.js'></script> 
        <script src='js/InfoUsuarioNRM.js'></script>
        <script>
                    fn_nrm_Subscription(<%=clTspPSeudoVin%>, 'USER_INFO_REQUEST', '1');
        </script>
    </body>
</html>
