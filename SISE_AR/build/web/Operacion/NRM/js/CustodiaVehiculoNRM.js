var vin = 0;
var vinTspPseudo = "";
var usr = 0;
var expe = 0;
var siTracking = document.getElementById('siTracking');
var noTracking = document.getElementById('noTracking');
var tipoUbicacion = document.getElementById('tipoUbicacion');
var divNivel = document.getElementById('divNivel');
var nivel = document.getElementById('nivel');
var siInventario = document.getElementById('siInventario');
var noInventario = document.getElementById('noInventario');
var divFolioInventario = document.getElementById('divFolioInventario');
var folioInventario = document.getElementById('folioInventario');
var siBloqueo = document.getElementById('siBloqueo');
var noBloqueo = document.getElementById('noBloqueo');
var alertaCloseInfoCustodia = document.getElementById('alertaCloseInfoCustodia');
var alertaCloseCustodia = document.getElementById('alertaCloseCustodia');
var estatus = document.getElementById('estatus');
var siLlegadaCustodio = document.getElementById('siLlegadaCustodio');
var noLlegadaCustodio = document.getElementById('noLlegadaCustodio');
var siVehiculoUbicacion = document.getElementById('siVehiculoUbicacion');
var noVehiculoUbicacion = document.getElementById('noVehiculoUbicacion');
var siAutoridades = document.getElementById('siAutoridades');
var noAutoridades = document.getElementById('noAutoridades');
var siAccesible = document.getElementById('siAccesible');
var noAccesible = document.getElementById('noAccesible');
var tipoPropiedad = document.getElementById('tipoPropiedad');
var siLlegadaAutoridades = document.getElementById('siLlegadaAutoridades');
var noLlegadaAutoridades = document.getElementById('noLlegadaAutoridades');
var fechaAutoridades = document.getElementById('fechaAutoridades');
var autoridadPresente = document.getElementById('autoridadPresente');
var noOficiales = document.getElementById('noOficiales');
var idPatrulla = document.getElementById('idPatrulla');
var condicionesVehiculo = document.getElementById('condicionesVehiculo');
var disposicionAutoridad = document.getElementById('disposicionAutoridad');
var siDesbloqueo = document.getElementById('siDesbloqueo');
var noDesbloqueo = document.getElementById('noDesbloqueo');
var siUntracking = document.getElementById('siUntracking');
var noUntracking = document.getElementById('noUntracking');
var infoAdicional = document.getElementById('infoAdicional');
var noFolio = document.getElementById('noFolio');
var escoltaAsignado = document.getElementById('escoltaAsignado');
var lada = document.getElementById('lada');
var telefono = document.getElementById('telefono');
var pais = document.getElementById('pais');
var estado = document.getElementById('estado');
var municipioAlcaldia = document.getElementById('municipioAlcaldia');
var colonia = document.getElementById('colonia');
var fechaAsignacion = document.getElementById('fechaAsignacion');
var tiempoArribo = document.getElementById('tiempoArribo');
var siTraslado = document.getElementById('siTraslado');
var noTraslado = document.getElementById('noTraslado');
var tipoDestino = document.getElementById('tipoDestino');
var estadoDestino = document.getElementById('estadoDestino');
var municipioDestino = document.getElementById('municipioDestino');
var coloniaDestino = document.getElementById('coloniaDestino');
var cpDestino = document.getElementById('cpDestino');
var calleNumeroDestino = document.getElementById('calleNumeroDestino');
var refVisualesDestino = document.getElementById('refVisualesDestino');
var siResguardo = document.getElementById('siResguardo');
var noResguardo = document.getElementById('noResguardo');
var fechaInicioRegistro = document.getElementById('fechaInicioRegistro');
var estatusInicioServicio = document.getElementById('estatusInicioServicio');
var velocidadInicio = document.getElementById('velocidadInicio');
var estatusInicioArranque = document.getElementById('estatusInicioArranque');
var nivelInicioBateria = document.getElementById('nivelInicioBateria');
var kilometrajeInicio = document.getElementById('kilometrajeInicio');
var folio911 = document.getElementById('folio911');
var folioRepuve = document.getElementById('folioRepuve');
var siArmas = document.getElementById('siArmas');
var noArmas = document.getElementById('noArmas');
var tipoArma = document.getElementById('tipoArma');
var noAsaltantes = document.getElementById('noAsaltantes');
var inicioTracking = document.getElementById('inicioTracking');
var longitud = document.getElementById('longitud');
var latitud = document.getElementById('latitud');
var direccionUltimoPunto = document.getElementById('direccionUltimoPunto');
var clPais = "";
var pM = document.getElementById('porcentajeMonitoreo');
var pB = document.getElementById('porcentajeBloqueo');
var pDB = document.getElementById('porcentajeDesbloqueo');
var pDM = document.getElementById('porcentajeDesmonitoreo');

var inicioTrackingPendiente = '';
var inicioUnrackingPendiente = '';
var inicioBlockingPendiente = '';
var inicioUnblockingPendiente = '';

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
                if (siTracking.checked) {
                pM.innerHTML = 'Monitoreo completo';
                pM.style.color = 'green';
            } else if ((!siTracking.checked && !noTracking.checked) || noTracking.checked) {
                pM.style.color = '#ff0000ab';
                noTracking.checked = 'true';
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
                    siTracking.checked = 'true';
                    fn_nrm_ConsultarTrackingPendiente(expe, clVin, usr);
                } else {
                    pM.style.color = 'gray';
                    pM.innerHTML = 'No se esta monitoreando';
                }
            }

            if (siBloqueo.checked) {
                pB.innerHTML = 'Bloque completo';
                pB.style.color = 'green';
            } else if ((!siBloqueo.checked && !noBloqueo.checked) || noBloqueo.checked) {
                pB.style.color = '#ff0000ab';
                noBloqueo.checked = 'true';
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
                    siBloqueo.checked = 'true';
                    fn_nrm_ConsultarBlockingPendiente(expe, clVin, usr);
                } else {
                    pB.style.color = 'gray';
                    pB.innerHTML = 'No esta bloqueado';
                }
            }

            if (siDesbloqueo.checked) {
                pDB.innerHTML = 'Desbloqueo Completo';
                pDB.style.color = 'green';
            } else if ((!siDesbloqueo.checked && !noDesbloqueo.checked) || noDesbloqueo.checked) {
                pDB.style.color = '#ff0000ab';
                noDesbloqueo.checked = 'true';
                if (status === 'UNBLOCKING REQUEST') {
                    pDB.innerHTML = 'Blocking iniciado al 10%';
                } else if (status === 'UNBLOCKING RESPONSE') {
                    pDB.innerHTML = 'Blocking iniciado al 30%';
                } else if (status === 'UNBLOCK STATUS KAM CORRECT') {
                    pDB.innerHTML = 'Blocking iniciado al 50%';
                } else if (status === 'UNBLOCK STATUS VNEXT CORRECT') {
                    pDB.innerHTML = 'Blocking iniciado al 70%';
                } else if (status === 'UNBLOCKING') {
                    pDB.innerHTML = 'Desbloqueo completo';
                    pDB.style.color = 'green';
                    siDesbloqueo.checked = 'true';
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
                    pDM.innerHTML = 'Untracking iniciado al 10%';
                } else if (status === 'UNTRACKING RESPONSE') {
                    pDM.innerHTML = 'Untracking iniciado al 30%';
                } else if (status === 'UNTRACK STATUS KAM CORRECT') {
                    pDM.innerHTML = 'Untracking iniciado al 50%';
                } else if (status === 'UNTRACK STATUS VNEXT CORRECT') {
                    pDM.innerHTML = 'Untracking iniciado al 70%';
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

function fn_nrm_ConsultarTrackingPendiente(expe, clVin, usr) {
    ajaxRequest({param: ["'" + parseInt(expe, 10) + "','" + parseInt(clVin, 10) + "'"],
        sql: "[st_nrm_ConsultarTrackingPendiente]",
        component: "json",
        nivel: "../../"}, function (data) {
        if (data !== null && data !== undefined && data[0] !== undefined) {
            console.dir(data[0]);
            if (parseInt(data[0].INFO, 10) === 0) {
                fn_nrm_ConsumeGeocoding(data[0].latitude, data[0].longitude, expe, usr, 'tracking', data[0]);
            }
        }
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
                fn_nrm_ConsumeGeocoding(data[0].latitude, data[0].longitude, expe, usr, 'untracking', data[0]);
            }
        }
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
                fn_nrm_ConsumeGeocoding(data[0].latitude, data[0].longitude, expe, usr, 'blocking', data[0]);
            }
        }
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
                fn_nrm_ConsumeGeocoding(data[0].latitude, data[0].longitude, expe, usr, 'unblocking', data[0]);
            }
        }
    });
}

function fn_nrm_ConsumeGeocoding(latitude, longitude, expe, usr, type, response) {
    document.getElementById('messageCustodia').innerHTML = "";
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
                    inicioTrackingPendiente = xmlHttpfn.responseText;
                    fn_nrm_GuardarTracking(usr, expe, 'pendiente', response);
                    document.getElementById('messageCustodia').innerHTML += "<br>SE DETECTO UN MONITOREO PENDIENTE";
                } else if (type === 'untracking') {
                    inicioUnrackingPendiente = xmlHttpfn.responseText;
                    siUntracking.disabled = true;
                    noUntracking.disabled = true;
                    fn_nrm_GuardarUnTracking(usr, expe, 'pendiente', response);
                    document.getElementById('messageCustodia').innerHTML += "<br>SE DETECTO UN DESMONITOREO PENDIENTE";
                } else if (type === 'blocking') {
                    inicioBlockingPendiente = xmlHttpfn.responseText;
                    siBloqueo.disabled = true;
                    noBloqueo.disabled = true;
                    fn_nrm_GuardarBlocking(usr, expe, 'pendiente', response);
                    document.getElementById('messageCustodia').innerHTML += "<br>SE DETECTO UN BLOQUEO PENDIENTE";
                } else if (type === 'unblocking') {
                    inicioUnblockingPendiente = xmlHttpfn.responseText;
                    siDesbloqueo.disabled = true;
                    noDesbloqueo.disabled = true;
                    fn_nrm_GuardarUnBlocking(usr, expe, 'pendiente', response);
                    document.getElementById('messageCustodia').innerHTML += "<br>SE DECTECTO UN DESBLOQUEO PENDIENTE";
                }

                fn_nrm_showModal('alertCustodia');
            } else {

            }
        }
    };

    xmlHttpfn.open(attr.metodo, attr.nivel + attr.url, attr.async);
    xmlHttpfn.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlHttpfn.send("_=" + new Date().getTime() + "&latitud=" + attr.latitude + "&longitud=" + attr.longitude);
}

function fn_nrm_GuardarTracking(usr, expe, type, response) {
    var exitoso = 0;
    var ubicacion = '';
    
    if (type === 'pendiente') {
        ubicacion = inicioTrackingPendiente;
    } else {
        ubicacion = response.ubicacionVehiculo;
    }
    
    if (siTracking.checked || type === 'pendiente') {
        exitoso = 1;
    }
    
    console.dir('Guardando Tracking:');
    console.dir("'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + type + "','" + fn_nrm_EliminarDiacriticos(ubicacion) + "','" + response.fechaHoraRegistro.replace(' ', 'T')
            + "','" + response.estatusServicio + "','" + response.velocidad + "','" + parseInt(response.estatusArranque, 10) + "','" + response.nivelBateria
            + "','" + response.kilometraje + "','" + exitoso + "'");
    ajaxRequest({param: ["'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + type + "','" + fn_nrm_EliminarDiacriticos(ubicacion) + "','" + response.fechaHoraRegistro.replace(' ', 'T')
                    + "','" + response.estatusServicio + "','" + response.velocidad + "','" + parseInt(response.estatusArranque, 10) + "','" + response.nivelBateria
                    + "','" + response.kilometraje + "','" + exitoso + "'"],
        sql: "[st_nrm_GuardaTracking]",
        component: "String",
        nivel: "../../"}, function (data) {
        console.dir(data);
        if (data.trim() === "ADDED") {
            document.getElementById('messageCustodia').innerHTML += "<br>EL MONITOREO FUE GUARDADO CORRECTAMENTE.<br>";
            pM.innerHTML = 'Monitoreo completo';
            pM.style.color = 'green';
        } else if (data.trim() === "UPDATED") {
            document.getElementById('messageCustodia').innerHTML += "<br>EL MONITOREO FUE ACTUALIZADO CORRECTAMENTE.<br>";
            pM.innerHTML = 'Monitoreo completo';
            pM.style.color = 'green';
        } else {
            document.getElementById('messageCustodia').innerHTML += "<br>OCURRIO UN ERROR AL GUARDAR EL MONITOREO.<br>";
        }
        fn_nrm_showModal('alertCustodia');
    });
}

function fn_nrm_RedirectListaExpedientes() {
    location.href = "ListadoExpedientes.jsp";
}

function fn_nrm_UltimaUbicacion(clVin) {
    ajaxRequest({param: ["'" + parseInt(clVin, 10) + "'"],
        sql: "[st_nrm_UltimaUbicacionVehiculo]",
        component: "json",
        nivel: "../../"}, function (data) {
        if (data !== null && data !== undefined && data[0] !== undefined) {
            console.dir(data[0]);
            latitud.value = data[0].latitude;
            longitud.value = data[0].longitude;
            fn_nrm_ConsumeGeocodingUbicacion(data[0].latitude, data[0].longitude);
        }
    });
}

function fn_nrm_ConsumeGeocodingUbicacion(latitude, longitude) {
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
                direccionUltimoPunto.value = xmlHttpfn.responseText;
            } else {
                direccionUltimoPunto.value = 'NO SE PUEDE CONSULTAR LA DIRECCION, INTENTELO NUEVAMENTE.';
            }
        }
    };

    xmlHttpfn.open(attr.metodo, attr.nivel + attr.url, attr.async);
    xmlHttpfn.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlHttpfn.send("_=" + new Date().getTime() + "&latitud=" + attr.latitude + "&longitud=" + attr.longitude);
}


function fn_nrm_ConsultarAsistenciaGuardada(expe) {
    ajaxRequest({param: ["'" + parseInt(expe, 10) + "'"],
        sql: "[st_nrm_ConsultaDetalleAsistencia]",
        component: "json",
        nivel: "../../"}, function (data) {
        if (data !== null && data !== undefined && data[0] !== undefined) {
            console.dir(data[0]);
            folio911.value = data[0].noReporte911;
            folioRepuve.value = data[0].noRepuve;
            if (parseInt(data[0].portanArmas, 10) === 1) {
                siArmas.checked = true;
            } else if (parseInt(data[0].portanArmas, 10) === 0) {
                noArmas.checked = true;
            }
            setTimeout(function () {
                tipoArma.value = parseInt(data[0].clTipoArma, 10);
            }, 2000);
            noAsaltantes.value = parseInt(data[0].noAsaltantes, 10);
        }
        folio911.readOnly = true;
        siArmas.disabled = true;
        noArmas.disabled = true;
        folioRepuve.readOnly = true;
        tipoArma.disabled = true;
        noAsaltantes.readOnly = true;
    });
}

function fn_nrm_GuardarCustodia(usr, expe) {
    document.getElementById('messageCustodia').innerHTML = "";
    document.getElementById('tablaFaltaInfo').innerHTML = "";
    if (fn_nrm_ValidarInfoCustodio()) {
        fn_nrm_showModal('process');
        fn_nrm_GuardarInfoCustodio(usr, expe);
    } else {
        fn_nrm_showModal('alertInfoCustodia');
    }

    if (fn_nrm_ValidarSeguimientoCustodio()) {
        fn_nrm_showModal('process');
        fn_nrm_GuardarSeguimientoCustodio(usr, expe);
    } else {
        fn_nrm_showModal('alertInfoCustodia');
    }

    if (fn_nrm_ValidarDestinoVehiculo()) {
        fn_nrm_showModal('process');
        fn_nrm_GuardarDestinoVehiculo(usr, expe);
    } else {
        fn_nrm_showModal('alertInfoCustodia');
    }
}

function fn_nrm_ValidarDestinoVehiculo() {
    var tableDestVehiculo = '<table><tr><th>Datos Destino Vehiculo</th><th>Descripcion</th></tr>';
    var numeroDestVehiculo = 0;

    if (siTraslado.checked || noTraslado.checked) {

    } else {
        tableDestVehiculo += '<tr style="font-size: 14px;"><td>Traslado por Autoridad?</td><td>Seleccione una opcion</td></tr>';
        numeroDestVehiculo++;
    }

    if (parseInt(tipoDestino.value, 10) === -1) {
        tableDestVehiculo += '<tr style="font-size: 14px;"><td>Tipo de Destino</td><td>Seleccione una opcion</td></tr>';
        fn_nrm_SetRedBackground('tipoDestino');
        numeroDestVehiculo++;
    } else {
        fn_nrm_RemoveRedBackground('tipoDestino');
    }

    if (parseInt(estadoDestino.value, 10) === -1) {
        tableDestVehiculo += '<tr style="font-size: 14px;"><td>Estado</td><td>Seleccione una opcion</td></tr>';
        fn_nrm_SetRedBackground('estadoDestino');
        numeroDestVehiculo++;
    } else {
        fn_nrm_RemoveRedBackground('estadoDestino');
    }

    if (parseInt(estadoDestino.value, 10) !== -1 && parseInt(municipioDestino.value, 10) === -1) {
        tableDestVehiculo += '<tr style="font-size: 14px;"><td>Municipio/Alcaldia</td><td>Seleccione una opcion</td></tr>';
        fn_nrm_SetRedBackground('municipioDestino');
        numeroDestVehiculo++;
    } else if (parseInt(estado.value, 10) !== -1 && parseInt(municipioDestino.value, 10) !== -1) {
        fn_nrm_RemoveRedBackground('municipioDestino');
    }

    if (coloniaDestino.value === "" || coloniaDestino.value === " ") {
        tableDestVehiculo += '<tr style="font-size: 14px;"><td>Colonia</td><td>Escriba la colonia</td></tr>';
        fn_nrm_SetRedBackground('coloniaDestino');
        numeroDestVehiculo++;
    } else {
        fn_nrm_RemoveRedBackground('coloniaDestino');
    }

    if (cpDestino.value === "" || cpDestino.value <= 0) {
        tableDestVehiculo += '<tr style="font-size: 14px;"><td>C.P.</td><td>Escriba un codigo postal valido</td></tr>';
        fn_nrm_SetRedBackground('cpDestino');
        numeroDestVehiculo++;
    } else {
        fn_nrm_RemoveRedBackground('cpDestino');
    }

    if (calleNumeroDestino.value === "" || calleNumeroDestino.value === " ") {
        tableDestVehiculo += '<tr style="font-size: 14px;"><td>Calle y Numero</td><td>Escriba la calle y el numero</td></tr>';
        fn_nrm_SetRedBackground('calleNumeroDestino');
        numeroDestVehiculo++;
    } else {
        fn_nrm_RemoveRedBackground('calleNumeroDestino');
    }

    if (refVisualesDestino.value === "" || refVisualesDestino.value === " ") {
        tableDestVehiculo += '<tr style="font-size: 14px;"><td>Referencias</td><td>Escriba las referencias visuales</td></tr>';
        fn_nrm_SetRedBackground('refVisualesDestino');
        numeroDestVehiculo++;
    } else {
        fn_nrm_RemoveRedBackground('refVisualesDestino');
    }

    if (siResguardo.checked || noResguardo.checked) {

    } else {
        tableDestVehiculo += '<tr style="font-size: 14px;"><td>Ingreso a Resguardo Oficial?</td><td>Seleccione una opcion</td></tr>';
        numeroDestVehiculo++;
    }

    if (numeroDestVehiculo > 0) {
        tableDestVehiculo += '</table><br>';
        document.getElementById('tablaFaltaInfo').innerHTML += tableDestVehiculo;
        return false;
    } else {
        return true;
    }
}

function fn_nrm_ValidarSeguimientoCustodio() {
    var tableSeguiCustodio = '<table><tr><th>Datos Seguimiento Custodio</th><th>Descripcion</th></tr>';
    var numeroSeguiCustodio = 0;

    if (parseInt(estatus.value, 10) === -1) {
        tableSeguiCustodio += '<tr style="font-size: 14px;"><td>Estatus</td><td>Seleccione una opcion</td></tr>';
        fn_nrm_SetRedBackground('estatus');
        numeroSeguiCustodio++;
    } else {
        fn_nrm_RemoveRedBackground('estatus');
    }

    if (numeroSeguiCustodio > 0) {
        tableSeguiCustodio += '</table><br>';
        document.getElementById('tablaFaltaInfo').innerHTML += tableSeguiCustodio;
        return false;
    } else {
        return true;
    }
}

function fn_nrm_ValidarInfoCustodio() {
    var tableInfoCustodio = '<table><tr><th>Datos Info Custodio</th><th>Descripcion</th></tr>';
    var numeroInfoCustodio = 0;

    if (noFolio.value === "" || noFolio.value === " ") {
        tableInfoCustodio += '<tr style="font-size: 14px;"><td>No. de Folio</td><td>Escriba el numero de folio</td></tr>';
        fn_nrm_SetRedBackground('noFolio');
        numeroInfoCustodio++;
    } else {
        fn_nrm_RemoveRedBackground('noFolio');
    }

    if (escoltaAsignado.value === "" || escoltaAsignado.value === " ") {
        tableInfoCustodio += '<tr style="font-size: 14px;"><td>Escolta Asignado</td><td>Escriba el nombre del escolta</td></tr>';
        fn_nrm_SetRedBackground('escoltaAsignado');
        numeroInfoCustodio++;
    } else {
        fn_nrm_RemoveRedBackground('escoltaAsignado');
    }

    if (lada.value === "" || lada.value === " ") {
        tableInfoCustodio += '<tr style="font-size: 14px;"><td>Lada</td><td>Escriba la lada</td></tr>';
        fn_nrm_SetRedBackground('lada');
        numeroInfoCustodio++;
    } else {
        fn_nrm_RemoveRedBackground('lada');
    }

    if (telefono.value === "" || telefono.value === " ") {
        tableInfoCustodio += '<tr style="font-size: 14px;"><td>Telefono</td><td>Escriba el numero de telefono</td></tr>';
        fn_nrm_SetRedBackground('telefono');
        numeroInfoCustodio++;
    } else {
        fn_nrm_RemoveRedBackground('telefono');
    }

    if (parseInt(pais.value, 10) === -1) {
        tableInfoCustodio += '<tr style="font-size: 14px;"><td>Pais</td><td>Seleccione una opcion</td></tr>';
        fn_nrm_SetRedBackground('pais');
        numeroInfoCustodio++;
    } else {
        fn_nrm_RemoveRedBackground('pais');
    }

    if (parseInt(estado.value, 10) === -1) {
        tableInfoCustodio += '<tr style="font-size: 14px;"><td>Estado</td><td>Seleccione una opcion</td></tr>';
        fn_nrm_SetRedBackground('estado');
        numeroInfoCustodio++;
    } else {
        fn_nrm_RemoveRedBackground('estado');
    }

    if (parseInt(estado.value, 10) !== -1 && parseInt(municipioAlcaldia.value, 10) === -1) {
        tableInfoCustodio += '<tr style="font-size: 14px;"><td>Municipio/Alcaldia</td><td>Seleccione una opcion</td></tr>';
        fn_nrm_SetRedBackground('municipioAlcaldia');
        numeroInfoCustodio++;
    } else if (parseInt(estado.value, 10) !== -1 && parseInt(municipioAlcaldia.value, 10) !== -1) {
        fn_nrm_RemoveRedBackground('municipioAlcaldia');
    }

    if (colonia.value === "" || colonia.value === " ") {
        tableInfoCustodio += '<tr style="font-size: 14px;"><td>Colonia</td><td>Escriba la colonia</td></tr>';
        fn_nrm_SetRedBackground('colonia');
        numeroInfoCustodio++;
    } else {
        fn_nrm_RemoveRedBackground('colonia');
    }

    if (fechaAsignacion.value === "") {
        tableInfoCustodio += '<tr style="font-size: 14px;"><td>Fecha y Hora de Asignacion</td><td>Seleccione la fecha y hora</td></tr>';
        fn_nrm_SetRedBackground('fechaAsignacion');
        numeroInfoCustodio++;
    } else {
        fn_nrm_RemoveRedBackground('fechaAsignacion');
    }

    if (parseInt(tiempoArribo.value, 10) === -1) {
        tableInfoCustodio += '<tr style="font-size: 14px;"><td>Tiempo Estimado de Arribo</td><td>Seleccione una opcion</td></tr>';
        fn_nrm_SetRedBackground('tiempoArribo');
        numeroInfoCustodio++;
    } else {
        fn_nrm_RemoveRedBackground('tiempoArribo');
    }

    if (numeroInfoCustodio > 0) {
        tableInfoCustodio += '</table><br>';
        document.getElementById('tablaFaltaInfo').innerHTML += tableInfoCustodio;
        return false;
    } else {
        return true;
    }
}

function fn_nrm_SetRedBackground(id) {
    document.getElementById(id).style.background = "yellow";
}

function fn_nrm_RemoveRedBackground(id) {
    document.getElementById(id).style.background = "";
}

function fn_nrm_ConsultarDestinoVehiculoGuardado(expe) {
    ajaxRequest({param: [parseInt(expe, 10)],
        sql: "[st_nrm_ConsultaDestinoVehiculo]",
        component: "json",
        nivel: "../../"}, function (data) {
        if (data !== null && data !== undefined && data[0] !== undefined) {
            console.dir(data);
            if (parseInt(data[0].ingresoResguOficial, 10) === 1) {
                siResguardo.checked = true;
            } else if (parseInt(data[0].ingresoResguOficial, 10) === 0) {
                noResguardo.checked = true;
            }
            cpDestino.value = data[0].cpDestinoVehiculo;
            if (parseInt(data[0].trasladoAutoridad, 10) === 1) {
                siTraslado.checked = true;
            } else if (parseInt(data[0].trasladoAutoridad, 10) === 0) {
                noTraslado.checked = true;
            }
            refVisualesDestino.value = data[0].referenciasDestinoVehiculo;
            calleNumeroDestino.value = data[0].calleNumeroDestinoVehiculo;
            coloniaDestino.value = data[0].coloniaDestionVehiculo;

            setTimeout(function () {
                if (data[0].clTipoDestinoVehiculo !== 0) {
                    tipoDestino.value = parseInt(data[0].clTipoDestinoVehiculo, 10);
                }
            }, 1000);

            setTimeout(function () {
                if (data[0].clEdoDestionVehiculo !== 0) {
                    estadoDestino.value = data[0].clEdoDestionVehiculo;
                    fn_nrm_LlenaMunicipioDelegacionDestino('estadoDestino', 'municipioDestino');
                }
            }, 4000);

            setTimeout(function () {
                if (data[0].clMunDestionVehiculo !== 0) {
                    municipioDestino.value = data[0].clMunDestionVehiculo;
                }
            }, 5000);
        }
    });
}

function fn_nrm_GuardarDestinoVehiculo(usr, expe) {
    var traslado = 0;
    if (siTraslado.checked) {
        traslado = 1;
    }
    var resguardo = 0;
    if (siResguardo.checked) {
        resguardo = 1;
    }
    console.dir("'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + 1 + "','" + traslado
            + "','" + parseInt(tipoDestino.value, 10) + "','" + parseInt(estadoDestino.value, 10)
            + "','" + parseInt(municipioDestino.value, 10) + "','" + coloniaDestino.value
            + "','" + parseInt(cpDestino.value, 10) + "','" + calleNumeroDestino.value
            + "','" + refVisualesDestino.value + "','" + resguardo + "'");
    ajaxRequest({param: ["'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + 1 + "','" + traslado
                    + "','" + parseInt(tipoDestino.value, 10) + "','" + estadoDestino.value
                    + "','" + municipioDestino.value + "','" + coloniaDestino.value
                    + "','" + parseInt(cpDestino.value, 10) + "','" + calleNumeroDestino.value
                    + "','" + refVisualesDestino.value + "','" + resguardo + "'"],
        sql: "[st_nrm_GuardaDestinoVehiculo]",
        component: "String",
        nivel: "../../"}, function (data) {
        console.dir(data);
        if (data.trim() === "ADDED") {
            document.getElementById('messageCustodia').innerHTML += "<br>EL DESTINO FUE GUARDADO CORRECTAMENTE.";
        } else if (data.trim() === "UPDATED") {
            document.getElementById('messageCustodia').innerHTML += "<br>EL DESTINO FUE ACTUALIZADO CORRECTAMENTE.";
        } else {
            document.getElementById('messageCustodia').innerHTML += "<br>OCURRIO UN ERROR AL GUARDAR EL DESTINO.";
        }
        fn_nrm_showModal('alertCustodia');
        fn_nrm_closeModal('process');
    });
}

function  fn_nrm_ConsultarInfoCustodioGuardado(expe, pais) {
    clPais = pais;
    ajaxRequest({param: [parseInt(expe, 10)],
        sql: "[st_nrm_ConsultaInfoCustodio]",
        component: "json",
        nivel: "../../"}, function (data) {
        if (data !== null && data !== undefined && data[0] !== undefined) {
            console.dir(data);
            escoltaAsignado.value = data[0].escoltaAsginado;
            lada.value = data[0].lada;
            telefono.value = data[0].telefono;
            fechaAsignacion.value = data[0].fechaHoraAsigCustodio.replace(' ', 'T');
            noFolio.value = data[0].noFolio;
            colonia.value = data[0].colonia;

           
            
            setTimeout(function () {
                fn_nrm_LlenaEntidadFederativa();
            }, 2000);

            setTimeout(function () {
                if (data[0].clEdo !== 0) {
                    estado.value = data[0].clEdo;
                }
            }, 3000);

            setTimeout(function () {
                fn_nrm_LlenaMunicipioDelegacion();
            }, 4000);
            
            setTimeout(function () {
                municipioAlcaldia.value = data[0].clMun;
            }, 5000);
            
            setTimeout(function () {
                if (data[0].clEstimaTiempoArribo !== 0) {
                    tiempoArribo.value = parseInt(data[0].clEstimaTiempoArribo, 10);
                }
            }, 1000);
        }
    });
}

function fn_nrm_GuardarInfoCustodio(usr, expe) {
    console.dir("'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + 1 + "','" + noFolio.value
            + "','" + escoltaAsignado.value + "','" + lada.value + "','" + telefono.value + "','" + parseInt(pais.value, 10) + "','" + estado.value
            + "','" + municipioAlcaldia.value + "','" + colonia.value + "','" + fechaAsignacion.value.replace('T', ' ')
            + "','" + parseInt(tiempoArribo.value, 10) + "'");
    ajaxRequest({param: ["'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + 1 + "','" + noFolio.value
                    + "','" + escoltaAsignado.value + "','" + lada.value + "','" + telefono.value + "','" + parseInt(pais.value, 10) + "','" + estado.value
                    + "','" + municipioAlcaldia.value + "','" + colonia.value + "','" + fechaAsignacion.value.replace('T', ' ')
                    + "','" + parseInt(tiempoArribo.value, 10) + "'"],
        sql: "[st_nrm_GuardaInfoCustodio]",
        component: "String",
        nivel: "../../"}, function (data) {
        console.dir(data);
        if (data.trim() === "ADDED") {
            document.getElementById('messageCustodia').innerHTML += "<br>LA INFORMACION FUE GUARDADA CORRECTAMENTE.";
        } else if (data.trim() === "UPDATED") {
            document.getElementById('messageCustodia').innerHTML += "<br>LA INFORMACION FUE ACTUALIZADA CORRECTAMENTE.";
        } else {
            document.getElementById('messageCustodia').innerHTML += "<br>OCURRIO UN ERROR AL GUARDAR LA INFORMACION.";
        }
        fn_nrm_showModal('alertCustodia');
        fn_nrm_closeModal('process');
    });
}

function fn_nrm_ConsultarSeguimientoCustodioGuardado(expe) {
    ajaxRequest({param: [parseInt(expe, 10)],
        sql: "[st_nrm_ConsultaSeguimientoCustodio]",
        component: "json",
        nivel: "../../"}, function (data) {
        if (data !== null && data !== undefined && data[0] !== undefined) {
            console.dir(data);
            if (parseInt(data[0].solicitaBloqCustodio, 10) === 1) {
                siBloqueo.checked = true;
                siBloqueo.disabled = true;
                noBloqueo.disabled = true;
            } else if (parseInt(data[0].solicitaBloqCustodio, 10) === 0) {
                noBloqueo.checked = true;
            }
            if (parseInt(data[0].llegadaUbicacionCustodio, 10) === 1) {
                siLlegadaCustodio.checked = true;
            } else if (parseInt(data[0].llegadaUbicacionCustodio, 10) === 0) {
                noLlegadaCustodio.checked = true;
            }
            if (parseInt(data[0].vehiculoUbicacion, 10) === 1) {
                siVehiculoUbicacion.checked = true;
            } else if (parseInt(data[0].vehiculoUbicacion, 10) === 0) {
                noVehiculoUbicacion.checked = true;
            }
            if (parseInt(data[0].llegadaUbicacionAutoridad, 10) === 1) {
                siAutoridades.checked = true;
            } else if (parseInt(data[0].llegadaUbicacionAutoridad, 10) === 0) {
                noAutoridades.checked = true;
            }
            if (parseInt(data[0].zonaAccesoAutoridad, 10) === 1) {
                siAccesible.checked = true;
            } else if (parseInt(data[0].zonaAccesoAutoridad, 10) === 0) {
                noAccesible.checked = true;
            }
            if (parseInt(data[0].clTipoUbicacionVehiculo, 10) === 2 || parseInt(data[0].clTipoUbicacionVehiculo, 10) === 3) {
                divNivel.style.display = "block";
                nivel.value = parseInt(data[0].nivelVehiculo, 10);
            }
            if (parseInt(data[0].llegadaUbicacionAutoridad, 10) === 1) {
                siLlegadaAutoridades.checked = true;
            } else if (parseInt(data[0].llegadaUbicacionAutoridad, 10) === 0) {
                noLlegadaAutoridades.checked = true;
            }
            fechaAutoridades.value = data[0].fechaHoraLlegadaAutoridad.replace(' ', 'T');
            noOficiales.value = parseInt(data[0].numeroOficiales, 10);
            idPatrulla.value = data[0].idPatrulla;
            if (parseInt(data[0].realizaInventario, 10) === 1) {
                siInventario.checked = true;
                divFolioInventario.style.display = "block";
                folioInventario.value = data[0].noFolioInventario;
            } else if (parseInt(data[0].realizaInventario, 10) === 0) {
                noInventario.checked = true;
            }
            if (parseInt(data[0].solicitaDesbloqueoVehiculo, 10) === 1) {
                siDesbloqueo.checked = true;
                siDesbloqueo.disabled = true;
                noDesbloqueo.disabled = true;
            } else if (parseInt(data[0].solicitaDesbloqueoVehiculo, 10) === 0) {
                noDesbloqueo.checked = true;
            }
            if (parseInt(data[0].solicitaUntrackingVehiculo, 10) === 1) {
                siUntracking.checked = true;
                siUntracking.disabled = true;
                noUntracking.disabled = true;
            } else if (parseInt(data[0].solicitaUntrackingVehiculo, 10) === 0) {
                noUntracking.checked = true;
            }
            infoAdicional.value = data[0].informacionAdicional;


            setTimeout(function () {
                if (data[0].clCondicionesVehiculo !== 0) {
                    condicionesVehiculo.value = parseInt(data[0].clCondicionesVehiculo, 10);
                }
                if (data[0].clTipoUbicacionVehiculo !== 0) {
                    tipoUbicacion.value = parseInt(data[0].clTipoUbicacionVehiculo, 10);
                }
                if (data[0].clTipoPropiedad !== 0) {
                    document.getElementById('tipoPropiedad').value = parseInt(data[0].clTipoPropiedad, 10);
                }
                if (data[0].clAutoridadPresenta !== 0) {
                    autoridadPresente.value = parseInt(data[0].clAutoridadPresenta, 10);
                }
                if (data[0].clvehiculoDisposicionAutoridad !== 0) {
                    disposicionAutoridad.value = parseInt(data[0].clvehiculoDisposicionAutoridad, 10);
                }
                if (data[0].clEstatusSeguiCustodio !== 0) {
                    estatus.value = data[0].clEstatusSeguiCustodio;
                }
            }, 2000);
        }
    });
}

function fn_nrm_GuardarSeguimientoCustodio(usr, expe) {
    var bloqueo = 0;
    if (siBloqueo.checked) {
        bloqueo = 1;
    }
    var llegada = 0;
    if (siLlegadaCustodio.checked) {
        llegada = 1;
    }
    var vehiculoUbica = 0;
    if (siVehiculoUbicacion.checked) {
        vehiculoUbica = 1;
    }
    var autoridad = 0;
    if (siAutoridades.checked) {
        autoridad = 1;
    }
    var accesible = 0;
    if (siAccesible.checked) {
        accesible = 1;
    }
    var inventario = 0;
    if (siInventario.checked) {
        inventario = 1;
    }
    var desbloqueo = 0;
    if (siDesbloqueo.checked) {
        desbloqueo = 1;
    }
    var untracking = 0;
    if (siUntracking.checked) {
        untracking = 1;
    }
    var llegadaAutoridad = 0;
    if (siLlegadaAutoridades.checked) {
        llegadaAutoridad = 1;
    }
    var tipoPropiedad = document.getElementById('tipoPropiedad');
    console.dir("'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + 1 + "','" + parseInt(estatus.value, 10)
            + "','" + bloqueo + "','" + llegada + "','" + vehiculoUbica + "','" + autoridad + "','" + accesible
            + "','" + parseInt(tipoUbicacion.value, 10) + "','" + nivel.value + "','" + tipoPropiedad.value
            + "','" + llegadaAutoridad + "','" + fechaAutoridades.value.replace('T', ' ') + "','" + parseInt(autoridadPresente.value, 10)
            + "','" + noOficiales.value + "','" + idPatrulla.value + "','" + inventario + "','" + folioInventario.value
            + "','" + parseInt(condicionesVehiculo.value, 10) + "','" + parseInt(disposicionAutoridad.value, 10)
            + "','" + desbloqueo + "','" + untracking + "','" + infoAdicional.value + "'");
    ajaxRequest({param: ["'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + 1 + "','" + parseInt(estatus.value, 10)
                    + "','" + bloqueo + "','" + llegada + "','" + vehiculoUbica + "','" + autoridad + "','" + accesible
                    + "','" + parseInt(tipoUbicacion.value, 10) + "','" + nivel.value + "','" + tipoPropiedad.value
                    + "','" + llegadaAutoridad + "','" + fechaAutoridades.value.replace('T', ' ') + "','" + parseInt(autoridadPresente.value, 10)
                    + "','" + noOficiales.value + "','" + idPatrulla.value + "','" + inventario + "','" + folioInventario.value
                    + "','" + parseInt(condicionesVehiculo.value, 10) + "','" + parseInt(disposicionAutoridad.value, 10)
                    + "','" + desbloqueo + "','" + untracking + "','" + infoAdicional.value + "'"],
        sql: "[st_nrm_GuardaSeguimientoCustodio]",
        component: "String",
        nivel: "../../"}, function (data) {
        console.dir(data);
        if (data.trim() === "ADDED") {
            document.getElementById('messageCustodia').innerHTML += "<br>EL SEGUIMIENTO FUE GUARDADO CORRECTAMENTE.";
        } else if (data.trim() === "UPDATED") {
            document.getElementById('messageCustodia').innerHTML += "<br>EL SEGUIMIENTO FUE ACTUALIZADO CORRECTAMENTE.";
        } else {
            document.getElementById('messageCustodia').innerHTML += "<br>OCURRIO UN ERROR AL GUARDAR EL SEGUIMIENTO.";
        }
        fn_nrm_showModal('alertCustodia');
        fn_nrm_closeModal('process');
    });
}

function fn_nrm_GuardarUnTracking(usr, expe, type, response) {
    var exitoso = 0;
    var ubicacion = '';
    
    if (type === 'pendiente') {
        ubicacion = inicioUnrackingPendiente;
    } else {
        ubicacion = response.ubicacionVehiculo;
    }
    
    if (siUntracking.checked || type === 'pendiente') {
        exitoso = 1;
    }
    
    console.dir("'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + type + "','" + fn_nrm_EliminarDiacriticos(ubicacion) + "','" + response.fechaHoraRegistro.replace('T', ' ')
            + "','" + response.estatusServicio + "','" + response.velocidad + "','" + response.estatusArranque + "','" + response.nivelBateria
            + "','" + response.kilometraje + "','" + exitoso + "'");
    ajaxRequest({param: ["'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + "" + "','" + fn_nrm_EliminarDiacriticos(ubicacion) + "','" + response.fechaHoraRegistro.replace('T', ' ')
                    + "','" + response.estatusServicio + "','" + response.velocidad + "','" + response.estatusArranque + "','" + response.nivelBateria
                    + "','" + response.kilometraje + "','" + exitoso + "'"],
        sql: "[st_nrm_GuardaUnTracking]",
        component: "String",
        nivel: "../../"}, function (data) {
        console.dir(data);
        if (data.trim() === "ADDED") {
            fn_nrm_GuardarSeguimientoCustodio(usr, expe);
            document.getElementById('messageCustodia').innerHTML += "<br>EL DESMONITOREO FUE GUARDADO CORRECTAMENTE.";
            pDM.innerHTML = 'Desmonitoreo Completo';
            pDM.style.color = 'green';
        } else if (data.trim() === "UPDATED") {
            fn_nrm_GuardarSeguimientoCustodio(usr, expe);
            document.getElementById('messageCustodia').innerHTML += "<br>EL DESMONITOREO FUE ACTUALIZADO CORRECTAMENTE.";
            pDM.innerHTML = 'Desmonitoreo Completo';
            pDM.style.color = 'green';
        } else {
            document.getElementById('messageCustodia').innerHTML += "<br>OCURRIO UN ERROR AL GUARDAR EL DESMONITOREO.";
        }
    });
}

function fn_nrm_GuardarUnBlocking(usr, expe, type, response) {
    var exitoso = 0;
    var ubicacion = '';
    
    if (type === 'pendiente') {
        ubicacion = inicioUnblockingPendiente;
    } else {
        ubicacion = response.ubicacionVehiculo;
    }
    
    if (siDesbloqueo.checked || type === 'pendiente') {
        console.dir('UNTRACKING PENDIENTE');
        exitoso = 1;
    }
    
    console.dir("'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + type + "','" + fn_nrm_EliminarDiacriticos(ubicacion) + "','" + response.fechaHoraRegistro.replace('T', ' ')
            + "','" + response.estatusServicio + "','" + response.velocidad + "','" + response.estatusArranque + "','" + response.nivelBateria
            + "','" + response.kilometraje + "','" + exitoso + "'");
    ajaxRequest({param: ["'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + "" + "','" + fn_nrm_EliminarDiacriticos(ubicacion) + "','" + response.fechaHoraRegistro.replace('T', ' ')
                    + "','" + response.estatusServicio + "','" + response.velocidad + "','" + response.estatusArranque + "','" + response.nivelBateria
                    + "','" + response.kilometraje + "','" + exitoso + "'"],
        sql: "[st_nrm_GuardaUnBlocking]",
        component: "String",
        nivel: "../../"}, function (data) {
        console.dir(data);
        if (data.trim() === "ADDED") {
            fn_nrm_GuardarSeguimientoCustodio(usr, expe);
            document.getElementById('messageCustodia').innerHTML += "<br>EL DESBLOQUEO FUE GUARDADO CORRECTAMENTE.";
            pDB.innerHTML = 'Desbloqueo Completo';
            pDB.style.color = 'green';
        } else if (data.trim() === "UPDATED") {
            fn_nrm_GuardarSeguimientoCustodio(usr, expe);
            document.getElementById('messageCustodia').innerHTML += "<br>EL DESBLOQUEO FUE ACTUALIZADO CORRECTAMENTE.";
            pDB.innerHTML = 'Desbloqueo Completo';
            pDB.style.color = 'green';
        } else {
            document.getElementById('messageCustodia').innerHTML += "<br>OCURRIO UN ERROR AL GUARDAR EL DESBLOQUEO.";
        }
    });
}

function fn_nrm_GuardarBlocking(usr, expe, type, response) {
    var exitoso = 0;
    var ubicacion = '';
    
    if (type === 'pendiente') {
        ubicacion = inicioBlockingPendiente;
    } else {
        ubicacion = response.ubicacionVehiculo;
    }
    
    if (siBloqueo.checked || type === 'pendiente') {
        console.dir('UNTRACKING PENDIENTE');
        exitoso = 1;
    }
    
    console.dir("'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + type + "','" + fn_nrm_EliminarDiacriticos(ubicacion) + "','" + response.fechaHoraRegistro.replace('T', ' ')
            + "','" + response.estatusServicio + "','" + response.velocidad + "','" + response.estatusArranque + "','" + response.nivelBateria
            + "','" + response.kilometraje + "','" + exitoso + "'");
    ajaxRequest({param: ["'" + parseInt(usr, 10) + "','" + parseInt(expe, 10) + "','" + "" + "','" + fn_nrm_EliminarDiacriticos(ubicacion) + "','" + response.fechaHoraRegistro.replace('T', ' ')
                    + "','" + response.estatusServicio + "','" + response.velocidad + "','" + response.estatusArranque + "','" + response.nivelBateria
                    + "','" + response.kilometraje + "','" + exitoso + "'"],
        sql: "[st_nrm_GuardaBlocking]",
        component: "String",
        nivel: "../../"}, function (data) {
        console.dir(data);
        if (data.trim() === "ADDED") {
            fn_nrm_GuardarSeguimientoCustodio(usr, expe);
            document.getElementById('messageCustodia').innerHTML += "<br>EL BLOQUEO FUE GUARDADO CORRECTAMENTE.";
            pB.innerHTML = 'Bloque completo';
            pB.style.color = 'green';
        } else if (data.trim() === "UPDATED") {
            fn_nrm_GuardarSeguimientoCustodio(usr, expe);
            document.getElementById('messageCustodia').innerHTML += "<br>EL BLOQUEO FUE ACTUALIZADO CORRECTAMENTE.";
            pB.innerHTML = 'Bloque completo';
            pB.style.color = 'green';
        } else {
            document.getElementById('messageCustodia').innerHTML += "<br>OCURRIO UN ERROR AL GUARDAR EL BLOQUEO.";
        }
    });
}

function fn_nrm_IniciarBlocking(command, vin, vinTspPseudo, event) {
    fn_nrm_showModal('process');
    var attr = {
        url: "servlet/com.ike.ws.nrm.BlockingProcess",
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
                    if (command === "block") {
                        siBloqueo.disabled = true;
                        noBloqueo.disabled = true;
                        fn_nrm_GuardarBlocking(usr, expe, '', response);
                    } else if (command === "unblock") {
                        siDesbloqueo.disabled = true;
                        noDesbloqueo.disabled = true;
                        fn_nrm_GuardarUnBlocking(usr, expe, '', response);
                    }

                } else if (parseInt(response.exitoso, 10) === 0) {
                    if (command === "block") {
                        siBloqueo.checked = false;
                        noBloqueo.checked = false;
                    } else if (command === "unblock") {
                        siDesbloqueo.checked = false;
                        noDesbloqueo.checked = false;
                    }
                }
                document.getElementById('messageCustodia').innerHTML = response.message;
                fn_nrm_showModal('alertCustodia');
            } else {
                document.getElementById('messageCustodia').innerHTML = "EL SERVICIO NO RESPONDE, INTENTELO NUEVAMENTE.";
                fn_nrm_showModal('alertCustodia');
            }
        }
    };

    xmlHttpfn.open(attr.metodo, attr.nivel + attr.url, attr.async);
    xmlHttpfn.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlHttpfn.send("_=" + new Date().getTime() + "&command=" + attr.command + "&clVinTspPseudo=" + attr.vin + "&vinTspPseudo=" + attr.vinTspPseudo + "&event=" + attr.event);
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
                    siUntracking.disabled = true;
                    noUntracking.disabled = true;
                    fn_nrm_GuardarUnTracking(usr, expe, '', response);
                } else if (parseInt(response.exitoso, 10) === 0) {
                    noUntracking.checked = false;
                    siUntracking.checked = false;
                }
                document.getElementById('messageCustodia').innerHTML = response.message;
                fn_nrm_showModal('alertCustodia');
            } else {
                document.getElementById('messageCustodia').innerHTML = "EL SERVICIO NO RESPONDE, INTENTELO NUEVAMENTE.";
                fn_nrm_showModal('alertCustodia');
            }
        }
    };

    xmlHttpfn.open(attr.metodo, attr.nivel + attr.url, attr.async);
    xmlHttpfn.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlHttpfn.send("_=" + new Date().getTime() + "&command=" + attr.command + "&clVinTspPseudo=" + attr.vin + "&vinTspPseudo=" + attr.vinTspPseudo + "&event=" + attr.event);
}

siBloqueo.onchange = function () {
    if (siTracking.checked) {
        fn_nrm_IniciarBlocking('block', vin, vinTspPseudo, "blocking");
    } else if (noTracking.checked) {
        fn_nrm_showModal('alertCustodia');
        document.getElementById('messageCustodia').innerHTML = "PARA BLOQUEAR EL VEHICULO, DEBE ESTAR EN MONITOREO";
        siBloqueo.checked = false;
    }
};

siDesbloqueo.onchange = function () {
    if (siBloqueo.checked) {
        fn_nrm_IniciarBlocking('unblock', vin, vinTspPseudo, "blocking");
    } else {
        fn_nrm_showModal('alertCustodia');
        document.getElementById('messageCustodia').innerHTML = "PARA DESBLOQUEAR EL VEHICULO, DEBE ESTAR BLOQUEADO";
        siDesbloqueo.checked = false;
    }
};

siUntracking.onchange = function () {
    //SVTB
    if (siTracking.checked && siBloqueo.checked && siDesbloqueo.checked) {
            fn_nrm_IniciarTracking('tracking', 'untrack', usr, expe, vin, vinTspPseudo);
    } else if (siTracking.checked && siBloqueo.checked && noDesbloqueo.checked) {
            fn_nrm_showModal('alertCustodia');
        document.getElementById('messageCustodia').innerHTML = "PARA DEJAR DE MONITOREAR EL VEHICULO, DEBE DESBLOQUEAR EL CARRO";
        siUntracking.checked = false;
    //SVT
    }else if(siTracking.checked && noBloqueo.checked && noDesbloqueo.checked){
            fn_nrm_IniciarTracking('tracking', 'untrack', usr, expe, vin, vinTspPseudo);
    }else if (noTracking.checked && noBloqueo.checked && noDesbloqueo.checked) {
             fn_nrm_showModal('alertCustodia');
        document.getElementById('messageCustodia').innerHTML = "PARA DEJAR DE MONITOREAR EL VEHICULO, DEBE ESTAR EN MONITOREO";
            siUntracking.checked = false;
    } else if(noTracking.checked){
        fn_nrm_showModal('alertCustodia');
        document.getElementById('messageCustodia').innerHTML = "PARA DEJAR DE MONITOREAR EL VEHICULO, DEBE ESTAR EN MONITOREO";
        siUntracking.checked = false;
        }
};

siInventario.onchange = function () {
    console.dir('Si Inventario...');
    divFolioInventario.style.display = "block";
};

noInventario.onchange = function () {
    console.dir('No Inventario...');
    folioInventario.value = "";
    divFolioInventario.style.display = "none";
};

// When the user clicks on <span> (x), close the modal
if (alertaCloseCustodia !== null && alertaCloseCustodia !== undefined) {
    alertaCloseCustodia.onclick = function () {
        fn_nrm_closeModal('alertCustodia');
    };
}

// When the user clicks on <span> (x), close the modal
if (alertaCloseInfoCustodia !== null && alertaCloseInfoCustodia !== undefined) {
    alertaCloseInfoCustodia.onclick = function () {
        fn_nrm_closeModal('alertInfoCustodia');
    };
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

function fn_nrm_showModal(idModal) {
    var modal = document.getElementById(idModal);
    modal.style.display = "block";
}

function fn_nrm_closeModal(idModal) {
    var modal = document.getElementById(idModal);
    modal.style.display = "none";
}

function fn_nrm_ValidaTipoUbicacion() {
    console.dir('Cambio...');
    if (parseInt(tipoUbicacion.value, 10) === 2 || parseInt(tipoUbicacion.value, 10) === 3) {
        divNivel.style.display = "block";
    } else {
        divNivel.style.display = "none";
        nivel.value = "";
    }
}

function fn_nrm_OcultarElementos() {
    divNivel.style.display = "none";
    divFolioInventario.style.display = "none";
}

function fn_nrm_ConsultarTrackingGuardado(e, v, vTP, u) {
    vin = v;
    vinTspPseudo = vTP;
    usr = u;
    siTracking.disabled = true;
    expe = e;
    ajaxRequest({param: [parseInt(expe, 10)],
        sql: "[st_nrm_ConsultaTracking]",
        component: "json",
        nivel: "../../"}, function (data) {
        if (data !== null && data !== undefined && data[0] !== undefined) {
            console.dir(data);
            if (parseInt(data[0].trackingExitoso, 10) === 1) {
                siTracking.checked = true;
                if (fechaInicioRegistro !== null)
                    fechaInicioRegistro.value = data[0].fechaHoraTrack.replace(' ', 'T');
                if (estatusInicioServicio !== null)
                    estatusInicioServicio.value = data[0].estatusServicioTrack;
                if (velocidadInicio !== null)
                    velocidadInicio.value = data[0].velocidadTrack;
                if (estatusInicioArranque !== null) {
                    setTimeout(function () {
                        estatusInicioArranque.value = parseInt(data[0].estatusArranqueTrack, 10);
                    }, 2000);
                }
                if (nivelInicioBateria !== null)
                    nivelInicioBateria.value = data[0].nivelBateriaTrack;
                if (kilometrajeInicio !== null)
                    kilometrajeInicio.value = data[0].kilometrajeTrack;
                if (inicioTracking !== null)
                    inicioTracking.value = data[0].ubicacionVehiculoTrack;
            } else if (parseInt(data[0].trackingExitoso, 10) === 0) {
                noTracking.checked = true;
            }
        }
        siTracking.disabled = true;
        noTracking.disabled = true;
        if (fechaInicioRegistro !== null)
            fechaInicioRegistro.disabled = true;
        if (estatusInicioServicio !== null)
            estatusInicioServicio.readOnly = true;
        if (velocidadInicio !== null)
            velocidadInicio.readOnly = true;
        if (estatusInicioArranque !== null)
            estatusInicioArranque.disabled = true;
        if (nivelInicioBateria !== null)
            nivelInicioBateria.readOnly = true;
        if (kilometrajeInicio !== null)
            kilometrajeInicio.readOnly = true;
        if (inicioTracking !== null)
            inicioTracking.readOnly = true;
    });
}

function fn_nrm_ConsumeCombo(sql, id) {
    
    
    
    
    if (document.getElementById(id) !== null) {
        ajaxRequest({param: [], sql: sql, component: "combobox", nivel: "../../"}, function (data) {
            document.getElementById(id).innerHTML = '<option value="-1">Seleccione una opcion...</option>';
//        console.dir(data[0]);
            var tamanio = data.length;
//        console.dir(tamanio);
            var i;
            for (i = 0; i < tamanio; i++) {
//            console.dir(data[i].text);
                if(id === "pais"){
                    console.dir(parseInt(clPais, 10));
                    console.dir(data[i].value);
                    if(parseInt(data[i].value, 10) === parseInt(clPais, 10)){
                        document.getElementById(id).innerHTML += '<option selected value="' + data[i].value + '">' + data[i].text + '</option>';
                        fn_nrm_LlenaEntidadFederativa();
                    }
                }else{
                document.getElementById(id).innerHTML += '<option value="' + data[i].value + '">' + data[i].text + '</option>';
            }
                
            }
        });
    }
}

function fn_nrm_LlenaEntidadFederativa() {
    var codPais = document.getElementById('pais').value;
    document.getElementById('municipioAlcaldia').innerHTML = '<option value="-1">Seleccione una opcion...</option>';
    if (parseInt(codPais, 10) === 43) {
        country = 43;
        fn_nrm_ConsumeCombo('[st_CatalogoEntidadFederativa]', 'estado');
        fn_nrm_ConsumeCombo('[st_CatalogoEntidadFederativa]', 'estadoDestino');
    } else if (parseInt(codPais, 10) === 132) {
        country = 132;
        fn_nrm_ConsumeCombo('[st_nrm_EntFedPeru]', 'estado');
        fn_nrm_ConsumeCombo('[st_nrm_EntFedPeru]', 'estadoDestino');
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

function fn_nrm_LlenaMunicipioDelegacionDestino(idEstado, idAlcaldia) {
    var codPais = document.getElementById('pais').value;
    var codEnt = document.getElementById(idEstado).value;
    
    var sql = '';

    if (parseInt(codPais, 10) === 10) {
        sql = '[st_MunDelxCodEnt]';
    } else if (parseInt(codPais, 10) === 39) {
        sql = '[st_nrm_MunDelxCodEntChile]';
    }
    
    //console.dir(codEnt);
    ajaxRequest({param: [codEnt], sql: sql, component: "combobox", nivel: "../../"}, function (data) {
        //console.dir(data);
        document.getElementById(idAlcaldia).innerHTML = '<option value="-1">Seleccione una opcion...</option>';
        var tamanio = data.length;
//        console.dir(tamanio);
        var i;
        for (i = 0; i < tamanio; i++) {
//            console.dir(data[i].text);
            document.getElementById(idAlcaldia).innerHTML += '<option value="' + data[i].value + '">' + data[i].text + '</option>';
        }
    });
}

function fn_nrm_RedirectTracking(expe, vin, vinTspPseudo, pais) {
    location.href = "TrackingNRM.jsp?clExpediente=" + expe + "&clVinTspPseudo=" + vin + "&vinTspPseudo=" + vinTspPseudo + "&clPais=" + pais;
}

function fn_nrm_EliminarDiacriticos(texto) {
    console.dir(texto.normalize('NFD').replace(/[\u0300-\u036f]/g, ""));
    return texto.normalize('NFD').replace(/[\u0300-\u036f]/g, "");
}

