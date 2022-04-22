<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.asistencias.DAOReferenciaAdiestramiento,com.ike.asistencias.to.ReferenciaAdiestramiento" errorPage="" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Guardería de Mascotas</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>
    <body  class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilCalendario.js'></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>

        <%
            String StrclExpediente = "0";
            String StrclUsrApp = "0";
            String StrclPaginaWeb = "6077";
            String strCodEnt = "";

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

            DAOReferenciaAdiestramiento daoRA = null;
            ReferenciaAdiestramiento RA = null;

            if (StrclExpediente != null) {
                daoRA = new DAOReferenciaAdiestramiento();
                RA = daoRA.getReferenciaAdiestramiento(StrclExpediente);
                
                strCodEnt = RA != null ? RA.getCodEnt(): "";
            } else {
        %> El expediente no existe <%
                StrclExpediente = null;
                StrclUsrApp = null;
                StrclPaginaWeb = null;

                return;
            }

        %>
        <script>fnOpenLinks()</script>

        <%            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp));%>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "", "")%>

        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='<%=StrclPaginaWeb%>'>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="ReferenciaAdiestramiento.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjInput("Teléfono Contacto", "Telefono", RA != null ? RA.getTelefono(): "", true, true, 30, 80, "", true, false, 25, "fnValidaNumero();")%>
        <%=MyUtil.ObjInput("E-mail", "Correo", RA != null ? RA.getCorreo(): "", true, true, 200, 80, "", false, false, 45, "fnValidaCorreo();")%>
        <%=MyUtil.ObjComboC("Provincia", "CodEnt", RA != null ? RA.getDsEntFed(): "", true, true, 470, 80, "", "select codent,dsentfed from cEntFed where clpais = 10 order by dsEntFed", "fnLlenaMunicipiosCS();", "", 30, true, false)%>
        <%=MyUtil.ObjTextArea("Link de Web o Fuente Proporcionada a N/U", "LigaPro", RA != null ? RA.getLigaPro(): "", "80", "4", true, true, 30, 120, "", false, false)%>
        <%=MyUtil.ObjComboC("Localidad", "CodMD", RA != null ? RA.getDsMunDel(): "", true, true, 470, 120, "", "Select CodMD, dsMunDel from cMunDel where CodEnt='" + strCodEnt + "' order by dsMunDel", "", "", 35, false, false)%>
        <!--%=MyUtil.ObjComboC("Localidad", "CodMD", RA != null ? RA.getDsMunDel(): "", true, true, 470, 120, "", "Select CodMD, dsMunDel from cMunDel", "", "", 35, false, false)%-->
        <%=MyUtil.ObjTextArea("Información Solicitada por N/U", "InformacionSol", RA != null ? RA.getInformacionSol(): "", "80", "4", true, true, 30, 200, "", true, false)%>
        <%=MyUtil.ObjTextArea("Información Proporcionada a N/U", "InformacionPro", RA != null ? RA.getInformacionPro(): "", "80", "4", true, true, 470, 200, "", true, false)%>
        <%=MyUtil.DoBlock("Referenciación y Orientación en Adiestramiento", 250, 30)%>

        <%=MyUtil.ObjInput("Nombre", "Nombre", RA != null ? RA.getNombre(): "", true, true, 30, 320, "", true, false, 25, "")%>
        <%=MyUtil.ObjComboC("Tipo de Mascota", "clMascotaRef", RA != null ? RA.getDsMascotaRef(): "", true, true, 210, 320, "", "select * from cRMascota ", "", "", 10, false, false)%>
        <%=MyUtil.ObjComboC("Tipo de Recreación", "clRTipoRecreacion", RA != null ? RA.getDsRTipoRecreacion(): "", true, true, 400, 320, "", "select * from cRTipoRecreacion ", "", "", 10, false, false)%>
        <%=MyUtil.ObjComboC("Sexo", "clSexo", RA != null ? RA.getDsSexo(): "", true, true, 30, 360, "", "select * from cSexo ", "", "", 10, false, false)%>
        <%=MyUtil.ObjInput("Peso (kg)", "Peso", RA != null ? RA.getPeso(): "", true, true, 210, 360, "", false, false, 30, "")%>
        <%=MyUtil.ObjInput("Edad", "Edad", RA != null ? RA.getEdad(): "", true, true, 400, 360, "", false, false, 30, "")%>
        <%=MyUtil.DoBlock("Información Adicional", 0, 0)%>

        <%=MyUtil.GeneraScripts()%>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>

        <%
            StrclExpediente = null;
            StrclUsrApp = null;
            StrclPaginaWeb = null;

            daoRA = null;
            RA = null;
        %>
    </body>
</html>
