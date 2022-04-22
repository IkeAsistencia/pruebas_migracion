<%-- 
    Document   : showMap
    Created on : oct 11, 2017, 5:52:59 p.m.
    Author     : ddiez
--%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Búsqueda demo</title>
        <!-- Este css tengo que ponerlo porque con la version nueva no muestra el hover del autocomplete correctamente -->
        <link href="js/css/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
        <link href="js/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="js/jquery.js"></script>
        <script type="text/javascript" src="js/jquery-ui.min.js"></script>
        <script type='text/javascript' src='js/jquery.mcautocomplete.js'></script>
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.2.0/dist/leaflet.css"
           integrity="sha512-M2wvCLH6DSRazYeZRIm1JnYyh22purTM+FDB5CsyxtQJYeKq83arPe5wgbNmcFXGqiSH2XR8dT/fJISVA1r/zQ=="
           crossorigin="" />
        <script src="https://unpkg.com/leaflet@1.2.0/dist/leaflet.js"></script>
        <style>
            .map {
                height: 600px;
                width: 200px;
                z-index: 0;
            }
        </style>
        <!--
        <script src="https://openlayers.org/en/v4.3.2/build/ol.js" type="text/javascript"></script>
        -->
    </head>
    <body>
        <div id="map" class="map" style="float:right;width:60%;height:600px;"></div>
        <script type="text/javascript">
            var map = L.map('map', 
                            {drawControl: true}).setView([-36.00, -58.00], 13);
            L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
            }).addTo(map);
            var myLayer = L.geoJSON().addTo(map);
            //myLayer.addData(geojsonFeature);
        </script>
            <div class="ui-block-b">
            </div>
        </div>
        <script>
            function update_map_loc(parent_osm_id) {
                $.ajax({
                    url: '/geo/get_gjson',
                    dataType: 'json', //Si lo llamamos desde otro dominio cambiarlo por jsonp
                    data: {
                        parent_osm_id: parent_osm_id
                    },
                    success: function (data) {
                        console.log(data);
                        if (!data || data.length === 0) {
                            myLayer.clearLayers();
                        } else {
                            myLayer.clearLayers();
                            myLayer.addData(data);
                            map.fitBounds(myLayer.getBounds(),{maxZoom:12});
                        }
                    }
                });
            };
        </script>
    </body>
</html>
