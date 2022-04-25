<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.asistencias.DAOSucursalReddeDescuentos,com.ike.asistencias.to.SucursalReddeDescuentos;" %>

<html>
    <head>
        <title>Sucursal Red de Descuentos</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilDireccion.js' ></script>
        <script src='../Utilerias/UtilStore.js'></script>

        <%
        String strclUsr = "0";
        String strclSucursalReddeDescuentos = "0";
        String strclReddeDescuentos = "0";
        String StrCodEnt = "";
        String StrclPaginaWeb = "0";
        String strNombreRed = "";

        if (session.getAttribute("clUsrApp") != null) {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }

        if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true) {
        %>Fuera de Horario<%
            strclUsr = null;
            strclSucursalReddeDescuentos = null;
            strclReddeDescuentos = null;
            StrCodEnt = null;
            StrclPaginaWeb = null;
            strNombreRed = null;

            return;
        }

        if (request.getParameter("clSucursalReddeDescuentos") != null) {
            strclSucursalReddeDescuentos = request.getParameter("clSucursalReddeDescuentos").toString();
        }

        strclReddeDescuentos = session.getAttribute("clReddeDescuentos").toString();

        DAOSucursalReddeDescuentos daoSucursalReddeDescuentos = null;
        SucursalReddeDescuentos SuRe = null;

        //SERVLET GENERICO
        String Store = "";
        String Commit = "";

        Store = "st_GuardaSucursalReddeDescuentos, st_ActualizaSucursalReddeDescuentos";
        session.setAttribute("sp_Stores", Store);

        Commit = "clSucursalReddeDescuentos";
        session.setAttribute("Commit", Commit);
        // TERMINA SERVLET GENERICO

        daoSucursalReddeDescuentos = new DAOSucursalReddeDescuentos();
        SuRe = daoSucursalReddeDescuentos.getSucursalReddeDescuentos(strclSucursalReddeDescuentos.toString());

        if (SuRe != null) {
            StrCodEnt = SuRe.getCodEnt();
        }

        if (strclReddeDescuentos != null) {
            ResultSet rs = UtileriasBDF.rsSQLNP("select NombreComercial from ReddeDescuentos where clReddeDescuentos = " + strclReddeDescuentos);
            while (rs.next()) {
                strNombreRed = rs.getString("NombreComercial");
            }
            rs.close();
            rs = null;
        }

        StrclPaginaWeb = "5024";
        session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %><script>fnOpenLinks()</script><%

        MyUtil.InicializaParametrosC(5024, Integer.parseInt(strclUsr));%>
        <%=MyUtil.doMenuAct("../servlet/com.ike.guarda.EjecutaSP", "", "fnsp_Guarda();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="SucursalReddeDescuentos.jsp?"%>'>
        <INPUT id="Secuencia" name="Secuencia" type="hidden" value="">
        <INPUT id="SecuenciaG" name="SecuenciaG" type="hidden" value="clReddeDescuentos,Contacto,Sucursal,CodEnt,CodMD,Calle,CodigoPostal,Telefono1,Telefono2">
        <INPUT id="SecuenciaA" name="SecuenciaA" type="hidden" value="clSucursalReddeDescuentos,Contacto,Sucursal,CodEnt,CodMD,Calle,CodigoPostal,Telefono1,Telefono2">
        <INPUT id="clReddeDescuentos" name="clReddeDescuentos" type="hidden" value="<%=strclReddeDescuentos%>">
        <INPUT id="clSucursalReddeDescuentos" name="clSucursalReddeDescuentos" type="hidden" value="<%=strclSucursalReddeDescuentos%>">

        <%=MyUtil.ObjInput("Nombre Comercial", "NombreComercial", strNombreRed, false, false, 40, 80, strNombreRed, false, false, 70, "")%>
        <%=MyUtil.ObjInput("Nombre del Contacto", "Contacto", SuRe != null ? SuRe.getContacto() : "", true, true, 40, 120, "", true, true, 70, "")%>
        <%=MyUtil.ObjInput("Nombre de la Sucursal", "Sucursal", SuRe != null ? SuRe.getSucursal() : "", true, true, 40, 160, "", true, true, 70, "")%>
        <%=MyUtil.ObjComboC("Provincia", "CodEnt", SuRe != null ? SuRe.getDsEntFed() : "", true, true, 40, 200, "", "select codent,dsentfed from cEntFed order by dsEntFed", "fnLlenaMunicipios();", "", 35, true, true)%>
        <%=MyUtil.ObjComboC("Localidad", "CodMD", SuRe != null ? SuRe.getDsMunDel() : "", true, true, 40, 240, "", "Select CodMD, dsMunDel from cMunDel where CodEnt='" + StrCodEnt + "' order by dsMunDel", "", "", 30, true, true)%>
        <%=MyUtil.ObjInput("Calle", "Calle", SuRe != null ? SuRe.getCalle() : "", true, true, 40, 280, "", true, true, 70, "")%>
        <%=MyUtil.ObjInput("Código Postal", "CodigoPostal", SuRe != null ? SuRe.getCodigoPostal() : "", true, true, 40, 320, "", true, true, 10, "")%>
        <%=MyUtil.ObjInput("Teléfono 1", "Telefono1", SuRe != null ? SuRe.getTelefono1() : "", true, true, 40, 360, "", true, true, 25, "")%>
        <%=MyUtil.ObjInput("Teléfono 2", "Telefono2", SuRe != null ? SuRe.getTelefono2() : "", true, true, 220, 360, "", false, false, 25, "")%>
        <%=MyUtil.DoBlock("Sucursal Red de Descuentos", 20, 0)%>

        <%=MyUtil.GeneraScripts()%>

        <%
        strclUsr = null;
        strclSucursalReddeDescuentos = null;
        strclReddeDescuentos = null;
        StrCodEnt = null;
        StrclPaginaWeb = null;
        strNombreRed = null;
        Store = null;
        Commit = null;

        daoSucursalReddeDescuentos = null;
        SuRe = null;
        %>

    </body>
</html>
