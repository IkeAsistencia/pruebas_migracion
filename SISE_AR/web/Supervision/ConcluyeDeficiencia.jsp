<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>Concluye Deficiencia</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" />
        <script type="text/javascript"  src='../../Utilerias/Util.js' ></script>
        <p style="width: auto"></p>
        <%
                    StringBuffer StrSql = new StringBuffer();
                    String StrclUsrApp = "0";
                    String StrclDeficienciaxExpediente = "0";


                    if (session.getAttribute("clUsrApp") != null) {
                        StrclUsrApp = session.getAttribute("clUsrApp").toString();
                    }

                    if (request.getParameter("clDeficienciaxExpediente") != null) {
                        StrclDeficienciaxExpediente = request.getParameter("clDeficienciaxExpediente");
                    }

                    if (StrclDeficienciaxExpediente != "0") {
                        StrSql.append(" st_ConcluyeDeficiencia '").append(StrclUsrApp).append("','").append(StrclDeficienciaxExpediente).append("'");
                        UtileriasBDF.ejecutaSQLNP(StrSql.toString());
                        //System.out.println("QRY: " + StrSql);

                        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
                        if (rs.next()) {
                            if (rs.getString("Error").equals("0")) {
        %>
        <script type="text/javascript">
            location.href='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>../servlet/Utilerias.Lista?P=303&Apartado=S';
        </script>
        <%
                            }
                        }
                    }
                    StrSql.delete(0, StrSql.length());

                    StrclUsrApp = null;
                    StrclDeficienciaxExpediente = null;
        %>
    </body>
</html>
