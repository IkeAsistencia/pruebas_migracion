function fnLlenaPaginas(){
    var strConsulta = "sp_GetPaginas " + document.all.clGpoUsr.value;
    var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
    pstrCadena = pstrCadena + "&strName=clPaginaWebC";
    fnOptionxDefault('clPaginaWebC',pstrCadena);
}

function fnLlenaSubServiciosPaq(){
    var strConsulta = "sp_GetSubServiciosPaq " + document.all.clPaquete.value  + "," + document.all.clServicio.value;
    var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
    pstrCadena = pstrCadena + "&strName=clSubServicioC";
    fnOptionxDefault('clSubServicioC',pstrCadena);
}

function fnLlenaSubServiciosCob(){
    var strConsulta = "sp_GetSubServiciosCob " + document.all.clCobertura.value  + "," + document.all.clServicio.value;
    var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
    pstrCadena = pstrCadena + "&strName=clSubServicioC";
    fnOptionxDefault('clSubServicioC',pstrCadena);
}

/*
function fnLlenaSubServiciosCobMix(){
    var strConsulta = "st_LlenaSubServiciosCobMix " + document.all.clCobertura.value  + "," + document.all.clServicio.value;
    var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
    pstrCadena = pstrCadena + "&strName=clSubServicioC";
    fnOptionxDefault('clSubServicioC',pstrCadena);
}
*/
function fnLlenaSubServicios(){
    var pstrCadena = "../servlet/Combos.LlenaSubServicio?clServicio=" + document.all.clServicio.value;
    document.all.clSubServicio.value = '';
    pstrCadena = pstrCadena + "&strName=clSubServicioC";
    fnOptionxDefault('clSubServicioC',pstrCadena);
}

function fnLlenaSubServiciosExp(){
    var strConsulta = "sp_GetSubServicios  " + document.all.clServicio.value;
    var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
    pstrCadena = pstrCadena + "&strName=clSubServicioC";
    fnOptionxDefault('clSubServicioC',pstrCadena);
}

//function fnLlenaSubServiciosReferencias(){
//    var pstrCadena = "../servlet/Combos.LlenaSubServicio?clServicio=" + document.all.clServicio.value;
//    document.all.clSubServicio.value = '';
//    pstrCadena = pstrCadena + "&strName=clSubServicioC";
//    fnOptionxDefault('clSubServicioC',pstrCadena);
//}

function fnLlenaSubServiciosReferencias(){
    var strConsulta = "sp_GetSubServiciosReferencias " + document.all.clServicio.value;
    var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
    pstrCadena = pstrCadena + "&strName=clSubServicioC";
    fnOptionxDefault('clSubServicioC',pstrCadena);
}

function fnHabilitaLugarEvento(){
    var strConsulta = "st_ObtenLugarEvento " + document.all.clAreaOperativa.value;
    var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
    pstrCadena = pstrCadena + "&strName=clLugarEventoC";
    fnOptionxDefault('clLugarEventoC',pstrCadena);
}
