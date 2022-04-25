<%@page contentType="text/html; charset=iso-8859-1" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" %>
<html>
    <head>
        <title>Cobertura de Proveedor Vial</title>
    </head>
    <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
    <%
            String StrclCoberturaxProveedor = "";
            String StrclUsrApp = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (request.getParameter("clCoberturaxProveedor") != null) {
                StrclCoberturaxProveedor = request.getParameter("clCoberturaxProveedor").toString();
            }

            MyUtil.InicializaParametrosC(811, Integer.parseInt(StrclUsrApp));
    %>
    <input id='clCoberturaxProveedor' name='clCoberturaxProveedor' type='hidden' value='<%=StrclCoberturaxProveedor%>'>
    
    <frameset framespacing='0' noresize frameborder='no' rows="250,*">
        <frame frameborder='no' noresize name='DetalleCobertura' id='DetalleCobertura' src='DetalleCobxProv.jsp'></frame>
        <frame frameborder='yes' noresize name='VistaPrevia' id='VistaPrevia' src='../Empty.jsp?'></frame>
    </frameset>
</html>
