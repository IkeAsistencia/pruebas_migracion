<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" import="Utilerias.ResultList,Seguridad.SeguridadC" %>
<html>
    <head><title>Encuestas</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <script type="text/javascript">
            if (history.forward(1)) {
                history.replace(history.forward(1));     }
        </script>
    </head>
    <body class="cssBody" onload="fnDatosDefault();">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js' ></script>
        <script type="text/javascript" src='../../Utilerias/UtilStore.js' ></script>
        <script type="text/javascript" src='../../Utilerias/UtilCalendario.js' ></script>
        <link href='../../StyleClasses/Calendario.css' rel='stylesheet' type='text/css'>
        <%
            String StrclUsr = "0";
            if (session.getAttribute("clUsrApp") != null) {
                StrclUsr = session.getAttribute("clUsrApp").toString();
            }
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr)) != true) {
                %> Fuera de Horario <%
                StrclUsr = null;
                return;            }
            String StrclPaginaWeb = "0";
            String StrclAsistencia = "0";
            String StrclConcierge = "0";
            String StrclSubservicio = "0";
            String StrURL = "";
            String StrPregunta = "0";
            StrclPaginaWeb = "713";
            String StrMailC = "";
            String StrMailP = "";
            String StrMailA = "";
            String StrMailO = "";
            String StrMailAsis = "";
            String StrMail2Asis = "";
            String StrclCuenta = "";
            ResultList rsAsist = null;
            if (session.getAttribute("clCuenta") != null) {
                StrclCuenta = session.getAttribute("clCuenta").toString();     }
            if (request.getParameter("clAsistencia") != null) {
                StrclAsistencia = request.getParameter("clAsistencia").toString();       }
            if (request.getParameter("URLASISTENCIA") != null) {
                StrURL = request.getParameter("URLASISTENCIA").toString();      }
            if (request.getParameter("clConcierge") != null) {
                StrclConcierge = request.getParameter("clConcierge").toString();        }
            if (request.getParameter("clSubservicio") != null) {
                StrclSubservicio = request.getParameter("clSubservicio").toString();      }
            if (request.getParameter("Pregunta") != null) {
                StrPregunta = request.getParameter("Pregunta").toString();          }
/*          StringBuffer StrSql = new StringBuffer();
            StrSql.append(" st_CSgetEmailsNU '").append(StrclConcierge).append("'");
            ResultSet rsAsist = UtileriasBDF.rsSQLNP(StrSql.toString());*/
            rsAsist = new ResultList();
            rsAsist.rsSQL("st_CSgetEmailsNU '"+StrclConcierge+"'");
            if (rsAsist.next()) {
                StrMailC = rsAsist.getString("Email");
                StrMailP = rsAsist.getString("EmailP");
                StrMailA = rsAsist.getString("EmailA");
                StrMailO = rsAsist.getString("EmailO");
                StrMailAsis = rsAsist.getString("EmailAsis");
                StrMail2Asis = rsAsist.getString("Email2Asis");
            }
            rsAsist.close();
            rsAsist=null;
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            //<<<<<<<<<<<< Servlet Generico >>>>>>>>>>>
            String Store = "";
            Store = "st_GuardaCSEncuestas, ";
            session.setAttribute("sp_Stores", Store);
            String Commit = "";
            Commit = "clEncuesta";
            session.setAttribute("Commit", Commit);
            int iY = 0;
        %><%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsr));%>
        <form id="forma" name="forma" action="../../servlet/com.ike.guarda.EjecutaSP" method="post">
            <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=StrURL%><%="?clAsistencia=" + StrclAsistencia + "&clConcierge=" + StrclConcierge + "&"%>'>
            <input id="clPaginaWeb" name="clPaginaWeb" type="hidden" value="<%=StrclPaginaWeb%>" >
            <input id="Secuencia" name="Secuencia" type="hidden" value="">
            <!--input id="SecuenciaG" name="SecuenciaG" type="hidden" value="clConcierge,clAsistencia,clSubservicio,clUsrApp,Marcar,Peticion,clPaisDestino,clCiudadDestino,TiempoContacto,MailContacto"!-->
            <input id="SecuenciaG" name="SecuenciaG" type="hidden" value="clConcierge,clAsistencia,clSubservicio,clUsrApp,Marcar,Peticion,clPaisDestino,clCiudadDestino,TiempoContacto,MailContacto,EsItinerario,ParteItinerario,NombreItinerario,clItinerario"/>
            <input id="SecuenciaA" name="SecuenciaA" type="hidden" value="">
            <input id="clConcierge" name="clConcierge" type="hidden" value="<%=StrclConcierge%>" >
            <input id="clAsistencia" name="clAsistencia" type="hidden" value="<%=StrclAsistencia%>" >
            <input id="clSubservicio" name="clSubservicio" type="hidden" value="<%=StrclSubservicio%>" >
            <input id="clUsrApp" name="clUsrApp" type="hidden" value="<%=StrclUsr%>" >
            <input id="Pregunta" name="Pregunta" type="hidden" value="<%=StrPregunta%>" >
            <input id="clCuenta" name="clCuenta" type="hidden" value="<%=StrclCuenta%>" >
            <input id="MailContacto" name="MailContacto" type="hidden" value="">
            <input name='Action' id='Action' type='hidden' value="1">
            <%iY = 50;%>
            <div  class='VTable' size='60'  style='position:absolute; z-index:0; left:30px; top:<%=iY%>px; background-color: #A9D0F5; layer-background-color: #848484; width: 582px; height: 11px;  ' align="center"><strong>ESTADÍSTICOS</strong></div>
            <div class='FTable'  id="2" style='position:absolute; z-index:0; left:30px; top:<%=iY + 10%>px; background-color: #FFFFFF; layer-background-color: #FFFFFF; width: 582px; height: 90px;' ></div>
            <%=MyUtil.ObjComboC("<strong>Recepción de Solicitud</strong>", "Peticion", "", true, true, 40, iY + 20, "0", "select clTipoPeticion,dsTipoPeticion,Secuencia from cCSTipoPeticion order by 3 asc", "fnValidaTipoPeticion(this);fnHabilitaBtnEnviar();fnMuestraEncuesta();", "", 30, false, false)%>
            <%=MyUtil.ObjComboC("<strong>País Destino del Servicio</strong>", "clPaisDestino", "", true, true, 210, iY + 20, "0", "st_CSPaisDestino", "fnLlenaCiudadDestino();fnHabilitaBtnEnviar();fnMuestraEncuesta();", "", 30, false, false)%>
            <%=MyUtil.ObjComboC("<strong>Ciudad Destino del Servicio</strong>", "clCiudadDestino", "", true, true, 435, iY + 20, "0", "st_CSCiudadDestino", "fnHabilitaBtnEnviar();fnMuestraEncuesta();", "", 30, false, false)%>
            <%if(!StrclSubservicio.equalsIgnoreCase("39")){%>
                <%=MyUtil.ObjComboC("<strong>Tiempo de Contato</strong>","TiempoContacto","",true,true,40,iY+60,"0","st_CSLlenaComboTiemConta","fnHabilitaBtnEnviar();fnMuestraEncuesta();fnMuestraItinerario();","",30,false,false)%>
                <script>
//--------------------------------------------------------------------
                    document.all.TiempoContacto.disabled = false;
                    document.all.TiempoContactoC.disabled = false;
//------------------------------------------------------------------------------    
                </script>
            <%}else{%>
                <!--div id="TiempoContactoDIV" name="TiempoContactoDIV" style="position:absolute; top:<%=iY+60%>px;left: 40px"-->
                    <!--p class='FTable'><strong>Tiempo de Contacto</strong><br-->
                        <!--<input id="TiempoContacto"  name="TiempoContacto" type="text" value="72 horas" class='VTable' readonly />-->
                <%=MyUtil.ObjComboC("<strong>Tiempo de Contacto</strong>","TiempoContacto","",false,false,40,iY+60,"0","st_CSLlenaComboTiemConta","fnHabilitaBtnEnviar();fnMuestraEncuesta();fnMuestraItinerario();","",30,false,false)%>
            </p>
                <!--/div-->
            <%}%>            
                <div id="Envio" name="Envio" style="position:absolute; top: 10px;left: 30px">
                    <input class="cBtn" type="button" value="Enviar" onclick="fnArmaMailsContacto();fnGuarda();" id="BtnEnviar" name="BtnEnviar">
                </div>
            <%iY = iY + 115;%>
            <div id="CorreosDIV" name="CorreosDIV" style="position:absolute; left:0px; width: 582px; visibility:hidden">
                <div class='VTable' size='60'  style='position:absolute; z-index:-105; left:30px; top:<%=iY%>px; background-color: #A9D0F5; layer-background-color: #848484; width: 582px; height: 10px;  ' align="center"><strong>DIRECCIONES DE CORREO ELECTRÓNICO</strong></div>
                <div class='FTable'  id="3" style='position:absolute; z-index:-106; left:30px; top:<%=iY + 10%>px; background-color: #FFFFFF; layer-background-color: #FFFFFF; width: 582px; height: 260px;' ></div>
                <%=MyUtil.ObjInput("E-mail Comercial", "Email", StrMailC, true, true, 40, iY + 20, StrMailC, false, false, 45, "validaCorreo(this);")%>
                <%=MyUtil.ObjChkBox("", "EmailC_Env", "", true, true, 350, iY + 20, "0", "SI", "NO", "fnValidaCorreos();")%>
                <%=MyUtil.ObjInput("E-mail Personal", "EmailP", StrMailP, true, true, 40, iY + 60, "", false, false, 45, "validaCorreo(this);")%>
                <%=MyUtil.ObjChkBox("", "EmailP_Env", "", true, true, 350, iY + 60, "0", "SI", "NO", "fnValidaCorreos();")%>
                <%=MyUtil.ObjInput("E-mail Alternativo", "EmailA", StrMailA, true, true, 40, iY + 100, "", false, false, 45, "validaCorreo(this);")%>
                <%=MyUtil.ObjChkBox("", "EmailA_Env", "", true, true, 350, iY + 100, "0", "SI", "NO", "fnValidaCorreos();")%>
                <%=MyUtil.ObjInput("E-mail Otro", "EmailO", StrMailO, true, true, 40, iY + 140, "", false, false, 45, "validaCorreo(this);")%>
                <%=MyUtil.ObjChkBox("", "EmailO_Env", "", true, true, 350, iY + 140, "0", "SI", "NO", "fnValidaCorreos();")%>
                <%=MyUtil.ObjInput("E-mail Asistente", "EmailAsis", StrMailAsis, true, true, 40, iY + 180, "", false, false, 45, "validaCorreo(this);")%>
                <%=MyUtil.ObjChkBox("", "EmailAsis_Env", "", true, true, 350, iY + 180, "0", "SI", "NO", "fnValidaCorreos();")%>
                <%=MyUtil.ObjInput("E-mail Asistente alternativo", "Email2Asis", StrMail2Asis, true, true, 40, iY + 220, "", false, false, 45, "validaCorreo(this);")%>
                <%=MyUtil.ObjChkBox("", "EmailAsis2_Env", "", true, true, 350, iY + 230, "0", "SI", "NO", "fnValidaCorreos();")%>
            </div>
            <div name='EncuestaDIV' id='EncuestaDIV' style='position:absolute; z-index:1000; left:600px; top:10px; visibility:hidden;'>
                <div  class='VTable' size='60'  style='position:absolute; z-index:0; left:30px; top:40px; background-color: #A9D0F5; layer-background-color: #848484; width: 572px; height: 10px;  ' align="center"><strong>MASTER CARD</strong></div>
                <div class='FTable'  id="1" style='position:absolute; z-index:0; left:30px; top:50px; background-color: #FFFFFF; layer-background-color: #FFFFFF; width: 572px; height: 90px;' >
                    <p style='position:absolute; z-index:100; left:10px;'>MASTERCARD NECESITA CONOCER SU OPINIÓN SOBRE SU EXPERIENCIA CON EL SERVICIO DE CONCIERGE, PARA BRINDARLE UN MEJOR Y MÁS EFICIENTE SERVICIO EN FUTURAS OCASIONES.</p>
                    <%=MyUtil.ObjComboC("<strong>LE ENVIAREMOS UNA ENCUESTA DE SATISFACCIÓN POR E-MAIL, ESTÁ USTED DE ACUERDO?</strong>", "Marcar", "", true, true, 10,40, "0", "SELECT clRespuesta, dsRespuesta FROM CScRespuesta", "fnHabilitaBtnEnviar();", "", 130, false, false)%>
                    <br><br><br><br><br>
                </div>

                <script>
                    document.all.Marcar.disabled = false;
                    document.all.MarcarC.disabled = false;
                </script>
            </div>
            <div name='EncuestaItinerario' id='EncuestaItinerario' style='position:absolute; z-index:1000; left:600px; top:180px; visibility:hidden;'>
                <div  class='VTable' size='60'  style='position:absolute; z-index:1001; left:30px; top:40px; background-color: #A9D0F5; layer-background-color: #848484; width: 572px; height: 10px;' align="center"><strong>CONSULTAS</strong></div>
                <div class='FTable'  id="1" style='position:absolute; z-index:0; left:30px; top:50px; background-color: #FFFFFF; layer-background-color: #FFFFFF; width: 572px; height: 215px;'>
                    <br><br><br><br><br>
                </div>       
                <%=MyUtil.ObjComboC("Es Consulta","EsItinerario","",true,true,40,60,"0","st_LlenacomboSINO","fnMuestraParteItin();","",30,true,true)%>
                <div name="DivParteItin" id="DivParteItin" style='position:absolute; z-index:1001; visibility:hidden; width: 582px; height: 11px;'>
                    <%=MyUtil.ObjComboC("Parte de Consulta","ParteItinerario","",true,true,40,100,"0","st_LlenacomboParteItinerario","fnMuestradsItin();","",30,true,true)%>
                </div>
                <div name="DivNombreItin" id="DivNombreItin" style='position:absolute; z-index:1001; visibility:hidden; width: 582px; height: 11px;'>
                <%=MyUtil.ObjInput("Nombre de Consulta","NombreItinerario","",true,true,40,140,"",true,true,45,"")%>
                </div>
                <div name="DivclItitin" id="DivclItitin" style='position:absolute; z-index:1001; visibility:hidden; width: 582px; height: 11px;'>
                <%=MyUtil.ObjComboC("Itinerario","clItinerario","",true,true,40,140,"0","st_CSLlenaComboItinerario '"+StrclConcierge+"'","","",30,true,true)%>
                </div>
            </div>
        </form>
        <%=MyUtil.GeneraScripts()%>
        <%  //<<<<<<<<<<<<<<<< Limpiar Variables >>>>>>>>>
            StrclUsr = null;
            StrclPaginaWeb = null;
            StrclPaginaWeb = null;
            StrclUsr = null;
            StrclPaginaWeb = null;
            StrclAsistencia = null;
            StrclConcierge = null;
            StrclSubservicio = null;
            StrURL = null;
            StrPregunta = null;
            StrMailC = null;
            StrMailP = null;
            StrMailA = null;
            StrMailO = null;
            StrMailAsis = null;
            StrMail2Asis = null;
            StrclCuenta = null;
        %>
        <script type="text/javascript" >
        //------------------------------------------------------------------------------
            document.all.Peticion.disabled = false;
            document.all.PeticionC.disabled = false;
            document.all.clPaisDestino.disabled = false;
            document.all.clPaisDestinoC.disabled = false;
            document.all.clCiudadDestino.disabled = false;
            document.all.clCiudadDestinoC.disabled = false;
            document.all.EmailC_EnvC.disabled = false;
            document.all.EmailA_EnvC.disabled = false;
            document.all.EmailO_EnvC.disabled = false;
            document.all.EmailP_EnvC.disabled = false;
            document.all.EmailAsis_EnvC.disabled = false;
            document.all.EmailAsis2_EnvC.disabled = false;
            document.all.Email.readOnly = false;
            document.all.EmailP.readOnly = false;
            document.all.EmailA.readOnly = false;
            document.all.EmailO.readOnly = false;
            document.all.EmailAsis.readOnly = false;
            document.all.Email2Asis.readOnly = false;
            document.all.BtnEnviar.disabled = true;
            document.all.EsItinerario.disabled = false;
            document.all.EsItinerarioC.disabled = false;
            document.all.ParteItinerario.disabled = false;
            document.all.ParteItinerarioC.disabled = false;            
            document.all.NombreItinerario.readOnly = false;
            document.all.clItinerario.disabled = false;
            document.all.clItinerarioC.disabled = false;
            fnValidaCorreos();
//------------------------------------------------------------------------------
            //  SE CARGAN DATOS DEFAULT CUANDO SE DETECTEN CIERTOS SERVICIOS
            function fnDatosDefault() {
                if (document.all.clSubservicio.value == '39') {
                    document.all.Peticion.value = 2;
                    document.all.PeticionC.value = 2;
                    document.all.TiempoContacto.value = 4;
                    document.all.TiempoContactoC.value = 4;
                    document.all.Marcar.value = '0';
                    document.all.MarcarC.value = '0';
                }
                if (document.all.clSubservicio.value == '40') { //  SELECCIONA PAIS Y CIUDAD DEFAULT PARA EZEIZA (SALAS VIP)
                    document.all.clPaisDestino.value = 10;
                    document.all.clPaisDestinoC.value = 10;
                    document.all.Peticion.value = 2;
                    document.all.PeticionC.value = 2;
                    //document.all.TiempoContacto.value = 14; //YA NO SE NECESITA QUE TENGA POR DEAFAULT UN TIEMPO DE CONTACTO
                    //document.all.TiempoContactoC.value = 14; //YA NO SE NECESITA QUE TENGA POR DEAFAULT UN TIEMPO DE CONTACTO
                    document.all.Marcar.value = '0';
                    document.all.MarcarC.value = '0';
                    fnLlenaCiudadDestino();
                }
                if (document.all.clSubservicio.value == '44' || document.all.clSubservicio.value == '45'){ //  SELECCIONA PAIS Y CIUDAD DEFAULT PARA CARRASCO
                    document.all.clPaisDestino.value = 10;
                    document.all.clPaisDestinoC.value = 10;
                    document.all.Peticion.value = 2;
                    document.all.PeticionC.value = 2;
                    document.all.TiempoContacto.value = 15;
                    document.all.TiempoContactoC.value = 15;
                    document.all.Marcar.value = '0';
                    document.all.MarcarC.value = '0';
                    fnLlenaCiudadDestino();
                }

                //fnValidaTipoPeticion(2);
                fnMuestraEncuesta();
				fnValidaTipoPeticion(document.all.Peticion);
                fnHabilitaBtnEnviar();
            }
            function fnSubmit() {
                fnsp_Guarda();
                fnOpenWindow();
                document.all.forma.target = "WinSave";
                document.all.forma.submit();
            }
            function fnGuarda() {
                var Valida = "";
                if (document.all.clCuenta.value == '1353' || document.all.clCuenta.value == '1354') {
                    if (document.all.Marcar.value == "" && document.all.Peticion.value == '2')
                        Valida = Valida + "Pregunta. ";
                    if (document.all.Peticion.value == "")
                        Valida = Valida + "Recepción de solicitud. ";
                    if (document.all.clPaisDestino.value == "")
                        Valida = Valida + "País Destino del Servicio. ";
                    if (document.all.clCiudadDestino.value == "")
                        Valida = Valida + "Ciudad Destino del Servicio. ";
                    if (document.all.TiempoContacto.value == "")
                        Valida = Valida + "Tiempo de Contacto. ";
                    if (document.all.Peticion.value != '1' && document.all.TiempoContacto.value != '1') {
                        if (document.all.EmailC_Env.value == '0' 
                            && document.all.EmailA_Env.value == '0' 
                            && document.all.EmailP_Env.value == '0' 
                            && document.all.EmailO_Env.value == '0' 
                            && document.all.EmailAsis_Env.value == '0' 
                            && document.all.EmailAsis2_Env.value == '0') {
                            Valida = Valida + "Al menos un E-mail. "; }
                    }
                    //------------------Itinerario------------------------------
                     if(document.all.Peticion.value!="1" && document.all.TiempoContacto.value>"3" && document.all.clSubservicio.value!= "39" ){
                        if(document.all.EsItinerario.value==""){
                            Valida = Valida + " Es Itinerario. ";
                        }else{
                            if(document.all.EsItinerario.value=="1"){
                                if(document.all.ParteItinerario.value==""){
                                    Valida = Valida + " Parte de Itinerario. ";
                                }else{
                                    if(document.all.ParteItinerario.value=="1"){
                                        if(document.all.NombreItinerario.value==""){
                                            Valida=Valida+" Nombre de Itinerario. ";
                                            }
                                    }else{
                                        if(document.all.clItinerario.value==""){
                                            Valida=Valida+" Itinerario. ";
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    //----------------------------------------------------------
                    if (Valida != "") {
                        alert('Falta informar1: ' + Valida);
                    } else {
                        fnSubmit();
                    }
                } else {
                    if (document.all.Peticion.value == "")
                        Valida = Valida + "Recepción de solicitud. ";
                    if (document.all.clPaisDestino.value == "")
                        Valida = Valida + "País Destino del Servicio. ";
                    if (document.all.clCiudadDestino.value == "")
                        Valida = Valida + "Ciudad Destino del Servicio. ";
                    if (document.all.TiempoContacto.value == "")
                        Valida = Valida + "Tiempo de Contacto. ";
                    if (Valida != "") {
                        alert('Falta informar2: ' + Valida);
                    } else {
                        fnSubmit();
                    }
                }
            }
            function fnVeCuestionario(valor) {
                if (valor == "1") {
                    document.all.Cuestionario.style.visibility = "visible";
                } else {
                    document.all.Cuestionario.style.visibility = "hidden";
                }
            }
            function fnValidaTipoPeticion(pTipoPet) {
                if (pTipoPet.value != '1') {
                    document.all.CorreosDIV.style.visibility = "visible";
                } else {
                    document.all.CorreosDIV.style.visibility = "hidden";
                }
            }
            function fnValidaCorreos() {
                if (document.all.Email.value == '') {
                    document.all.EmailC_EnvC.disabled = true;
                    document.all.EmailC_EnvC.checked = false;
                } else {
                    document.all.EmailC_EnvC.disabled = false;
                }
                if (document.all.EmailP.value == '') {
                    document.all.EmailP_EnvC.disabled = true;
                    document.all.EmailP_EnvC.checked = false;
                } else {
                    document.all.EmailP_EnvC.disabled = false;
                }
                if (document.all.EmailA.value == '') {
                    document.all.EmailA_EnvC.disabled = true;
                    document.all.EmailA_EnvC.checked = false;
                } else {
                    document.all.EmailA_EnvC.disabled = false;
                }
                if (document.all.EmailO.value == '') {
                    document.all.EmailO_EnvC.disabled = true;
                    document.all.EmailO_EnvC.checked = false;
                } else {
                    document.all.EmailO_EnvC.disabled = false;
                }
                if (document.all.EmailAsis.value == '') {
                    document.all.EmailAsis_EnvC.disabled = true;
                    document.all.EmailAsis_EnvC.checked = false;
                } else {
                    document.all.EmailAsis_EnvC.disabled = false;
                }
                if (document.all.Email2Asis.value == '') {
                    document.all.EmailAsis2_EnvC.disabled = true;
                    document.all.EmailAsis2_EnvC.checked = false;
                } else {
                    document.all.EmailAsis2_EnvC.disabled = false;
                }
            }
            function fnArmaMailsContacto() {
                if (document.all.Peticion.value != '1') {
                    if (document.all.EmailC_EnvC.checked != false) {
                        if (document.all.MailContacto.value != '') {
                            document.all.EmailC_Env.value = 1;
                            document.all.MailContacto.value = document.all.MailContacto.value + ',' + document.all.Email.value;
                        } else {
                            document.all.EmailC_Env.value = 1;
                            document.all.MailContacto.value = document.all.Email.value;
                        }
                    } else {
                        document.all.EmailC_Env.value = 0;
                    }
                    if (document.all.EmailP_EnvC.checked != false) {
                        if (document.all.MailContacto.value != '') {
                            document.all.EmailP_Env.value = 1;
                            document.all.MailContacto.value = document.all.MailContacto.value + ',' + document.all.EmailP.value;
                        } else {
                            document.all.EmailP_Env.value = 1;
                            document.all.MailContacto.value = document.all.EmailP.value;
                        }
                    } else {
                        document.all.EmailP_Env.value = 0;
                    }

                    if (document.all.EmailA_EnvC.checked != false) {
                        if (document.all.MailContacto.value != '') {
                            document.all.EmailA_Env.value = 1;
                            document.all.MailContacto.value = document.all.MailContacto.value + ',' + document.all.EmailA.value;
                        } else {
                            document.all.EmailA_Env.value = 1;
                            document.all.MailContacto.value = document.all.EmailA.value;
                        }
                    } else {
                        document.all.EmailA_Env.value = 0;
                    }
                    if (document.all.EmailO_EnvC.checked != false) {
                        if (document.all.MailContacto.value != '') {
                            document.all.EmailO_Env.value = 1;
                            document.all.MailContacto.value = document.all.MailContacto.value + ',' + document.all.EmailO.value;
                        } else {
                            document.all.EmailO_Env.value = 1;
                            document.all.MailContacto.value = document.all.EmailO.value;
                        }
                    } else {
                        document.all.EmailO_Env.value = 0;
                    }
                    if (document.all.EmailAsis_EnvC.checked != false) {
                        if (document.all.MailContacto.value != '') {
                            document.all.EmailAsis_Env.value = 1;
                            document.all.MailContacto.value = document.all.MailContacto.value + ',' + document.all.EmailAsis.value;
                        } else {
                            document.all.EmailAsis_Env.value = 1;
                            document.all.MailContacto.value = document.all.EmailAsis.value;
                        }
                    } else {
                        document.all.EmailAsis_Env.value = 0;
                    }
                    if (document.all.EmailAsis2_EnvC.checked != false) {
                        if (document.all.MailContacto.value != '') {
                            document.all.EmailAsis2_Env.value = 1;
                            document.all.MailContacto.value = document.all.MailContacto.value + ',' + document.all.Email2Asis.value;
                        } else {
                            document.all.EmailAsis2_Env.value = 1;
                            document.all.MailContacto.value = document.all.Email2Asis.value;
                        }
                    } else {
                        document.all.EmailAsis2_Env.value = 0;
                    }
                }
                return;
            }
            function fnHabilitaBtnEnviar() {
                if (document.all.Peticion.value == '' || document.all.clPaisDestino.value == '' || document.all.clCiudadDestino.value == '' || document.all.TiempoContacto.value == '') {
                    if (document.all.Pregunta.value == '0' && document.all.Peticion.value == '2') {
                        if (document.all.Marcar.value == '') {
                            document.all.BtnEnviar.disabled = true;
                        } else {
                            document.all.BtnEnviar.disabled = true;
                        }
                    } else {
                        document.all.BtnEnviar.disabled = true;
                    }
                } else {
                    document.all.BtnEnviar.disabled = false;
                }
            }

            function validaCorreo(pCampo) {
                var Cadena
                var PosArroba
                var usuario
                var dominio
                if (pCampo.value != '') {
                    if (pCampo.value.indexOf('@', 0) == -1) {
                        pCampo.value = '';
                        alert("La dirección de correo no es válida.");
                    } else {
                        PosArroba = pCampo.value.lastIndexOf('@')
                        usuario = pCampo.value.substring(0, PosArroba)
                        dominio = pCampo.value.substring(PosArroba + 1, Cadena)
                        if (usuario == '' || dominio == '') {
                            pCampo.value = '';
                            alert("La dirección de correo no es válida.");
                        }
                        //Valida el nombre de usuario y verifica que no existan dos @
                        if (usuario.indexOf('@', 0) != -1) {
                            pCampo.value = '';
                            alert("La dirección de correo no es válida.");
                        }
                        //valida el dominio
                        if (dominio.indexOf('.', 0) == -1 || dominio.indexOf('@', 0) != -1) {
                            pCampo.value = '';
                            alert("La dirección de correo no es válida.");
                        }
                    }
                    fnValidaCorreos();
                }
            }
            function fnMuestraEncuesta() {
                if ((    document.all.clCuenta.value == '1353' 
                      || document.all.clCuenta.value == '1354') 
                      && document.all.Peticion.value == '2') {
                    document.all.EncuestaDIV.style.visibility = 'visible';
                } else {
                    document.all.EncuestaDIV.style.visibility = 'hidden';
                }
            }
            function fnLlenaCiudadDestino() {
                var strConsulta = "st_CSCiudadDestino '" + document.all.clPaisDestinoC.value + "'";
                var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=clCiudadDestinoC";
                fnOptionxDefault('clCiudadDestinoC', pstrCadena);
            }
            function fnMuestraItinerario(){
                Peticion=document.all.Peticion.value;
                clTiempoContacto=document.all.TiempoContacto.value;
                if(clTiempoContacto>3 && Peticion!=1){
                    document.all.EncuestaItinerario.style.visibility = 'visible';
                }else{
                    document.all.EsItinerario.value="";
                    document.all.EsItinerarioC.value="";
                    document.all.ParteItinerario.value="";
                    document.all.ParteItinerarioC.value="";
                    document.all.NombreItinerario.value="";
                    document.all.EncuestaItinerario.style.visibility = 'hidden';
                    document.all.DivParteItin.style.visibility='hidden';
                    document.all.DivclItitin.style.visibility='hidden';
                    document.all.DivNombreItin.style.visibility='hidden';
                    }
                }
//------------------------------------------------------------------------------
            function fnMuestraParteItin(){
                EsItinerario=document.all.EsItinerario.value;
                if(EsItinerario=='1'){
                    document.all.DivParteItin.style.visibility='visible';
                }else{
                    document.all.DivParteItin.style.visibility='hidden';
                    document.all.ParteItinerario.value="";
                    document.all.ParteItinerarioC.value="";
                    document.all.clItinerario.value="";
                    document.all.clItinerarioC.value="";
                    document.all.NombreItinerario.value="";
                    document.all.DivclItitin.style.visibility='hidden';
                    document.all.DivNombreItin.style.visibility='hidden';
                    }
                }
//------------------------------------------------------------------------------
            function fnMuestradsItin(){
                ParteItinerario=document.all.ParteItinerario.value;
                if(ParteItinerario=='1' ){
                    document.all.DivNombreItin.style.visibility='visible';
                    document.all.DivclItitin.style.visibility='hidden';
                    document.all.clItinerarioC.value='';
                    document.all.clItinerario.value='';
                }else{
                    if(ParteItinerario==''){
                        document.all.DivNombreItin.style.visibility='hidden';
                        document.all.DivclItitin.style.visibility='hidden';         
                        document.all.NombreItinerario.value='';
                        document.all.clItinerarioC.value='';
                        document.all.clItinerario.value='';
                    }else{
                        document.all.DivNombreItin.style.visibility='hidden';
                        document.all.DivclItitin.style.visibility='visible'; 
                        document.all.NombreItinerario.value='';
                        }
                    }
                }
            /*
            function fnMuestraItinerario(){
                if(document.all.clCuenta.value == '1353' 
                        || document.all.clCuenta.value == '1354') {
                Peticion=document.all.Peticion.value;
                clTiempoContacto=document.all.TiempoContacto.value;
                if(clTiempoContacto>3 && Peticion!=1){
                    document.all.EncuestaItinerario.style.visibility = 'visible';
                }else{
                    document.all.EsItinerario.value="";
                    document.all.EsItinerarioC.value="";
                    document.all.ParteItinerario.value="";
                    document.all.ParteItinerarioC.value="";
                    document.all.NombreItinerario.value="";
                    document.all.EncuestaItinerario.style.visibility = 'hidden';
                    document.all.DivParteItin.style.visibility='hidden';
                    document.all.DivclItitin.style.visibility='hidden';
                    document.all.DivNombreItin.style.visibility='hidden';
                    }
                }
                }
//------------------------------------------------------------------------------
            function fnMuestraParteItin(){
                EsItinerario=document.all.EsItinerario.value;
                if(EsItinerario=='1'){
                    document.all.DivParteItin.style.visibility='visible';
                }else{
                    document.all.DivParteItin.style.visibility='hidden';
                    document.all.ParteItinerario.value="";
                    document.all.ParteItinerarioC.value="";
                    document.all.NombreItinerario.value="";
                    document.all.DivclItitin.style.visibility='hidden';
                    document.all.DivNombreItin.style.visibility='hidden';
                    }
                }
//------------------------------------------------------------------------------
            function fnMuestradsItin(){
                ParteItinerario=document.all.ParteItinerario.value;
                if(ParteItinerario=='1' ){
                    document.all.DivNombreItin.style.visibility='visible';
                    document.all.DivclItitin.style.visibility='hidden';
                    document.all.clItinerarioC.value='';
                    document.all.clItinerario.value='';
                }else{
                    if(ParteItinerario==''){
                        document.all.DivNombreItin.style.visibility='hidden';
                        document.all.DivclItitin.style.visibility='hidden';         
                        document.all.NombreItinerario.value='';
                        document.all.clItinerarioC.value='';
                        document.all.clItinerario.value='';
                    }else{
                        document.all.DivNombreItin.style.visibility='hidden';
                        document.all.DivclItitin.style.visibility='visible'; 
                        document.all.NombreItinerario.value='';
                        }
                    }
                }*/
        </script>
    </body>
</html>
