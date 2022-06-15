<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Utilerias.UtileriasBDF,java.sql.ResultSet,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Envio de SMS Asiganción</title>   
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <style type="text/css">
            .Mensaje {
                font-family: Verdana, Arial, Helvetica, sans-serif;
                color: #000066;
                font-size: 12px;                
            }
        </style>
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js'></script>         
        <%
            String StrclUsrApp = "0";
            String StrclExpediente = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
                return;
            }
            MyUtil.InicializaParametrosC(731, Integer.parseInt(StrclUsrApp));

            ResultSet rsVldArea = UtileriasBDF.rsSQLNP("st_SMSValidaBtnSms " + StrclExpediente);
            if (rsVldArea.next()) {
                if (rsVldArea.getString("Boton").equalsIgnoreCase("1")) {
        %>
        <!--
        <form action='../GeneraSMSAsignacion' method='post' name="Externo">
        <input name='clTipoEnvio' id='clTipoEnvio' type='hidden' value="5">
        -->
        <!--form action='../servlet/Utilerias.GeneraSMSAsignacion' method='post' name="Externo"-->
            <form action='../servlet/com.ike.sms.GeneraSMSAsignacion' method='post' name="Externo">
            <input name='clExpediente' id='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <input name='clUsrApp' id='clUsrApp' type='hidden' value='<%=StrclUsrApp%>'>



            <%=MyUtil.ObjComboC("Seleccione un mensaje", "clMensajeSMS", "", true, true, 85, 45, "", "Select clMensaje, dsMensaje from SMScMensaje Where Activo = 1", "", "", 25, true, true)%>

            <div class='VTable' style='position:absolute; z-index:3; left:500px; top:115px;'>
                <input class="cBtn" name="Enviar" type='button' onclick="this.form.submit();
                        alert('El mensaje ha sido programado para ser enviado');
                        window.close();
                        refrescar();" value='Enviar SMS'>
            </div>            

        </form>
        <%
        } else {%>
        <div class='Mensaje' style='position:absolute; z-index:3; left:70px; top:70px;width:545px; height:130px;'>
            El envi&oacute; de mensajes &uacute;nicamente esta disponible para expedientes con servicio vial.
        </div>
        <%}
            }
        %>
        <div class='cssBGDetSw' style='background-color:#052145; position:absolute; z-index:1; left:70px; top:25px; width:555px; height:130px;'>
            <p class='cssTitDet'></p></div>
        <div class='cssBGDet' style='position:absolute; z-index:2; left:60px; top:15px; width:555px; height:130px;'>
            <p class='cssTitDet'>Envio de Mensaje SMS</p></div>

        <script>
            document.all.clMensajeSMSC.disabled = false;

            function refrescar() {
                opener.focus();
                opener.actualizar();
            }
        </script>
    </body>  
</html>