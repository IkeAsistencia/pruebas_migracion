<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" import="java.net.HttpURLConnection,java.net.URL,java.security.SecureRandom" %>
<html>
    <head>
        <title>.: SISE Argentina :.</title>
        <meta http-equiv="Content-Type">
        <script src="Utilerias/jquery-1.12.4.js" type="text/javascript"></script>
        <script src="Utilerias/Util.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $("input, textarea").addClass("inactivo");
                $("input, textarea").focus(function () {
                    $(this).addClass("activo").removeClass("inactivo");
                }).blur(function () {
                    $(this).removeClass("activo").addClass("inactivo");
                });
            });</script>
        <link href="StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link rel="shortcut icon" href="Imagenes/IkeIcon.ico" type="image/x-icon"/>
    </head>
    <body onload="fnValidaRes();fnCheckErrorToRedirect()" style=" ">         
        <!--body onload="fnValidaRes(); alert('¡ATENCION! \n\nEstas ingresando en el SISE de contingencia, recuerda que este es un sistema de emergencia por lo que solo debe ser utilizado cuando el SISE convencional no esté funcionando correctamente. \n\nSe guardará en bitácora todo acceso a este sistema.')" style=" "-->
        <%
            String url = response.encodeURL("servlet/Seguridad.DobleAutenticacion");
            String errorMsg ="";
            String redirectURL ="0";            
            if (session.getAttribute("errorMsg") != null) {
                errorMsg = session.getAttribute("errorMsg").toString();
                session.removeAttribute("errorMsg");
            }           
            if (session.getAttribute("redirectToLogin")!= null){
                session.removeAttribute("redirectToLogin");
                redirectURL= "1";                
            }           
        %>
        <form action="<%=url%>" method="post" id="frm1">
            <script>
//------------------------------------------------------------------------------                
                //  VALIDA RESOLUCION PARA MEJORAR PRESENTACION
                function fnValidaRes() {
                    var myDivPrincipal = document.getElementById("divPrincipal");
                    var myDivPiePag = document.getElementById("piepag");
                    if (screen.availWidth == 800) {
                        myDivPrincipal.style.left = '10px';
                        myDivPrincipal.style.top = '10px';
                        myDivPiePag.style.left = '230px';
                        return;
                    }
                    if (screen.availWidth == 1024) {
                        myDivPrincipal.style.left = '12%';
                        myDivPrincipal.style.top = '22%';
                        myDivPiePag.style.left = '340px';
                        return;
                    }                    
                    if (screen.availWidth == 1280) {
                        myDivPrincipal.style.left = '20%';
                        myDivPrincipal.style.top = '30%';
                        myDivPiePag.style.left = '35%';
                        return;
                    }
                }
//------------------------------------------------------------------------------
            </script>
            <div id="divPrincipal" style="position:absolute; left:20%; top:30%">
                <img src="Imagenes/PortadaARL.jpg">
                <div id="inputArea" style="position:absolute; z-index:40; left:115px; top:130px;">
                    <label id="lblCodigo" for="txtCodigoVerificacion" style="color:#FFFFFF; font-size:17px; font-variant:small-caps; font-weight:bold;">Codigo de Verificación</label>
                    <input id="codigoVerificacion" name="codigoVerificacion" type="password" size="6" maxlength="6" onblur="fnReplaceScripting(this.value, this.id);"/>                
                    <div class="buttons">
                        <button type="submit" class="positive" onclick="fnReplaceScripting()">INGRESAR</button>
                    </div>                 
                </div>                
                 <div id="mensajeError" style="position:absolute; z-index:50; left:115px; top:250px; color:#FF0000">                   
                    <%=errorMsg%>
                </div>                 
                 <div id="avisoCorreo" style="position:absolute; z-index:50; left:115px; top:300px; color:#FF0000">
                     <label id="lblAvisoCorreo" for="txtAvisoCorreo" style="color:#000000; font-size:15px; font-weight:bold;">Verifique su casilla de correo electrónico</label>
                 </div>
                <input type="hidden" id="redirectHome" value="<%=redirectURL%>"/> 
            </div>
        </form>
        <div id="piepag" style="position:absolute; z-index:20; bottom:10px">
            <p>&reg; 2018 <a href="http://www.ikeasistencia.com/">iké asistencia.</a></p>
        </div>
        <script>
//---------------------------------------------------------------------		
            function fnReplaceScripting() {
                var cod = document.all.codigoVerificacion.value
                cod = cod.replace(/insert /gi, "");
                cod = cod.replace(/ into /gi, "");
                cod = cod.replace(/values/gi, "");
                cod = cod.replace(/delete /gi, "");
                cod = cod.replace(/update /gi, "");
                cod = cod.replace(/drop /gi, "");
                cod = cod.replace(/exec /gi, "");
                cod = cod.replace(/execute /gi, "");
                cod = cod.replace(/truncate /gi, "");
                cod = cod.replace(/alter /gi, "");
                cod = cod.replace(/ table /gi, "");
                cod = cod.replace(/'/gi, "");
                cod = cod.replace(/"/gi, "");
                cod = cod.replace(/</gi, "");
                cod = cod.replace(/>/gi, "");              
                document.all.codigoVerificacion.value = cod;
            }
//---------------------------------------------------------------------            
            function fnCheckErrorToRedirect(){
                var redirect = document.getElementById('redirectHome').value;
                if(redirect ==='1'){
                    fnRedirect_Page();
                }
            }
//---------------------------------------------------------------------  
            function fnRedirect_Page () {
                    var tID = setTimeout(function () {
                    window.location.href = 'Registro.jsp';
                    window.clearTimeout(tID);		// clear time out.
                }, 5000);
            }
//---------------------------------------------------------------------        
        </script>
    </body>
</html>