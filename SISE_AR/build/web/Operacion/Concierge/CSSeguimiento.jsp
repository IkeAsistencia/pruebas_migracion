<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.concierge.DAOConciergeG,com.ike.concierge.to.ConciergeG,com.ike.concierge.DAOReferenciasxAsist,com.ike.concierge.to.ReferenciasxAsist" errorPage="" %>

<html>
    <head>
        <title>Agenda Concierge</title>
        <link rel="stylesheet" id="cssRef" href="floating_window_with_tabs-skin2.css" media="screen">
        <script type="text/javascript">
            var floating_window_skin = 2;
        </script>
        <script type="text/javascript" src="floating_window_with_tabs.js"></script>
        <script type="text/javascript" src='../../Utilerias/UtilCalendario.js'></script>
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="fnFecha();">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>

        <!--  NUEVA LIBRERIAS PARA EL MÓDULO HTML  -->
        <script type="text/javascript" src="../../Utilerias/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>

        <!--  NUEVO SCRIPT QUE PERMITE LA CARGA DEL EDITOR HTML :: INICIO -->
        <script type="text/javascript">
            tinyMCE.init({
                // General options
                mode: "textareas",
                //mode : "exact",
                elements: "Observaciones0, Observaciones1",
                theme: "advanced",
                skin: "o2k7",
                //skin_variant : "silver",
                //skin_variant : "black",
                plugins: "safari,spellchecker,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",
                // Theme options
                //theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,forecolor,backcolor,|,formatselect,fontselect,fontsizeselect",
                theme_advanced_buttons1: "styleselect",
                theme_advanced_buttons2: "",
                theme_advanced_buttons3: "",
                theme_advanced_buttons4: "",
                theme_advanced_toolbar_location: "top",
                theme_advanced_toolbar_align: "left",
                theme_advanced_statusbar_location: "none",
                theme_advanced_resizing: false,
                height: "80",
                width: "510",
                // Example content CSS (should be your site CSS)
                content_css: "/js/tinymce/examples/css/content.css",
                // Style formats
                style_formats: [
                    {title: 'Texto en negritas', inline: 'b', styles: {fontSize: '11px'}}
                    //{title: 'Texto en rojo', inline: 'span', styles: {color: '#ff0000'}},
                    //{title: 'Texto subrayado', inline: 'u', exact: true},
                    //{title: 'Texto sombreado', inline: 'span', styles: {background: '#ffff00'}}
                ],
                formats: {
                    alignleft: {selector: 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes: 'left'},
                    aligncenter: {selector: 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes: 'center'},
                    alignright: {selector: 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes: 'right'},
                    alignfull: {selector: 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes: 'full'},
                    bold: {inline: 'span', 'classes': 'bold'},
                    italic: {inline: 'span', 'classes': 'italic'},
                    underline: {inline: 'span', 'classes': 'underline', exact: true},
                    strikethrough: {inline: 'del'},
                    customformat: {inline: 'span', styles: {color: '#00ff00', fontSize: '20px'}, attributes: {title: 'Pruebas'}}
                }
            });
        </script>
        <!--  NUEVO SCRIPT QUE PERMITE LA CARGA DEL EDITOR HTML :: FIN -->

        <%
            String StrclAsistencia = "0";
            String StrclConcierge = "";
            String StrclSubservicio = "0";
            String strclUsrApp = "0";
            String StrclCuenta = "0";
            ResultSet rsC = null;
            String StrclPaginaWeb = "721";
            String StrNoOpcion = "";
            ResultSet rs2 = null;
            String StrclExperiencia = "";
            String Strdisponibles = "0";
            String StrExpact = "";
            String Strclestatus = "0";
            String StrWList = "0";
            String Strexpact = "0";

            StringBuffer StrSql = new StringBuffer();
            DAOConciergeG daosg = null;
            ConciergeG conciergeg = null;
            DAOReferenciasxAsist daoRef = null;
            ReferenciasxAsist ref = null;

            if (session.getAttribute("clUsrApp") != null) {
                strclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clConcierge") != null) {
                StrclConcierge = session.getAttribute("clConcierge").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true) {
        %>Fuera de Horario<%
                            return;
                        }

                        if (session.getAttribute("clAsistencia") != null) {
                            StrclAsistencia = session.getAttribute("clAsistencia").toString();
                        }

                        if (session.getAttribute("clSubservicio") != null) {
                            StrclSubservicio = session.getAttribute("clSubservicio").toString();
                        }

                        rsC = UtileriasBDF.rsSQLNP("st_GetCuentaCS '" + StrclAsistencia + "'");                        
                        if (rsC.next()) {
                            StrclCuenta = rsC.getString("clCuenta");
                        }

                        rsC.close();
                        rsC = null;

                        if (StrclAsistencia.equalsIgnoreCase(null) || StrclAsistencia.equalsIgnoreCase("0")) {
        %>Debe de Ingresar una Asistencia Valida, Consulte a sus administrador<%
                            return;
                        }

                        if (strclUsrApp != null) {
                            daosg = new DAOConciergeG();
                            conciergeg = daosg.getConciergeGenerico(StrclConcierge);
                            daoRef = new DAOReferenciasxAsist();
                            ref = daoRef.getclAsistencia(StrclAsistencia);
                        }

                //---------------------------------------------------------------
                        // SE AGREGA CODIGO PARA EL MANEJO DE LAS ASISTENCIAS DUPLICADAS.
                        String StrclAsistenciaVTR = "";
                        if (session.getAttribute("clAsistenciaVTR") != null) {
                            StrclAsistenciaVTR = session.getAttribute("clAsistenciaVTR").toString();
                        }
                        //---------------------------------------------------------------

                        session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %><script>fnOpenLinks()</script><%
                    MyUtil.InicializaParametrosC(721, Integer.parseInt(strclUsrApp));

                    // checar si ya existe asistencia para el expediente, si existe, ya no procede la alta
                    StrSql.append(" Select clAsistencia").append(" From CSAsistencia ").append(" Where clAsistencia=").append(StrclAsistencia);
                    ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
                    StrSql.delete(0, StrSql.length());
                    StrSql = null;
             
                    // seguimiento al servicio
                    if (rs.next()) {
                        
                    rs2 = UtileriasBDF.rsSQLNP("st_CSRevisaAsist " + StrclAsistencia);
                    System.out.println("Consulta  st_CSRevisaAsist " + StrclAsistencia);
                    if (rs2.next()) {
                         StrclExperiencia = rs2.getString("clExperiencia");
                         Strdisponibles = rs2.getString("disponibles");
                         Strclestatus = rs2.getString("clestatus");
                         StrWList = rs2.getString("wList");  
                         StrExpact = rs2.getString("expact");                                                                                                                                         
 
                    }
        %>
            <form name='frmExp' id='frmExp' method='get' action='../../servlet/Concierge.CSGuardaSeguimiento'>
            <input type="hidden" id="ValidaSupervisor" name="ValidaSupervisor" value="0"><br>
            <input type="hidden" id="MsgValidaSupervisor" name="MsgValidaSupervisor" value="">
            <input type="hidden" id="clExperiencia" name="clExperiencia" value='<%=StrclExperiencia%>'>
            <input type="hidden" id="disponibles" name="disponibles" value='<%=Strdisponibles%>'>
            <input type="hidden" id="clestatu" name="clestatus" value='<%=Strclestatus%>'>
            <input type="hidden" id="WList" name="WList" value='<%=StrWList%>'>
            <input type="hidden" id="Expact" name="Expact" value='<%=StrExpact%>'>            
                        
            <%=MyUtil.ObjComboC("Estatus", "clEstatus0", "", true, true, 30, 30, "", "sp_CSGetEstatusOp '" + StrclAsistencia + "'", "fnHabilitaFe();fnMuestraEstatus();", "", 50, false, false)%>
            <div style='position:absolute; z-index:1500; left:10px; top:1px;' name='FechaP' id='FechaP'>
                <%=MyUtil.ObjInputF("Programar Fecha", "FechaProgramada", "", true, true, 350, 30, "", true, true, 20, 2, "fnHabilitaGuarda();")%>
            </div>

            <div class='VTable' style='position:absolute; z-index:10; left:30px; top:70px;'>
                <p class='VTable' style='position:relative; z-index:102; left:0px; top:19px; text-transform: uppercase'>Observaciones</p>
                <textarea name="Observaciones0" id="Observaciones0" style="width:20%"></textarea>
            </div>

            <div style='position:absolute; z-index:1025; left:1px; top:70px;' name='DetCon' id='DetCon'>
                <%=MyUtil.ObjComboC("Referencia final asignada", "clRefxAsistOpcOtros", "", true, true, 30, 180, "0", "st_CSRefxAsistOpcOtros'" + StrclAsistencia + "'", "fnHabilitaGuarda2();", "", 30, false, false)%>
            </div>

            <div style='position:absolute; z-index:1025; left:1px; top:70px;' name='tipoServicioB' id='tipoServicioB'>
                <%=MyUtil.ObjComboC("Tipo de conclusión del evento", "clReferenciaxAsistencia", "", true, true, 30, 230, "0", "st_TipoServicioBrindado", "fnHabilitaGuarda2();", "", 30, false, false)%>
            </div>

            <div  style='position:absolute; z-index:25; left:10px; top:1px;' name='ECorreo' id='ECorreo'>
                <%=MyUtil.ObjComboC("Evaluación por correo", "EvaluacionC", "", true, true, 230, 30, "", "st_EvalucionxCorreo", "", "", 50, false, false)%>
            </div>

            <script>document.all.ECorreo.style.visibility = 'hidden';</script>                                                                                                                                                                  

            <INPUT id='URLBACK0' name='URLBACK0' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>CSSeleccionaServicio.jsp?clSubservicio=<%=StrclSubservicio%>'>
            <INPUT id='clAsistencia0' name='clAsistencia0' type='hidden' value='<%=StrclAsistencia%>'>
            <INPUT id='TipoSeg0' name='TipoSeg0' type='hidden' value='0'>
            <INPUT id='Action' name='Action' type='hidden' value='1'>
            <input id="clCuenta" name="clCuenta" type="hidden"  VALUE="<%=StrclCuenta%>">
            <input id='NoOpcion' name='NoOpcion' type='hidden' value='<%=StrNoOpcion%>'>

            <input name='FechaProgMsk' id='FechaProgMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>

            <%=MyUtil.DoBlock("Seguimiento al Evento", 100, 80)%>

            <div class='VTable' style='position:absolute; z-index:20; left:520px; top:40px;'>
                <INPUT id="BTN1" type='button' VALUE='Guardar...' onClick='fnCorta();
                        fnReplaceScript(tinyMCE.get(document.all.Observaciones0.id).getContent(), document.all.Observaciones0.id);
                        fnAlertaEstatusDisponible();' class='cBtn'>
            </div>

            <div id="DivF"></div>
            <div id="DivValidaSupervisor"></div>
        </form>

        <form name='frmCon' id='frmCon' method='get' action='../../servlet/Concierge.CSGuardaStatus'>
            <%
                String Store = "";
                Store = " ,st_SCActualizaConclusion";
                session.setAttribute("sp_Stores", Store);
                String Commit = "";
                Commit = "clCSTipoConclucion";
                session.setAttribute("Commit", Commit);
            %>

            <input id="Secuencia" name="Secuencia" type="hidden" value="">
            <input id="SecuenciaG" name="SecuenciaG" type="hidden"  VALUE="">
            <input id="SecuenciaA" name="SecuenciaA" type="hidden"  VALUE="clCSTipoConclucion">                                                                
            <INPUT id='URLBACK1' name='URLBACK1' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>CSSeleccionaServicio.jsp?clSubservicio=<%=StrclSubservicio%>'>

            <div class='VTable' id="CSRecordatorio" name="CSRecordatorio" style='position:absolute; z-index:25; left:120px; top:205px;'><p align="center"><font color="navy" face="Arial" size="4" ><b><i> "Debe de informar el Tipo de Conclusion" </i></b></font> <br> </p></div>
            <div style='position:absolute; z-index:25; left:10px; top:50px;' name='TipoConclusion' id='TipoConclusion'>
                <%=MyUtil.ObjComboC("Tipo de conclusión", "clCSTipoConclucion", "", true, true, 30, 330, "0", "st_SCConcluyeEvento '" + StrclAsistencia + "'", "", "", 30, false, false)%>
            </div>

            <div class='VTable' style='position:absolute; z-index:20; left:30px; top:390px;'>
                <INPUT type='submit' VALUE='Guardar...' onClick='document.all.frmCon.submit()' class='cBtn'>
            </div>
            <%=MyUtil.DoBlock("Tipo de conclusión del Evento", 270, 80)%>
        </form>

        <input type="hidden" name="TieneConclusion" id="TieneConclusion" value="0">

        <%
            ResultSet rsGetInfoA = null;
            rsGetInfoA = UtileriasBDF.rsSQLNP("sp_CSGetInfoAsistencia " + StrclSubservicio);

            if (rsGetInfoA.next()) {
                if (rsGetInfoA.getString("TieneConclusion").equalsIgnoreCase("1")) {
        %><script>document.all.TieneConclusion.value = 1;</script><%                                    }
            }

            rsGetInfoA.close();
            rsGetInfoA = null;
            ResultSet rsValidaSup = null;
            rsValidaSup = UtileriasBDF.rsSQLNP("sp_CSValidaSupervisor '" + StrclAsistencia + "'");
            String StrValidaSupervisor = "0", StrMsgValidaSupervisor = "";

            if (rsValidaSup.next()) {
                StrValidaSupervisor = rsValidaSup.getString("ValidaSupervisor");
                StrMsgValidaSupervisor = rsValidaSup.getString("Mensaje");
            }
        %>

        <script> document.all.ValidaSupervisor.value = <%=StrValidaSupervisor%>;
            document.all.MsgValidaSupervisor.value = '<%=StrMsgValidaSupervisor%>';</script>

        <%
        } else {
        %>La Asistencia no Existe<%                    }
        %><%@ include file="csVentanaFlotante.jspf" %><%
            rs.close();
            rs = null;
            StrclAsistencia = null;
            strclUsrApp = null;
            daosg = null;
            conciergeg = null;
            StrclConcierge = null;
            daoRef = null;
            ref = null;
        %>
        <script>
            document.all.clEstatus0C.disabled = false;
            document.all.clCSTipoConclucionC.disabled = false;
            document.all.clRefxAsistOpcOtrosC.disabled = false;
            document.all.Observaciones0.readOnly = false;
            document.all.frmCon.style.visibility = 'hidden';
            document.all.DetCon.style.visibility = 'hidden';
            document.all.FechaProgramada.readOnly = false;
            document.all.EvaluacionCC.disabled = false;

            document.getElementById('clReferenciaxAsistenciaC').disabled = false;
            document.getElementById('tipoServicioB').style.visibility = 'hidden';

            function fnValidaClave() {
                //alert(1);
                Parametros = 'Usr=' + document.all.Usr.value + '&MsgValidaSupervisor=' + document.all.MsgValidaSupervisor.value + '&Pwd=' + document.all.Pwd.value;
                fnLLenaInputFn('ValidaSupervisor.jsp?', Parametros, 'DivValidaSupervisor', 'fnResponse');
            }

            function fnResponse() {
                if (document.all.clUsrAppValSup.value != 0) {
                    document.all.frmExp.submit();
                }
            }

            function fnGuarda() {
                if ((document.all.clEstatus0.value == 47 || document.all.clEstatus0C.value == 57 || document.all.clEstatus0C.value == 52) && document.all.FechaProgramada.value == '') {
                    alert("Debe introducir una fecha.");
                    return;
                }
                //alert("estatus:"+document.all.clEstatus0.value+", Valida Supervisor: "+document.all.ValidaSupervisor.value);
                if (document.all.clEstatus0.value == 47 && document.all.ValidaSupervisor.value == 1) {
                    Parametros = 'MsgValidaSupervisor=' + document.all.MsgValidaSupervisor.value;
                    fnLLenaInput('ValidaSupervisor.jsp?', Parametros, 'DivValidaSupervisor');
                    DivF.className = 'loading-visible';
                    return;
                }

                if (((document.all.clRefxAsistOpcOtrosC.value == '')) && (document.all.clEstatus0C.value == 66 || document.all.clEstatus0C.value == 67 || document.all.clEstatus0C.value == 68 || document.all.clEstatus0C.value == 69 || document.all.clEstatus0C.value == 49)) {
                    alert("Debe seleccionar alguna opción del combo Otros.");
                    return;
                }

                if (document.all.clEstatus0.value == 47 || document.all.clEstatus0C.value != 67 || document.all.clEstatus0C.value != 68 || document.all.clEstatus0C.value != 69) {
                    document.all.frmExp.submit();
                } 
            }

            function fnHabilitaFe() {
                if (document.all.clEstatus0C.value == 47 || document.all.clEstatus0C.value == 57 || document.all.clEstatus0C.value == 52 || document.all.clEstatus0C.value == 70 || document.all.clEstatus0C.value == 71) {
                    document.all.FechaP.style.visibility = 'visible';
                    document.all.BTN1.disabled = true;
                } else {
                    document.all.FechaProgramada.value = '';
                    document.all.FechaP.style.visibility = 'hidden';
                }
            }

            function fnMuestraConclusion() {
                if //(document.all.clEstatus0C.value==7)
                        (document.all.clEstatus0C.value == 7 || document.all.clEstatus0C.value == 8 || document.all.clEstatus0C.value == 10) {
                    document.all.frmCon.style.visibility = 'visible';
                } else {
                    //document.all.TipoConclusion.value='';
                    document.all.frmCon.style.visibility = 'hidden';
                }
              fnHabilitaCorreo();
            }


            /***********   validacion para mostrar el de talle de la conclucion **********  */
            function fnMuestraEstatus() {
                if (document.all.clEstatus0C.value == 66 || document.all.clEstatus0C.value == 67 || document.all.clEstatus0C.value == 68 || document.all.clEstatus0C.value == 69 || document.all.clEstatus0C.value == 49) {
                    document.all.DetCon.style.visibility = 'visible';
                    document.getElementById('tipoServicioB').style.visibility = 'visible'
                    document.all.BTN1.disabled = true;
                } else {
                    //document.all.TipoConclusion.value = '';
                    //document.all.TipoConclusionC.value = '';
                    document.all.DetCon.style.visibility = 'hidden';
                    document.getElementById('tipoServicioB').style.visibility = 'hidden'
                    document.all.BTN1.disabled = false;
                }
            }

            function fnHabilitaGuarda() {
                if (document.all.FechaProgramada.value == '') {
                    document.all.BTN1.disabled = true;
                } else {
                    document.all.BTN1.disabled = false;
                }
            }

            function fnHabilitaGuarda2() {
                if (document.all.clRefxAsistOpcOtrosC.value == '') {
                    //alert(document.all.clRefxAsistOpcOtrosC.value);
                    document.all.BTN1.disabled = true;
                } else {
                    //alert(document.all.clRefxAsistOpcOtrosC.value);
                    document.all.BTN1.disabled = false;
                }
            }

            // validacion para Valida x Correo
            function fnHabilitaCorreo() {
                if (document.all.clEstatus0C.value == 10 && document.all.clCuenta.value == 735) {
                    document.all.ECorreo.style.visibility = 'visible';
                } else {
                    document.all.ECorreo.style.visibility = 'hidden';
                }
            }

            function fnFecha() {
                document.all.Action.value == 1;
                document.all.FechaP.style.visibility = 'hidden';
            }

            function fnReplaceScript(value, id) {
                value = value.replace(/select /gi, "");
                value = value.replace(/insert/gi, "");
                value = value.replace(/into/gi, "");
                value = value.replace(/values/gi, "");
                value = value.replace(/delete/gi, "");
                value = value.replace(/update/gi, "");
                value = value.replace(/drop /gi, "");
                value = value.replace(/exec/gi, "");
                value = value.replace(/execute/gi, "");
                value = value.replace(/truncate/gi, "");
                value = value.replace(/'/gi, "");
                value = value.replace(/"/gi, "");
                tinyMCE.activeEditor.setContent(value);
                document.all[id].value = value;
            }

            function fnCorta() {
                //alert(document.all.Observaciones0.value);
                //alert(document.all.Observaciones.value);
            }
            
            function fnAlertaEstatusDisponible() {
                if (document.all.WList.value == '1' && document.all.disponibles.value != '0' &&
                        (document.all.clEstatus0.value == 7 || document.all.clEstatus0.value == 8 || document.all.clEstatus0.value == 49 || document.all.clEstatus0.value == 66 || document.all.clEstatus0.value == 67 || document.all.clEstatus0.value == 68 || document.all.clEstatus0.value == 69)) {
                    //alert("Llego ! estatus: " + document.all.clEstatus0.value + " exp: " + document.all.clExperiencia.value + " disp: " + document.all.disponibles.value  + " estatus: " + document.all.clestatu.value + " wlist: " + document.all.WList.value + " expact: " + document.all.Expact.value);
                    var resp = confirm("ESTÁ A PUNTO DE CERRAR UNA ASISTENCIA EN LISTA DE ESPERA CUYA EXPERIENCIA TIENE DISPONIBILIDAD. DESEA CONTINUAR ? ");
                    if (resp == true) {
                        document.all.frmExp.submit();
                        //alert("entro en guardar")
                    } else {
                        document.all.clEstatus0C.value = '';                                                
                        tinyMCE.get('Observaciones0').setContent('');
                        document.all.clRefxAsistOpcOtrosC.value = '';
                        return;
                    }
                } else {
                    fnGuarda();                        
                    //alert("guarda en else")
                }
            }                 
                       
        </script>
        <script type="text/javascript">
            initFloatingWindowWithTabs('window4', Array('Nuestro Usuario', 'Referencias'), 350, 250, 700, 20, false, false, true, true, false);
        </script>
    </body>
</html>
