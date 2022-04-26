//<<<<<<<<<<<<<<<< Función que Obtiene la secuencia de Guardar,  Actualizar >>>>>>>>>>>>>
function fnsp_Guarda(){
        if (document.all.Action.value==1){
                document.all.Secuencia.value=fnOrden(1);
        }       
        
        if (document.all.Action.value==2){
            document.all.Secuencia.value=fnOrden(2);
        }
}

//<<<<<<<<<<<<<<<  Función que regresa los Valores de la Secuencia  >>>>>>>>>>>>>>>>
function fnOrden(Action){

      if (Action==1){
        var SGuarda= document.all.SecuenciaG.value ;
        SGuarda=SGuarda.split(",");
      }       

      if (Action==2){
        var SGuarda= document.all.SecuenciaA.value ;
        SGuarda=SGuarda.split(",");
      } 

     var ID="";
     var SPGuarda="";

    for (i=0; i<SGuarda.length; i++){
        ID=SGuarda[i]; 
        SPGuarda=SPGuarda+"'"+document.all[ID].value+"'";
        if (i!=SGuarda.length-1)
            SPGuarda=SPGuarda+","
    }
     return SPGuarda;
}