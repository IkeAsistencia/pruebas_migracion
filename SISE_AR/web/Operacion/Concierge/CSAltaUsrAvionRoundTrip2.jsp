<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../Utilerias/Util.js'></script>
<script src='../Utilerias/UtilMask.js'></script>
<script src='../Utilerias/UtilDireccion.js'></script>
<br>
    <center><h1>Pasajero registrado</h1>
     <input type="button" class="cBtn" value="Cerrar" onclick="javascript:top.opener.fnLlenaPasajeros();window.close();">
     <script>   javascript:top.opener.fnLlenaPasajeros();
                window.close();
     </script>
   </center>
    </body>
</html>   