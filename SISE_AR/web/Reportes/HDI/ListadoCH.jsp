<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <title>Listado Reporte HDI</title>
    </head>
    <body  leftmargin=30 class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js'></script>
        <%
            String StrclUsrApp = "0";
            
            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %>Fuera de Horario<%
                StrclUsrApp = null;
                return;
            }

            String StrFechaInicio = "";
            String StrFechaFin = "";
            String StrPoliza = "";
            String StrPatente = "";
            StringBuffer StrSql = new StringBuffer();

            if (request.getParameter("FechaInicio") != null) {
                StrFechaInicio = request.getParameter("FechaInicio").toString();
            }

            if (request.getParameter("FechaFin") != null) {
                StrFechaFin = request.getParameter("FechaFin").toString();
            }

            if (request.getParameter("Poliza") != null) {
                StrPoliza = request.getParameter("Poliza").toString();
            }

            if (request.getParameter("Patente") != null) {
                StrPatente = request.getParameter("Patente").toString();
            }
            String StrclPaginaWeb = "1449";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb); %>
        <%MyUtil.InicializaParametrosC(1449, Integer.parseInt(StrclUsrApp)); %>

        <%
            StringBuffer strSalida = new StringBuffer();
            String StrQuery = "";
            StrQuery = "st_ReporteGralHDI '" + StrFechaInicio + "','" + StrFechaFin + "','" + StrPoliza + "','" + StrPatente + "'";
            System.out.println(StrQuery);
            UtileriasBDF.rsTableNP(StrQuery, strSalida);
            %><%=strSalida.toString()%><%
            strSalida.delete(0, strSalida.length());
            strSalida = null;
            StrclUsrApp = null;
            StrFechaFin = null;
            StrFechaInicio = null;
            StrPoliza = null;
            StrPatente = null;
        %>
    </body>
</html>