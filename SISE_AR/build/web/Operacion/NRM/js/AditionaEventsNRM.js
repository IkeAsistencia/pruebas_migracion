function fn_nrm_ProcessDecrypt(vinTspPseudo){
    fn_nrm_showModal('process');
    var attr = {
        url: "servlet/com.ike.ws.nrm.AditionalProcess",
        vinTspPseudo: vinTspPseudo,
        event: "decrypt",
        contentType: "text/html; charset=utf-8",
        metodo: "POST",
        async: true,
        nivel: '../'
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
                document.getElementById(vinTspPseudo).innerHTML = xmlHttpfn.responseText;
                fn_nrm_closeModal('process');
            } else {
                
            }
        }
    };

    xmlHttpfn.open(attr.metodo, attr.nivel + attr.url, attr.async);
    xmlHttpfn.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlHttpfn.send("_=" + new Date().getTime() + "&vinTspPseudo=" + attr.vinTspPseudo + "&event=" + attr.event);
}

function fn_nrm_showModal(idModal) {
    var modal = document.getElementById(idModal);
    modal.style.display = "block";
}

function fn_nrm_closeModal(idModal) {
    var modal = document.getElementById(idModal);
    modal.style.display = "none";
}


