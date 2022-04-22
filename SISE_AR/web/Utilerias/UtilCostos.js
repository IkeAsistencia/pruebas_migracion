function fnLlenaConceptos(pclAreaOperativa) {
    var pstrCadena = "../servlet/Combos.LlenaConcepto?clAreaOperativa=" + pclAreaOperativa;
    document.all.clConcepto.value = '';
    pstrCadena = pstrCadena + "&strName=clConceptoC";
    fnOptionxDefault('clConceptoC', pstrCadena);
}

function fnRegresaCosto() {
    if (document.all.clConcepto.value == '0') {
        document.all.Concepto.readOnly = false;
        //document.all.Concepto.className = 'FReq';
        document.all.Concepto.value = '';
        //document.all.CostoSEA.className = 'FReq';
        document.all.CostoSEA.value = '';
        // document.all.Costo.value = '';
        document.all.CostoConv.value = '0';
        document.all.Excepcion.value = '0';


    } else {
        document.all.Concepto.readOnly = true;
        //document.all.Concepto.className = 'FTable';
        //document.all.CostoSEA.className = 'FTable';
        var pstrCadena = "RegresaCosto.jsp?clProveedor=" + document.all.clProveedor.value + "&clConcepto=" + document.all.clConcepto.value;
        window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=700,height=500');
    }
}

/*function fnActualizaDatosCosto(pCosto,pclCostoxSubservxEF,pclCostoXProvXSubserv){
 document.all.CostoConv.value = pCosto;
 document.all.clCostoxSubservxEF.value=pclCostoxSubservxEF;
 document.all.clCostoXProvXSubserv.value=pclCostoXProvXSubserv;
 document.all.Concepto.value=document.all.clConceptoC.options[document.all.clConceptoC.selectedIndex].text;
 fnTotaliza();
 }*/

function fnActualizaDatosCosto(pCosto, pclCostoxSubservxEF, pclCostoXProvXSubserv, pclCategoria, pExcepcion) {
    document.all.CostoConv.value = pCosto;
    document.all.clCostoxSubservxEF.value = pclCostoxSubservxEF;
    document.all.clCostoXProvXSubserv.value = pclCostoXProvXSubserv;
    document.all.Concepto.value = document.all.clConceptoC.options[document.all.clConceptoC.selectedIndex].text;
    document.all.clCategoria.value = pclCategoria;
    document.all.Excepcion.value = pExcepcion;
    fnTotaliza();
    fnMuestraKMS();
}

function fnTotaliza() {

    CostoExcedente = eval(parseInt(document.all.CostoSEA.value) + parseInt(document.all.CostoNU.value) - parseInt(document.all.CostoConv.value));
    if (CostoExcedente < 0) {
        CostoExcedente = 0;
    }
    document.all.CostoExced.value = CostoExcedente;
}

function fnRegistraPago() {
    if (document.all.btnGuarda.disabled == true) {
        var strCadena = "../servlet/Utilerias.RegistraPago?clProveedor=" + document.all.clProveedor.value + "&TipoPago=" + document.all.Nomina.value + "&clCosto=" + document.all.clCosto.value +"&CostoNU="+ document.all.CostoNU.value +"&clMedioPago="+ document.all.clMedioPago.value +"&CostoCIA="+ document.all.CostoCIA.value;
        window.open(strCadena, "newWin", "scrollbars=no,status=yes,width=1,height=1");
    }
}