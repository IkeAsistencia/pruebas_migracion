
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>Desencriptar Tarjeta</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onLoad="">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script type="text/javascript" src='../../Utilerias/Util.js' ></script>
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px; right:10px;'>
            <p align="center"><font color="navy" face="Arial" size="2" ><b><i></i></b></font><br>
            </p>
        </div> 
        <%   //'DesencripTarj.jsp?pclExpediente=' + document.all.clExpediente.value + '&pDesencripTarj='+document.all.DesencripTarj.value, 'Hist', 'scrollbars=yes,status=yes,width=650,height=300');                    

            String StrclUsrApp = "0";
            String StrclExpediente = "0";
            String StrDesencripTarj = "0";
            String StrCodigoSeg = "0";

            String StrError = "";

            ResultSet rs = null;

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (request.getParameter("pclExpediente") != null) {
                StrclExpediente = request.getParameter("pclExpediente").toString();
            }

            rs = UtileriasBDF.rsSQLNP("st_DesEncriptaT " + StrclExpediente + "," + StrclUsrApp);

            if (rs.next()) {
                StrDesencripTarj = rs.getString("tarj");
                StrCodigoSeg = rs.getString("codigoSeguridad");

            }

            System.out.println("tarj " + StrDesencripTarj + " CodSeguridad " + StrCodigoSeg);
            rs.close();
            rs = null;

        %> 
        <script>
                top.opener.fnActualizaEncrip('<%=StrDesencripTarj%>', '<%=StrCodigoSeg%>');
                window.close();
        </script>                
    </body>
</html>


