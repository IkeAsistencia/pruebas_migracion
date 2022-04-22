iRow = 0;
//------------------------------------------------------------------------------
function assignGeoHogar(clProveedor) {
    parent.frames['DatosExpediente'].datos.clProveedor.value = clProveedor;
    parent.frames['DatosExpediente'].datos.modo.value = "GEOHOGAR";
    parent.frames['Contenido'].location.href = '../Operacion/AsignaProveedor.jsp?Proveedor=' + clProveedor + "&modo=GEOHOGAR";
}
//------------------------------------------------------------------------------
function assignGeoVial(clProveedor) {
    parent.frames['DatosExpediente'].datos.clProveedor.value = clProveedor;
    parent.frames['DatosExpediente'].datos.modo.value = "GEOVIAL";
    parent.frames['Contenido'].location.href = '../Operacion/AsignaProveedor.jsp?Proveedor=' + clProveedor + "&modo=GEOVIAL";
}
//------------------------------------------------------------------------------
function openGeoMap( osmid, clPais, clEntFed, codMD, dsMunDel, tipo, id, tieneAA) {
    sUrl = '../Geolocalizacion/prestadoresMap.jsp?change=true&osmid=' + osmid;
    sUrl = sUrl + '&clPais='   + clPais;
    sUrl = sUrl + '&clEntFed=' + clEntFed;
    sUrl = sUrl + '&codMD='    + codMD;
    sUrl = sUrl + '&dsMunDel=' + dsMunDel;
    sUrl = sUrl + '&tipo='     + tipo;
    sUrl = sUrl + '&id='       + id;
    sUrl = sUrl + '&tieneAA='  + tieneAA;
    WMap = window.open(sUrl, 'MapManager', 'modal=yes,resizable=yes,menubar=0,status=0,toolbar=0,height=1000,width=1400,screenX=1,screenY=1');
}
//------------------------------------------------------------------------------
function fnValidaResponse(CodeResponse, Url) {
    if (CodeResponse != -1) {
        WSave.close();
        location.href = Url;
    }
    else {
        blnAceptar = 0;
        document.all.btnGuarda.disabled = false;
        document.all.btnCancela.disabled = false;
        WSave.resizeTo(640, 480);
        WSave.focus();
    }
}
//------------------------------------------------------------------------------
function fnRelocate(Url) {
    location.href = Url;}
//------------------------------------------------------------------------------
function fnOpenWindow() {
    WSave = window.open('', 'WinSave', 'modal=yes,resizable=yes,menubar=0,status=0,toolbar=0,height=1,width=1,screenX=1,screenY=1');
    if (WSave != null) {
        if (WSave.opener == null)
            WSave.opener = self;
    }
    WSave.opener.focus();
}
//------------------------------------------------------------------------------
function fnReplaceSelect(strName, strNew) {
    var strSELECT = document.getElementById([strName]);
    var cadena = "<option value='0'>SELECCIONE OPCION</option>" + strNew;
    strSELECT.outerHTML = strSELECT.outerHTML.replace(strSELECT.innerHTML, cadena + '</select>');
//    strSELECT = "";
//    strSELECT = document.all[strName].outerHTML;
//    strSELECT = strSELECT.substring(0, strSELECT.indexOf("<OPTION", 1));
//    strSELECT = strSELECT + "<OPTION VALUE=''>SELECCIONE OPCION</OPTION>" + strNew;
//    strSELECT = strSELECT + "</SELECT>";
//    document.all[strName].length = 0;
//    document.all[strName].outerHTML = strSELECT;
    }
//------------------------------------------------------------------------------
function fnOptionxAdd(strName, strIndex, strClave, strDescription) {
    document.all[strName].options[strIndex] = new Option(strClave, strDescription);
}
//------------------------------------------------------------------------------
function fnOptionxDefault(strName, strCadena) {
    document.all[strName].length = 0;
    document.all[strName].options[0] = new Option('SELECCIONE OPCION', '');
    document.all[strName].value = '';
    window.open(strCadena, "", "scrollbars=no,status=yes,width=1,height=1");
}
//------------------------------------------------------------------------------
function fnIncrementaLinks() {
    if (iRow > 200) {
        return;
    }
    else {
        iRow += 8;
        strRows = "80,200," + iRow;
        top.document.all.leftPO.rows = strRows;
        setTimeout("fnIncrementaLinks()", 1);
    }
}
//------------------------------------------------------------------------------
function fnIncrementa() {
    if (iRow > 60) {
        return;
    }
    else {
        iRow += 8;
        strRows = iRow + ",*";
        top.document.all.rightPO.rows = strRows;
        setTimeout("fnIncrementa()", 1);
    }
}
//------------------------------------------------------------------------------
function fnOpenFolders(iInicio) {
    if (iInicio < 60) {
        iRow = iInicio;
        top.document.all.rightPO.scrolling = "no";
        setTimeout("fnIncrementa()", 1);
        top.document.all.rightPO.scrolling = "yes";
        top.document.all.DatosExpediente.src = "Mail/folders.jsp";
    } else {
        strRows = "80,*";
        top.document.all.rightPO.rows = strRows;
    }
}
//------------------------------------------------------------------------------
function fnOpenFilters(iInicio) {
    alert("Quitar llamado a fnOpenFilters(), ya no se usa");
}
//------------------------------------------------------------------------------
function fnOpenLinks(iInicio) {
    if (top.document.all.leftPO == null) {
        url_site = document.URL;
        url_pos = url_site.indexOf('//');
        url_limpia = url_site.substr(url_pos + 2);
        url_prot = url_site.substr(0, url_pos + 2);
        // separamos todas las posibles carpetas
        url_split = url_limpia.split('/');
        // y obtenemos el dominio actual
        url_base = url_prot + url_split[0];
        //alert(url_split[0]);
        if (url_split[0].indexOf('localhost') != -1) {
            url_base = url_prot + url_split[0] + "/" + url_split[1];
        }
        document.location.href = url_base;
    }
    if (iInicio < 200) {
        iRow = iInicio;
        top.document.all.leftPO.scrolling = "no";
        setTimeout("fnIncrementaLinks()", 1);
    } else {
        strRows = "80,200,*";
        top.document.all.leftPO.rows = strRows;
    }
    top.document.all.leftPO.scrolling = "yes";
    top.document.all.InfoRelacionada.contentWindow.location.reload();
}
//------------------------------------------------------------------------------
function fnDecrementaLinks() {
    if (iRowClose <= 0) {
        strRows =  iRowClose + ",*";
        top.document.all.rightPO.rows = strRows;
        return;
    }
    else {
        iRowClose -= 8;
        strRows =  iRowClose + ",*";
        top.document.all.rightPO.rows = strRows;
        setTimeout("fnDecrementaLinks()", 1);
    }
}
//------------------------------------------------------------------------------
function fnDecrementa() {
    if (iRowClose <= 0) {
        strRows = "80,85," + iRowClose + ",*";
        top.document.all.leftPO.rows = strRows;
        return;
    }
    else {
        iRowClose -= 8;
        strRows = "80,85," + iRowClose + ",*";
        top.document.all.leftPO.rows = strRows;
        setTimeout("fnDecrementa()", 1);
    }
}
//------------------------------------------------------------------------------
function fnCloseLinks() {
    strRows = "80,*,0";
    top.document.all.leftPO.rows = strRows;
    top.document.all.rightPO.rows = "0,*";
}
//------------------------------------------------------------------------------
function fnCloseFilters() {
    alert("Quitar llamado a fnCloseFilters(), ya no se usa");
}
//------------------------------------------------------------------------------
function fnCloseFolders() {
    strRows = "80,85,0,*";
    top.document.all.leftPO.rows = strRows;
}
//------------------------------------------------------------------------------
function EsNumerico(Campo) {
    if (isNaN(Campo.value) == true)
    {
        alert(Campo.name + ' debe ser numérico');
        Campo.value = "";
    }
}
//------------------------------------------------------------------------------
function fnRango(Campo, ValIni, ValFin) {
    if (isNaN(Campo.value) == true)
    {
        alert(Campo.name + ' debe ser numérico');
        Campo.value = "";
    }
    else {
        if (Campo.value < ValIni) {
            alert(Campo.name + ' debe ser entre ' + ValIni + ' y ' + ValFin);
            Campo.value = "";
        }
        if (Campo.value > ValFin) {
            alert(Campo.name + ' debe ser entre ' + ValIni + ' y ' + ValFin);
            Campo.value = "";
        }
    }
}
//------------------------------------------------------------------------------
///******************************************************************************
//Función:isValidDate (myDate,sep)
//Propósito: Validar si la información capturada es una fecha
// Parametros: myDate.- Cadena que se deberá validar
//             sep.- Caracter que se ocupa como separador
///******************************************************************************
//------------------------------------------------------------------------------
function isValidDate(myDate, sep) {
    // verifica si la fecha is valida en el formato dd/mm/yyyy hh:mm
    switch (myDate.length) {
        case 10: //Valida la nada mas la fecha
            if (myDate.substring(7, 8) == sep && myDate.substring(4, 5) == sep) {
                var date = myDate.substring(8, 10);
                var month = myDate.substring(5, 7);
                var year = myDate.substring(0, 4);
                var test = new Date(year, month - 1, date);
                if (year == y2k(test.getYear()) && (month - 1 == test.getMonth()) && (date == test.getDate())) {
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
            if (myDate.substring(7, 8) == sep && myDate.substring(4, 5) == sep) {
                var date = myDate.substring(8, 10);
                var month = myDate.substring(5, 7);
                var year = myDate.substring(0, 4);
                var hour = myDate.substring(11, 16);
                var test = new Date(year, month - 1, date);
                if (year == y2k(test.getYear()) && (month - 1 == test.getMonth()) && (date == test.getDate())) {
                    if (isValidHour(hour, ':', false) == true) {
                        return 1;
                    }
                    else {
                        alert('Fecha válida pero Hora inválida');
                        return 0;
                    }
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
        case 19://Valida fecha con hora completa
            if (myDate.substring(7, 8) == sep && myDate.substring(4, 5) == sep) {
                var date = myDate.substring(8, 10);
                var month = myDate.substring(5, 7);
                var year = myDate.substring(0, 4);
                var hour = myDate.substring(11, 19);
                var test = new Date(year, month - 1, date);
                if (year == y2k(test.getYear()) && (month - 1 == test.getMonth()) && (date == test.getDate())) {
                    if (isValidHour(hour, ':', true) == true) {
                        return 1;
                    }
                    else {
                        alert('Fecha válida pero Hora inválida');
                        return 0;
                    }
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
        case 0:
            return 0;
            break;
        default:
            alert('Tamaño Inválido');
            return 0;
            break;
    }
}
//------------------------------------------------------------------------------
function y2k(number) {
    return (number < 1000) ? number + 1900 : number;
}
//------------------------------------------------------------------------------
///******************************************************************************
//Función:iisValidHour  (myDate,sep)
//Propósito: Validar si la información capturada es una Hora
// Parametros: myHour.- Cadena que se deberá validar
//             sep.- Caracter que se ocupa como separador
///******************************************************************************
//------------------------------------------------------------------------------
function isValidHour(myHour, sep, conSegundos) {
    // verifica si la hora is valida en el formato hh:mm:ss

    if (conSegundos == true) {
        if (myHour.length == 8) {
            if (myHour.substring(2, 3) == sep && myHour.substring(5, 6) == sep) {
                var Hour = myHour.substring(0, 2);
                var Min = myHour.substring(3, 5);
                var Seg = myHour.substring(6, 8);

                if (Hour >= 0 && Hour <= 24) {
                    if (Min >= 0 && Min <= 60) {
                        if (Seg >= 0 && Seg <= 60) {
                            return 1;
                        } else {
                            alert('Segundos Invalidos');
                            return 0;
                        }
                    } else {
                        alert('Minutos Invalidos');
                        return 0;
                    }
                }//if hora
                else {
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
    else {

        if (myHour.length == 5) {
            if (myHour.substring(2, 3) == sep) {
                var Hour = myHour.substring(0, 2);
                var Min = myHour.substring(3, 5);

                if (Hour >= 0 && Hour <= 24) {
                    if (Min >= 0 && Min <= 60) {
                        return 1;
                    }
                    else {
                        alert('Minutos Invalidos');
                        return 0;
                    }
                }//if hora
                else {
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
//------------------------------------------------------------------------------
function fnValidaCampo(obj, strTipoCampo) {
    if (document.all.Action.value == 1 || document.all.Action.value == 2) {
        var strCampo = obj.value;
        var ok;
        switch (strTipoCampo) {
            case "HoraCompleta":
                ok = isValidHour(strCampo, ':', true);
                break;
            case "HoraParcial":
                ok = isValidHour(strCampo, ':', false);
                break;
            case "Fecha":
                ok = isValidDate(strCampo, '/');
                break;
            default:
                break;
        }

        if (ok == 0) {
            alert("La información de " + strTipoCampo + " no esta capturada correctamente");
            obj.value = "";
        }
    }
}
//------------------------------------------------------------------------------
function fnValidaModelo(pObj) {
    if (isNaN(pObj.value) == false) {
        var num = eval(pObj.value);
        if (num < 1950) {
            alert("El modelo debe ser mayor o igual a 1950");
            pObj.focus();
            return 0;
        }
        var anio = parseInt(new Date().getFullYear()) + 2;
        if (num > anio) {
            alert("El modelo debe ser menor o igual a " + anio);
            pObj.focus();
            return 0;
        }
    } else {
        alert("El campo de modelo debe ser númerico");
        pObj.focus();
        return 0;
    }
    return 1;
}
//------------------------------------------------------------------------------
function fnOrder(iColumn) {
    var rows, switching, i, x, y, shouldSwitch, switchCount = 0, dir,cmpX,cmpY;    var column = 2;    var table = document.getElementById('PW_LST');    if(table == null){
         table = document.getElementById('ObjTable');
         column = 1;
    }    switching = true;    dir = "asc";    while (switching) {        switching = false;
        rows = table.rows;        for (i = column; i < (rows.length - 1); i++) {            shouldSwitch = false;            x = rows[i].getElementsByTagName("TD")[iColumn];
            y = rows[i + 1].getElementsByTagName("TD")[iColumn];            if (x.innerText == '' || isNaN(x.innerText)) {
                cmpX = x.innerText.toLowerCase();
            } else {
                cmpX = parseFloat(x.innerText);
            }            if (y.innerText == '' || isNaN(y.innerText)) {
                cmpY = y.innerText.toLowerCase();
            } else {
                cmpY = parseFloat(y.innerText);
            }            if (dir == "asc") {
                if (cmpX > cmpY) {
                    shouldSwitch = true;
                    break;
                }
            } else if (dir == "desc") {
                if (cmpX < cmpY) {
                    shouldSwitch = true;
                    break;
                }
            }
        }            if (shouldSwitch) {
                rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                switching = true;
                switchCount++;
            } else {
                if (switchCount == 0 && dir == "asc") {
                    dir = "desc";
                    switching = true;
                }
            }
    }
}
//------------------------------------------------------------------------------
function fnBuscaGral(strProc) {
    window.open('FiltroBusquedaGral.jsp?strSQL=' + strProc, 'WinGral', 'resizable=yes,menubar=0,status=0,toolbar=0,height=250,width=700,screenX=50,screenY=50');
}
//------------------------------------------------------------------------------
function fnActualizaLlave(strObject, strValuecl, strValueTxt) {
    document.all[strObject].value = strValuecl;
    document.all[strObject + "V"].value = strValueTxt;
}
//------------------------------------------------------------------------------
function fnLlenaGiros() {
    var strConsulta = "st_GetGiroRedComer " + document.all.clTipoDescuento.value;
    var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
    pstrCadena = pstrCadena + "&strName=clGiroRedC";
    fnOptionxDefault('clGiroRedC', pstrCadena);
}
//------------------------------------------------------------------------------
function fnReplaceScripting(value, id) {
    value = value.replace(/select /gi, "");
    value = value.replace(/insert /gi, "");
    value = value.replace(/ into /gi, "");
    value = value.replace(/values/gi, "");
    value = value.replace(/delete /gi, "");
    value = value.replace(/update /gi, "");
    value = value.replace(/drop /gi, "");
    value = value.replace(/exec /gi, "");
    value = value.replace(/execute /gi, "");
    value = value.replace(/truncate /gi, "");
    //value = value.replace(/alter /gi, ""); //Se comenta por que no estaba guardando el nombre walter, esta validacion no está en Mexico
    value = value.replace(/ table /gi, "");
    value = value.replace(/'/gi, "");
    value = value.replace(/"/gi, "");
    value = value.replace(/</gi, "");
    value = value.replace(/>/gi, "");
    //<<<<<<<<<<<<<<<<< Quitar Numeros de TC >>>>>>>>>>>>>>>>>
    if (id == "NumeroTC" | id == "Clave" | id == "Clabe") {
        document.all[id].value = value;
    } else {
        //<<<<<<<<<<<<<<<< Caso 1:  1234123412341234 >>>>>>>>>>>
        value = value.replace(/(\d{16})/gi, "");
        //<<<<<<<<<<<<<<<< Caso 2:  1234-1234-1234-1234 >>>>>>>>>>>
        value = value.replace(/(\d{4}[\-|\s|\w|\.|\*|\,|\#|\$]\d{4}[\-|\s|\w|\.|\*|\,|\#|\$]\d{4}[\-|\s|\w|\.|\*|\,|\#|\$]\d{4})/gi, "");
        document.all[id].value = value;
    }
}
//------------------------------------------------------------------------------
function fnNewBitacora(pNiveles) {
    var StrNiveles = "";
    for (i = 1; i <= pNiveles; i++) {
        StrNiveles = StrNiveles + "../";    }
    var sStr = "";
    var all = document.getElementsByTagName("*");
    for (var i = 0; i < all.length; i++) {
        if (all[i].id != '') {
            sStr += "[" + all[i].id + " = " + all[i].value + "]" + " ";
        }
    }
    window.open(StrNiveles + 'servlet/Utilerias.EjecutaGuardaBtaView?Contenido=' + sStr, 'WinGral', 'resizable=yes,menubar=0,status=0,toolbar=0,height=1,width=1,screenX=1,screenY=1');
}
//------------------------------------------------------------------------------
function fn_BlinkMuestra() {
    if (!document.all.blink)
        return;
    else {

        for (i = 0; (i < document.all.blink.length); i++) {
            document.all.blink[i].style.visibility = "hidden";
        }
        setTimeout("fn_BlinkOculta()", 500)
    }
}
//------------------------------------------------------------------------------
function fn_BlinkOculta() {
    for (i = 0; (i < document.all.blink.length); i++) {
        document.all.blink[i].style.visibility = "visible";    }
    setTimeout("fn_BlinkMuestra()", 500)
    }
//------------------------------------------------------------------------------
function fnAbrirNuevoEvento(STRclSubservicio) {
    top.Contenido.location.href = "CSSeleccionaServicio.jsp?clSubservicio=" + STRclSubservicio;}
//------------------------------------------------------------------------------
function fnAbrirHistorialNU(clConcierge) {
    window.open('CSAbrirHistorialNU.jsp?clConcierge=' + clConcierge, 'Hist', 'scrollbars=yes,status=yes,width=650,height=300');}
//------------------------------------------------------------------------------
function fnReload() {    location.reload();}
//------------------------------------------------------------------------------
function fnAbrirAsistencia(NombrePaginaWeb, clAsistencia, clConcierge, clSubservicio) {
    top.Contenido.location.href = NombrePaginaWeb + "&clAsistencia=" + clAsistencia + "&clConcierge=" + clConcierge + "&clSubservicio=" + clSubservicio;
}
//------------------------------------------------------------------------------
function fnOrderR(vObjTable, iColumn) {
    strValAct = "";
    strValCmp = "";
    iRowAct = 2;
    iRowCmp = 2;
    var iTR = 0;
    for (iR = 2; iR < vObjTable.rows.length; iR++) {
        iTR = parseInt(iTR) + 1;
        if (iR > 2) {
            try {
                iRowAct = iR;
                iRowCmp = iR;
                strValAct = vObjTable.rows(iRowAct).cells(iColumn).innerHTML;
                strValCmp = vObjTable.rows(iRowCmp - 1).cells(iColumn).innerHTML;
                while ((strValAct < strValCmp) && (iRowCmp > 2)) {
                    iRowCmp -= 1;
                    strValCmp = vObjTable.rows(iRowCmp - 1).cells(iColumn).innerHTML;
                }
                vObjTable.moveRow(iRowAct, iRowCmp);
            } catch (e) {
            }
        }
    }
}
//------------------------------------------------------------------------------
//LLENA EL COMBO PARA DETERMINAR LA FALLA HOGAR
function fnLlenaFalla(){             
    var clUbFallaH = document.all.clUbFallaH.value;
    var clSubServicio = document.all.clSubservicio.value;
    var pstrCadena = '../../servlet/Combos.LlenaFalla?clUbFallaH=' + clUbFallaH + '&clSubServicio=' + clSubServicio;                        
    pstrCadena = pstrCadena + '&strName=clTipoFallaHC';
    fnOptionxDefault('clTipoFallaHC',pstrCadena);
 }
//------------------------------------------------------------------------------            