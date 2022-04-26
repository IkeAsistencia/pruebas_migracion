function fnLlenaAMIS(){ 
    var pstrCadena = "../../servlet/Combos.LlenaAMIS?CodigoMarca=" + document.all.TMO_NMARC.value;
    document.all.ClaveAMIS.value = '';
    document.all.ClaveAMISVTR.value = '';
    pstrCadena = pstrCadena + "&strName=ClaveAMISC";
    fnOptionxDefault('ClaveAMISC',pstrCadena);
}

function fnActualizaAMIS(){ 
    document.all.ClaveAMISVTR.value = document.all.ClaveAMIS.value;
}

function fnLlenaAMISAcumula(){ 
    var pstrCadena = "../servlet/Combos.LlenaAMIS?CodigoMarca=" + document.all.TMO_NMARC.value;
    document.all.ClaveAMIS.value = '';
    document.all.ClaveAMISVTR.value = '';
    pstrCadena = pstrCadena + "&strName=ClaveAMISC";
    fnOptionxDefault('ClaveAMISC',pstrCadena);
}

function fnLlenaTipoMotoAjax(value,IDCombo,Label,IdDiv,FnCombo,nivel){
    if (document.all.TMO_NMARC.value!=''){
        if (nivel==1){
            URL = "../servlet/Utilerias.LlenaCombosAjax?";
        }
        if (nivel==2){
            URL = "../../servlet/Utilerias.LlenaCombosAjax?";
        }
        if (nivel==3){
            URL = "../../../servlet/Utilerias.LlenaCombosAjax?";
        }
        var strConsulta = "st_GetTipoMoto '" + document.all.TMO_NMARC.value + "'";
        var Cadena = "strSQL="+ strConsulta+ "&strName=TMO_CODIA";
        Cadena += "&Opcion="+value+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
        fnLLenaInput(URL, Cadena, IdDiv);
    }
}