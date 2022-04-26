function fnLlenaAMIS(){ 
    var pstrCadena = "../../servlet/Combos.LlenaAMIS?CodigoMarca=" + document.all.CodigoMarca.value;
    document.all.ClaveAMIS.value = '';
    document.all.ClaveAMISVTR.value = '';
    pstrCadena = pstrCadena + "&strName=ClaveAMISC";
    fnOptionxDefault('ClaveAMISC',pstrCadena);
}

function fnActualizaAMIS(){ 
    document.all.ClaveAMISVTR.value = document.all.ClaveAMIS.value;
}

function fnLlenaAMISAcumula(){ 
    var pstrCadena = "../servlet/Combos.LlenaAMIS?CodigoMarca=" + document.all.CodigoMarca.value;
    document.all.ClaveAMIS.value = '';
    document.all.ClaveAMISVTR.value = '';
    pstrCadena = pstrCadena + "&strName=ClaveAMISC";
    fnOptionxDefault('ClaveAMISC',pstrCadena);
}

function fnLlenaTipoAutoAjax(value,IDCombo,Label,IdDiv,FnCombo,nivel){
    if (document.all.CodigoMarca.value!=''){
        if (nivel==1){
            URL = "../servlet/Utilerias.LlenaCombosAjax?";
        }
        if (nivel==2){
            URL = "../../servlet/Utilerias.LlenaCombosAjax?";
        }
        if (nivel==3){
            URL = "../../../servlet/Utilerias.LlenaCombosAjax?";
        }
        var strConsulta = "st_GetTipoAuto '" + document.all.CodigoMarca.value + "'";
        var Cadena = "strSQL="+ strConsulta+ "&strName=ClaveAMISC";
        Cadena += "&Opcion="+value+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
        fnLLenaInput(URL, Cadena, IdDiv);
    }
}