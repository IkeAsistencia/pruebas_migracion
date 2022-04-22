<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Asignacion Automatica O Manual</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>            
        <style> 
            .Titulo {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px; font-weight: bold; color: #000066; text-transform: uppercase; text-align:center;}
        </style>
   </head>
   <%
    String strclUsr=(session.getAttribute("clUsrApp")     != null?(String)session.getAttribute("clUsrApp")     :"0");
    if(SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true){
        %><font color="white"  style="font-family:Verdana,Arial,Helvetica,sans-serif; background-color:red;" size=3>LA SESION EXPIRO</font><%  
        strclUsr=null;
        return;
        }
    String StrclServicio=(session.getAttribute("clServicio")   != null?(String)session.getAttribute("clServicio")   :"");
    String StrclSubServicio=(session.getAttribute("clSubServicio")!= null?(String)session.getAttribute("clSubServicio"):"");
    String StrclExpediente=(session.getAttribute("clExpediente") != null?(String)session.getAttribute("clExpediente") :"");
   %>
   <body class="cssBody" onload="javascript:fnAccionesDisponibles(<%=StrclServicio%>);">
        <%
        if ( "1".equalsIgnoreCase(StrclServicio) ) {
            //Servocios VIAL
            ResultSet rsValidaWS = UtileriasBDF.rsSQLNP("st_WSValidaExpediente " + StrclExpediente);
            String StrPermiteWS = (rsValidaWS.next()?rsValidaWS.getString("PermiteWS"):"0");
            %>
            <center style="position:relative; top:90px;">
                <p class='Titulo'>Realizar Publicación Automática Vial?<br></p>
                <table align="center" border="0"> 
                    <tr>
                        <div id='Leyenda'><p>Verificando operaciones disponibles, Aguarde un instante...</p></div>                            
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <table>
                                <tr>
                                    <td valign="middle">
                                        <input id="AProgramar" name="AProgramar" type="checkbox" style="vertical-align:middle"/>
                                        <img src="../../Imagenes/asignacion/calendar.png" width="36px" height="36px"/>
                                    </td>
                                    <td>&nbsp;&nbsp;&nbsp;</td>
                                    <td valign="middle">
                                        <input id="ConExcedente" name="ConExcedente" type="checkbox" />
                                        <img src="../../Imagenes/asignacion/money.png" width="36px" height="36px"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>A Programar</td>
                                    <td>&nbsp;</td>
                                    <td>Con Excedente</td>
                                </tr>
                            </table>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr><td colspan="3">&nbsp;<br />&nbsp;</td></tr>
                    <tr>
                        <td width="200" align="center">
                            <div id='AsigAuto'  style='display:none;'>
                                <img alt='Asignación Automática' src='../../Imagenes/accept.png' onClick='javascript:fnPorPublicacionVial();' width='64' height='64'/>
                                <p>Asignaci&oacute;n Automatica</p>
                            </div>
                        </td>
                        <td width="200" align="center">
                            <div id='AsigAPila' style='display:none;'>
                                <img alt='Pila de Asignacion' src='../../Imagenes/accept.png' onClick='javascript:fnSendToBackVial(<%=StrclExpediente%>, <%=strclUsr%>, "SEND");' width='64' height='64' ><br />
                                <p>Enviar a Back Sin Proveedor</p>
                            </div>
                        </td>
                        <td width="200" align="center">
                            <div id='AsigManual'  style='display:block;'>
                                <img alt='Asignación Manual' src='../../Imagenes/remove.png' onClick='javascript:fnAsigManual();' width='64' height='64'>
                                <p>Asignaci&oacute;n Manual</p>
                            </div>
                        </td>
                    </tr>
                </table>
            </center>
        <%}else {
            if ( "3".equalsIgnoreCase(StrclServicio) ) {
                //Envios HOGAR
                %>
                <center style="position:relative; top:90px;">
                    <p class='Titulo'>Realizar Publicación Automática Hogar?<br></p>
                    <table align="center" border="0"> 
                        <tr>
                            <div id='Leyenda'><p>Verificando operaciones disponibles, Aguarde un instante...</p></div>                            
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr><td colspan="3">&nbsp;<br />&nbsp;</td></tr>
                        <tr>
                            <td width="200" align="center">
                                <div id='AsigAuto'  style='display:none;'>
                                    <img alt='Asignación Automática' src='../../Imagenes/accept.png' onClick='javascript:fnPorPublicacionHogar();' WIDTH='64' HEIGHT='64' >
                                    <p>Asignaci&oacute;n Automatica</p>
                                </div>
                            </td>
                            <td width="200" align="center">
                                <div id='AsigAPila' style='display:none;'>
                                     &nbsp;
                                </div>
                            </td>
                            <td width="200" align="center">
                                <div id='AsigManual'  style='display:block;'>
                                    <IMG alt='Asignación Manual' SRC='../../Imagenes/remove.png' onClick='javascript:fnAsigManualHogar();' WIDTH='64' HEIGHT='64'>
                                    <p>Asignaci&oacute;n Manual</p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </center>
            <%}else {    //TODOS LOS ENVIOS QUE NO SON HOGAR NI VIAL
                %>
                <script>
                    location.href = '../../servlet/Utilerias.Lista?P=184&Apartado=S';
                </script>
                <% }
            } %>
        <script>
//------------------------------------------------------------------------------        
            function fnPorPublicacionHogar() {
                parent.frames['DatosExpediente'].datos.modo.value = "GEOHOGAR";
                parent.frames['DatosExpediente'].datos.clProveedor.value = "1897"; //
                //Parametro AUTO:1  ES PUBLICACION AUTOMATICA
                window.open('../../Operacion/CreaCita.jsp?clProveedor=1897&NombreOpe=Pendiente&AUTO=1','winCita','resizable=no,menubar=0,status=yes,width=600,height=350');
            }
//------------------------------------------------------------------------------        
            function fnAsigManualHogar() {
                location.href = '../../servlet/Utilerias.Lista?P=184&Apartado=S';        }
//------------------------------------------------------------------------------
            function fnAsigManual(){
                location.href='../../servlet/Utilerias.Lista?P=184&Apartado=S';        }
//------------------------------------------------------------------------------
            function fnPorPublicacionVial(){
                var AProgramar = (document.getElementById("AProgramar").checked?"1":"0");
                var ConExcedente = (document.getElementById("ConExcedente").checked?"1":"0")
                window.open('WSEnviaExpediente.jsp?&clExpediente=<%=StrclExpediente%>&AProgramar=' + AProgramar +'&ConExcedente='+ConExcedente,'','resizable=no,menubar=0,status=0,toolbar=0,height=50,width=50,screenX=-50,screenY=0,scrollbars=yes')
            }
//------------------------------------------------------------------------------
            function fnAccionesDisponibles( servicio ) {
                if (servicio == 1) {
                    //Asignacion VIAL
                    fnDisponibleAsignar(<%=StrclExpediente%>, <%=strclUsr%>);
                    fnDisponiblePubAuto(<%=StrclExpediente%>);
                }
                else {
                    if (servicio == 3)  {
                        //Asignacion HOGAR
                        fnDisponiblePubAutoHogar(<%=StrclExpediente%>);
                        $('#Leyenda').hide();
                    }
                }    
            }
//------------------------------------------------------------------------------
            function fnSendToBackVial( clExpediente, clUsrApp, operacion){ 
                //Envia el expediente a la bolsa de expedientes.
                var AProgramar = (document.getElementById("AProgramar").checked?"1":"0");
                var ConExcedente = (document.getElementById("ConExcedente").checked?"1":"0")
                var datos ={"clExpediente": clExpediente, 
                            "clUsrApp": clUsrApp,
                            "operacion": operacion,
                            "AProgramar": AProgramar,
                            "ConExcedente": ConExcedente };
                $.ajax({
                    //TODO: Enviar directamente como JSON. Y EN POST
                    type: "GET",
                    url: "../../api/v1/sendToBack/send.jsp",
                    crossDomain: false,
                    cache: false,
                    data: datos,
                    contentType: 'application/x-www-form-urlencoded; charset=ISO-8859-1',
                    success: function(responseData, status, xhr) {
                        //Mostrar EXITO EN LA ASIGNACION DIRECTA
                        if (xhr.status == 200 ) {
                            alert("El expediente fue enviado para su asignacion correctamente");
                            location.href='../DetalleExpediente.jsp';
                        }
                        else {      }
                    },
                    error: function(req, status, error) {
                        alert("Error al enviar expediente a la bolsa de asignaciones");
                    }
                } )
            }
//------------------------------------------------------------------------------
            function fnDisponibleAsignar( clExpediente, clUsrApp ){ 
                var datos ={"clExpediente": clExpediente, "clUsrApp": clUsrApp };
                $.ajax({
                    type: "GET",
                    url: "../../api/v1/asignacion/estaBloqueadoExpediente.jsp",
                    crossDomain: false,
                    cache: false,
                    data: datos,
                    contentType: 'application/x-www-form-urlencoded; charset=ISO-8859-1',
                    success: function(responseData, status, xhr) {
                        $('#Leyenda').hide();
                        if (xhr.status == 200 ) {         $('#AsigAPila').show();                   }
                        else {
                            //STATUS 202 ES DUEÑO, PUEDE ASIGNAR.
                            $('#AsigAPila').hide();
                            $('#AsigManual').show();
                        }
                    },
                    error: function(req, status, error) {
                        $('#Leyenda').hide();
                        if ( req.status == 409 ) {
                            //Enviado a Asignar, SIN DUEÑO
                            $('#AsigAPila').hide();
                        }
                        else {
                            if ( req.status = 403 ) {
                                //Publicado y NO OWNER.
                                $('#AsigAPila').hide();
                            }
                            else {
                                Alert("Error, vuelva a intentar en unos instantes");
                            }
                        }
                    }
                } )
            }
//------------------------------------------------------------------------------
            function fnDisponiblePubAuto( clExpediente ){ 
                var datos ={"clExpediente": clExpediente };
                $.ajax({
                        type: "GET",
                        url: "../../api/v1/asignacion/permitePubAuto.jsp",
                        crossDomain: false,
                        cache: false,
                        data: datos,
                        contentType: 'application/x-www-form-urlencoded; charset=ISO-8859-1',
                        success: function(responseData, status, xhr) {       $('#AsigAuto').show();         },
                        error: function(req, status, error) {
                            $('#AsigAuto').hide();
                        }
                    } )
            }
//------------------------------------------------------------------------------
            function fnDisponiblePubAutoHogar( clExpediente ){ 
                var datos ={"clExpediente": clExpediente };
                $.ajax({
                    type: "GET",
                    url: "../../api/v1/asignacion/permitePubAutoHogar.jsp",
                    crossDomain: false,
                    cache: false,
                    data: datos,
                    contentType: 'application/x-www-form-urlencoded; charset=ISO-8859-1',
                    success: function(responseData, status, xhr) {
                        $('#AsigAuto').show();
                    },
                    error: function(req, status, error) {
                        $('#AsigAuto').hide();
                    }
                } )
            }
//------------------------------------------------------------------------------
        </script>
    </body>
</html>