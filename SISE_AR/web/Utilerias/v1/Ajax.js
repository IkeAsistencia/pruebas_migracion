/* 
 * @autor Jesus Moreno velasco
 * 
 */
var json_parse = (function () {
    "use strict";
    var at;     // The index of the current character
    var ch;     // The current character
    var escapee = {   "\"": "\"",
        "\\": "\\",   "/": "/",
        b: "\b",    f: "\f",
        n: "\n",    r: "\r",
        t: "\t"    };
    var text;
    var error = function (m) {
        throw {     name: "SyntaxError",
            message: m,  at: at,  text: text
        };
    };
    var next = function (c) {
        if (c && c !== ch) {
            error("Expected '" + c + "' instead of '" + ch + "'");
        }
        ch = text.charAt(at);
        at += 1;
        return ch;
    };
    var number = function () {
        var value;
        var string = "";
        if (ch === "-") {
            string = "-";
            next("-");
        }
        while (ch >= "0" && ch <= "9") {
            string += ch;
            next();
        }
        if (ch === ".") {
            string += ".";
            while (next() && ch >= "0" && ch <= "9") {
                string += ch;
            }
        }
        if (ch === "e" || ch === "E") {
            string += ch;
            next();
            if (ch === "-" || ch === "+") {
                string += ch;
                next();
            }
            while (ch >= "0" && ch <= "9") {
                string += ch;
                next();
            }
        }
        value = +string;
        if (!isFinite(value)) {
            error("Bad number");
        } else {
            return value;
        }
    };

    var string = function () {
        var hex;
        var i;
        var value = "";
        var uffff;
        if (ch === "\"") {
            while (next()) {
                if (ch === "\"") {
                    next();
                    return value;
                }
                if (ch === "\\") {
                    next();
                    if (ch === "u") {
                        uffff = 0;
                        for (i = 0; i < 4; i += 1) {
                            hex = parseInt(next(), 16);
                            if (!isFinite(hex)) {
                                break;
                            }
                            uffff = uffff * 16 + hex;
                        }
                        value += String.fromCharCode(uffff);
                    } else if (typeof escapee[ch] === "string") {
                        value += escapee[ch];
                    } else {
                        break;
                    }
                } else {
                    value += ch;
                }
            }
        }
        error("Bad string");
    };
    var white = function () {
        while (ch && ch <= " ") {
            next();
        }
    };

    var word = function () {
        switch (ch) {
        case "t":
            next("t");
            next("r");
            next("u");
            next("e");
            return true;
        case "f":
            next("f");
            next("a");
            next("l");
            next("s");
            next("e");
            return false;
        case "n":
            next("n");
            next("u");
            next("l");
            next("l");
            return null;
        }
        error("Unexpected '" + ch + "'");
    };
    var value;  // Place holder for the value function.
    var array = function () {
        var arr = [];
        if (ch === "[") {
            next("[");
            white();
            if (ch === "]") {
                next("]");
                return arr;   // empty array
            }
            while (ch) {
                arr.push(value());
                white();
                if (ch === "]") {
                    next("]");
                    return arr;
                }
                next(",");
                white();
            }
        }
        error("Bad array");
    };
    var object = function () {
        var key;
        var obj = {};
        if (ch === "{") {
            next("{");
            white();
            if (ch === "}") {
                next("}");
                return obj;   // empty object
            }
            while (ch) {
                key = string();
                white();
                next(":");
                if (Object.hasOwnProperty.call(obj, key)) {
                    error("Duplicate key '" + key + "'");
                }
                obj[key] = value();
                white();
                if (ch === "}") {
                    next("}");
                    return obj;
                }
                next(",");
                white();
            }
        }
        error("Bad object");
    };

    value = function () {
        white();
        switch (ch) {
        case "{":
            return object();
        case "[":
            return array();
        case "\"":
            return string();
        case "-":
            return number();
        default:
            return (ch >= "0" && ch <= "9")
                ? number()
                : word();
        }
    };
    return function (source, reviver) {
        var result;
        text = source;
        at = 0;
        ch = " ";
        result = value();
        white();
        if (ch) {
            error("Syntax error");
        }
        return (typeof reviver === "function")
            ? (function walk(holder, key) {
                var k;
                var v;
                var val = holder[key];
                if (val && typeof val === "object") {
                    for (k in val) {
                        if (Object.prototype.hasOwnProperty.call(val, k)) {
                            v = walk(val, k);
                            if (v !== undefined) {
                                val[k] = v;
                            } else {
                                delete val[k];
                            }
                        }
                    }
                }
                return reviver.call(holder, key, val);
            }({"": result}, ""))
            : result;
    };
}());

Object.prototype.extend = function(obj) {
   for (var i in obj) {
      if (obj.hasOwnProperty(i)) {
         this[i] = obj[i];
      }
   }
};
function ajaxRequest(datos,_callbackComplete,_callbackFail){
    if(!datos){
        alert("Debe configurar los datos de la petición.");
        return false;
    }
    var attr={
        url:"servlet/Utilerias.AjaxProcess",
        datos:null,
        contentType:"text/html; charset=utf-8",
        metodo:"POST",
        async:true,
        param:[],
        sql:"",
        component:"json", //string,table,combobox,html
        responsive:false,
        dinamicIDTable:"ObjTable",
        nivel:'../../'
    };
    attr.extend(datos);
    var xmlHttpfn;
    try{
        xmlHttpfn=new XMLHttpRequest();// Firefox, Opera 8.0+, Safari
    } catch (e) {
        try{
            xmlHttpfn=new ActiveXObject("Microsoft.XMLHTTP");
        } catch (e){
            try{
                 xmlHttpfn=new ActiveXObject("Msxml2.XMLHTTP"); // Internet Explorer
            } catch (e){
                alert("No AJAX!?");
                return false;
                }
            }
        }
        // Se ejecuta una funcion cuando se regresa el request 
        xmlHttpfn.onreadystatechange = function(){
            if(xmlHttpfn.readyState == 4) {
                if(xmlHttpfn.status == 200) {
                    if(_callbackComplete){
                        if (attr.component=="json" || attr.component=="combobox"){
                            var jsonRes={};
                            try{
                               jsonRes=json_parse(xmlHttpfn.responseText);
                            }catch(exjson){
                                console.log("error parse json");
                            }
                            _callbackComplete(jsonRes);
                        }else{
                            _callbackComplete(xmlHttpfn.responseText);
                        }
                    }
                 }else {
                    alert("Error en la peticion status["+xmlHttpfn.status+"]");
                    if(_callbackFail){
                         _callbackFail();
                    }
                 }
            }
        };
    xmlHttpfn.open(attr.metodo,attr.nivel+attr.url,attr.async);
    xmlHttpfn.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    if(attr.param.length===1){
        console.log(attr.param[0].toString().split("','"));
        attr.param=attr.param[0].toString().split("','");
    }
    xmlHttpfn.send("_=" + new Date().getTime()+"&dinamicIDTable="+attr.dinamicIDTable+"&responsive="+attr.responsive+"&param="+encodeURIComponent(escape(fnReplaceScriptingAjaxProcces( attr.param.join("|") )) )+"&sql="+attr.sql+"&component="+attr.component);
}

function createDinamicCoboBox(data,idElement,defaultSelection){
    var select=document.getElementById(idElement);
    select.options.length = 0;
    var option = document.createElement('option');
    option.setAttribute('value','');
    option.appendChild(document.createTextNode('--SELECIONE OPCIÃ“N--'));
    select.appendChild(option);
    for (var i=0; i < data.length; i += 1) {
        var option = document.createElement('option');
        if(defaultSelection && defaultSelection==data[i].value){
            option.selected=true;
        }
        option.setAttribute('value', data[i].value);
        option.appendChild(document.createTextNode(data[i].text));
        select.appendChild(option);
    }
}
function fnOrder(vObjTable, iColumn){
    var strValAct="";
    var strValCmp="";
    var iRowAct=1;
    var iRowCmp=1;
    for (var iR=1; iR < vObjTable.rows.length; iR++) {
        if (iR>1){
            iRowAct = iR;
            iRowCmp = iR;
            strValAct = vObjTable.rows(iRowAct).cells(iColumn).innerHTML;            
            strValCmp = vObjTable.rows(iRowCmp-1).cells(iColumn).innerHTML
            while((strValAct < strValCmp) && (iRowCmp>1)){
                iRowCmp-=1;                
                strValCmp = vObjTable.rows(iRowCmp-1).cells(iColumn).innerHTML
            }
            vObjTable.moveRow(iRowAct,iRowCmp);
        }
    }
}

function fnEncodeUriStr(url){
    return encodeURI(url);
}
function toUTF8ArrayWs(str) {
    try{
        return decodeURIComponent(escape(str));
    }catch(e)
    {
        return str;
    }
}


function fnReplaceScriptingAjaxProcces(value){
                value = value.replace(/select /gi,"");
                value = value.replace(/ select /gi,"");
                value = value.replace(/insert /gi,"");
                value = value.replace(/ insert /gi,"");
                value = value.replace(/ into /gi,"");
                value = value.replace(/ values /gi,"");
                value = value.replace(/delete /gi,"");
                value = value.replace(/ delete /gi,"");
                value = value.replace(/update /gi,"");
                value = value.replace(/ update /gi,"");
                value = value.replace(/drop /gi,"");
                value = value.replace(/ drop /gi,"");
                value = value.replace(/exec /gi,"");
                value = value.replace(/ exec /gi,"");
                value = value.replace(/execute /gi,"");
                value = value.replace(/ execute /gi,"");
                value = value.replace(/truncate /gi,"");
                value = value.replace(/ truncate /gi,"");
                value = value.replace(/ set /gi,"");
                value = value.replace(/ or /gi,"");
                value = value.replace(/ and /gi,"");
                value = value.replace(/javascript/gi,"");
                value = value.replace(/create /gi,"");
                value = value.replace(/ create /gi,"");
                value = value.replace(/procedure /gi,"");
                value = value.replace(/ procedure /gi,"");
                value = value.replace(/declare /gi,"");
                value = value.replace(/ declare /gi,"");
//                value = value.replace(/'/gi,"");
//                value = value.replace(/"/gi,"");
                value = value.replace(/</gi,"");
                value = value.replace(/>/gi,"");
                return value;
    }