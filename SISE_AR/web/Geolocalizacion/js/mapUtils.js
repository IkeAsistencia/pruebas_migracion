/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor. 
 *
 */
 $.ajaxSetup({
  type: 'POST',
  dataType: "json",
  contentType: "application/x-www-form-urlencoded; charset=UTF-8"
});

function startsWith(str, pat) {
    return str.toUpperCase().indexOf(pat) === 0; 
}
function disableBuscar( value ) {
    document.getElementById("Buscar").disabled =  value;
}

function countChars(str, char){
    //retorna cantidad del caracter especificado
        return str.split(char).length-1;
    }
function trimAllChars(str){
    //elimina todos los chars que sean iguales al carater especificado
    var cantElements = countChars(str,"'");
    //console.log(cantElements);
    for (var i = 0; i < cantElements ; i++) {
        str = str.replace("'", " ");
        //console.log(str);
    }
    return str;
    }

var geoHelper = {
    OSMLevels: function(latitude, longitude, altaEnBase ) {
        return $.ajax({
            url: "/SISE_AR/Geolocalizacion/reverseGeo.jsp",
            data: { format:'json', lat: latitude , lon: longitude }     });
    },
    parseOSMLevels: function(latitude, longitude, altaEnBase) {
        return this.OSMLevels(latitude, longitude, altaEnBase).then( function(data) {
            var prov = data.parents[4][0];
            var loca = "";
            if ( prov === 'Ciudad Autónoma de Buenos Aires' || prov === 'CABA') {
                prov = "CAPITAL FEDERAL";
                loca = data.parents[9][0];
            }
            else {
                if ( !data.parents[8] ) {
                    if (!data.parents[9]) {
                        if (!data.parents[5]) {
                            console.log("NO SE PUDO OBTENER LOCALIDAD DESDE OSM");
                            loca = "";
                        }
                        else loca = data.parents[5][0];
                    }
                    else loca = data.parents[9][0];
                }
                else loca = data.parents[8][0];
            }
            return { provincia: prov, localidad: loca };
        });
    },
    getSISECodByOSM: function(latitude, longitude, altaEnBase) {
        
        return this.parseOSMLevels(latitude, longitude, altaEnBase).then( function( data ) {
           
            //console.log('getSISECodByOSM' + data.localidad );
            return $.ajax({
                url: "/SISE_AR/Geolocalizacion/getCodsByDS.jsp",
                data: { dsEntFed: data.provincia , dsMunDel: data.localidad, source:'OSM', altaEnBase: altaEnBase }
            });
        });
    },
    getSISECodByGMap: function(provincia, localidad, altaEnBase)  {
        //console.log('getSISECodByGMap:' + localidad );
        return $.ajax({
            url: "/SISE_AR/Geolocalizacion/getCodsByDS.jsp",
            data: { dsEntFed: provincia , dsMunDel: localidad, source:'GMAP', altaEnBase: altaEnBase}
        });
    }
};

function enableIrBtn(entFed, munDel, IrBtn) {
    console.log("enable IrBtn:" + entFed + "::"+  munDel);
    if (IrBtn !== null) {                  
        console.log("Localidad:" + $('#' + munDel ).val() );        
        if ( $('#' + entFed ).val() !== "" && $('#' + munDel ).val() !== "" ) {
            document.getElementById(IrBtn).disabled = false;
            console.log("IR Habilitado");
        }
        else {
            document.getElementById(IrBtn).disabled = true;
            console.log("IR NO Habilitado");
        }
    }
}

function fillInAddressGeneric(place, calleNum, latLong, munDel, entFed, codMD, codEnt, altaEnBase) {
    fillInAddressGeneric(place, calleNum, latLong, munDel, entFed, codMD, codEnt, altaEnBase, null);
}

function fillInAddressGeneric(place, calleNum, latLong, munDel, entFed, codMD, codEnt, altaEnBase, IrBtn) {
    altaEnBase = typeof altaEnBase !== 'undefined' ? altaEnBase : true;
    console.log("AltaEnBase: " + String(altaEnBase) );
    console.log(place);
    var lat = place.geometry.location.lat().toString();
    var lon = place.geometry.location.lng().toString();
    var prov=""; var addrName=""; var addrNameLong=""; var addrNumb="";  
    var loca=""; var tmpLoca="";  var political="";    var fullAddrs="";
    
        
    
    for (var i = 0; i < place.address_components.length; i++) {
        var addressType = place.address_components[i].types[0];
        var val = trimAllChars(place.address_components[i]['short_name']);
        if (addressType === 'route') { 
            addrName = val;
        
            addrNameLong=trimAllChars( place.address_components[i]['long_name']);      
        }
        else if (addressType === 'street_number' ) addrNumb=val;
        else if (addressType === 'locality') { loca=val; }        //console.log("locality"+val);  
        else if (addressType === 'political') { political=val; }  //console.log("political"+val);  
        else if (addressType === 'vicinity' ) { political=  val; }  //console.log("vicinity"+val);  
        else if (addressType === 'administrative_area_level_1') prov=val; 
        else if (addressType === 'administrative_area_level_2') { tmpLoca = val; } //console.log("admin_area1"+val); 
        else if (addressType === 'sublocality_level_1') { political = val; }//console.log("sublocality1" + val); 
        if ( prov === 'CABA' || loca === 'CABA') loca = political;
        if ( loca === '' ) loca = tmpLoca;
        if ( startsWith(addrName, 'RN') || startsWith(addrName,"RP") || startsWith(addrName,"RM")) addrName = addrNameLong;
        if ( startsWith(addrName, 'UNNAMED'))  addrName = 'Camino Sin Nombre';
    }
    $('#' + calleNum).val( addrName + " " + addrNumb );
    $('#' + latLong ).val( lat.substring(0,9) + ", " + lon.substring(0,9));


    if (prov === "" || (loca === "" || loca.length <= '3')  ) {
        
        geoHelper.getSISECodByOSM(lat,lon, altaEnBase).done(function(data) {

            $('#' + entFed ).val( data[0].dsEntFed );
            $('#' + munDel ).val( data[0].dsMunDel );
            $('#' + codEnt ).val( data[0].codEndFed );
            $('#' + codMD ).val(  data[0].codMunDel );
             
            enableIrBtn(entFed, munDel, IrBtn);
        } );
    }
    else {
        prov = prov.toUpperCase();
        //console.log(prov);
        loca = loca.toUpperCase();
        geoHelper.getSISECodByGMap(prov, loca, altaEnBase).done( function(data) {
    
            $('#' + entFed ).val( data[0].dsEntFed.toUpperCase() );
            $('#' + munDel ).val( data[0].dsMunDel.toUpperCase() );
            $('#' + codEnt ).val( data[0].codEndFed.toUpperCase() );
            $('#' + codMD ).val(  data[0].codMunDel.toUpperCase() );

            enableIrBtn(entFed, munDel, IrBtn);
        });
    }
}
