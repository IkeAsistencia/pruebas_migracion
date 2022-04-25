	function fnLlenaEstatusProv(){
            if (document.all.clProveedor1.value != ''){
		var strConsulta = "sp_GetEstatusOp " + document.all.clExpediente1.value + "," + document.all.clProveedor1.value;
		var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
		pstrCadena = pstrCadena + "&strName=clEstatus1C";		
		fnOptionxDefault('clEstatus1C',pstrCadena);
            }else{
                var strConsulta = "sp_GetEstatusOp " + document.all.clExpediente1.value + ",''"
		var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
		pstrCadena = pstrCadena + "&strName=clEstatus1C";		
		fnOptionxDefault('clEstatus1C',pstrCadena);
            }
	}
