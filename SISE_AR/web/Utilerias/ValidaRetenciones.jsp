<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <title>Historial de Retenciones</title>
    </head>
    <script src='../Utilerias/Util.js'></script>

    <%
        String StrclUsrApp = "0";
        String Clave = "";

        if (session.getAttribute("clUsrApp") != null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if (request.getParameter("ClaveHistorico") != null) {
            Clave = request.getParameter("ClaveHistorico");
        }
        //System.out.println("Clave: '" + Clave + "'");

        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
    %>Fuera de Horario<%
            StrclUsrApp = null;
            return;
        }

    %><body class='cssBody' topmargin='10'>
        <p class='cssTitDet'>Historial Afiliados Telemarketing</p>
        <%
        StringBuffer strSql = new StringBuffer();
        StringBuffer strSalida = new StringBuffer();

        UtileriasBDF.rsTableNP(strSql.append("st_HistorialRetenciones '").append(Clave).append("'").toString(), strSalida);
        //System.out.println("st_HistorialRetenciones '" + Clave + "'");
%>
        <%=strSalida.toString()%>
        <%

        strSql.delete(0, strSql.length());
        strSalida.delete(0, strSalida.length());

        strSalida = null;
        strSql = null;

        StrclUsrApp = null;
        Clave = null;

        %>
    </body>
</html>
