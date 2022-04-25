<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>HISTÓRICO DE CAMBIOS</title></head>
    <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    <body class="cssBody">
        <script src='Utilerias/Util.js' ></script>
        <%
                String clReclamo = "";
                StringBuffer sb = new StringBuffer();

                if (request.getParameter("clReclamo") != null) {
                    clReclamo = request.getParameter("clReclamo").toString().trim();
                }

                sb.append("st_HistoricoReclamos ").append(clReclamo);
                //System.out.println(sb);
                ResultSet rs = UtileriasBDF.rsSQLNP(sb.toString());
                sb.delete(0, sb.length());
        %>
        <table width='990px' class='cssTitDet'>
            <tr><td><b>Histórico de Cambios</b></td></tr>
        </table>
        <TABLE width='990px' Border=1 Class='vTable'>
            <tr>
                <td class="TitC">FOLIO</td>
                <td class="TitC">ESTATUS</td>
                <td class="TitC">FECHA DEL RECLAMO</td>
                <td class="TitC">FECHA DE MODIFICACIÓN</td>              
                <td class="TitC">TIPIFICACIÓN</td>
                <td class="TitC">USUARIO QUE REGISTRA</td>
            </tr>
            <%  while (rs.next()) {%>

            <TR align="center">
                <TD><%=rs.getString("Folio")%></TD>
                <TD><%=rs.getString("Estatus")%></TD>
                <TD><%=rs.getString("FechaIngreso")%></TD>
                <TD><%=rs.getString("FechaModifica")%></TD>
                <TD><%=rs.getString("Tipificacion")%></TD>
                <TD><%=rs.getString("Usuario")%></TD>
            </TR>
            <%
                    }
                    rs.close();
                    rs = null;
            %></TABLE>

    </body>
</html>

