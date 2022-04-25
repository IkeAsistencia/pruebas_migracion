<%-- 
    Document   : GuarderiaMascotas
    Created on : 3/03/2011, 12:50:11 PM
    Author     : rurbina
--%>
<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.asistencias.DAOGuarderiaMascota,com.ike.asistencias.to.AsistenciaVeterinaria" errorPage="" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Mascotas</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>
    <body  class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilCalendario.js'></script>

        <%
        String StrclExpediente = "0";
        String StrclUsrApp = "0";
        String StrclPaginaWeb = "0";
        String StrSubservicio = "";

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
        
         if (session.getAttribute("dsSubServicio") != null) {
            StrSubservicio = session.getAttribute("dsSubServicio").toString();
        }    
        
        DAOGuarderiaMascota daogm = null;
        AsistenciaVeterinaria AV = null;

        if (StrclExpediente != null) {
            daogm = new DAOGuarderiaMascota();
            AV = daogm.getAsistenciaVeterinaria(StrclExpediente);
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
        StrclPaginaWeb = "6003";
        session.setAttribute("clPaginaWebP", StrclPaginaWeb);

        MyUtil.InicializaParametrosC(6003, Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "", "")%>

        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='6003'>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="GuarderiaMascotas.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjInput("Nombre de la Mascota", "NombreMascota", AV != null ? AV.getNombreMascota() : "", true, true, 30, 80, "", true, true, 30)%>
        <%=MyUtil.ObjInput("Edad (Años)", "Edad", AV != null ? AV.getEdad() : "", true, true, 210, 80, "", false, false, 10, "")%>
        <%=MyUtil.ObjInput("Peso (Kgs.)", "Peso", AV != null ? AV.getPeso() : "", true, true, 290, 80, "", false, false, 10, "")%>
        <%=MyUtil.ObjInput("Raza", "Raza", AV != null ? AV.getRaza() : "", true, true, 30, 125, "", false, false, 20, "")%>
        <%=MyUtil.ObjComboC("Tipo Mascota", "clTipoMascota", AV != null ? AV.getDsTipoMascota() : "", true, true, 160, 125, "", "Select clTipoMascota, dsTipoMascota From cTipoMascota order by dsTipoMascota ", "", "", 30, true, true)%>
        <%=MyUtil.ObjTextArea("Ubicación (Dirección)", "Direccion", AV != null ? AV.getDireccion() : "", "60", "4", true, true, 30, 170, "", false, false)%>
        <div id='lblHorario' name='lblHorario' style='position:absolute; z-index:20; left:100px; top:248px;'>
            <a class='FTable'><strong>HORARIO (AAAA-MM-DD HH:MM)</strong></a>
        </div>
        <%=MyUtil.ObjInputF("Fecha/Hora Entrada", "FechaEntrada", AV != null ? AV.getFechaEntrada() : "", true, false, 30, 270, "", true, false, 20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInputF("Fecha/Hora Salida", "FechaSalida", AV != null ? AV.getFechaSalida() : "", true, false, 200, 270, "", true, false, 20, 2, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjTextArea("Recomendaciones del Veterinario", "Recomendacion", AV != null ? AV.getRecomendacionVet() : "", "60", "4", true, true, 30, 320, "", false, false)%>
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", AV != null ? AV.getObservaciones() : "", "60", "4", true, true, 30, 400, "", false, false)%>
        <%--<%=MyUtil.DoBlock("Guardería de Mascotas", -100, 30)%>--%>
        <%=MyUtil.DoBlock(StrSubservicio, -100, 30)%>
        
        <%=MyUtil.GeneraScripts()%>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>

        <%
        StrclExpediente = null;
        StrclUsrApp = null;
        StrclPaginaWeb = null;

        daogm = null;
        AV = null;
        %>
    </body>
</html>
