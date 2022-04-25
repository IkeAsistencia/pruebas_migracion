	function fnLlenaSubEspecialidad(){
		var strConsulta = "sp_GetSubEspecialidad " + document.all.clEspecialidad.value;
		var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
		pstrCadena = pstrCadena + "&strName=clSubEspecialidadC";		
		fnOptionxDefault('clSubEspecialidadC',pstrCadena);
	}

	function fnLlenaEspecialidad(){
		var strConsulta = "sp_GetEspecialidad " + document.all.clServicioMedico.value;
		var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
		pstrCadena = pstrCadena + "&strName=clEspecialidadC";		
		fnOptionxDefault('clEspecialidadC',pstrCadena);
	}
  
           function fnLlenaSubEspecialidadH(){
		var strConsulta = "sp_GetSubEspecialidadH " + document.all.clEspecialidadH.value;                
		var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
		pstrCadena = pstrCadena + "&strName=clSubEspecialidadHC";		
		fnOptionxDefault('clSubEspecialidadHC',pstrCadena);
	}