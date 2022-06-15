<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title>Valida Reincidencias</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <%
        String strclUsr = "0";
        if (session.getAttribute("clUsrApp") != null) {
            strclUsr = session.getAttribute("clUsrApp").toString();        }
        if(SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true){
            %><font color="white"  style="font-family:Verdana,Arial,Helvetica,sans-serif; background-color:red;" size=3>LA SESION EXPIRO</font><%  
            strclUsr=null;
            return;
            }
        String StrclExpediente = "0";
        String StrclServicio = "0";
        String StrclSubServicio = "0";
        String StrdsServicio = "0";
        String StrdsSubServicio = "0";
        String StrclCuenta = "0";
        String StrClave = "0";
        String StrCobertura = "";
        String areaOperativa = "0";
        String StrNumReincide = "0";
        String evAnualMensual = "0";
        String titTipoSiniest = "";
        String LimiteEventosAnuales = "0";
        String EventosAnuales = "0";
        String EventosUltimoMes = "0";
        String LimiteMensual = "0";
        String StrclTipoServicio = "0";
        Boolean noHayCupoMensual  = true;
        Boolean noHayCupoAnual = true;
        StringBuffer StrSql = new StringBuffer();
        ResultSet rsReincide = null;
        ResultSet rsGetTipoServicio = null;
        if (session.getAttribute("clExpediente") != null) {
            StrclExpediente = session.getAttribute("clExpediente").toString();        }
        if (session.getAttribute("clCuenta") != null) {
            StrclCuenta = session.getAttribute("clCuenta").toString();        }
        if (session.getAttribute("Clave") != null) {
            StrClave = session.getAttribute("Clave").toString();        }
        if (request.getParameter("clServicio") != null) {
            StrclServicio = request.getParameter("clServicio").toString();        }
        if (request.getParameter("clSubservicio") != null) {
            StrclSubServicio = request.getParameter("clSubservicio").toString();        }
        if (request.getParameter("dsServicio") != null) {
            StrdsServicio = request.getParameter("dsServicio").toString();        }
        if (request.getParameter("dsSubservicio") != null) {
            StrdsSubServicio = request.getParameter("dsSubservicio").toString();        }
        if (request.getParameter("Cobertura") != null) {
            StrCobertura = request.getParameter("Cobertura").toString();        }
        if (session.getAttribute("areaOperativa") != null) {
            areaOperativa = session.getAttribute("areaOperativa").toString();        }
        if (StrCobertura.equalsIgnoreCase("1") ) {
            /* Control de reincidencia para subservicios cubiertos */
            StrSql.append("st_ObtenLimiteEventosMensual '" + StrclCuenta + "'," + areaOperativa +",'"+StrClave+"','"+StrclSubServicio+"'");
            rsReincide = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            if (rsReincide.next()) {
                if (StrclServicio.equals("3")) {
                rsGetTipoServicio = UtileriasBDF.rsSQLNP("SELECT clTipoServicio FROM Expediente WHERE clExpediente = " + StrclExpediente );
                    if (rsGetTipoServicio.next()) {
                        StrclTipoServicio = rsGetTipoServicio.getString("clTipoServicio");
                        //Para tipo mantenimiento    
                        if (StrclTipoServicio.equals("8")) {
                            if ( rsReincide.getString("LimiteEventosAnual") != null ) {
                                LimiteEventosAnuales = rsReincide.getString("LimiteEventosAnual");                }
                            if ( rsReincide.getString("MantenimientosAnuales") != null ) {
                                EventosAnuales = rsReincide.getString("MantenimientosAnuales");                }
                            if ( rsReincide.getString("MantenimientosMensuales") != null ) {   
                                EventosUltimoMes = rsReincide.getString("MantenimientosMensuales");                }
                            if ( rsReincide.getString("LimiteMensual") != null ) {
                                LimiteMensual = rsReincide.getString("LimiteMensual");                } 
                        } else {
                            if ( rsReincide.getString("LimiteEventosAnuales") != null ) {
                                LimiteEventosAnuales = rsReincide.getString("LimiteEventosAnuales");                }
                            if ( rsReincide.getString("EmergenciasAnuales") != null ) {
                                EventosAnuales = rsReincide.getString("EmergenciasAnuales");                }
                            if ( rsReincide.getString("EmergenciasMensuales") != null ) {   
                                EventosUltimoMes = rsReincide.getString("EmergenciasMensuales");                }
                            if ( rsReincide.getString("LimiteMensual") != null ) {
                                LimiteMensual = rsReincide.getString("LimiteMensual");                }
                        }
                    }
                rsGetTipoServicio.close();
                rsGetTipoServicio = null;
                } else {
                    if ( rsReincide.getString("LimiteEventosAnuales") != null ) {
                        LimiteEventosAnuales = rsReincide.getString("LimiteEventosAnuales");                }
                    if ( rsReincide.getString("EventosAnuales") != null ) {
                        EventosAnuales = rsReincide.getString("EventosAnuales");                }
                    if ( rsReincide.getString("EventosUltimoMes") != null ) {   
                        EventosUltimoMes = rsReincide.getString("EventosUltimoMes");                }
                    if ( rsReincide.getString("LimiteMensual") != null ) {
                        LimiteMensual = rsReincide.getString("LimiteMensual");                }
                }                
                /***  SERVICIOS CUBIERTOS  ***/
                // Para servicio se tienen diferentes conteos de eventos dependiendo del tipo de asistencia              
                // si es servicio hogar y de Mantenimiento entonces no tiene control mensual y eventosUltimoMes es 0
                noHayCupoMensual = (Integer.parseInt(EventosUltimoMes) >= Integer.parseInt(LimiteMensual))  &&  Integer.parseInt(LimiteMensual) >0;
                noHayCupoAnual = (Integer.parseInt(EventosAnuales) >= Integer.parseInt(LimiteEventosAnuales) && Integer.parseInt(LimiteEventosAnuales) >0);
                if ( noHayCupoMensual || noHayCupoAnual ) {                    
                    if ( noHayCupoMensual ) {
                        evAnualMensual = "2";
                        titTipoSiniest = "LISTADO SINIESTRALIDAD MES EN CURSO";
                        StrNumReincide = EventosUltimoMes.toString();
                        %>
                        <div class='Rojo' style='position:absolute; z-index:4; left:100px; top:40px; width:400px'>
                            Ha consumido  <span style="background: #ff5"><%=EventosUltimoMes%></span>  vez/veces en el <span style="background: #ff5">MES</span>, el servicio de <%=StrdsSubServicio%>. Límite mensual  <span style="background: #ff5"><%=LimiteMensual%></span>  asistencia/s.
                        </div>
                    <% } else {
                        evAnualMensual = "1";
                        titTipoSiniest = "LISTADO SINIESTRALIDAD ANUAL";
                        StrNumReincide = EventosAnuales.toString();
                        %>
                       <div class='Rojo' style='position:absolute; z-index:4; left:100px; top:40px; width:400px'>
                            Ha consumido  <span style="background: #ff5"><%=EventosAnuales%></span>  vez/veces en el <span style="background: #ff5">AÑO</span>, el servicio de <%=StrdsSubServicio%>. Límite anual  <span style="background: #ff5"><%=LimiteEventosAnuales%></span>  asistencia/s.
                        </div>
                        <% } %>
                    <a id="carImage" name="alerta" style="position: absolute; z-index: 555; left: 30px; top: 30px;">
                        <img src="../Imagenes/warning.png" width='45' height='45' alt="Alerta">
                    </a>
                    <!-- MUESTRO LA LISTA DE EXPEDIENTES -->
                    <div class='cssBGDet' style='position:absolute; z-index:4; left:30px; top:80px; width:400px'>
                        <tr><td class='cssTitDet'> <%=titTipoSiniest%></td></tr>
                        <tr><td>
                            <table><tr><td>
                                <% StringBuffer strEntrada = new StringBuffer();
                                strEntrada.append("st_EventosPorPeriodo '" + StrclCuenta + "','"+StrClave+"','"+evAnualMensual+"'");
                                StringBuffer strSalida = new StringBuffer();
                                UtileriasBDF.rsTableNP(strEntrada.toString(), strSalida);%>
                                <%=strSalida.toString()%><%
                                strSalida.delete(0, strSalida.length());
                                strSalida = null;%>
                            </td></tr></table>
                        </td></tr>
                     <p align='center'>
                        <input type='Button' class='cBtn' value='Cancelar' onClick="window.close();"/>
                        <input type='Button' class='cBtn' value='Aceptar'  onClick="fnAceptarSiniestralidad();"/>
                     </p>
                    </div>
                    <div class='cssBGDet' style='position:absolute; z-index:1; left:10px; top:10px; width:500px; height:550px;'>
                        <p class='cssTitDet'>Control de reincidencias</p>
                    </div>
                    <script>
//------------------------------------------------------------------------------
                    /* Si selecciona la habilitacion, tengo que re-preguntar si esta seguro. */
                    function fnAceptarSiniestralidad() {
                        var r = confirm("¿Esta seguro de habilitar la asistencia?'");
                        if (r == true) {
                            <% StringBuffer strInsert = new StringBuffer();
                            strInsert.append("st_InsertaReincidencia "+StrclExpediente+",'"+strclUsr+"',"+StrNumReincide+","+StrclSubServicio);
                            UtileriasBDF.ejecutaSQLNP(strInsert.toString()); %>
                            var url = "../Operacion/DetalleAsistencia.jsp?clSubServicio=<%=StrclSubServicio%>&clServicio=<%=StrclServicio%>&dsServicio=<%=StrdsServicio%>&dsSubservicio=<%=StrdsSubServicio%>";
                            window.opener.location.href= url.toString();
                            window.close();
                        } else {  window.close();  }
                        }
//------------------------------------------------------------------------------
                    </script>
                <% } else { %>
                <script>
//------------------------------------------------------------------------------                    
                    window.opener.location.href='../Operacion/DetalleAsistencia.jsp?clSubServicio=<%=StrclSubServicio%>&clServicio=<%=StrclServicio%>&dsServicio=<%=StrdsServicio%>&dsSubservicio=<%=StrdsSubServicio%>';
                    window.close();
//------------------------------------------------------------------------------
                </script>
                <%  }
                }
            rsReincide.close();
            rsReincide = null;
            /***    SERVICIOS NO CUBIERTOS  ***/
        } else { 
            /* Control de reincidencia para subservicios no cubiertos   */
            StrSql.append("st_ValidaReincide " + StrclExpediente + "," + StrclServicio + "," + StrclSubServicio);
            rsReincide = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            String StrReincidencias  = "0";
            if (rsReincide.next()) {
                if (rsReincide.getString("Reincidencias") != null) {
                    StrReincidencias = rsReincide.getString("Reincidencias").toString();   }
                }
            rsReincide.close();
            rsReincide = null;
            %>
        <div class='Rojo' style='position:absolute; z-index:4; left:150px; top:45px; width:150px'>
            El Expediente: <%=StrclExpediente%> ha solicitado el servicio no cubierto de: <%=StrdsSubServicio%>.
        </div>
        <form action="../servlet/Utilerias.AutorizaReincideClave" method="post">
            <div class='VTable' style='position:absolute; z-index:5; left:20px; top:30px;'>
                <table>
                    <tr><td><p class='FTable'>Usuario</p></td><tr>
                    <tr><td><input id="Usr" name="Usr" class='VTable'></input></td></tr>
                    <tr><td><p class='FTable'>Password</p></td><tr>
                    <tr><td><input type="password" id="Pass" name="Pass" class='VTable'/></td></tr>
                    <input type="hidden" id="NumReincide" name="NumReincide" value="<%=StrReincidencias%>"/>
                    <input type="hidden" id="clExpediente" name="clExpediente" value="<%=StrclExpediente%>"/>
                    <input type="hidden" id="Cuenta" name="Cuenta" value="<%=StrclCuenta%>"/>
                    <input type="hidden" id="Clave" name="Clave" value="<%=StrClave%>"/>
                    <input type="hidden" id="clServicio" name="clServicio" value="<%=StrclServicio%>"/>
                    <input type="hidden" id="clSubServicio" name="clSubServicio" value="<%=StrclSubServicio%>"/>
                    <input type="hidden" id="dsServicio" name="dsServicio" value="<%=StrdsServicio%>"/>
                    <input type="hidden" id="dsSubServicio" name="dsSubServicio" value="<%=StrdsSubServicio%>"/>
                    <tr><td><input type="submit" class="cBtn" value="Entrar"/></td></tr>
                </table>
            </div>
        </form>
        <div class='cssBGDetSw' style='background-color:#052145; position:absolute; z-index:0; left:15px; top:15px; width:300px; height:150px;'>
            <p class='cssTitDet'></p>
        </div>
        <div class='cssBGDet' style='position:absolute; z-index:1; left:10px; top:10px; width:300px; height:150px;'>
            <p class='cssTitDet'>Favor de ingresar Usuario y Contraseña</p>
        </div>
        <% }
        StrclExpediente = null;
        StrclServicio = null;
        StrclSubServicio = null;
        StrdsServicio = null;
        StrdsSubServicio = null;
        StrclCuenta = null;
        StrClave = null;
        StrSql = null;
        %>
    </body>
</html>