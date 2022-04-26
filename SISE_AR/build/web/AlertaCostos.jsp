<%-- 
    Document   : AlertaCostos
    Created on : 7/07/2021, 12:17:23 PM
    Author     : gezequiel
--%>

<%@page contentType="text/html; charset=iso-8859-1" import="Utilerias.UtileriasBDF,Seguridad.SeguridadC, Utilerias.LoadAlertaCostos,java.sql.ResultSet"%>

<html>
    <head>
        <title></title>
       <!--<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">-->
        <link href="StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <script>
            function hideLeftPanel() {
                parent.document.getElementById('topPO').cols = '17%,*,0%'
            }
            function viewLeftPanel() {
                parent.document.getElementById('topPO').cols = '17%,*,10%'
            }
        </script>
    </head>
    <!--body topmargin="12" leftmargin="5" bgproperties="fixed" bgcolor='#062f67' onload="fnValidaPermiso();"-->
    <body bgcolor='#062f67' onload="fnValidaPermiso();">

        <%
            String strclUsr = "0";
            String strCostos = "";

            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true) {
        %>Fuera de Horario<%
                strclUsr = null;
                strCostos = null;
                return;
            }

            String strPrivilegios = "0";
            StringBuffer bf = new StringBuffer();
            ResultSet rs = null;

            bf.append("st_GetPermisoAlertaCostos ").append(strclUsr);

            rs = UtileriasBDF.rsSQLNP(bf.toString());
            bf.delete(0, bf.length());

            if (rs.next()) {
                strPrivilegios = (rs.getString("privilegios").toString());
            }

            if (strPrivilegios.equals("1")) { %>
        <!-- <div style=height:20px; id="titMiniBanner">
             <p style=color:#ecf2f9;font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;text-transform:uppercase;font-weight:bold;position:absolute;top:5px;left:35px;>Monitoreos Pendientes</p>
         </div> -->

        <% strCostos = LoadAlertaCostos.getstrCostos(strclUsr); %>
        <% } else { %>
        <p></p>
        <% }%>

        <input type="hidden" id="valor" name="valor"  value= "<%=strCostos%>"><%
            //<<<Limpia Variables>>>
            strCostos = null;
            strclUsr = null;
            rs.close();
            rs = null;
            bf = null;
        %>
        <script type="text/javascript">
            var ancho = 130;
            var alto = 736;
            var velocidad = 5;
            contenido = document.all.valor.value;

            if (document.all.valor.value == '') {
                hideLeftPanel();
            } else {
                viewLeftPanel();
            }
                document.write('<marquee onmouseover="this.stop();" onmouseout="this.start();" direction="up" scrollAmount=' + velocidad + ' style="width:' + ancho + ';height:' + alto + '">' + contenido + '</marquee>')
            /*if (document.all) {
                document.write('<marquee onmouseover="this.stop();" onmouseout="this.start();" direction="up" scrollAmount=' + velocidad + ' style="width:' + ancho + ';height:' + alto + '">' + contenido + '</marquee>')
            }*/

            function fnValidaPermiso() {
                if (document.all.valor.value != '') {
                    document.all.titMiniBanner.style.visibility = 'true';
                } else {
                    document.all.titMiniBanner.style.visibility = 'false';
                }
            }

            function regenerar() {
                window.location.reload()
            }

            function regenerar2() {
                if (document.layers) {
                    setTimeout("window.onresize=regenerar", 450)
                    inimarquee()
                }
            }

            function inimarquee() {
                document.cmarquee01.document.cmarquee02.document.write(contenido)
                document.cmarquee01.document.cmarquee02.document.close()
                thelength = document.cmarquee01.document.cmarquee02.document.height
                scrollit()
            }

            function scrollit() {
                if (document.cmarquee01.document.cmarquee02.top >= thelength * (-1)) {
                    document.cmarquee01.document.cmarquee02.top -= velocidad
                    setTimeout("scrollit()", 100)
                } else {
                    document.cmarquee01.document.cmarquee02.top = alto
                    scrollit()
                }
            }

            function fn_Tiempo() {
                setTimeout("regenerar2()", 450);
                setTimeout("location.reload()", 60000);
            }
            window.onload = fn_Tiempo;
        </script>
    </body>
</html>
