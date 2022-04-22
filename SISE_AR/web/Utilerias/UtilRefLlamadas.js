 function fnLlenaSubCategoria(){  
		var strConsulta = "sp_GetSubCategoria '" + document.all.clCategoria.value + "'";
		var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                document.all.clSubCategoria.value = '';
		pstrCadena = pstrCadena + "&strName=clSubCategoriaC";		
		fnOptionxDefault('clSubCategoriaC',pstrCadena);
	}