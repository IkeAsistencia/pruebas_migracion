/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var script = document.createElement('script');
script.src = '//cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js';
document.getElementsByTagName('head')[0].appendChild(script); 

var sUrl = "api/v1/ccc/validarCosto.jsp";
    //Llama desde el boton VALIDAR en listado de Centro de Costos
    function fnValidarCC(expediente, clUsrApp) {
        //Llamar al stored procedure que pone al CxP en estado 3
        // st_validaExpxCC ( expediente, clUsrApp )
        var datos ={"clExpediente": expediente, 
                    "clUsrApp": clUsrApp };
            $.ajax({
                type: "GET",
                url: "../../" + sUrl,
                crossDomain: false,
                cache: false,
                data: datos,
                contentType: 'application/x-www-form-urlencoded; charset=ISO-8859-1',
                success: function(responseData, status, xhr) {
                    // Si Ok publicacion
                    //console.log(xhr.status );
                    cargaCostos();
                },
                error: function(req, status, error) {
                    // Si No OK
                    //      Mensaje de error
                    //console.log(status );
                    alert("El expediente no cuenta con las condiciones necesarias para ser validado o falta registrar pago en algun costo para este expediente.");
                }
//                statusCode: {
//                    200: function() {
//                        cargaCostos();
//                        },
//                    202:function() {
//                        alert("Validacion de Costos: Falta registrar pago en algun costo para este expediente.");
//                        },
//                    405:function() {
//                        alert("Error al enviar expediente a el portal de proveedor");
//                        },
//                    500:function() {
//                        alert("Error al enviar expediente a el portal de proveedor");
//                        },
//                    default:function(){
//                        alert("Error al enviar expediente a el portal de proveedor");    
//                    }
//                    
//                }
//                
            } )
        }

    //Llamado desde el boton validar desde el listado de costos de un expediente.
    //PRECAUCION: PATH de url de API REST y de listado.jsp
    function fnValidar(expediente) {
        //Llamar al stored procedure que pone al CxP en estado 3
        // st_validaExpxCC ( expediente, clUsrApp )   
        
        var datos ={"clExpediente": expediente, 
                    "clUsrApp": parent.frames["DatosExpediente"].document.getElementById("clUsrApp").value };
            $.ajax({
                type: "GET",
                url: "../" + sUrl,
                crossDomain: false,
                cache: false,
                data: datos,
                contentType: 'application/x-www-form-urlencoded; charset=ISO-8859-1',
//                statusCode: {
//                    200: function() {
//                        location.href='../Operacion/centroCostos/listado.jsp?';
//                        },
//                    202:function() {
//                        alert("Validacion de Costos: Falta registrar pago en algun costo para este expediente.");
//                        },
//                    405:function() {
//                        alert("Error al enviar expediente a el portal de proveedor");
//                        },
//                    500:function() {
//                        alert("Error al enviar expediente a el portal de proveedor");
//                        },
//                    default:function(){
//                        alert("Error al enviar expediente a el portal de proveedor");    
//                    }
//                    
//                }
                success: function(responseData, status, xhr) {
                    // Si Ok publicacion
                    //console.log(xhr.status );
                    alert("Validacion OK");
                    location.href='../Operacion/centroCostos/listado.jsp?';
                    
                },
                error: function(req, status, error) {
                    // Si No OK
                    //      Mensaje de error
                    //console.log(status );
                    var html = $.parseHTML(req.responseText)[5].innerHTML;
                    //console.log($.parseHTML(html));                    
                    alert("El expediente no cuenta con las condiciones necesarias para ser validado o falta registrar pago en algun costo para este expediente.");
                    //alert($.parseHTML(html)[2].innerHTML);
                }
            } )
        }
