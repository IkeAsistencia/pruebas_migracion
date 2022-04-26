<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%  String strclUsr = "";
    if (session.getAttribute("clUsrApp") != null) {
        strclUsr = session.getAttribute("clUsrApp").toString();
    }
    if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true) {
        out.println("<B>Fuera de Horario</B>");
        strclUsr = null;
        return;
    }
    String clGrupoCuenta = ( request.getParameter("grupoCuenta") != null ? request.getParameter("grupoCuenta") : "0");
%>            
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
    <body class="cssBody" onload="javascript:cargaAsignaciones(<%=clGrupoCuenta%>);">
        <div align="center">
        <br><br>
        <div id="MsgDefault" >
            Consultando Expedientes para asignacion, Aguarde un instante... 
            <input type="button" name="retry" id="retry" value="Reintentar" onclick="javascript:cargaAsignaciones(<%=clGrupoCuenta%>)">
        </div>
        <div id="DivListado" style="display:none;">
            <div id="titulo"><FONT style="COLOR: #000066" size=4 ;><B>Expedientes para Asignaci&oacute;n</B></FONT></div><br />
            <table id="PW_LST" class="Lista" cellspacing='0'>
                <thead>
                <tr class="Columnas"  align="center" >
                    <th id="expediente"  style="text-align:center">Expediente</th>
                    <th id="tiempo"      style="text-align:center">Tiempo Sin <br/> Asignaci&oacute;n</th>
                    <th id="fecha"       style="text-align:center">Fecha Apertura</th>
                    <!--th id="hora"        style="text-align:center">Hora Apertura</th -->
                    <th id="cuenta"      style="text-align:center">Cuenta</th>
                    <th id="subservicio" style="text-align:center">SubServicio</th>
                    <th id="localidad"   style="text-align:center">Localidad</th>
                    <th id="destino"     style="text-align:center">Destino</th>
                    <th id="usuario"     style="text-align:center">Usuario / Coordinador</th>
                    <th id="tomador"     style="text-align:center">Tomado por</th>
                    <th id="" style="text-align:center">Acciones</th>
                    <th id="servicio"    Style="text-align:center">Servicio</th>
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
    function cargaAsignaciones( clGrupoCuenta ) {
        $.ajax({
            type: "GET",
            dataType: "json",
            url: "../../api/v1/asignacion/listaExpAAsignar.jsp?grupoCuenta=" + clGrupoCuenta,
            crossDomain: false,
            cache: false,
            contentType: 'application/x-www-form-urlencoded; charset=ISO-8859-1',
            success: function(responseData, status, xhr) {
                //console.log(responseData);
                var i = 1;
                $.each(responseData,function(key,expediente){
                    //console.log(expediente.clExpediente);
                    var markup = "<tr class='Contenido" + i +"' onMouseOut='this.className = \"Contenido"+ i +"\"' onMouseOver='this.className = \"ratonEncima\"'>"
                    var divTomar = "none";
                    var divAcciones = "none";
                    var divTomado = "none";
                    if ( expediente.clUsrAppAsignado == -1 ) {
                        divTomar = "block";
                    }
                    else {
                        //SI YO TENGO EL CASO, MOSTRAR ACCIONES.
                        if (expediente.clUsrAppAsignado == <%=strclUsr%> ) {
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
                    markup += "<td><b>" + expediente.sFechaApertura + "</b></td>";
                    //markup += "<td><b>" + expediente.sHoraApertura + "</b></td>";
                    markup += "<td><b>" + expediente.sCuenta + "</b></td>";
                    markup += "<td><b>" + expediente.sSubServicio + "</b></td>";
                    markup += "<td><b>" + expediente.sLocalidad + "</b></td>";
                    markup += "<td><b>" + expediente.ColoniaDest + "</b></td>";
                    markup += "<td><b>" + expediente.sNombreOperador + "</b></td>";
                    markup += "<td><b>" + expediente.sTomador + "</b></td>";
                    //if (expediente.Estatus != 10 ) {
                        //Pendiente de Asignacion
                        markup += "<td width=\"120px\"><div id=\"tomar_" + expediente.clExpediente + "\" style=\"display:"+ divTomar +"\"> <a href=\"javascript:fnTomar(" + expediente.clExpediente + ", <%=strclUsr%> );\">TOMAR!</a> </div>";
                        markup += "<div id=\"acciones_" + expediente.clExpediente + "\" style=\"display:"+ divAcciones +"\"> <a href=\"javascript:fnAsignar(" + expediente.clExpediente + ", <%=strclUsr%> );\">ASIGNAR</a>";
                        markup += "&nbsp;&nbsp;<a href=\"javascript:fnLiberar(" + expediente.clExpediente + ", <%=strclUsr%> );\">LIBERAR</a> </div>";
                        markup += "<div id=\"tomado_" + expediente.clExpediente + "\" style=\"display:"+ divTomado +"\" > TOMADO</div></td>";
                    //}
                    //else {
                    //    markup += "<td width=\"120px\"><div id=\"ASIGNADORAUTO\" ><b>En Asig. Automatico</b></div></td>";
                    //}
                    markup += "<td nowrap>" + (expediente.sAProgramar=='S'?'<img src=\"../../Imagenes/asignacion/calendar.png\" width=\"28px\" height=\"28px\" alt=\"A Programar\">':'<img src=\"../../Imagenes/asignacion/Transparent.png\" width=\"28px\" height=\"28px\">') 
                                            + (expediente.sConExcedente=='S'?'<img src=\"../../Imagenes/asignacion/money.png\" width=\"28px\" height=\"28px\" alt=\"Con Excedente\">':'<img src=\"../../Imagenes/asignacion/Transparent.png\" width=\"28px\" height=\"28px\">') 
                                            + (expediente.sConexion=='S'?'<img src=\"../../Imagenes/asignacion/conexion.png\" width=\"28px\" height=\"28px\" alt=\"Conexion\">':'<img src=\"../../Imagenes/asignacion/Transparent.png\" width=\"28px\" height=\"28px\">') + "</td>"
                    markup += "</tr>";
                    $("#listado").append(markup);
                    i = (i==1?2:1);
                });
                ordenador('#expediente,#tiempo,#fecha,#hora,#cuenta,#subservicio,#localidad,#destino,#usuario,#tomador','#listado');
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
        //llamar por ajax intentando un lock.
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
    
    function fnAsignar( clExpediente ) {
        var datos ={"clExpediente": clExpediente};
        $.ajax({
            type: "GET",
            url: "../../api/v1/util/setExpedienteEnSession.jsp",
            crossDomain: false,
            cache: false,
            data: datos,
            contentType: 'application/x-www-form-urlencoded; charset=ISO-8859-1',
            success: function(responseData, status, xhr) {
                top.document.all.rightPO.rows = "70,*";
                parent.frames['DatosExpediente'].location.reload();
                location.href= "../SeleccionaServicio.jsp?&Apartado=S";
                //"../KM0/PermiteBsqdaGRoji.jsp?&Apartado=S";
            },
            error: function(responseData, status, xhr) {
                alert("Error, No se pudo asignar el expediente, intente nuevamente");
            }
        } );
    }
</script>
</body>
</html>