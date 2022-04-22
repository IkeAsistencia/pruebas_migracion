<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Combos.cbEntidad" errorPage="" %>
<html>
    <head>
        <title>Detalle Proveedor Ambulancia</title>
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
            String StrclPaginaWeb = "245";

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

            //ResultSet rs = UtileriasBDF.rsSQLNP( "sp_DetalleProveedor " + StrclProveedor + "," + strclUsr);
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <script>fnOpenLinks()</script>
        <%
            MyUtil.InicializaParametrosC(245, Integer.parseInt(StrclUsr));
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "fnLimpiaExtra()")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleProveedorAmb.jsp?"%>'>
        <%
            if (rs.next()) {

                StrNomOpe = rs.getString("NombreOpe");
                session.setAttribute("NombreOpe", StrNomOpe);
        %>
        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=rs.getString("clProveedor")%>'>
        <INPUT id='clAreaOperativa' name='clAreaOperativa' type='hidden' value='5'>

        <%=MyUtil.ObjInput("Nombre", "NombreRZ", rs.getString("NombreRZ"), true, true, 25, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Nombre en Operacion", "NombreOpe", rs.getString("NombreOpe"), true, true, 310, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Titular", "Titular", rs.getString("Titular"), true, true, 25, 120, "", true, true, 50)%>
        <%=MyUtil.ObjComboC("Rubro", "clGiro", rs.getString("dsGiro"), true, true, 310, 120, "", "Select clGiro, dsGiro from cGiro where clAreaOperativa = 5 order by dsGiro", "", "", 30, true, true)%>
        <%=MyUtil.ObjChkBox("", "Activo", rs.getString("Activo"), true, true, 310, 200, "", "ACTIVO", "INACTIVO", "")%>
        <%=MyUtil.ObjInput("CUIT", "RFC", rs.getString("RFC"), true, true, 25, 160, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.CuitMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Nextel", "NumNextel", rs.getString("NumNextel"), true, true, 175, 160, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Horario", "Horario", rs.getString("Horario"), true, true, 310, 160, "", false, false, 50)%>
        <%=MyUtil.ObjComboC("Tipo de Proveedor", "clTipoProveedor", rs.getString("dsTipoProveedor"), true, true, 25, 200, "", "Select clTipoProveedor, dsTipoProveedor from cTipoProveedor where clAreaOperativa = 5 order by dsTipoProveedor", "", "", 20, true, true)%>
        <%=MyUtil.ObjInput("Prioridad", "Prioridad", rs.getString("Prioridad"), true, true, 200, 200, "", true, true, 5)%>
        <%=MyUtil.DoBlock("Detalle de Proveedor de Ambulancia", 160, 0)%>
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
        <%=MyUtil.ObjInput("Codigo Postal", "CP", rs.getString("CP"), true, true, 310, yPos, "", false, false, 10)%>
        <%=MyUtil.DoBlock("Ubicación del Proveedor", 130, 0)%>
        <%yPos += 90;%>

        <%=MyUtil.ObjComboC("Banco", "clBanco", rs.getString("dsBanco"), true, true, 25, yPos, "", "Select clBanco, Nombre from cBanco where Activo = 1 order by Nombre", "", "", 50, false, false)%>
        <%=MyUtil.ObjInput("Num. Sucursal", "SucursalBan", rs.getString("SucursalBan"), true, true, 350, yPos, "", false, false, 15)%>
        <%=MyUtil.ObjInput("Tipo de Cuenta", "TipoCuentaBan", rs.getString("TipoCuentaBan"), true, true, 460, yPos, "", false, false, 20)%>
        <%=MyUtil.ObjChkBox("Cheque", "Cheque", rs.getString("Cheque"), true, true, 600, yPos, "", "SI", "NO", "")%>
        <%yPos += 50;%>
        <!--%=MyUtil.ObjInput("Plaza", "PlazaBan", rs.getString("PlazaBan"), true, true, 25, yPos, "", false, false, 5)%-->
        <%=MyUtil.ObjInput("A Nombre De", "ANombreDe", rs.getString("ANombreDe"), true, true, 25, yPos, "", false, false, 48)%>
        <%=MyUtil.ObjInput("Num. de Cuenta", "CuentaBan", rs.getString("CuentaBan"), true, true, 325, yPos, "", false, false, 20)%>
        <%=MyUtil.ObjInput("C.B.U.", "Clabe", rs.getString("Clabe"), true, true, 460, yPos, "", false, false, 30, "if(this.readOnly==false){fnValMask(this,document.all.CubMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("CUIT Asociado", "CuitA", rs.getString("CuitA"), true, true, 640, yPos, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.CuitMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Email 1", "Email1", rs.getString("Email1"), true, true, 25, 495, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Email 2", "Email2", rs.getString("Email2"), true, true, 250, 495, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Email 3", "Email3", rs.getString("Email3"), true, true, 475, 495, "", false, false, 40)%>
        <%=MyUtil.DoBlock("Banco del Proveedor", 0, 0)%>
        <%yPos += 135;%>

        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", rs.getString("Observaciones"), "100", "7", true, true, 30, yPos, "", false, false)%>
        <%=MyUtil.DoBlock("Observaciones Extras", 400, 70)%>
        <%
        } else {
            StrNomOpe = "";
            session.setAttribute("NombreOpe", StrNomOpe);
        %>
        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='0'>
        <INPUT id='clAreaOperativa' name='clAreaOperativa' type='hidden' value='5'>

        <%=MyUtil.ObjInput("Nombre", "NombreRZ", "", true, true, 25, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Nombre en Operacion", "NombreOpe", "", true, true, 310, 80, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Titular", "Titular", "", true, true, 25, 120, "", true, true, 50)%>
        <%=MyUtil.ObjComboC("Rubro", "clGiro", "", true, true, 310, 120, "", "Select clGiro, dsGiro from cGiro where clAreaOperativa = 5 order by dsGiro", "", "", 30, true, true)%>
        <%=MyUtil.ObjChkBox("", "Activo", "", true, true, 310, 200, "", "ACTIVO", "INACTIVO", "")%>
        <%=MyUtil.ObjInput("CUIT", "RFC", "", true, true, 25, 160, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.CuitMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Nextel", "NumNextel", "", true, true, 175, 160, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Horario", "Horario", "", true, true, 310, 160, "", false, false, 50)%>
        <%=MyUtil.ObjComboC("Tipo de Proveedor", "clTipoProveedor", "", true, true, 25, 200, "", "Select clTipoProveedor, dsTipoProveedor from cTipoProveedor where clAreaOperativa = 5 order by dsTipoProveedor", "", "", 20, true, true)%>
        <%=MyUtil.ObjInput("Prioridad", "Prioridad", "", true, true, 200, 200, "", true, true, 5)%>
        <%=MyUtil.DoBlock("Detalle de Proveedor de Ambulancia", 160, 0)%>
        <%yPos += 320;%>

        <%=MyUtil.ObjComboMem("Provincia", "CodEnt", "", "", cbEntidad.GeneraHTML(20, ""), true, true, 25, 280, "", "fnLlenaMunicipios()", "", 20, true, true)%>
        <%=MyUtil.ObjComboMem("Localidad", "CodMD", "", "", cbEntidad.GeneraHTMLMD(30, "", ""), true, true, 310, 280, "", "", "", 20, true, true)%>
        <%=MyUtil.ObjInput("Calle", "Calle", "", true, true, 25, yPos, "", false, false, 50)%>
        <%=MyUtil.ObjInput("Código Postal", "CP", "", true, true, 315, yPos, "", false, false, 10)%>
        <%=MyUtil.DoBlock("Ubicación del Proveedor", 130, 0)%>
        <%yPos += 90;%>

        <%=MyUtil.ObjComboC("Banco", "clBanco", "", true, true, 25, yPos, "", "Select clBanco, Nombre from cBanco where Activo=1 order by Nombre", "", "", 50, false, false)%>
        <%=MyUtil.ObjInput("Num. Sucursal", "SucursalBan", "", true, true, 350, yPos, "", false, false, 15)%>
        <%=MyUtil.ObjInput("Tipo de Cuenta", "TipoCuentaBan", "", true, true, 460, yPos, "", false, false, 20)%>
        <%=MyUtil.ObjChkBox("", "Cheque", "", true, true, 600, yPos, "", "CHEQUE ACTIVO", "CHEQUE INACTIVO", "")%>
        <%yPos += 50;%>
        <!--%=MyUtil.ObjInput("Plaza", "PlazaBan", "", true, true, 25, yPos, "", false, false, 5)%-->
        <%=MyUtil.ObjInput("A Nombre De", "ANombreDe", "", true, true, 25, yPos, "", false, false, 48)%>
        <%=MyUtil.ObjInput("Num. de Cuenta", "CuentaBan", "", true, true, 325, yPos, "", false, false, 20)%>
        <%=MyUtil.ObjInput("C.U.B.", "Clabe", "", true, true, 460, yPos, "", false, false, 30, "if(this.readOnly==false){fnValMask(this,document.all.CubMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("CUIT Asociado", "CuitA", "", true, true, 640, yPos, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.CuitMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Email 1", "Email1", "", true, true, 25, 495, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Email 2", "Email2", "", true, true, 250, 495, "", false, false, 40)%>
        <%=MyUtil.ObjInput("Email 3", "Email3", "", true, true, 475, 495, "", false, false, 40)%>
        <%=MyUtil.DoBlock("Banco del Proveedor", 0, 0)%>
        <%yPos += 135;%>

        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", "", "100", "7", true, true, 30, yPos, "", false, false)%>
        <%=MyUtil.DoBlock("Observaciones Extras", 400, 70)%>
        <%
            }
        %>
        <input name='CuitMsk' id='CuitMsk' type='hidden' value='VN09VN09F---VN09VN09VN09VN09VN09VN09VN09VN09F/--VN09'>
        <input name='CubMsk' id='CubMsk' type='hidden' value='VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09VN09'>
        <!--input name='CuitAMsk' id='CuitAMsk' type='hidden' value='VN09VN09F---VN09VN09VN09VN09VN09VN09VN09VN09F/--VN09'-->
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
        <%=MyUtil.GeneraScripts()%>
    </body>
</html>