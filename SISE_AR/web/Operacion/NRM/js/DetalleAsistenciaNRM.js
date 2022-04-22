var siSeguro = document.getElementById('siSeguro');
var noSeguro = document.getElementById('noSeguro');
var si911 = document.getElementById('si911');
var no911 = document.getElementById('no911');
var siRepuve = document.getElementById('siRepuve');
var noRepuve = document.getElementById('noRepuve');
var siViolencia = document.getElementById('siViolencia');
var noViolencia = document.getElementById('noViolencia');
var siArmas = document.getElementById('siArmas');
var noArmas = document.getElementById('noArmas');
var anio = document.getElementById('anio');
var robo = document.getElementById('robo');
var hurto = document.getElementById('hurto');
var fechaReporteAutoridades = document.getElementById('fechaReporteAutoridades');
var estado = document.getElementById('estado');
var municipioAlcaldia = document.getElementById('municipioAlcaldia');
var colonia = document.getElementById('colonia');
var cp = document.getElementById('cp');
var calleNumero = document.getElementById('calleNumero');
var referencias = document.getElementById('referencias');
var fechaRobo = document.getElementById('fechaRobo');
var aseguradora = document.getElementById('aseguradora');
var noMotor = document.getElementById('noMotor');
var noPoliza = document.getElementById('noPoliza');
var noSiniestro = document.getElementById('noSiniestro');
var folio911 = document.getElementById('folio911');
var folioRepuve = document.getElementById('folioRepuve');
var noAsaltantes = document.getElementById('noAsaltantes');
var tipoArma = document.getElementById('tipoArma');
var spanCloseDetalle = document.getElementById('alertCloseDetalle');
var alertaCloseGuardado = document.getElementById('alertaCloseGuardado');
var pais = document.getElementById('pais');
var country = '';

function fn_nrm_RedirectTracking(expe, vin, vinTspPseudo) {
    location.href = "TrackingNRM.jsp?clExpediente=" + expe + "&clVinTspPseudo=" + vin + "&vinTspPseudo=" + vinTspPseudo + "&clPais=" + pais.value;
}

function fn_nrm_ConsultarDetalleGuardado(expe) {
    ajaxRequest({param: ["'" + parseInt(expe, 10) + "'"],
        sql: "[st_nrm_ConsultaDetalleAsistencia]",
        component: "json",
        nivel: "../../"}, function (data) {
        if (data !== null && data !== undefined && data[0] !== undefined) {
            console.dir(data[0]);
            noSiniestro.value = data[0].noSiniestro;
            folio911.value = data[0].noReporte911;
            folioRepuve.value = data[0].noRepuve;
            setTimeout(function () {
                aseguradora.value = parseInt(data[0].clAseguradora, 10);
            }, 2000);
            noPoliza.value = data[0].noPoliza;
            
            setTimeout(function () {
                document.getElementById('pais').value = parseInt(data[0].clPais, 10);
            }, 1000);
            
            setTimeout(function () {
                fn_nrm_LlenaEntidadFederativa();
            }, 2000);
            
            setTimeout(function () {
                console.dir('ESTADO');  
                console.dir(data[0].clEdo);
                estado.value = data[0].clEdo;
            }, 3000);
            
            setTimeout(function () {
                fn_nrm_LlenaMunicipioDelegacion();
            }, 4000);
            
            setTimeout(function () {
                console.dir('MUNICIPIO');  
                console.dir(data[0].clMun);
                municipioAlcaldia.value = data[0].clMun;
            }, 5000);
            
            fechaRobo.value = data[0].horaFechaRobo.replace(' ', 'T');
            anio.value = data[0].vehiculoAnio;
            if (parseInt(data[0].hurto, 10) === 1) {
                hurto.checked = true;
            } else if (parseInt(data[0].hurto, 10) === 0) {
                robo.checked = true;
            }
            if (parseInt(data[0].reporte911, 10) === 1) {
                si911.checked = true;
                document.getElementById('folio911Div').style.display = "block";
            } else if (parseInt(data[0].reporte911, 10) === 0) {
                no911.checked = true;
            }
            setTimeout(function () {
                console.dir(parseInt(data[0].clTipoArma, 10));
                tipoArma.value = parseInt(data[0].clTipoArma, 10);
            }, 2000);
            fechaReporteAutoridades.value = data[0].horaFechaReporteAutoridad.replace(' ', 'T');
            if (parseInt(data[0].reporteRepuve, 10) === 1) {
                siRepuve.checked = true;
                document.getElementById('folioRepuveDiv').style.display = "block";
            } else if (parseInt(data[0].reporteRepuve, 10) === 0) {
                noRepuve.checked = true;
            }
            if (parseInt(data[0].roboViolencia, 10) === 1) {
                siViolencia.checked = true;
                document.getElementById('portanArmasDiv').style.display = "block";
            } else if (parseInt(data[0].roboViolencia, 10) === 0) {
                noViolencia.checked = true;
                document.getElementById('noAsaltantesDiv').style.display = "block";
                noAsaltantes.value = parseInt(data[0].noAsaltantes, 10);
            }
            referencias.value = data[0].referenciaIncidente;
            colonia.value = data[0].coloniaIncidente;
            cp.value = parseInt(data[0].cp, 10);
            if (parseInt(data[0].cuentaConSeguro, 10) === 1) {
                siSeguro.checked = true;
                document.getElementById('aseguradoraDiv').style.display = "block";
                document.getElementById('noPolizaDiv').style.display = "block";
                document.getElementById('noSiniestroDiv').style.display = "block";
            } else if (parseInt(data[0].cuentaConSeguro, 10) === 0) {
                noSeguro.checked = true;
            }
            noMotor.value = data[0].noMotor;
            calleNumero.value = data[0].calleNumeroIncidente;
            if (parseInt(data[0].portanArmas, 10) === 1) {
                siArmas.checked = true;
                document.getElementById('tipoArmaDiv').style.display = "block";
                document.getElementById('noAsaltantesDiv').style.display = "block";
                noAsaltantes.value = parseInt(data[0].noAsaltantes, 10);
            } else if (parseInt(data[0].portanArmas, 10) === 0) {
                noArmas.checked = true;
                document.getElementById('noAsaltantesDiv').style.display = "block";
                noAsaltantes.value = parseInt(data[0].noAsaltantes, 10);
            }
            document.getElementById('btnTracking').disabled = false;
//            document.getElementById('btnCancelar').disabled = true;
        }
    });
}

function fn_nrm_GuardarDetalleAsistencia(usr, vinTspPseudo, vin, expe, serv, subserv) {
    document.getElementById('tablaFaltaInfo').innerHTML = "";
    var numero = 0;
    if (fn_nrm_ValidarDatosVehiculo()) {

    } else {
        numero++;
        fn_nrm_showModal('alertInfoDetalle');
    }

    if (fn_nrm_ValidarDatosSeguro()) {

    } else {
        numero++;
        fn_nrm_showModal('alertInfoDetalle');
    }

    if (fn_nrm_ValidarReporteRobo()) {

    } else {
        numero++;
        fn_nrm_showModal('alertInfoDetalle');
    }

    if (fn_nrm_ValidarUbicacionRobo()) {

    } else {
        numero++;
        fn_nrm_showModal('alertInfoDetalle');
    }

    if (fn_nrm_ValidarDescOcurrido()) {

    } else {
        numero++;
        fn_nrm_showModal('alertInfoDetalle');
    }

    if (numero > 0) {

    } else {
        fn_nrm_showModal('process');
        fn_nrm_GuardaDetalleAsistencia(usr, expe, vin, vinTspPseudo, serv, subserv);
        document.getElementById('infoGuardado').innerHTML = "";
    }
}

function fn_nrm_GuardaDetalleAsistencia(usr, expe, vin, vinTspPseudo, serv, subserv) {

    var seguro = 0;
    if (siSeguro.checked) {
        seguro = 1;
    }

    var reporte911 = 0;
    if (si911.checked) {
        reporte911 = 1;
    }

    var rob = 0;
    var hurt = 0;
    if (robo.checked) {
        rob = 1;
    } else {
        hurt = 1;
    }

    var repuve = 0;
    if (siRepuve.checked) {
        repuve = 1;
    }

    var violencia = 0;
    if (siViolencia.checked) {
        violencia = 1;
    }

    var armas = 0;
    if (siArmas.checked) {
        armas = 1;
    }
    
    var pais = document.getElementById('pais').value;
    console.dir("'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + parseInt(vin, 10) + "','"
            + parseInt(aseguradora.value, 10) + "','" + noMotor.value + "','" + seguro + "','" + noPoliza.value + "','"
            + noSiniestro.value + "','" + reporte911 + "','" + rob + "','" + hurt + "','" + folio911.value + "','"
            + repuve + "','" + folioRepuve.value + "','" + parseInt(estado.value, 10) + "','" + parseInt(municipioAlcaldia.value, 10) + "','"
            + colonia.value + "','" + cp.value + "','" + calleNumero.value + "','" + referencias.value + "','" + violencia + "','"
            + armas + "','" + parseInt(tipoArma.value, 10) + "','" + parseInt(noAsaltantes.value, 10) + "','"
            + fechaRobo.value.replace('T', ' ') + "','" + vinTspPseudo + "','" + anio.value + "','" + fechaReporteAutoridades.value.replace('T', ' ') + "','" +  parseInt(pais, 10) + "'");

    ajaxRequest({param: ["'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + parseInt(vin, 10) + "','"
                    + parseInt(aseguradora.value, 10) + "','" + noMotor.value + "','" + seguro + "','" + noPoliza.value + "','"
                    + noSiniestro.value + "','" + reporte911 + "','" + rob + "','" + hurt + "','" + folio911.value + "','"
                    + repuve + "','" + folioRepuve.value + "','" + estado.value + "','" + municipioAlcaldia.value + "','"
                    + colonia.value + "','" + cp.value + "','" + calleNumero.value + "','" + referencias.value + "','" + violencia + "','"
                    + armas + "','" + parseInt(tipoArma.value, 10) + "','" + parseInt(noAsaltantes.value, 10) + "','"
                    + fechaRobo.value.replace('T', ' ') + "','" + vinTspPseudo + "','" + anio.value + "','" + fechaReporteAutoridades.value.replace('T', ' ') + "','" +  parseInt(pais, 10) + "'"],
        sql: "[st_nrm_GuardaDetalleAsistencia]",
        component: "String",
        nivel: "../../"}, function (data) {
        console.dir(data);
        if (data.trim() === "ADDED") {
            fn_nrm_SetServicioAndSubservicio(usr, expe, serv, subserv);
        } else if (data.trim() === "UPDATED") {
//            fn_nrm_SetServicioAndSubservicio(usr, expe, serv, subserv);
            document.getElementById('infoGuardado').innerHTML += "EL DETALLE FUE ACTUALIZADO CORRECTAMENTE.";

        } else {
            document.getElementById('infoGuardado').innerHTML += "OCURRIO UN ERROR AL GUARDAR EL DETALLE INTENTELO NUEVAMENTE";
        }
        fn_nrm_closeModal('process');
        fn_nrm_showModal('alertGuardadoAsistencia');
    });
}

function fn_nrm_SetServicioAndSubservicio(usr, expe, serv, subserv) {
    ajaxRequest({param: ["'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + serv + "','" + subserv + "'"],
        sql: "[st_nrm_SetServicioAndSubServicio]",
        component: "String",
        nivel: "../../"}, function (data) {
        console.dir(data);
        if (data.trim() === "UPDATED") {
            document.getElementById('infoGuardado').innerHTML += "<br>EL DETALLE FUE GUARDADO CORRECTAMENTE.";
            document.getElementById('btnTracking').disabled = false;
            document.getElementById('btnCancelar').disabled = true;
        } else {
            document.getElementById('infoGuardado').innerHTML += "<br>OCURRIO UN ERROR AL GUARDAR EL SERVICIO Y SUBSERVICIO.";
        }
    });
}

function fn_nrm_ValidarDescOcurrido() {
    var tableDescOcurrido = '<table><tr><th>Datos Ubicacion del Robo</th><th>Descripcion</th></tr>';
    var numeroDescOcurrido = 0;

    if (fechaRobo.value === "") {
        tableDescOcurrido += '<tr style="font-size: 14px;"><td>Fecha y Hora del Robo</td><td>Seleccione la fecha y hora</td></tr>';
        fn_nrm_SetRedBackground('fechaRobo');
        numeroDescOcurrido++;
    } else {
        fn_nrm_RemoveRedBackground('fechaRobo');
    }

    if(noAsaltantes.value === "" || parseInt(noAsaltantes.value, 10) < 1){
        tableDescOcurrido += '<tr style="font-size: 14px;"><td>Numero de Asaltantes</td><td>Introduzca el numero de asaltantes</td></tr>';
        fn_nrm_SetRedBackground('noAsaltantes');
        numeroDescOcurrido++;
    }else{
        fn_nrm_RemoveRedBackground('noAsaltantes');
    }

    if (numeroDescOcurrido > 0) {
        tableDescOcurrido += '</table><br>';
        document.getElementById('tablaFaltaInfo').innerHTML += tableDescOcurrido;
        return false;
    } else {
        return true;
    }
}

function fn_nrm_ValidarUbicacionRobo() {
    var tableUbicacionRobo = '<table><tr><th>Datos Ubicacion del Robo</th><th>Descripcion</th></tr>';
    var numeroUbicacionRobo = 0;
    var country = document.getElementById('pais').value;
    
    if(parseInt(country, 10) === -1){
        tableUbicacionRobo += '<tr style="font-size: 14px;"><td>Pais</td><td>Seleccione una opcion</td></tr>';
        fn_nrm_SetRedBackground('pais');
        numeroUbicacionRobo++;
    }else{
        fn_nrm_RemoveRedBackground('pais');
    }

    if (parseInt(estado.value, 10) === -1) {
        tableUbicacionRobo += '<tr style="font-size: 14px;"><td>Estado</td><td>Seleccione una opcion</td></tr>';
        fn_nrm_SetRedBackground('estado');
        numeroUbicacionRobo++;
    } else {
        fn_nrm_RemoveRedBackground('estado');
    }

    if (parseInt(estado.value, 10) !== -1 && parseInt(municipioAlcaldia.value, 10) === -1) {
        tableUbicacionRobo += '<tr style="font-size: 14px;"><td>Municipio/Alcaldia</td><td>Seleccione una opcion</td></tr>';
        fn_nrm_SetRedBackground('municipioAlcaldia');
        numeroUbicacionRobo++;
    } else if (parseInt(estado.value, 10) !== -1 && parseInt(municipioAlcaldia.value, 10) !== -1) {
        fn_nrm_RemoveRedBackground('municipioAlcaldia');
    }

    if (colonia.value === "" || colonia.value === " ") {
        tableUbicacionRobo += '<tr style="font-size: 14px;"><td>Colonia</td><td>Escriba la colonia</td></tr>';
        fn_nrm_SetRedBackground('colonia');
        numeroUbicacionRobo++;
    } else {
        fn_nrm_RemoveRedBackground('colonia');
    }

    if (cp.value === "" || cp.value <= 0) {
        tableUbicacionRobo += '<tr style="font-size: 14px;"><td>C.P.</td><td>Escriba un codigo postal valido</td></tr>';
        fn_nrm_SetRedBackground('cp');
        numeroUbicacionRobo++;
    } else {
        fn_nrm_RemoveRedBackground('cp');
    }

    if (calleNumero.value === "" || calleNumero.value === " ") {
        tableUbicacionRobo += '<tr style="font-size: 14px;"><td>Calle y Numero</td><td>Escriba la calle y el numero</td></tr>';
        fn_nrm_SetRedBackground('calleNumero');
        numeroUbicacionRobo++;
    } else {
        fn_nrm_RemoveRedBackground('calleNumero');
    }

    if (referencias.value === "" || referencias.value === " ") {
        tableUbicacionRobo += '<tr style="font-size: 14px;"><td>Referencias</td><td>Escriba las referencias visuales</td></tr>';
        fn_nrm_SetRedBackground('referencias');
        numeroUbicacionRobo++;
    } else {
        fn_nrm_RemoveRedBackground('referencias');
    }

    if (numeroUbicacionRobo > 0) {
        tableUbicacionRobo += '</table><br>';
        document.getElementById('tablaFaltaInfo').innerHTML += tableUbicacionRobo;
        return false;
    } else {
        return true;
    }
}

function fn_nrm_ValidarReporteRobo() {
    var tableReporteRobo = '<table><tr><th>Datos del Robo</th><th>Descripcion</th></tr>';
    var numeroReporteRobo = 0;

    if (hurto.checked || robo.checked) {
    } else {
        tableReporteRobo += '<tr style="font-size: 14px;"><td>Tipo de Robo?</td><td>Seleccione una opcion</td></tr>';
        numeroReporteRobo++;
    }

    if (si911.checked || no911.checked) {
    } else {
        tableReporteRobo += '<tr style="font-size: 14px;"><td>Reporte al 911?</td><td>Seleccione una opcion</td></tr>';
        numeroReporteRobo++;
    }

    if (siRepuve.checked || noRepuve.checked) {
    } else {
        tableReporteRobo += '<tr style="font-size: 14px;"><td>Reporte a Repuve?</td><td>Seleccione una opcion</td></tr>';
        numeroReporteRobo++;
    }

    if (fechaReporteAutoridades.value === "") {
        tableReporteRobo += '<tr style="font-size: 14px;"><td>Fecha y Hora Reporte Autoridades</td><td>Seleccione la Fecha y Hora</td></tr>';
        fn_nrm_SetRedBackground('fechaReporteAutoridades');
        numeroReporteRobo++;
    } else {
        fn_nrm_RemoveRedBackground('fechaReporteAutoridades');
    }

    if (numeroReporteRobo > 0) {
        tableReporteRobo += '</table><br>';
        document.getElementById('tablaFaltaInfo').innerHTML += tableReporteRobo;
        return false;
    } else {
        return true;
    }
}

function fn_nrm_ValidarDatosSeguro() {
    var tableDatosSeguro = '<table><tr><th>Datos del Seguro</th><th>Descripcion</th></tr>';
    var numeroDatosSeguro = 0;

    if (siSeguro.checked || noSeguro.checked) {
    } else {
        tableDatosSeguro += '<tr style="font-size: 14px;"><td>Cuenta con seguro?</td><td>Seleccione una opcion</td></tr>';
        numeroDatosSeguro++;
    }

    if (numeroDatosSeguro > 0) {
        tableDatosSeguro += '</table><br>';
        document.getElementById('tablaFaltaInfo').innerHTML += tableDatosSeguro;
        return false;
    } else {
        return true;
    }
}

function fn_nrm_ValidarDatosVehiculo() {
    var tableVehicleInfo = '<table><tr><th>Datos del Vehiculo</th><th>Descripcion</th></tr>';
    var numeroVehicleInfo = 0;

    if (anio.value === "" || anio.value === " ") {
        tableVehicleInfo += '<tr style="font-size: 14px;"><td>Año</td><td>Escriba el año del vehiculo</td></tr>';
        fn_nrm_SetRedBackground('anio');
        numeroVehicleInfo++;
    } else {
        fn_nrm_RemoveRedBackground('anio');
    }

    if (numeroVehicleInfo > 0) {
        tableVehicleInfo += '</table><br>';
        document.getElementById('tablaFaltaInfo').innerHTML += tableVehicleInfo;
        return false;
    } else {
        return true;
    }
}

// When the user clicks on <span> (x), close the modal
if (spanCloseDetalle !== null && spanCloseDetalle !== undefined) {
    spanCloseDetalle.onclick = function () {
        fn_nrm_closeModal('alertInfoDetalle');
    };
}

// When the user clicks on <span> (x), close the modal
if (alertaCloseGuardado !== null && alertaCloseGuardado !== undefined) {
    alertaCloseGuardado.onclick = function () {
        fn_nrm_closeModal('alertGuardadoAsistencia');
    };
}

function fn_nrm_showModal(idModal) {
    var modal = document.getElementById(idModal);
    modal.style.display = "block";
}

function fn_nrm_closeModal(idModal) {
    var modal = document.getElementById(idModal);
    modal.style.display = "none";
}

function fn_nrm_SetRedBackground(id) {
    document.getElementById(id).style.background = "yellow";
}

function fn_nrm_RemoveRedBackground(id) {
    document.getElementById(id).style.background = "";
}

function fn_nrm_Mapa(expe, usr) {
    var codPais = document.getElementById('pais').value;
    if (codPais !== null && codPais !== undefined && parseInt(codPais) !== -1) {
        console.dir('Cargando Mapa Punteo...');
        //Liga para DEV
        fn_LoadMap('https://siamdev.ikeasistencia.com/map_service_DEV/map_pointer?IdUsuario=1&IdCuenta=1450&IdSubServicio=211&clPais=' + parseInt(codPais, 10) + '&IdExpediente=' + parseInt(expe, 10), 'IdUsuario|IdCuenta|IdSubServicio|IdExpediente|clPais|Colonia|Calle|CP', parseInt(usr, 10) + ',V|1,V|1,V|' + parseInt(expe, 10) + ',V|' + parseInt(codPais, 10) + ',V|colonia|calleNumero|cp', 'cp|estado|municipioAlcaldia|colonia|calleNumero', 'map_service_DEV/map_pointer_DV?', parseInt(expe, 10));

        //Liga para QA
//        fn_LoadMap('https://siamdev.ikeasistencia.com/map_service/map_pointer?IdUsuario=1&IdCuenta=1450&IdSubServicio=211&clPais=' + parseInt(codPais, 10) + '&IdExpediente=' + parseInt(expe, 10), 'IdUsuario|IdCuenta|IdSubServicio|IdExpediente|clPais|Colonia|Calle|CP', parseInt(usr, 10) + ',V|1,V|1,V|' + parseInt(expe, 10) + ',V|' + parseInt(codPais, 10) + ',V|colonia|calleNumero|cp', 'cp|estado|municipioAlcaldia|colonia|calleNumero', 'map_service/map_pointer_DV?', parseInt(expe, 10));
    } else {
        document.getElementById('infoGuardado').innerHTML = "PARA VISUALIZAR EL MAPA DEBE SELECCIONAR UN PAIS.";
        fn_nrm_showModal('alertGuardadoAsistencia');
    }

}

function fn_nrm_ConsumeCombo(sql, id) {
    console.dir(id);
    ajaxRequest({param: [], sql: sql, component: "combobox", nivel: "../../"}, function (data) {
        document.getElementById(id).innerHTML = '<option value="-1">Seleccione una opcion...</option>';
        console.dir(data[0]);
        var tamanio = data.length;
        console.dir(tamanio);
        var i;
        for (i = 0; i < tamanio; i++) {
//            console.dir(data[i].text);
            document.getElementById(id).innerHTML += '<option value="' + data[i].value + '">' + data[i].text + '</option>';
        }
    });
}

function fn_nrm_LlenaEntidadFederativa() {
    var codPais = document.getElementById('pais').value;
    document.getElementById('municipioAlcaldia').innerHTML = '<option value="-1">Seleccione una opcion...</option>';
    if (parseInt(codPais, 10) === 10) {
        country = 10;
        fn_nrm_ConsumeCombo('[st_CatalogoEntidadFederativa]', 'estado');
    } else if (parseInt(codPais, 10) === 39) {
        country = 39;
        fn_nrm_ConsumeCombo('[st_nrm_EntFedChile]', 'estado');
    }
}

function fn_nrm_LlenaMunicipioDelegacion() {
    var codPais = document.getElementById('pais').value;
    var codEnt = document.getElementById('estado').value;
    var sql = '';

    if (parseInt(codPais, 10) === 10) {
        sql = '[st_MunDelxCodEnt]';
    } else if (parseInt(codPais, 10) === 39) {
        sql = '[st_nrm_MunDelxCodEntChile]';
    }


//    console.dir(codEnt);
    ajaxRequest({param: [codEnt], sql: sql, component: "combobox", nivel: "../../"}, function (data) {
//        console.dir(data);
        document.getElementById('municipioAlcaldia').innerHTML = '<option value="-1">Seleccione una opcion...</option>';
//        console.dir(data[0]);
        var tamanio = data.length;
//        console.dir(tamanio);
        var i;
        for (i = 0; i < tamanio; i++) {
//            console.dir(data[i].text);
            document.getElementById('municipioAlcaldia').innerHTML += '<option value="' + data[i].value + '">' + data[i].text + '</option>';
        }

    });
}

siArmas.onchange = function () {
    console.dir('Si Armas.');
    document.getElementById('tipoArmaDiv').style.display = 'block';
    document.getElementById('noAsaltantesDiv').style.display = 'block';
};

noArmas.onchange = function () {
    console.dir('No Armas.');
    document.getElementById('tipoArmaDiv').style.display = 'none';
    document.getElementById('noAsaltantesDiv').style.display = 'block';
    document.getElementById('noAsaltantes').value = "";
    fn_nrm_ConsumeCombo('[st_nrm_GetTipoArma]', 'tipoArma');
};

siViolencia.onchange = function () {
    console.dir('Si Violencia.');
    document.getElementById('portanArmasDiv').style.display = 'block';
};

noViolencia.onchange = function () {
    console.dir('No Violencia.');
    document.getElementById('portanArmasDiv').style.display = 'none';
    siArmas.checked = false;
    noArmas.checked = false;
    document.getElementById('tipoArmaDiv').style.display = 'none';
    document.getElementById('noAsaltantesDiv').style.display = 'block';
};

siRepuve.onchange = function () {
    console.dir('Si Repuve.');
    document.getElementById('folioRepuveDiv').style.display = 'block';
};

noRepuve.onchange = function () {
    console.dir('No Repuve.');
    document.getElementById('folioRepuveDiv').style.display = 'none';
    document.getElementById('folioRepuve').value = "";
};


si911.onchange = function () {
    console.dir('Si 911.');
    document.getElementById('folio911Div').style.display = 'block';
};

no911.onchange = function () {
    console.dir('No 911.');
    document.getElementById('folio911Div').style.display = 'none';
    document.getElementById('folio911').value = "";
};

siSeguro.onchange = function () {
    console.dir('Se Seguro.');
    document.getElementById('aseguradoraDiv').style.display = 'block';
    document.getElementById('noPolizaDiv').style.display = 'block';
    document.getElementById('noSiniestroDiv').style.display = 'block';
};

noSeguro.onchange = function () {
    console.dir('No Seguro.');
    fn_nrm_ConsumeCombo('[st_nrm_GetAseguradora]', 'aseguradora');
    document.getElementById('noPoliza').value = "";
    document.getElementById('noSiniestro').value = "";
    document.getElementById('aseguradoraDiv').style.display = 'none';
    document.getElementById('noPolizaDiv').style.display = 'none';
    document.getElementById('noSiniestroDiv').style.display = 'none';
};

function fn_nrm_OcultarElementos() {
    document.getElementById('aseguradoraDiv').style.display = 'none';
    document.getElementById('noPolizaDiv').style.display = 'none';
    document.getElementById('noSiniestroDiv').style.display = 'none';
    document.getElementById('folio911Div').style.display = 'none';
    document.getElementById('folioRepuveDiv').style.display = 'none';
    document.getElementById('portanArmasDiv').style.display = 'none';
    document.getElementById('tipoArmaDiv').style.display = 'none';
    document.getElementById('noAsaltantesDiv').style.display = 'none';
}

