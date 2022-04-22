<%-- 
    Document   : EliminaCadaverMascota
    Created on : 2/03/2011, 01:46:21 PM
    Author     : rurbina
--%>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.asistencias.DAOEliminaCadaverMascota,com.ike.asistencias.to.AsistenciaVeterinaria" errorPage="" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Eliminación de Cadáver de Mascotas</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body  class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js' ></script>

        <%
        String StrclExpediente = "";
        String StrclUsrApp = "0";
        String StrclPaginaWeb = "0";

        if (session.getAttribute("clUsrApp") != null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
            StrclExpediente = null;
            StrclUsrApp = null;
            StrclPaginaWeb = null;

            return;
        }

        if (session.getAttribute("clExpediente") != null) {
            StrclExpediente = session.getAttribute("clExpediente").toString();
        }

        DAOEliminaCadaverMascota daoecm = null;
        AsistenciaVeterinaria AV = null;

        if (StrclExpediente != null) {
            daoecm = new DAOEliminaCadaverMascota();
            AV = daoecm.getAsistenciaVeterinaria(StrclExpediente);
        } else {
        %> El expediente no existe <%
            StrclExpediente = null;
            StrclUsrApp = null;
            StrclPaginaWeb = null;

            return;
        }

        %>
        <script>fnOpenLinks()</script>

        <%
        StrclPaginaWeb = "6002";
        session.setAttribute("clPaginaWebP", StrclPaginaWeb);

        MyUtil.InicializaParametrosC(6002, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "", "")%>

        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='6002'>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="EliminaCadaverMascota.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjInput("Nombre de la Mascota", "NombreMascota", AV != null ? AV.getNombreMascota() : "", true, true, 30, 80, "", true, true, 30)%>
        <%=MyUtil.ObjInput("Edad (Años)", "Edad", AV != null ? AV.getEdad() : "", true, true, 210, 80, "", false, false, 10, "")%>
        <%=MyUtil.ObjInput("Peso (Kgs.)", "Peso", AV != null ? AV.getPeso() : "", true, true, 290, 80, "", false, false, 10, "")%>
        <%=MyUtil.ObjInput("Raza", "Raza", AV != null ? AV.getRaza() : "", true, true, 30, 125, "", false, false, 20, "")%>
        <%=MyUtil.ObjComboC("Tipo Mascota", "clTipoMascota", AV != null ? AV.getDsTipoMascota() : "", true, true, 160, 125, "", "Select clTipoMascota, dsTipoMascota From cTipoMascota order by dsTipoMascota ", "", "", 30, true, true)%>
        <%=MyUtil.ObjTextArea("Ubicación (Dirección)", "Direccion", AV != null ? AV.getDireccion() : "", "60", "4", true, true, 30, 170, "", false, false)%>
        <%=MyUtil.DoBlock("Eliminación de Cadáver de Mascotas", -100, 30)%>

        <%=MyUtil.ObjTextArea("Motivo de Muerte", "MotivoMuerte", AV != null ? AV.getMotivoMuerte() : "", "60", "4", true, true, 30, 290, "", false, false)%>
        <%=MyUtil.ObjTextArea("Recomendaciones del Veterinario", "Recomendacion", AV != null ? AV.getRecomendacionVet() : "", "60", "4", true, true, 30, 370, "", false, false)%>
        <%=MyUtil.DoBlock("Evaluación", 160, 35)%>

        <%=MyUtil.GeneraScripts()%>
        <%
        StrclExpediente = null;
        StrclUsrApp = null;
        StrclPaginaWeb = null;

        daoecm = null;
        AV = null;
        %>
    </body>
</html>
