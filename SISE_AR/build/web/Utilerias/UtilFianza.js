function fnLlenaProvFian(){
        var strConsulta = "sp_LlenaProvConFianzas " + document.all.clAfianzadora.value;
        var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
        pstrCadena = pstrCadena + "&strName=clProveedorExhibeC";		
        fnOptionxDefault('clProveedorExhibeC',pstrCadena);
}

function fnLlenaFoliosLibres(){
        var strConsulta = "sp_LlenaFoliosLibres " + document.all.clAfianzadora.value + ",'" + document.all.clProveedorExhibe.value + "','" + document.all.clFolioAfianzadora.value + "'" ;
        var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
        pstrCadena = pstrCadena + "&strName=clFolioAfianzadoraC";		
        fnOptionxDefault('clFolioAfianzadoraC',pstrCadena);
}

function fnValidaFecha(AnioComp)
 { 
 
   intAnioExh = 0;
   intAnioExp = 0;
 
   if(fnValMask(document.all.FechaExhib,document.all.FechaExhibMsk.value,'FechaExhib')!=false){

       intAnioExh = document.all.FechaExhib.value.substring(0,4);
       intAnioExp = document.all.FechaExped.value.substring(0,4);

       //  Validar no se cambie el año en las fechas
       if (document.all.Action.value == 2)   // Si es modificacion, se validan las fechas deben ser del mismo anio
        {
              if (AnioComp != intAnioExh)
              {
               alert("El año informado de la Fecha de Exhibición no debe ser diferente al que se informó cuando se dió de alta");
               document.all.FechaExhib.focus(); 
                return;
              }
        }

        if (document.all.FechaExped.value < document.all.FechaExhib.value)
        {
           alert("La Fecha de Expedición no puede ser menor a la Fecha de Exhibición");
           document.all.FechaExped.focus(); 
        }
   }
 }
function fnBuscaDatFianza(){

    if (document.all.clFolioAfianzadora.value!=''){
        if (document.all.Action.value==1){
             var pstrCadena = "BuscaDatosFianza.jsp?";
             pstrCadena = pstrCadena + "clFolioAfianzadora= " + document.all.clFolioAfianzadora.value;
             window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
        } 
    }

}

function fnActualizaDatFianza(pFechaExped){
    document.all.FechaExped.value=pFechaExped;
}