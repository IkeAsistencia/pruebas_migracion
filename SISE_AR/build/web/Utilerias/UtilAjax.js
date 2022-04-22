//<<<<<<<<<<<<<<<<< Métodos AJAX >>>>>>>>>>>>>>>>>
/*
      open (método (GET,POST), URL, banderaAsync (true,false), nombreusr, paswword);
      send (contenido);
      abort();
      getAllResponseHeaders(cabecera);
      setRequestHeader(etiqueta, valor);
*/

//<<<<<<<<<<<<<<<<< Propiedades AJAX >>>>>>>>>>>>>>>>>
/*
    status = 404 (Error) o 200 (OK)
    statusText
    responseText  getElementByID
    responseXML   getElementByTagName
    readyState = 0:Sin Iniciar, 1:Cargando, 2:Cargando, 3:Interactivo, 4:Completado
    onreadystatechange
*/


//<<<<<<<<<<<<<<<<<<<<<<<<<<< Llena Input AJAX >>>>>>>>>>>>>>>>>>>>>>>>>
var IdDiv="";

function fnLLenaInput(StrURL, strCadena, StrIdDiv) {
    // <<<<<<<<<<< Creamos el control XMLHttpRequest segun el navegador >>>>>>>>>>
    //<<<<<<<<<<<<< Otro Explorador que no sea Explorer >>>>>>>>>>>>>
    if( window.XMLHttpRequest ){
        ajax = new XMLHttpRequest();
    }
    //<<<<<<<<<<<<< Internet Explorer >>>>>>>>>>>>
    else {
        ajax = new ActiveXObject("Microsoft.XMLHTTP");
    }

    IdDiv = StrIdDiv;
    //<<<<<<<< Se ejecuta una funcion cuando se regresa el request >>>>>>>>
    ajax.onreadystatechange = fnCallback;

    //<<<<<<<<<<<< Codifica los caracteres especiales >>>>>>>>>>>
    //alert(Cadena);
    strCadena = encodeURI(strCadena);
    //alert(Cadena);

    //<<<<<<<<<< Enviamos la petición a la URL de forma asíncrona >>>>>>>>>>
    ajax.open("GET",StrURL+strCadena, false);
    ajax.send("");
}


//<<<<<<<<<<<<<<< Funcion que Devuelve la informacion solicitada >>>>>>>>>>>>
function fnCallback() {
    //<<<<<<<<<<<<<< Comprobamos si la peticion se ha completado (estado 4) >>>>>>>>>>>>>


    if( ajax.readyState == 4 )
    {
        //<<<<<<<<<< Comprobamos si la respuesta ha sido correcta (resultado HTTP 200) >>>>>>>>>>
        if( ajax.status == 200 ){
            //<<<<<<<<<<<Mostramos resultado en la pagina HTML mediante DHTML >>>>>>>>>>>
            //alert(IdDiv);
            //document.getElementById(IdDiv).innerHTML = ajax.responseText;
            document.all[IdDiv].innerHTML = ajax.responseText;
        }
    }
}



function fnEnviaForm(StrURL, StrIdForm) {

    DivLoad.className = 'load-visible';

    // <<<<<<<<<<< Creamos el control XMLHttpRequest segun el navegador >>>>>>>>>>
    //<<<<<<<<<<<<< Otro Explorador que no sea Explorer >>>>>>>>>>>>>
    if( window.XMLHttpRequest ){
        ajaxForm = new XMLHttpRequest();
    }
    //<<<<<<<<<<<<< Internet Explorer >>>>>>>>>>>>
    else {
        ajaxForm = new ActiveXObject("Microsoft.XMLHTTP");
    }



    var Formulario = document.forms[StrIdForm]; //document.getElementById(StrIdForm);

    var cadenaFormulario = "";
    var sepCampos = "";

    for (var i=0; i <= Formulario.elements.length -1;i++) {
        cadenaFormulario += sepCampos+Formulario.elements[i].name+'='+encodeURI(Formulario.elements[i].value);
        sepCampos="&";
    }

    // alert(cadenaFormulario);

    //<<<<<<<< Se ejecuta una funcion cuando se regresa el request >>>>>>>>
    ajaxForm.onreadystatechange = fnCallbackLista;

    //<<<<<<<<<< Enviamos la petición a la URL de forma asíncrona >>>>>>>>>>
    ajaxForm.open("POST",StrURL, true);
    ajaxForm.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=ISO-8859-1');
    ajaxForm.send(cadenaFormulario);
}

function fnCallbackLista (){
    //<<<<<<<<<<<<<< Comprobamos si la peticion se ha completado (estado 4) >>>>>>>>>>>>>
    if( ajaxForm.readyState == 1){
        loading.className = 'loading-visible'; //document.getElementById('loading').className = 'loading-visible';
    }

    if( ajaxForm.readyState == 2){
        loading.className = 'loading-visible';
    }

    if( ajaxForm.readyState == 4 ){
        loading.className = 'loading-invisible'; //document.getElementById('loading').className = 'loading-visible';
        DivLoad.className = 'load-invisible';
        //<<<<<<<<<< Comprobamos si la respuesta ha sido correcta (resultado HTTP 200) >>>>>>>>>>
        if( ajaxForm.status == 200 ){
            //<<<<<<<<<<<Mostramos resultado en la pagina HTML mediante DHTML >>>>>>>>>>>
            //document.getElementById(IdDiv).innerHTML = ajax.responseText;
            //document.all.Lista.innerHTML = ajaxForm.responseText;
            //alert(1);
            window.location.reload();
        }
    }
}

function fnEnviaFormPag(StrURL, StrIdForm) {

    DivLoad.className = 'load-visible';

    // <<<<<<<<<<< Creamos el control XMLHttpRequest segun el navegador >>>>>>>>>>
    //<<<<<<<<<<<<< Otro Explorador que no sea Explorer >>>>>>>>>>>>>
    if( window.XMLHttpRequest ){
        ajaxForm = new XMLHttpRequest();
    }
    //<<<<<<<<<<<<< Internet Explorer >>>>>>>>>>>>
    else {
        ajaxForm = new ActiveXObject("Microsoft.XMLHTTP");
    }



    var Formulario = document.forms[StrIdForm]; //document.getElementById(StrIdForm);

    var cadenaFormulario = "";
    var sepCampos = "";

    for (var i=0; i <= Formulario.elements.length -1;i++) {
        cadenaFormulario += sepCampos+Formulario.elements[i].name+'='+encodeURI(Formulario.elements[i].value);
        sepCampos="&";
    }


    //<<<<<<<< Se ejecuta una funcion cuando se regresa el request >>>>>>>>
    ajaxForm.onreadystatechange = fnCallbackPag;

    //<<<<<<<<<< Enviamos la petición a la URL de forma asíncrona >>>>>>>>>>
    ajaxForm.open("POST",StrURL, true);
    ajaxForm.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=ISO-8859-1');
    ajaxForm.send(cadenaFormulario);
}

function fnCallbackPag (){
    //<<<<<<<<<<<<<< Comprobamos si la peticion se ha completado (estado 4) >>>>>>>>>>>>>
    if( ajaxForm.readyState == 1){
        loading.className = 'loading-visible'; //document.getElementById('loading').className = 'loading-visible';
    }

    if( ajaxForm.readyState == 2){
        loading.className = 'loading-visible';
    }

    if( ajaxForm.readyState == 4 ){
        loading.className = 'loading-invisible'; //document.getElementById('loading').className = 'loading-visible';
        DivLoad.className = 'load-invisible';
        //<<<<<<<<<< Comprobamos si la respuesta ha sido correcta (resultado HTTP 200) >>>>>>>>>>
        if( ajaxForm.status == 200 ){
            //<<<<<<<<<<<Reload de la PaginaWeb >>>>>>>>>>>
            window.location.reload();
        }
    }
}

//<<<<<<<<<<<<<<<<<<<<<<<< Auto Completar >>>>>>>>>>>>>>>>>>>>>>>>>>
function fnAutoCompletado(StrURL, strCadena, StrIdDiv) {
    // <<<<<<<<<<< Creamos el control XMLHttpRequest segun el navegador >>>>>>>>>>
    //<<<<<<<<<<<<< Otro Explorador que no sea Explorer >>>>>>>>>>>>>
    if( window.XMLHttpRequest ){
        ajax = new XMLHttpRequest();
    }
    //<<<<<<<<<<<<< Internet Explorer >>>>>>>>>>>>
    else {
        ajax = new ActiveXObject("Microsoft.XMLHTTP");
    }

    IdDiv = StrIdDiv;
    //<<<<<<<< Se ejecuta una funcion cuando se regresa el request >>>>>>>>
    ajax.onreadystatechange = fnCallback;

    //<<<<<<<<<< Enviamos la petición a la URL de forma asíncrona >>>>>>>>>>
    ajax.open("GET",StrURL+strCadena, false);
    ajax.send("");
}



//<<<<<<<<<<<<<<<<<<<<<<<<<<< Llena Input AJAX con function  >>>>>>>>>>>>>>>>>>>>>>>>>
var StrFnAjax = "";

function fnLLenaInputFn(StrURL, strCadena, StrIdDiv, StrFn) {
    // <<<<<<<<<<< Creamos el control XMLHttpRequest segun el navegador >>>>>>>>>>
    //<<<<<<<<<<<<< Otro Explorador que no sea Explorer >>>>>>>>>>>>>
    if( window.XMLHttpRequest ){
        ajax = new XMLHttpRequest();
    }
    //<<<<<<<<<<<<< Internet Explorer >>>>>>>>>>>>
    else {
        ajax = new ActiveXObject("Microsoft.XMLHTTP");
    }

    IdDiv = StrIdDiv;
    StrFnAjax = StrFn;
    //<<<<<<<< Se ejecuta una funcion cuando se regresa el request >>>>>>>>
    ajax.onreadystatechange = fnCallbackFn;

    //<<<<<<<<<<<< Codifica los caracteres especiales >>>>>>>>>>>
    strCadena = encodeURI(strCadena);

    //<<<<<<<<<< Enviamos la petición a la URL de forma asíncrona >>>>>>>>>>
    ajax.open("GET",StrURL+strCadena, false);
    ajax.send("");
}


//<<<<<<<<<<<<<<< Funcion que Devuelve la informacion solicitada >>>>>>>>>>>>
function fnCallbackFn() {
    //<<<<<<<<<<<<<< Comprobamos si la peticion se ha completado (estado 4) >>>>>>>>>>>>>


    if( ajax.readyState == 4 )
    {
        //<<<<<<<<<< Comprobamos si la respuesta ha sido correcta (resultado HTTP 200) >>>>>>>>>>
        if( ajax.status == 200 ){
            //<<<<<<<<<<<Mostramos resultado en la pagina HTML mediante DHTML y ejecutar una function en js >>>>>>>>>>>
            document.all[IdDiv].innerHTML = ajax.responseText;
            //eval(StrFnAjax);
            window[StrFnAjax]();
        }
    }
}



//<<<<<<<<<<<<<<<<< Funcion para realizar una busqueda >>>>>>>>>>>>>>>>
function fnBusquedaWeb(StrURL, strCadena, StrIdDiv, StrParametros) {
    var Consulta_Parametros= StrParametros;
    Consulta_Parametros=Consulta_Parametros.split(",");

    var StrCadenaConsulta = "";
    var ID_Consulta="";
    var ValorID_Consulta="";

    StrCadenaConsulta = "Parametros="+StrParametros+"&";
    for (i=0; i<Consulta_Parametros.length; i++){
        ID_Consulta=Consulta_Parametros[i];
        ValorID_Consulta=document.all[ID_Consulta].value;
        StrCadenaConsulta = StrCadenaConsulta + ID_Consulta+'='+ValorID_Consulta+'&';

    }

    document.all.DivBusquedaWeb.style.visibility= 'visible';

    // <<<<<<<<<<< Creamos el control XMLHttpRequest segun el navegador >>>>>>>>>>
    //<<<<<<<<<<<<< Otro Explorador que no sea Explorer >>>>>>>>>>>>>
    if( window.XMLHttpRequest ){
        ajax = new XMLHttpRequest();
    }
    //<<<<<<<<<<<<< Internet Explorer >>>>>>>>>>>>
    else {
        ajax = new ActiveXObject("Microsoft.XMLHTTP");
    }

    IdDiv = StrIdDiv;
    //<<<<<<<< Se ejecuta una funcion cuando se regresa el request >>>>>>>>
    ajax.onreadystatechange = fnCallbackBusquedaWeb;


    //<<<<<<<<<<<< Codifica los caracteres especiales >>>>>>>>>>>
    StrCadenaConsulta = encodeURI(StrCadenaConsulta);
    strCadena = encodeURI(strCadena);

    //<<<<<<<<<< Enviamos la petición a la URL de forma asíncrona >>>>>>>>>>
    ajax.open("GET",StrURL+StrCadenaConsulta+strCadena, false);
    ajax.send("");

}

//<<<<<<<<<<<<<<< Funcion que Devuelve la informacion solicitada >>>>>>>>>>>>
function fnCallbackBusquedaWeb() {
    //<<<<<<<<<<<<<< Comprobamos si la peticion se ha completado (estado 4) >>>>>>>>>>>>>

    if( ajax.readyState == 1){
        loading.className = 'loading-visible'; //document.getElementById('loading').className = 'loading-visible';
    }

    if( ajax.readyState == 2){
        loading.className = 'loading-visible';
    }


    if( ajax.readyState == 4 )
    {
        //<<<<<<<<<< Comprobamos si la respuesta ha sido correcta (resultado HTTP 200) >>>>>>>>>>
        if( ajax.status == 200 ){
            //<<<<<<<<<<<Mostramos resultado en la pagina HTML mediante DHTML >>>>>>>>>>>
            //alert(IdDiv);
            //document.getElementById(IdDiv).innerHTML = ajax.responseText;
            document.all[IdDiv].innerHTML = ajax.responseText;

        }
        loading.className = 'loading-invisible';
        DivFondo.className = 'load-visible';
    }
}



//<<<<<<<<<<<<<<<<< Funcion para Autorizacion  >>>>>>>>>>>>>>>>
var StrFnAutAjax = "";
function fnAutorizaWeb(StrURL, strCadena, StrIdDiv, StrParametros, StrFnAut) {
    var Consulta_Parametros= StrParametros;
    Consulta_Parametros=Consulta_Parametros.split(",");

    var StrCadenaConsulta = "";
    var ID_Consulta="";
    var ValorID_Consulta="";

    StrCadenaConsulta = "Parametros="+StrParametros+"&";
    for (i=0; i<Consulta_Parametros.length; i++){
        ID_Consulta=Consulta_Parametros[i];
        ValorID_Consulta=document.all[ID_Consulta].value;
        StrCadenaConsulta = StrCadenaConsulta + ID_Consulta+'='+ValorID_Consulta+'&';

    }
    document.all.DivBusquedaWeb.style.visibility= 'visible';

    // <<<<<<<<<<< Creamos el control XMLHttpRequest segun el navegador >>>>>>>>>>
    //<<<<<<<<<<<<< Otro Explorador que no sea Explorer >>>>>>>>>>>>>
    if( window.XMLHttpRequest ){
        ajax = new XMLHttpRequest();
    }
    //<<<<<<<<<<<<< Internet Explorer >>>>>>>>>>>>
    else {
        ajax = new ActiveXObject("Microsoft.XMLHTTP");
    }

    IdDiv = StrIdDiv;
    StrFnAutAjax = StrFnAut;
    //<<<<<<<< Se ejecuta una funcion cuando se regresa el request >>>>>>>>
    ajax.onreadystatechange = fnCallbackAutorizaWeb;

    //<<<<<<<<<<<< Codifica los caracteres especiales >>>>>>>>>>>
    StrCadenaConsulta = encodeURI(StrCadenaConsulta);
    strCadena = encodeURI(strCadena);

    //<<<<<<<<<< Enviamos la petición a la URL de forma asíncrona >>>>>>>>>>
    ajax.open("GET",StrURL+StrCadenaConsulta+strCadena, false);
    ajax.send("");

}

//<<<<<<<<<<<<<<< Funcion que Devuelve la informacion solicitada >>>>>>>>>>>>
function fnCallbackAutorizaWeb() {
    //<<<<<<<<<<<<<< Comprobamos si la peticion se ha completado (estado 4) >>>>>>>>>>>>>

    if( ajax.readyState == 1){
        loading.className = 'loading-visible';
    }

    if( ajax.readyState == 2){
        loading.className = 'loading-visible';
    }


    if( ajax.readyState == 4 )
    {
        //<<<<<<<<<< Comprobamos si la respuesta ha sido correcta (resultado HTTP 200) >>>>>>>>>>
        if( ajax.status == 200 ){
            //<<<<<<<<<<<Mostramos resultado en la pagina HTML mediante DHTML >>>>>>>>>>>
            document.all[IdDiv].innerHTML = ajax.responseText;
            window[StrFnAutAjax]();

        }
        //loading.className = 'loading-invisible';
        DivFondo.className = 'load-visible';
    }
}




//<<<<<<<<<<<<<<<<< Funcion para Campos Obligatoris  >>>>>>>>>>>>>>>>
function fnCamposObligatorios(StrURL, strCadena, StrIdDiv) {
    document.all.DivCamposObligatorios.style.visibility= 'visible';

    // <<<<<<<<<<< Creamos el control XMLHttpRequest segun el navegador >>>>>>>>>>
    //<<<<<<<<<<<<< Otro Explorador que no sea Explorer >>>>>>>>>>>>>
    if( window.XMLHttpRequest ){
        ajax = new XMLHttpRequest();
    }
    //<<<<<<<<<<<<< Internet Explorer >>>>>>>>>>>>
    else {
        ajax = new ActiveXObject("Microsoft.XMLHTTP");
    }

    IdDiv = StrIdDiv;
    //<<<<<<<< Se ejecuta una funcion cuando se regresa el request >>>>>>>>
    ajax.onreadystatechange = fnCallbackCamposObligatorios;

    //<<<<<<<<<<<< Codifica los caracteres especiales >>>>>>>>>>>
    strCadena = encodeURI(strCadena);

    //<<<<<<<<<< Enviamos la petición a la URL de forma asíncrona >>>>>>>>>>
    ajax.open("GET",StrURL+strCadena, false);
    ajax.send("");

}

//<<<<<<<<<<<<<<< Funcion que Devuelve la informacion solicitada >>>>>>>>>>>>
function fnCallbackCamposObligatorios() {
    //<<<<<<<<<<<<<< Comprobamos si la peticion se ha completado (estado 4) >>>>>>>>>>>>>
    if( ajax.readyState == 1){
        loading.className = 'loading-visible';
    }
    if( ajax.readyState == 2){
        loading.className = 'loading-visible';
    }
    if( ajax.readyState == 4 ){
        //<<<<<<<<<< Comprobamos si la respuesta ha sido correcta (resultado HTTP 200) >>>>>>>>>>
        if( ajax.status == 200 ){
            //<<<<<<<<<<<Mostramos resultado en la pagina HTML mediante DHTML >>>>>>>>>>>
            document.all[IdDiv].innerHTML = ajax.responseText;
        }
        loading.className = 'loading-invisible';
        DivFondo.className = 'load-visible';
    }
}









