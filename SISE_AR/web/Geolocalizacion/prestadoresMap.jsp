<%@page contentType="text/html; charset=iso-8859-1" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF,java.util.Enumeration" %>
<!DOCTYPE html>
<%
   boolean bChange = ( request.getParameter("change")!=null   ? request.getParameter("change").equalsIgnoreCase("true"):false );
   String osmid    = ( request.getParameter("osmid")!=null    ? request.getParameter("osmid")    :"" );
   String clPais   = ( request.getParameter("clPais")!=null   ? request.getParameter("clPais")   :"10");
   String clEntFed = ( request.getParameter("clEntFed")!=null ? request.getParameter("clEntFed") :"");
   String codMD    = ( request.getParameter("codMD")!=null    ? request.getParameter("codMD")    :"");
   String dsMunDel = ( request.getParameter("dsMunDel")!=null ? request.getParameter("dsMunDel") :"");
   String tipo     = ( request.getParameter("tipo")!=null     ? request.getParameter("tipo")     :"");
   String id       = ( request.getParameter("id")!=null       ? request.getParameter("id")       :"");
%>
<html>
  <head>
    <meta http-equiv="x-ua-compatible" content="IE=10">
    <script type="text/javascript" src="modernizr-custom.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>    
    <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <!-- title>Maps Manager</title -->
    <meta name="viewport" content="initial-scale=1.0">
    <!--meta charset="utf-8" -->
    <style>
      #map { height: 96%;}
      html, body {height: 96%;margin: 0;padding: 0;}
      .ui-autocomplete-loading {
          background: white url("images/ui-anim_basic_16x16.gif") right center no-repeat;
      }
    </style>
  </head>
  <body>
    <script>
      var map;
      function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
          zoom: 5,
          center: {lat: -32.4691086034951, lng: -65.7325277672206}
        });
        map.data.setStyle({ fillColor: 'red',strokeColor: 'red', strokeWeight: 2});
        map.data.loadGeoJson('trGeoJSON.jsp?osmid=<%=osmid%>');
      }
      function loadGeoJsonString(osmid) {
        map.data.loadGeoJson('trGeoJSON.jsp?osmid='+osmid);
      }
      function zoom(map) {
        //alert ( $('#osmid').val() == 'null' );
        if ( $.trim($('#osmid').val()) != '' && $('#osmid').val() != 'null') { 
            var bounds = new google.maps.LatLngBounds();
            map.data.forEach(function(feature) {
              processPoints(feature.getGeometry(), bounds.extend, bounds);
            });
            map.fitBounds(bounds);
        }
        else {
            alert("SIN GEOREFERENCIAS");
        }
      }
      function processPoints(geometry, callback, thisArg) {
        if (geometry instanceof google.maps.LatLng) {
          callback.call(thisArg, geometry);
        } else if (geometry instanceof google.maps.Data.Point) {
          callback.call(thisArg, geometry.get());
        } else {
          geometry.getArray().forEach(function(g) {
            processPoints(g, callback, thisArg);
          });
        }
      }      
    function Assign() {
        alert("Seguro de asignar?");
        window.close();
    }
    </script>
<script type="text/javascript">
  $( function() {
    $( "#localidad" ).autocomplete({
      minLength: 3,
      select: function( event, ui ) {
          console.log("osmid:" + ui.item.osmid);
          map.data.forEach(function(feature) {
             map.data.remove(feature);
          } );
          if ( ui.item.osmid != null && ui.item.osmid != 'null' ) {
              $("#osmid").val( ui.item.osmid );
              loadGeoJsonString(ui.item.osmid);
              $("#Centrar").removeAttr("disabled");
              $("#assign").removeAttr("disabled");
          }
          else {
              $("#Centrar").attr("disabled", "disabled");
              $("#assign").attr("disabled", "disabled");
          }
      },
      source: function (request, response) {
        //console.log( $('#clEntFed').val() );
        $.ajax({
            url: "getLocalidades.jsp",
            dataType: 'json',
            data: { term: request.term, clEntFed: $('#clEntFed').val() },
            success: function (data) {
                var result;
                if (!data || data.length === 0) {
                    result = [{ label: 'Sin resultados.' }];
                } else { result = data; }
                response(result);
            }
        }); 
    } } 
   );
  } );
function confirmarUpdate() {
  if (confirm("Confirma actualizacion?")) {
    $.ajax({  
        url:'updLocalidad.jsp',  
        type:'post',  
        dataType: 'json',  
        data: { clEntFed: $('#clEntFed').val(), codMD: $('#codMD').val() , osmid: $('#osmid').val(), clUsrApp: $('#clUsrApp').val() },
        success: function(data) {  
            if (data.status == 'OK') {
                alert("Actualizacion correcta");
                window.close();
            }
            else {
                alert("Error: " + data.status );
            }
        },
        error: function(xhr,status,error) {
            alert("error" + status + "|" + error );
        }
    });  
  }
}
</script>    
    <script async defer   src="https://maps.googleapis.com/maps/api/js?key=<%=ar.com.ike.geo.Geolocalizacion.GOOGLE_API_KEY%>&callback=initMap">
    </script>
<br/>
<div>Busqueda:
<input type="hidden" id="clPais"   value="<%=clPais%>">
<input type="hidden" id="osmid"    value="<%=osmid%>">
<input type="hidden" id="codMD"    value="<%=codMD%>">
<input type="hidden" id="dsMunDel" value="<%=dsMunDel%>">
<input type="hidden" id="tipo"     value="<%=tipo%>">
<input type="hidden" id="id"       value="<%=id%>">
<input type="hidden" id="clUsrApp" value="<%=session.getAttribute("clUsrApp")%>">
<%
    String strSql = new String( "st_GEOGetEntFedLike 10, '', 25" );
    ResultSet rs = null;
    rs = UtileriasBDF.rsSQLNP(strSql.toString());
    out.println("<select id='clEntFed'>");
    while (rs.next()) {
        out.println("<option value='" + rs.getString("CodEnt") + "' " + (rs.getString("CodEnt").equals(clEntFed)?"selected":"" ) + " >" + rs.getString("dsEntFed") + "</option >");
    }
    out.println("</select>");
%>
    <input id="localidad" name="Localidad" value="<%=dsMunDel%>" >
    <input type="button" id="Centrar"      value="Centrar"  onclick="zoom(map);return false;" >
    <input type="button" id="assign"   value="Asignar" onclick="confirmarUpdate();return false;" >
</div>
    <div id="map"></div>
  </body>
</html>