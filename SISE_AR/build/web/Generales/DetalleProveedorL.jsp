<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Combos.cbEntidad" errorPage="" %>
<html>
    <head>
        <title>Detalle Proveedor Legal</title>
    </head>
    <body class="cssBody">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilDireccion.js'></script>
        <script src='../Utilerias/UtilMask.js'></script>

        <%
            com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es", "AR");

            String StrclUsr = "0";
            String StrclProveedor = "0";
            String StrNomOpe = "";
            String CodEnt = "";
            String dsEntFed = "";
            String dsMunDel = "";
            String StrCodMD = "";
            String StrclPaginaWeb = "243";

            int xPos = 0, yPos = 0;

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsr = session.getAttribute("clUsrApp").toString();
            }
            if (request.getParameter("clProveedor") != null) {
                StrclProveedor = request.getParameter("clProveedor").toString();
            }
            if (StrclProveedor.compareToIgnoreCase("0") == 0) {
                if (session.getAttribute("clProveedor") != null) {
                    StrclProveedor = session.getAttribute("clProveedor").toString();
                }
            }
            session.setAttribute("clProveedor", StrclProveedor);

            StringBuffer StrSql = new StringBuffer();
            StrSql.append("sp_DetalleProveedor ").append(StrclProveedor).append(",").append(StrclUsr);

            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

        %><script>fnOpenLinks()</script><%        MyUtil.InicializaParametrosC(243, Integer.parseInt(StrclUsr));
        %>

        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "fnLimpiaExtra()")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleProveedorL.jsp?"%>'>

        <%
            if (rs.next()) {
                StrNomOpe = rs.getString("NombreOpe");
                session.setAttribute("NombreOpe", StrNomOpe);
                StrclProveedor = rs.getString("clProveedor");
        %>

        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
        <INPUT id='clAreaOperativa' name='clAreaOperativa' type='hidden' value='2'>

        <%=MyUtil.ObjInput("Nombre", "NombreRZ", rs.getString("NombreRZ"), true, true, 25, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Nombre Fiscal", "NombreOpe", rs.getString("NombreOpe"), true, true, 310, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Titular", "Titular", rs.getString("Titular"), true, true, 25, 120, "", true, true, 50)%>
        <%=MyUtil.ObjComboC("Rubro", "clGiro", rs.getString("dsGiro"), true, true, 310, 120, "", "Select clGiro, dsGiro from cGiro Where clAreaOperativa = 2 order by dsGiro", "", "", 10, true, true)%>
        <%=MyUtil.ObjChkBox("", "Activo", rs.getString("Activo"), true, true, 600, 120, "", "ACTIVO", "INACTIVO", "")%>
        <%=MyUtil.ObjInput("Cuit", "RFC", rs.getString("RFC"), true, true, 25, 160, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.CuitMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Nextel", "NumNextel", rs.getString("NumNextel"), true, true, 175, 160, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Horario", "Horario", rs.getString("Horario"), true, true, 310, 160, "", false, false, 50)%>
        <%=MyUtil.ObjComboC("Tipo de Proveedor", "clTipoProveedor", rs.getString("dsTipoProveedor"), true, true, 25, 200, "", "Select clTipoProveedor, dsTipoProveedor from cTipoProveedor where clAreaOperativa = 2 order by dsTipoProveedor", "fnValidaTipo()", "", 20, true, true)%>
        <%=MyUtil.ObjChkBox("Citas", "Citas", rs.getString("Citas"), true, true, 230, 200, "", "SI", "NO", "")%>
        <%=MyUtil.ObjComboC("Gerencia Regional del Proveedor", "clGerenciaReg", rs.getString("dsGerencia"), true, true, 310, 200, "", "Select clGerenciaReg, dsGerencia from cGerenciaRegional order by dsGerencia", "", "", 60, true, false)%>
        <%=MyUtil.ObjInput("Prioridad", "Prioridad", rs.getString("Prioridad"), true, true, 600, 160, "", true, true, 5)%>
        <%=MyUtil.ObjComboC("Tipo&nbsp;de&nbsp;Tabulador", "clTipoTabulador", rs.getString("dsTipoTabulador"), false, false, 600, 80, "2", "Select clTipoTabulador, dsTipoTabulador from cTipoTabulador Order By dsTipoTabulador", "", "", 60, false, false)%>
        <%=MyUtil.ObjInput("Clave Proveedor", "clProveedorD", StrclProveedor, false, false, 600, 200, "", false, false, 8)%>
        <%=MyUtil.DoBlock("Detalle de Proveedor de Legal")%>

        <%
            CodEnt = rs.getString("CodEnt");
            dsEntFed = rs.getString("dsEntFed");
            dsMunDel = rs.getString("dsMunDel");
            StrCodMD = rs.getString("CodMD");
        %>

        <%=MyUtil.ObjComboMem("Provincia", "CodEnt", dsEntFed, CodEnt, cbEntidad.GeneraHTML(20, dsEntFed), true, true, 25, 280, "", "fnLlenaMunicipios()", "", 20, true, true)%>
        <%=MyUtil.ObjComboMem("Localidad", "CodMD", dsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(30, CodEnt, dsMunDel), true, true, 410, 280, "", "", "", 20, true, true)%>
        <%=MyUtil.ObjInput("Calle", "Calle", rs.getString("Calle"), true, true, 25, 320, "", false, false, 50)%>
        <%=MyUtil.ObjInput("C�digo Postal", "CP", rs.getString("CP"), true, true, 310, 320, "", false, false, 10)%>
        <%=MyUtil.DoBlock("Ubicaci�n del Proveedor", 130, 0)%>
        <%yPos = 400;%>

        <%=MyUtil.ObjComboC("Banco", "clBanco", rs.getString("dsBanco"), true, true, 25, yPos, "", "Select clBanco, Nombre from cBanco where Activo=1 order by Nombre", "", "", 50, false, false)%>
        <%=MyUtil.ObjInput("N�m. Sucursal", "SucursalBan", rs.getString("SucursalBan"), true, true, 350, yPos, "", false, false, 15)%>
        <%=MyUtil.ObjInput("Tipo cuenta", "TipoCuentaBan", rs.getString("TipoCuentaBan"), true, true, 460, yPos, "", false, false, 20)%>
        <%=MyUtil.ObjChkBox("Cheque", "Cheque", rs.getString("Cheque"), true, true, 600, yPos, "", "ACTIVO", "INACTIVO", "")%>
        <%yPos += 40;%>
        <!--%=MyUtil.ObjInput("Plaza", "PlazaBan", rs.getString("PlazaBan"), true, true, 25, yPos, "", false, false, 5)%-->
        <%=MyUtil.ObjInput("A Nombre De", "ANombreDe", rs.getString("ANombreDe"), true, true, 25, yPos, "", false, false, 48)%>
        <%=MyUtil.ObjInput("N�m. Cuenta", "CuentaBan", rs.getString("CuentaBan"), true, true, 325, yPos, "", false, false, 20)%>
        <%=MyUtil.ObjInput("C.B.U.", "Clabe", rs.getString("Clabe"), true, true, 460, yPos, "", false, false, 30, "if(this.readOnly==false){fnValMask(this,document.all.CubMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("CUIT Asociado", "CuitA", rs.getString("CuitA"), true, true, 640, yPos, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.CuitMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Email 1", "Email1", rs.getString("Email1"), true, true, 25, 480, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Email 2", "Email2", rs.getString("Email2"), true, true, 250, 480, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Email 3", "Email3", rs.getString("Email3"), true, true, 475, 480, "", false, false, 40)%>
        <%=MyUtil.DoBlock("Banco del Proveedor", 0, 0)%>
        <%yPos += 120;%>

        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", rs.getString("Observaciones"), "102", "7", true, true, 30, yPos, "", false, false)%>
        <%=MyUtil.DoBlock("Observaciones Extras", 400, 70)%>
        <%yPos += 160;%>

        <%=MyUtil.ObjChkBox("Carta Oferta Original Firmado ", "Convenio", rs.getString("Convenio"), true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Ficha de proveedor(Obligatorio) ", "Ficha", rs.getString("Ficha"), true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Conocimientos", "Conocimientos", rs.getString("Conocimientos"), true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Experiencia ", "Experiencia", rs.getString("Experiencia"), true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Infraestructura", "Infraestructura", rs.getString("Infraestructura"), true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Copia del Cuit (Obligatorio) ", "CopiaRFC", rs.getString("CopiaRFC"), true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Copia de Identificaci�n del responsable y t�cnicos(Opcional)", "CopiaIdent", rs.getString("CopiaIdent"), true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Estado de cuenta bancaria(Opcional)", "EdoCuenta", rs.getString("EdoCuenta"), true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Copia de factura del negocio u original cancelada(Opcional)", "CopiaFactura", rs.getString("CopiaFactura"), true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Fotograf�as del negocio(Opcional)", "Fotografias", rs.getString("Fotografias"), true, true, 30, yPos, "0", "")%>
        <%=MyUtil.DoBlock("Requisitos de Aprobaci�n", 300, 0)%>
        <%
        } else {
            StrNomOpe = "";
            session.setAttribute("NombreOpe", StrNomOpe);
        %>
        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='0'>
        <INPUT id='clAreaOperativa' name='clAreaOperativa' type='hidden' value='2'>

        <%=MyUtil.ObjInput("Nombre", "NombreRZ", "", true, true, 25, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Nombre Fiscal", "NombreOpe", "", true, true, 310, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Titular", "Titular", "", true, true, 25, 120, "", true, true, 50)%>
        <%=MyUtil.ObjComboC("Rubro", "clGiro", "", true, true, 310, 120, "", "Select clGiro, dsGiro from cGiro Where clAreaOperativa = 2 order by dsGiro", "", "", 10, true, true)%>
        <%=MyUtil.ObjChkBox("", "Activo", "", true, true, 600, 120, "", "ACTIVO", "INACTIVO", "")%>
        <%=MyUtil.ObjInput("Cuit", "RFC", "", true, true, 25, 160, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.CuitMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Nextel", "NumNextel", "", true, true, 175, 160, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Horario", "Horario", "", true, true, 310, 160, "", false, false, 50)%>
        <%=MyUtil.ObjComboC("Tipo de Proveedor", "clTipoProveedor", "", true, true, 25, 200, "", "Select clTipoProveedor, dsTipoProveedor from cTipoProveedor where clAreaOperativa = 2 order by dsTipoProveedor", "", "", 20, true, true)%>
        <%=MyUtil.ObjChkBox("Citas", "Citas", "", true, true, 230, 200, "", "SI", "NO", "")%>
        <%=MyUtil.ObjInput("Prioridad", "Prioridad", "", true, true, 600, 200, "", true, true, 5)%>
        <%=MyUtil.ObjComboC("Gerencia Regional del Proveedor", "clGerenciaReg", "", true, true, 310, 200, "", "Select clGerenciaReg, dsGerencia from cGerenciaRegional order by dsGerencia", "", "", 60, true, false)%>
        <%=MyUtil.ObjComboC("Tipo&nbsp;de&nbsp;Tabulador", "clTipoTabulador", "", false, false, 600, 80, "2", "Select clTipoTabulador, dsTipoTabulador from cTipoTabulador Order By dsTipoTabulador", "", "", 20, false, false)%>
        <%=MyUtil.DoBlock("Detalle de Proveedor de Legal")%>

        <%=MyUtil.ObjComboMem("Provincia", "CodEnt", "", "", cbEntidad.GeneraHTML(20, ""), true, true, 25, 280, "", "fnLlenaMunicipios()", "", 20, true, true)%>
        <%=MyUtil.ObjComboMem("Localidad", "CodMD", "", "", cbEntidad.GeneraHTMLMD(30, "", ""), true, true, 410, 280, "", "", "", 20, true, true)%>
        <%=MyUtil.ObjInput("Calle", "Calle", "", true, true, 25, 320, "", false, false, 50)%>
        <%=MyUtil.ObjInput("C�digo Postal", "CP", "", true, true, 310, 320, "", false, false, 10)%>
        <%=MyUtil.DoBlock("Ubicaci�n del Proveedor", 130, 0)%>
        <%yPos = 400;%>

        <%=MyUtil.ObjComboC("Banco", "clBanco", "", true, true, 25, yPos, "", "Select clBanco, Nombre from cBanco where Activo = 1 order by Nombre", "", "", 50, false, false)%>
        <%=MyUtil.ObjInput("N�m. Sucursal", "SucursalBan", "", true, true, 350, yPos, "", false, false, 15)%>
        <%=MyUtil.ObjInput("Tipo Cuenta", "TipoCuentaBan", "", true, true, 460, yPos, "", false, false, 20)%>
        <%=MyUtil.ObjChkBox("Cheque", "Cheque", "", true, true, 600, yPos, "", "SI", "NO", "")%>
        <%yPos += 40;%>
        <!--%=MyUtil.ObjInput("Plaza", "PlazaBan", "", true, true, 25, yPos, "", false, false, 5)%-->
        <%=MyUtil.ObjInput("A Nombre De", "ANombreDe", "", true, true, 25, yPos, "", false, false, 48)%>
        <%=MyUtil.ObjInput("N�m. Cuenta", "CuentaBan", "", true, true, 325, yPos, "", false, false, 20)%>
        <%=MyUtil.ObjInput("C.U.B.", "Clabe", "", true, true, 460, yPos, "", false, false, 30, "if(this.readOnly==false){fnValMask(this,document.all.CubMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("CUIT Asociado", "CuitA", "", true, true, 640, yPos, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.CuitMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Email 1", "Email1", "", true, true, 25, 480, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Email 2", "Email2", "", true, true, 250, 480, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Email 3", "Email3", "", true, true, 475, 480, "", false, false, 40)%>
        <%=MyUtil.DoBlock("Banco del Proveedor", 0, 0)%>
        <%yPos += 120;%>

        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", "", "102", "7", true, true, 30, yPos, "", false, false)%>
        <%=MyUtil.DoBlock("Observaciones Extras", 400, 70)%>
        <%yPos += 160;%>
        <%=MyUtil.ObjChkBox("Carta Oferta Original Firmado", "Convenio", "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Ficha de proveedor(Obligatorio) ", "Ficha", "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Conocimientos", "Conocimientos", "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Experiencia ", "Experiencia", "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Infraestructura", "Infraestructura", "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Copia del Cuit (Obligatorio) ", "CopiaRFC", "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Copia de Identificaci�n del responsable y t�cnicos(Opcional)", "CopiaIdent", "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Estado de cuenta bancaria(Opcional)", "EdoCuenta", "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Copia de factura del negocio u original cancelada(Opcional)", "CopiaFactura", "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Fotograf�as del negocio(Opcional)", "Fotografias", "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.DoBlock("Requisitos de Aprobaci�n", 300, 0)%>
        <%
            }
        %>
        <%=MyUtil.GeneraScripts()%>
        <input name='CuitMsk' id='CuitMsk' type='hidden' value='VN09VN09F---VN09VN09VN09VN09VN09VN09VN09VN09F/--VN09'>
        <!--input name='CuitAMsk' id='CuitAMsk' type='hidden' value='VN09VN09F---VN09VN09VN09VN09VN09VN09VN09VN09F/--VN09'-->
        <input name='CubMsk' id='CubMsk' type='hidden' value='VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09'>
        <script>

            function fnValidaTipo() {
                if (document.all.clTipoProveedor.value == "1") {
                    document.all.clTipoTabuladorC.value = '2';
                    document.all.clTipoTabulador.value = '2';
                }
                else {
                    document.all.clTipoTabuladorC.value = '';
                    document.all.clTipoTabulador.value = '';
                }
            }
        </script>
        <%
            rs.close();
            rs = null;
            StrSql = null;

            StrclUsr = null;
            StrclProveedor = null;
            StrNomOpe = null;
            StrclPaginaWeb = null;
            CodEnt = null;
            dsEntFed = null;
            dsMunDel = null;
            StrCodMD = null;
        %>
    </body>
</html>