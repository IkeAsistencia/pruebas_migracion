<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Encabezado</title>
        <style type="text/css">
            .offer-holder {
                width: 600px;
                height: 30px;
                position: absolute;
                top: 14px;
                left: 280px;
                color: #000080;
                font-family: Verdana, Arial, ArialBlack, Helvetica, sans-serif;
                font-size: 10px;
                }
            .Seconds {    display: none;            }
            .clockStyle {
                padding:2px;    /***    ESPACIO ENTRE DIGITOS Y MARGEN  ***/
                color:black;    /***    COLOR DE LOS DIGITOS    ***/
                font-family:sans-serif;
                font-size:13px;
                font-weight:bold;
                letter-spacing: 1px;
            }
            
            .alertas-ppe-title {
                width: 70px; 
                text-align: center; 
                bottom: 0; 
                color: white; 
                font-weight: bold; 
                position: absolute; 
                transform: rotate(-90deg); 
                -ms-transform: rotate(-90deg); 
                -webkit-transform: rotate(-90deg); 
                transform-origin: left bottom;
                -ms-transform-origin: left bottom;
                background-color: black;
            }
        </style>
    </head>
    <body background="Imagenes/banner_fondo.png" style="background-repeat:repeat-x;">
        <script type="text/javascript" language="JavaScript" src="Utilerias/jquery-1.11.1.min.js"></script>
        <script type="text/javascript" src='Utilerias/UtilAjax.js'></script>
        <%
            String strclUsr = "0";
            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();    }
            String StrPermisoBanner = "0";
            String strAlertaApp = "0";
            if (session.getAttribute("alertaApp") != null) {
                strAlertaApp = session.getAttribute("alertaApp").toString();         }
            StringBuffer StrSql = new StringBuffer();
            StrSql.append("st_Encabezado ").append(strclUsr);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            StrSql = null;
            int iBanners = 0;            
        %>

        <% if (strAlertaApp.equalsIgnoreCase("1")) {%>
        <div id="logo_chat" style="position:absolute; z-index:25; left:800px; top:0px; width:600; height:300;" >
            <!--iframe src="AlertaApp.jsp" allowtransparency  width=600 height=300 scrolling="no" frameborder="no"></iframe-->
        </div>
        <%}%>
        <div id="alertas_ppe" style="position:absolute; z-index:25; right:30; top:0px; width:200;" >
            <div id="alertas_ppe_data" style="display: none; width:200;">
                <div class="alertas-ppe-title">PPE</div>
                <a href="Operacion/AlertasPPE.jsp" target="Contenido">
                <div style="width:200;background-color: green; color: white; font-weight: bold; padding: 2 10;">
                    <span style="width: 140; display: inline-block;">Alertas</span><span id="alertas_ppe_nivel_uno" style="display: inline-block; width: 40; text-align: right;"></span>
                </div>
                <div style="width:200;background-color: yellow; color: black; font-weight: bold; padding: 2 10;">
                    <span style="width: 140; display: inline-block;">Urgentes</span><span id="alertas_ppe_nivel_dos" style="display: inline-block; width: 40; text-align: right;"></span>
                </div>
                <div style="width:200;background-color: red; color: white; font-weight: bold; padding: 2 10;">
                    <span style="width: 140; display: inline-block;">Vencidas</span><span id="alertas_ppe_vencidas" style="display: inline-block; width: 40; text-align: right;"></span>
                </div>
                </a>
            </div>
            <script type="text/javascript">
                function obtenerAlertas() {
                    console.log("Obteniendo alertas");
                    $.ajax({
                        url: "servlet/ObtenerAlertas",
                        xhrFields: {
                           withCredentials: true
                        },
                        cache: false,
                        success: function(data) {
                            console.log('Obtuvimos alertas');
                            console.log(data);                            
                            var contenedor = $('#alertas_ppe_data');
                            if (data.nivelUno > 0 || data.nivelDos > 0 || data.vencidas > 0) {
                                contenedor.show();
                                var nivelUno = $('#alertas_ppe_nivel_uno');
                                var nivelDos = $('#alertas_ppe_nivel_dos');
                                var vencidas = $('#alertas_ppe_vencidas');                                
                                nivelUno.text(data.nivelUno);
                                nivelDos.text(data.nivelDos);
                                vencidas.text(data.vencidas);
                            } else {  contenedor.hide();    }
                        },
                        error: function(err) {
                            console.log('Error obteniendo alertas');
                            console.log(err);
                        }
                     });
                }
                var timerHandle = setInterval(obtenerAlertas, 15000);
            </script>
        </div>
        <div id="logo_ike" style="position:absolute; z-index:25; left:0px; top:0px;">
            <img alt="Ike Asistencia Argentina" src="Imagenes/logo_ike_banner.png">
        </div>
        <div id="icon_date" style="position: absolute; z-index:35; left:18px; top:49px;">
            <img alt="Fecha" src="Imagenes/calendar.png">
        </div>
        <div id="icon_clock" style="position: absolute; z-index:35; left:135px; top:49px;">
            <img alt="Hora" src="Imagenes/clock.png">
        </div>
        <div id="date" class="clockStyle" style="position: absolute; z-index:50; left: 36px; top:48px;"></div>
        <div id="clock" class="clockStyle" style="position: absolute; z-index:50; left: 154px; top:48px;"></div>
        <div class="rotateBanner" id="rotate" style="">
            <%while (rs.next()) {
                StrPermisoBanner = rs.getString("clBanner");%>
                <div class="offer-holder"><%=rs.getString("dsBanner")%></div><%
                iBanners++;
                }
            if (iBanners == 0) {
                %><div class="offer-holder"><span class="Seconds">60</span></div><%
                iBanners = 1;
                }
            rs.close();
            rs = null;
            %>
        </div>
    </body>
    <input type="hidden" id="Banners" name="Banners" value="<%=iBanners%>">
    <script type="text/javascript">
//------------------------------------------------------------------------------
        function updateClock() {       
            var Fechahora = new Date();
            var myClock;
            var day = Fechahora.getUTCDate();   
            var meses = new Array("Ene","Febo","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic");
            var mes = meses[Fechahora.getMonth()];           
            var a�o = Fechahora.getFullYear();            
            myClock = document.getElementById('clock');
            myClock.innerText = Fechahora.toLocaleTimeString().replace(/([\d]+:[\d]{3})(:[\d]{3})(.*)/, "$1$3");
            setTimeout('updateClock()', 1000);                
            var myDate = document.getElementById('date');
            myDate = document.getElementById('date');
            myDate.innerText = day + "/" + mes + "/" + a�o;
            }
//------------------------------------------------------------------------------        
        updateClock();
        <% if (!StrPermisoBanner.equalsIgnoreCase("0")) {%>
        var Banners = document.all.Banners.value;
        var iBanner = 0;
        var speed = 25;
        if (iBanner == 0) {          rotate();       }
//------------------------------------------------------------------------------        
        function rotate() {
            if (iBanner == 0) {
                $("div.rotateBanner div").hide().eq(0).show();
                speed = $("div.rotateBanner div").fadeOut().eq(0).fadeIn().find('.Seconds').text();
            } else {
                if (iBanner > Banners + 1) {
                    iBanner = 0;
                    speed = $("div.rotateBanner div").fadeOut().eq(0).fadeIn().find('.Seconds').text();
                    fnListener();
                    $("div.rotateBanner div").hide().eq(0).show();
                    Banners = document.all.NumBanners.value;
                } else {   speed = $("div.rotateBanner div").fadeOut().eq(parseInt(iBanner)).fadeIn().find('.Seconds').text();    }
            }
            iBanner = parseInt(iBanner) + 1;
            setTimeout("rotate()", (parseInt(speed) * 1000));
        }
//------------------------------------------------------------------------------
        function fnListener() {
            URL = "ShowBanner.jsp";
            Cadena = "";
            IdDiv = "rotate";
            fnLLenaInput(URL, Cadena, IdDiv);
        }
//------------------------------------------------------------------------------
        <%}%>
    </script>
</html>