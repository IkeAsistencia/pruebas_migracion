// Get the modal
var modal = document.getElementById('myModal');

// Get the <span> element that closes the modal
var span = document.getElementById('alerta-close');

setInterval(fn_nrm_loadSubscriptions, 90000);

function fn_nrm_loadSubscriptions(){
//    console.dir('Alerta cargada...');
    ajaxRequest({param:[], sql:"[st_nrm_Alerta]", component:"json", nivel:""}, function(data){
//        console.dir(data);
        
        if(parseInt(data[0].pairing, 10) === 0 && parseInt(data[0].userRequest, 10) === 0 && parseInt(data[0].userResponse, 10) === 0 &&  parseInt(data[0].userSettings, 10) === 0){
        }else if(parseInt(data[0].tipoFlujo) === 2){
            document.getElementById('pairing').innerHTML = data[0].pairing;
            document.getElementById('userRequest').innerHTML = data[0].userRequest;
            document.getElementById('userResponse').innerHTML = data[0].userResponse;
            document.getElementById('userSettings').innerHTML = data[0].userSettings;
            document.getElementById('total').innerHTML = parseInt(data[0].pairing, 10) + parseInt(data[0].userRequest, 10) + parseInt(data[0].userResponse, 10) + parseInt(data[0].userSettings, 10);
            top.document.all.rightPO.rows = "*, 0, 0";
            modal.style.display = "block";
        }
    });

}

function fn_nrm_redirectListaPreafilidos(){
    location.href = "Operacion/NRM/ListadoPreAfiliadosNRM.jsp";
    setInterval(fn_nrm_loadSubscriptions, 10000);
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
  top.document.all.rightPO.rows = "0, 0, *";
  modal.style.display = "none";
};




