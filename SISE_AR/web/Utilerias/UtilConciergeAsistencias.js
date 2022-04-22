
/*---VALIDACIONES PARA PAGOS CON TARJETA DE CREDITO (INICIO)---*/


function fnAntesGuardar(){
    if ((document.all.clTipoPagoC.value == 1 || document.all.clTipoPagoC.value == 2 || document.all.clTipoPagoC.value == 3) && (document.all.SecC.value == "" || document.all.Expira.value == "" || document.all.NumeroTC.value == ""))
    {
        msgVal = msgVal + "Favor de proveer los datos completos de Pago por Tarjeta de Crédito";
        document.all.btnGuarda.readOnly=false;
        document.all.btnCancela.readOnly=false;
        document.all.btnGuarda.disabled=false;
        document.all.btnCancela.disabled=false;
    }
}
        
/////////////////////////////////////////////////Validacion forma de pago
function fnTipoPago(opcion){
    if (document.all.Action.value==1){
        if (opcion==1){
            document.all.NomBanco.readOnly=false;
            document.all.NombreTC.readOnly=false; 
            document.all.NumeroTC.readOnly=false;
            document.all.SecC.readOnly=false;
            document.all.ExpiraVTR.readOnly=false;
            document.all.NumeroTC.maxLenght=19;
            document.all.SecC.maxLength=3;
            document.all.NumeroTCMsk.value="VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09";
            document.all.SecCMsk.value="VN09VN09VN09";
            document.all.NomBanco.className="FReq";
            document.all.NombreTC.className="FReq"; 
            document.all.NumeroTC.className="FReq";
            document.all.SecC.className="FReq";
            document.all.ExpiraVTR.className="FReq";
            document.all.ExpiraMsk.value="VN09VN09F-/-VN09VN09";       
        }
        else if (opcion==2){
            document.all.NomBanco.readOnly=false;
            document.all.NombreTC.readOnly=false; 
            document.all.NumeroTC.readOnly=false;
            document.all.SecC.readOnly=false;
            document.all.ExpiraVTR.readOnly=false;
            document.all.NumeroTC.maxLenght=19;
            document.all.SecC.maxLength=3;
            document.all.NumeroTCMsk.value="VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09";
            document.all.SecCMsk.value="VN09VN09VN09";
            document.all.NomBanco.className="FReq";
            document.all.NombreTC.className="FReq"; 
            document.all.NumeroTC.className="FReq";
            document.all.SecC.className="FReq";
            document.all.ExpiraVTR.className="FReq";
            document.all.ExpiraMsk.value="VN09VN09F-/-VN09VN09";
        }
        
        else if (opcion==3 ){
            document.all.NomBanco.readOnly=false;
            document.all.NombreTC.readOnly=false; 
            document.all.NumeroTC.readOnly=false;
            document.all.SecC.readOnly=false;
            document.all.ExpiraVTR.readOnly=false;            
            document.all.SecC.maxLength=4;
            document.all.NumeroTCMsk.value="VN09VN09VN09VN09F-/-VN09VN09VN09VN09VN09VN09F-/-VN09VN09VN09VN09VN09";
            document.all.NumeroTC.maxLenght=18;
            document.all.SecCMsk.value="VN09VN09VN09VN09";
            document.all.NomBanco.className="FReq";
            document.all.NombreTC.className="FReq"; 
            document.all.NumeroTC.className="FReq";
            document.all.SecC.className="FReq";
            document.all.ExpiraVTR.className="FReq";
            document.all.ExpiraMsk.value="VN09VN09F-/-VN09VN09";
        }
        else {
            document.all.NumeroTCMsk.value="";
            document.all.ExpiraMsk.value="";
            document.all.NomBanco.readOnly=true;
            document.all.NombreTC.readOnly=true;
            document.all.NumeroTC.readOnly=true;
            document.all.SecC.readOnly=true;
            document.all.ExpiraVTR.readOnly=true;
            document.all.NomBanco.value="";
            document.all.NombreTC.value="";
            document.all.NumeroTC.value="";
            document.all.SecC.value="";
            document.all.Expira.value="";
            document.all.SecCMsk.value="";
            document.all.ExpiraVTR.value="";
            document.all.NumeroTC.className="VTable";
            document.all.NomBanco.className="VTable";
            document.all.NombreTC.className="VTable";
            document.all.SecC.className="VTable";
            document.all.ExpiraVTR.className="VTable";
        }
    } else if(document.all.Action.value==2){

        if (opcion==1){
            document.all.NomBanco.readOnly=false;
            document.all.NombreTC.readOnly=false; 
            document.all.NumeroTC.readOnly=false;
            document.all.SecC.readOnly=false;
            document.all.ExpiraVTR.readOnly=false;
            document.all.NumeroTC.maxLenght=19;
            document.all.SecC.maxLength=3;
            document.all.NumeroTCMsk.value="VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09";
            document.all.SecCMsk.value="VN09VN09VN09";
            document.all.ExpiraMsk.value="VN09VN09F-/-VN09VN09";       
        }
        else if (opcion==2){
            document.all.NomBanco.readOnly=false;
            document.all.NombreTC.readOnly=false; 
            document.all.NumeroTC.readOnly=false;
            document.all.SecC.readOnly=false;
            document.all.ExpiraVTR.readOnly=false;
            document.all.NumeroTC.maxLenght=19;
            document.all.SecC.maxLength=3;
            document.all.NumeroTCMsk.value="VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09F-/-VN09VN09VN09VN09";
            document.all.SecCMsk.value="VN09VN09VN09";
            document.all.ExpiraMsk.value="VN09VN09F-/-VN09VN09";
        }
        
        else if (opcion==3 ){
            document.all.NomBanco.readOnly=false;
            document.all.NombreTC.readOnly=false; 
            document.all.NumeroTC.readOnly=false;
            document.all.SecC.readOnly=false;
            document.all.ExpiraVTR.readOnly=false;            
            document.all.SecC.maxLength=4;
            document.all.NumeroTCMsk.value="VN09VN09VN09VN09F-/-VN09VN09VN09VN09VN09VN09F-/-VN09VN09VN09VN09VN09";
            document.all.NumeroTC.maxLenght=18;
            document.all.SecCMsk.value="VN09VN09VN09VN09";
            document.all.ExpiraMsk.value="VN09VN09F-/-VN09VN09";
        }
        else {
            document.all.NumeroTCMsk.value="";
            document.all.ExpiraMsk.value="";
            document.all.NomBanco.readOnly=true;
            document.all.NombreTC.readOnly=true;
            document.all.NumeroTC.readOnly=true;
            document.all.SecC.readOnly=true;
            document.all.ExpiraVTR.readOnly=true;
            document.all.NomBanco.value="";
            document.all.NombreTC.value="";
            document.all.NumeroTC.value="";
            document.all.SecC.value="";
            document.all.Expira.value="";
            document.all.SecCMsk.value="";
            document.all.ExpiraVTR.value="";
            document.all.NumeroTC.className="VTable";
            document.all.NomBanco.className="VTable";
            document.all.NombreTC.className="VTable";
            document.all.SecC.className="VTable";
            document.all.ExpiraVTR.className="VTable";
        }
    }

}
////////////////////////////////////////////////////////////////////////////
    
function fnValidaPrefijoTC(numtc){
        
    if(document.all.NumeroTC.value != ""){
        if (document.all.clTipoPagoC.value=="1"){
            if (numtc.substring(0,1)!="4"){
                alert("El prefijo de VISA no es válido.");
                document.all.NumeroTC.focus();
            }
        }

        if (document.all.clTipoPagoC.value=="2"){
            if (numtc.substring(0,1)!="5"){
                alert("El prefijo de MASTERCARD no es válido.");
                document.all.NumeroTC.focus();
            }
        }

        if (document.all.clTipoPagoC.value=="3"){
            if (numtc.substring(0,1)!="3"){
                alert("El prefijo de AMERICAN EXPRESS no es válido.");
                document.all.NumeroTC.focus();
            }
        }
            
            
    }
}

//////////////////////////////////////////////Vencimiento de tarjeta

function fnFechVen(venc){
    if(document.all.ExpiraVTR.value=="-"){
        document.all.ExpiraVTR.value="";
    } else{
        if (document.all.ExpiraVTR.value != ""){
            var mes = venc.substring(0,2);
            var anio = venc.substring(3,5);
            document.all.Expira.value = '20'+ anio + "-" + mes;
            var actual=new Date();      
            var vanio='20'+ anio;
            var aanio=actual.getYear();
            var ames=actual.getMonth();
            //alert("Mes"+actual.getMonth());
            var sanio=aanio.toString();
            var smes=ames.toString();
            var actanio= parseInt(sanio,10);
            var actmes= parseInt(smes,10);
            var venanio= parseInt(vanio,10);
            var venmes= parseInt(mes,10);

            actmes=actmes+1;
            // alert(actanio+"-"+venanio);
            //alert(actmes+"-"+venmes);

            if(actanio <= venanio){
                //alert(venmes);
                if(venmes < 13 && venmes !=0){              
                    var ianio= actanio;
                    var imes= actmes;
                    var inmes= 12;
                    var contmes=0;
                  
                    for(ianio;ianio<=venanio;ianio++){
                        if(ianio==venanio)
                            inmes=venmes;
                   
                        for(imes;(imes<=inmes)&&(imes<13);imes++){
                            contmes=contmes+1;
                        }

                        if(imes>12)
                            imes=1;
                    }
                }else{
                    alert("Fecha Invalida, Favor de Verificar");
                    document.all.ExpiraVTR.value = "";
                    document.all.Expira.value = "";
                    document.all.ExpiraVTR.focus();
                    document.all.btnGuarda.readOnly=false;
                    document.all.btnCancela.readOnly=false;
                    document.all.btnGuarda.disabled=false;
                    document.all.btnCancela.disabled=false;
                }
                
            } else {
    
                if(contmes<1 || (venanio <= actanio)){
                    alert("La Tarjeta Esta Vencida");
                    document.all.ExpiraVTR.value = "";
                    document.all.Expira.value = "";
                    document.all.ExpiraVTR.focus();
                    document.all.btnGuarda.readOnly=false;
                    document.all.btnCancela.readOnly=false;
                    document.all.btnGuarda.disabled=false;
                    document.all.btnCancela.disabled=false;
                }
            }
        }
    }
}
/////////////////////////////////////////////////////////Funcion para Limpiar campos de tarjeta
function fnLimpiaTar(){
    if(document.all.clTipoPago.value==1 || document.all.clTipoPago.value==2 || document.all.clTipoPago.value==3)
    {
        document.all.NombreTC.value="";
        document.all.NomBanco.value="";
        document.all.NumeroTC.value="";
        document.all.Expira.value="";
        document.all.ExpiraVTR.value="";
        document.all.SecC.value="";
    }

    if (document.all.clTipoPago.value==4 || document.all.clTipoPago.value==5 || document.all.clTipoPago.value==6 || document.all.clTipoPago.value==7){
        document.all.NomBanco.value="";
        document.all.NombreTC.value="";
        document.all.NumeroTC.value="";
        document.all.Expira.value="";
        document.all.ExpiraVTR.value="";
        document.all.SecC.value="";
        document.all.NomBanco.readOnly=true;
        document.all.NombreTC.readOnly=true;	
        document.all.NumeroTC.readOnly=true;	
        document.all.Expira.readOnly=true;
        document.all.ExpiraVTR.readOnly=true;
        document.all.SecC.readOnly=true;	
    }
    else {
        document.all.NomBanco.readOnly=false;	
        document.all.NombreTC.readOnly=false;	
        document.all.NumeroTC.readOnly=false;	
        document.all.Expira.readOnly=false;
        document.all.ExpiraVTR.readOnly=false;
        document.all.SecC.readOnly=false;
        
    }
}
/////////////////////////Funcion Campos requeribles    
function fnReqCampo(){
    if (document.all.clTipoPago.value==1 || document.all.clTipoPago.value==2 || document.all.clTipoPago.value==3)
    {
        if ( document.all.NomBanco.value=="" || document.all.NombreTC.value=="" || document.all.NumeroTC.value=="" || document.all.ExpiraVTR.value=="" || document.all.SecC.value=="")
        {
            msgVal = msgVal + " Debe de Ingresar Los campos requeridos de Tarjetas de Credito. ";
            document.all.NomBanco.focus();
            document.all.btnGuarda.readOnly=false;
            document.all.btnCancela.readOnly=false;
            document.all.btnGuarda.disabled=false;
            document.all.btnCancela.disabled=false;
        }
    }
}

/*------------------------------------------------VALIDACIONES PARA PAGOS CON TARJETA DE CREDITO (FIN)------------------------------------------------- */  


function fnPregunta(VC,VS,VU,PO){
    var Urlback = document.all.URLBACK.value;

    if (document.all.Action.value ==1){
        Urlback = Urlback + "CSCamposExtraAs.jsp?clConcierge="+VC+"&clSubservicio="+VS+"&URLASISTENCIA="+VU+"&Pregunta="+document.all.Pregunta.value;
    }else{
        Urlback = Urlback + PO + "?";
    }

    var cachahURL = document.all.URLBACK.value;
    if (cachahURL.indexOf(".jsp")==-1){
        document.all.URLBACK.value = Urlback;
    }          
} 

function fnValidaCorreo(pCampo){
    var Cadena
    var PosArroba
    var usuario
    var dominio

    if(pCampo.value!=''){
        if(pCampo.value.indexOf('@', 0) == -1){
            pCampo.value = '';
            alert("La dirección de correo no es valida.");
        }else{
            PosArroba = pCampo.value.lastIndexOf('@')
            usuario=pCampo.value.substring(0,PosArroba)
            dominio=pCampo.value.substring(PosArroba+1,Cadena)
            if (usuario == '' || dominio=='') {
                pCampo.value = '';
                alert("La dirección de correo no es valida.");
            }
            //Valida el nombre de usuario y verifica que no existan dos @
            if(usuario.indexOf('@', 0) != -1) {
                pCampo.value = '';
                alert("La dirección de correo no es valida.");
            }
            //valida el dominio
            if(dominio.indexOf('.', 0) == -1 || dominio.indexOf('@', 0) != -1){
                pCampo.value = '';
                alert("La dirección de correo no es valida.");
            }
        }
    }
}

function fnEsNumerico(Campo){
    if(isNaN(Campo.value)==true){
        alert(Campo.label + ' debe ser numérico, sin espacios ni guiones.');
        Campo.value = '';
        Campo.focus();
        document.all.NombreBanco.value = '';
    }
}


