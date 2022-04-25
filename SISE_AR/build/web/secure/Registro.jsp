<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="java.security.SecureRandom"%>

<html>
    <head>
        <title>.: SISE Argentina :.</title>
        <meta http-equiv="Content-Type">
        <script src="../Utilerias/jquery-1.12.4.js" type="text/javascript"></script>
        <script src="../Utilerias/Util.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $("input, textarea").addClass("inactivo");
                $("input, textarea").focus(function () {
                    $(this).addClass("activo").removeClass("inactivo");
                }).blur(function () {
                    $(this).removeClass("activo").addClass("inactivo");
                });
            });</script>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link rel="shortcut icon" href="../Imagenes/IkeIcon.ico" type="image/x-icon"/>
    </head>
    <body onload="fnValidaRes()" style=" ">
        <!--body onload="fnValidaRes(); alert('�ATENCION! \n\nEstas ingresando en el SISE de contingencia, recuerda que este es un sistema de emergencia por lo que solo debe ser utilizado cuando el SISE convencional no est� funcionando correctamente. \n\nSe guardar� en bit�cora todo acceso a este sistema.')" style=" "-->
        <%
            String url = response.encodeURL("../servlet/Seguridad.Login");
        %>
        <form action="<%=url%>" method="post" id="frm1">
            <script>
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
            </script>

            <div id="divPrincipal" style="position:absolute; left:20%; top:30%">
                <img src="../Imagenes/PortadaARP.jpg">
                <!--img src="Imagenes/PortadaARCT.jpg"-->
                <!--img src="Imagenes/PortadaARC.jpg"-->
                <div id="inputArea" style="position:absolute; z-index:20; left:115px; top:130px;">
                    <label id="lblUsuario" for="txtUsuario" style="color:#FFFFFF; font-size:17px; font-variant:small-caps; font-weight:bold;">usuario</label>
                    <input id="Usr" name="Usr" type="text" size="10" maxlength="15" onblur="fnReplaceScripting(this.value, this.id);"/>
                    <label id="lblPass" for="txtContrase�a" style="color:#FFFFFF; font-size:17px; font-variant:small-caps; font-weight:bold;" onblur="alert();">contrase�a</label>
                    <!--input id="Pass" name="Pass" type="password" size="10" maxlength="10" onblur="fnReplaceScripting(this.value, this.id);" autocomplete="off"/-->
                    <input id="Pass" name="Pass" type="password" size="10" maxlength="10" onblur="fnReplaceScripting(this.value, this.id);" />
                    <div class="buttons">
                        <button type="submit" class="positive" onclick="fnReplaceScripting();">INGRESAR</button>

                    </div>
                </div>
            </div>
        </form>
        <div id="piepag" style="position:absolute; z-index:20; bottom:10px">
            <p style="font-size:10px;">ESTE SITIO SE VE MEJOR CON <a href="http://www.microsoft.com/latam/windows/internet-explorer/">INTERNET EXPLORER 9</a> � SUPERIOR.</p>
            <p>&reg; 2014 <a href="http://www.ikeasistencia.com/">ik� asistencia.</a></p>
        </div>
        <script>
            function fnReplaceScripting() {
                var usr = document.all.Usr.value;
                var pass = document.all.Pass.value;
                usr = usr.replace(/select /gi, "");
                usr = usr.replace(/insert /gi, "");
                usr = usr.replace(/ into /gi, "");
                usr = usr.replace(/values/gi, "");
                usr = usr.replace(/delete /gi, "");
                usr = usr.replace(/update /gi, "");
                usr = usr.replace(/drop /gi, "");
                usr = usr.replace(/exec /gi, "");
                usr = usr.replace(/execute /gi, "");
                usr = usr.replace(/truncate /gi, "");
                usr = usr.replace(/alter /gi, "");
                usr = usr.replace(/ table /gi, "");
                usr = usr.replace(/'/gi, "");
                usr = usr.replace(/"/gi, "");
                usr = usr.replace(/</gi, "");
                usr = usr.replace(/>/gi, "");
                pass = pass.replace(/select /gi, "");
                pass = pass.replace(/insert /gi, "");
                pass = pass.replace(/ into /gi, "");
                pass = pass.replace(/values/gi, "");
                pass = pass.replace(/delete /gi, "");
                pass = pass.replace(/update /gi, "");
                pass = pass.replace(/drop /gi, "");
                pass = pass.replace(/exec /gi, "");
                pass = pass.replace(/execute /gi, "");
                pass = pass.replace(/truncate /gi, "");
                pass = pass.replace(/alter /gi, "");
                pass = pass.replace(/ table /gi, "");
                pass = pass.replace(/'/gi, "");
                pass = pass.replace(/"/gi, "");
                pass = pass.replace(/</gi, "");
                pass = pass.replace(/>/gi, "");
                document.all.Usr.value = usr;
                document.all.Pass.value = pass;
                /*document.getElementById("frm1").submit();*/
            }
        </script>
    </body>
</html>