<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%  String strclUsr = "";
    int tipoSeguimiento = (request.getParameter("tipo")!=null?Integer.parseInt(request.getParameter("tipo")):1);
    if (session.getAttribute("clUsrApp") != null) {
        strclUsr = session.getAttribute("clUsrApp").toString();
    }
    else {
        strclUsr= "5463";
    }%>            
<html>
    <head>
        <title>Asignacion Automatica O Manual</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script type="text/javascript" src="../../Utilerias/jquery.sortElements.js"></script>
        <style>
            .Titulo {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold; color: #000066; text-transform: uppercase; text-align:center;}
        </style>
    </head>
    <body class="cssBody" onload="javascript:cargaAsignaciones();">
        <div align="center">
        <br><br>
        <div id="MsgDefault" >
            Consultando expedientes disponibles para seguimiento, aguarde un instante... 
            <input type="button" name="retry" id="retry" value="Reintentar" onclick="javascript:cargaAsignaciones()">
        </div>
        <div id="DivListado" style="display:none;">
            <div id="titulo"><FONT style="COLOR: #000066" size=4 ;><B>Lista <%=(tipoSeguimiento==1?"Monitoreo":(tipoSeguimiento==2?"Contacto":"Cierre") )%></B></FONT></div><br />            
            <table id="PW_LST" class="Lista" cellspacing='0' width="100%">
                <thead>
                <tr class="Columnas" >
                    <th id="expediente"  style="text-align:center">Expediente</th>
                    <th id="minuto"      style="text-align:center">Minutos</th>
                    <th id="cuenta"      style="text-align:center">Cuenta</th>
                    <th id="proveedor"   style="text-align:center">Proveedor</th>
                    <th id="subservicio" style="text-align:center">Sub Servicio</th>
                    <th id="asigna"      style="text-align:center">Asign&oacute;</th>
                    <th id="provincia"   style="text-align:center">Provincia</th>
                    <th id="localidad"   style="text-align:center">Localidad</th>
                    <th id="fecha"       style="text-align:center">Fecha Apertura</th>
                    <% if (tipoSeguimiento == 3 ) { %>
                    <th id="estado"      style="text-align:center">Estado</th>
                    <% } %>
                    <th style="text-align:center">Acciones</th>
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
    function cargaAsignaciones() {
        $.ajax({
            type: "GET",
            dataType: "json",
            url: "../../api/v1/seguimiento/listaExpASeguir.jsp?tipo=<%=tipoSeguimiento%>",
            crossDomain: false,
            cache: false,
            contentType: 'application/x-www-form-urlencoded; charset=ISO-8859-1',
            success: function(responseData, status, xhr) {
                //console.log(responseData);
                var i = 1;
                $.each(responseData,function(key,expediente){
                    //console.log(expediente);
                    var markup = "<tr class='Contenido" + i +"' onMouseOut='this.className = \"Contenido"+ i +"\"' onMouseOver='this.className = \"ratonEncima\"'>"
                    var divTomar = "none";
                    var divAcciones = "none";
                    var divTomado = "none";
                    if ( expediente.iUsrAppAsignado == -1 ) {
                        divTomar = "block";
                    }
                    else {
                        //SI YO TENGO EL CASO, MOSTRAR ACCIONES.
                        if (expediente.iUsrAppAsignado == <%=strclUsr%> ) {
                            divAcciones="block";
                        }
                        else {
                            divTomado="block";
                        }
                    }
                    var colour = 'cssPlasmaVerde';
                    if (expediente.iMinSinAsignacion > 7 && expediente.iMinSinAsignacion < 11) {
                        colour = 'cssPlasmaAmarillo';
                    }
                    else {
                        if (expediente.iMinSinAsignacion > 10 ) {
                            colour = 'cssPlasmaRojo';
                        }
                    }
                    markup += "<td><b>" + expediente.clExpediente + "</b></td>";
                    markup += "<td><p class=\""+ colour +"\">" + expediente.iMinSinAsignacion + "</p></td>";
                    markup += "<td>" + expediente.sCuenta + "</td>";
                    //markup += "<td><p class=\""+ colour +"\">" + expediente.iMinSinAsignacion + "</p></td>";
                    markup += "<td>" + expediente.sProveedor + "</td>";
                    markup += "<td>" + expediente.sSubServicio + "</td>";
                    markup += "<td>" + expediente.sUsuario + "</td>";

                    markup += "<td>" + expediente.sProvincia + "</td>";
                    markup += "<td>" + expediente.sLocalidad + "</td>";
                    markup += "<td>" + expediente.sFechaApertura + "</td>";
                    if ( 3 == <%=tipoSeguimiento%>  ) {
                    markup += "<td>" + expediente.sEstatus + "</td>";
                    }
                    markup += "<td width=\"120px\"><div id=\"tomar_" + expediente.clExpediente + "\" style=\"display:"+ divTomar +"\"> <a href=\"javascript:fnTomar(" + expediente.clExpediente + ", <%=strclUsr%> );\">TOMAR!</a>";
                    //NO SE PERMITE LIBERAR UN SEGUIMIENTO:
                    //markup += "&nbsp;&nbsp;<a href=\"javascript:fnLiberar(" + expediente.clExpediente + ", <%=strclUsr%> );\">LIBERAR</a> ";
                    markup += "</div>";
                    if (expediente.sEstatus.toUpperCase() == 'MONITOREO') {
                        markup += "<div id=\"acciones_" + expediente.clExpediente + "\" style=\"display:"+ divAcciones +"\"> <a href=\"javascript:fnEnviar('../Seguimiento.jsp?Apartado=S', " + expediente.clExpediente + ", <%=strclUsr%> );\">Monitorear</a></div>";
                    }
                    else if (expediente.sEstatus.toUpperCase() == 'CONTACTO') {
                        markup += "<div id=\"acciones_" + expediente.clExpediente + "\" style=\"display:"+ divAcciones +"\"> <a href=\"javascript:fnEnviar('../Seguimiento.jsp?Apartado=S', " + expediente.clExpediente + ", <%=strclUsr%> );\">Contactar</a></div>";
                    }
                    else if (expediente.sEstatus.toUpperCase() == 'CIERRE') {
                        markup += "<div id=\"acciones_" + expediente.clExpediente + "\" style=\"display:"+ divAcciones +"\"> <a href=\"javascript:fnEnviar('../Seguimiento.jsp?Apartado=S', " + expediente.clExpediente + ", <%=strclUsr%> );\">Cierre PVD</a></div>";
                    }
                    else if (expediente.sEstatus.toUpperCase() == 'FINALIZAR') {
                        markup += "<div id=\"acciones_" + expediente.clExpediente + "\" style=\"display:"+ divAcciones +"\"> <a href=\"javascript:fnEnviar('../Seguimiento.jsp?Apartado=S', " + expediente.clExpediente + ", <%=strclUsr%> );\">Finalizar</a></div>";
                    }
                    markup += "<div id=\"tomado_" + expediente.clExpediente + "\" style=\"display:"+ divTomado +"\" >TOMADO</div></td>";
                    markup += "</tr>";
                    $("#listado").append(markup);
                    i = (i==1?2:1);
                });
                ordenador("#expediente,#minuto,#cuenta,#proveedor,#subservicio,#asigna,#provincia,#localidad,#fecha,#estado","#listado");
                MsgDefault.style.display = "none";
                DivListado.style.display = "block";
            },
            error: function(req, status, error) {
                //console.log(error);
                //console.log(status);
                alert("Error al enviar expediente a la bolsa de asignaciones");
            }
        } )
    }

    function fnTomar(expediente, usuario) {
        //lamar por ajax intentando un lock.
        var datos ={"clExpediente": expediente, "clUsrApp": usuario,"operacion": "LOCK"};
        //console.log(datos);
        $.ajax({
            type: "GET",
            url: "../../api/v1/asignacion/lockExpediente.jsp",
            crossDomain: false,
            cache: false,
            data: datos,
            contentType: 'application/x-www-form-urlencoded; charset=ISO-8859-1',
            success: function(responseData, status, xhr) {
                //console.log("fnTomar:" + datos);
                $( "#tomar_"+expediente ).hide();
                $( "#acciones_"+expediente).show();
                $( "#tomado_"+expediente).hide()
                },
            error: function(responseData, status, xhr) {
                alert("No se pudo tomar el expediente");
                $( "#tomar_"+expediente ).hide();
                $( "#acciones_"+expediente).hide();
                $( "#tomado_"+expediente).show()
                }
            } );
    }

    function fnLiberar(expediente, usuario) {
        //llamar por ajax liberando lock
        var datos ={"clExpediente": expediente, "clUsrApp": usuario,"operacion": "UNLOCK"};
        //console.log(datos);
        $.ajax({
            type: "GET",
            url: "../../api/v1/asignacion/lockExpediente.jsp",
            crossDomain: false,
            cache: false,
            data: datos,
            contentType: 'application/x-www-form-urlencoded; charset=ISO-8859-1',
            success: function(responseData, status, xhr) {
                $( "#tomar_"+expediente ).show();
                $( "#acciones_"+expediente).hide();
            }  } );
    }
    
    function fnEnviar(urlDestino, clExpediente ) {
        var datos ={"clExpediente": clExpediente};
        $.ajax({
            type: "GET",
            url: "../../api/v1/util/setExpedienteEnSession.jsp",
            crossDomain: false,
            cache: false,
            data: datos,
            contentType: 'application/x-www-form-urlencoded; charset=ISO-8859-1',
            success: function(responseData, status, xhr) {
                //location.href= "../KM0/PermiteBsqdaGRoji.jsp?&Apartado=S";
                top.document.all.rightPO.rows = "70,*";
                top.frames['DatosExpediente'].location.reload();
                location.href= urlDestino;
            },
            error: function(responseData, status, xhr) {
                alert("Error, No se pudo asignar el expediente, intente nuevamente");
            }
        } );
    }
</script>
</body>
</html>