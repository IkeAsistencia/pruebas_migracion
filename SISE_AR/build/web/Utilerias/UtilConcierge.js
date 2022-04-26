
	function fnLlenaSubCategorias(){  
		var pstrCadena = "../servlet/Combos.LlenaSubCategorias?clCategoria=" + document.all.clCategoria.value;
                document.all.clSubCategoria.value = '';
		pstrCadena = pstrCadena + "&strName=clSubCategoriaC";		
		fnOptionxDefault('clSubCategoriaC',pstrCadena);
	}

	function fnLlenaZonasCS(){  
		var pstrCadena = "../servlet/Combos.LlenaZonasCS?clCiudad=" + document.all.clCiudad.value;
                document.all.clZona.value = '';
		pstrCadena = pstrCadena + "&strName=clZonaC";		
		fnOptionxDefault('clZonaC',pstrCadena);
	}

	function fnLlenaCiudadesCS(){ 
		var pstrCadena = "../servlet/Combos.LlenaCiudad?clPais=" + document.all.clPais.value;
                document.all.clCiudad.value = '';
		pstrCadena = pstrCadena + "&strName=clCiudadC";		
		fnOptionxDefault('clCiudadC',pstrCadena);
                /*
               if (document.all.clPaisC.value != '115'){
                    document.all.CodEnt.disabled = true;
                    document.all.CodEntC.disabled=true;
                    document.all.CodMD.disabled = true;
                    document.all.CodMDC.disabled=true;
                }else{
                    document.all.CodEnt.disabled = false;
                    document.all.CodEntC.disabled=false;
                }
                */
        }

        function fnDeshabCiudad(){
        /*
           if (document.all.clPaisC.value = '115'){
                    document.all.clCiudad.disabled=true;
                    document.all.clCiudadC.disabled=true;
           }
        */
        }