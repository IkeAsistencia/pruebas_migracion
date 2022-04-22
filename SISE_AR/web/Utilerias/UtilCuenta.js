function fnLlenaCuenta(){
        //alert(document.all.clGrupoCuenta.value);
        var strConsulta = "sp_LlenaCuenta " + document.all.clGrupoCuenta.value;
        //alert(strConsulta);
        var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
        pstrCadena = pstrCadena + "&strName=clCuentaC";		
        fnOptionxDefault('clCuentaC',pstrCadena);
}
