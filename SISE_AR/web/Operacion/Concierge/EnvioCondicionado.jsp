<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Envio Condicionado Concierge</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <%
                    String StrclUsrApp = "";
                    String StrclAsistencia = "0";
                    String StrMensaje = "";
                    String StrETCC = "0";
                    String StrETCP = "0";
                    String StrETCA = "0";
                    String StrETCO = "0";
                    String StrETCX1 = "0";

                    if (session.getAttribute("clUsrApp") != null) {
                        StrclUsrApp = session.getAttribute("clUsrApp").toString();
                    }

                    if (request.getParameter("clAsistencia") != null) {
                        StrclAsistencia = request.getParameter("clAsistencia");
                    }

                    if (request.getParameter("ETCC") != null) {
                        StrETCC = request.getParameter("ETCC");
                    }

                    if (request.getParameter("ETCP") != null) {
                        StrETCP = request.getParameter("ETCP");
                    }

                    if (request.getParameter("ETCA") != null) {
                        StrETCA = request.getParameter("ETCA");
                    }

                    if (request.getParameter("ETCO") != null) {
                        StrETCO = request.getParameter("ETCO");
                    }

                    if (request.getParameter("ETCX1") != null) {
                        StrETCX1 = request.getParameter("ETCX1");
                    }

                    StringBuffer strSql = new StringBuffer();

                    strSql.append("st_GeneraMailConcierge '").append(StrclAsistencia).append("','").append(StrclUsrApp);
                    strSql.append("','").append(StrETCC);
                    strSql.append("','").append(StrETCP);
                    strSql.append("','").append(StrETCA);
                    strSql.append("','").append(StrETCO);
                    strSql.append("','").append(StrETCX1).append("'");

                    //System.out.println("Entra: " + strSql);
                    ResultSet rs = UtileriasBDF.rsSQLNP(strSql.toString());
                    strSql.delete(0, strSql.length());

                    if (rs.next()) {
                        StrMensaje = rs.getString("Mensaje");
        %>

        <script>
            top.opener.fnValidaEnvio('<%=StrMensaje%>');
            window.close();
        </script>
        <%}
                    rs.close();
                    rs = null;

                    StrclUsrApp = null;
                    StrclAsistencia = null;
                    StrMensaje = null;
                    StrETCC = null;
                    StrETCP = null;
                    StrETCA = null;
                    StrETCO = null;
                    StrETCX1 = null;
        %>
    </body>
</html>