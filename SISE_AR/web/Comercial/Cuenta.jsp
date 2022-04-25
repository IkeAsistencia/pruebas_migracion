<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="com.ike.catalogos.DAOCuentas,com.ike.catalogos.to.Cuentas,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<html>
    <head>
        <title>Detalle de Cuentas</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" >
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../Utilerias/UtilAjax.js'></script>
        <script type="text/javascript" src='../Utilerias/overlib.js'></script>

        <%
                    String StrclUsrApp = "0";
                    String StrclCuenta = "0";
                    String NombreCta = "";
                    String StrclAseguradora = "0";
                    String StrdsAseguradora = "";
                    String StrclPais = "10";
                    String StrdsPais = "ARGENTINA";
                    String StrCodEnt = "";
                    String StrdsEntFed = "";
                    String StrCodMD = "";
                    String StrdsMunDel = "";
                    String StrclSubTipoCuenta = "";

                    if (session.getAttribute("clUsrApp") != null) {
                        StrclUsrApp = session.getAttribute("clUsrApp").toString();
                    }

                    if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) {
        %>Fuera de Horario<%
                        StrclUsrApp = null;
                        StrclCuenta = null;
                        NombreCta = null;
                        StrclAseguradora = null;
                        StrdsAseguradora = null;
                        StrclPais = null;
                        StrdsPais = null;
                        StrCodEnt = null;
                        StrdsEntFed = null;
                        StrCodMD = null;
                        StrdsMunDel = null;
                        StrclSubTipoCuenta = null;

                        return;
                    }

                    if (request.getParameter("clCuenta") != null) {
                        StrclCuenta = request.getParameter("clCuenta").toString();
                    } else {
                        if (session.getAttribute("clCuenta") != null) {
                            StrclCuenta = session.getAttribute("clCuenta").toString();
                        }
                    }

                    session.setAttribute("clCuenta", StrclCuenta);

                    DAOCuentas daoCU = null;
                    Cuentas CU = null;

                    if (StrclCuenta != "0") {
                        daoCU = new DAOCuentas();
                        CU = daoCU.getCuentas(StrclCuenta);

                        StrclAseguradora = CU != null ? CU.getClAseguradora() : "";
                        StrdsAseguradora = CU != null ? CU.getDsAseguradora() : "";
                        NombreCta = CU != null ? CU.getNombre() : "";
                        StrCodEnt = CU != null ? CU.getCodEnt() : "";
                        StrdsEntFed = CU != null ? CU.getDsEntFed() : "";
                        StrCodMD = CU != null ? CU.getCodMD() : "";
                        StrdsMunDel = CU != null ? CU.getDsMunDel() : "";
                        StrclSubTipoCuenta = CU != null ? CU.getClSubTipoCuenta() : "";
                    }

                    String StrclPaginaWeb = "32";
                    session.setAttribute("clPaginaWebP", StrclPaginaWeb);
                    session.setAttribute("NombreCta", NombreCta);

        %>
        <script type="text/javascript">fnOpenLinks(window.parent.frames.InfoRelacionada.height)</script>
        <%MyUtil.InicializaParametrosC(32, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="Cuenta.jsp?"%>'>
        <script type="text/javascript">document.all.btnElimina.disabled=true;</script>
        <INPUT id='clCuenta' name='clCuenta' type='hidden' value='<%=StrclCuenta%>'><br><br><br><br>

        <%=MyUtil.ObjInput("Cuenta (Nombre)", "Nombre", NombreCta, true, true, 30, 70, "", true, true, 70)%>
        <%=MyUtil.ObjInput("CUIT", "RFC", CU != null ? CU.getRFC() : "", true, true, 415, 70, "", true, true, 13)%>
        <%=MyUtil.ObjComboC("Empresa SEA", "clEmpresaSEA", CU != null ? CU.getDsEmpresaSEA() : "", true, true, 515, 70, "", "Select clEmpresaSEA, dsEmpresaSEA from cEmpresaSEA order by dsEmpresaSEA", "", "", 40, true, true)%>
        <%=MyUtil.ObjChkBox("Activo", "Activo", CU != null ? CU.getActivo() : "", true, true, 675, 70, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjInput("Descripci�n de la Cuenta", "dsCuenta", CU != null ? CU.getDsCuenta() : "", true, true, 30, 110, "", true, true, 70)%>
        <%=MyUtil.ObjComboC("Canal de Distribuci�n", "clCanalDistribucion", CU != null ? CU.getDsCanalDistribucion() : "", true, true, 415, 110, "", "Select clCanalDistribucion, dsCanalDistribucion from cCanalDistribucion order by dsCanalDistribucion", "", "", 40, true, true)%>
        <%=MyUtil.ObjComboC("Tipo de Cuenta", "clTipoCuenta", CU != null ? CU.getDsTipoCuenta() : "", true, true, 30, 150, "", "Select clTipoCuenta, dsTipoCuenta from cTipoCuenta order by dsTipoCuenta", "fnLlenaSubTipoCuenta()", "", 40, true, true)%>
        <%=MyUtil.ObjComboC("Subtipo de Cuenta", "clSubTipoCuenta", CU != null ? CU.getDsSubTipoCuenta() : "", true, true, 195, 150, "", "Select clSubTipoCuenta, dsSubTipoCuenta from cSubTipoCuenta where clSubTipoCuenta = " + StrclSubTipoCuenta + " order by dsSubTipoCuenta", "", "", 40, true, true)%>
        <div onmouseover="return overlib('<b>DETERMINA EL CAMPO DE B�SQUEDA PARA EL AFILIADO.</b>',CENTER);" onmouseout="return nd();">
            <%=MyUtil.ObjComboC("Tipo de Clave", "clTipoClave", CU != null ? CU.getDsTipoClave() : "", true, true, 360, 150, "", "Select clTipoClave, dsTipoClave from cTipoClave order by dsTipoClave", "", "", 40, true, true)%>
        </div>
        <%=MyUtil.ObjInput("ID Cuenta", "Cuenta", StrclCuenta, false, false, 30, 190, "", false, false, 9)%>
        <%=MyUtil.ObjInput("Prefijo", "PrefijoV", CU != null ? CU.getPrefijo() : "", false, false, 115, 190, "", false, false, 6)%>
        <%=MyUtil.ObjComboC("Grupo Cuenta", "clGrupoCuenta", CU != null ? CU.getDsGrupoCuenta() : "", true, true, 185, 190, "", "Select clGrupoCuenta,dsGrupoCuenta From cGrupoCuenta order by dsGrupoCuenta", "", "", 40, true, true)%>
        <%=MyUtil.ObjComboC("Tipo de Validaci�n", "clTipoValidacion", CU != null ? CU.getDsTipoValidacion() : "", true, true, 430, 190, "", "Select clTipoValidacion, dsTipoValidacion from cTipoValidacion order by dsTipoValidacion", "", "", 40, true, true)%>
        <%=MyUtil.ObjComboC("Aseguradora", "clAseguradora", StrdsAseguradora, true, true, 615, 190, StrclAseguradora, "Select clAseguradora, dsAseguradora from cAseguradora order by dsAseguradora", "", "", 40, false, false)%>
        <div onmouseover="return overlib('<b>HABILITA ESQUEMA DE BENEFICIARIOS EN RETENCIONES GENERALES.</b>',CENTER);" onmouseout="return nd();">
            <%=MyUtil.ObjChkBox("Beneficiarios", "Beneficiarios", CU != null ? CU.getBeneficiarios() : "", true, true, 30, 230, "0", "SI", "NO", "")%>
        </div>
        <div onmouseover="return overlib('<b>HABILITA LA CUENTA PARA RETENCIONES GENERALES.</b>',CENTER);" onmouseout="return nd();">
            <%=MyUtil.ObjChkBox("Retenciones", "Retencion", CU != null ? CU.getRetencion() : "", true, true, 140, 230, "0", "Si", "NO", "")%>
        </div>
        <div onmouseover="return overlib('<b>HABILITA LA CUENTA PARA CIRCUITO DE RECLAMOS.</b>',CENTER);" onmouseout="return nd();">
            <%=MyUtil.ObjChkBox("Reclamos", "Reclamo", CU != null ? CU.getReclamo() : "", true, true, 240, 230, "0", "SI", "NO", "")%>
        </div>
        <%=MyUtil.ObjChkBox("Envio A Cobro", "PermiteEnvioACobro", CU != null ? CU.getPermiteEnvioACobro() : "", true, true, 320, 230, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjChkBox("Cuenta VIP", "CuentaVIP", CU != null ? CU.getCuentaVIP() : "", true, true, 430, 230, "0", "SI", "NO", "")%>
        <%=MyUtil.DoBlock("Datos Generales", -60, 0)%>

        <%=MyUtil.ObjComboMem("Pais", "clPais", StrdsPais, StrclPais, cbPais.GeneraHTML(20, StrdsPais), false, false, 30, 320, StrclPais, "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", StrdsEntFed, StrCodEnt, cbEntidad.GeneraHTML(40, StrdsEntFed, Integer.parseInt(StrclPais)), true, true, 30, 360, "", "fnLLenaComboMDAjax(this.value);", "", 20, false, false, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", StrdsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(40, StrCodEnt, StrdsMunDel), true, true, 30, 400, "", "", "", 20, false, false, "LocalidadDiv")%>
        <%=MyUtil.ObjInput("Calle", "Calle", CU != null ? CU.getCalle() : "", true, true, 30, 440, "", false, false, 50)%>
        <%=MyUtil.DoBlock("Domicilio", 190, 0)%>

        <%=MyUtil.ObjInput("Nombre del Contacto", "Contacto", CU != null ? CU.getContacto() : "", true, true, 450, 320, "", false, false, 43)%>
        <%=MyUtil.ObjInput("LADA(1)", "Lada1", CU != null ? CU.getLada1() : "", true, true, 450, 360, "", false, false, 6)%>
        <%=MyUtil.ObjInput("Tel�fono(1)", "Tel1", CU != null ? CU.getTel1() : "", true, true, 510, 360, "", false, false, 20)%>
        <%=MyUtil.ObjInput("LADA(2)", "Lada2", CU != null ? CU.getLada2() : "", true, true, 450, 400, "", false, false, 6)%>
        <%=MyUtil.ObjInput("Tel�fono(2)", "Tel2", CU != null ? CU.getTel2() : "", true, true, 510, 400, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Informaci�n de Contacto", 0, 0)%>

        <%=MyUtil.GeneraScripts()%>
        <%
                    StrclUsrApp = null;
                    StrclCuenta = null;
                    NombreCta = null;
                    StrclAseguradora = null;
                    StrdsAseguradora = null;
                    StrclPais = null;
                    StrdsPais = null;
                    StrCodEnt = null;
                    StrdsEntFed = null;
                    StrCodMD = null;
                    StrdsMunDel = null;
                    StrclSubTipoCuenta = null;
                    StrclPaginaWeb = null;
        %>
        <script type="text/javascript" >
            function fnLlenaSubTipoCuenta(){
                var strConsulta = "sp_GetSubTipoCuenta " + document.all.clTipoCuenta.value;
                var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=clSubTipoCuentaC";
                fnOptionxDefault('clSubTipoCuentaC',pstrCadena);
            }

            function fnLlenaEntidadAjaxFn(cod){
                IDCombo= 'CodEnt';
                Label='Provincia';
                IdDiv='CodEntDiv';
                FnCombo='fnLLenaComboMDAjax(this.value);';
                URL = "../servlet/Combos.LlenaEntidadAjax?";
                Cadena = "Opcion="+cod+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            function fnLLenaComboMDAjax(value){
                IDCombo= 'CodMD';
                Label='Localidad';
                IdDiv='LocalidadDiv';
                FnCombo='';
                URL = "../servlet/Combos.LlenaMDAjax?";
                Cadena = "Opcion="+value+"&IdCombo="+IDCombo+"&Label="+Label+"&FnCombo="+FnCombo;
                fnLLenaInput(URL, Cadena, IdDiv);
            }

            document.all.Nombre.maxLength=60;
            document.all.RFC.maxLength=13;
            document.all.Calle.maxLength=100;
            document.all.Contacto.maxLength=100;
            document.all.Lada1.maxLength=5;
            document.all.Lada2.maxLength=5;
            document.all.Tel1.maxLength=10;
            document.all.Tel2.maxLength=10;

        </script>
    </body>
</html>
