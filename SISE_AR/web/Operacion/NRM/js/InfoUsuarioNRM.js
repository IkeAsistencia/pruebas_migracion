var alertCloseRequest = document.getElementById('alertCloseRequest');
var alertCloseVerifyInfo = document.getElementById('alertCloseVerifyInfo');
var alertaCloseForward = document.getElementById('alertaCloseForward');
var alertCloseRequestLista = document.getElementById('alertCloseRequestLista');
var validar = "";

function fn_nrm_RedirectListaUsuarios(){
    location.href = "ListadoPreAfiliadosNRM.jsp";
}

function fn_nrm_RedirectPantallaEspejo(expe, vinTspPseudo, vin){
    location.href = "CustodiaVehiculoNRM.jsp?clExpediente=" + expe + "&vinTspPseudo=" + vinTspPseudo + "&clVinTspPseudo=" + vin + "&espejo=" + 1;
}

// When the user clicks on <span> (x), close the modal
if (alertCloseRequestLista !== null && alertCloseRequestLista !== undefined) {
    alertCloseRequestLista.onclick = function () {
        fn_nrm_closeModal('alertUserRequest');
    };
}

// When the user clicks on <span> (x), close the modal
if (alertCloseRequest !== null && alertCloseRequest !== undefined) {
    alertCloseRequest.onclick = function () {
        fn_nrm_closeModal('alertUserRequestValida');
    };
}

// When the user clicks on <span> (x), close the modal
if (alertCloseVerifyInfo !== null && alertCloseVerifyInfo !== undefined) {
    alertCloseVerifyInfo.onclick = function () {
        fn_nrm_closeModal('alertVerifyInfo');
    };
}

// When the user clicks on <span> (x), close the modal
if (alertaCloseForward !== null && alertaCloseForward !== undefined) {
    alertaCloseForward.onclick = function () {
        fn_nrm_closeModal('alertUserSettings');
        if(validar === "0"){
            fn_nrm_RedirectListaUsuarios();
        }
    };
}

function fn_nrm_CloseModalValidar(vin) {
    window.open('../NRM/InfoPreAfiliadoNRM.jsp?clTspPseudoVin=' + vin + '&validar=2', 'Validar Preguntas y Respuestas Secretas', 'resizable=no,scrollbars=no,status=yes,width=1100,height=450');
}

function fn_nrm_showModal(idModal) {
    var modal = document.getElementById(idModal);
    modal.style.display = "block";
}

function fn_nrm_closeModal(idModal) {
    var modal = document.getElementById(idModal);
    modal.style.display = "none";
}

function fn_nrm_AltaUsuario(vin) {
    location.href = 'InfoPreAfiliadoNRM.jsp?clTspPseudoVin=' + vin;
}

//function fn_nrm_GetPreguntasSecretas() {
//    ajaxRequest({param: [], sql: "[st_nrm_GetPreguntasSecretas]", component: "combobox", nivel: "../../"}, function (data) {
//        document.getElementById('pregunta1').innerHTML += '<option value="-1">Seleccione una opcion...</option>';
//        document.getElementById('pregunta2').innerHTML += '<option value="-1">Seleccione una opcion...</option>';
//        document.getElementById('confPregunta1').innerHTML += '<option value="-1">Seleccione una opcion...</option>';
//        document.getElementById('confPregunta2').innerHTML += '<option value="-1">Seleccione una opcion...</option>';
//        data.forEach(fn_nrm_BuildCombobox);
//    });
//}

function fn_nrm_SetRedBackground(id) {
    document.getElementById(id).style.background = "yellow";
}

function fn_nrm_RemoveRedBackground(id) {
    document.getElementById(id).style.background = "";
}

function fn_nrm_ForwardUserSettings(vin, vali) {
    validar = vali;
    if (fn_nrm_VerifyInformation()) {
        fn_nrm_Subscription(vin, 'svtUserSettings', vali);
    }
}

function fn_nrm_VerifyInformation() {
    var table = '<table><tr><th>Campo</th><th>Descripcion</th></tr>';
    var number = 0;
//    var pregunta1 = document.getElementById('pregunta1').value;
//    var pregunta2 = document.getElementById('pregunta2').value;
//    var confPregunta1 = document.getElementById('confPregunta1').value;
//    var confPregunta2 = document.getElementById('confPregunta2').value;
//    var respuestaSecreta1 = document.getElementById('respuestaSecreta1').value;
//    var confRespustaSecreta1 = document.getElementById('confRespustaSecreta1').value;
//    var respuestaSecreta2 = document.getElementById('respuestaSecreta2').value;
//    var confRespustaSecreta2 = document.getElementById('confRespustaSecreta2').value;
    var placas = document.getElementById('placas').value;
    var color = document.getElementById('color').value;

//    if (parseInt(pregunta1, 10) === -1) {
//        table += '<tr style="font-size: 14px;"><td>Pregunta Secreta 1</td><td>Seleccine la pregunta secreta 1</td></tr>';
//        fn_nrm_SetRedBackground('pregunta1');
//        number++;
//    } else {
//        fn_nrm_RemoveRedBackground('pregunta1');
//    }

//    if (parseInt(pregunta2, 10) === -1) {
//        table += '<tr style="font-size: 14px;"><td>Pregunta Secreta 2</td><td>Seleccine la pregunta secreta 2</td></tr>';
//        fn_nrm_SetRedBackground('pregunta2');
//        number++;
//    } else {
//        fn_nrm_RemoveRedBackground('pregunta2');
//    }

//    if (parseInt(pregunta1, 10) !== -1 && parseInt(confPregunta1, 10) === -1) {
//        table += '<tr style="font-size: 14px;"><td>Confirmar Pregunta Secreta 1</td><td>Comfirme la pregunta secreta 1</td></tr>';
//        fn_nrm_SetRedBackground('confPregunta1');
//        number++;
//    } else if (parseInt(pregunta1, 10) !== -1 && parseInt(confPregunta1, 10) !== -1 && parseInt(pregunta1, 10) === parseInt(confPregunta1, 10)) {
//        fn_nrm_RemoveRedBackground('pregunta1');
//        fn_nrm_RemoveRedBackground('confPregunta1');
//    } else {
//        table += '<tr style="font-size: 14px;"><td>Pregunta Secreta 1 y Confirmar Pregunta Secreta 1</td><td>Las preguntas deben coincidir</td></tr>';
//        fn_nrm_SetRedBackground('pregunta1');
//        fn_nrm_SetRedBackground('confPregunta1');
//        number++;
//    }

//    if (parseInt(pregunta2, 10) !== -1 && parseInt(confPregunta2, 10) === -1) {
//        table += '<tr style="font-size: 14px;"><td>Confirmar Pregunta Secreta 2</td><td>Comfirme la pregunta secreta 2</td></tr>';
//        fn_nrm_SetRedBackground('confPregunta2');
//        number++;
//    } else if (parseInt(pregunta2, 10) !== -1 && parseInt(confPregunta2, 10) !== -1 && parseInt(pregunta2, 10) === parseInt(confPregunta2, 10)) {
//        fn_nrm_RemoveRedBackground('pregunta2');
//        fn_nrm_RemoveRedBackground('confPregunta2');
//    } else {
//        table += '<tr style="font-size: 14px;"><td>Pregunta Secreta 2 y Confirmar Pregunta Secreta 2</td><td>Las preguntas deben coincidir</td></tr>';
//        fn_nrm_SetRedBackground('pregunta2');
//        fn_nrm_SetRedBackground('confPregunta2');
//        number++;
//    }

//    if (respuestaSecreta1 === "" || respuestaSecreta1 === " ") {
//        table += '<tr style="font-size: 14px;" ><td>Respuesta Secreta 1</td><td>Escriba la respuesta secreta 1</td></tr>';
//        fn_nrm_SetRedBackground('respuestaSecreta1');
//        number++;
//    } else if (respuestaSecreta1 === confRespustaSecreta1) {
//        fn_nrm_RemoveRedBackground('respuestaSecreta1');
//        fn_nrm_RemoveRedBackground('confRespustaSecreta1');
//    } else {
//        table += '<tr style="font-size: 14px;"><td>Respuesta Secreta 1 y Confirmar Respuesta Secreta 1</td><td>Las respuestas deben coincidir</td></tr>';
//        fn_nrm_SetRedBackground('respuestaSecreta1');
//        fn_nrm_SetRedBackground('confRespustaSecreta1');
//        number++;
//    }

//    if (respuestaSecreta2 === "" || respuestaSecreta2 === " ") {
//        table += '<tr style="font-size: 14px;"><td>Respuesta Secreta 2</td><td>Escriba la respuesta secreta 2</td></tr>';
//        fn_nrm_SetRedBackground('respuestaSecreta2');
//        number++;
//    } else if (respuestaSecreta2 === confRespustaSecreta2) {
//        fn_nrm_RemoveRedBackground('respuestaSecreta2');
//        fn_nrm_RemoveRedBackground('confRespustaSecreta2');
//    } else {
//        table += '<tr style="font-size: 14px;"><td>Respuesta Secreta 2 y Confirmar Respuesta Secreta 2</td><td>Las respuestas deben coincidir</td></tr>';
//        fn_nrm_SetRedBackground('respuestaSecreta2');
//        fn_nrm_SetRedBackground('confRespustaSecreta2');
//        number++;
//    }

    if (placas === "" || placas === " ") {
        table += '<tr style="font-size: 14px;"><td>Placas</td><td>Escriba las placas del vehiculo</td></tr>';
        fn_nrm_SetRedBackground('placas');
        number++;
    } else {
        fn_nrm_RemoveRedBackground('placas');
    }

    if (color === "" || color === " ") {
        table += '<tr style="font-size: 14px;"><td>Color</td><td>Escriba el color del vehiculo</td></tr>';
        fn_nrm_SetRedBackground('color');
        number++;
    } else {
        fn_nrm_RemoveRedBackground('color');
    }

    if (number > 0) {
        table += '</table>';
        document.getElementById('tablaFaltaInfo').innerHTML = table;
        fn_nrm_showModal('alertVerifyInfo');
        return false;
    } else {
        return true;
    }
}

//function fn_nrm_BuildCombobox(item, index) {
//    document.getElementById('pregunta1').innerHTML += '<option value="' + index + '">' + item.text + '</option>';
//    document.getElementById('pregunta2').innerHTML += '<option value="' + index + '">' + item.text + '</option>';
//    document.getElementById('confPregunta1').innerHTML += '<option value="' + index + '">' + item.text + '</option>';
//    document.getElementById('confPregunta2').innerHTML += '<option value="' + index + '">' + item.text + '</option>';
//}

function fn_nrm_Subscription(vin, typeEvent, vali) {
    validar = vali;
    fn_nrm_showModal('process');
    id = vin;
    event = typeEvent;
    ajaxRequest({param: ["'" + parseInt(vin, 10) + "','" + typeEvent + "'"], sql: "[st_nrm_Subscription]", component: "String", nivel: "../../"}, function (data) {
        console.dir(data);
        console.dir(fn_stringToJson(data));
        var json = fn_stringToJson(data);
        if (typeEvent === 'svtUserSettings') {
            json.vehicle.plateNumber = document.getElementById('placas').value;
            json.vehicle.color = document.getElementById('color').value;
            
//            json.userIdentityChallenge.secretQuestion1 = document.getElementById('pregunta1').options[document.getElementById('pregunta1').selectedIndex].text;
//            json.userIdentityChallenge.secretAnswer1 = document.getElementById('respuestaSecreta1').value;
//            json.userIdentityChallenge.secretQuestion2 = document.getElementById('pregunta2').options[document.getElementById('pregunta2').selectedIndex].text;
//            json.userIdentityChallenge.secretAnswer2 = document.getElementById('respuestaSecreta2').value;
            
            json.userIdentityChallenge.secretQuestion1 = "question1";
            json.userIdentityChallenge.secretAnswer1 = "answer1";
            json.userIdentityChallenge.secretQuestion2 = "question2";
            json.userIdentityChallenge.secretAnswer2 = "answer2";
            console.dir(fn_jsonToString(json));
            fn_nrm_ConsumeApiService('forwardUserSettings', fn_jsonToString(json));
        } else if (typeEvent === 'USER_INFO_REQUEST') {
            fn_nrm_ConsumeApiService('userRequest', data);
        } else {
            fn_nrm_ConsumeApiService('userRequest', data);
        }
    });
}

function fn_nrm_ConsumeApiService(typeEvent, json) {
    var event = "";
    if (typeEvent === "forwardUserSettings") {
        event = "forward";
    } else if (typeEvent === "userRequest") {
        event = "request";
    }

    var attr = {
        url: "servlet/com.ike.ws.nrm.SubscriptionProcess",
        json: json,
        event: event,
        vin: id,
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
                if (event === 'forward') {
                    document.getElementById('messageForward').innerHTML = xmlHttpfn.responseText;
                    fn_nrm_showModal('alertUserSettings');
                    fn_nrm_ActualizaAfiliado(id);
                } else if (event === 'request') {
                    if (validar === "0") {
                        console.dir('Sincronizando...');
                        console.dir(fn_stringToJson(xmlHttpfn.responseText));
                        var response = fn_stringToJson(xmlHttpfn.responseText);
                        document.getElementById('messageRequest').innerHTML = response.message;
                        fn_nrm_showModal('alertUserRequest');
                        document.getElementById(id).disabled = "true";
                    } else if (validar === "1") {
                        console.dir('Sincronizando...');
                        console.dir(fn_stringToJson(xmlHttpfn.responseText));
                        var response = fn_stringToJson(xmlHttpfn.responseText);
                        if(response.exitoso === 0){
                            document.getElementById('messageRequestValida').innerHTML = response.message;
                            fn_nrm_showModal('alertUserRequestValida');
                        }else if(response.exitoso === 1){
                            document.getElementById('messageRequestValida').innerHTML = response.message;
                            fn_nrm_showModal('alertUserRequestValida');
                            document.getElementById('titularServicio').value = response.name;
                            document.getElementById('telefono').value = response.phoneNumber;
                            document.getElementById('placas').value = response.vehiclePlateNumber;
                            document.getElementById('color').value = response.vehicleColor;
                            document.getElementById('marca').value = response.vechicleBrand;
                            document.getElementById('modelo').value = response.modelName;
                        }

                    }
                } else {
                    document.getElementById('messageRequest').innerHTML = xmlHttpfn.responseText;
                    fn_nrm_showModal('alertUserRequest');
                    console.dir(xmlHttpfn.responseText);
                }
            } else {
                document.getElementById('messageForward').innerHTML = xmlHttpfn.responseText;
                fn_nrm_showModal('alertUserSettings');
//                console.dir('OCURRIO UN ERROR AL CONSUMIR EL SERVICIO, INTENTELO NUEVAMENTE');
            }
        }
    };

    xmlHttpfn.open(attr.metodo, attr.nivel + attr.url, attr.async);
    xmlHttpfn.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlHttpfn.send("_=" + new Date().getTime() + "&event=" + attr.event + "&json=" + attr.json + "&vin=" + attr.vin);
}

function fn_nrm_ActualizaAfiliado(clVin){
    var nombre = document.getElementById('titularServicio').value;
    var telefono = document.getElementById('telefono').value;
    var placas = document.getElementById('placas').value;
    var color = document.getElementById('color').value;
    var modelo = document.getElementById('modelo').value;
    var marca = document.getElementById('marca').value;
    
    ajaxRequest({param: ["'" + parseInt(clVin, 10) + "','" + nombre + "','" + telefono + "','" + placas + "','" + color + "','" + marca + "','" + modelo + "'"], 
        sql: "[st_nrm_ActualizaAfiliado]", 
        component: "String", 
        nivel: "../../"}, function (data) {
        console.dir(data);
        if(data !== null && data !== undefined){
            if(data.trim() === 'UPDATED'){
                document.getElementById('messageForward').innerHTML += '<br>LA INFORMACION DEL AFILIADO FUE ACTUALIZADA';
            }else{
                document.getElementById('messageForward').innerHTML += '<br>LA INFORMACION DEL AFILIADO NO FUE ACTUALIZADA, INTENTELO NUEVAMENTE';
            }
        }
    });
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



