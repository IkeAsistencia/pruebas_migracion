<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title></title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <script type="text/javascript"  src='../../Utilerias/Util.js'></script>
        <%
            String StrclReferencia="0";

            if (request.getParameter("clReferencia")!= null){
                StrclReferencia = request.getParameter("clReferencia").toString();
             }
            if (request.getParameter("clReferencia")!= null){
                StrclReferencia = request.getParameter("clReferencia").toString();
             }

            StringBuffer strSQL = new StringBuffer();

            strSQL.append(" st_CSInfoReferecia ").append(StrclReferencia);

            ResultSet rs = UtileriasBDF.rsSQLNP(strSQL.toString());
            strSQL.delete(0,strSQL.length());

            if (rs.next()){

        %>
        <center>
            <table border=1 class='FTable'>
                <tr>
                    <td class='cssTitDet' colspan="2">Nombre de la Referencia : </td><td colspan="2"><%=rs.getString("NomAlter")%> </td>
                </tr>
                <tr>
                    <td class='TTable'>Nombre Razon Social : </td><td><%=rs.getString("NomEstablec")%> </td>
                    <td class='TTable'>Contacto : </td><td><%=rs.getString("Contacto")%> </td>
                </tr>
                <tr>
                    <td class='cssAzul' colspan="4">Pais: <%=rs.getString("dsPais")%> </td>
                </tr>
                <tr>
                    <td >Acepta VISA: <%=rs.getString("AceptaVisa")%></td>
                    <td >Acepta MasterCard: <%=rs.getString("AceptaMaster")%></td>
                    <td> Acepta American Express: <%=rs.getString("AceptaAmerican")%></td>
                    <td>Acepta Diners: <%=rs.getString("AceptaDinners")%></td>
                </tr>
                <tr>
                    <td colspan="2">Acepta Tarjeta de Debito: <%=rs.getString("AceptaDebito")%></td>
                    <td colspan="2">Acepta Efectivo: <%=rs.getString("AceptaEfectivo")%></td>
                </tr>
                <tr>
                    <td>Provincia: <%=rs.getString("dsEntFed")%></td><td>Localidad: <%=rs.getString("dsMunDel")%></td>
                    <td>Entidad: <%=rs.getString("Entidad")%></td><td>Ciudad: <%=rs.getString("Ciudad")%></td>
                </tr>
                <tr>
                    <td colspan="2">Calle: <%=rs.getString("CalleNum")%></td>
                    <td colspan="2">Entre Calles: <%=rs.getString("EntreCalles")%></td>
                </tr>
                <tr>
                    <td colspan="2">CP: <%=rs.getString("CP")%></td>
                    <td colspan="2">Horario: <%=rs.getString("Horario")%></td>
                </tr>
            </table>
        </center>
        <%
            }

        rs.close();
        rs=null;
        %>
    </body>
</html>

