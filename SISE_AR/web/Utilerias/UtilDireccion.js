function fnLlenaCiudades(){ 
    var pstrCadena = "../../servlet/Combos.LlenaCiudad?clPais=" + document.all.clPais.value;
    document.all.clCiudad.value = '';
    pstrCadena = pstrCadena + "&strName=clCiudadC";
    fnOptionxDefault('clCiudadC',pstrCadena);
}

function fnLlenaCiudResiden(){ 
    var pstrCadena = "../../servlet/Combos.LlenaCiudad?clPais=" + document.all.clPaisResid.value;
    document.all.clCiudadResid.value = '';
    pstrCadena = pstrCadena + "&strName=clCiudadResidC";
    fnOptionxDefault('clCiudadResidC',pstrCadena);
}

function fnLlenaMunicipiosExp(){  
    var pstrCadena = "../servlet/Combos.LlenaMD?CodEnt=" + document.all.CodEnt.value;
    document.all.CodMD.value = '';
    pstrCadena = pstrCadena + "&strName=CodMDC";
    fnOptionxDefault('CodMDC',pstrCadena);
    document.all.clPais.value = '10';
    document.all.clPaisC.value = '10';
}

function fnLlenaMunicipios(){  
    var pstrCadena = "../servlet/Combos.LlenaMD?CodEnt=" + document.all.CodEnt.value;
    document.all.CodMD.value = '';
    pstrCadena = pstrCadena + "&strName=CodMDC";
    fnOptionxDefault('CodMDC',pstrCadena);
}

function fnLlenaMunicipios2(){  
    var pstrCadena = "../servlet/Combos.LlenaMD?CodEnt=" + document.all.CodEnt2.value;
    document.all.CodMD2.value = '';
    pstrCadena = pstrCadena + "&strName=CodMD2C";
    fnOptionxDefault('CodMD2C',pstrCadena);
}

function fnLlenaMunicipiosCS(){  
    var pstrCadena = "../../servlet/Combos.LlenaMD?CodEnt=" + document.all.CodEnt.value;
    document.all.CodMD.value = '';
    pstrCadena = pstrCadena + "&strName=CodMDC";
    fnOptionxDefault('CodMDC',pstrCadena);
}

function fnLlenaMunicipiosRGMMH(){  
    var pstrCadena = "../../servlet/Combos.LlenaMD?CodEnt=" + document.all.CodEntH.value;
    document.all.CodMDH.value = '';
    pstrCadena = pstrCadena + "&strName=CodMDHC";
    fnOptionxDefault('CodMDHC',pstrCadena);
}

function fnLlenaMunicipiosRGMMP(){  
    var pstrCadena = "../../servlet/Combos.LlenaMD?CodEnt=" + document.all.CodEntP.value;
    document.all.CodMDP.value = '';
    pstrCadena = pstrCadena + "&strName=CodMDPC";
    fnOptionxDefault('CodMDPC',pstrCadena);
}

function fnLlenaMunicipiosU(){  
    var pstrCadena = "../../servlet/Combos.LlenaMD?CodEnt=" + document.all.CodEntU.value;
    document.all.CodMDU.value = '';
    pstrCadena = pstrCadena + "&strName=CodMDUC";
    fnOptionxDefault('CodMDUC',pstrCadena);
}

function fnLlenaMunicipiosF(){  
    var pstrCadena = "../../servlet/Combos.LlenaMD?CodEnt=" + document.all.CodEntF.value;
    document.all.CodMDF.value = '';
    pstrCadena = pstrCadena + "&strName=CodMDFC";
    fnOptionxDefault('CodMDFC',pstrCadena);
}

	
function fnLlenaMunicipiosKM(){  
    var pstrCadena = "../../servlet/Combos.LlenaMD?CodEnt=" + document.all.CodEnt.value;
    document.all.CodMD.value = '';
    pstrCadena = pstrCadena + "&strName=CodMDC";
    fnOptionxDefault('CodMDC',pstrCadena);
}

function fnLlenaMunicipiosKMDest(){  
    var pstrCadena = "../../servlet/Combos.LlenaMD?CodEnt=" + document.all.CodEntDest.value;
    document.all.CodMDDest.value = '';
    pstrCadena = pstrCadena + "&strName=CodMDDestC";
    fnOptionxDefault('CodMDDestC',pstrCadena);
}

function fnLlenaMunFunerarioUbic(){  
    var pstrCadena = "../../servlet/Combos.LlenaMD?CodEnt=" + document.all.CodEntUbicacion.value;
    document.all.CodMDUbicacion.value = '';
    pstrCadena = pstrCadena + "&strName=CodMDUbicacionC";
    fnOptionxDefault('CodMDUbicacionC',pstrCadena);
}

function fnLlenaMunFunerarioFallec(){  
    var pstrCadena = "../../servlet/Combos.LlenaMD?CodEnt=" + document.all.CodEntFallecimiento.value;
    document.all.CodMDFallecimiento.value = '';
    pstrCadena = pstrCadena + "&strName=CodMDFallecimientoC";
    fnOptionxDefault('CodMDFallecimientoC',pstrCadena);
}

function fnLlenaMunicipiosOper(){ 
    var pstrCadena = "../../servlet/Combos.LlenaMD?CodEnt=" + document.all.CodEnt.value;
    document.all.CodMD.value = '';
    pstrCadena = pstrCadena + "&strName=CodMDC";
    fnOptionxDefault('CodMDC',pstrCadena);
}

function fnLlenaMunResiden(){
    var pstrCadena = "../../servlet/Combos.LlenaMD?CodEnt=" + document.all.CodEntResid.value;
    document.all.CodMDResid.value = '';
    pstrCadena = pstrCadena + "&strName=CodMDResidC";
    fnOptionxDefault('CodMDResidC',pstrCadena);
}	
 
function fnLlenaMunPolizaUbi(){  
    var pstrCadena = "../servlet/Combos.LlenaMD?CodEnt=" + document.all.CodEntUbicacion.value;
    document.all.CodMDUbicacion.value = '';
    pstrCadena = pstrCadena + "&strName=CodMDUbicacionC";
    fnOptionxDefault('CodMDUbicacionC',pstrCadena);
}

function fnLlenaMunPolizaDest(){  
    var pstrCadena = "../servlet/Combos.LlenaMD?CodEnt=" + document.all.CodEntDest.value;
    document.all.CodMDDest.value = '';
    pstrCadena = pstrCadena + "&strName=CodMDDestC";
    fnOptionxDefault('CodMDDestC',pstrCadena);
}

function fnLLenaEntidadAjax(cod){ /// Llena ComboMemDiv de Entidad segun pais seleccionado SIN funcion

    alert("cod"+cod);
    IDCombo= 'CodEnt';
    Label='Provincia';
    IdDiv='CodEntDiv';
    FnCombo='';
    URL = "../servlet/Combos.LlenaEntidadAjax?";
    Cadena = "Opcion="+cod+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
    fnLLenaInput(URL, Cadena, IdDiv);
}

function fnLlenaEntidadAjaxFn(cod){  /// Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion

    //alert("fnLlenaEntidadAjaxFn:"+cod);

    IDCombo= 'CodEnt';
    Label='Provincia';
    IdDiv='CodEntDiv';
    FnCombo='fnLLenaComboMDAjax(this.value);';
    URL = "../servlet/Combos.LlenaEntidadAjax?";
    Cadena = "Opcion="+cod+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
    
    alert(URL + ' - ' + Cadena + ' - ' + IdDiv);
    
    fnLLenaInput(URL, Cadena, IdDiv);
}

function fnLlenaEntidadAjaxFn2(cod){  /// Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion

    IDCombo= 'CodEnt2';
    Label='Provincia2';
    IdDiv='CodEntDiv2';
    FnCombo='fnLLenaComboMDAjax2(this.value);';
    URL = "../servlet/Combos.LlenaEntidadAjax?";
    Cadena = "Opcion="+cod+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
    
    alert(URL + ' - ' + Cadena + ' - ' + IdDiv);
    
    fnLLenaInput(URL, Cadena, IdDiv);
}

function fnLLenaComboMDAjax2(value){

    IDCombo= 'CodMD2';
    Label='Localidad';
    IdDiv='LocalidadDiv';
    FnCombo='';
    URL = "../servlet/Combos.LlenaMDAjax?";
    Cadena = "Opcion="+value+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
    //alert(URL + ' - ' + Cadena + ' - ' + IdDiv);
    fnLLenaInput(URL, Cadena, IdDiv);
}  

function fnLLenaComboMDAjax(value){

    //alert("llena MD: " + value);
    IDCombo= 'CodMD';
    Label='Localidad';
    IdDiv='LocalidadDiv';
    FnCombo='';
    URL = "../servlet/Combos.LlenaMDAjax?";
    Cadena = "Opcion="+value+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
    //alert(URL + ' - ' + Cadena + ' - ' + IdDiv);
    fnLLenaInput(URL, Cadena, IdDiv);
    
}  

//Abre una pagina para realizar la busqueda de una colonia
function fnBuscaColonia(){
    if (document.all.btnGuarda.disabled==false){
        var pstrCadena = "../Utilerias/FiltrosDireccion.jsp?strSQL=sp_WebBuscaDir 1,'" + document.all.CP.value + "'";
        pstrCadena = pstrCadena + "&Colonia=&CodMd=&dsMunDel=&CodEnt=&dsEntFed=&Tipo=1";
        window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=1,height=1');
    }
}

//Abre una pagina para realizar la busqueda de una colonia desde una segunda subcarpeta
function fnBuscaColoniaN2(){
    if (document.all.btnGuarda.disabled==false){
        var pstrCadena = "../../Utilerias/FiltrosDireccion.jsp?strSQL=sp_WebBuscaDir 1,'" + document.all.CP.value + "'";
        pstrCadena = pstrCadena + "&Colonia=&CodMd=&dsMunDel=&CodEnt=&dsEntFed=&Tipo=1";
        window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=1,height=1');
    }
}

function fnActualizaDatosCP(pCP, dsColonia, CodMD, dsMunDel, CodEnt, dsEntFed){
    document.all.CP.value = pCP;
    document.all.Colonia.value = dsColonia;
    document.all.CodMD.value = CodMD;
    document.all.dsMunDel.value = dsMunDel;
    document.all.CodEnt.value = CodEnt;
    document.all.dsEntFed.value = dsEntFed;
}

function fnLimpiaExtra(){
    if (document.all.Action.value==99){ // MRV-20150512: Se cambia la condicion para que nunca se cumpla, las jsp de detalles de proveedor llaman a esta funcion la cual limpia el estado y municipio en altas �Como para que?
        document.all.CodMD.value = "";
        document.all.CodEnt.value = "";
    }
} 

//Abre una p�gina para realizar la b�squeda de una colonia (Aplica para una segunda direcci�n en la misma p�gina sin c�digo postal, solo colonia)
function fnBuscaColoniaResiden(){ 
    if (document.all.btnGuarda.disabled==false){
        var pstrCadena = "../../Utilerias/FiltrosDireccion.jsp?strSQL=sp_WebBuscaDir 3,'','" + document.all.ColoniaResid.value + "','" + document.all.CodEntResid.value + "'";
        pstrCadena = pstrCadena + "&ColoniaResid=&CodMdResid=&dsMunDelResid=&CodEntResid=&dsEntFedResid=&Tipo=3";
        window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=1,height=1');
    }
}

function fnActualizaDatosResid(CP, ColoniaResid, CodMDResid, dsMunDelResid, CodEntResid, dsEntFedResid){
    document.all.ColoniaResid.value = ColoniaResid;
    document.all.CodMDResid.value = CodMDResid;
    document.all.dsMunDelResid.value = dsMunDelResid;
    document.all.CodEntResid.value = CodEntResid;
    document.all.dsEntFedResid.value = dsEntFedResid;
}

function fnLimpiaExtraResid(){
    if (document.all.Action.value==1){
        document.all.CodMDResid.value = "";
        document.all.CodEntResid.value = "";
    }
}


//Abre una p�gina para realizar la b�squeda de una colonia sin c�digo postal, solo colonia)
function fnBuscaColoniasinCP(){
    if (document.all.btnGuarda.disabled==false){
        var pstrCadena = "../../Utilerias/FiltrosDireccion.jsp?strSQL=sp_WebBuscaDir 4,'','" + document.all.Colonia.value + "','" + document.all.CodEnt.value + "'";
        pstrCadena = pstrCadena + "&Colonia=&CodMd=&dsMunDel=&CodEnt=&dsEntFed=&Tipo=4";
        window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=1,height=1');
    }
}

function fnActualizaDatosCol(CP, dsColonia, CodMD, dsMunDel, CodEnt, dsEntFed){
    document.all.Colonia.value = dsColonia;
    document.all.CodMD.value = CodMD;
    document.all.dsMunDel.value = dsMunDel;
    document.all.CodEnt.value = CodEnt;
    document.all.dsEntFed.value = dsEntFed;
}
	
