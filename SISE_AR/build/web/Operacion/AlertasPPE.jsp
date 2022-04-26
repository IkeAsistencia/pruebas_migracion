<%@page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" import="Seguridad.SeguridadC,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Iterator,ar.com.ike.alertas.AlertasService,ar.com.ike.alertas.Alertas,ar.com.ike.alertas.Alerta"%>
<html>
    <head>
         <title>Alertas PPE</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <style type="text/css">
            .VENCIDA {
                background-color: red !important;
                color: white !important;
                font-weight: bold;
            }
            .URGENTE {
                background-color: yellow !important;
                color: black !important;
                font-weight: bold;
            }
            .ALERTA {
                background-color: green !important;
                color: white !important;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <%
            String strClUsrApp = "0";
            if (session.getAttribute("clUsrApp") != null) {
                strClUsrApp = session.getAttribute("clUsrApp").toString();      }
            if(SeguridadC.verificaHorarioC(Integer.parseInt(strClUsrApp)) != true){
                %><font color="white"  style="font-family:Verdana,Arial,Helvetica,sans-serif; background-color:red;" size=3>LA SESION EXPIRO</font><%  
                strClUsrApp=null;
                return;
                }
            Alertas alertas = AlertasService.ObtenerAlertas(Integer.parseInt(strClUsrApp));
        %>
        <table class="Lista">
            <tr class="Columnas">
                <th>Alerta</th>
                <th>Expediente</th>
                <th>Cita</th>
                <th>Recordatorio</th>
                <th>Vencimiento</th>
                <th>Urgencia</th>
            </tr>
            <%  Iterator<Alerta> itAlertas = alertas.alertas.iterator();
                while(itAlertas.hasNext()){
                    Alerta alerta = itAlertas.next();
                    DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                    String strVencimiento = df.format(alerta.FechaVencimiento);
                    %>
                    <tr class="Contenido1">
                        <td><%= alerta.clAlerta %></td>
                        <td><a href="DetalleExpediente.jsp?clExpediente=<%= alerta.clExpediente %>" target="Contenido"><%= alerta.clExpediente %></a></td>
                        <td>
                            <% if (alerta.clCita != null) {%>
                                <a href="DetalleExpediente.jsp?clExpediente=<%= alerta.clExpediente %>&irASeguimiento=S" target="Contenido">
                                    <%= alerta.clCita %>
                                </a>
                                <%}%>
                        </td>
                        <td>
                            <% if (alerta.clRecordatorio != null) {%>
                                <a href="DetalleExpediente.jsp?clExpediente=<%= alerta.clExpediente %>&irABitacora=S" target="Contenido">
                                    <%= alerta.clRecordatorio %>
                                </a>
                                <%}%>
                        </td>
                        <td>
                            <%= strVencimiento %>
                        </td>
                        <td class="<%= (alerta.nivelUno ? "ALERTA" : (alerta.nivelDos ? "URGENTE" : (alerta.vencida ? "VENCIDA" : "")))%>">
                            <%= (alerta.nivelUno ? "ALERTA" : (alerta.nivelDos ? "URGENTE" : (alerta.vencida ? "VENCIDA" : "")))%>
                        </td>
                    </tr>
                    <%}%>
        </table>
    </body>
</html>