<%@ page import="com.ike.catalogos.DAOProveedor"%>
<%@ page import="com.ike.catalogos.to.Proveedor"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.catalogos.to.Proveedor,com.ike.catalogos.DAOProveedor,Utilerias.UtileriasBDF,Combos.cbPais,Combos.cbEntidad" errorPage="" %>
<html>
    <head>
        <title>Detalle Proveedor Km0</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilDireccion.js'></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <script src='../Utilerias/UtilAjax.js'></script>
        <%
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es", "AR");

        String strclUsr = "0";
        String StrclProveedor = "0";
        String StrNomOpe = "";
        String CodEnt = "";
        String dsEntFed = "";
        String dsMunDel = "";
        String StrCodMD = "";
        int StrclPais = 10; //Pais default:  Argentina

        int xPos = 0, yPos = 0;

        if (session.getAttribute("clUsrApp") != null) {
            strclUsr = session.getAttribute("clUsrApp").toString();
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

        // ResultSet rs = UtileriasBDF.rsSQLNP("sp_DetalleProveedor " + StrclProveedor + "," + strclUsr);

        Proveedor prov = new Proveedor();
        DAOProveedor dao = new DAOProveedor();

        prov = dao.getProveedor(StrclProveedor, strclUsr);

        String StrclPaginaWeb = "89";
        session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <script>fnOpenLinks()</script>
        <%
        MyUtil.InicializaParametrosC(89, Integer.parseInt(strclUsr));
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "fnPaisDefault();", "fnLimpiaExtra();")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleProveedor.jsp?"%>'>
        <%
        if (prov != null) {
            StrNomOpe = prov.getNombreOpe();
            session.setAttribute("NombreOpe", StrNomOpe);

            CodEnt = prov.getCodEnt();
            dsEntFed = prov.getDsEntFed();
            dsMunDel = prov.getDsMunDel();
            StrCodMD = prov.getCodMD();
            StrclPais = Integer.valueOf(prov.getClPais());
        }
        %>
        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%= StrclProveedor%>'>
        <INPUT id='clAreaOperativa' name='clAreaOperativa' type='hidden' value='1'>

        <%=MyUtil.ObjInput("Nombre", "NombreRZ", prov != null ? prov.getNombreRZ() : "", true, true, 25, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Nombre En Operaci�n", "NombreOpe", prov != null ? prov.getNombreOpe() : "", true, true, 310, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Titular", "Titular", prov != null ? prov.getTitular() : "", true, true, 25, 120, "", true, true, 50)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.giro"), "clGiro", prov != null ? prov.getDsGiro() : "", true, true, 310, 120, "", "Select * from cGiro where clAreaOperativa = 1 order by dsGiro", "", "", 45, true, true)%>
        <%=MyUtil.ObjChkBox("", "Activo", prov != null ? prov.getActivo() : "", true, true, 480, 160, "", "ACTIVO", "INACTIVO", "")%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.rfc"), "RFC", prov != null ? prov.getRFC() : "", true, true, 25, 160, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.CuitMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Nextel", "NumNextel", prov != null ? prov.getNumNextel() : "", true, true, 175, 160, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Horario", "Horario", prov != null ? prov.getHorario() : "", true, true, 310, 160, "", false, false, 30)%>
        <%=MyUtil.ObjComboC("Tipo de Proveedor", "clTipoProveedor", prov != null ? prov.getDsTipoProveedor() : "", true, true, 25, 200, "", "Select clTipoProveedor, dsTipoProveedor from cTipoProveedor where clAreaOperativa = 1 order by dsTipoProveedor", "", "", 20, true, true)%>
        <%=MyUtil.ObjInput("Prioridad", "Prioridad", prov != null ? prov.getPrioridad() : "", true, true, 480, 200, "", true, true, 5)%>
        <%=MyUtil.DoBlock("Detalle de Proveedor de Gr�a")%>

        <%=MyUtil.ObjComboMem("Pais", "clPais", prov != null ? prov.getDsPais() : "", prov != null ? prov.getClPais() : "", cbPais.GeneraHTML(20, prov != null ? prov.getDsPais() : ""), true, true, 25, 280, "0", "fnLlenaEntidadAjaxFn(this.value);", "", 20, false, false)%>
        <%=MyUtil.ObjComboMemDiv("Provincia", "CodEnt", dsEntFed, CodEnt, cbEntidad.GeneraHTML(20, dsEntFed, StrclPais), true, true, 250, 280, "", "fnLLenaComboMDAjax(this.value);", "", 20, true, true, "CodEntDiv")%>
        <%=MyUtil.ObjComboMemDiv("Localidad", "CodMD", dsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(30, CodEnt, dsMunDel), true, true, 510, 280, "", "", "", 20, false, false, "LocalidadDiv")%>
        <%yPos = 320;%>
        <%=MyUtil.ObjInput("Calle", "Calle", prov != null ? prov.getCalle() : "", true, true, 25, yPos, "", false, false, 50)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"), "CP", prov != null ? prov.getCP() : "", true, true, 310, yPos, "", false, false, 10)%>
        <%=MyUtil.DoBlock("Ubicaci�n del Proveedor", 170, 0)%>

        <%yPos += 80;%>
        <%=MyUtil.ObjComboC("Banco", "clBanco", prov != null ? prov.getDsBanco() : "", true, true, 25, yPos, "", "Select * from cBanco where Activo=1 order by Nombre", "", "", 50, false, false)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.sucursal"), "SucursalBan", prov != null ? prov.getSucursalBan() : "", true, true, 350, yPos, "", false, false, 15)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.tipoCuenta"), "TipoCuentaBan", prov != null ? prov.getTipoCuentaBan() : "", true, true, 460, yPos, "", false, false, 20)%>
        <%yPos += 40;%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.plaza"), "PlazaBan", prov != null ? prov.getPlazaBan() : "", true, true, 25, yPos, "", false, false, 5)%>
        <%=MyUtil.ObjInput("A Nombre De", "ANombreDe", prov != null ? prov.getANombreDe() : "", true, true, 85, yPos, "", false, false, 40)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.numCuenta"), "CuentaBan", prov != null ? prov.getCuentaBan() : "", true, true, 325, yPos, "", false, false, 20)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.clabe"), "Clabe", prov != null ? prov.getClabe() : "", true, true, 460, yPos, "", false, false, 20)%>
        <%=MyUtil.DoBlock("Banco del Proveedor", 0, 0)%>
        <%yPos += 90;%>

        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", prov != null ? prov.getObservaciones() : "", "103", "7", true, true, 30, yPos, "", false, false)%>
        <%=MyUtil.DoBlock("Observaciones Extras", 400, 70)%>
        <%yPos += 150;%>
        <%=MyUtil.ObjChkBox("Carta Oferta Original Firmado", "Convenio", prov != null ? prov.getConvenio() : "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Ficha de proveedor(Obligatorio) ", "Ficha", prov != null ? prov.getFicha() : "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Conocimientos", "Conocimientos", prov != null ? prov.getConocimientos() : "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Experiencia ", "Experiencia", prov != null ? prov.getExperiencia() : "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Infraestructura", "Infraestructura", prov != null ? prov.getInfraestructura() : "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Copia del " + i18n.getMessage("message.title.rfc") + " (Obligatorio) ", "CopiaRFC", prov != null ? prov.getCopiaRFC() : "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Copia de Identificaci�n del responsable y t�cnicos(Opcional)", "CopiaIdent", prov != null ? prov.getCopiaIdent() : "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Estado de cuenta bancaria(Opcional)", "EdoCuenta", prov != null ? prov.getEdoCuenta() : "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Copia de factura del negocio u original cancelada(Opcional)", "CopiaFactura", prov != null ? prov.getCopiaFactura() : "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Fotograf�as del negocio(Opcional)", "Fotografias", prov != null ? prov.getFotografias() : "", true, true, 30, yPos, "0", "")%>
        <%=MyUtil.DoBlock("Requisitos de Aprobaci�n", 300, 0)%>

        <input name='CuitMsk' id='CuitMsk' type='hidden' value='VN09VN09F---VN09VN09VN09VN09VN09VN09VN09VN09F/--VN09'>
        <%

        strclUsr = null;
        StrclProveedor = null;
        StrNomOpe = null;
        StrclPaginaWeb = null;
        CodEnt = null;
        dsEntFed = null;
        dsMunDel = null;
        StrCodMD = null;

        prov = null;
        dao = null;

        %>
        <%=MyUtil.GeneraScripts()%>

        <script>
            function fnPaisDefault(){
                document.all.clPais.value=10;
                document.all.clPaisC.value=10;

                fnLlenaEntidadAjaxFn(10); // Carga Entidades de Argentina Por Default
            }
        </script>
    </body>
</html>