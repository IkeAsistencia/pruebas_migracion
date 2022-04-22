<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xml:lang="en" xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <script type="text/javascript"    src="//code.jquery.com/jquery-1.12.4.js"></script>
  <link rel="stylesheet" type="text/css" href="/css/normalize.css" />
  <link rel="stylesheet" type="text/css" href="/css/result-light.css" />
  <script type="text/javascript" src="../../Utilerias/jquery.sortElements.js"></script>
  <style id="compiled-css" type="text/css">
      td, th { border: 1px solid #111; padding: 6px; }
        th { font-weight: 700; }
  </style>
</head>
<body>
    <input type="button" onclick="javascript:cargaCostos();" value="Cargar" />
    <table><thead>
    <tr>
        <th id="expediente_header">Expediente</th>
        <th id="cuenta_header">Cuenta</th>
        <th id="fecha_header">Fecha</th>
        <th id="pvd_header">Proveedor</th>
    </tr>
        </thead>
        <tbody id="listado">
    </table>
    
    <script>
        function cargaCostos() {
        $.ajax({
            type: "GET",
            dataType: "json",
            url: "../../api/v1/ccc/listaCostos.jsp",
            crossDomain: false,
            cache: false,
            contentType: 'application/x-www-form-urlencoded; charset=ISO-8859-1',
            success: function(responseData, status, xhr) {
                var i = 1;
                $.each(responseData,function(key,expediente){
                    markup = "<tr>";
                    markup += "<td><b>" + expediente.clExpediente + "</b></td>";
                    markup += "<td><b>" + expediente.cuenta + "</b></td>";
                    markup += "<td><b>" + expediente.fecha   + "</b></td>";
                    markup += "<td><b>" + expediente.proveedor + "</b></td>";
                    markup += "</tr>";
                    $("#listado").append(markup);
                    i = (i==1?2:1);
                });
                ordenador('#expediente_header,#cuenta_header, #fecha_header, #pvd_header','#listado')
            },
            error: function(req, status, error) {
                alert("Error al obtener listados de costos de expedientes");
            }
        } )
    }
        
        
        
    </script>
    
</body>
</html>
