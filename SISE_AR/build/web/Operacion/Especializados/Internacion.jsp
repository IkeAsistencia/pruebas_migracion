<%-- 
    Document   : Internacion
    Created on : 11/02/2013, 01:00:48 PM
    Author     : fcerqueda
--%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="com.ike.asistencias.DAOInternacion,com.ike.asistencias.to.Internacion,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,java.sql.ResultSet,Utilerias.UtileriasBDF;"%>

<html>
    <head>
        <title>Internacion</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>
        <%
                    String StrclUsrApp = "0";
                    String StrclExpediente = "0";
                    String StrclPaginaWeb = "6057";

                    String StrclPais = "10";
                    String StrdsPais = "";
                    String StrCodEnt = "";
                    String StrdsEntFed = "";
                    String StrCodMD = "";
                    String StrdsMunDel = "";

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
                        StrclCuenta = null;
                        StrDsCuenta = null;
                        StrNU = null;
                        StrClave = null;
                        StrfechaApertura = null;
                        StrTel = null;
                        StrCorreo = null;

                        return;
                    }

                    DAOInternacion DI = null;
                    Internacion OI = null;

                    StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
                    ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
                    StrSql.delete(0, StrSql.length());

                    if (rs.next()) {
                        DI = new DAOInternacion();
                        OI = DI.getInternacion(StrclExpediente);

                        StrclPais = OI != null ? OI.getClPais() : StrclPais;
                        StrdsPais = OI != null ? OI.getDsPais() : StrdsPais;
                        StrCodEnt = OI != null ? OI.getCodEnt() : StrCodEnt;
                        StrdsEntFed = OI != null ? OI.getDsEntfed() : StrdsEntFed;
                        StrCodMD = OI != null ? OI.getCodMD() : StrCodMD;
                        StrdsMunDel = OI != null ? OI.getDsMunDel() : StrdsMunDel;
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
        <%MyUtil.InicializaParametrosC(6057, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "", "")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="Internacion.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='clCuenta' name='clCuenta' type='hidden' value='<%=StrclCuenta%>'>

        <%=MyUtil.ObjInput("Cuenta", "Nombre", OI != null ? OI.getDsCuenta() : "", false, false, 30, 80, StrDsCuenta, true, true, 35, "")%>
        <%=MyUtil.ObjInput("Nombre de Usuario", "NombreUsuario", OI != null ? OI.getNombredelUsuario() : "", false, false, 280, 80, StrNU, true, true, 35, "")%>
        <%=MyUtil.ObjInput("Clave", "Clave", OI != null ? OI.getClave() : "", false, false, 540, 80, StrClave, true, true, 30, "")%>
        <%=MyUtil.ObjInput("Fecha Apertura", "FechaApertura", OI != null ? OI.getFechadeApertura() : "", false, false, 770, 80, StrfechaApertura, true, true, 20, "")%>
        <%=MyUtil.ObjInput("Teléfono Contacto", "Telefono", OI != null ? OI.getTelefono() : "", true, true, 30, 125, StrTel, true, false, 25, "fnValidaNumero();")%>
        <%=MyUtil.ObjInput("E-mail", "Correo", OI != null ? OI.getCorreo() : "", true, true, 200, 125, StrCorreo, false, false, 45, "fnValidaCorreo();")%>
        <%=MyUtil.ObjComboMem("Pais", "clPais", StrdsPais, StrclPais, cbPais.GeneraHTML(20, StrdsPais), true, false, 490, 125, StrclPais, "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", StrdsEntFed, StrCodEnt, cbEntidad.GeneraHTML(40, StrdsEntFed, Integer.parseInt(StrclPais)), true, true, 490, 170, StrCodEnt, "fnLLenaComboMDAjax(this.value);", "", 20, true, true, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", StrdsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(40, StrCodEnt, StrdsMunDel), true, true, 490, 210, StrCodMD, "", "", 20, true, true, "LocalidadDiv")%>
        <%=MyUtil.ObjTextArea("Link de Web o Fuente Proporcionada a N/U", "LigaPro", OI != null ? OI.getLigaPro() : "", "80", "4", true, true, 30, 170, "", false, false)%>
        <%=MyUtil.ObjTextArea("Información Solicitada por N/U", "InfSolicitada", OI != null ? OI.getInformacionSol() : "", "80", "6", true, true, 30, 250, "", true, false)%>
        <%=MyUtil.ObjTextArea("Información Proporcionada a N/U", "InfProporcionada", OI != null ? OI.getInformacionPro() : "", "80", "6", true, true, 470, 250, "", true, false)%>
        <%=MyUtil.DoBlock("Asistencia Ante Internación", -50, 60)%>
        <%=MyUtil.GeneraScripts()%>

        <script type="text/javascript" >
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
                    DI = null;
                    OI = null;

                    rExp.close();
                    rs.close();

                    rExp = null;
                    rs = null;
        %>
    </body>
</html>
