<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="com.ike.asistencias.DAOAsistenciaTrasladoCortesia,com.ike.asistencias.to.DetalleAsistenciaTrasladoCortesia,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
    <head>
        <title>Detalle Asistencia Traslado Cortesia</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css"> 
    </head>
    <body class="cssBody" OnLoad="">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAuto.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>
        <script type="text/javascript" src="../../Geolocalizacion/modernizr-custom.js"></script>
        <script type="text/javascript" src="../../Geolocalizacion/js/jquery.js"></script>
        <script type="text/javascript" src="../../Geolocalizacion/js/mapUtils.js"></script>
        <script src="../../Utilerias/UtilCalendario.js"></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        
        <%
            String StrclUsrApp = "";
            String StrclExpediente = "";
            String StrclPaginaWeb = "6171";
            //  DATOS DE LA UBICACION ORIGEN, VIENEN DEL EXPEDIENTE EN SESION
            String StrclPais = "10";
            String StrdsPais = "";
            String StrdsEntFed = "";
            String StrCodEnt = "";
            String StrdsMunDel = "";
            String StrCodMD = "";
            String StrCalleNum = "";
            String StrclCuenta = "0";
            String StrClave = "";
            String StrdsSubServicio = "";
            String StrLimiteMonto = "";
            String StrclSubServicio = "0";
            String StrclUbFallaH = "0";


            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }
            if (session.getAttribute("clPais") != null) {
                StrclPais = session.getAttribute("clPais").toString();
            }
            if (session.getAttribute("dsPais") != null) {
                StrdsPais = session.getAttribute("dsPais").toString();
            }
            if (session.getAttribute("clCuenta") != null) {
                StrclCuenta = session.getAttribute("clCuenta").toString();
            }
            if (session.getAttribute("Clave") != null) {
                StrClave = session.getAttribute("Clave").toString();
            }
            if (session.getAttribute("dsSubServicio") != null) {
                StrdsSubServicio = session.getAttribute("dsSubServicio").toString();
            }           
            if (session.getAttribute("clSubServicio") != null) {
                StrclSubServicio = session.getAttribute("clSubServicio").toString();
            }
            
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %>Fuera de Horario<%
                return;
            }

            ResultSet cdr = UtileriasBDF.rsSQLNP( "sp_DetalleExpediente " + StrclExpediente );
            if (cdr.next()) {
                StrCodEnt   = cdr.getString("CodEnt");
                StrdsEntFed = cdr.getString("dsEntFed");
                StrCodMD    = cdr.getString("CodMD");
                StrdsMunDel = cdr.getString("dsMunDel");
            }
            else {
                out.println("ERROR NO SE PUEDE OBTENER DATOS DEL EXPEDIENTE");
                return;
            }
            StringBuffer StrSql = new StringBuffer();
            StringBuffer StrSql2 = new StringBuffer();
            DAOAsistenciaTrasladoCortesia daoAH = null;
            DetalleAsistenciaTrasladoCortesia AH = null;
            StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            if (rs.next()) {
                daoAH = new DAOAsistenciaTrasladoCortesia();
                AH = daoAH.getDetalleAsistenciaTrasladoCortesia(StrclExpediente);
            } else {
                %> El expediente no existe <%
                rs.close();
                rs = null;
                return;
            }             
                    
            StrSql = new StringBuffer();
            StrSql.append(" st_getDatosAfiliadoGral '").append(StrClave).append("','").append(StrclCuenta).append("'");
            ResultSet rsDatosAfil = UtileriasBDF.rsSQLNP(StrSql.toString());
            if (rsDatosAfil.next()) {
                StrCalleNum = rsDatosAfil.getString("calleNum");
            }
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            
        %>
        <script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(162, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "","", "")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="TrasladoCortesia.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
       
        <input id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubServicio%>'>
        <input id='dsSubservicio' name='dsSubservicio' type='hidden' value='<%=StrdsSubServicio%>'>


        <input id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrApp%>'>
        
        <%=MyUtil.ObjInput("Motivo", "Motivo",AH != null ? AH.getMotivo() : "", true, true, 30, 82, "", true, false, 25)%>
        <%=MyUtil.ObjInput("Cantidad de <br> Personas", "CantPersonas",AH != null ? AH.getCantPersonas() : "", true, true, 210, 70, "", true, false, 3)%>
        
        
        
        <%=MyUtil.ObjInputF("Fecha de Traslado", "FechaTraslado",AH != null ? AH.getFechaTraslado() :"", true, true, 300, 82, "", true, false,20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaSiniestraMsk.value,this.name)};")%>              
        <%=MyUtil.ObjInput("Hora (24 hrs.)", "HoraD",AH != null ? AH.getHoraD() : "", true, true, 480, 82, "", true, false, 6,"fnHrsD(this);")%>
 
        <%=MyUtil.DoBlock("Datos de Traslado", 10, 10)%>
        
        
        <!-- GEOLOC ORIGEN-->
        <%
        String sTmpDirA = new String( StrdsEntFed + ", " + StrdsMunDel + ", " + (AH != null ? AH.getCalleO(): "") );
        %>
        
        <input type="hidden" name="calleO" id="DireccionA" value="<%=sTmpDirA%>" >
        <div class='VTable' style='position:absolute; z-index:20; left:580px; top:200px; '>
            <INPUT id="MapaOrig" type='button' VALUE='Mapa' onClick='openMap("DireccionA", "LatLongO","CalleO","dsMunDelO","dsEntFedO","CodMDO","CodEntO");return false;' class='cBtn'>
        </div>
        <%=MyUtil.ObjInput("Provincia", "dsEntFedO", StrdsEntFed, false, false, 30, 190, StrdsEntFed, false, false, 45)%>
        <%=MyUtil.ObjInput("Localidad", "dsMunDelO", StrdsMunDel, false, false, 300, 190, StrdsEntFed, false, false, 45)%>
        <input type="hidden" id="CodMD" name="CodMDO" value="<%=StrCodMD%>">
        <input type="hidden" id="CodEnt" name="CodEntO" value="<%=StrCodEnt%>">  
        <%=MyUtil.ObjInput("Calle", "CalleO",AH != null ? AH.getCalleO() : "", true, true, 30, 240, "",  true, false, 58)%>
        <%=MyUtil.ObjInput("Latitud y Longitud", "LatLongO", AH != null ? AH.getLatLongO(): "", true, true, 380, 240, "", true, false, 34)%>   
        <%=MyUtil.ObjTextArea("Referencias Visuales", "ReferenciasO", AH != null ? AH.getReferenciasO() : "", "75", "5", true, true, 30, 285, "", true, false)%>
        <%=MyUtil.DoBlock("Ubicación Origen", 80, 40)%>

        <!-- GEOLOC DESTINO-->
        <%
        String sTmpDirB = new String( StrdsEntFed + ", " + StrdsMunDel + ", " + (AH != null ? AH.getCalleD(): "") );
        %>
        
        <input type="hidden" name="calleD" id="DireccionB" value="<%=sTmpDirB%>" >
        <div class='VTable' style='position:absolute; z-index:20; left:580px; top:430px; '>
            <INPUT id="MapaDest" type='button' VALUE='Mapa' onClick='openMap("DireccionB", "LatLongD","CalleD","dsMunDelD","dsEntFedD","CodMDD","CodEntD");return false;' class='cBtn'>
        </div>
        <%=MyUtil.ObjInput("Provincia", "dsEntFedD", StrdsEntFed, false, false, 30, 420, StrdsEntFed, false, false, 45)%>
        <%=MyUtil.ObjInput("Localidad", "dsMunDelD", StrdsMunDel, false, false, 300, 420, StrdsEntFed, false, false, 45)%>
        <input type="hidden" id="CodMD" name="CodMDD" value="<%=StrCodMD%>">
        <input type="hidden" id="CodEnt" name="CodEntD" value="<%=StrCodEnt%>">  
        <%=MyUtil.ObjInput("Calle", "CalleD",AH != null ? AH.getCalleD() : "", true, true, 30, 470, "", true, false, 58)%>
        <%=MyUtil.ObjInput("Latitud y Longitud", "LatLongD", AH != null ? AH.getLatLongD(): "", true, true, 380, 470, "", true, false, 34)%>   
        <%=MyUtil.ObjTextArea("Referencias Visuales", "ReferenciasD", AH != null ? AH.getReferenciasD() : "", "75", "5", true, true, 30, 515, "", true, false)%>
        <%=MyUtil.DoBlock("Ubicación Destino", 80, 40)%>
        
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", AH != null ? AH.getObservaciones() : "", "75", "5", true, true, 30, 650, "", false, false)%>
        <%=MyUtil.ObjInput("Costo:", "Costo",AH != null ? AH.getCosto() : "", true, true, 475, 650, "", false, false, 10)%>              
        <%=MyUtil.DoBlock("Detalle de " + StrdsSubServicio, 10, 40)%>
       
      
        <%=MyUtil.GeneraScripts()%>
        <input name='FechaSiniestraMsk' id='FechaSiniestraMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>


        <%
            rs.close();
            rs = null;
            daoAH = null;
            AH = null;
        %>
        <input name='FechaProgMomMsk' id='FechaProgMomMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <script type="text/javascript" >
          
     

    
    
           $(document).ready(function() {
                $("#btnCambio").click(function() {
                    document.getElementById("DireccionA").disabled = false; 
                });
                $("#btnAlta").click(function() {
                    document.getElementById("DireccionA").disabled = false; 
                });
                $("#CalleNum").change(function() {
                    document.getElementById("LatLong").value = "";
                })
            });

            function setupClickListener(id) {
              var button = document.getElementById(id);
              button.addEventListener('click', function() {
                fillInAddress();
              });
            }

            function openMap(campo, latLong, calle, localidad, provincia,codMD, codEnt) {
                direccion = document.getElementById(campo).value;
                geo = window.open('../../Geolocalizacion/gmap3.jsp?dire='+ direccion +'&dDir=' + campo + '&dLatLon=' + latLong
                + '&fCalle=' + calle + "&fLoc=" + localidad + "&fPro=" + provincia + "&fCodMD=" + codMD + "&fCodEnt=" + codEnt, 'GEO',
                'modal=yes,resizable=yes,menubar=0,status=0,toolbar=0,height=820,width=1200,screenX=1,screenY=1');
                geo.focus();
            }
    
            function fnBuscaGeo() {
                var pstrCadena = "/SISE_AR/Geolocalizacion/showMap.jsp";
                window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=900,height=800');
            }
            
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

            
        </script>
    </body>
</html>