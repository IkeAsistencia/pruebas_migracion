var alertaCloseTracking = document.getElementById('alertaCloseTracking');
var alertaClose = document.getElementById('alertaClose');
var inicioTracking = document.getElementById('inicioTracking');
var fechaInicioRegistro = document.getElementById('fechaInicioRegistro');
var estatusInicioServicio = document.getElementById('estatusInicioServicio');
var velocidadInicio = document.getElementById('velocidadInicio');
var estatusInicioArranque = document.getElementById('estatusInicioArranque');
var nivelInicioBateria = document.getElementById('nivelInicioBateria');
var kilometrajeInicio = document.getElementById('kilometrajeInicio');
var siInicioTracking = document.getElementById('siInicioTracking');
var noInicioTracking = document.getElementById('noInicioTracking');
var siUntracking = document.getElementById('siUntracking');
var noUntracking = document.getElementById('noUntracking');
var finTracking = document.getElementById('finTracking');
var fechaFinRegistro = document.getElementById('fechaFinRegistro');
var estatusFinServicio = document.getElementById('estatusFinServicio');
var velocidadFin = document.getElementById('velocidadFin');
var estatusFinArranque = document.getElementById('estatusFinArranque');
var nivelFinBateria = document.getElementById('nivelFinBateria');
var kilometrajeFin = document.getElementById('kilometrajeFin');
var siBlocking = document.getElementById('siBlocking');
var noBlocking = document.getElementById('noBlocking');
var inicioBlocking = document.getElementById('inicioBlocking');
var fechaBlocking = document.getElementById('fechaBlocking');
var estatusServicioBlocking = document.getElementById('estatusServicioBlocking');
var velocidadBlocking = document.getElementById('velocidadBlocking');
var estatusBlocking = document.getElementById('estatusBlocking');
var nivelBateriaBlocking = document.getElementById('nivelBateriaBlocking');
var kilometrajeBlocking = document.getElementById('kilometrajeBlocking');
var siFinBlocking = document.getElementById('siFinBlocking');
var noFinBlocking = document.getElementById('noFinBlocking');
var finBlocking = document.getElementById('finBlocking');
var fechaFinBlocking = document.getElementById('fechaFinBlocking');
var estatusServicioFinBlocking = document.getElementById('estatusServicioFinBlocking');
var velocidadFinBlocking = document.getElementById('velocidadFinBlocking');
var estatusFinBlocking = document.getElementById('estatusFinBlocking');
var nivelBateriaFinBlocking = document.getElementById('nivelBateriaFinBlocking');
var kilometrajeFinBlocking = document.getElementById('kilometrajeFinBlocking');
var btnTracking = document.getElementById('btnTracking');
    var pM = document.getElementById('porcentajeMonitoreo');
    var pB = document.getElementById('porcentajeBloqueo');
    var pDB = document.getElementById('porcentajeDesbloqueo');
    var pDM = document.getElementById('porcentajeDesmonitoreo');

function fn_nrm_ActualizaStatus(expe, clVin, usr) {

    var status;
    ajaxRequest({param: [parseInt(clVin, 10)],
        sql: "[st_nrm_ConsultaStatusVinTspPseudo]",
        component: "String",
        nivel: "../../"}, function (data) {
        if (data !== null && data !== undefined) {
            status = data.trim();
            console.dir(data);

            setTimeout(function () {
                if (siInicioTracking.checked) {
                    pM.innerHTML = 'Monitoreo completo';
                    pM.style.color = 'green';
                } else if ((!siInicioTracking.checked && !noInicioTracking.checked) || noInicioTracking.checked) {
                    pM.style.color = '#ff0000ab';
                    noInicioTracking.checked = 'true';
                    if (status === 'TRACKING REQUEST') {
                        pM.innerHTML = 'Monitoreo iniciado al 10%';
                    } else if (status === 'TRACKING RESPONSE') {
                        pM.innerHTML = 'Monitoreo iniciado al 30%';
                    } else if (status === 'TRACK STATUS KAM CORRECT') {
                        pM.innerHTML = 'Monitoreo iniciado al 50%';
                    } else if (status === 'TRACK STATUS VNEXT CORRECT') {
                        pM.innerHTML = 'Monitoreo iniciado al 70%';
                    } else if (status === 'TRACKING') {
                        pM.innerHTML = 'Monitoreo completo';
                        pM.style.color = 'green';
                        siInicioTracking.checked = 'true';
                        fn_nrm_ConsultarTrackingPendiente(expe, clVin, usr);
                        btnTracking.disabled = 'true';
                    } else {
                        pM.style.color = 'gray';
                        pM.innerHTML = 'No se esta monitoreando';
                    }
                }

                if (siBlocking.checked === true) {
                    pB.innerHTML = 'Bloque completo';
                    pB.style.color = 'green';
                } else if ((!siBlocking.checked && !noBlocking.checked) || noBlocking.checked) {
                    pB.style.color = '#ff0000ab';
                    noBlocking.checked = 'true';
                    if (status === 'BLOCKING REQUEST') {
                        pB.innerHTML = 'Bloqueo iniciado al 10%';
                    } else if (status === 'BLOCKING RESPONSE') {
                        pB.innerHTML = 'Bloqueo iniciado al 30%';
                    } else if (status === 'BLOCK STATUS KAM CORRECT') {
                        pB.innerHTML = 'Bloqueo iniciado al 50%';
                    } else if (status === 'BLOCK STATUS VNEXT CORRECT') {
                        pB.innerHTML = 'Bloqueo iniciado al 70%';
                    } else if (status === 'BLOCKING') {
                        pB.innerHTML = 'Bloqueo completo';
                        pB.style.color = 'green';
                        siBlocking.checked = 'true';
                        fn_nrm_ConsultarBlockingPendiente(expe, clVin, usr);
                    } else {
                        console.dir('No bloqueado');
                        pB.style.color = 'gray';
                        pB.innerHTML = 'No esta bloqueado';
                    }
                }

                if (siFinBlocking.checked) {
                    pDB.innerHTML = 'Desbloqueo Completo';
                    pDB.style.color = 'green';
                } else if ((!siFinBlocking.checked && !noFinBlocking.checked) || noFinBlocking.checked) {
                    pDB.style.color = '#ff0000ab';
                    noFinBlocking.checked = 'true';
                    if (status === 'UNBLOCKING REQUEST') {
                        pDB.innerHTML = 'Desbloqueo iniciado al 10%';
                    } else if (status === 'UNBLOCKING RESPONSE') {
                        pDB.innerHTML = 'Desbloqueo iniciado al 30%';
                    } else if (status === 'UNBLOCK STATUS KAM CORRECT') {
                        pDB.innerHTML = 'Desbloqueo iniciado al 50%';
                    } else if (status === 'UNBLOCK STATUS VNEXT CORRECT') {
                        pDB.innerHTML = 'Desbloqueo iniciado al 70%';
                    } else if (status === 'UNBLOCKING') {
                        pDB.innerHTML = 'Desbloqueo completo';
                        pDB.style.color = 'green';
                        siFinBlocking.checked = 'true';
                        fn_nrm_ConsultarUnBlockingPendiente(expe, clVin, usr);
                    } else {
                        pDB.style.color = 'gray';
                        pDB.innerHTML = 'No existe solicitud';
                    }
                }

                if (siUntracking.checked) {
                    pDM.innerHTML = 'Desmonitoreo Completo';
                    pDM.style.color = 'green';
                } else if ((!siUntracking.checked && !noUntracking.checked) || noUntracking.checked) {
                    pDM.style.color = '#ff0000ab';
                    noUntracking.checked = 'true';
                    if (status === 'UNTRACKING REQUEST') {
                        pDM.innerHTML = 'Desmonitoreo iniciado al 10%';
                    } else if (status === 'UNTRACKING RESPONSE') {
                        pDM.innerHTML = 'Desmonitoreo iniciado al 30%';
                    } else if (status === 'UNTRACK STATUS KAM CORRECT') {
                        pDM.innerHTML = 'Desmonitoreo iniciado al 50%';
                    } else if (status === 'UNTRACK STATUS VNEXT CORRECT') {
                        pDM.innerHTML = 'Desmonitoreo iniciado al 70%';
                    } else if (status === 'UNTRACKING') {
                        pDM.innerHTML = 'Desmonitoreo completo';
                        pDM.style.color = 'green';
                        siUntracking.checked = 'true';
                        fn_nrm_ConsultarUnTrackingPendiente(expe, clVin, usr);
                    } else {
                        pDM.style.color = 'gray';
                        pDM.innerHTML = 'No existe solicitud';
                    }
                }
            }, 500);
        }
    });


}

function fn_nrm_Guardar(usr, expe) {
    document.getElementById('messageTracking').innerHTML = "";
    document.getElementById('tablaFaltaInfo').innerHTML = "";
    if (fn_nrm_ValidaTracking()) {
        fn_nrm_GuardarTracking(usr, expe, 'manual');
    } else {
        fn_nrm_showModal('alertInfoUsuario');
    }

    if (fn_nrm_ValidaUntracking()) {
        fn_nrm_GuardarUnTracking(usr, expe, 'manual');
    } else {
        fn_nrm_showModal('alertInfoUsuario');
    }

    if (fn_nrm_ValidaBlocking()) {
        fn_nrm_GuardarBlocking(usr, expe, 'manual');
    } else {
        fn_nrm_showModal('alertInfoUsuario');
    }

    if (fn_nrm_ValidaUnblocking()) {
        fn_nrm_GuardarUnBlocking(usr, expe, 'manual');
    } else {
        fn_nrm_showModal('alertInfoUsuario');
    }
}

function fn_nrm_ValidaUnblocking() {
    var tableInfoUnBlocking = '<table><tr><th>Datos Desbloqueo</th><th>Descripcion</th></tr>';
    var numeroInfoUnBlocking = 0;
    if (finBlocking.value === "") {
        tableInfoUnBlocking += '<tr style="font-size: 14px;"><td>Ubicacion del Vehiculo</td><td>Escriba la ubicacion</td></tr>';
        numeroInfoUnBlocking++;
        fn_nrm_SetRedBackground('finBlocking');
    } else {
        fn_nrm_RemoveRedBackground('finBlocking');
    }

    if (fechaFinBlocking.value === "") {
        tableInfoUnBlocking += '<tr style="font-size: 14px;"><td>Fecha y Hora del Registro</td><td>Sellecione la fecha y hora</td></tr>';
        numeroInfoUnBlocking++;
        fn_nrm_SetRedBackground('fechaFinBlocking');
    } else {
        fn_nrm_RemoveRedBackground('fechaFinBlocking');
    }

    if (numeroInfoUnBlocking > 0) {
        tableInfoUnBlocking += '</table><br>';
        document.getElementById('tablaFaltaInfo').innerHTML += tableInfoUnBlocking;
        return false;
    } else {
        return true;
    }
}

function fn_nrm_ValidaBlocking() {
    var tableInfoBlocking = '<table><tr><th>Datos Bloqueo</th><th>Descripcion</th></tr>';
    var numeroInfoBlocking = 0;
    if (inicioBlocking.value === "") {
        tableInfoBlocking += '<tr style="font-size: 14px;"><td>Ubicacion del Vehiculo</td><td>Escriba la ubicacion</td></tr>';
        numeroInfoBlocking++;
        fn_nrm_SetRedBackground('inicioBlocking');
    } else {
        fn_nrm_RemoveRedBackground('inicioBlocking');
    }

    if (fechaBlocking.value === "") {
        tableInfoBlocking += '<tr style="font-size: 14px;"><td>Fecha y Hora del Registro</td><td>Sellecione la fecha y hora</td></tr>';
        numeroInfoBlocking++;
        fn_nrm_SetRedBackground('fechaBlocking');
    } else {
        fn_nrm_RemoveRedBackground('fechaBlocking');
    }

    if (numeroInfoBlocking > 0) {
        tableInfoBlocking += '</table><br>';
        document.getElementById('tablaFaltaInfo').innerHTML += tableInfoBlocking;
        return false;
    } else {
        return true;
    }
}

function fn_nrm_ValidaUntracking() {
    var tableInfoUnTracking = '<table><tr><th>Datos Desmonitoreo</th><th>Descripcion</th></tr>';
    var numeroInfoUnTracking = 0;
    if (finTracking.value === "") {
        tableInfoUnTracking += '<tr style="font-size: 14px;"><td>Ubicacion del Vehiculo</td><td>Escriba la ubicacion</td></tr>';
        numeroInfoUnTracking++;
        fn_nrm_SetRedBackground('finTracking');
    } else {
        fn_nrm_RemoveRedBackground('finTracking');
    }

    if (fechaFinRegistro.value === "") {
        tableInfoUnTracking += '<tr style="font-size: 14px;"><td>Fecha y Hora del Registro</td><td>Sellecione la fecha y hora</td></tr>';
        numeroInfoUnTracking++;
        fn_nrm_SetRedBackground('fechaFinRegistro');
    } else {
        fn_nrm_RemoveRedBackground('fechaFinRegistro');
    }

    if (numeroInfoUnTracking > 0) {
        tableInfoUnTracking += '</table><br>';
        document.getElementById('tablaFaltaInfo').innerHTML += tableInfoUnTracking;
        return false;
    } else {
        return true;
    }
}

function fn_nrm_ValidaTracking() {
    var tableInfoTracking = '<table><tr><th>Datos Monitoreo</th><th>Descripcion</th></tr>';
    var numeroInfoTracking = 0;
    if (inicioTracking.value === "") {
        tableInfoTracking += '<tr style="font-size: 14px;"><td>Ubicacion del Vehiculo</td><td>Escriba la ubicacion</td></tr>';
        numeroInfoTracking++;
        fn_nrm_SetRedBackground('inicioTracking');
    } else {
        fn_nrm_RemoveRedBackground('inicioTracking');
    }

    if (fechaInicioRegistro.value === "") {
        tableInfoTracking += '<tr style="font-size: 14px;"><td>Fecha y Hora del Registro</td><td>Sellecione la fecha y hora</td></tr>';
        numeroInfoTracking++;
        fn_nrm_SetRedBackground('fechaInicioRegistro');
    } else {
        fn_nrm_RemoveRedBackground('fechaInicioRegistro');
    }

    if (numeroInfoTracking > 0) {
        tableInfoTracking += '</table><br>';
        document.getElementById('tablaFaltaInfo').innerHTML += tableInfoTracking;
        return false;
    } else {
        return true;
    }
}

function fn_nrm_Deshabilitar() {
    siInicioTracking.disabled = true;
    noInicioTracking.disabled = true;
    siUntracking.disabled = true;
    noUntracking.disabled = true;
    siBlocking.disabled = true;
    noBlocking.disabled = true;
    siFinBlocking.disabled = true;
    noFinBlocking.disabled = true;
}

function fn_nrm_ConsultarUnBlockingGuardado(expe) {
    ajaxRequest({param: [parseInt(expe, 10)],
        sql: "[st_nrm_ConsultaUnBlocking]",
        component: "json",
        nivel: "../../"}, function (data) {
        if (data !== null && data !== undefined && data[0] !== undefined) {
            console.dir(data);
            if (parseInt(data[0].unBlockingExitoso, 10) === 1) {
                siFinBlocking.checked = true;
                finBlocking.value = data[0].ubicacionVehiculoUnBlock;
                fechaFinBlocking.value = data[0].fechaHoraUnBlock.replace(' ', 'T');
                estatusServicioFinBlocking.value = data[0].estatusServicioUnBlock;
                velocidadFinBlocking.value = data[0].velocidadUnBlock;
                setTimeout(function () {
                    estatusFinBlocking.value = parseInt(data[0].estatusArranqueUnBlock, 10);
                }, 2000);
                nivelBateriaFinBlocking.value = data[0].nivelBateriaUnBlock;
                kilometrajeFinBlocking.value = data[0].kilometrajeUnBlock;
            } else if (parseInt(data[0].unBlockingExitoso, 10) === 0) {
                finBlocking.value = data[0].ubicacionVehiculoUnBlock;
                fechaFinBlocking.value = data[0].fechaHoraUnBlock.replace(' ', 'T');
                noFinBlocking.checked = true;
            }
        }
    });
}

function fn_nrm_ConsultarBlockingGuardado(expe) {
    ajaxRequest({param: [parseInt(expe, 10)],
        sql: "[st_nrm_ConsultaBlocking]",
        component: "json",
        nivel: "../../"}, function (data) {
        if (data !== null && data !== undefined && data[0] !== undefined) {
            console.dir(data);
            if (parseInt(data[0].blockingExitoso, 10) === 1) {
                siBlocking.checked = true;
                inicioBlocking.value = data[0].ubicacionVehiculoBlock;
                fechaBlocking.value = data[0].fechaHoraBlock.replace(' ', 'T');
                estatusServicioBlocking.value = data[0].estatusServicioBlock;
                velocidadBlocking.value = data[0].velocidadBlock;
                setTimeout(function () {
                    estatusBlocking.value = parseInt(data[0].estatusArranqueBlock, 10);
                }, 2000);
                nivelBateriaBlocking.value = data[0].nivelBateriaBlock;
                kilometrajeBlocking.value = data[0].kilometrajeBlock;
            } else if (parseInt(data[0].blockingExitoso, 10) === 0) {
                inicioBlocking.value = data[0].ubicacionVehiculoBlock;
                fechaBlocking.value = data[0].fechaHoraBlock.replace(' ', 'T');
                noBlocking.checked = true;
            }
        }
    });
}

function fn_nrm_ConsultarUnTrackingGuardado(expe) {
    ajaxRequest({param: [parseInt(expe, 10)],
        sql: "[st_nrm_ConsultaUnTracking]",
        component: "json",
        nivel: "../../"}, function (data) {
        if (data !== null && data !== undefined && data[0] !== undefined) {
            console.dir(data);
            if (parseInt(data[0].unTrackingExitoso, 10) === 1) {
                siUntracking.checked = true;
                finTracking.value = data[0].ubicacionVehiculoUnTrack;
                fechaFinRegistro.value = data[0].fechaHoraUnTrack.replace(' ', 'T');
                estatusFinServicio.value = data[0].estatusServicioUnTrack;
                velocidadFin.value = data[0].velocidadUnTrack;
                setTimeout(function () {
                    estatusFinArranque.value = parseInt(data[0].estatusArranqueUnTrack, 10);
                }, 2000);
                nivelFinBateria.value = data[0].nivelBateriaUnTrack;
                kilometrajeFin.value = data[0].kilometrajeUnTrack;
            } else if (parseInt(data[0].unTrackingExitoso, 10) === 0) {
                finTracking.value = data[0].ubicacionVehiculoUnTrack;
                fechaFinRegistro.value = data[0].fechaHoraUnTrack.replace(' ', 'T');
                noUntracking.checked = true;
            }
        }
    });
}

function fn_nrm_ConsultarTrackingGuardado(expe) {
    ajaxRequest({param: [parseInt(expe, 10)],
        sql: "[st_nrm_ConsultaTracking]",
        component: "json",
        nivel: "../../"}, function (data) {
        if (data !== null && data !== undefined && data[0] !== undefined) {
            console.dir(data);
            if (parseInt(data[0].trackingExitoso, 10) === 1) {
                siInicioTracking.checked = true;
                inicioTracking.value = data[0].ubicacionVehiculoTrack;
                fechaInicioRegistro.value = data[0].fechaHoraTrack.replace(' ', 'T');
                estatusInicioServicio.value = data[0].estatusServicioTrack;
                velocidadInicio.value = data[0].velocidadTrack;
                setTimeout(function () {
                    estatusInicioArranque.value = parseInt(data[0].estatusArranqueTrack, 10);
                }, 2000);
                nivelInicioBateria.value = data[0].nivelBateriaTrack;
                kilometrajeInicio.value = data[0].kilometrajeTrack;
                btnTracking.disabled = 'true';
            } else if (parseInt(data[0].trackingExitoso, 10) === 0) {
                inicioTracking.value = data[0].ubicacionVehiculoTrack;
                fechaInicioRegistro.value = data[0].fechaHoraTrack.replace(' ', 'T');
                noInicioTracking.checked = true;
            }
        }
    });
}

function fn_nrm_IniciarTracking(event, command, usr, expe, vin, vinTspPseudo) {
    fn_nrm_showModal('process');
    var attr = {
        url: "servlet/com.ike.ws.nrm.TrackingProcess",
        command: command,
        vin: vin,
        vinTspPseudo: vinTspPseudo,
        event: event,
        contentType: "text/html; charset=utf-8",
        metodo: "POST",
        async: true,
        nivel: '../../'
    };
    var xmlHttpfn;
    try {
        xmlHttpfn = new XMLHttpRequest();// Firefox, Opera 8.0+, Safari
    } catch (e) {
        try {
            xmlHttpfn = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (e) {
            try {
                xmlHttpfn = new ActiveXObject("Msxml2.XMLHTTP"); // Internet Explorer
            } catch (e) {
                alert("No AJAX!?");
                return false;
            }
        }
    }
    xmlHttpfn.onreadystatechange = function () {
        if (xmlHttpfn.readyState === 4) {
            if (xmlHttpfn.status === 200) {
                fn_nrm_closeModal('process');
                console.dir(xmlHttpfn.responseText);
                console.dir(fn_stringToJson(xmlHttpfn.responseText));
                var response = fn_stringToJson(xmlHttpfn.responseText);

                if (parseInt(response.exitoso, 10) === 1) {
                    siInicioTracking.checked = true;
                    console.dir('Eliminando Diacriticos:')
                    console.dir(fn_nrm_EliminarDiacriticos(response.ubicacionVehiculo));
                    inicioTracking.value = fn_nrm_EliminarDiacriticos(response.ubicacionVehiculo);
                    fechaInicioRegistro.value = response.fechaHoraRegistro.replace(' ', 'T');
                    estatusInicioServicio.value = response.estatusServicio;
                    velocidadInicio.value = response.velocidad;
                    estatusInicioArranque.value = parseInt(response.estatusArranque, 10);
                    nivelInicioBateria.value = response.nivelBateria;
                    kilometrajeInicio.value = response.kilometraje;
                    fn_nrm_GuardarTracking(usr, expe);
                } else if (parseInt(response.exitoso, 10) === 0) {
                    noInicioTracking.checked = true;
                }
                document.getElementById('messageTracking').innerHTML = response.message;
                fn_nrm_showModal('alertTracking');
            } else {
                document.getElementById('messageRequest').innerHTML = "EL SERVICIO NO RESPONDE, INTENTELO NUEVAMENTE.";
                fn_nrm_showModal('alertTracking');
            }
        }
    };

    xmlHttpfn.open(attr.metodo, attr.nivel + attr.url, attr.async);
    xmlHttpfn.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlHttpfn.send("_=" + new Date().getTime() + "&command=" + attr.command + "&clVinTspPseudo=" + attr.vin + "&vinTspPseudo=" + attr.vinTspPseudo + "&event=" + attr.event);
}

function fn_nrm_ConsultarTrackingPendiente(expe, clVin, usr) {
    ajaxRequest({param: ["'" + parseInt(expe, 10) + "','" + parseInt(clVin, 10) + "'"],
        sql: "[st_nrm_ConsultarTrackingPendiente]",
        component: "json",
        nivel: "../../"}, function (data) {
        if (data !== null && data !== undefined && data[0] !== undefined) {
            console.dir(data[0]);
            if (parseInt(data[0].INFO, 10) === 0) {
                fn_nrm_ConsumeGeocoding(data[0].latitude, data[0].longitude, expe, usr, 'tracking');
                fechaInicioRegistro.value = data[0].fechaHoraRegistro.replace(' ', 'T');
                estatusInicioServicio.value = data[0].estatusServicio;
                velocidadInicio.value = data[0].velocidad;
                estatusInicioArranque.value = parseInt(data[0].estatusArranque, 10);
                nivelInicioBateria.value = data[0].nivelBateria;
                kilometrajeInicio.value = data[0].kilometraje;
            }
        }
    });
}

function fn_nrm_GuardarTracking(usr, expe, type) {
    var exitoso = 0;
    if (siInicioTracking.checked) {
        exitoso = 1;
    }

    if (type === 'pendiente') {
        console.dir('UNTRACKING PENDIENTE');
        exitoso = 1;
    }
    console.dir('Guardando Tracking:');
    console.dir(fn_nrm_EliminarDiacriticos(inicioTracking.value));
    console.dir("'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + type + "','" + fn_nrm_EliminarDiacriticos(inicioTracking.value) + "','" + fechaInicioRegistro.value.replace('T', ' ')
            + "','" + estatusInicioServicio.value + "','" + velocidadInicio.value + "','" + estatusInicioArranque.value + "','" + nivelInicioBateria.value
            + "','" + kilometrajeInicio.value + "','" + exitoso + "'");
    ajaxRequest({param: ["'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + type + "','" + fn_nrm_EliminarDiacriticos(inicioTracking.value) + "','" + fechaInicioRegistro.value.replace('T', ' ')
                    + "','" + estatusInicioServicio.value + "','" + velocidadInicio.value + "','" + estatusInicioArranque.value + "','" + nivelInicioBateria.value
                    + "','" + kilometrajeInicio.value + "','" + exitoso + "'"],
        sql: "[st_nrm_GuardaTracking]",
        component: "String",
        nivel: "../../"}, function (data) {
        console.dir(data);
        if (data.trim() === "ADDED") {
            document.getElementById('messageTracking').innerHTML += "<br>EL MONITOREO FUE GUARDADO CORRECTAMENTE.<br>";
            if (type !== 'manual') {
                btnTracking.disabled = 'true';
            }
            pM.innerHTML = 'Monitoreo completo';
            pM.style.color = 'green';
        } else if (data.trim() === "UPDATED") {
            document.getElementById('messageTracking').innerHTML += "<br>EL MONITOREO FUE ACTUALIZADO CORRECTAMENTE.<br>";
            if (type !== 'manual') {
                btnTracking.disabled = 'true';
            }
            pM.innerHTML = 'Monitoreo completo';
            pM.style.color = 'green';
        } else {
            document.getElementById('messageTracking').innerHTML += "<br>OCURRIO UN ERROR AL GUARDAR EL MONITOREO.<br>";
        }
        fn_nrm_showModal('alertTracking');
    });
}

function fn_nrm_ConsultarUnTrackingPendiente(expe, clVin, usr) {
    ajaxRequest({param: ["'" + parseInt(expe, 10) + "','" + parseInt(clVin, 10) + "'"],
        sql: "[st_nrm_ConsultarUntrackingPendiente]",
        component: "json",
        nivel: "../../"}, function (data) {
        if (data !== null && data !== undefined && data[0] !== undefined) {
            console.dir(data[0]);
            if (parseInt(data[0].INFO, 10) === 0) {
                fn_nrm_ConsumeGeocoding(data[0].latitude, data[0].longitude, expe, usr, 'untracking');
                fechaFinRegistro.value = data[0].fechaHoraRegistro.replace(' ', 'T');
                estatusFinServicio.value = data[0].estatusServicio;
                velocidadFin.value = data[0].velocidad;
                estatusFinArranque.value = parseInt(data[0].estatusArranque, 10);
                nivelFinBateria.value = data[0].nivelBateria;
                kilometrajeFin.value = data[0].kilometraje;
            }
        }
    });
}

function fn_nrm_GuardarUnTracking(usr, expe, type) {
    var exitoso = 0;
    if (siUntracking.checked) {
        exitoso = 1;
    }

    if (type === 'pendiente') {
        console.dir('UNTRACKING PENDIENTE');
        exitoso = 1;
    }

    console.dir("'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + type + "','" + fn_nrm_EliminarDiacriticos(finTracking.value) + "','" + fechaFinRegistro.value.replace('T', ' ')
            + "','" + estatusFinServicio.value + "','" + velocidadFin.value + "','" + estatusFinArranque.value + "','" + nivelFinBateria.value
            + "','" + kilometrajeFin.value + "','" + exitoso + "'");
    ajaxRequest({param: ["'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + type + "','" + fn_nrm_EliminarDiacriticos(finTracking.value) + "','" + fechaFinRegistro.value.replace('T', ' ')
                    + "','" + estatusFinServicio.value + "','" + velocidadFin.value + "','" + estatusFinArranque.value + "','" + nivelFinBateria.value
                    + "','" + kilometrajeFin.value + "','" + exitoso + "'"],
        sql: "[st_nrm_GuardaUnTracking]",
        component: "String",
        nivel: "../../"}, function (data) {
        console.dir(data);
        if (data.trim() === "ADDED") {
            document.getElementById('messageTracking').innerHTML += "<br>EL DESMONITOREO FUE GUARDADO CORRECTAMENTE.<br>";
            pDM.innerHTML = 'Desmonitoreo Completo';
            pDM.style.color = 'green';
        } else if (data.trim() === "UPDATED") {
            document.getElementById('messageTracking').innerHTML += "<br>EL DESMONITOREO FUE ACTUALIZADO CORRECTAMENTE.<br>";
            pDM.innerHTML = 'Desmonitoreo Completo';
            pDM.style.color = 'green';
        } else {
            document.getElementById('messageTracking').innerHTML += "<br>OCURRIO UN ERROR AL GUARDAR EL DESMONITOREO.<br>";
        }
        fn_nrm_showModal('alertTracking');
    });
}

function fn_nrm_ConsultarBlockingPendiente(expe, clVin, usr) {
    ajaxRequest({param: ["'" + parseInt(expe, 10) + "','" + parseInt(clVin, 10) + "'"],
        sql: "[st_nrm_ConsultarBlockingPendiente]",
        component: "json",
        nivel: "../../"}, function (data) {
        if (data !== null && data !== undefined && data[0] !== undefined) {
            console.dir(data[0]);
            if (parseInt(data[0].INFO, 10) === 0) {
                fn_nrm_ConsumeGeocoding(data[0].latitude, data[0].longitude, expe, usr, 'blocking');
                fechaBlocking.value = data[0].fechaHoraRegistro.replace(' ', 'T');
                estatusServicioBlocking.value = data[0].estatusServicio;
                velocidadBlocking.value = data[0].velocidad;
                estatusBlocking.value = parseInt(data[0].estatusArranque, 10);
                nivelBateriaBlocking.value = data[0].nivelBateria;
                kilometrajeBlocking.value = data[0].kilometraje;
            }
        }
    });
}

function fn_nrm_GuardarBlocking(usr, expe, type) {
    var exitoso = 0;
    if (siBlocking.checked) {
        exitoso = 1;
    }

    if (type === 'pendiente') {
        console.dir('BLOCKING PENDIENTE');
        exitoso = 1;
    }
    console.dir("'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + type + "','" + fn_nrm_EliminarDiacriticos(inicioBlocking.value) + "','" + fechaBlocking.value.replace('T', ' ')
            + "','" + estatusServicioBlocking.value + "','" + velocidadBlocking.value + "','" + estatusBlocking.value + "','" + nivelBateriaBlocking.value
            + "','" + kilometrajeBlocking.value + "','" + exitoso + "'");
    ajaxRequest({param: ["'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + type + "','" + fn_nrm_EliminarDiacriticos(inicioBlocking.value) + "','" + fechaBlocking.value.replace('T', ' ')
                    + "','" + estatusServicioBlocking.value + "','" + velocidadBlocking.value + "','" + estatusBlocking.value + "','" + nivelBateriaBlocking.value
                    + "','" + kilometrajeBlocking.value + "','" + exitoso + "'"],
        sql: "[st_nrm_GuardaBlocking]",
        component: "String",
        nivel: "../../"}, function (data) {
        console.dir(data);
        if (data.trim() === "ADDED") {
            document.getElementById('messageTracking').innerHTML += "<br>EL BLOQUEO FUE GUARDADO CORRECTAMENTE.<br>";
            pB.innerHTML = 'Bloque completo';
            pB.style.color = 'green';
        } else if (data.trim() === "UPDATED") {
            document.getElementById('messageTracking').innerHTML += "<br>EL BLOQUEO FUE ACTUALIZADO CORRECTAMENTE.<br>";
            pB.innerHTML = 'Bloque completo';
            pB.style.color = 'green';
        } else {
            document.getElementById('messageTracking').innerHTML += "<br>OCURRIO UN ERROR AL GUARDAR EL BLOQUEO.<br>";
        }
        fn_nrm_showModal('alertTracking');
    });
}

function fn_nrm_ConsultarUnBlockingPendiente(expe, clVin, usr) {
    ajaxRequest({param: ["'" + parseInt(expe, 10) + "','" + parseInt(clVin, 10) + "'"],
        sql: "[st_nrm_ConsultarUnblockingPendiente]",
        component: "json",
        nivel: "../../"}, function (data) {
        if (data !== null && data !== undefined && data[0] !== undefined) {
            console.dir(data[0]);
            if (parseInt(data[0].INFO, 10) === 0) {
                fn_nrm_ConsumeGeocoding(data[0].latitude, data[0].longitude, expe, usr, 'unblocking');
                fechaFinBlocking.value = data[0].fechaHoraRegistro.replace(' ', 'T');
                estatusServicioFinBlocking.value = data[0].estatusServicio;
                velocidadFinBlocking.value = data[0].velocidad;
                estatusFinBlocking.value = parseInt(data[0].estatusArranque, 10);
                nivelBateriaFinBlocking.value = data[0].nivelBateria;
                kilometrajeFinBlocking.value = data[0].kilometraje;
            }
        }
    });
}

function fn_nrm_GuardarUnBlocking(usr, expe, type) {
    var exitoso = 0;
    if (siFinBlocking.checked) {
        exitoso = 1;
    }

    if (type === 'pendiente') {
        console.dir('UNBLOCKING PENDIENTE');
        exitoso = 1;
    }
    console.dir("'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + type + "','" + fn_nrm_EliminarDiacriticos(finBlocking.value) + "','" + fechaFinBlocking.value.replace('T', ' ')
            + "','" + estatusServicioFinBlocking.value + "','" + velocidadFinBlocking.value + "','" + estatusFinBlocking.value + "','" + nivelBateriaFinBlocking.value
            + "','" + kilometrajeFinBlocking.value + "','" + exitoso + "'");
    ajaxRequest({param: ["'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + type + "','" + fn_nrm_EliminarDiacriticos(finBlocking.value) + "','" + fechaFinBlocking.value.replace('T', ' ')
                    + "','" + estatusServicioFinBlocking.value + "','" + velocidadFinBlocking.value + "','" + estatusFinBlocking.value + "','" + nivelBateriaFinBlocking.value
                    + "','" + kilometrajeFinBlocking.value + "','" + exitoso + "'"],
        sql: "[st_nrm_GuardaUnBlocking]",
        component: "String",
        nivel: "../../"}, function (data) {
        console.dir(data);
        if (data.trim() === "ADDED") {
            document.getElementById('messageTracking').innerHTML += "<br>EL DESBLOQUEO FUE GUARDADO CORRECTAMENTE.<br>";
            pDB.innerHTML = 'Desbloqueo Completo';
            pDB.style.color = 'green';
        } else if (data.trim() === "UPDATED") {
            document.getElementById('messageTracking').innerHTML += "<br>EL DESBLOQUEO FUE ACTUALIZADO CORRECTAMENTE.<br>";
            pDB.innerHTML = 'Desbloqueo Completo';
            pDB.style.color = 'green';
        } else {
            document.getElementById('messageTracking').innerHTML += "<br>OCURRIO UN ERROR AL GUARDAR EL DESBLOQUEO.<br>";
        }
        fn_nrm_showModal('alertTracking');
    });
}

function fn_nrm_ConsumeGeocoding(latitude, longitude, expe, usr, type) {
    document.getElementById('messageTracking').innerHTML = "";
    console.dir('Geocoding');
    var attr = {
        url: "servlet/com.ike.ws.nrm.GeocodingProcess",
        latitude: latitude,
        longitude: longitude,
        contentType: "text/html; charset=utf-8",
        metodo: "POST",
        async: true,
        nivel: '../../'
    };
    var xmlHttpfn;
    try {
        xmlHttpfn = new XMLHttpRequest();// Firefox, Opera 8.0+, Safari
    } catch (e) {
        try {
            xmlHttpfn = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (e) {
            try {
                xmlHttpfn = new ActiveXObject("Msxml2.XMLHTTP"); // Internet Explorer
            } catch (e) {
                alert("No AJAX!?");
                return false;
            }
        }
    }
    xmlHttpfn.onreadystatechange = function () {
        if (xmlHttpfn.readyState === 4) {
            if (xmlHttpfn.status === 200) {
                console.dir(xmlHttpfn.responseText);

                if (type === 'tracking') {
                    siInicioTracking.checked = true;
                    inicioTracking.value = xmlHttpfn.responseText;
                    fn_nrm_GuardarTracking(usr, expe, 'pendiente');
                    document.getElementById('messageTracking').innerHTML += "<br>SE DETECTO UN MONITOREO PENDIENTE";
                } else if (type === 'untracking') {
                    siUntracking.checked = true;
                    finTracking.value = xmlHttpfn.responseText;
                    fn_nrm_GuardarUnTracking(usr, expe, 'pendiente');
                    document.getElementById('messageTracking').innerHTML += "<br>SE DETECTO UN DESMONITOREO PENDIENTE";
                } else if (type === 'blocking') {
                    siBlocking.checked = true;
                    inicioBlocking.value = xmlHttpfn.responseText;
                    fn_nrm_GuardarBlocking(usr, expe, 'pendiente');
                    document.getElementById('messageTracking').innerHTML += "<br>SE DETECTO UN BLOQUEO PENDIENTE";
                } else if (type === 'unblocking') {
                    siFinBlocking.checked = true;
                    finBlocking.value = xmlHttpfn.responseText;
                    fn_nrm_GuardarUnBlocking(usr, expe, 'pendiente');
                    document.getElementById('messageTracking').innerHTML += "<br>SE DECTECTO UN DESBLOQUEO PENDIENTE";
                }

                fn_nrm_showModal('alertTracking');
            } else {

            }
        }
    };

    xmlHttpfn.open(attr.metodo, attr.nivel + attr.url, attr.async);
    xmlHttpfn.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlHttpfn.send("_=" + new Date().getTime() + "&latitud=" + attr.latitude + "&longitud=" + attr.longitude);
}

function fn_nrm_ConsumeCombo(sql, id) {
    ajaxRequest({param: [], sql: sql, component: "combobox", nivel: "../../"}, function (data) {
        document.getElementById(id).innerHTML = '<option value="-1">Seleccione una opcion...</option>';
//        console.dir(data[0]);
        var tamanio = data.length;
//        console.dir(tamanio);
        var i;
        for (i = 0; i < tamanio; i++) {
//            console.dir(data[i].text);
            document.getElementById(id).innerHTML += '<option value="' + data[i].value + '">' + data[i].text + '</option>';
        }
    });
}

// When the user clicks on <span> (x), close the modal
if (alertaClose !== null && alertaClose !== undefined) {
    alertaClose.onclick = function () {
        fn_nrm_closeModal('alertInfoUsuario');
    };
}

// When the user clicks on <span> (x), close the modal
if (alertaCloseTracking !== null && alertaCloseTracking !== undefined) {
    alertaCloseTracking.onclick = function () {
        fn_nrm_closeModal('alertTracking');
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

/**
 * Metodo que recibe un json como parametro y 
 * lo regresa como un string la variable _jsonString
 * es global
 * @param {*} _json 
 */
function fn_jsonToString(_json) {
    _jsonString = JSON.stringify(_json);
    return _jsonString;
}

/**
 * Metodo que recibe un string como parametro y 
 * lo regresa como un json la variable _stringJson
 * es global 
 * @param {*} _string 
 */
function fn_stringToJson(_string) {
    _stringJson = JSON.parse(_string);
    return _stringJson;
}

function fn_nrm_CustodiaVehiculo(expe, vin, vinTspPseudo, pais) {
    location.href = "CustodiaVehiculoNRM.jsp?clExpediente=" + expe + "&clVinTspPseudo=" + vin + "&vinTspPseudo=" + vinTspPseudo + "&clPais=" + pais;
}

function fn_nrm_RedirectDetalleAsistencia(expe) {
    location.href = "DetalleAsistenciaNRM.jsp?clExpediente=" + expe;
}

function fn_nrm_EliminarDiacriticos(texto) {
    console.dir(texto.normalize('NFD').replace(/[\u0300-\u036f]/g, ""));
    return texto.normalize('NFD').replace(/[\u0300-\u036f]/g, "");
}

function fn_nrm_SetRedBackground(id) {
    document.getElementById(id).style.background = "yellow";
}

function fn_nrm_RemoveRedBackground(id) {
    document.getElementById(id).style.background = "";
}


