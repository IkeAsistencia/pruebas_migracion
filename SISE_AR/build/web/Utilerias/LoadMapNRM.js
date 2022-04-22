var G_RBrowser = "";
var G_EURI = false; //Si es true habilita encodeURI();
var dm = 0;
var NoGPW = 0;
var msgNoGPW = '';

function submitData(URLS, PRS) {
    var payload = JSON.parse(PRS);
    var iframe = document.getElementById('urlmT');

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
                iframe.contentWindow.document.open();
                iframe.contentWindow.document.write(xmlHttpfn.responseText);
            } else {
                console.dir('Error al consumir el mapa.');
            }
        }
    };

    xmlHttpfn.open("POST", URLS);
    xmlHttpfn.setRequestHeader('Content-type', 'application/json');
    xmlHttpfn.send(JSON.stringify(payload));
}

// == [Funcion para mostrar y cargar el MapaTracking] ==================================================================================== --
function fn_LoadMapTrack(URL, PRS) {
    var objFrame = document.getElementById("urlmT");
    var iframeValue = objFrame.getAttribute("value");
    var PRM = "", URLS = "";
    rep = '\"';
    var iframeWin = document.getElementById("urlmT").contentWindow;
    var map = document.getElementById('mModal');
    PRM = PRS;
    URLS = URL;
    PRM = PRM.replace(/'/g, rep);
    objFrame.src = "";
    // == [Se valida que se encuentre cargado por el completo el Mapa Vacio antes de inyectar parametros] ======================== --
    if (iframeValue === "0") {
        // == [Se muestra el MAPA] =================================================================================================== --
        objFrame.setAttribute("value", "1");
        map.style.display = 'block';
        submitData(URLS, PRM);
        top.document.all.rightPO.rows = "0,0,*";

    } else {
        objFrame.setAttribute("value", "1");
        map.style.display = 'block';
        submitData(URLS, PRM);
        top.document.all.rightPO.rows = "0,0,*";
    }

    // == [Evento para ocultar el mapa] ============================================================================================= --
    map.onclick = function () {
        objFrame = document.getElementById("urlmT");
        iframeValue = objFrame.getAttribute("value");
        if (iframeValue === "1") {
            map.style.display = 'none';
            top.document.all.rightPO.rows = "0,80,*";
            objFrame.setAttribute("value", "0");
        }
    }

    return false;
}

// == [Funcion para mostrar y cargar el MapaUnico] ==================================================================================== --
function fn_LoadMapUnico(URL, PRS, VPR, CPW, CNTX) {

    var objFrame = document.getElementById("urlmT");
    var iframeSrc = objFrame.getAttribute("src");
    var iframeValue = objFrame.getAttribute("value");
    var PRM = "", VP = "", SPR = "", GPR = "";
    var iframeWin = document.getElementById("urlmT").contentWindow;
    var map = document.getElementById('mModal');
    var urlcorta, urlcop = URL;
    // == [Se inyecta la URL del Mapa solo 1 vez al dar click en el boton de mapa] =========================================== --
    if (iframeSrc !== "") {
        urlcorta = urlcop.substring(0, 63);
        if (iframeSrc.substring(0, 63) !== urlcorta) {
            objFrame.src = URL;
        }
    } else {
        objFrame.src = URL;
    }

    // == [Se muestra el MAPA] =================================================================================================== --
    map.style.display = 'block';

    // == [Evento para ocultar el mapa] ============================================================================================= --
    map.onclick = function () {
        objFrame = document.getElementById("urlmT");
        iframeValue = objFrame.getAttribute("value");
        if (iframeValue === "1") {
            $('#mModal').fadeOut(1000);
            fn_EST('st_S2_GetUbicacionunica', 'clExpediente,S|' + CPW + ',V', 'EF:1;PT:S;');
        }
    };
    return false;
}


// == [Funcion para mostrar y cargar el Mapa] ==================================================================================== --
function fn_LoadMap(URL, PRS, VPR, CPW, CNTX, EXPE) {

    var objFrame = document.getElementById("urlmT");
    var iframeSrc = objFrame.getAttribute("src");
    var iframeValue = objFrame.getAttribute("value");
    var PRM = "", VP = "", SPR = "", GPR = "";
    var iframeWin = document.getElementById("urlmT").contentWindow;
    var map = document.getElementById('mModal');

    // == [Se inyecta la URL del Mapa solo 1 vez al dar click en el boton de mapa] =========================================== --
    if (iframeSrc === "") {
        objFrame.src = URL;
        objFrame.setAttribute("value", "1");
    }

    // == [Se inyenctan los parametros del expediente para el punteo] ======================================================== --
    if (PRS !== '') {

        PRS = PRS.split("|");

        VPR = VPR.split("|");

        for (var i = 0; i < PRS.length; i++) {

            VP = VPR[i].split(",");

            if (VP.length > 1) {

                if (VP[1].toUpperCase() === 'V') {
                    PRM = PRM + PRS[i] + "=" + VP[0].trim() + "&";
                }
            } else {

                if (isNaN(VP[0])) {
                    PRM = PRM + PRS[i] + "=" + document.getElementById(VP[0]).value + "&";
                } else {
                    PRM = PRM + PRS[i] + "=" + document.getElementById(VP[0]).value + "&";
                }
            }
        }
        PRM = PRM.replace(/ /gi, '%20');
        PRM = PRM.replace('%20', '');
        PRM = CNTX + PRM;
    }


    // == [Se valida que se encuentre cargado por el completo el Mapa Vacio antes de inyectar parametros] ======================== --
    if (iframeValue === "0") {
        if (navigator.userAgent.indexOf("MSIE") > -1 && !window.opera) {
            objFrame.onreadystatechange = function () {
                if (objFrame.readyState === "complete") {
                    setTimeout(function () {
                        objFrame.setAttribute("value", "1");
                        iframeWin.postMessage(PRM, "*");
                    }, 4000);
                }
            };
        } else {
            objFrame.onload = function () {
//                $('#carga').show();
                setTimeout(function () {
                    objFrame.setAttribute("value", "1");
                    iframeWin.postMessage(PRM, "*");
                }, 4000);
            };
        }
    } else {
        iframeWin.postMessage(PRM, "*");
        objFrame.onload = function () {
            iframeWin.postMessage(PRM, "*");
//            $('#carga').hide();
        };
    }

    // == [Se muestra el MAPA] =================================================================================================== --
    map.style.display = 'block';
    top.document.all.rightPO.rows = "0,0,*";

    // == [Evento para ocultar el mapa] ============================================================================================= --
    map.onclick = function () {
        objFrame = document.getElementById("urlmT");
        iframeValue = objFrame.getAttribute("value");
        if (iframeValue === "1") {
            document.getElementById('mModal').style.display = 'none';
            top.document.all.rightPO.rows = "0,80,*";
            fn_nrm_GetInfoUbicacion(EXPE, CPW);
        } else {
            document.getElementById('mModal').style.display = 'none';
            top.document.all.rightPO.rows = "0,80,*";
            fn_nrm_GetInfoUbicacion(EXPE, CPW);
        }
    };

    return false;
}

function fn_nrm_CreateJsonTracking(expe) {
    //Liga para DEV
    var urlMapTrack = 'https://siamdev.ikeasistencia.com/map_service_DEV/api/tracking/map';

    //Liga para QA
//    var urlMapTrack = 'https://siamdev.ikeasistencia.com/map_service/api/tracking/map';
    
    ajaxRequest({param: ["'" + parseInt(expe, 10) + "'"], sql: "[st_nrm_Json_TrackingMP]", component: "String", nivel: "../../"}, function (data) {
        console.dir(data);
        fn_LoadMapTrack(urlMapTrack, data);
    });
}

function fn_nrm_GetInfoUbicacion(expe, cpw) {
    console.dir(expe);
    ajaxRequest({param: ["'" + parseInt(expe, 10) + "'"], sql: "[st_NRM_GetUbicacion]", component: "String", nivel: "../../"}, function (data) {
        console.dir(data);
        var info = data;
        console.dir(info);
        fn_nrm_Recorre(cpw, info);
    });
}

function fn_nrm_Recorre(cpw, info) {
    document.getElementById('municipioAlcaldia').value = '-1';
    var DCW = cpw.split("|");
    var DGI = info.split("|");

    for (var i = 0; i < DCW.length; i++) {
        VP = DGI[i].split(",");
        if (VP[0] === DCW[i]) {
            if (VP[0] === 'municipioAlcaldia') {
                var alcaldia = VP[1];
                setTimeout(function () {
                    fn_nrm_LlenaMunicipioDelegacion();
                    fn_nrm_LoadAlcaldia(alcaldia);
                }, 2000);

            } else {
                document.getElementById(DCW[i]).value = VP[1];
            }
        }
    }
}

function fn_nrm_LoadAlcaldia(alcaldia) {
    setTimeout(function () {
        document.getElementById('municipioAlcaldia').value = '-1';
        document.getElementById('municipioAlcaldia').value = alcaldia.trim();
    }, 3000);
}
