var automatico = document.getElementById('automatico');
var manual = document.getElementById('manual');
var nombreVin = document.getElementById('nombreVin');
var correoVin = document.getElementById('correoVin');
var nombreCorreoVin = document.getElementById('nombreCorreoVin');
var alertaCloseControlPanel = document.getElementById('alertaCloseControlPanel');

function fn_nrm_ConsultarConfiguracion(origen, nivel) {
    ajaxRequest({param: [],
        sql: "[st_nrm_ConsultaControlPanel]",
        component: "json",
        nivel: nivel}, function (data) {
        console.dir(data);
        if (origen === 'panel') {
            if (data !== null && data !== undefined) {
                if (data[0] !== undefined && data[0].clControlPanel === '1') {
                    if (data[0].tipoFlujo === 1) {
                        automatico.checked = true;
                    } else if (data[0].tipoFlujo === 2) {
                        manual.checked = true;
                    }
                }

                if (data[1] !== undefined && data[1].clControlPanel === '2') {
                    if (data[1].tipoFlujo === 3) {
                        nombreVin.checked = true;
                    } else if (data[1].tipoFlujo === 4) {
                        correoVin.checked = true;
                    } else if (data[1].tipoFlujo === 5) {
                        nombreCorreoVin.checked = true;
                    }
                }
            }
        } else if (origen === 'afiliado') {
            if (data !== null && data !== undefined) {
                if (data[1] !== undefined && data[1].clControlPanel === '2') {
                    if (data[1].tipoFlujo === 3) {
                        document.getElementById('NU').disabled = false;
                        document.getElementById('Correo').disabled = true;
                    } else if (data[1].tipoFlujo === 4) {
                        document.getElementById('NU').disabled = true;
                        document.getElementById('Correo').disabled = false;
                    } else if (data[1].tipoFlujo === 5) {
                        document.getElementById('NU').disabled = false;
                        document.getElementById('Correo').disabled = false;
                    }

                  
                    document.getElementById('Placas').disabled = true;
                    document.getElementById('DNI').disabled = true;
                    document.getElementById('Cuenta').disabled = true;
                }
            }
        }
    });
}

function fn_nrm_GuardarConfiguracion() {
    fn_nrm_showModal('process');
    var subFlujo;
    var dsSubFlujo;
    var busqFlujo;
    var dsBusqFlujo;

    if (automatico.checked) {
        subFlujo = 1;
        dsSubFlujo = 'AUTOMATICO';
    } else if (manual.checked) {
        subFlujo = 2;
        dsSubFlujo = 'MANUAL';
    }

    if (nombreVin.checked) {
        busqFlujo = 3;
        dsBusqFlujo = 'NOMBRE Y VIN';
    } else if (correoVin.checked) {
        busqFlujo = 4;
        dsBusqFlujo = 'CORREO Y VIN';
    } else if (nombreCorreoVin.checked) {
        busqFlujo = 5;
        dsBusqFlujo = 'NOMBRE, CORREO Y VIN';
    }
    console.dir("'" + parseInt(subFlujo, 10) + "','" + dsSubFlujo + "','" + parseInt(busqFlujo, 10) + "','" + dsBusqFlujo + "'");
    ajaxRequest({param: ["'" + parseInt(subFlujo, 10) + "','" + dsSubFlujo + "','" + parseInt(busqFlujo, 10) + "','" + dsBusqFlujo + "'"],
        sql: "[st_nrm_GuardaControlPanel]",
        component: "String",
        nivel: "../../"}, function (data) {
        console.dir(data);
        if (data.trim() === "UPDATED") {
            document.getElementById('messageControlPanel').innerHTML = "<br>LA CONFIGURACION FUE ACTUALIZADA CORRECTAMENTE.";
        } else {
            document.getElementById('messageControlPanel').innerHTML = "<br>OCURRIO UN ERROR AL GUARDAR LA CONFIGURACION.";
        }
        fn_nrm_showModal('alertControlPanel');
        fn_nrm_closeModal('process');
    });
}

function fn_nrm_showModal(idModal) {
    var modal = document.getElementById(idModal);
    modal.style.display = "block";
}

function fn_nrm_closeModal(idModal) {
    var modal = document.getElementById(idModal);
    modal.style.display = "none";
}

if (alertaCloseControlPanel !== null && alertaCloseControlPanel !== undefined) {
    alertaCloseControlPanel.onclick = function () {
        fn_nrm_closeModal('alertControlPanel');
    };
}

if(document.getElementById('clGrupoCuentaC') !== null && document.getElementById('clGrupoCuentaC') !== undefined){
    document.getElementById('clGrupoCuentaC').onchange = function () {
    console.dir('Cambio el grupo de cuenta.');
    console.dir(document.getElementById('clGrupoCuentaC').value);
    if (parseInt(document.getElementById('clGrupoCuentaC').value, 10) === 89) {
        fn_nrm_ConsultarConfiguracion('afiliado', "../");
       
   
    } else {
       
        document.getElementById('NU').disabled = false;
        document.getElementById('Correo').disabled = true;
        document.getElementById('Placas').disabled = false;
        
        document.getElementById('DNI').disabled = false;
        document.getElementById('Cuenta').disabled = false;
    }
};
}



