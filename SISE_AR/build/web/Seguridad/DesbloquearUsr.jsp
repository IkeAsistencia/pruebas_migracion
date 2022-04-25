<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@page import="java.sql.ResultSet,Utilerias.UtileriasBDF" %>

<html>
    <head>
        <title>Actualización de Menús</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <style>
            .principal{
                font-size:14px;
                font-family:sans-serif;
                font-weight:bold;
            }
            .texto{
                font-size:13px;
                font-weight:bold;
                color:#FE7018;
                font-family:sans;
            }
            .instrucciones{
                font-size:12px;
                font-weight:bold;
                font-family:sans-serif;
            }
        </style>
    </head>
    <body bgcolor="#004B85" >
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>

        <%
        String StrclUsrApp = "0";

        if (request.getParameter("clUsrApp") != null) {
            StrclUsrApp = request.getParameter("clUsrApp");
        }

        StringBuffer StrSql2 = new StringBuffer();
        StrSql2.append("sp_DesbloqueaUsr '");
        StrSql2.append(StrclUsrApp).append("'");

        UtileriasBDF.ejecutaSQLNP(StrSql2.toString());
        StrSql2.delete(0, StrSql2.length());

        StringBuffer StrSql = new StringBuffer();
        StrSql.append("Select Nombre from cUsrApp where clUsrApp='" + StrclUsrApp + "'");

        ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0, StrSql.length());

        if (rs2.next()) {
            String StrNombreUsr = rs2.getString("Nombre");

            //out.println("<p align='center'>");
            //out.println("<font class='TitResumen'> El Usuario: </font><br><br><font class='cssazul'>" + StrNombreUsr + "<br>(Clave:" + StrclUsrApp + ")</font> <br><br><font class='TitResumen'>fue desbloqueado.<BR>Su contraseña para entrar al Sistema es '12345678'.");
%>
        <input id='URLBACK' name='URLBACK' type='hidden' value='" + request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1) + "Main.jsp?'>
        <div align="center">
            <div class="Table"><br>
                <a class="instrucciones">Se ha desbloqueado con éxito<br>el Usuario:</a><br><br>
                <a class="principal"><%=StrNombreUsr%></a><br>
                <a class="principal">clave: <%=StrclUsrApp%></a><br><br>
                <a class="instrucciones">Debe ingresar al Sistema<br>con la contraseña: <a class="texto">'12345678'</a>.</a><br><br>
                <input style="font-size:11px;" class="cBtn" type="button" id="btnCrr" value="ACEPTAR" onClick="window.close();"></input>
                <br><br>
            </div>
        </div>
        <% }%>

        <!--br><br>
        <input type="button" name="btnCrr" id="btnCrr" onclick="window.close();" value="Cerrar Ventana"></input-->
        <%
        rs2.close();
        rs2 = null;

        StrclUsrApp = null;
        StrSql2 = null;
        StrSql = null;
        %>
    </body>
</html>