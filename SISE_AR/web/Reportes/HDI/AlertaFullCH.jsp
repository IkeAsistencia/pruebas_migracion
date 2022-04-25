<%@ page contentType="text/html;charset=windows-1252"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>Reporte Chartis</title>
    </head>
    <body>
        <%
            String strclTipoRpo = "0";
            
            if (request.getParameter("clTipoRpo") != null) {
                strclTipoRpo = request.getParameter("clTipoRpo").toString();
            }
            
            session.setAttribute("clTipoRpo", strclTipoRpo);
        %>
        <script>
            //------------------------------------------------------------------------------
            var nuevaVentana = window.open('FraAlertasCH.jsp?', 'new', 'resizable=yes,menubar=0,status=0,toolbar=0,height=100%,width=100%,screenX=0,screenY=0,fullscreen=yes');
            //------------------------------------------------------------------------------
        </script>
    </body>
</html>