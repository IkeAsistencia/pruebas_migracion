<%@ page contentType="text/html; charset=iso-8859-1" language="java"%>
<%@ page import="com.ike.catalogos.DAOCostoxProveedor,com.ike.catalogos.to.CostoxProveedor,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC;"%>
<html>
    <head>
        <title>Costo x Subservicio x Proveedor</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" >
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../Utilerias/Util.js' ></script>
        <script type="text/javascript" src='../Utilerias/UtilServicio.js' ></script>
        <script type="text/javascript" src='../Utilerias/UtilCostos.js' ></script>
        <%
            String StrclProveedor = "";
            String StrclCostoxProvxSubserv = "";
            String StrclUsrApp = "";
            String StrNomOpe = "";
            String StrclServicio = "";
            String StrclAreaOperativa = "";
            String StrFechaActual = "";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clProveedor") != null) {
                StrclProveedor = session.getAttribute("clProveedor").toString();
            }

            if (request.getParameter("clCostoXProvXSubserv") != null) {
                StrclCostoxProvxSubserv = request.getParameter("clCostoXProvXSubserv").toString();
            }

            if (session.getAttribute("NombreOpe") != null) {
                StrNomOpe = session.getAttribute("NombreOpe").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %>Fuera de Horario <%
                StrclProveedor = null;
                StrclCostoxProvxSubserv = null;
                StrclUsrApp = null;
                StrNomOpe = null;
                StrclServicio = null;
                StrFechaActual = null;
                return;
            }

            StringBuffer StrSql = new StringBuffer();

            DAOCostoxProveedor daoCP = null;
            CostoxProveedor CP = null;

            StrSql.append(" st_getAreaServicioxProv '").append(StrclProveedor).append("'");
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs.next()) {
                //  StrclAreaOperativa = rs.getString("clAreaOperativa");
                //  StrclServicio = rs.getString("clServicio");
                StrclAreaOperativa = rs.getString("clAreaOperativa");
                StrclServicio = "1";
                StrFechaActual = rs.getString("FechaActual");
            }

            if (!StrclCostoxProvxSubserv.equalsIgnoreCase("")) {
                daoCP = new DAOCostoxProveedor();
                CP = daoCP.getCostoxProveedor(StrclCostoxProvxSubserv);
            }

            String StrclPaginaWeb = "249";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <script type="text/javascript">fnOpenLinks()</script>
        <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleCostoxSubxProv.jsp?"%>'>
        <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
        <INPUT id='clCostoXProvXSubserv' name='clCostoXProvXSubserv' type='hidden' value='<%=StrclCostoxProvxSubserv%>'>
        <INPUT id='FechaActualiza' name='FechaActualiza' type='hidden' value='<%=StrFechaActual%>'>

        <%=MyUtil.ObjInput("Nombre Operativo", "NombreOpe", CP != null ? CP.getNombreOpe() : "", false, false, 30, 80, StrNomOpe, false, false, 70)%>
        <%=MyUtil.ObjComboC("Servicio", "clServicio", CP != null ? CP.getDsServicio() : "", true, true, 30, 120, StrclServicio, "SELECT clServicio, dsServicio FROM cServicio where clServicio ='" + StrclServicio + "' ORDER BY dsServicio ", "fnLlenaSubServicios()", "", 50, true, true)%>
        <%=MyUtil.ObjComboC("Subservicio", "clSubServicio", CP != null ? CP.getDsSubservicio() : "", true, true, 250, 120, "", "SELECT clSubServicio, dsSubServicio FROM cSubServicio where clServicio ='" + StrclServicio + "' ORDER BY dsSubServicio ", "fnLlenaConceptos(" + StrclAreaOperativa + ")", "", 50, true, true)%>
        <%=MyUtil.ObjComboC("Concepto", "clConcepto", CP != null ? CP.getDsConcepto() : "", true, true, 30, 160, "", "SELECT clConcepto, dsConcepto FROM cConceptoCosto where clAreaOperativa = '" + StrclAreaOperativa + "' ORDER BY dsConcepto", "", "", 50, true, true)%>
        <%=MyUtil.ObjInput("<b>Costo Base</b>", "Costo", CP != null ? CP.getCosto() : "", true, true, 30, 200, "", true, true, 10)%>
        <%=MyUtil.ObjInput("Fecha Actualización", "FechaVTR", CP != null ? CP.getFechaActualiza() : "", false, false, 250, 200, "", false, false, 23)%>
        <%=MyUtil.DoBlock("Detalle de Costo x Subservicio por Proveedor", 0, 0)%>
        <%=MyUtil.GeneraScripts()%>
        <%
            StrclProveedor = null;
            StrclCostoxProvxSubserv = null;
            StrclUsrApp = null;
            StrNomOpe = null;
            StrclServicio = null;
            StrFechaActual = null;
            daoCP = null;
            CP = null;

            rs.close();
            rs = null;
        %>
    </body>
</html>
