<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%  
    String strclUsr = "0";
    if (session.getAttribute("clUsrApp") != null) {
        strclUsr = session.getAttribute("clUsrApp").toString();        }
    if(SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true){
        %><font color="white"  style="font-family:Verdana,Arial,Helvetica,sans-serif; background-color:red;" size=3>LA SESION EXPIRO</font><%  
        strclUsr=null;
        return;
        }
    if (session.getAttribute("clUsrApp") != null) {
        strclUsr = session.getAttribute("clUsrApp").toString();
    }else { strclUsr= "5463";  }%>            
<html>
    <head>
        <title>Listado de Centro de Costos</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>            
        <script type="text/javascript" src="../../Utilerias/jquery.sortElements.js"></script>
        <style>
            .Titulo {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold; color: #000066; text-transform: uppercase; text-align:center;}
        </style>
    </head>
    <body class="cssBody" onload="javascript:cargaCostos();">
        <div align="center">
        <br><br>
        <div id="MsgDefault" >
            Consultando Expedientes para asignacion, Aguarde un instante... 
            <input type="button" name="retry" id="retry" value="Reintentar" onclick="javascript:cargaCostos()">
        </div>
        <div id="DivListado" style="display:none;">
            <div id="titulo"><FONT style="COLOR: #000066" size=4;><B>Conflicto de Costo</B></FONT></div><br />
            <table id="PW_LST" class="Lista" cellspacing='0'>
                <thead>
                <tr class="Columnas"  align="center" >
                    <th id="expediente" style="text-align:center">Expediente</th>
                    <th id="pago" style="text-align:center">Pago Proveedor</th>
                    <th id="cuenta" style="text-align:center">Cuenta</th>
                    <th id="fecha" style="text-align:center">Fecha Apertura</th>
                    <th id="pvd" style="text-align:center">Proveedor</th>
                    <th id="subservicio" style="text-align:center">SubServicio</th>
                    <th id="costo" style="text-align:center">Monto</th>
                    <!--<th id="motivo" style="text-align:center">Motivo</th> ORIGINAL JOA -->
                    <th id="Comentarios" style="text-align:center">Comentarios</th>
                    <th id="accion" style="text-align:center">Accion</th>
                </tr>
                </thead>
                    <tbody id="listado"></tbody>
            </table>                 
        </div>
        <div id="DivResultado" style="display:none;">
            <table id="PW_LST" class="Lista" cellspacing='0'>
                <thead><tr class='Contenido1'><th>Resultado</th><th>Identificacion de Caso</th></thead>
                <tbody id="resultado"></tbody>
            </table>                 
        </div>
    </div>
<script>
//------------------------------------------------------------------------------    
    function cargaCostos() {
        $.ajax({
            type: "GET",
            dataType: "json",
            url: "../../api/v1/ccc/listaRechazos.jsp",
            crossDomain: false,
            cache: false,
            contentType: 'application/x-www-form-urlencoded; charset=ISO-8859-1',
            success: function(responseData, status, xhr) {
                $("#listado tr").remove();
                var i = 1;
                $.each(responseData,function(key,expediente){                    
                    var markup = "<tr class='Contenido" + i +"' onMouseOut='this.className = \"Contenido"+ i +"\"' onMouseOver='this.className = \"ratonEncima\"'>"
                    markup += "<td><b><a href='../DetalleExpediente.jsp?clExpediente=" + expediente.clExpediente + "'> " + expediente.clExpediente + "</a></b></td>";
                    markup += "<td><b>" + expediente.clPagoProveedor + "</b></td>";
                    markup += "<td><b>" + expediente.cuenta + "</b></td>";
                    markup += "<td><b>" + expediente.fecha   + "</b></td>";
                    markup += "<td><b>" + expediente.proveedor + "</b></td>";
                    markup += "<td><b>" + expediente.subServicio + "</b></td>";
                    markup += "<td><b>" + expediente.costo + "</b></td>";
                    //markup += "<td><b>" + expediente.motivo + "</b></td>";   //ORIGINAL JOA
                    markup += "<td><b>" + expediente.comentarios + "</b></td>";
                    markup += "<td>";
                    //Status: 10 -> Modificado a PVD
                    markup += "<input type='button' value='Modificado' onclick='javascript:fnUpdStatus(" + expediente.clPagoProveedor + ", 10);'>";
                    //Status: 7 -> Declinado a PVD            
                    markup += "<input type='button' value='No Modificado' onclick='javascript:fnUpdStatus(" + expediente.clPagoProveedor + ", 7);'>";
                    markup += "</td>";
                    markup += "</tr>";
                    $("#listado").append(markup);
                    i = (i==1?2:1);
                });
                ordenador('#expediente, #pago, #cuenta, #fecha, #pvd, #subservicio, #costo, #accion','#listado');
                MsgDefault.style.display = "none";
                DivListado.style.display = "block";
            },
            error: function(req, status, error) {
                alert("Error al obtener listados de costos de expedientes");
            }
        } )
    }
//------------------------------------------------------------------------------    
    function fnUpdStatus(clPagoProveedor, clEstatus) {
        //Llamar al stored procedure que pone al CxP en estado 3
        // st_validaExpxCC ( expediente, clUsrApp )
        var datos ={"clPagoProveedor": clPagoProveedor, 
                    "clEstatus": clEstatus };
            $.ajax({
                type: "GET",
                url: "../../api/v1/ccc/updEstadoPago.jsp",
                crossDomain: false,
                cache: false,
                data: datos,
                contentType: 'application/x-www-form-urlencoded; charset=ISO-8859-1',
                success: function(responseData, status, xhr) {
                // Si Ok publicacion
                    if (xhr.status == 200 ) {
                        //Reload page
                        //location.reload();
                        cargaCostos();
                    }
                },
                error: function(req, status, error) {
                    // Si No OK
                    //      Mensaje de error
                    alert("Error al enviar expediente a el portal de proveedor");
                }
            } )
        }
//------------------------------------------------------------------------------
</script>
</body>
</html>