<%-- 
    Document   : CSValidaBins
    Created on : 22/12/2009, 07:55:53 PM
    Author     : rfernandez
--%>
<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1250">
        <title>Valida Bin</title>
    </head>
    <body>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js' ></script>
        <%
                String strClave = "0";
                String StrclCuenta = "";
                String StrSql = "";
                String Banco = "0";
                String Otorgar = "0";
                String Mensaje = "";
                String WarmTransfer = "";
                String ExisteBin = "";
                String StrclPais="";

                if (request.getParameter("ClaveBin") != null) {
                    strClave = request.getParameter("ClaveBin").toString();
                }

                if (request.getParameter("clCuenta") != null) {
                    StrclCuenta = request.getParameter("clCuenta").toString();
                }

                StrSql = "st_CSObtenClave '" + strClave + "','" + StrclCuenta + "'";
                ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());

                if (rs.next()) {
                    Banco = rs.getString("Banco");
                    Otorgar = rs.getString("Otorgar");
                    Mensaje = rs.getString("Mensaje");
                    WarmTransfer = rs.getString("WarmTransfer");
                    ExisteBin = rs.getString("ExisteBin");
                    StrclPais = rs.getString("clPais");
                }
        %>
        <script>
            top.opener.fnActualizaBin('<%=Banco%>','<%=Otorgar%>','<%=Mensaje%>','<%=WarmTransfer%>','<%=ExisteBin%>','<%=StrclPais%>');
            window.close();
        </script>
        <%
                strClave = null;
                Banco = null;
                rs = null;
        %>
    </body>
</html>
