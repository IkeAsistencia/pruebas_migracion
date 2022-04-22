<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>JSP Page</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head> 
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <%
            String StrclQuejaxSupervision = "0";
            String StrclPaginaWeb = "0";
            String StrclUsrApp = "0";
            String StrclSeguimientoQueja = "0";
            String StrFechaAct = "0";
            String StrEstatusQueja = "0";

            if (session.getAttribute("clQuejaxSupervision") != null) {
                StrclQuejaxSupervision = session.getAttribute("clQuejaxSupervision").toString();
            }
            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (request.getParameter("clSeguimientoQueja") != null) {
                StrclSeguimientoQueja = request.getParameter("clSeguimientoQueja").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {%>
        Fuera de Horario
        <% return;
            }

            ResultSet rsFecha = UtileriasBDF.rsSQLNP("Select convert(varchar(16),getdate(),120) FechaApertura ");
            if (rsFecha.next()) {
                StrFechaAct = rsFecha.getString("FechaApertura");
            }

            StringBuffer StrSql = new StringBuffer();

            StrSql.append(" Select SQ.clQuejaxSupervision, ");
            StrSql.append(" SQ.Comentarios,");
            StrSql.append(" convert(varchar(16),SQ.Fecha,120) as Fecha,");
            StrSql.append(" Us.Nombre");
            StrSql.append(" From SeguimientoQueja SQ");
            StrSql.append(" inner Join cUsrApp US on (SQ.clUsrApp=US.clUsrApp)");
            StrSql.append(" Where SQ.clSeguimientoQueja=").append(StrclSeguimientoQueja);

            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
        %> 
        <script>fnOpenLinks()</script>

        <%     StrclPaginaWeb = "468";
            //Se checan permisos de alta,baja,cambio,consulta de esta pagina
            MyUtil.InicializaParametrosC(468, Integer.parseInt(StrclUsrApp));
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);%> 

        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1) + "SeguimientoxQueja.jsp?"%>'>

        <%  if (rs.next()) {
        %>
        <script>document.all.btnCambio.disabled = true;
            document.all.btnAlta.disabled = true;</script>
        <INPUT id='clSeguimientoQueja' name='clSeguimientoQueja' type='hidden' value='<%=StrclSeguimientoQueja%>'>
        <INPUT id='clQuejaxSupervision' name='clQuejaxSupervision' type='hidden' value='<%=StrclQuejaxSupervision%>'>
        <%=MyUtil.ObjTextArea("Comentarios", "ComentariosVTR", rs.getString("Comentarios"), "80", "3", true, true, 30, 80, "", false, false)%>
        <%=MyUtil.ObjInput("Fecha<BR>AAAA/MM/DD HH:MM", "FechaVTR", rs.getString("Fecha"), true, true, 30, 150, "", true, true, 25, "")%>
        <%=MyUtil.ObjInput("Usuario", "clUsrAppVTR", rs.getString("Nombre"), false, false, 188, 162, "", false, false, 50, "")%>
        <%=MyUtil.DoBlock("Seguimiento por queja", 100, 25)%>
        <%
        } else {
            StrSql.append(" Select QS.clEstatusQueja,EQ.dsEstatusQueja from QuejasxSupervision QS");
            StrSql.append(" inner join cEstatusQueja EQ on (QS.clEstatusQueja=EQ.clEstatusQueja)");
            StrSql.append(" where QS.clQuejaxSupervision=").append(StrclQuejaxSupervision);

            ResultSet rsEstatus = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            if (rsEstatus.next()) {

                StrEstatusQueja = rsEstatus.getString("clEstatusQueja");
                if (StrEstatusQueja == null) {
                    StrEstatusQueja = "";
                }

                if (StrEstatusQueja.equalsIgnoreCase("1") || StrEstatusQueja.equalsIgnoreCase("2") || StrEstatusQueja.equalsIgnoreCase("3")) {%>
        <script>document.all.btnCambio.disabled = true;</script>

        <INPUT id='clSeguimientoQueja' name='clSeguimientoQueja' type='hidden' value='<%=StrclSeguimientoQueja%>'>
        <INPUT id='clQuejaxSupervision' name='clQuejaxSupervision' type='hidden' value='<%=StrclQuejaxSupervision%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrApp%>'>
        <INPUT id='Fecha' name='Fecha' type='hidden' value='<%=StrFechaAct%>'>
        <%=MyUtil.ObjTextArea("Comentarios", "Comentarios", "", "100", "4", true, true, 30, 80, "", true, true)%>
        <%=MyUtil.DoBlock("Seguimiento por queja", 350, 25)%>

        <% } else {%>
        <script>document.all.btnAlta.disabled = true;
            document.all.btnCambio.disabled = true;</script>
        <TABLE Border=1 Class='Rojo' align='center'>
            <tr><td>No puede ingresar seguimiento</td></tr>
            <tr><td>La queja se encuentra con estatus:</td></tr>
            <tr><td><%=rsEstatus.getString("dsEstatusQueja")%></td></tr></table>
            <%}
            } else {%>
        La Queja No tiene Estatus  
        <%}
            }%>
        <%=MyUtil.GeneraScripts()%>
    </body>
</html>