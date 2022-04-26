<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.util.Map,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.operacion.DAOAltaCitas,com.ike.operacion.to.AltaCitas" errorPage="" %>
<html>
    <head>
        <title>Crea Cita</title> 
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
        <style>
            .bottomright {
                position: absolute;
                bottom: 50px;
                right: 40px;
            }
        </style>
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../Utilerias/UtilCalendario.js'></script>
        <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <%
            String strclUsr = "0";
            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();
                } 
            if(SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true){
                %><font color="white"  style="font-family:Verdana,Arial,Helvetica,sans-serif; background-color:red;" size=3>LA SESION EXPIRO</font><%  
                strclUsr=null;
                return;
                }
            String StrProveedor = "0";
            String StrdsProveedor = "0";
            String StrclExpediente = "0";
            String StrclCita = "0";
            String StrclEstatusCita="1";
            DAOAltaCitas daos = null;
            AltaCitas altacitas = null;
            boolean bAutomatica    = (request.getParameter("AUTO")!=null?"1".equals(request.getParameter("AUTO")):false);
            String sModo = (String)session.getAttribute("MODO");
            boolean bDirecta = false;
            if ( sModo != null && sModo.startsWith("GEO") ) {            bDirecta = true;            }
            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();            }
            ResultSet rs = UtileriasBDF.rsSQLNP( "st_getDatosEnvioGeoHogar " + StrclExpediente );
            if (rs.next()) {            
                //Si retorna registro es que fue una cancelacion de cita
                bDirecta = rs.getInt("directa") ==1;
                bAutomatica = true;
                }
            rs.close();
            if (request.getParameter("clProveedor") != null) {
                StrProveedor = request.getParameter("clProveedor").toString().trim();          }
            if (request.getParameter("NombreOpe") != null) {
                StrdsProveedor = request.getParameter("NombreOpe").toString().trim();           }
            String StrclPaginaWeb = "6131";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            MyUtil.InicializaParametrosC(6131, Integer.parseInt(strclUsr));
            if (strclUsr != null) {
                daos = new DAOAltaCitas();
                altacitas = daos.getAltaCitas(StrclCita);
                }
            if ( bDirecta ) {       out.print( MyUtil.doMenuAct("altaCitaGEOHogar.jsp", "", "") ); 
            }else {
                if ( bAutomatica) {   out.print( MyUtil.doMenuAct("altaCitaGEOHogar.jsp", "", "") ); 
                }else {  out.println( MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "", "") );    }
                }
            %>
                <input id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="CreaCita2.jsp?"%>'>
                <input id='clCita' name='clCita' type='hidden' value='<%=StrclCita%>'/>
                <input id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'/>
                <input id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'/>
                <input id='clEstatusCita' name='clEstatusCita' type='hidden' value='<%=StrclEstatusCita%>'/>
                <input id='clProveedor' name='clProveedor' type='hidden' value='<%=StrProveedor%>'/>
                <input id="enviarGeoHogar" name="enviarGeoHogar" type="hidden" value=''/>
                <input id='AUTO' name='AUTO' type='hidden' value='<%=(bAutomatica?"1":"0")%>'/>
                <input id='modo' name='modo' type='hidden' value=''/>
                <input id="FechaProgMomAux" name="FechaProgMomAux" type="hidden" value="FechaProgMom"/>       
                <input id='FechaProgMomMsk' name='FechaProgMomMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F'/>
                <%=MyUtil.ObjInput("Proveedor", "clProveedor", StrdsProveedor, false, false, 100, 80, "", false, false, 25)%>
                <%=MyUtil.ObjInputFC("Fecha Cita (AAAA-MM-DD)", "Fecha", "", true, true, 90, 120, "", true, false, 15, 1, "fnValidaFechaActual(this);")%>
                <%=MyUtil.ObjInput("Hora Desde (HH:MM)", "HoraD", "", true, true, 260, 120, "", true, false, 5,"fnHrsD(this);")%>
                <%=MyUtil.ObjInput("Hora Hasta (HH:MM)", "HoraH", "", true, true, 400, 120, "", true, false, 5,"fnHrsH(this);fnHrsCita();")%>
                <%=MyUtil.DoBlock("Nueva Cita", 0,0)%>
                <input type="button" class="cBtn" value="Cerrar" onclick="javascript:top.opener.location.reload();window.close();">
                <%=MyUtil.GeneraScripts()%>
                <%
                    strclUsr = null;
                    daos = null;
                    altacitas = null;
                %>
        <script type="text/javascript" >  
//------------------------------------------------------------------------------
            document.getElementById("enviarGeoHogar").value = opener.parent.frames['DatosExpediente'].datos.modo.value;
//------------------------------------------------------------------------------
            function fnHrsCita(){
                var StrHoraD=devolverMinutos(document.getElementById("HoraD").value);
		var StrHoraH=devolverMinutos(document.getElementById("HoraH").value);
                var StrDifHr = (StrHoraH-StrHoraD);
                if(StrHoraH  < StrHoraD && StrHoraD < 1261){          alert("Rango no permitido");
                }else if(StrDifHr > 180){    alert("No se puede ingresar un rango mayor a 3 hs");
                }else if(StrDifHr < 0){
                    StrHoraH = (StrHoraH + 1440) - StrHoraD;
                    if(StrHoraH > 180){       alert("No se puede ingresar un rango mayor a 3 hs");          } 
                    }
                }
//------------------------------------------------------------------------------
            function fnHrsD(campo){
                var StrHoraDL=(document.getElementById("HoraD").value.length);                
                    if(StrHoraDL <= 2){                   
                        var StrHoraDV=(document.getElementById("HoraD").value);
                        var min=":00";
                        var res = StrHoraDV.concat(min);
                        campo.value=res;
                }
                validaHora(campo);
            }
//------------------------------------------------------------------------------
            function fnHrsH(campo){
                var StrHoraHL=(document.getElementById("HoraH").value.length);                
                    if(StrHoraHL <= 2){                   
                        var StrHoraHV=(document.getElementById("HoraH").value);
                        var min=":00";
                        var res = StrHoraHV.concat(min);
                        campo.value=res;
                }
                validaHora(campo);
            }
//------------------------------------------------------------------------------
            function validaHora(campo){
                var patt =/^\d{2}:\d{2}/g
                if(!patt.test(campo.value)){
                    campo.value="";
                    alert("Formato 24 Hrs (hh:mm)");
                }else{
                    var agr=campo.value.split(":");
                    if(parseInt(agr[0])>24||parseInt(agr[1])>59){
                        campo.value="";
                        alert("Formato 24 Hrs (hh:mm)");
                    }
                }
            }
//------------------------------------------------------------------------------
            function devolverMinutos(horaMinutos){
                var horass=((horaMinutos.split(":")[0])*60);
                var minutoss=(horaMinutos.split(":")[1]);               
                var sumHM= (1*horass+ minutoss*1);              
                return sumHM;
            }     
//------------------------------------------------------------------------------
            function isValidDate(d) {
                return d instanceof Date && !isNaN(d);            }
//------------------------------------------------------------------------------
            function fnValidaFechaActual(campo){  
                var anio =  parseInt(campo.value.substring(0),10);
                var nva_fecha = new Date();
                var anio_mas_uno = parseInt(nva_fecha.getFullYear()) + 1;    
                var FechaC1 = document.getElementById("Fecha").value;
                var FechaC = FechaC1.substring(0, 10); 
                campo.value=FechaC;
            }
//------------------------------------------------------------------------------
        </script>
    </body>
</html>
