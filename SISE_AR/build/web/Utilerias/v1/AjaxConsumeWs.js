/* 
 * @autor Jesus Moreno velasco
 * 
 */
var json_parseWS = (function () {
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
function ajaxRequestWS(datos,_callbackComplete,_callbackFail){
    if(!datos){
        console.log("debe de configurar los datos de la petision.");
        return false;
    }
    var attr={
        urlServlet:"servlet/Utilerias.AjaxConsumeWSRest",
        datos:null,
        contentType:"text/html; charset=utf-8",
        metodoServlet:"GET",
        async:true,
        url:"",
        json:"", //string,table,combobox,html
        method:"",
        nivel:'../../'
    };
    attr.extend(datos);
    var xmlHttpfn;
    if(window.XMLHttpRequest){
        xmlHttpfn=new XMLHttpRequest();// Firefox, Opera 8.0+, Safari
    }else{
        try{
            xmlHttpfn=new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e){
            try{
                 xmlHttpfn=new ActiveXObject("Microsoft.XMLHTTP"); // Internet Explorer
            } catch (e){
                console.log("No AJAX!?");
                return false;
                }
            }
        }
//        xmlHttpfn.setRequestHeader('Content-Length', '64'),
        // Se ejecuta una funcion cuando se regresa el request 
//        xmlHttpfn.setRequestHeader("Content-type", "text/html");
        xmlHttpfn.onreadystatechange = function(){
            if(xmlHttpfn.readyState == 4) {
                if(xmlHttpfn.status == 200) {
                    if(_callbackComplete){
//                        if (attr.component=="json" || attr.component=="combobox"){
                            var jsonRes={};
                            try{
                               jsonRes=json_parseWS(xmlHttpfn.responseText);
                            }catch(exjson){
                                console.log("error parse json");
                            }
                            _callbackComplete(jsonRes);
//                        }
//                        else{
//                            _callbackComplete(xmlHttpfn.responseText);
//                        }
                    }
                 }else {
                    console.log("Error en la peticion status["+xmlHttpfn.status+"]");
                    console.log(xmlHttpfn);
                    if(_callbackFail){
                         _callbackFail();
                    }
                 }
            }
        };
    var myDateWS = new Date();//evita COOKIES
    xmlHttpfn.open(attr.metodoServlet,
    attr.nivel+attr.urlServlet+"?myDateWS="+myDateWS.getTime()+"&method="+attr.method+"&json="+fnEncodeUriStrWservice(attr.json)+"&url="+fnEncodeUriStrWservice(attr.url),true);
    xmlHttpfn.send();

}
function converUtcDate(date1){
    var dateFin = new Date(Date.UTC(date1.substring(0, 4), date1.substring(5, 7), date1.substring(8, 10), date1.substring(11, 13), date1.substring(14, 16), date1.substring(17, 19) ));
    var hora=dateFin.getHours().length == 1 ? '0' + dateFin.getHours() : dateFin.getHours();
    var minutos=dateFin.getMinutes().length==1 ? '0' + dateFin.getMinutes() : dateFin.getMinutes();
    var segundos=dateFin.getSeconds().length==1 ? '0' + dateFin.getSeconds() : dateFin.getSeconds();
    return  date1.substring(0, 10)+" "+hora+":"+minutos+":"+segundos;
}
function fnEncodeUriStrWservice(url){
    return encodeURI(url);
}
