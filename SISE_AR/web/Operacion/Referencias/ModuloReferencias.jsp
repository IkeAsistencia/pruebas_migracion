<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.referencias.DAORReferencias,com.ike.referencias.to.RReferencias,java.sql.ResultSet;" %>

<html>
    <head>
        <title>Módulo de Referencias</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="fnShow(document.all.clSubservicio.value);">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../../Utilerias/Util.js'></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <script src='../../Utilerias/UtilStore.js'></script>

        <%
        String strclUsr = "0";
        String strclRReferencias = "0";
        String strclCuenta = "0";
        String strCodEnt = "";
        String strCodMD = "";
        String strclServicio = "0";
        String strclSubServicio = "0";
        String strclServicioA = "0";
        String strclSubServicioA = "0";
        String StrclExpediente = "0";

        if (session.getAttribute("clUsrApp") != null) {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }

        if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true) {
        %> Fuera de Horario <%
            strclUsr = null;
            strclRReferencias = null;
            strclCuenta = null;
            strCodEnt = null;
            strCodMD = null;
            strclServicio = null;
            strclSubServicio = null;
            strclServicioA = null;
            strclSubServicioA = null;
            return;
        }
        
        if (request.getParameter("clRReferencias") != null && request.getParameter("clRReferencias") != "") {
            strclRReferencias = request.getParameter("clRReferencias");
        } else {
            if (session.getAttribute("clRReferencias") != null && session.getAttribute("clRReferencias") != "") {
                strclRReferencias = session.getAttribute("clRReferencias").toString();
            }
            
            if (session.getAttribute("clExpediente") != null) {
               StrclExpediente = session.getAttribute("clExpediente").toString();
            }
        }
        System.out.println(strclRReferencias);        

        
        if (session.getAttribute("clServicio") != null) {
            strclServicioA = session.getAttribute("clServicio").toString();
        }
        
        if (session.getAttribute("clSubServicio") != null) {
            strclSubServicioA = session.getAttribute("clSubServicio").toString();
        }

        DAORReferencias daoRReferencias = null;
        RReferencias RR = null;

//SERVLET GENERICO
        String Store = "";
        String Commit = "";

        Store = "st_GuardaRReferencia, st_ActualizaRReferencia";
        session.setAttribute("sp_Stores", Store);

        Commit = "clRReferencias";
        session.setAttribute("Commit", Commit);
// TERMINA SERVLET GENERICO

        if (!strclRReferencias.equalsIgnoreCase("0") || !StrclExpediente.equalsIgnoreCase("0")) {
            daoRReferencias = new DAORReferencias();
            //RR = daoRReferencias.getRReferencias(strclRReferencias,StrclExpediente);
            RR = daoRReferencias.getRReferencias(strclRReferencias,StrclExpediente);
        }

        if (RR != null) {
            strCodEnt = RR.getCodEnt();
            strCodMD = RR.getCodMD();

            strclServicio = RR.getClServicio();
            strclSubServicio = RR.getClSubServicio();
        }

        session.setAttribute("CodEntSession", strCodEnt);
        session.setAttribute("CodMDSession", strCodMD);
        session.setAttribute("clSubservicioSession", strclSubServicio);
        session.setAttribute("clRReferencias", strclRReferencias);

        String StrclPaginaWeb = "899";
        MyUtil.InicializaParametrosC(899, Integer.parseInt(strclUsr));
        session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <script>fnOpenLinks()</script>

        <%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "", "fnsp_Guarda();")%>


        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="ModuloReferencias.jsp?"%>'>
        <INPUT id="Secuencia" name="Secuencia" type="hidden" value="">
        <INPUT id="SecuenciaG" name="SecuenciaG" type="hidden" value="FechadeApertura,clCuenta,NombredelUsuario,Clave,Telefono,Correo,CodEnt,CodMD,InformacionSol,InformacionPro,LigaPro,clRInfo,clMascotaRef,clRTipoRecreacion,clSexo,Peso,Edad,clEstatus,clServicio,clSubservicio,clUsrApp,clExpediente,clServicioA,clSubServicioA">
        <INPUT id="SecuenciaA" name="SecuenciaA" type="hidden" value="clRReferencias,clCuenta,NombredelUsuario,Clave,Telefono,Correo,CodEnt,CodMD,InformacionSol,InformacionPro,LigaPro,clRInfo,clMascotaRef,clRTipoRecreacion,clSexo,Peso,Edad,clEstatus,clServicio,clSubservicio">
        <INPUT id="clUsrApp" name="clUsrApp" type="hidden" value="<%=strclUsr%>">
        <INPUT id="clExpediente" name="clExpediente" type="hidden" value="<%=StrclExpediente%>">
        <INPUT id="clServicioA" name="clServicioA" type="hidden" value="<%=strclServicioA%>">
        <INPUT id="clSubServicioA" name="clSubServicioA" type="hidden" value="<%=strclSubServicioA%>">
        <INPUT id="clRReferencias" name="clRReferencias" type="hidden" value="<%=strclRReferencias%>">
        <INPUT id='clCuenta' name='clCuenta' type='hidden' value='<%=RR != null ? RR.getClCuenta() : ""%>'>

        <%=MyUtil.ObjInput("Folio", "Folio", RR != null ? RR.getClRReferencias() : "", false, false, 30, 80, "", false, false, 8, "")%>
        <%=MyUtil.ObjInput("Cuenta", "Nombre", RR != null ? RR.getDsCuenta() : "", true, false, 100, 80, "", true, false, 35, "fnBuscaCuenta();")%>

        <%if (MyUtil.blnAccess[4] == true) {
        %><div class='VTable' style='position:absolute; z-index:25; left:295px; top:93px;'>
            <IMG SRC='../../Imagenes/Lupa.gif' onClick='fnBuscaCuenta();' WIDTH=20 HEIGHT=20>
        </div>
        <%  }%>

        <%=MyUtil.ObjInput("Nombre de Usuario", "NombredelUsuario", RR != null ? RR.getNombredelUsuario() : "", true, true, 338, 80, "", true, false, 35, "if(this.readOnly==false){fnBuscaClienteVIP()}")%>
        <% if (MyUtil.blnAccess[4] == true) {%>
        <div class='VTable' style='position:absolute; z-index:25; left:535px; top:93px;'>
            <IMG SRC='../../Imagenes/Lupa.gif' onClick='fnBuscaAfiliado();' WIDTH=20 HEIGHT=20>
        </div>
        <%  }%>
        <%=MyUtil.ObjInput("Clave", "Clave", RR != null ? RR.getClave() : "", true, true, 580, 80, "", true, false, 30, "")%>
        <%=MyUtil.ObjInput("Fecha Apertura", "FechadeApertura", RR != null ? RR.getFechadeApertura() : "", false, false, 770, 80, "", false, false, 20, "")%>
        <%=MyUtil.ObjInput("Teléfono Contacto", "Telefono", RR != null ? RR.getTelefono() : "", true, true, 30, 125, "", true, false, 25, "fnValidaNumero();")%>
        <%=MyUtil.ObjInput("E-mail", "Correo", RR != null ? RR.getCorreo() : "", true, true, 200, 125, "", false, false, 45, "fnValidaCorreo();")%>
        <%=MyUtil.ObjComboC("Provincia", "CodEnt", RR != null ? RR.getDsEntFed() : "", true, true, 470, 125, "", "select codent,dsentfed from cEntFed order by dsEntFed", "fnLlenaMunicipiosCS();", "", 30, true, false)%>
        <%=MyUtil.ObjComboC("Localidad", "CodMD", RR != null ? RR.getDsMunDel() : "", true, true, 470, 170, "", "Select CodMD, dsMunDel from cMunDel where CodEnt='" + strCodEnt + "' order by dsMunDel", "", "", 35, true, false)%>
        <%=MyUtil.ObjTextArea("Link de Web o Fuente Proporcionada a N/U", "LigaPro", RR != null ? RR.getLigaPro() : "", "80", "4", true, true, 30, 170, "", false, false)%>
        <%=MyUtil.ObjTextArea("Información Solicitada por N/U", "InformacionSol", RR != null ? RR.getInformacionSol() : "", "80", "4", true, true, 30, 250, "", true, false)%>
        <%=MyUtil.ObjTextArea("Información Proporcionada a N/U", "InformacionPro", RR != null ? RR.getInformacionPro() : "", "80", "4", true, true, 470, 250, "", true, false)%>
        <%=MyUtil.ObjComboC("Estatus", "clEstatus", RR != null ? RR.getDsEstatus() : "", false, true, 30, 330, "0", "select * from cEstatus  where clEstatus in (0,10,7,29) ", "", "", 20, false, false)%>
        <%=MyUtil.ObjComboC("Servicio", "clServicio", RR != null ? RR.getDsServicio() : "", true, true, 250, 330, "", "sp_LlenaServicioModReferencias " + strclCuenta, "fnLlenaSubservicio();", "", 40, true, false)%>
        <%=MyUtil.ObjComboC("Subservicio", "clSubservicio", RR != null ? RR.getDsSubServicio() : "", true, true, 470, 330, "", " select clSubServicio, dsSubServicio from cSubServicio where clClasificacionServicios = 3 and clServicio = " + strclServicio + " order by dsSubServicio", "fnShow(this.value);", "", 20, true, false)%>
        <%=MyUtil.DoBlock("Módulo de Referencias y Orientación al Cliente", -50, 0)%>

        <%=MyUtil.ObjComboC("Información", "clRInfo", RR != null ? RR.getDsRinfo() : "", true, true, 30, 420, "", "select * from cRInformacion ", "", "", 10, false, false)%>
        <%=MyUtil.ObjComboC("Tipo de Mascota", "clMascotaRef", RR != null ? RR.getDsMascotaRef() : "", true, true, 210, 420, "", "select * from cRMascota ", "", "", 10, false, false)%>
        <%=MyUtil.ObjComboC("Tipo de Recreación", "clRTipoRecreacion", RR != null ? RR.getDsRTipoRecreacion() : "", true, true, 400, 420, "", "select * from cRTipoRecreacion ", "", "", 10, false, false)%>
        <%=MyUtil.ObjComboC("Sexo", "clSexo", RR != null ? RR.getDsSexo() : "", true, true, 30, 460, "", "select * from cSexo ", "", "", 10, false, false)%>
        <%=MyUtil.ObjInput("Peso (kg)", "Peso", RR != null ? RR.getPeso() : "", true, true, 210, 460, "", false, false, 30, "")%>
        <%=MyUtil.ObjInput("Edad", "Edad", RR != null ? RR.getEdad() : "", true, true, 400, 460, "", false, false, 30, "")%>
        <%=MyUtil.DoBlock("Información Adicional", 0, 0)%>

        <div class='VTable' style='position:absolute; z-index:25; left:360px; top:16px;' id="CtaCobertura">
            <input class='cBtn' type='button' value='Cobertura' onClick="window.open('../VistaCobertura.jsp?&clCuenta='+document.all.clCuenta.value,'','resizable=no,menubar=0,status=0,toolbar=0,height=450,width=1005,screenX=-50,screenY=0,scrollbars=yes')"></input>
        </div>

        <%=MyUtil.GeneraScripts()%>

        <script>
            function fnBuscaCuenta(){
                if (document.all.Nombre.value!=''){
                    if (document.all.Action.value==1){
                        var pstrCadena = "../../Utilerias/FiltrosCuenta.jsp?strSQL=sp_WebBuscaCuenta ";
                        pstrCadena = pstrCadena + "&Cuenta= " + document.all.Nombre.value;
                        window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
                    }
                }
            }

            function fnActualizaDatosCuenta(dsCuenta,clCuenta,clTipoVal, Msk, MskUsr, Agentes){
                if (document.all.Action.value ==1){ ////evita el bug de cambiar cuenta usando la ventana de busqueda de cuenta
                    document.all.Nombre.value = dsCuenta;
                    document.all.clCuenta.value = clCuenta;
                }
                fnLlenaServicioReferencias();
            }

            function fnBuscaAfiliado(){
                if (document.all.Action.value==1){
                    var pstrCadena = "../../Utilerias/FiltrosNuestroUsr.jsp?strSQL=sp_WebBuscaNuestroUsr ";
                    pstrCadena = pstrCadena + "&Clave= " + document.all.Clave.value + "&clCuenta= " + document.all.clCuenta.value;
                    window.open(pstrCadena,'newWinBA','scrollbars=yes,status=yes,width=1200,height=500,top=200,left=50');
                }
            }

            function fnActualizaDatosNuestroUsr(dsNU,Clave, pclCuenta, pNomCuenta, Msk, MskUsr, DatosNUsr, ClaveBeneficiario){
                if (document.all.Action.value==1 ){  ////evita el bug de cambiar datos (clave, NU, cuenta, etc) usando la ventana de busqueda de nuestro usr
                    document.all.NombredelUsuario.value=dsNU;
                    document.all.clCuenta.value=pNomCuenta;
                    document.all.Clave.value=Clave;
                    document.all.clCuenta.value=pclCuenta;
                    document.all.Nombre.value=pNomCuenta;
                }
                fnLlenaServicioReferencias();
            }

            function fnBuscaClienteVIP(){
                if (document.all.NombredelUsuario.value!='' && document.all.Action.value ==1){
                    var pstrCadena = "../BuscaClienteVIP.jsp?strSQL=sp_BuscaClienteVIP";
                    pstrCadena = pstrCadena + "&Nombre=" + document.all.NombredelUsuario.value;
                    window.open(pstrCadena,'newVIP','scrollbars=yes,status=yes,width=640,height=300');
                }
            }

            function fnValidaCorreo(){
                var strCorreo = document.all.Correo.value;
                if (document.all.Correo.value !=''){
                    if (strCorreo.indexOf('@',0) == -1){
                        alert("Escriba una direccion de correo Valida")
                        document.all.Correo.value="";
                        document.all.Correo.focus();
                    }
                }
            }

            function fnValidaNumero(){
                if(isNaN(document.all.Telefono.value)){
                    alert('Introduce sólo Numeros')
                    document.all.Telefono.value="";
                    document.all.Telefono.focus();
                }
            }

            //---- Llena Subservicio -----
            function fnLlenaSubservicio(){
                var strConsulta = "st_LlenasubservicioRedRef '" + document.all.clServicio.value+ "'";
                var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=clSubservicioC";
                fnOptionxDefault('clSubservicioC',pstrCadena);
            }

            /***************    SI HAY NUEVOS SUBSERVICIOS DE REFERENCIA, AGREGARLOS AQUI   *******************/
            function fnShow(clSubServicio){
                //<<<<<<<<<<<<<< Si  esta en Alta o en Cambio >>>>>>>>>>>>>>>>
                if (document.all.Action.value == 1 || document.all.Action.value == 2) {
                    document.all.clRInfo.disabled=false;
                    document.all.clMascotaRefC.disabled=false;
                    document.all.clRTipoRecreacionC.disabled=false;
                    document.all.clSexoC.disabled=false;
                    document.all.Peso.disabled=false;
                    document.all.Edad.disabled=false;
                }

                //<<<<<<<<<<<< Ref Mecanicas  >>>>>>>>>>>>>>>>
                if (clSubServicio==325){    //325 PROD  339 TEST
                    //<<< Campos No necesarios >>>>>>>>>>>>>>
                    document.all.clMascotaRefC.disabled=true;
                    document.all.clMascotaRefC.value='';
                    document.all.clMascotaRef.value='';

                    document.all.clRTipoRecreacionC.disabled=true;
                    document.all.clRTipoRecreacionC.value='';
                    document.all.clRTipoRecreacion.value='';

                    document.all.Peso.disabled=true;
                    document.all.Peso.value='';

                }

                //<<<<<<<<<<<< Ref  Ezpecializados  >>>>>>>>>>>>>>>>
                if (clSubServicio==324){    //324 PROD  338 TEST
                    document.all.clMascotaRefC.disabled=true;
                    document.all.clMascotaRefC.value='';
                    document.all.clMascotaRef.value='';

                    document.all.clRTipoRecreacionC.disabled=true;
                    document.all.clRTipoRecreacionC.value='';
                    document.all.clRTipoRecreacion.value='';

                    document.all.Peso.disabled=true;
                    document.all.Peso.value='';

                    document.all.Edad.disabled=true;
                    document.all.Edad.value='';
                }

                //<<<<<<<<<<<< Ref Mascotas >>>>>>>>>>>>>>>>
                if (clSubServicio==326){    //326 PROD  318 TEST
                    document.all.clRTipoRecreacionC.disabled=true;
                    document.all.clRTipoRecreacionC.value='';
                    document.all.clRTipoRecreacion.value='';

                    //document.all.clSexoC.disabled=true;
                    //document.all.clSexoC.value='';
                    //document.all.clSexo.value='';

                    //document.all.Edad.disabled=true;
                    //document.all.Edad.value='';
                }

                //<<<<<<<<<<<< Ref PC >>>>>>>>>>>>>>>>
                if (clSubServicio==328){    //328 PROD  340 TEST
                    document.all.clMascotaRefC.disabled=true;
                    document.all.clMascotaRefC.value='';
                    document.all.clMascotaRef.value='';

                    document.all.clRTipoRecreacionC.disabled=true;
                    document.all.clRTipoRecreacionC.value='';
                    document.all.clRTipoRecreacion.value='';

                    document.all.Peso.disabled=true;
                    document.all.Peso.value='';
                }
            }

            document.onclick = fnclickCambiar;
            var flag=1;

            function fnclickCambiar(){
                if (document.all.Action.value==2){
                    if(flag==1){
                        document.all.clRInfo.disabled=false;
                        document.all.clMascotaRefC.disabled=false;
                        document.all.clRTipoRecreacionC.disabled=false;
                        document.all.clSexoC.disabled=false;
                        document.all.Peso.disabled=false;
                        document.all.Edad.disabled=false;
                        fnShow(document.all.clSubservicio.value);
                        flag=2;
                    }
                }
            }

            function fnLlenaServicioReferencias(){
                var strConsulta = "sp_LlenaServicioModReferencias '" + document.all.clCuenta.value+ "'";
                var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=clServicioC";
                fnOptionxDefault('clServicioC',pstrCadena);
            }
        </script>

        <%
        daoRReferencias = null;
        RR = null;

        strclUsr = null;
        strclRReferencias = null;
        strclCuenta = null;
        strCodEnt = null;
        strCodMD = null;
        strclServicio = null;
        strclSubServicio = null;
        Store = null;
        Commit = null;
        %>
    </body>
</html>
