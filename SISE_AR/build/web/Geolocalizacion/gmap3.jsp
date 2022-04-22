<%-- 
    Document   : gmap
    Created on : 23/11/2017, 10:25:56
    Author     : ddiez
--%>
<%@page contentType="text/html; charset=UTF-8"  %>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <script type="text/javascript" src="modernizr-custom.js"></script>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>    
        <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script type="text/javascript" src="js/mapUtils.js"></script>
        <style>fieldset {
                    border: 1px solid #000066;
                    width: 99%;
                    height: 50px;
                    background: #ecf2f9;
                    color: #000066;
                    padding: 3px;
                }
                fieldset legend {
                    font-family: Verdana, Arial, Helvetica, sans-serif;
                    font-size: 11px;
                    font-weight: bold;
                    background: #FE7018;
                    color: #FFFFFF;
                    padding: 6px;
                }
                label {
                    font-family: Verdana, Arial, Helvetica, sans-serif;
                    font-size: 11px;
                    font-weight: bold;
                    color: #000066;
                }
        </style>
    </head>
    <body bgcolor="#062f67">
    <%        
    String direccion     = request.getParameter("dire");
    String destDir       = request.getParameter("dDir");
    String destLatLon    = request.getParameter("dLatLon");
    String destLocalidad = request.getParameter("fLoc");
    String destProvincia = request.getParameter("fPro");
    String destCalle     = request.getParameter("fCalle");
    String destCodMD     = request.getParameter("fCodMD");
    String destCodEnt    = request.getParameter("fCodEnt");
    %>
    <div class="row">
        <div class="col-md-12">
            <div>
                <div>
                    <fieldset>
                    <legend>Geolocalizacion</legend>
                        <input id="Provincia" type="text" name="Provincia" value="" style="width:80px;" disabled/>
                        <input id="Localidad" type="text" name="Localidad" value="" style="width:120px;" disabled/>
                        <label for="travelfrom">Dir.
                            <input id="travelfrom" type="text" name="travelfrom" value="" style="width:350px;" />
                        </label>
                        &nbsp;
                        <label for="eCalle">E.C.
                            <input id="eCalle" type="text" name="eCalle" value="" style="width:140px;" />
                        </label>
                        &nbsp;
                        <label for="lat">Lat.
                            <input id="lat" type="text" name="lat" value="" style="width:66px;" onChange="javascript:disableBuscar(false);return false;" />
                        </label>
                        &nbsp;
                        <label for="lon">Long.
                            <input id="lon" type="text" name="lon" value="" style="width:66px;" onChange="javascript:disableBuscar(false);return false;"/>
                        </label>
                        <input type="button" id="Buscar" value="Buscar" onclick="Buscar()" disabled />
                        &nbsp;
                        <input type="button" id="select" value="Ir" onclick="Selection()" disabled />
                        <input id="Calle"     type="hidden" name="Calle" value="" />
                        <input id="CodMD"     type="hidden" name="CodMD" value="" />
                        <input id="CodEnt"    type="hidden" name="CodEnt" value="" />
                </fieldset>
                </div>
                <div>
                    <div id="dvDistance"></div>
                </div>
            </div>
            <div id="dvMap" style="min-height:750px"></div>
        </div>
    </div>
    <script>
        var placeSearch, autocomplete, service;
        var componentForm = {
          street_number: 'short_name',
          route: 'long_name',
          locality:'long_name',
          administrative_area_level_1: 'long_name',
          administrative_area_level_2: 'long_name'
        };

        var source, destination;
        var map;
        var markers = [];
        var selectingFrom = true;
        var geocoder;
        var infowindow;
        var autocomplete;
        
        
        
        function initMap() {
            console.log("gmap3.Version:3.1");
            var myCenter = new google.maps.LatLng(-34.637248,-58.604915);
            geocoder = new google.maps.Geocoder();
            infowindow = new google.maps.InfoWindow;
            var mapCanvas = document.getElementById('dvMap');
            var mapOptions = {center: myCenter, zoom: 11, mapTypeId: google.maps.MapTypeId.ROADMAP, gestureHandling: 'greedy' };
            map = new google.maps.Map( mapCanvas, mapOptions );
            autocomplete = new google.maps.places.Autocomplete( document.getElementById('travelfrom') );
            //autocomplete.bindTo('bounds', map);
            console.log("pase");
            autocomplete.setComponentRestrictions( {'country': ['ar']});
            autocomplete.addListener('place_changed', autocompleteFillIn);
            //google.maps.event.addDomListener(window, 'load', function () {          });
            google.maps.event.addListener(map, "click", mapClickEvent ); 
            service = new google.maps.places.PlacesService(map);
        }
        
        function fillTextBoxes(place) {
            clearMarkers();
            placeMarker(map, place.geometry.location );
            var tmpLat = String( place.geometry.location.lat() );
            var tmpLng = String( place.geometry.location.lng() )
            $('#lat').val( tmpLat.substring(0,9) );
            $('#lon').val( tmpLng.substring(0,9) );
        }
        
        function autocompleteFillIn() {
            //SE LLama desde busqueda por Direccion
            document.getElementById("Localidad").value ="";
            document.getElementById("Provincia").value = "";
            document.getElementById("select").disabled = true;
            fillTextBoxes( autocomplete.getPlace() );
            //Al estar desacoplado de SISE, hay que hacer el insert, en otro caso el insert se hacia desde la plantilla de asistencia
            fillInAddressGeneric(autocomplete.getPlace(),"travelfrom", "LatLong",  "Localidad", "Provincia","CodMD", "CodEnt", true, "select");
            $('#eCalle').val("");
        }

        function mapClickEvent(event) {
            //SE LLama desde busqueda por Click en mapa
            geocoder.geocode({ 'latLng': event.latLng }, function(results, status) {
                document.getElementById("Localidad").value ="";
                document.getElementById("Provincia").value ="";
                document.getElementById("select").disabled = true;
                fillTextBoxes( results[0] );
                //Al estar desacoplado de SISE, hay que hacer el insert, en otro caso el insert se hacia desde la plantilla de asistencia
                  fillInAddressGeneric(results[0],"travelfrom", "LatLong",  "Localidad", "Provincia","CodMD", "CodEnt", true,"select");
            });
        }
        function Selection(){
            var direccion;
            if ( document.getElementById('eCalle').value != '' ) {
                direccion = document.getElementById('travelfrom').value + " y " + document.getElementById('eCalle').value;
            }
            else {
                direccion = document.getElementById('travelfrom').value;
            }
            opener.document.getElementById('<%=destDir%>').value = direccion;
            opener.document.getElementById('<%=destLatLon%>').value =  String(document.getElementById('lat').value).substring(0,9) + ", " + String(document.getElementById('lon').value).substring(0,9);
            opener.document.getElementById('<%=destLocalidad%>').value = document.getElementById("Localidad").value;
            opener.document.getElementById('<%=destProvincia%>').value = document.getElementById("Provincia").value;
            opener.document.getElementById('<%=destCalle%>').value = direccion;
            opener.document.getElementById('<%=destCodMD%>').value = document.getElementById("CodMD").value;
            opener.document.getElementById('<%=destCodEnt%>').value = document.getElementById("CodEnt").value;
            opener.focus();
            //TODO:
            setTimeout(function() {
                window.close(); 
            }, 500);
            
        }
        function Buscar() {
            var latlng =  new google.maps.LatLng(parseFloat(document.getElementById('lat').value),parseFloat(document.getElementById('lon').value));
            getPlace(latlng);
            clearMarkers();
            placeMarker(map, latlng);
        }
        function placeMarker(map, location) {
            map.setCenter(location);
            marker = new google.maps.Marker({
                position: location,
                map: map
            });
            markers.push(marker);
        }
        function setMapOnAll(map) {
          for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(map);
          }
        }
        function clearMarkers() {
          setMapOnAll(null);
        }
        $('#eCalle').keypress(function(e) {
            if (e.which==13) {
                var request = {
                    query:  trimAllChars($('#travelfrom').val(),"'") + ' y '+  trimAllChars($('#eCalle').val(),"'")  ,
                    fields: ['formatted_address', 'name', 'geometry'],
                };
                service.findPlaceFromQuery(request , callback);
            } }
        );
        function callback(results, status) {
          if (status == google.maps.places.PlacesServiceStatus.OK) {
            if (results.length > 0 ) {
              var place = results[0];
              console.log("Callback...");
              console.log(place.formatted_address);
              $('#lat').val(place.geometry.location.lat());
              $('#lon').val(place.geometry.location.lng());
              clearMarkers();
              placeMarker(map, place.geometry.location);
              getPlace(place.geometry.location);
            }
          }
          else {
              console.log("NO ENCONTRADO");
              $('#lat').val("NO ENCONTRADO");
              $('#lon').val("NO ENCONTRADO");
          }
        }

    function getPlace(latlng) {
        //SE LLama desde busqueda por LAT/Long
        document.getElementById("Localidad").value ="";
        document.getElementById("Provincia").value ="";
        document.getElementById("select").disabled = true;
        geocoder.geocode({ 'latLng':latlng }, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            if (results[0]) {
                console.log(results[0]);
                fillInAddressGeneric(results[0],"travelfrom", "LatLong",  "Localidad", "Provincia","CodMD", "CodEnt", true, "select");
            }
        }
    });
    } 
    </script>
    <script async defer src="//maps.googleapis.com/maps/api/js?libraries=places&key=<%=ar.com.ike.geo.Geolocalizacion.GOOGLE_API_KEY%>&callback=initMap&region=AR&language=ES"></script>
</body>
</html>