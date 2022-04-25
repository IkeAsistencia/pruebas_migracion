<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="UtlHash.LoadPagina,Utilerias.GeneraRpt,java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>Estatus</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    
    <body class='cssBody'>
        <form action='../servlet/Seguridad.StartStopServices' method='get'>
            <input name='IDProcess' id='IDProcess' type='hidden'>
            <input name='Action' id='Action' type='hidden'>
            ARGENTINA PROD <br><br>

            <%
                ResultSet rs = UtileriasBDF.rsSQLNP("st_ObtenReportesCorreosNoEnviados");
                String StrReportesSinEnviar = "";
                String StrCorreosSinEnviar = "";
                if (rs.next()) {
                    StrReportesSinEnviar = rs.getString("NoReportes");
                    StrCorreosSinEnviar = rs.getString("NoCorreos");
                }
            %>
            <table>
                <tr>
                    <td>Envío de Reportes</td>
                    <td>
                        <input onClick='document.all.IDProcess.value = 1; document.all.Action.value = 1' type='submit' value='Iniciar'></input>
                        <input onClick='document.all.IDProcess.value = 1; document.all.Action.value = 0' type='submit' value='Detener'></input>
                    </td>
                    <% if (Utilerias.GeneraRpt.getEstatus()) { %>
                        <td>Estatus: <b> <font color="GREEN">Iniciado</font></b></td>
                    <%} else {%>
                        <td>Estatus: <b> <font color="RED">Detenido</font></b></td>
                    <%}%> 
                </tr>
                <tr>
                    <td colspan="3">
                        <b>REPORTES NO ENVIADOS: <%=StrReportesSinEnviar%></b>
                    </td>
                </tr>
                <tr>
                    <td>Envio de Correo</td>
                    <td>
                        <input onClick='document.all.IDProcess.value = 4; document.all.Action.value = 1' type='submit' value='Iniciar'></input>
                        <input onClick='document.all.IDProcess.value = 4; document.all.Action.value = 0' type='submit' value='Detener'></input>
                    </td>
                     <% if (Utilerias.EnviaCorreo.getEstatus()) { %>
                        <td>Estatus: <b> <font color="GREEN">Iniciado</font></b></td>
                    <%} else {%>
                        <td>Estatus: <b> <font color="RED">Detenido</font></b></td>
                    <%}%> 
                </tr>
                <tr>
                    <td colspan="3">
                        <b>CORREOS NO ENVIADOS: <%=StrCorreosSinEnviar%></b>
                    </td>
                </tr>
                <tr>
                    <td>Envio de Correo PDF</td>
                    <td>
                        <input onClick='document.all.IDProcess.value = 5; document.all.Action.value = 1' type='submit' value='Iniciar'></input>
                        <input onClick='document.all.IDProcess.value = 5; document.all.Action.value = 0' type='submit' value='Detener'></input>
                    </td>
                
                    <% if (Utilerias.EnviaCorreoPDF.getEstatus()) { %>
                        <td>Estatus: <b> <font color="GREEN">Iniciado</font></b></td>
                    <%} else {%>
                        <td>Estatus: <b> <font color="RED">Detenido</font></b></td>
                    <%}%> 
                </tr>
                
                <tr>
                    <td>Envio de SMS</td>
                    <td>
                        <input onClick='document.all.IDProcess.value = 6; document.all.Action.value = 1' type='submit' value='Iniciar'></input>
                        <input onClick='document.all.IDProcess.value = 6; document.all.Action.value = 0' type='submit' value='Detener'></input>
                    </td>
                
                    <% if (Utilerias.EnviaSMS.getEstatus()) { %>
                        <td>Estatus: <b> <font color="GREEN">Iniciado</font></b></td>
                    <%} else {%>
                        <td>Estatus: <b> <font color="RED">Detenido</font></b></td>
                    <%}%> 
                </tr>
                
                <tr>
                    <td colspan="3">
                        <b>PROCESO CONCIERGE</b>
                    </td>                                   
                </tr>
                
                <tr>
                    <td>Actualiza Concierge MC</td>
                    <td>
                        <input onClick='document.all.IDProcess.value = 7; document.all.Action.value = 1' type='submit' value='Iniciar'></input>
                        <input onClick='document.all.IDProcess.value = 7; document.all.Action.value = 0' type='submit' value='Detener'></input>
                    </td>
                
                    <% if (Utilerias.ProcesoConcierge.getEstatus()) { %>
                        <td>Estatus: <b> <font color="GREEN">Iniciado</font></b></td>
                    <%} else {%>
                        <td>Estatus: <b> <font color="RED">Detenido</font></b></td>
                    <%}%> 
                </tr>
                
            </table>
        </form>
                <%
                rs.close();
                rs = null;
                StrReportesSinEnviar = null;
                StrCorreosSinEnviar = null;
                %>
    </body>
</html>
