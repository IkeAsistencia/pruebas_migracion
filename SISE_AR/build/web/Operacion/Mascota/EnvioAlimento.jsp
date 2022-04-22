<%@ page import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,com.ike.asistencias.DAOEnvioAlimento,com.ike.asistencias.to.EnvioAlimento" errorPage="" %>
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
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <!--div class='VTable' style='position:absolute; z-index:25; left:400px; top:15px;'><p align="center"><font color="navy" face="Arial" size="3" ><b><i>Envio Alimento</i></b></font><br></p></div-->
        <%
            String StrclExpediente = "0";
            String StrclUsrApp = "0";
            String StrclPaginaWeb = "6078";
            String StrCodEnt = "";

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

            DAOEnvioAlimento daoea = null;
            EnvioAlimento EA = null;

            if (StrclExpediente != null) {
                daoea = new DAOEnvioAlimento();
                EA = daoea.getEnvioAlimento(StrclExpediente);

                StrCodEnt = EA != null ? EA.getCodEnt() : "";
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

        <INPUT id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='6078'>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="EnvioAlimento.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjInput("Nombre de la Mascota", "NombreMascota", EA != null ? EA.getNombreMascota() : "", true, true, 30, 80, "", true, true, 30)%>
        <%=MyUtil.ObjInput("Edad", "Edad", EA != null ? EA.getEdad() : "", true, true, 210, 80, "", true, true, 10, "")%>
        <%=MyUtil.ObjComboC("Tamaño", "clTamano", EA != null ? EA.getDsTamano() : "", true, true, 290, 80, "", "select clTamano, dsTamano from cTamano order by 1", "", "", 30, true, true)%>
        <%=MyUtil.ObjTextArea("Observaciones", "Observaciones", EA != null ? EA.getObservaciones() : "", "62", "4", true, true, 30, 120, "", false, false)%>
        <%=MyUtil.DoBlock("DATOS MASCOTA", -20, 30)%>

        <%=MyUtil.ObjComboC("Provincia", "CodEnt", EA != null ? EA.getDsEntFed() : "", true, true, 30, 240, "", "select codent,dsentfed from cEntFed where clpais = 10 order by dsEntFed", "fnLlenaMunicipiosCS()", "", 30, true, true)%>
        <%=MyUtil.ObjComboC("Localidad", "CodMD", EA != null ? EA.getDsMunDel() : "", true, true, 30, 280, "", "Select CodMD, dsMunDel from cMunDel where CodEnt='" + StrCodEnt + "' order by dsMunDel", "", "", 35, true, true)%>
        <%=MyUtil.ObjInput("DIRECCIÓN", "Direccion", EA != null ? EA.getDireccion() : "", true, true, 30, 320, "", true, true, 30)%>
        <%=MyUtil.ObjInput("Referencias", "Referencias", EA != null ? EA.getReferencias() : "", true, true, 280, 320, "", false, false, 30)%>
        <%=MyUtil.DoBlock("DOMICILIO", 0, 0)%>

        <%=MyUtil.ObjInput("Costo", "Costo", EA != null ? EA.getCosto() : "", true, true, 30, 410, "", true, true, 10, "")%>
        <%=MyUtil.ObjInput("Costo Final", "CostoFinal", EA != null ? EA.getCostoFinal() : "", true, true, 150, 410, "", true, true, 10, "")%>
        <%=MyUtil.DoBlock("COTIZACIÓN", 0, 0)%>

        <%=MyUtil.ObjInput("Nombre", "Nombre", EA != null ? EA.getNombre() : "", true, true, 30, 500, "", true, true, 50)%>
        <%=MyUtil.ObjInput("TELÉFONO", "Telefono", EA != null ? EA.getTelefono() : "", true, true, 320, 500, "", true, true, 15, "")%>
        <%=MyUtil.ObjInput("VEHÍCULO", "Vehiculo", EA != null ? EA.getVehiculo() : "", true, true, 30, 540, "", false, false, 60, "")%>
        <%=MyUtil.ObjInput("No. MÓVIL", "NoMovil", EA != null ? EA.getNoMovil() : "", true, true, 30, 580, "", false, false, 20, "")%>
        <%=MyUtil.ObjInput("Patente", "Patente", EA != null ? EA.getPatente() : "", true, true, 290, 580, "", false, false, 20, "")%>
        <%=MyUtil.DoBlock("DATOS DELIVERY", 0, 0)%>

        <%=MyUtil.GeneraScripts()%>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>

        <%
            StrclExpediente = null;
            StrclUsrApp = null;
            StrclPaginaWeb = null;

            daoea = null;
            EA = null;
        %>
    </body>
</html>
