<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%  
    String strclUsrApp = "0";
    if (session.getAttribute("clUsrApp") != null) {
        strclUsrApp = session.getAttribute("clUsrApp").toString();        }
    if(SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true){
        %><font color="white"  style="font-family:Verdana,Arial,Helvetica,sans-serif; background-color:red;" size=3>LA SESION EXPIRO</font><%  
        strclUsrApp=null;
        return;
        }
    String strclUsr = "";
    if (session.getAttribute("clUsrApp") != null) {
        strclUsr = session.getAttribute("clUsrApp").toString();
    } else {   strclUsr= "5463";  }
%>            
<html>
    <head>
        <title>Listado de Centro de Costos</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script type="text/javascript" src="../../Utilerias/jquery.sortElements.js"></script>
        <script type="text/javascript" src="utilidades.js"></script>
        <style>
            .Titulo {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold; color: #000066; text-transform: uppercase; text-align:center;}
        </style>
        <script src='../../Utilerias/Util.js'></script>
    </head>
    <body class="cssBody" onload="javascript:cargaCostos();">
        <div align="center">
        <br><br>
        <div id="MsgDefault" >
            Consultando Expedientes para Validar, Aguarde un instante... 
            <input type="button" name="retry" id="retry" value="Reintentar" onclick="javascript:cargaCostos()">
        </div>
        <div id="DivListado" style="display:none;">
            <div id="titulo"><FONT style="COLOR: #000066" size=4 ><B>Expedientes a Validar</B></FONT></div><br />
            <div align="left" style="">
                <input type="text" id="filtro_custom" onkeyup="filtro();">
                <input type="button" name="borrar" value="Borrar" onclick="document.getElementById('filtro_custom').value='';filtro();">  
            </div><br />
            <table id="PW_LST" class="Lista" cellspacing='0'>
                <tr class="Columnas"  align="center" >
                    <th id="expediente" style="text-align:center">Expediente</th>
                    <th id="cuenta" style="text-align:center">Cuenta</th>
                    <th id="fecha" style="text-align:center">Fecha Apertura</th>
                    <th id="proveedor" style="text-align:center">Proveedor</th>
                    <th id="subServicio" style="text-align:center">SubServicio</th>
                    <th id="Concepto" style="text-align:center">Concepto</th>
                    <th id="Costo" style="text-align:center">Monto</th>
                    <th id="accion" style="text-align:center">Accion</th>
                </tr>
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
    var data = [];    
//------------------------------------------------------------------------------
    function cargaCostos() {
        $.ajax({
            type: "GET",
            dataType: "json",
            url: "../../api/v1/ccc/listaCostos.jsp",
            crossDomain: false,
            cache: false,
            contentType: 'application/x-www-form-urlencoded; charset=ISO-8859-1',
            success: function(responseData, status, xhr) {
                data = responseData;
                mostrarCostos(data);
                ordenador('#expediente,#cuenta, #fecha, #proveedor, #subServicio, #Concepto, #costo, #accion','#listado');
                MsgDefault.style.display = "none";
                DivListado.style.display = "block";
            },
            error: function(req, status, error) {
                alert("Error al obtener listados de costos de expedientes");
            }
        } )
    }
//------------------------------------------------------------------------------
    function filtro(){
        var keys_filtro=document.getElementById("filtro_custom").value;
        var data_preformed=[];
        if(keys_filtro.length>0){            
            $.each(data,function(key,expediente){ 
                if(String(expediente.proveedor).toLowerCase().indexOf(keys_filtro.toLowerCase()) !== -1 && expediente.costo!=""){
                    data_preformed.push(expediente);
                }
            });
            mostrarCostos(data_preformed);
        }else{
            mostrarCostos(data);
        }
    }
//------------------------------------------------------------------------------
    function mostrarCostos(data_formed){
                var i = 1;
                $("#listado tr").remove();
        $.each(data_formed,function(key,expediente){
                    var markup = "<tr class='Contenido" + i +"' onMouseOut='this.className = \"Contenido"+ i +"\"' onMouseOver='this.className = \"ratonEncima\"'>"
                    markup += "<td><b><a href='../DetalleExpediente.jsp?clExpediente=" + expediente.clExpediente + "'> " + expediente.clExpediente + "</a></b></td>";
                    markup += "<td><b>" + expediente.cuenta + "</b></td>";
                    markup += "<td><b>" + expediente.fecha   + "</b></td>";
                    markup += "<td><b>" + expediente.proveedor + "</b></td>";
                    markup += "<td><b>" + expediente.subServicio + "</b></td>";
                    markup += "<td><b>" + expediente.conceptoCosto + "</b></td>";
                    markup += "<td><b>" + (expediente.costo ==0?'':expediente.costo)+ "</b></td>";
                    markup += "<td>";
                    if (expediente.check ) {
                        markup += "<input type='button' value='Validar' onclick='javascript:fnValidarCC(" + expediente.clExpediente  +", <%=strclUsr%> );'>";
                    }
                    if (expediente.link ) {
                        markup += "<input type='button' value='Revisar' onclick='javascript:fnRevisar(" + expediente.clExpediente + ");'>";
                    }
                    markup += "</td>";
                    markup += "</tr>";
                    $("#listado").append(markup);
                    i = (i==1?2:1);
                });
            }
//------------------------------------------------------------------------------
    function fnRevisar(expediente ) {
        // Envia a listado de costos de expediente.
        var datos ={"clExpediente": expediente};
        $.ajax({
            type: "GET",
            url: "../../api/v1/util/setExpedienteEnSession.jsp",
            crossDomain: false,
            cache: false,
            data: datos,
            contentType: 'application/x-www-form-urlencoded; charset=ISO-8859-1',
            success: function(responseData, status, xhr) {
                parent.frames['DatosExpediente'].location.reload();
                location.href="../../servlet/Utilerias.Lista?P=241&Apartado=S";
            },
            error: function(responseData, status, xhr) {
                alert("Error, No se pudo asignar el expediente, intente nuevamente");
            }
        } );
    }
//------------------------------------------------------------------------------
</script>
</body>
</html>
