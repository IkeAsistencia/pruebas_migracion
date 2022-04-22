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
                <% return;
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
            StrSql.delete(0, StrSql.length());

            String StrclPaginaWeb = "301";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

           MyUtil.InicializaParametrosC(301, Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina%>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "", "")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1) + "DetalleSeguiDeficiencias.jsp?"%>'>

        <%       
        if (Integer.parseInt(StrclEstatusDef) == 3) {    //Valida si esta concluido

            StrSql.append("st_getPermisoDeficiencia ").append(StrclUsrApp);

            ResultSet rsPagDet = UtileriasBDF.rsSQLNP(StrSql.toString());
            if (rsPagDet.next()) {
                if (rsPagDet.getInt("Permiso") == 0) {  //valida si tiene permisos de cambiar deficiencia justificadas o concluidas%>
                    <script>
                        document.all.btnAlta.disabled = true;
                        document.all.btnCambio.disabled = true;
                        document.all.btnElimina.disabled = true;
                    </script>
            <% }
                rsPagDet.close();
                rsPagDet = null;
            }

        }
            
        if (rs.next()) {%>
            <INPUT id='clDeficienciaxExpediente' name='clDeficienciaxExpediente' type='hidden' value='<%= StrclDeficienciaxExpediente%>'><br><br><br><br>
            <INPUT id='clUsrAppConcluyo' name='clUsrAppConcluyo' type='hidden' value='<%= StrclUsrApp%>'><br><br><br><br>
            <INPUT id='clTipoDeficienciaVTR' name='clTipoDeficienciaVTR' type='hidden' value='<%=rs.getString("clTipoDeficiencia")%>'><br><br><br><br>
            <%=MyUtil.ObjInput("Area", "Area", rs.getString("dsAreaDefiencia"), false, false, 30, 110, "", false, false, 30)%>
            <%=MyUtil.ObjInput("Coordinador con Deficiencia", "Usuario", rs.getString("UsrDeficiencia"), false, false, 280, 110, "", false, false, 50)%>
            <%=MyUtil.ObjInput("Proveedor con Deficiencia", "Proveedor", rs.getString("Proveedor"), false, false, 280, 110, "", false, false, 50)%>
            <%=MyUtil.ObjInput("Deficiencia", "Deficiencia", rs.getString("dsDeficiencia"), false, false, 30, 150, "", false, false, 100)%>
            <%=MyUtil.ObjChkBox("", "AceptadaVTR", rs.getString("Aceptada"), false, false, 30, 190, "", "ACEPTADA", "NO ACEPTADA", "fnCheck()")%>
            <%=MyUtil.ObjTextArea("Observaciones del Supervisor", "ObservacionesSupVTR", rs.getString("ObservacionesSup"), "100", "5", false, false, 30, 230, "", false, false)%>
            <%=MyUtil.ObjTextArea("Observaciones del Coordinador", "ObservacionesRespVTR", rs.getString("ObservacionesResp"), "100", "5", false, false, 30, 310, "", false, false)%>
            <%=MyUtil.DoBlock("Detalle de Respuesta de Deficiencias", 100, 40)%>

            <%=MyUtil.ObjComboC("Estatus Deficiencia", "clEstatusDef", rs.getString("dsEstatusDef"), false, true, 30, 440, "1", "SELECT clEstatusDef,dsEstatusDef FROM CESTATUSDEF", "fnCambioEst()", "", 50, false, true)%>
            <%=MyUtil.ObjChkBox("", "Asentada", rs.getString("Asentada"), false, false, 250, 440, "", "ASENTADA", "NO ASENTADA", "")%>
            <%=MyUtil.ObjTextArea("Observaciones del Conclusión", "ObservacionesConclu", rs.getString("ObservacionesConclu"), "100", "5", false, true, 30, 480, "", false, false)%>
            <%=MyUtil.DoBlock("Conclusión", 180, 40)%>
        <%} else {%>
            <INPUT id='clDeficienciaxExpediente' name='clDeficienciaxExpediente' type='hidden' value='<%=StrclDeficienciaxExpediente%>'><br><br><br><br>
            <INPUT id='clUsrAppConcluyo' name='clUsrAppConcluyo' type='hidden' value='<%=StrclUsrApp%>'><br><br><br><br>
            <INPUT id='clTipoDeficienciaVTR' name='clTipoDeficienciaVTR' type='hidden' value=''><br><br><br><br>
            <%=MyUtil.ObjInput("Area", "Area", "", false, false, 30, 110, "", false, false, 30)%>
            <%=MyUtil.ObjInput("Coordinador con Deficiencia", "Usuario", "", false, false, 280, 110, "", false, false, 50)%>
            <%=MyUtil.ObjInput("Proveedor con Deficiencia", "Proveedor", "", false, false, 280, 110, "", false, false, 50)%>
            <%=MyUtil.ObjInput("Deficiencia", "Deficiencia", "", false, false, 30, 150, "", false, false, 100)%>
            <%=MyUtil.ObjChkBox("", "AceptadaVTR", "", false, false, 30, 190, "", "ACEPTADA", "NO ACEPTADA", "fnCheck()")%> 
            <%=MyUtil.ObjTextArea("Observaciones del Supervisor", "ObservacionesSupVTR", "", "100", "5", false, false, 30, 230, "", false, false)%>
            <%=MyUtil.ObjTextArea("Observaciones del Coordinador", "ObservacionesRespVTR", "", "100", "5", false, false, 30, 310, "", false, false)%>
            <%=MyUtil.DoBlock("Detalle de Respuesta de Deficiencias", 100, 40)%>                          

            <%=MyUtil.ObjComboC("Estatus Deficiencia", "clEstatusDef", "", false, true, 30, 440, "1", "SELECT clEstatusDef,dsEstatusDef FROM CESTATUSDEF", "fnCambioEst()", "", 50, false, true)%>                       
            <%=MyUtil.ObjChkBox("", "Asentada", "", false, false, 250, 440, "", "ASENTADA", "NO ASENTADA", "")%> 
            <%=MyUtil.ObjTextArea("Observaciones del Conclusión", "ObservacionesConclu", "", "100", "5", false, true, 30, 480, "", false, false)%>
            <%=MyUtil.DoBlock("Conclusión", 180, 40)%>   
        <% }
            rs.close();
            rs = null;
            StrSql = null;
            StrclDeficienciaxExpediente = null;
            StrclUsrApp = null;
            StrclEstatusDef = null;
        %>


        <%=MyUtil.DoBlock("Detalle de Marca Deficiencias", 450, 0)%>                          
        <%=MyUtil.GeneraScripts()%>

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


            function fnCambioEst() {
                var Tipo = eval(document.all.clEstatusDef.value);
                switch (Tipo) {
                    case 1: //Asignada
                        document.all.clEstatusDefC.value = 3;
                        document.all.clEstatusDef.value = 3;
                        document.all.Asentada.value = 0;
                        document.all.AsentadaC.disabled = false;
                        document.all.AsentadaC.checked = false;
                        //document.all.ObservacionesSup.readOnly=false;
                        break;
                    case 2: //Justificada
                        document.all.clEstatusDefC.value = 3;
                        document.all.clEstatusDef.value = 3;
                        document.all.Asentada.value = 0;
                        document.all.AsentadaC.disabled = false;
                        document.all.AsentadaC.checked = false;
                        //document.all.ObservacionesSup.readOnly=false;
                        break;
                    case 3: //Concluido
                        document.all.Asentada.value = 0;
                        document.all.AsentadaC.disabled = false;
                        document.all.AsentadaC.checked = false;
                        //document.all.ObservacionesSup.readOnly=false;
                        break;
                }

            }
        </script>


    </body>
</html>
