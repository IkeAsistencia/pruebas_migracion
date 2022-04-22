<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Combos.cbEntidad" errorPage="" %>
<html>
    <head>
        <title>Detalle Proveedor Médico</title>
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
            String StrclPaginaWeb = "476";

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

            ResultSet rs = UtileriasBDF.rsSQLNP("sp_DetalleProveedor " + StrclProveedor + "," + StrclUsr);
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <script>fnOpenLinks()</script>
        <%
            MyUtil.InicializaParametrosC(476, Integer.parseInt(StrclUsr));
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "fnLimpiaExtra()")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleProveedorM.jsp?"%>'>
        <%
            if (rs.next()) {

                StrNomOpe = rs.getString("NombreOpe");
                session.setAttribute("NombreOpe", StrNomOpe);
        %>
        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%= rs.getString("clProveedor")%>'>
        <INPUT id='clAreaOperativa' name='clAreaOperativa' type='hidden' value='8'>

        <%=MyUtil.ObjInput("Nombre", "NombreRZ", rs.getString("NombreRZ"), true, true, 25, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Nombre Fiscal", "NombreOpe", rs.getString("NombreOpe"), true, true, 310, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Titular", "Titular", rs.getString("Titular"), true, true, 25, 120, "", true, true, 50)%>
        <%=MyUtil.ObjComboC("Rubro", "clGiro", rs.getString("dsGiro"), true, true, 310, 120, "", "Select clGiro, dsGiro from cGiro where clAreaOperativa=5 order by dsGiro", "", "", 20, true, true)%>
        <%=MyUtil.ObjChkBox("", "Activo", rs.getString("Activo"), true, true, 480, 200, "", "ACTIVO", "INACTIVO", "")%>
        <%=MyUtil.ObjInput("Cuit", "RFC", rs.getString("RFC"), true, true, 25, 160, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.CuitMsk.value,this.name)}")%>
        <%=MyUtil.ObjComboC("Tipo de Proveedor", "clTipoProveedor", rs.getString("dsTipoProveedor"), true, true, 25, 200, "", "Select clTipoProveedor, dsTipoProveedor from cTipoProveedor where clAreaOperativa = 5 order by dsTipoProveedor", "", "", 20, true, true)%>
        <%=MyUtil.ObjInput("Prioridad", "Prioridad", rs.getString("Prioridad"), false, false, 200, 200, "1", false, false, 5)%>
        <%=MyUtil.ObjInput("CURP", "CURP", rs.getString("CURP"), true, true, 175, 160, "", false, false, 20)%>
        <%=MyUtil.ObjComboC("Especialidad", "clEspecialidad", rs.getString("dsEspecialidad"), true, true, 310, 160, "", "Select clEspecialidad, dsEspecialidad From cEspecialidad", "fnLlenaComboSubEspecialidad()", "", 40, true, true)%>
        <%=MyUtil.ObjComboC("SubEspecialidad", "clSubEspecialidad", rs.getString("dsSubEspecialidad"), true, true, 310, 200, "", "Select clSubEspecialidad,dsSubEspecialidad from cSubEspecialidad where clEspecialidad='" + rs.getString("clEspecialidad") + "' order by dsSubEspecialidad", "", "", 40, false, false)%>
        <%=MyUtil.DoBlock("Detalle de Proveedor Médicos")%>
        <%yPos = 320;%>

        <%
            CodEnt = rs.getString("CodEnt");
            dsEntFed = rs.getString("dsEntFed");
            dsMunDel = rs.getString("dsMunDel");
            StrCodMD = rs.getString("CodMD");
        %>

        <%=MyUtil.ObjComboMem("Provincia", "CodEnt", dsEntFed, CodEnt, cbEntidad.GeneraHTML(20, dsEntFed), true, true, 25, 280, "", "fnLlenaMunicipios()", "", 20, true, true)%>
        <%=MyUtil.ObjComboMem("Localidad", "CodMD", dsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(30, CodEnt, dsMunDel), true, true, 410, 280, "", "", "", 20, true, true)%>
        <%=MyUtil.ObjInput("Calle", "Calle", rs.getString("Calle"), true, true, 25, yPos, "", false, false, 50)%>
        <%=MyUtil.ObjInput("Código Postal", "CP", rs.getString("CP"), true, true, 310, yPos, "", false, false, 10)%>
        <%=MyUtil.DoBlock("Ubicación del Proveedor", 130, 0)%>
        <%yPos += 80;%>

        <%=MyUtil.ObjComboC("Banco", "clBanco", rs.getString("dsBanco"), true, true, 25, yPos, "", "Select clBanco, Nombre from cBanco where Activo=1 order by Nombre", "", "", 50, false, false)%>
        <%=MyUtil.ObjInput("Núm. Sucursal", "SucursalBan", rs.getString("SucursalBan"), true, true, 350, yPos, "", false, false, 15)%>
        <%=MyUtil.ObjInput("Tipo Cuenta", "TipoCuentaBan", rs.getString("TipoCuentaBan"), true, true, 460, yPos, "", false, false, 20)%>
        <%=MyUtil.ObjChkBox("Cheque", "Cheque", rs.getString("Cheque"), true, true, 600, yPos, "", "SI", "NO", "")%>
        <%yPos += 40;%>
        <!--%=MyUtil.ObjInput("Plaza", "PlazaBan", rs.getString("PlazaBan"), true, true, 25, yPos, "", false, false, 5)%-->
        <%=MyUtil.ObjInput("A Nombre De", "ANombreDe", rs.getString("ANombreDe"), true, true, 25, yPos, "", false, false, 48)%>
        <%=MyUtil.ObjInput("Núm. Cuenta", "CuentaBan", rs.getString("CuentaBan"), true, true, 325, yPos, "", false, false, 20)%>
        <%=MyUtil.ObjInput("C.B.U.", "Clabe", rs.getString("Clabe"), true, true, 460, yPos, "", false, false, 30, "if(this.readOnly==false){fnValMask(this,document.all.CubMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Cuit Asociado", "CuitA", rs.getString("CuitA"), true, true, 640, yPos, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.CuitMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Email 1", "Email1", rs.getString("Email1"), true, true, 25, 480, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Email 2", "Email2", rs.getString("Email2"), true, true, 250, 480, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Email 3", "Email3", rs.getString("Email3"), true, true, 475, 480, "", false, false, 40)%>
        <%=MyUtil.DoBlock("Banco del Proveedor", 0, 0)%>
        <%yPos += 120;%>

        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", rs.getString("Observaciones"), "100", "7", true, true, 30, yPos, "", false, false)%>
        <%=MyUtil.DoBlock("Observaciones Extras", 400, 70)%>
        <%yPos += 150;%>

        <%=MyUtil.ObjChkBox("Título", "Titulo", rs.getString("Titulo"), true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Cédula", "Cedula", rs.getString("Cedula"), true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Recertificación", "Recertificacion", rs.getString("Recertificacion"), true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Especialidad ", "Especialidad", rs.getString("Especialidad"), true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Diploma de Especialidad", "DiplomaEsp", rs.getString("DiplomaEsp"), true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Adiestramiento", "Adiestramiento", rs.getString("Adiestramiento"), true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Cédula de Especialidad", "CedulaEsp", rs.getString("CedulaEsp"), true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Certificado", "Certificado", rs.getString("Certificado"), true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.DoBlock("Requisitos de Aprobación", 300, 0)%>

        <%
        } else {

            StrNomOpe = "";
            session.setAttribute("NombreOpe", StrNomOpe);
        %>
        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='0'>
        <INPUT id='clAreaOperativa' name='clAreaOperativa' type='hidden' value='8'>

        <%=MyUtil.ObjInput("Nombre", "NombreRZ", "", true, true, 25, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Nombre Fiscal", "NombreOpe", "", true, true, 310, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Titular", "Titular", "", true, true, 25, 120, "", true, true, 50)%>
        <%=MyUtil.ObjComboC("Rubro", "clGiro", "", true, true, 310, 120, "", "Select clGiro, dsGiro from cGiro where clAreaOperativa = 5 order by dsGiro", "", "", 20, true, true)%>
        <%=MyUtil.ObjChkBox("", "Activo", "", true, true, 480, 200, "", "ACTIVO", "INACTIVO", "")%>
        <%=MyUtil.ObjInput("C.U.B.", "RFC", "", true, true, 25, 160, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.CuitMsk.value,this.name)}")%>

        <%=MyUtil.ObjComboC("Tipo de Proveedor", "clTipoProveedor", "", true, true, 25, 200, "", "Select clTipoProveedor, dsTipoProveedor from cTipoProveedor where clAreaOperativa = 5 order by dsTipoProveedor", "", "", 20, true, true)%>
        <%=MyUtil.ObjInput("Prioridad", "Prioridad", "1", false, false, 200, 200, "1", false, false, 5)%>
        <%=MyUtil.ObjInput("CURP", "CURP", "", true, true, 175, 160, "", false, false, 20)%>
        <%=MyUtil.ObjComboC("Especialidad", "clEspecialidad", "", true, true, 310, 160, "", "Select clEspecialidad, dsEspecialidad From cEspecialidad", "fnLlenaComboSubEspecialidad()", "", 40, true, true)%>
        <%=MyUtil.ObjComboC("SubEspecialidad", "clSubEspecialidad", "", true, true, 310, 200, "", "", "", "", 40, false, false)%>
        <%=MyUtil.DoBlock("Detalle de Proveedor Médicos")%>
        <%yPos = 320;%>

        <%=MyUtil.ObjComboMem("Provincia", "CodEnt", "", "", cbEntidad.GeneraHTML(20, ""), true, true, 25, 280, "", "fnLlenaMunicipios()", "", 20, true, true)%>
        <%=MyUtil.ObjComboMem("Localidad", "CodMD", "", "", cbEntidad.GeneraHTMLMD(30, "", ""), true, true, 310, 280, "", "", "", 20, true, true)%>
        <%=MyUtil.ObjInput("Calle", "Calle", "", true, true, 25, yPos, "", false, false, 50)%>
        <%=MyUtil.ObjInput("Código Postal", "CP", "", true, true, 310, yPos, "", false, false, 10)%>
        <%=MyUtil.DoBlock("Ubicación del Proveedor", 130, 0)%>
        <%yPos += 80;%>

        <%=MyUtil.ObjComboC("Banco", "clBanco", "", true, true, 25, yPos, "", "Select clBanco, Nombre from cBanco where Activo=1 order by Nombre", "", "", 50, false, false)%>
        <%=MyUtil.ObjInput("Núm. Sucursal", "SucursalBan", "", true, true, 350, yPos, "", false, false, 15)%>
        <%=MyUtil.ObjInput("Tipo Cuenta", "TipoCuentaBan", "", true, true, 460, yPos, "", false, false, 20)%>
        <%=MyUtil.ObjChkBox("", "Cheque", "", true, true, 600, yPos, "", "CHEQUE ACTIVO", "CHEQUE INACTIVO", "")%>
        <%yPos += 40;%>
        <!--%=MyUtil.ObjInput("Plaza", "PlazaBan", "", true, true, 25, yPos, "", false, false, 5)%-->
        <%=MyUtil.ObjInput("A Nombre De", "ANombreDe", "", true, true, 25, yPos, "", false, false, 48)%>
        <%=MyUtil.ObjInput("Núm. Cuenta", "CuentaBan", "", true, true, 325, yPos, "", false, false, 20)%>
        <%=MyUtil.ObjInput("C.U.B.", "Clabe", "", true, true, 460, yPos, "", false, false, 30, "if(this.readOnly==false){fnValMask(this,document.all.CubMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("CUIT Asociado", "CuitA", "", true, true, 640, yPos, "", false, false, 30, "if(this.readOnly==false){fnValMask(this,document.all.CuitMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Email 1", "Email1", "", true, true, 25, 480, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Email 2", "Email2", "", true, true, 250, 480, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Email 3", "Email3", "", true, true, 475, 480, "", false, false, 40)%>
        <%=MyUtil.DoBlock("Banco del Proveedor", 0, 0)%>
        <%yPos += 120;%>

        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", "", "100", "7", true, true, 30, yPos, "", false, false)%>
        <%=MyUtil.DoBlock("Observaciones Extras", 400, 70)%>
        <%yPos += 150;%>

        <%=MyUtil.ObjChkBox("Título", "Titulo", "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Cédula", "Cédula", "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Recertificacion", "Recertificacion", "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Especialidad ", "Especialidad", "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Diploma de Especialidad", "DiplomaEsp", "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Adiestramiento", "Adiestramiento", "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Cédula de Especialidad", "CedulaEsp", "", true, true, 30, yPos, "0", "")%>
        <%yPos += 40;%>
        <%=MyUtil.ObjChkBox("Certificado", "Certificado", "", true, true, 30, yPos, "0", "")%>
        <%=MyUtil.DoBlock("Requisitos de Aprobación", 300, 0)%>

        <%
            }
        %>
        <input name='CuitMsk' id='CuitMsk' type='hidden' value='VN09VN09F---VN09VN09VN09VN09VN09VN09VN09VN09F/--VN09'>
        <!--input name='CuitAMsk' id='CuitAMsk' type='hidden' value='VN09VN09F---VN09VN09VN09VN09VN09VN09VN09VN09F/--VN09'-->
        <input name='CubMsk' id='CubMsk' type='hidden' value='VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09'>
        <%
            rs.close();
            rs = null;

            StrclUsr = null;
            StrclProveedor = null;
            StrNomOpe = null;
            StrclPaginaWeb = null;
            CodEnt = null;
            dsEntFed = null;
            dsMunDel = null;
            StrCodMD = null;
        %>
        <%=MyUtil.GeneraScripts()%>

        <script>

            function fnLlenaComboSubEspecialidad() {

                var strConsulta = "sp_LlenaComboSubEspecialidad '" + document.all.clEspecialidad.value + "'";
                var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                //      alert(pstrCadena);
                document.all.clSubEspecialidad.value = '';
                pstrCadena = pstrCadena + "&strName=clSubEspecialidadC";
                fnOptionxDefault('clSubEspecialidadC', pstrCadena);
            }

        </script>
    </body>
</html>