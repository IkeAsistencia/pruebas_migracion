function fnValMask(pObj, pstrMask, pstrCampo){
    if (pstrMask=="" || pObj.value==""){
        return true;
    }
    /* Reglas (por cada caracter agregar lo siguiente:
            Tipo:   F Fijo
                    V Variable

            Dato:   N Número
                    ? Cualquiera
                    Valor (en caso de tipo fijo)

            LimiteSup N Número que indica el máximo
            LimiteInf N Número que indica el mínimo

    */

    strVal = "";
    strMask = "";
    strBack = "";
    strChar = "";
    strVal = pObj.value;
    strMask=pstrMask;

    iL=strVal.length;
    iM=strMask.length;
    iC=0;
    iCM=0;
    if (iL>(iM/4)){
        alert("En el campo: " + pstrCampo + " Hay MAS caracteres de los permitidos");
        pObj.focus();   
        return false;
    }

    while((iC<iL) && (iCM<iM)){
        strChar=strVal.substring(iC,iC+1);
        switch(strMask.substring(iCM,iCM+1)){
            case "V":
                switch(strMask.substring(iCM+1,iCM+2)){
                    case "N": 
                        if((strChar!="1") && (strChar!="2") && (strChar!="3") && (strChar!="4") && (strChar!="5") && (strChar!="6") && (strChar!="7") && (strChar!="8") && (strChar!="9") && (strChar!="0")){
                            alert("El caracter " + eval(iC+1) + " en el campo: " + pstrCampo + " debe ser un número");
                            pObj.focus();
                            return false;
                        }
                        strBack=strBack+strChar;
                        break;
                    case "?": strBack=strBack+strChar;
                        break;
                    default: 
                        break;
                }
                iC++;
                iCM+=4;
                break;

            case "F":
                strBack=strBack+strMask.substring(iCM+1,iCM+2);
                //alert(strMask.substring(iCM+1,iCM+2).toUpper());
                if((strChar==strMask.substring(iCM+1,iCM+2))||(strChar==strMask.substring(iCM+2,iCM+3))||(strChar==strMask.substring(iCM+3,iCM+4))){
                    iC++;
                }
                iCM+=4;
                break;
            default: 
                alert("El formato del campo no está bien definido, consulte a su administrador");
                pObj.focus();
                break;    
        }
    }
    iL=strBack.length;
    if (iL<(iM/4)){
        alert("En el campo: " + pstrCampo + "Hay MENOS caracteres de los permitidos");
        pObj.focus();
    }
    pObj.value=strBack;
    return true;
}
	
