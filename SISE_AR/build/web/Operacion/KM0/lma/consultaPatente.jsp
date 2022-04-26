<%-- 
    Document   : consultaPatente.jsp
    Created on : 29/01/2020, 10:37:09 AM
    Author     : ddiez
--%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1" import="Seguridad.SeguridadC,ar.com.ike.client.lma.ConsultaPatente,ar.com.ike.client.lma.PatenteSinPolizaException,ar.com.ike.client.lma.ServConsultaPatenteResponse" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Consulta por Patente a La Mercantil Andina</title>
        <style>
            .row1 {
                background-color: D0E4F5;
            }
            .row2{
                background-color: white;
            }
            .thead {
                background-color: #0B6FA4;
                color: white;
            }
            table {
                font-size: 18px;
            }
        </style>
    </head>
    <body>
    <table>
    <tr><th class="thead" colspan="2">Datos La Mercantil Andina</th></tr>
    <%
        if ( "GET".equalsIgnoreCase(request.getMethod() ) ) {
            //GET patente.
            %>
            <form method="POST">
            <tr>
            <td>
                <input type="text" value="" id="patente" name="patente">
                <input type="submit">
            </td>
            </tr>
            </form>
            <%
        }
        else {
            String patente = ( request.getParameter("patente")!=null? request.getParameter("patente") : "" );
            if ( !"".equals(patente) ) {
                ConsultaPatente cp = new ConsultaPatente();
                try {
                    ServConsultaPatenteResponse CPresp = cp.getDatos(patente);
                    %>
                    <tr>
                        <td class="row1" >P&oacute;liza</td>
                        <td class="row1"><%=CPresp.poliza%></td>
                    </tr>
                    <tr>
                        <td class="row2">Nombre</td>
                        <td class="row2"><%=CPresp.nombre%></td>
                    </tr>
                    <tr>
                        <td class="row1">Raz&oacute;n Social</td>
                        <td class="row1"><%=CPresp.razonSocial%></td>
                    </tr>
                    <tr>
                        <td class="row2">Direcci&oacute;n</td>
                        <td class="row2"><%=CPresp.direccion%></td>
                    </tr>
                    <tr>
                        <td class="row1">Veh&iacute;culo</td>
                        <td class="row1"><%=CPresp.marca%></td>
                    </tr>
                    <tr>
                        <td class="row2">C&oacute;digo de Producto</td>
                        <td class="row2"><%=CPresp.codigoProducto%></td>
                    </tr>
                    <%
                }
                catch (PatenteSinPolizaException sinPat) {
                    System.out.print("consultaPatente.jsp.NO Brindar Servicio:" + patente );
                %>
                    <tr>
                        <td class="row1" colspan="2" >DOMINIO <%=patente%> no encontrado, NO BRINDAR SERVICIO.</td>
                    </tr>
                <%
                }
            }
        %>
            <tr><td colspan="2">&nbsp;</td></tr>
            <tr><td colspan="2">
                <div align="right"><input type="button" onclick="window.close()" value="Cerrar"></div>
                </td>
            </tr>
        <%
        }
    %>
    </table>

    </body>
</html>
