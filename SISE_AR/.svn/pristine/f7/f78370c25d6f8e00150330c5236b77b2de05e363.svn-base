<%@ page import="com.ike.model.DAOTieneAsistencia,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.asistencias.DAOSeguimientoProveedor,com.ike.asistencias.to.SeguimientoProveedor,Combos.cbEntidad,java.sql.ResultSet;" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<html>
    <head>
        <title>Detalle Seguimiento del Proveedor Veterinario</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilServicio.js' ></script>

        <!--script>document.all.btnCambio.disabled = true;</script-->
        <%
            String StrclUsr = "0";
            String StrclSeguimientoProveedor = "0";
            String StrclProveedor = "0";
            String StrNomOpe = "";
            String Strfecha = "";
            String StrclPaginaWeb = "5016";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsr = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsr)) != true) {
        %> Fuera de Horario <%
                StrclUsr = null;
                StrclSeguimientoProveedor = null;
                StrclProveedor = null;
                StrNomOpe = null;
                Strfecha = null;
                return;
            }

            if (request.getParameter("clSeguimientoProveedor") != null) {
                StrclSeguimientoProveedor = request.getParameter("clSeguimientoProveedor");
            }

            session.setAttribute("clSeguimientoProveedor", StrclSeguimientoProveedor);

            if (session.getAttribute("clProveedor") != null) {
                StrclProveedor = session.getAttribute("clProveedor").toString();
            }

            if (session.getAttribute("NombreOpe") != null) {
                StrNomOpe = session.getAttribute("NombreOpe").toString();
            }

            DAOSeguimientoProveedor daoSeguimientoProveedor = null;
            SeguimientoProveedor SP = null;

            daoSeguimientoProveedor = new DAOSeguimientoProveedor();
            SP = daoSeguimientoProveedor.getSeguimientoProveedor(StrclSeguimientoProveedor.toString());

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <script>fnOpenLinks()</script>

        <%MyUtil.InicializaParametrosC(5016, Integer.parseInt(StrclUsr));
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%>
        <%
            int iY = 40;
        %>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="SeguimientoProveedorVet.jsp?"%>'>
        <INPUT id='clSeguimientoProveedor' name='clSeguimientoProveedor' type='hidden' value='<%=StrclSeguimientoProveedor%>'>
        <INPUT id='clProveedor' name='clProveedor' type = "hidden" value='<%=StrclProveedor%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type="hidden" value='<%=StrclUsr%>'>

        <%=MyUtil.ObjInput("Nombre Operativo", "NombreOpe", StrNomOpe, false, false, 30, 80, StrNomOpe, false, false, 70, "")%>
        <%=MyUtil.ObjInput("Fecha de Alta <br> (AAAA-MM-DD-HH:MM)<br>Automática", "fechaVR", SP != null ? SP.getFecha() : "", false, false, 440, 80, Strfecha, false, false, 20, "")%>
        <%=MyUtil.ObjComboC("Medios de Contacto", "clMediosContacto", SP != null ? SP.getDsMediosContacto() : "", true, false, 30, 125, "", "Select clMediosContacto, dsMediosContacto from cMediosContacto", "", "", 50, true, false)%>
        <%=MyUtil.ObjComboC("Clasificacion", "clClasificacionSeguimiento", SP != null ? SP.getDsClasificacionSeguimiento() : "", true, false, 210, 125, "", "Select clClasificacionSeguimiento,dsClasificacionSeguimiento from cClasificacionSeguimiento", "", "", 50, true, false)%>
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", SP != null ? SP.getObservaciones() : "", "105", "5", true, true, 30, 180, "", true, false)%>
        <%=MyUtil.DoBlock("Seguimiento Proveedor", 20, 50)%>
        <%=MyUtil.GeneraScripts()%>

        <%
            daoSeguimientoProveedor = null;
            SP = null;

            StrclUsr = null;
            StrclSeguimientoProveedor = null;
            StrclProveedor = null;
            StrNomOpe = null;
            Strfecha = null;
            StrclPaginaWeb = null;
        %>
    </body>
</html>
