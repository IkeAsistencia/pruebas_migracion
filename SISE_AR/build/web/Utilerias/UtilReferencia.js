	function fnValidaResponse(CodeResponse, Url){
		if (CodeResponse!=-1){
// 			WSave.close(); 
			location.href=Url;
		}
		else{
			blnAceptar=0;
			WSave.resizeTo(640,480);
			WSave.focus();
		}
	}
	function fnOpenWindow(){
		WSave=window.open('','WinSave','resizable=yes,menubar=0,status=0,toolbar=0,height=1,width=1,screenX=1,screenY=1');
		if (WSave != null) {
		    if (WSave.opener == null)
			WSave.opener = self;
		}		
		WSave.opener.focus();		
	}	
	function fnOptionxAdd(strName,strIndex,strClave,strDescription){	
		document.all[strName].options[strIndex] = new Option(strClave,strDescription);
	}
	function fnOptionxDefault(strName,strCadena){	
		document.all[strName].length=0;
		document.all[strName].options[0] = new Option('SELECCIONE OPCION','');
		document.all[strName].value='';		
		window.open(strCadena,"newWin","scrollbars=no,status=yes,width=1,height=1");	
	}


	iRow=0;

	function fnIncrementaLinks(){
		if (iRow>200){
			return;
		}
		else{
			iRow+=8;
			strRows="80,200,"+iRow;
			top.document.all.leftPO.rows=strRows;			
			setTimeout("fnIncrementaLinks()",1);
		}
	} 

	function fnIncrementa(){
		if (iRow>60){
			return;
		}
		else{
			iRow+=8;
			strRows=iRow+",*";				
			top.document.all.rightPO.rows=strRows;			
			setTimeout("fnIncrementa()",1);
		}
	}
	
        function fnOpenFolders(iInicio){
		if (iInicio<60){
			iRow=iInicio;
			top.document.all.rightPO.scrolling="no";
			setTimeout("fnIncrementa()",1);
			top.document.all.rightPO.scrolling="yes";		
			top.document.all.DatosExpediente.src="Mail/folders.jsp";
		}else{
			strRows="80,*";				
			top.document.all.rightPO.rows=strRows;			
		}
        }

        function fnOpenFilters(iInicio){
                alert("Quitar llamado a fnOpenFilters(), ya no se usa");
        }

        function fnOpenLinks(iInicio){
		if (iInicio<200){
			iRow=iInicio;
			top.document.all.leftPO.scrolling="no";
			setTimeout("fnIncrementaLinks()",1);
		}else{
			strRows="80,200,*";				
			top.document.all.leftPO.rows=strRows;			
		}
		top.document.all.leftPO.scrolling="yes";		
		top.document.all.InfoRelacionada.src="InfoRelacionada.jsp";
        }

	function fnDecrementaLinks(){
		if (iRowClose<=0){
			strRows=iRowClose+",*";				
			top.document.all.rightPO.rows=strRows;			
			return;
		}
		else{
			iRowClose-=8;
			strRows=iRowClose+",*";				
			top.document.all.rightPO.rows=strRows;			
			setTimeout("fnDecrementaLinks()",1);
		}
	}

	function fnDecrementa(){
		if (iRowClose<=0){
			strRows="80,85,"+iRowClose+",*";				
			top.document.all.leftPO.rows=strRows;			
			return;
		}
		else{
			iRowClose-=8;
			strRows="80,85,"+iRowClose+",*";				
			top.document.all.leftPO.rows=strRows;			
			setTimeout("fnDecrementa()",1);
		}
	}

        function fnCloseLinks(){
		strRows="80,*,0";				
		top.document.all.leftPO.rows=strRows;
                top.document.all.rightPO.rows="0,*";
        }   
	
        function fnCloseFilters(){
                alert("Quitar llamado a fnCloseFilters(), ya no se usa");
        }   

        function fnCloseFolders(){
		strRows="80,85,0,*";				
		top.document.all.leftPO.rows=strRows;			
        }

        function EsNumerico(Campo){ 
           if (isNaN(Campo.value)==true)
           {
              alert(Campo.name + ' debe ser numérico');
              Campo.value="";
           } 
        } 

        function fnRango(Campo,ValIni,ValFin){ 
           if (isNaN(Campo.value)==true)
           {
              alert(Campo.name + ' debe ser numérico');
              Campo.value="";
           } 
           else {
             if (Campo.value < ValIni) {
                alert(Campo.name + ' debe ser entre ' + ValIni + ' y ' + ValFin);
                Campo.value="";
             }
             if (Campo.value > ValFin) { 
                alert(Campo.name + ' debe ser entre ' + ValIni + ' y ' + ValFin);
                Campo.value="";
             }
           } 
        }


        ///******************************************************************************
        //Función:isValidDate (myDate,sep)
        //Propósito: Validar si la información capturada es una fecha
        // Parametros: myDate.- Cadena que se deberá validar
        //             sep.- Caracter que se ocupa como separador  
        ///******************************************************************************

        function isValidDate (myDate,sep) {
        // verifica si la fecha is valida en el formato dd/mm/yyyy hh:mm
                  switch (myDate.length){
                     case 10: //Valida la nada mas la fecha 
                            if (myDate.substring(7,8) == sep && myDate.substring(4,5) == sep) {
                               var date  = myDate.substring(8,10);
                               var month = myDate.substring(5,7);
                               var year  = myDate.substring(0,4);
                               var test = new Date(year,month-1,date);
                               if (year == y2k(test.getYear()) && (month-1 == test.getMonth()) && (date == test.getDate())) {
                                  return 1;
                                 }
                               else {
                                   alert('Formato válido pero Fecha inválida');
                                   return 0;
                                }
                              }
                            else {
                               alert('Separadores Inválidos');
                               return 0;
                            }
                               break;   
                     case 16: //Valida fecha con hora sencilla
                            if (myDate.substring(7,8) == sep && myDate.substring(4,5) == sep) {
                                 var date  = myDate.substring(8,10);
                                 var month = myDate.substring(5,7);
                                 var year  = myDate.substring(0,4);
                                 var hour =  myDate.substring(11,16);  
                                 var test = new Date(year,month-1,date);
                                 if (year == y2k(test.getYear()) && (month-1 == test.getMonth()) && (date == test.getDate())) {
                                     if (isValidHour(hour,':',false)==true){return 1;}
                                     else{
                                          alert('Fecha válida pero Hora inválida');
                                          return 0;
                                         }
                                  }
                                 else{
                                     alert('Formato válido pero Fecha inválida');
                                     return 0;
                                  } 
                              }
                             else{
                                 alert('Separadores Inválidos');
                                 return 0;
                             }
                             break;   
                     case 19://Valida fecha con hora completa
                            if (myDate.substring(7,8) == sep && myDate.substring(4,5) == sep) {
                                 var date  = myDate.substring(8,10);
                                 var month = myDate.substring(5,7);
                                 var year  = myDate.substring(0,4);
                                 var hour =  myDate.substring(11,19);  
                                 var test = new Date(year,month-1,date);
                                 if (year == y2k(test.getYear()) && (month-1 == test.getMonth()) && (date == test.getDate())) {
                                     if (isValidHour(hour,':',true)==true){return 1;}
                                     else{
                                          alert('Fecha válida pero Hora inválida');
                                          return 0;
                                         }
                                  }
                                 else{
                                     alert('Formato válido pero Fecha inválida');
                                     return 0;
                                  } 
                              }
                             else{
                                 alert('Separadores Inválidos');
                                 return 0;
                             }
                             break;
                     case 0: 
                             return 0;     
                             break;
                     default:
                             alert('Tamaño Inválido');
                             return 0;
                             break;
                } 
        }

        function y2k(number) { return (number < 1000) ? number + 1900 : number; }


        ///******************************************************************************
        //Función:iisValidHour  (myDate,sep)
        //Propósito: Validar si la información capturada es una Hora 
        // Parametros: myHour.- Cadena que se deberá validar
        //             sep.- Caracter que se ocupa como separador  
        ///******************************************************************************

        function isValidHour (myHour,sep,conSegundos) {
        // verifica si la hora is valida en el formato hh:mm:ss 

           if (conSegundos==true){ 
               if (myHour.length==8) {
                  if (myHour.substring(2,3) == sep && myHour.substring(5,6) == sep) {
                        var Hour  = myHour.substring(0,2);
                        var Min = myHour.substring(3,5);
                        var Seg  = myHour.substring(6,8);

                       if (Hour>=0 && Hour<=24){
                          if (Min>=0 &&  Min<=60){
                             if (Seg>=0 &&  Seg<=60){
                                return 1;
                              }else{
                                alert('Segundos Invalidos');
                                return 0;
                              }
                           }else{
                           alert('Minutos Invalidos');
                           return 0;
                           }  
                        }//if hora
                         else{
                           alert('Hora Invalida');
                           return 0;
                        }
                    }// if separador
                    else {
                        alert('Separadores Invalidos');
                        return 0;
                    }
                }//if tamaño
                else {
                    alert('Tamaño Invalido');
                    return 0;
                }
           } //if conSegundos
           else{

               if (myHour.length==5) {
                  if (myHour.substring(2,3) == sep) {
                        var Hour  = myHour.substring(0,2);
                        var Min = myHour.substring(3,5);

                       if (Hour>=0 && Hour<=24){
                          if (Min>=0 &&  Min<=60){
                                return 1;
                           }
                           else{
                           alert('Minutos Invalidos');
                           return 0;
                           }  
                        }//if hora
                         else{
                           alert('Hora Invalida');
                            return 0;
                        }
                    }// if separador
                    else {
                        alert('Separadores Invalidos');
                        return 0;
                    }
                }//if tamaño
                else {
                    alert('Tamaño Invalido');
                    return 0;
                }

           }


        }

        function fnValidaCampo(obj,strTipoCampo){
           if (document.all.Action.value==1 ||document.all.Action.value==2){
                var strCampo=obj.value;
                var ok;     
                  switch (strTipoCampo){
                     case "HoraCompleta":
                                 ok=isValidHour(strCampo,':',true);
                                 break;   
                     case "HoraParcial":
                                 ok=isValidHour(strCampo,':',false);
                                 break;   
                     case "Fecha":   
                                 ok=isValidDate(strCampo,'/');
                                break;    
                     default: break;
                } 

              if (ok==0){
                    alert("La información de " + strTipoCampo + " no esta capturada correctamente");
                   obj.value="";
               }             
          }
        }


