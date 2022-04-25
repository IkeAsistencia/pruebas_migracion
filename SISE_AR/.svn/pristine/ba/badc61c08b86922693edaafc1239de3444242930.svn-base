<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.asistencias.DAOModuloRedDescuentos,com.ike.asistencias.to.ModuloRedDescuentos;" %>

<html>
    <head>
        <title>Módulo Red de Descuentos</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../../Utilerias/Util.js'></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <script src='../../Utilerias/UtilStore.js'></script>

        <%
            String strclUsr = "0";
            String strclModuloRedDescuentos = "0";
            String StrCodEnt = "";
            String strclServicio = "";
            String StrclPaginaWeb = "";
            String StrclTipoDescuento = "";
            String StrclGiroRed = "";

            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true) {
        %> Fuera de Horario <%
                strclUsr = null;
                strclModuloRedDescuentos = null;
                StrCodEnt = null;
                strclServicio = null;
                StrclPaginaWeb = null;
                StrclTipoDescuento = null;
                StrclGiroRed = null;

                return;
            }

            if (request.getParameter("clModuloRedDescuentos") != null) {
                strclModuloRedDescuentos = request.getParameter("clModuloRedDescuentos").toString();
            } else {
                if (session.getAttribute("clModuloRedDescuentos") != null) {
                    strclModuloRedDescuentos = session.getAttribute("clModuloRedDescuentos").toString();
                }
            }

            session.setAttribute("clModuloRedDescuentos", strclModuloRedDescuentos);

            DAOModuloRedDescuentos daoModuloRedDescuentos = null;
            ModuloRedDescuentos MRD = null;

            //SERVLET GENERICO
            String Store = "";
            String Commit = "";

            Store = "st_GuardaMReddeDescuentos, st_ActualizaMReddeDescuentos";
            session.setAttribute("sp_Stores", Store);

            Commit = "clModuloRedDescuentos";
            session.setAttribute("Commit", Commit);
            // TERMINA SERVLET GENERICO

            if (!strclModuloRedDescuentos.equalsIgnoreCase("0")) {
                daoModuloRedDescuentos = new DAOModuloRedDescuentos();
                MRD = daoModuloRedDescuentos.getModuloRedDescuentos(strclModuloRedDescuentos);
            }

            if (MRD != null) {
                StrCodEnt = MRD.getCodEnt();
                strclServicio = MRD.getClServicio();

                StrclTipoDescuento = MRD.getClTipoDescuento();
                StrclGiroRed = MRD.getClGiroRed();
            }

            session.setAttribute("clTipoDescuentoSession", StrclTipoDescuento);
            session.setAttribute("clGiroRedSession", StrclGiroRed);

            StrclPaginaWeb = "5026";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %><script>fnOpenLinks()</script>

        <%MyUtil.InicializaParametrosC(5026, Integer.parseInt(strclUsr));%>

        <%=MyUtil.doMenuAct("../../servlet/com.ike.guarda.EjecutaSP", "", "fnsp_Guarda();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="ModuloRedDescuentos.jsp?"%>'>
        <INPUT id="Secuencia" name="Secuencia" type="hidden" value="">
        <INPUT id="SecuenciaG" name="SecuenciaG" type="hidden" value="FechadeApertura,clCuenta,NombredelUsuario,Clave,Telefono,CodEnt,CodMD,InformacionSol,clTipoDescuento,clGiroRed,clServicio,clSubservicio,clRedEstatus,Observaciones">
        <INPUT id="SecuenciaA" name="SecuenciaA" type="hidden" value="clModuloRedDescuentos,clCuenta,NombredelUsuario,Clave,Telefono,CodEnt,CodMD,InformacionSol,clTipoDescuento,clGiroRed,clServicio,clSubservicio,clRedEstatus,Observaciones">
        <INPUT id="clModuloRedDescuentos" name="clModuloRedDescuentos" type="hidden" value="<%=strclModuloRedDescuentos%>">
        <INPUT id='clCuenta' name='clCuenta' type='hidden' value='<%=MRD != null ? MRD.getClCuenta() : ""%>'>

        <%=MyUtil.ObjInput("Cuenta", "Nombre", MRD != null ? MRD.getDsCuenta() : "", true, true, 30, 80, "", true, false, 40, "fnBuscaCuenta();")%>

        <%
            if (MyUtil.blnAccess[4] == true) {%>
        <div class='VTable' style='position:absolute; z-index:25; left:250px; top:90px;'>
            <IMG SRC='../../Imagenes/Lupa.gif' onClick='fnBuscaCuenta();' WIDTH=20 HEIGHT=20>
        </div>
        <% }%>

        <%=MyUtil.ObjInput("Nombre del Usuario", "NombredelUsuario", MRD != null ? MRD.getNombredelUsuario() : "", true, true, 310, 80, "", true, false, 40, "if(this.readOnly==false){fnBuscaClienteVIP()}")%>
        <%
            if (MyUtil.blnAccess[4] == true) {%>
        <div class='VTable' style='position:absolute; z-index:25; left:530px; top:90px;'>
            <IMG SRC='../../Imagenes/Lupa.gif' onClick='fnBuscaAfiliado();' WIDTH=20 HEIGHT=20>
        </div>
        <% }%>
        <%=MyUtil.ObjInput("Clave", "Clave", MRD != null ? MRD.getClave() : "", true, true, 590, 80, "", true, false, 30, "")%>
        <%=MyUtil.ObjInput("Fecha Apertura <Strong>(Automatica)</Strong>", "FechadeApertura", MRD != null ? MRD.getFechadeApertura() : "", false, false, 770, 70, "", false, false, 25, "")%>
        <%=MyUtil.ObjInput("Teléfono Contacto", "Telefono", MRD != null ? MRD.getTelefono() : "", true, true, 30, 125, "", false, false, 20, "")%>
        <%=MyUtil.ObjComboC("Provincia", "CodEnt", MRD != null ? MRD.getDsEntFed() : "", true, true, 200, 125, "", "select codent,dsentfed from cEntFed order by dsEntFed", " fnLlenaMunicipiosCS();", "", 35, true, false)%>
        <%=MyUtil.ObjComboC("Localidad", "CodMD", MRD != null ? MRD.getDsMunDel() : "", true, true, 590, 125, "", "Select CodMD, dsMunDel from cMunDel where CodEnt='" + StrCodEnt + "' order by dsMunDel", "", "", 10, true, true)%>
        <%=MyUtil.ObjTextArea("Información Solicitada por N/U", "InformacionSol", MRD != null ? MRD.getInformacionSol() : "", "70", "5", true, true, 30, 170, "", false, false)%>
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", MRD != null ? MRD.getObservaciones() : "", "70", "5", true, true, 450, 170, "", false, false)%>
        <%=MyUtil.ObjComboC("Servicio", "clServicio", MRD != null ? MRD.getDsServicio() : "", true, true, 30, 260, "", "select S.clServicio, UPPER(S.dsServicio) 'dsServicio' from csubservicio CS left join cservicio S on (S.clservicio=CS.clservicio) where CS.clClasificacionServicios = 2", "fnLlenaSubservicios();", "", 30, true, true)%>
        <%=MyUtil.ObjComboC("Subservicio", "clSubservicio", MRD != null ? MRD.getDsSubServicio() : "", true, true, 230, 260, "", "select clSubservicio, UPPER(dssubservicio) from csubservicio where clClasificacionServicios = 2 and clServicio = '" + strclServicio + "'", "", "", 10, true, true)%>
        <%=MyUtil.ObjComboC("Tipo de Descuento", "clTipoDescuento", MRD != null ? MRD.getDsTipoDescuento() : "", true, true, 450, 260, "", "select clTipoDescuento, UPPER(dsTipoDescuento) 'dsTipoDescuento' from cTipoDescuento order by 2", "fnLlenaGiroRed();", "", 10, true, true)%>
        <%=MyUtil.ObjComboC("Rubro", "clGiroRed", MRD != null ? MRD.getDsGiroRed() : "", true, true, 620, 260, "", "select clGiroRed, UPPER(dsGiroRed) from cGiroRed order by dsGiroRed", "", "", 10, true, true)%>
        <%=MyUtil.ObjComboC("Estatus", "clRedEstatus", MRD != null ? MRD.getDsRedEstatus() : "", false, true, 30, 300, "3", "select clRedEstatus, UPPER(dsRedEstatus) from cRedEstatus order by dsRedEstatus", "", "", 10, true, true)%>
        <%=MyUtil.DoBlock("Módulo Red de Descuentos", -20, 0)%>

        <%
            daoModuloRedDescuentos = null;
            MRD = null;

            strclUsr = null;
            strclModuloRedDescuentos = null;
            StrCodEnt = null;
            strclServicio = null;
            StrclPaginaWeb = null;
            Store = null;
            Commit = null;
            StrclTipoDescuento = null;
            StrclGiroRed = null;
        %>

        <%=MyUtil.GeneraScripts()%>

        <script>
            function fnBuscaCuenta() {
                if (document.all.Nombre.value != '') {
                    if (document.all.Action.value == 1) {
                        var pstrCadena = "../../Utilerias/FiltrosCuenta.jsp?strSQL=sp_WebBuscaCuenta ";
                        pstrCadena = pstrCadena + "&Cuenta= " + document.all.Nombre.value;
                        window.open(pstrCadena, 'newWin', 'scrollbars=yes,status=yes,width=700,height=500');
                    }
                }
            }

            function fnActualizaDatosCuenta(dsCuenta, clCuenta, clTipoVal, Msk, MskUsr, Agentes) {
                if (document.all.Action.value == 1) { ////evita el bug de cambiar cuenta usando la ventana de busqueda de cuenta
                    document.all.Nombre.value = dsCuenta;
                    document.all.clCuenta.value = clCuenta;
                }
            }

            function fnBuscaAfiliado() {
                if (document.all.Action.value == 1) {
                    var pstrCadena = "../../Utilerias/FiltrosNuestroUsr.jsp?strSQL=sp_WebBuscaNuestroUsr ";
                    pstrCadena = pstrCadena + "&Clave= " + document.all.Clave.value + "&clCuenta= " + document.all.clCuenta.value;
                    window.open(pstrCadena, 'newWinBA', 'scrollbars=yes,status=yes,width=1200,height=500,top=200,left=50');
                }
            }

            function fnActualizaDatosNuestroUsr(dsNU, Clave, pclCuenta, pNomCuenta, Msk, MskUsr, DatosNUsr, ClaveBeneficiario) {
                if (document.all.Action.value == 1) {  ////evita el bug de cambiar datos (clave, NU, cuenta, etc) usando la ventana de busqueda de nuestro usr
                    document.all.NombredelUsuario.value = dsNU;
                    document.all.clCuenta.value = pNomCuenta;
                    document.all.Clave.value = Clave;
                    document.all.clCuenta.value = pclCuenta;
                    document.all.Nombre.value = pNomCuenta;
                }
            }

            function fnBuscaClienteVIP() {
                if (document.all.NombredelUsuario.value != '' && document.all.Action.value == 1) {
                    var pstrCadena = "../BuscaClienteVIP.jsp?strSQL=sp_BuscaClienteVIP";
                    pstrCadena = pstrCadena + "&Nombre=" + document.all.NombredelUsuario.value;
                    window.open(pstrCadena, 'newVIP', 'scrollbars=yes,status=yes,width=640,height=300');
                }
            }

            function fnLlenaSubservicios() {
                var strConsulta = "st_LlenasubservicioRed " + document.all.clServicio.value;
                var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=clSubservicioC";
                fnOptionxDefault('clSubservicioC', pstrCadena);
            }

            function fnLlenaGiroRed() {
                var strConsulta = "st_LlenaGiroRedDescuentos " + document.all.clTipoDescuento.value;
                var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=clGiroRedC";
                fnOptionxDefault('clGiroRedC', pstrCadena);
            }

        </script>
    </body>
</html>