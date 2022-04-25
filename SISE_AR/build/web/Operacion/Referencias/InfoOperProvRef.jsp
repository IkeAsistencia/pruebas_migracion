<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title>Información Adicional Referencias</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <script src='Utilerias/Util.js'></script>
        <%
        String StrclProveedorRef = "0";
        String StrclSubServicio = "";

        if (request.getParameter("clProveedorRef") != null) {
            StrclProveedorRef = request.getParameter("clProveedorRef");
        }

        if (session.getAttribute("clSubservicioSession") != null) {
            StrclSubServicio = session.getAttribute("clSubservicioSession").toString();
        } else {
            if (request.getParameter("clSubservicioSession") != null) {
                StrclSubServicio = request.getParameter("clSubservicioSession");
            }
        }

        StringBuffer strSQL = new StringBuffer();

        /***************    SI HAY NUEVOS SUBSERVICIOS DE REFERENCIA, AGREGARLOS AQUI   *******************/
        //  REFERENCIAS VETERINARIAS    326 PROD, 318 CAPA
        if (StrclSubServicio.equalsIgnoreCase("326")) {
            strSQL.append(" select coalesce(Nombre,'') 'Nombre',");
            strSQL.append(" coalesce(Direccion,'') 'Direccion',");
            strSQL.append(" coalesce(Telefono,'') 'Telefono',");
            strSQL.append(" coalesce(Observaciones,'') 'Observaciones'");
            strSQL.append(" from cRefVet where clRefVet = ").append(StrclProveedorRef);
            ResultSet rs = UtileriasBDF.rsSQLNP(strSQL.toString());
            strSQL.delete(0, strSQL.length());

            strSQL.append(" select PV.dsPrestacionVet from cPrestacionVet PV ");
            strSQL.append(" left join PrestacionxRefVet PxR on (PxR.clPrestacionVet=PV.clPrestacionVet) ");
            strSQL.append(" where PxR.clRefVet = ").append(StrclProveedorRef);
            strSQL.append(" order by (PV.dsPrestacionVet) ");

            ResultSet rs2 = UtileriasBDF.rsSQLNP(strSQL.toString());
            strSQL.delete(0, strSQL.length());

            if (rs.next()) {%>
        <center>
            <table border=1 class='FTable'>
                <tr><td class='cssTitDet' colspan="2" style="font-weight: bold;">Nombre</td></tr>
                <tr align="center"><td colspan="2" style="font-weight: bold;"><%=rs.getString("Nombre")%> </td></tr>
                <tr><td class='TTable'>Dirección: </td><td><%=rs.getString("Direccion")%></td></tr>
                <tr><td class='TTable'>Teléfono: </td><td><%=rs.getString("Telefono")%></td></tr>
                <tr><td class='cssTitDet' colspan="2" style="font-weight: bold;">Prestaciones</td></tr>
                <% while (rs2.next()) {%>
                <tr><td colspan="2"><%=rs2.getString("dsPrestacionVet")%> </td></tr>
                <%}%>
                <tr><td class='TTable'>Observaciones: </td><td><%=rs.getString("Observaciones")%></td></tr>
            </table>
            <br>
            <input class="cBtn" type="button" value="CERRAR" title="Cerrar" onclick="window.close();">
        </center>
        <%}%>
        <%}

        //  REFERENCIAS MECANICAS   325 PROD, 339 CAPA
        if (StrclSubServicio.equalsIgnoreCase("325")) {
            strSQL.append(" select coalesce(Marca,'') 'Marca', ");
            strSQL.append(" coalesce(RazonSocial,'') 'Nombre', ");
            strSQL.append(" coalesce(Direccion,'') 'Direccion', ");
            strSQL.append(" coalesce(EF.dsEntFed,'') 'Provincia',");
            strSQL.append(" coalesce(MD.dsMunDel,'') 'Localidad',");
            strSQL.append(" coalesce(Telefono,'') 'Telefono',");
            strSQL.append(" coalesce(Fax,'') 'Fax',");
            strSQL.append(" coalesce(Email,'') 'Email',");
            strSQL.append(" case ServicioExpress when 0 then 'NO'");
            strSQL.append(" when 1 then 'SI' end 'ServicioExpress',");
            strSQL.append(" coalesce(Direccion,'') 'Direccion',");
            strSQL.append(" coalesce(Ref.Observaciones,'') 'Observaciones'");            
            strSQL.append(" from cRefVial REF");
            strSQL.append(" left join cEntFed EF on (EF.CodEnt=REF.CodEnt)");
            strSQL.append(" left join cMunDel MD on (MD.CodMD=REF.CodMD)");
            strSQL.append(" where clRefVial = ").append(StrclProveedorRef);

            ResultSet rs = UtileriasBDF.rsSQLNP(strSQL.toString());
            strSQL.delete(0, strSQL.length());

            if (rs.next()) {%>
        <center>
            <table border=1 class='FTable'>
                <tr><td class='cssTitDet' colspan="2" style="font-weight: bold;">Nombre</td></tr>
                <tr align="center"><td colspan="2" style="font-weight: bold;"><%=rs.getString("Nombre")%> </td></tr>
                <tr><td class='TTable'>Dirección: </td><td><%=rs.getString("Direccion")%></td></tr>
                <tr><td class='TTable'>Provincia: </td><td><%=rs.getString("Provincia")%></td></tr>
                <tr><td class='TTable'>Localidad: </td><td><%=rs.getString("Localidad")%></td></tr>
                <tr><td class='TTable'>Teléfono: </td><td><%=rs.getString("Telefono")%></td></tr>
                <tr><td class='TTable'>Fax: </td><td><%=rs.getString("Fax")%></td></tr>
                <tr><td class='TTable'>Email: </td><td><%=rs.getString("Email")%></td></tr>
                <tr><td class='cssTitDet' colspan="2" style="font-weight: bold;">Prestaciones</td></tr>
                <tr><td class='TTable'>Marca: </td><td><%=rs.getString("Marca")%></td></tr>
                <tr><td class='TTable'>Servicio Express: </td><td><%=rs.getString("ServicioExpress")%></td></tr>
                <tr><td class='TTable'>Observaciones: </td><td><%=rs.getString("Observaciones")%></td></tr>
            </table>
            <br>
            <input class="cBtn" type="button" value="CERRAR" title="Cerrar" onclick="window.close();">
        </center>
        <%}%>
        <%}

        //  REFERENCIAS PC    328 PROD, 340 CAPA
        if (StrclSubServicio.equalsIgnoreCase("328")) {
            strSQL.append(" select coalesce(Nombre,'') 'Nombre', ");
            strSQL.append(" coalesce(Direccion,'') 'Direccion', ");
            strSQL.append(" coalesce(EF.dsEntFed,'') 'Provincia',");
            strSQL.append(" coalesce(MD.dsMunDel,'') 'Localidad',");
            strSQL.append(" coalesce(Telefono,'') 'Telefono',");
            strSQL.append(" coalesce(Observaciones,'') 'Observaciones'");
            strSQL.append(" from cRefPC REF");
            strSQL.append(" left join cEntFed EF on (EF.CodEnt=REF.CodEnt)");
            strSQL.append(" left join cMunDel MD on (MD.CodMD=REF.CodMD)");
            strSQL.append(" where clRefPC = ").append(StrclProveedorRef);

            ResultSet rs = UtileriasBDF.rsSQLNP(strSQL.toString());
            strSQL.delete(0, strSQL.length());

            if (rs.next()) {%>
        <center>
            <table border=1 class='FTable'>
                <tr><td class='cssTitDet' colspan="2" style="font-weight: bold;">Nombre</td></tr>
                <tr align="center"><td colspan="2" style="font-weight: bold;"><%=rs.getString("Nombre")%> </td></tr>
                <tr><td class='TTable'>Dirección: </td><td><%=rs.getString("Direccion")%></td></tr>
                <tr><td class='TTable'>Provincia: </td><td><%=rs.getString("Provincia")%></td></tr>
                <tr><td class='TTable'>Localidad: </td><td><%=rs.getString("Localidad")%></td></tr>
                <tr><td class='TTable'>Teléfono: </td><td><%=rs.getString("Telefono")%></td></tr>
                <tr><td class='cssTitDet' colspan="2" style="font-weight: bold;">Prestaciones</td></tr>
                <tr><td class='TTable'>Observaciones: </td><td><%=rs.getString("Observaciones")%></td></tr>
            </table>
            <br>
            <input class="cBtn" type="button" value="CERRAR" title="Cerrar" onclick="window.close();">
        </center>
        <%}%>
        <%}

        //  REFERENCIAS MUSEOS    324 PROD, 338 CAPA
        if (StrclSubServicio.equalsIgnoreCase("324")) {
            strSQL.append(" select coalesce(Nombre,'') 'Nombre', ");
            strSQL.append(" coalesce(Direccion,'') 'Direccion', ");
            strSQL.append(" coalesce(EF.dsEntFed,'') 'Provincia',");
            strSQL.append(" coalesce(MD.dsMunDel,'') 'Localidad',");
            strSQL.append(" coalesce(Observaciones,'') 'Observaciones'");
            strSQL.append(" from cRefMuseos REF");
            strSQL.append(" left join cEntFed EF on (EF.CodEnt=REF.CodEnt)");
            strSQL.append(" left join cMunDel MD on (MD.CodMD=REF.CodMD)");
            strSQL.append(" where clRefMuseo = ").append(StrclProveedorRef);

            ResultSet rs = UtileriasBDF.rsSQLNP(strSQL.toString());
            strSQL.delete(0, strSQL.length());

            if (rs.next()) {%>
        <center>
            <table border=1 class='FTable'>
                <tr><td class='cssTitDet' colspan="2" style="font-weight: bold;">Nombre</td></tr>
                <tr align="center"><td colspan="2" style="font-weight: bold;"><%=rs.getString("Nombre")%> </td></tr>
                <tr><td class='TTable'>Dirección: </td><td><%=rs.getString("Direccion")%></td></tr>
                <tr><td class='TTable'>Provincia: </td><td><%=rs.getString("Provincia")%></td></tr>
                <tr><td class='TTable'>Localidad: </td><td><%=rs.getString("Localidad")%></td></tr>
                <tr><td class='cssTitDet' colspan="2" style="font-weight: bold;">Prestaciones</td></tr>
                <tr><td class='TTable'>Observaciones: </td><td><%=rs.getString("Observaciones")%></td></tr>
            </table>
            <br>
            <input class="cBtn" type="button" value="CERRAR" title="Cerrar" onclick="window.close();">
        </center>
        <%}%>
        <%}%>

    </body>
</html>
