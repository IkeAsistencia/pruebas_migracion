<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>JSP Page</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>

        <%
            String StrclDeficienciaxExpediente = "0";
            String StrclUsrApp = "0";
            String StrclEstatusDef = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {%>
                Fuera de Horario
                <%return;
            }

            if (request.getParameter("clDeficienciaxExpediente") != null) {
                StrclDeficienciaxExpediente = request.getParameter("clDeficienciaxExpediente");
            }

            if (request.getParameter("clEstatusDef") != null) {
                StrclEstatusDef = request.getParameter("clEstatusDef");
            }

            StringBuffer StrSql = new StringBuffer();

            StrSql.append("st_getDeficineicaxExpediente ").append(StrclDeficienciaxExpediente);

            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());

            String StrclPaginaWeb = "307";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
           MyUtil.InicializaParametrosC(307, Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina%>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "", "")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1) + "DetalleResponDeficiencias.jsp?"%>'>
        <% if (Integer.parseInt(StrclEstatusDef) != 1) {    //Valida si esta concluido%>
            <script>
                document.all.btnAlta.disabled = true;
                document.all.btnCambio.disabled = true;
                document.all.btnElimina.disabled = true;
            </script>
        <% }

       if (rs.next()) {%>
            <INPUT id='clDeficienciaxExpediente' name='clDeficienciaxExpediente' type='hidden' value='<%=StrclDeficienciaxExpediente%>'><br><br><br><br>
            <INPUT id='clUsrAppJust' name='clUsrAppJust' type='hidden' value='<%= StrclUsrApp%>'><br><br><br><br>
            <INPUT id='clTipoDeficienciaVTR' name='clTipoDeficienciaVTR' type='hidden' value='<%=rs.getString("clTipoDeficiencia")%>'><br><br><br><br>
            <%=MyUtil.ObjInput("Area", "Area", rs.getString("dsAreaDefiencia"), false, false, 30, 110, "", false, false, 30)%>
            <%=MyUtil.ObjInput("Coordinador con Deficiencia", "Usuario", rs.getString("UsrDeficiencia"), false, false, 280, 110, "", false, false, 50)%>
            <%=MyUtil.ObjInput("Proveedor con Deficiencia", "Proveedor", rs.getString("Proveedor"), false, false, 280, 110, "", false, false, 50)%>
            <%=MyUtil.ObjInput("Deficiencia", "Deficiencia", rs.getString("dsDeficiencia"), false, false, 30, 150, "", false, false, 100)%>
            <%=MyUtil.ObjTextArea("Observaciones del Supervisor", "ObservacionesSupVTR", rs.getString("ObservacionesSup"), "100", "5", false, false, 30, 190, "", false, false)%>
            <%=MyUtil.DoBlock("Detalle de Respuesta de Deficiencias", 100, 40)%>                          

            <%=MyUtil.ObjComboC("Estatus Deficiencia", "clEstatusDef", rs.getString("dsEstatusDef"), false, true, 30, 320, "1", "SELECT clEstatusDef,dsEstatusDef FROM CESTATUSDEF", "fnCambioEst()", "", 30, false, true)%>                       
            <%=MyUtil.ObjChkBox("", "Aceptada", rs.getString("Aceptada"), false, false, 250, 320, "", "ACEPTADA", "NO ACEPTADA", "fnCheck()")%> 
            <%=MyUtil.ObjTextArea("Observaciones de la Justificación", "ObservacionesResp", rs.getString("ObservacionesResp"), "100", "5", false, false, 30, 360, "", false, false)%>
            <%=MyUtil.DoBlock("Justificación", 180, 40)%>
            
            <%=MyUtil.ObjComboC("Estatus Deficiencia", "clEstatusDef1", rs.getString("dsEstatusDef"), false, false, 30, 500, "1", "SELECT clEstatusDef,dsEstatusDef FROM CESTATUSDEF", "fnCambioEst()", "", 50, false, true)%>
            <%=MyUtil.ObjChkBox("", "Asentada", rs.getString("Asentada"), false, false, 250, 500, "", "ASENTADA", "NO ASENTADA", "")%>
            <%=MyUtil.ObjTextArea("Observaciones de la Conclusión", "ObservacionesConclu", rs.getString("ObservacionesConclu"), "100", "5", false, false, 30, 540, "", false, false)%>
            <%=MyUtil.DoBlock("Conclusión", 180, 40)%>
            
            
        <%}%>

        <%=MyUtil.GeneraScripts()%>
        <% StrSql = null;
            rs.close();
            rs = null;
            StrclDeficienciaxExpediente = null;
            StrclUsrApp = null;
            StrclEstatusDef = null;
        %>       
        <script>

            //Oculta las campos proveedor y usuario
            var Tipo = eval(document.all.clTipoDeficienciaVTR.value);
            document.all.D4.style.visibility = 'hidden';
            document.all.D5.style.visibility = 'hidden';
            switch (Tipo) {
                case 1:    //Coordinador
                    document.all.D4.style.visibility = 'visible';
                    document.all.D5.style.visibility = 'hidden';
                    break;
                case 2:      //Proveedor
                    document.all.D4.style.visibility = 'hidden';
                    document.all.D5.style.visibility = 'visible';
                    break;

            }

            function fnCheck() {
                if (document.all.Aceptada.value == 1) {
                    document.all.ObservacionesResp.readOnly = true;
                    document.all.ObservacionesResp.value = '';
                }
                else {
                    document.all.ObservacionesResp.readOnly = false;
                }
            }

            function fnCambioEst() {
                var Tipo = eval(document.all.clEstatusDef.value);
                switch (Tipo) {
                    case 1: //Asignada
                        document.all.ObservacionesResp.value = '';
                        document.all.Aceptada.value = 0;
                        document.all.AceptadaC.disabled = true;
                        document.all.AceptadaC.checked = false;
                        document.all.ObservacionesResp.readOnly = true;
                        break;
                    case 2: //Justificada
                        document.all.ObservacionesResp.readOnly = false;
                        document.all.AceptadaC.disabled = false;
                        break;
                    case 3: //Concluido
                        document.all.clEstatusDefC.value = 1;
                        document.all.ObservacionesResp.value = '';
                        document.all.Aceptada.value = 0;
                        document.all.AceptadaC.disabled = true;
                        document.all.AceptadaC.checked = false;
                        document.all.ObservacionesResp.readOnly = true;
                        break;
                }
            }
        </script>
    </body>
</html>