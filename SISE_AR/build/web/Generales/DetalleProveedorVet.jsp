<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Combos.cbEntidad" errorPage="" %>
<html>
    <head>
        <title>Detalle Proveedor Mascotas</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
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
            String StrclPaginaWeb = "5003";

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
            MyUtil.InicializaParametrosC(5003, Integer.parseInt(StrclUsr));
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "fnLimpiaExtra()")%>

        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='<%=5003%>'>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleProveedorVet.jsp?"%>'>
        <%
            if (rs.next()) {

                StrNomOpe = rs.getString("NombreOpe");
                session.setAttribute("NombreOpe", StrNomOpe);
        %>
        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%= rs.getString("clProveedor")%>'>
        <INPUT id='clAreaOperativa' name='clAreaOperativa' type='hidden' value='11'>

        <%=MyUtil.ObjInput("Nombre", "NombreRZ", rs.getString("NombreRZ"), true, true, 25, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Nombre En Operación", "NombreOpe", rs.getString("NombreOpe"), true, true, 380, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Titular", "Titular", rs.getString("Titular"), true, true, 25, 120, "", true, true, 50)%>
        <%=MyUtil.ObjComboC("Rubro", "clGiro", rs.getString("dsGiro"), true, true, 380, 120, "", "Select clGiro, dsGiro from cGiro where clAreaOperativa=11 order by dsGiro", "", "", 20, false, false)%>
        <%=MyUtil.ObjChkBox("", "Activo", rs.getString("Activo"), true, true, 630, 120, "", "ACTIVO", "INACTIVO", "")%>
        <%=MyUtil.ObjInput("Cuit", "RFC", rs.getString("RFC"), true, true, 25, 160, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.CuitMsk.value,this.name)}")%>
        <%=MyUtil.ObjComboC("Tipo de Proveedor", "clTipoProveedor", rs.getString("dsTipoProveedor"), true, true, 380, 160, "", "Select clTipoProveedor, dsTipoProveedor from cTipoProveedor where clAreaOperativa = 11 order by dsTipoProveedor", "", "", 20, false, false)%>
        <%=MyUtil.ObjInput("Prioridad", "Prioridad", rs.getString("Prioridad"), false, false, 150, 160, "1", false, false, 5)%>
        <%=MyUtil.ObjInput("CURP", "CURP", rs.getString("CURP"), true, true, 230, 160, "", false, false, 20)%>
        <%=MyUtil.ObjComboC("Especialidad", "clEspecialidad", rs.getString("dsEspecialidad"), true, true, 25, 200, "", "Select clEspecialidad, dsEspecialidad From cEspecialidadVet order by dsEspecialidad", "", "", 40, true, true)%>
        <!--%=MyUtil.ObjComboC("SubEspecialidad", "clSubEspecialidad", rs.getString("dsSubEspecialidad"), true, true, 380, 200, "", "Select clSubEspecialidad,dsSubEspecialidad from cSubEspecialidadVet where clEspecialidad='" + rs.getString("clEspecialidad") + "' order by dsSubEspecialidad", "", "", 40, false, false)%-->
        <%=MyUtil.DoBlock("Detalle de Proveedor Veterinario")%>

        <%
            CodEnt = rs.getString("CodEnt");
            dsEntFed = rs.getString("dsEntFed");
            dsMunDel = rs.getString("dsMunDel");
            StrCodMD = rs.getString("CodMD");
        %>

        <%=MyUtil.ObjComboMem("Provincia", "CodEnt", dsEntFed, CodEnt, cbEntidad.GeneraHTML(20, dsEntFed), true, true, 30, 280, "", "fnLlenaMunicipios()", "", 35, true, true)%>
        <%=MyUtil.ObjComboMem("Localidad", "CodMD", dsMunDel, StrCodMD, cbEntidad.GeneraHTMLMD(30, CodEnt, dsMunDel), true, true, 410, 280, "", "", "", 35, true, true)%>
        <%=MyUtil.ObjInput("Código Postal", "CP", rs.getString("CP"), true, true, 30, 320, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Calle", "Calle", rs.getString("Calle"), true, true, 160, 320, "", false, false, 80)%>
        <%=MyUtil.DoBlock("Ubicación del Proveedor", 140, 0)%>

        <%=MyUtil.ObjComboC("Banco", "clBanco", rs.getString("dsBanco"), true, true, 25, 400, "", "Select clBanco, Nombre from cBanco where Activo = 1 order by Nombre", "", "", 45, false, false)%>
        <%=MyUtil.ObjInput("Núm. Sucursal", "SucursalBan", rs.getString("SucursalBan"), true, true, 350, 400, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Tipo Cuenta", "CuentaBan", rs.getString("CuentaBan"), true, true, 483, 400, "", false, false, 20)%>
        <%=MyUtil.ObjChkBox("Cheque", "Cheque", rs.getString("Cheque"), true, true, 600, 400, "", "SI", "NO", "")%>
        
        <!--%=MyUtil.ObjInput("Plaza", "PlazaBan", rs.getString("PlazaBan"), true, true, 25, 440, "", false, false, 5)%-->      
        <%=MyUtil.ObjInput("A Nombre De", "ANombreDe", rs.getString("ANombreDe"), true, true, 25, 440, "", false, false, 50)%>
        <%=MyUtil.ObjInput("C.B.U.", "Clabe", rs.getString("Clabe"), true, true, 380, 440, "", false, false, 30, "if(this.readOnly==false){fnValMask(this,document.all.CubMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Cuit Asociado", "CuitA", rs.getString("CuitA"), true, true, 640, 440, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.CuitMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Email 1", "Email1", rs.getString("Email1"), true, true, 25, 480, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Email 2", "Email2", rs.getString("Email2"), true, true, 250, 480, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Email 3", "Email3", rs.getString("Email3"), true, true, 475, 480, "", false, false, 40)%>
        <%=MyUtil.DoBlock("Banco del Proveedor", 50, 0)%>

        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", rs.getString("Observaciones"), "100", "7", true, true, 30, 560, "", false, false)%>
        <%=MyUtil.DoBlock("Observaciones Extras", 400, 70)%>

        <%=MyUtil.ObjChkBox("Título", "Titulo", rs.getString("Titulo"), true, true, 30, 710, "0", "")%>
        <%=MyUtil.ObjChkBox("Cédula", "Cedula", rs.getString("Cedula"), true, true, 30, 740, "0", "")%>
        <%=MyUtil.ObjChkBox("Recertificación", "Recertificacion", rs.getString("Recertificacion"), true, true, 30, 770, "0", "")%>
        <%=MyUtil.ObjChkBox("Especialidad ", "Especialidad", rs.getString("Especialidad"), true, true, 30, 800, "0", "")%>
        <%=MyUtil.ObjChkBox("Diploma de Especialidad", "DiplomaEsp", rs.getString("DiplomaEsp"), true, true, 30, 830, "0", "")%>
        <%=MyUtil.ObjChkBox("Adiestramiento", "Adiestramiento", rs.getString("Adiestramiento"), true, true, 30, 860, "0", "")%>
        <%=MyUtil.ObjChkBox("Cédula de Especialidad", "CedulaEsp", rs.getString("CedulaEsp"), true, true, 30, 890, "0", "")%>
        <%=MyUtil.ObjChkBox("Certificado", "Certificado", rs.getString("Certificado"), true, true, 30, 920, "0", "")%>
        <%=MyUtil.DoBlock("Requisitos de Aprobación", 300, 0)%>

        <%
        } else {
            StrNomOpe = "";
            session.setAttribute("NombreOpe", StrNomOpe);
        %>
        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='0'>
        <INPUT id='clAreaOperativa' name='clAreaOperativa' type='hidden' value='11'>

        <%=MyUtil.ObjInput("Nombre", "NombreRZ", "", true, true, 25, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Nombre En Operación", "NombreOpe", "", true, true, 380, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Titular", "Titular", "", true, true, 25, 120, "", true, true, 50)%>
        <%=MyUtil.ObjComboC("Rubro", "clGiro", "", true, true, 380, 120, "", "Select * from cGiro where clAreaOperativa=11 order by dsGiro", "", "", 20, false, false)%>
        <%=MyUtil.ObjChkBox("", "Activo", "", true, true, 600, 120, "", "ACTIVO", "INACTIVO", "")%>
        <%=MyUtil.ObjInput("Cuit", "RFC", "", true, true, 25, 160, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.CuitMsk.value,this.name)}")%>
        <%=MyUtil.ObjComboC("Tipo de Proveedor", "clTipoProveedor", "", true, true, 380, 160, "", "Select clTipoProveedor, dsTipoProveedor from cTipoProveedor where clAreaOperativa = 11 order by dsTipoProveedor", "", "", 20, true, true)%>
        <%=MyUtil.ObjInput("Prioridad", "Prioridad", "1", false, false, 150, 160, "1", false, false, 5)%>
        <%=MyUtil.ObjInput("CURP", "CURP", "", true, true, 230, 160, "", false, false, 20)%>
        <%=MyUtil.ObjComboC("Especialidad", "clEspecialidad", "", true, true, 25, 200, "", "Select clEspecialidad, dsEspecialidad From cEspecialidadVet order by dsEspecialidad", "", "", 40, true, true)%>
        <!--%=MyUtil.ObjComboC("SubEspecialidad", "clSubEspecialidad", "", true, true, 380, 200, "", "sp_LlenaComboSubEspecialidadVet ", "", "", 40, false, false)%-->
        <%=MyUtil.DoBlock("Detalle de Proveedor Veterinario")%>

        <%=MyUtil.ObjComboMem("Provincia", "CodEnt", "", "", cbEntidad.GeneraHTML(20, ""), true, true, 25, 280, "", "fnLlenaMunicipios()", "", 35, true, true)%>
        <%=MyUtil.ObjComboMem("Localidad", "CodMD", "", "", cbEntidad.GeneraHTMLMD(30, "", ""), true, true, 380, 280, "", "", "", 35, true, true)%>
        <%=MyUtil.ObjInput("Código Postal", "CP", "", true, true, 25, 320, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Calle", "Calle", "", true, true, 380, 320, "", false, false, 50)%>
        <%=MyUtil.DoBlock("Ubicación del Proveedor", 220, 0)%>

        <%=MyUtil.ObjComboC("Banco", "clBanco", "", true, true, 25, 400, "", "Select * from cBanco where Activo=1 order by Nombre", "", "", 45, false, false)%>
        <%=MyUtil.ObjInput("Núm. Sucursal", "SucursalBan", "", true, true, 450, 400, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Tipo Cuenta", "CuentaBan", "", true, true, 483, 400, "", false, false, 20)%>
        <%=MyUtil.ObjChkBox("", "Cheque", "", true, true, 600, 400, "", "CHEQUE ACTIVO", "CHEQUE INACTIVO", "")%>
        
        <!--%=MyUtil.ObjInput("Plaza", "PlazaBan", "", true, true, 25, 440, "", false, false, 5)%-->             
        <%=MyUtil.ObjInput("A Nombre De", "ANombreDe", "", true, true, 25, 440, "", false, false, 50)%>
        <%=MyUtil.ObjInput("C.U.B.", "Clabe", "", true, true, 380, 440, "", false, false, 30, "if(this.readOnly==false){fnValMask(this,document.all.CubMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("CUIT Asociado", "CuitA", "", true, true, 640, 440, "", false, false, 30, "if(this.readOnly==false){fnValMask(this,document.all.CuitMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Email 1", "Email1", "", true, true, 25, 480, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Email 2", "Email2", "", true, true, 250, 480, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Email 3", "Email3", "", true, true, 475, 480, "", false, false, 40)%>
        <%=MyUtil.DoBlock("Banco del Proveedor", 50, 0)%>

        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", "", "100", "7", true, true, 30, 530, "", false, false)%>
        <%=MyUtil.DoBlock("Observaciones Extras", 400, 70)%>

        <%=MyUtil.ObjChkBox("Título", "Titulo", "", true, true, 30, 680, "0", "")%>
        <%=MyUtil.ObjChkBox("Cédula", "Cédula", "", true, true, 30, 710, "0", "")%>
        <%=MyUtil.ObjChkBox("Recertificacion", "Recertificacion", "", true, true, 30, 740, "0", "")%>
        <%=MyUtil.ObjChkBox("Especialidad ", "Especialidad", "", true, true, 30, 770, "0", "")%>
        <%=MyUtil.ObjChkBox("Diploma de Especialidad", "DiplomaEsp", "", true, true, 30, 800, "0", "")%>
        <%=MyUtil.ObjChkBox("Adiestramiento", "Adiestramiento", "", true, true, 30, 830, "0", "")%>
        <%=MyUtil.ObjChkBox("Cédula de Especialidad", "CedulaEsp", "", true, true, 30, 860, "0", "")%>
        <%=MyUtil.ObjChkBox("Certificado", "Certificado", "", true, true, 30, 890, "0", "")%>
        <%=MyUtil.DoBlock("Requisitos de Aprobación", 300, 0)%>

        <%
            }
        %>
        <input name='CuitMsk' id='CuitMsk' type='hidden' value='VN09VN09F---VN09VN09VN09VN09VN09VN09VN09VN09F/--VN09'>
        <input name='CubMsk' id='CubMsk' type='hidden' value='VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09'>
        <!--input name='CuitAMsk' id='CuitAMsk' type='hidden' value='VN09VN09F---VN09VN09VN09VN09VN09VN09VN09VN09F/--VN09'-->
        <%
            StrclUsr = null;
            StrclProveedor = null;
            StrNomOpe = null;
            CodEnt = null;
            dsEntFed = null;
            dsMunDel = null;
            StrCodMD = null;
            StrclPaginaWeb = null;

            rs.close();
            rs = null;
        %>
        <%=MyUtil.GeneraScripts()%>

        <script>
            /*function fnLlenaComboSubEspecialidad(){
             var strConsulta = "sp_LlenaComboSubEspecialidadVet '" + document.all.clEspecialidad.value + "'";
             var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
             //      alert(pstrCadena);
             document.all.clSubEspecialidad.value = '';
             pstrCadena = pstrCadena + "&strName=clSubEspecialidadC";
             fnOptionxDefault('clSubEspecialidadC',pstrCadena);
             }*/
        </script>
    </body>
</html>