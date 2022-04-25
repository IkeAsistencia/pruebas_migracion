<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="com.ike.asistencias.DAOTramitel,com.ike.asistencias.to.Tramitel,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,Combos.cbAMIS,java.sql.ResultSet,Utilerias.UtileriasBDF"%>

<html>
    <head>
        <title>Tramitel</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAuto.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>

        <%
                    String StrclUsrApp = "0";
                    String StrclExpediente = "0";
                    String StrclPaginaWeb = "6056";

                    String StrclPais = "10";
                    String StrdsPais = "";
                    String StrCodEnt = "";
                    String StrdsEntFed = "";
                    String StrCodMD = "";
                    String StrdsMunDel = "";
                    String StrclMarcaAuto = "";

                    //  DATOS DEL AFILIADO
                    String StrclCuenta = "0";       //sesion
                    String StrDsCuenta = "";
                    String StrNU = "";
                    String StrClave = "";            //sesion
                    String StrfechaApertura = "";
                    String StrTel = "";
                    String StrCorreo = "";           //sesion

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
                    if (session.getAttribute("CodEnt") != null) {
                        StrCodEnt = session.getAttribute("CodEnt").toString();
                    }
                    if (session.getAttribute("dsEntFed") != null) {
                        StrdsEntFed = session.getAttribute("dsEntFed").toString();
                    }
                    if (session.getAttribute("CodMD") != null) {
                        StrCodMD = session.getAttribute("CodMD").toString();
                    }
                    if (session.getAttribute("dsMunDel") != null) {
                        StrdsMunDel = session.getAttribute("dsMunDel").toString();
                    }
                    if (session.getAttribute("clCuenta") != null) {
                        StrclCuenta = session.getAttribute("clCuenta").toString();
                    }
                    if (session.getAttribute("Clave") != null) {
                        StrClave = session.getAttribute("Clave").toString();
                    }
                    if (session.getAttribute("Correo") != null) {
                        StrCorreo = session.getAttribute("Correo").toString();
                    }

                    StringBuffer StrSql = new StringBuffer();

                    StrSql.append(" st_getDatosExpediente ").append(StrclExpediente);
                    ResultSet rExp = UtileriasBDF.rsSQLNP(StrSql.toString());
                    StrSql.delete(0, StrSql.length());

                    if (rExp.next()) {
                        StrDsCuenta = rExp.getString("Nombre");
                        StrNU = rExp.getString("NuestroUsuario");
                        StrTel = rExp.getString("Telefono");
                        rExp = UtileriasBDF.rsSQLNP("select convert(varchar(16),getdate(),121) as 'fechaA'");
                        if (rExp.next()) {
                            StrfechaApertura = rExp.getString("fechaA");
                        }
                    } else {
                        rExp.close();
                        rExp = null;
                    }

                    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %> Fuera de Horario <%

                        StrclUsrApp = null;
                        StrclExpediente = null;
                        StrclPaginaWeb = null;
                        StrclPais = null;
                        StrdsPais = null;
                        StrCodEnt = null;
                        StrdsEntFed = null;
                        StrCodMD = null;
                        StrdsMunDel = null;
                        StrclMarcaAuto = null;
                        StrclCuenta = null;
                        StrDsCuenta = null;
                        StrNU = null;
                        StrClave = null;
                        StrfechaApertura = null;
                        StrTel = null;
                        StrCorreo = null;

                        return;
                    }

                    DAOTramitel daoTM = null;
                    Tramitel TM = null;

                    StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
                    ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
                    StrSql.delete(0, StrSql.length());

                    if (rs.next()) {
                        daoTM = new DAOTramitel();
                        TM = daoTM.getTramitel(StrclExpediente);

                        StrclPais = TM != null ? TM.getClPais() : StrclPais;
                        StrdsPais = TM != null ? TM.getDsPais() : StrdsPais;
                        StrCodEnt = TM != null ? TM.getCodEnt() : StrCodEnt;
                        StrdsEntFed = TM != null ? TM.getDsEntfed() : StrdsEntFed;
                        StrCodMD = TM != null ? TM.getCodMD() : StrCodMD;
                        StrdsMunDel = TM != null ? TM.getDsMunDel() : StrdsMunDel;

                        StrclMarcaAuto = TM != null ? TM.getCodigoMarca() : "";

                    } else {
        %> El expediente no existe <%

                        rs.close();
                        rs = null;

                        StrclPais = null;
                        StrdsPais = null;
                        StrCodEnt = null;
                        StrdsEntFed = null;
                        StrCodMD = null;
                        StrdsMunDel = null;
                        StrclMarcaAuto = null;
                        StrclCuenta = null;
                        StrDsCuenta = null;
                        StrNU = null;
                        StrClave = null;
                        StrfechaApertura = null;
                        StrTel = null;
                        StrCorreo = null;
                        return;
                    }
                    session.setAttribute("clPaginaWebP", StrclPaginaWeb);

        %>

        <script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(6056, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "", "")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="Tramitel.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='clCuenta' name='clCuenta' type='hidden' value='<%=StrclCuenta%>'>

        <%=MyUtil.ObjInput("Cuenta", "Nombre", TM != null ? TM.getDsCuenta() : "", false, false, 30, 80, StrDsCuenta, true, true, 35, "")%>
        <%=MyUtil.ObjInput("Nombre de Usuario", "NombreUsuario", TM != null ? TM.getNombredelUsuario() : "", false, false, 280, 80, StrNU, true, true, 35, "")%>
        <%=MyUtil.ObjInput("Clave", "Clave", TM != null ? TM.getClave() : "", false, false, 540, 80, StrClave, true, true, 30, "")%>
        <%=MyUtil.ObjInput("Fecha Apertura", "FechaApertura", TM != null ? TM.getFechadeApertura() : "", false, false, 770, 80, StrfechaApertura, true, true, 20, "")%>
        <%=MyUtil.ObjInput("Teléfono Contacto", "Telefono", TM != null ? TM.getTelefono() : "", true, true, 30, 125, StrTel, true, false, 25, "fnValidaNumero();")%>
        <%=MyUtil.ObjInput("E-mail", "Correo", TM != null ? TM.getCorreo() : "", true, true, 200, 125, StrCorreo, false, false, 45, "fnValidaCorreo();")%>


        <%=MyUtil.ObjComboMem("Pais", "clPais", StrdsPais, StrclPais, cbPais.GeneraHTML(20, StrdsPais), true, false, 490, 125, StrclPais, "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", StrdsEntFed, StrCodEnt, cbEntidad.GeneraHTML(40, StrdsEntFed, Integer.parseInt(StrclPais)), true, true, 490, 170, StrCodEnt, "fnLLenaComboMDAjax(this.value);", "", 20, true, true, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", StrdsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(40, StrCodEnt, StrdsMunDel), true, true, 490, 210, StrCodMD, "", "", 20, true, true, "LocalidadDiv")%>


        <%=MyUtil.ObjTextArea("Link de Web o Fuente Proporcionada a N/U", "LigaPro", TM != null ? TM.getLigaPro() : "", "80", "4", true, true, 30, 170, "", false, false)%>
        <%=MyUtil.ObjTextArea("Información Solicitada por N/U", "InfSolicitada", TM != null ? TM.getInformacionSol() : "", "80", "6", true, true, 30, 250, "", true, false)%>
        <%=MyUtil.ObjTextArea("Información Proporcionada a N/U", "InfProporcionada", TM != null ? TM.getInformacionSol() : "", "80", "6", true, true, 470, 250, "", true, false)%>
        <%=MyUtil.DoBlock("Tramitel", -50, 60)%>

        <%=MyUtil.ObjComboC("Tipo de Falla", "clTipoFalla", TM != null ? TM.getDsTipoFalla() : "", true, true, 30, 410, "", "Select * from cTipoFalla where DerivadoDe = 'A1' ", "", "", 50, true, true)%>
        <%=MyUtil.ObjComboC("Tipo de Grua", "clTipoGrua", TM != null ? TM.getDsTipoGrua() : "", true, true, 280, 410, "", "Select clTipoGrua, dsTipoGrua from cTipoGrua", "", "", 50, true, true)%>
        <%=MyUtil.ObjInput("Modelo", "Modelo", TM != null ? TM.getModelo() : "", true, true, 530, 410, "", true, true, 6, "if(this.readOnly==false){fnValidaModelo(this)}")%>
        <%=MyUtil.ObjInput("Color", "Color", TM != null ? TM.getColor() : "", true, true, 680, 410, "", true, true, 10)%>
        <%=MyUtil.ObjInput("Patente", "Placas", TM != null ? TM.getPatente() : "", true, true, 830, 410, "", true, true, 8)%>
        <%=MyUtil.ObjComboC("Marca de Auto", "CodigoMarca", TM != null ? TM.getDsMarcaAuto() : "", true, true, 30, 450, "", " Select CodigoMarca, dsMarcaAuto from cMarcaAuto order by dsMarcaAuto", "fnLlenaTipoAutoAjax(this.value,'ClaveAMIS','Tipo de Auto','TipoAutoDiv','',2);", "", 50, true, false)%>
        <%=MyUtil.ObjComboCDiv("Tipo de Auto", "ClaveAMIS", TM != null ? TM.getDsTipoAuto() : "", true, true, 280, 450, "", " Select ClaveAMIS, dsTipoAuto from cTipoAuto where CodigoMarca = '" + StrclMarcaAuto + "' order by dsTipoAuto", "", "", 50, true, false, "TipoAutoDiv")%>
        <%=MyUtil.ObjComboC("Lugar", "clLugarEvento", TM != null ? TM.getDsLugarEvento() : "", true, true, 530, 450, "", "select clLugarEvento, dsLugarEvento from cLugarEvento order by dsLugarEvento", "", "", 20, true, true)%>

        <%--<INPUT id='ClaveAMISVTR' name='ClaveAMISVTR' type='hidden' value=''>--%>
        <%=MyUtil.DoBlock("Información Vehículo ", -110, 0)%>

        <%=MyUtil.GeneraScripts()%>

        <script>

            function fnValidaNumero(){  //-->ok
                if(isNaN(document.all.Telefono.value)){
                    alert('Introduce sólo Números.')
                    document.all.Telefono.value="";
                    document.all.Telefono.focus();
                }
            }

            function fnValidaCorreo(){  //-->ok
                var strCorreo = document.all.Correo.value;
                if (document.all.Correo.value !=''){
                    if (strCorreo.indexOf('@',0) == -1){
                        alert("Escriba una dirección de correo válida.")
                        document.all.Correo.value="";
                        document.all.Correo.focus();
                    }
                }
            }

            function fnLlenaEntidadAjaxFn(cod){  /// Llena ComboMemDiv de Entidad segun pais seleccionado CON funcion
                IDCombo= 'CodEnt';
                Label='Provincia';
                IdDiv='CodEntDiv';
                FnCombo='fnLLenaComboMDAjax(this.value);';
                URL = "../../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion="+cod+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjax(value){
                IDCombo= 'CodMD';
                Label='Localidad';
                IdDiv='LocalidadDiv';
                FnCombo='';
                URL = "../../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion="+value+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

        </script>

        <%
                    daoTM = null;
                    TM = null;

                    rExp.close();
                    rs.close();

                    rExp = null;
                    rs = null;
        %>
    </body>
</html>
