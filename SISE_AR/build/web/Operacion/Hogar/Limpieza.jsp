<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="com.ike.asistencias.DAOAsistenciaHogar,com.ike.asistencias.to.DetalleAsistenciaHogar,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
    <head>
        <title>Detalle Asistencia Limpieza</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" OnLoad="fnMuestraDivs();">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAuto.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>
        <script type="text/javascript" src="../../Geolocalizacion/modernizr-custom.js"></script>
        <script type="text/javascript" src="../../Geolocalizacion/js/jquery.js"></script>
        <script type="text/javascript" src="../../Geolocalizacion/js/mapUtils.js"></script>
        <%
            String StrclUsrApp = "";
            String StrclExpediente = "";
            String StrclPaginaWeb = "6169";
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
            boolean StrObligaE = false;
            boolean StrObligaL = false;
            boolean StrObligaT = false;
            boolean StrObligaA = false;
            boolean StrObligaMed = false;
            
         


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


            if(StrclSubServicio.equals("479")){
                StrObligaE = true;
            }

            if(StrclSubServicio.equals("480")){
                StrObligaL = true;
            }

            if(StrclSubServicio.equals("481")){
                StrObligaT = true;
            }

            if(StrclSubServicio.equals("482")){
                StrObligaA = true;
                StrObligaMed = true;
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
            DAOAsistenciaHogar daoAH = null;
            DetalleAsistenciaHogar AH = null;
            StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            if (rs.next()) {
                daoAH = new DAOAsistenciaHogar();
                AH = daoAH.getDetalleAsistenciaHogar(StrclExpediente);
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
            int iRowPx = 80;
        %>
        <script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(162, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "","", "")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="Limpieza.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='InfoFinal' name='InfoFinal' type='hidden' value='<%=AH!=null?AH.getInformeF():"0"%>'>
        <input id='clSubservicio' name='clSubservicio' type='hidden' value='<%=StrclSubServicio%>'>
        <input id='dsSubservicio' name='dsSubservicio' type='hidden' value='<%=StrdsSubServicio%>'>
        


        <input id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrApp%>'>
        <!-- GEOLOC TARGET LOCAL-->
        <%
        String sTmpDirA = new String( StrdsEntFed + ", " + StrdsMunDel + ", " + (AH != null ? AH.getCalle(): "") );
        %>
        <!-- %=MyUtil.ObjInput("Direccion", "DireccionA", sTmpDirA ,  true, true, 30,110, "", true, true, 80 )% -->
        <input type="hidden" name="calle" id="DireccionA" value="<%=sTmpDirA%>" >
        <div class='VTable' style='position:absolute; z-index:20; left:510px; top:<%=iRowPx+16%>px; '>
            <INPUT id="MapaOrig" type='button' VALUE='Mapa' onClick='openMap("DireccionA", "LatLong","Calle","dsMunDel","dsEntFed","CodMD","CodEnt");return false;' class='cBtn'>
        </div>
        <%=MyUtil.ObjInput("Provincia", "dsEntFed", StrdsEntFed, false, false, 30, iRowPx, StrdsEntFed, false, false, 45)%>
        <%=MyUtil.ObjInput("Localidad", "dsMunDel", StrdsMunDel, false, false, 280, iRowPx, StrdsEntFed, false, false, 45)%>
        <input type="hidden" id="CodMD" name="CodMD" value="<%=StrCodMD%>">
        <input type="hidden" id="CodEnt" name="CodEnt" value="<%=StrCodEnt%>">
        <%
        iRowPx = iRowPx + 30;
        %>
        <%=MyUtil.ObjInput("Calle", "Calle",AH != null ? AH.getCalle() : "", true, true, 30, iRowPx, "", true, false, 58)%>
        <%=MyUtil.ObjInput("Latitud y Longitud", "LatLong", AH != null ? AH.getLatLong(): "", true, true, 330, iRowPx, "", true, false, 34)%>

        <%
        iRowPx = iRowPx + 30;
        %>
        <%=MyUtil.ObjTextArea("Referencias Visuales", "Referencias", AH != null ? AH.getReferencias() : "", "75", "5", true, true, 30, iRowPx, "", true, false)%>
        <%=MyUtil.DoBlock("Domicilio", 80, 40)%>

        <%
        iRowPx = iRowPx + 130;
        %>
        
        <div id='divEmpleada'>
            <%=MyUtil.ObjInput("Cantidad de Horas", "CantHorasL",AH != null ? AH.getCantHorasL() : "", true, true, 30, iRowPx, "", StrObligaE, false, 10)%>
        </div>
        
        <div id='divLavanderia'>
            <%=MyUtil.ObjInput("Peso", "PesoL",AH != null ? AH.getPesoL() : "", true, true, 475, iRowPx, "", false, false, 10)%>
            <%=MyUtil.ObjInput("Cantidad de Prendas", "CantPrendasL",AH != null ? AH.getCantPrendasL() : "", true, true, 30, iRowPx, "", StrObligaL, false, 10)%>
        </div>
        
        <div id='divTapizado'>
            <%=MyUtil.ObjInput("Tipo de Mueble", "MuebleL",AH != null ? AH.getMuebleL() : "", true, true, 30, iRowPx, "", StrObligaT, false, 50)%>
            <%=MyUtil.ObjInput("Tipo de Tapizado", "TapizadoL",AH != null ? AH.getTapizadoL() : "", true, true, 475, iRowPx, "", StrObligaT, false, 25)%>
        </div>
        
        <div id='divAlfombras'>
            <%=MyUtil.ObjInput("Tipo de Alfombra", "AlfombraL",AH != null ? AH.getAlfombraL() : "", true, true, 30, iRowPx, "", StrObligaA, false, 50)%>
        </div>
        
        <div id='divHandyman'>
            <%=MyUtil.ObjInput("Listado", "dsCondicionadoL",AH != null ? AH.getdsCondicionadoL() : "", true, true, 30, iRowPx, "", false, false, 50)%>
            <%=MyUtil.ObjComboC("Ubicacion de falla", "clUbFallaH", AH != null ? AH.getDsUbFallaH() : "", true, true, 550, iRowPx, "", "st_getUbicacionF ", "", "", 50, false, false)%>       
        </div>
        
         <div id='divMedidas'>
            <%=MyUtil.ObjInput("Medidas", "MedidasL",AH != null ? AH.getMedidasL() : "", true, true, 380, iRowPx, "", StrObligaMed, false, 15)%>   
         </div>
        
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", AH != null ? AH.getObservaciones() : "", "75", "5", true, true, 30, iRowPx+50, "", false, false)%>
        <%=MyUtil.ObjInput("Costo:", "Costo",AH != null ? AH.getCosto() : "", true, true, 475, iRowPx+50, "", false, false, 10)%>              
        <%=MyUtil.DoBlock("Detalle de " + StrdsSubServicio, 20, 45)%>
        <%
        iRowPx = iRowPx + 110;
        %>
      
        <%=MyUtil.GeneraScripts()%>

        <%
            rs.close();
            rs = null;
            daoAH = null;
            AH = null;
        %>
        <input name='FechaProgMomMsk' id='FechaProgMomMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <script type="text/javascript" >
          
          document.all.divEmpleada.style.visibility = "hidden";
          document.all.divLavanderia.style.visibility = "hidden";
          document.all.divTapizado.style.visibility = "hidden";
          document.all.divAlfombras.style.visibility = "hidden";
          document.all.divHandyman.style.visibility = "hidden";
          document.all.divMedidas.style.visibility = "hidden";
    
    
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
            
            function fnMuestraDivs() {

                
                if (document.all.clSubservicio.value == '479') {
                    document.all.divEmpleada.style.visibility = "visible";                   
                } 
                else {
                    if (document.all.clSubservicio.value == '480') {
                    document.all.divLavanderia.style.visibility = "visible";                  
                    }
                    else{
                        if (document.all.clSubservicio.value == '481') {
                        document.all.divTapizado.style.visibility = "visible";                  
                        }
                        else {
                            if (document.all.clSubservicio.value == '482') {
                                document.all.divMedidas.style.visibility = "visible";    
                                document.all.divAlfombras.style.visibility = "visible";                  
                            }
                            else {
                             if (document.all.clSubservicio.value == '483') {
                            document.all.divMedidas.style.visibility = "visible";       
                            document.all.divHandyman.style.visibility = "visible";                  
                            }
                            }
                        }
                    }
                }
            }

            
        </script>
    </body>
</html>