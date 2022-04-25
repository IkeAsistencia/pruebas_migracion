<%-- 
    Document   : panelAsigAuto.jsp
    Created on : 13/07/2018, 15:13:45
    Author     : ddiez
--%>
<%@page contentType="text/html; charset=iso-8859-1" %>
<%@page import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF,java.util.Enumeration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
    <head>
        <meta http-equiv="x-ua-compatible" content="IE=10">
        <script type="text/javascript" src="modernizr-custom.js"></script>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>    
        <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <style>
            #datos{
                    border: 1px solid #000066;
                    background: #ecf2f9;
                    color: #000066;
                    padding: 10px;
                }
            #datos_even{
                    border: 1px solid #000066;
                    background: #ecf2f9;
                    color: #000066;
                    padding: 10px;
                }
                #datos_odd {
                    border: 1px solid #000066;
                    background: #e0f2f9;
                    color: #003366;
                    padding: 10px;
                }                
                fieldset legend {
                    font-family: Verdana, Arial, Helvetica, sans-serif;
                    font-size: 11px;
                    font-weight: bold;
                    background: #FE7018;
                    color: #FFFFFF;
                    padding: 6px;
                }
        </style>
    </head>
    <body bgcolor="#062f67">
    <table id="datos" width="">
        <tr><th width="150px">Expediente</th><th width="200px">Fecha Envio</th><th width="200px">Respuesta</th><th width="100px">Aceptado</th></tr>
    <%
            String strSql = new String( "SELECT clExpediente, FechaEnvio, Respuesta, coalesce(aceptado, 'false') as aceptado from wsenvioexpediente  where fechaenvio > dateadd(hh,-48,getdate()) order by fechaenvio desc" );
            ResultSet rs = null;
            rs = UtileriasBDF.rsSQLNP(strSql.toString());
            boolean i= false;
            while (rs.next()) {
                out.println("<tr id='datos_" + (i?"odd":"even") + "'><td align='center'>");
                int tmpExp = rs.getInt("clExpediente");
                out.print( tmpExp > 0? tmpExp:"<font color='#ff3333'>" +tmpExp+"</font>" );
                out.print("</td><td>");
                out.print(rs.getString("FechaEnvio"));
                out.print("</td><td>");
                out.print(rs.getString("respuesta"));
                out.print("</td><td align='center'>");
                out.print("false".equals(rs.getString("aceptado"))?"---": "SI");
                out.print("</td></tr>");
                i =!i;
            }
    %>
    </table>        
    </body>
</html>
