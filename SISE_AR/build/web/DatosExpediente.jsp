<%@page contentType="text/html; charset=iso-8859-1" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF"%>
<html>
    <head>
        <title>Datos Expediente</title>
        <link href="StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body topmargin="5" leftmargin="5" bgcolor=#062f67 bgproperties="fixed">
        <table class="Table" width='900' cellspacing="0" cellpadding="0">
            <%
            String strclUsrApp = "0";
            if (session.getAttribute("clUsrApp") != null) {
                strclUsrApp = session.getAttribute("clUsrApp").toString();           }
            if(SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true){
                %><font color="white"  style="font-family:Verdana,Arial,Helvetica,sans-serif; background-color:red;" size=3>LA SESION EXPIRO</font><%  
                strclUsrApp=null;
                return;
                }
            String strclExpediente = "0";
            if (session.getAttribute("clExpediente") != null) {
                strclExpediente = session.getAttribute("clExpediente").toString();        }
            if (strclExpediente.equalsIgnoreCase("0")) {
            } else {
                try {
                    StringBuffer strSQL = new StringBuffer();
                    strSQL.append("st_getDatosExpediente ").append(strclExpediente);
                    ResultSet rs = UtileriasBDF.rsSQLNP(strSQL.toString());
                    strSQL.delete(0, strSQL.length());
                    if (rs.next()) {      %>
                        <tr>
                            <td class='TitResumen' >Expediente:</td><td class='FTable'><%=rs.getString("clExpediente")%></td>
                                <input type="hidden" id="clExpediente" name="clExpediente" value="<%=rs.getString("clExpediente")%>">
                            <td class='TitResumen' >Cuenta:</td><td class='FTable'><%=rs.getString("Nombre")%></td>
                        </tr>
                        <tr>
                            <td class='TitResumen' >NU:</td><td class='FTable'><%=rs.getString("NuestroUsuario")%></td>
                            <td class='TitResumen' >Teléfono:</td><td class='FTable'><%=rs.getString("Telefono")%></td>
                            <td class='TitResumen' >Servicio:</td><td class='FTable'><%=rs.getString("dsServicio")%>&nbsp&nbsp/&nbsp&nbsp<%=rs.getString("dsSubservicio")%></td>
                        </tr>
                        <tr><td class='TitResumen' >Ocurrido:</td><td colspan=4 class='FTable'><%=rs.getString("DescripcionOcurrido")%></td></tr>
                        <%
                        }
                    rs.close();
                    rs = null;
                    strSQL.append("st_getEstatusProv '").append(strclExpediente).append("'");
                    rs = UtileriasBDF.rsSQLNP(strSQL.toString());
                    strSQL.delete(0, strSQL.length());
                    if (rs.next()) {%>
                        <tr>
                            <td class='TitResumen' >Último Proveedor:</td><td class='FTable'><%=rs.getString("NombreOpe")%></td>
                            <td class='TitResumen' >Estatus:</td><td class='FTable'><%=rs.getString("dsEstatus")%></td>
                        </tr>
                        <%}
                    rs.close();
                    rs = null;
                } catch (Exception e) {     e.printStackTrace();  }
                }  %>
            <input id="clUsrApp" name="clUsrApp" type="hidden" value="<%=strclUsrApp%>" />
            <form name="datos">
                <input id="clProveedor" name="clProveedor" type="hidden" value="">
                <input id="modo" name="modo" type="hidden" value="">
                <input id="extra" name="extra" type="hidden" value="">
            </form>
        </table>
    </body>
</html>