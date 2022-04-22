<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head><title>JSP Page</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head> 
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilDireccion.js' ></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <%
            String StrclExpediente = "0";
            String StrclUsrApp = "0";
            String StrclPaginaWeb = "0";
            String StrFecha = "";
            String strclSupervision = "0";
            String StrclQuejaxSupervision = "0";
            String StrclQuejaxSupervisionD = "0";
            String StrclQuejaxSupervisionG = "0";
            String strStatus = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {%>
                Fuera de Horario
                <% return;
            }

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            if (session.getAttribute("clSupervision") != null) {
                strclSupervision = session.getAttribute("clSupervision").toString();
            }

            StringBuffer StrSql = new StringBuffer();

            StrSql.append("Select convert(varchar(16),getdate(),120) fechaEt ");
            ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs2.next()) {
                StrFecha = rs2.getString("fechaEt");
            }

        %>  
        <INPUT id='clExpediente2' name='clExpediente2' type='hidden' value='<%=StrclExpediente%>'> 
        <%
            if (request.getParameter("clQuejaxSupervision") != null) {
                StrclQuejaxSupervisionG = request.getParameter("clQuejaxSupervision").toString();
            }
            StrSql.append("Select coalesce(clQuejaxSupervision,'') clQuejaxSupervision from DeficienciasxExpediente where clExpediente=").append(StrclExpediente).append(" and clQuejaxSupervision=").append(StrclQuejaxSupervisionG);
            ResultSet rs4 = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs4.next()) {
                StrclQuejaxSupervisionD = rs4.getString("clQuejaxSupervision");
            } else {
                StrclQuejaxSupervisionD = null;
            }
        %>
        <script>
            fnOpenLinks();
        </script>
        <%            
            StrSql.append("st_getQuejaxSupervision ").append(StrclQuejaxSupervisionG);

            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            StrclPaginaWeb = "336";
            MyUtil.InicializaParametrosC(336, Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);%> 

        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "fnLlenaQueja();", "fnRequiere();")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1) + "QuejasxSupervision.jsp?"%>'>       
        <%
            StrSql.append("Select clEstatusQueja from QuejasxSupervision where clQuejaxSupervision=").append(StrclQuejaxSupervision);

            ResultSet rs3 = UtileriasBDF.rsSQLNP(StrSql.toString());
            if (rs3.next()) {
                strStatus = rs3.getString("clEstatusQueja");
                if (strStatus.equalsIgnoreCase("4") || strStatus.equalsIgnoreCase("5") || strStatus.equalsIgnoreCase("6")) { %>
                    <script>
                        document.all.btnAlta.disabled = true;
                        document.all.btnCambio.disabled = true;
                        document.all.btnElimina.disabled = true;
                    </script>
                <% } %>    
            <% } %>    
        <% if (rs.next()) { %>
            <% if (StrclQuejaxSupervisionG != null && StrclQuejaxSupervisionD == null && rs.getString("EsQueja").equalsIgnoreCase("1")) {
                    out.println("<script>  alert ('Necesita Ingresar una Deficiencia a la Queja'); </script>");
                    StrclQuejaxSupervision = StrclQuejaxSupervisionG;
                    out.println("<script> location.href='../Supervision/DetalleMarcaDeficiencias.jsp?clQuejaxSupervision=" + StrclQuejaxSupervision + "';</script>");
                } else {
                    StrclQuejaxSupervision = StrclQuejaxSupervisionG;
                } %>
            <INPUT id='clQuejaxSupervision' name='clQuejaxSupervision' type='hidden' value='<%=StrclQuejaxSupervision%>'>
            <INPUT id='clSupervision' name='clSupervision' type='hidden' value='<%=strclSupervision%>'>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%= StrclExpediente%>'>
            <INPUT id='clUsrAppIngresa' name='clUsrAppIngresa' type='hidden' value='<%= StrclUsrApp%>'>
            <INPUT id='StrFecha' name='StrFecha' type='hidden' value='<%= StrFecha%>'>

            <%=MyUtil.ObjComboC("Queja", "clQueja", rs.getString("dsQueja"), true, false, 30, 130, "", "st_ComboQuejasActivas", "", "", 140, true, true)%>
            <%=MyUtil.ObjComboC("Estatus  de la Queja", "clEstatusQueja", rs.getString("dsEstatusQueja"), false, true, 300, 130, "1", "Select clEstatusQueja,dsEstatusQueja from cEstatusQueja", "fnFechasolucion(); fnhabilita();", "", 140, true, true)%>
            <%=MyUtil.ObjChkBox("Queja o Inconformidad", "EsQueja", rs.getString("EsQueja"), true, true, 550, 125, "0", "Queja", "Inconformidad", "")%>
            <%=MyUtil.ObjComboC("Se Quej�", "clQuejo", rs.getString("dsQuejo"), true, true, 500, 180, "", "select clQuejo, dsQuejo from cSeQuejo where Activo = 1", "", "", 100, false, false)%>            
            <%=MyUtil.ObjTextArea("Observaciones de Supervisor", "ObservacionesSup", rs.getString("ObservacionesSup"), "80", "3", true, true, 30, 180, "", true, true)%>
            <%=MyUtil.ObjTextArea("Observaciones de Area", "ObservacionesArea", rs.getString("ObservacionesArea"), "80", "3", false, true, 30, 250, "", false, false)%>
            <%=MyUtil.ObjTextArea("Solucion", "Solucion", rs.getString("Solucion"), "80", "3", false, true, 30, 320, "", false, false)%>
            <%=MyUtil.ObjComboC("Tipo de solucion", "clTipoSolQueja", rs.getString("dsTipoSolQueja"), true, true, 500, 320, "", "Select clTipoSolQueja,dsTipoSolQueja from cTipoSolQueja", "", "", 100, false, false)%>
            <%=MyUtil.ObjInput("Fecha de Ingreso<BR>AAAA/MM/DD HH:MM", "FechaIngresoVTR", rs.getString("FechaIngreso"), false, false, 30, 390, rs2.getString("fechaEt"), true, true, 22)%>
            <%=MyUtil.ObjInput("Fecha de Solucion<BR>AAAA/MM/DD HH:MM", "FechaSolucion", rs.getString("FechaSolucion"), false, false, 300, 390, "", false, false, 22, "")%>
            <%=MyUtil.DoBlock("Modulo de Quejas", -20, 25)%> 
        <% } else { %>
            <script>document.all.btnElimina.disabled = true;</script>
            <INPUT id='clQuejaxSupervision' name='clQuejaxSupervision' type='hidden' value='<%=StrclQuejaxSupervision%>'>
            <INPUT id='clSupervision' name='clSupervision' type='hidden' value='<%= strclSupervision%>'>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%= StrclExpediente%>'>
            <INPUT id='clUsrAppIngresa' name='clUsrAppIngresa' type='hidden' value='<%= StrclUsrApp%>'>
            <%=MyUtil.ObjComboC("Queja", "clQueja", "", true, false, 30, 130, "", "st_ComboQuejasActivas", "", "", 140, true, true)%>
            <%=MyUtil.ObjComboC("Estatus  de la Queja", "clEstatusQueja", "", false, true, 300, 130, "1", "Select clEstatusQueja,dsEstatusQueja from cEstatusQueja", "", "", 140, true, true)%>
            <%=MyUtil.ObjChkBox("Queja o Inconformidad", "EsQueja", "", true, true, 550, 125, "0", "Queja", "Inconformidad", "")%>         
            <%=MyUtil.ObjComboC("Se Quej�", "clQuejo", "", true, true, 500, 180, "", "select clQuejo, dsQuejo from cSeQuejo where Activo = 1", "", "", 100, false, false)%> 
            <%=MyUtil.ObjTextArea("Observaciones de Supervisor", "ObservacionesSup", "", "80", "3", true, false, 30, 180, "", true, true)%>
            <%=MyUtil.ObjTextArea("Observaciones de Area", "ObservacionesArea", "", "80", "3", false, true, 30, 250, "", false, true)%>
            <%=MyUtil.ObjTextArea("Solucion", "Solucion", "", "80", "3", false, true, 30, 320, "", false, true)%>
            <%=MyUtil.ObjComboC("Tipo de solucion", "clTipoSolQueja", "", true, true, 500, 320, "", "Select clTipoSolQueja,dsTipoSolQueja from cTipoSolQueja", "", "", 100, false, false)%>
            <%=MyUtil.ObjInput("Fecha de Ingreso", "FechaIngresoVTR", "", false, false, 30, 390, StrFecha, true, true, 22)%>
            <%=MyUtil.ObjInput("Fecha de Soucion<BR>AAAA/MM/DD HH:MM", "FechaSolucion", "", false, false, 300, 390, "", false, false, 22, "")%>
            <%=MyUtil.DoBlock("Modulo de Quejas", -20, 25)%>
			<%-- <%=MyUtil.DoBlock("Modulo de Quejas", 150, 25)%> --%>
        <% } %>

        <%=MyUtil.GeneraScripts()%>

        <input name='FechaSolucionMsk' id='FechaSiniestroMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        <script>      
            function fnFechasolucion()            {
                if (document.all.clEstatusQueja.value == 4 || document.all.clEstatusQueja.value == 5 || document.all.clEstatusQueja.value == 6) {
                    document.all.FechaSolucion.value = document.all.StrFecha.value;
                }
                else {
                    document.all.FechaSolucion.value = "";
                }
            }

            function fnLlenaQueja() {
                var strConsulta = "sp_GetQueja '" + document.all.clExpediente2.value + "'";
                var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                document.all.clQueja.value = '';
                pstrCadena = pstrCadena + "&strName=clQuejaC";
                fnOptionxDefault('clQuejaC', pstrCadena);
            }

            function fnhabilita() {
                if (document.all.clEstatusQueja.value == 1 || document.all.clEstatusQueja.value == 2 || document.all.clEstatusQueja.value == 3) {
                    document.all.Solucion.disabled = true;
                }
                else {
                    document.all.Solucion.disabled = false;
                }
            }

            function fnRequiere() {
                if (document.all.Action.value != 1) {
                    if (document.all.clEstatusQueja.value == 1 || document.all.clEstatusQueja.value == 2 || document.all.clEstatusQueja.value == 3) {
                        if (document.all.ObservacionesArea.value == "") {
                            msgVal = msgVal + ',' + document.all.ObservacionesArea.name + '. Observaciones Area';
                            document.all.btnGuarda.disabled = false;
                            document.all.btnCancela.disabled = false;
                        }
                    }
                    else {
                        if (document.all.clEstatusQueja.value == 4 || document.all.clEstatusQueja.value == 5 || document.all.clEstatusQueja.value == 6) {
                            if (document.all.ObservacionesSup.value == "") {
                                msgVal = msgVal + ', ' + document.all.ObservacionesSup.name;
                            }
                            if (document.all.ObservacionesArea.value == "") {
                                msgVal = msgVal + ', ' + document.all.ObservacionesArea.name;
                            }
                            if (document.all.Solucion.value == "") {
                                msgVal = msgVal + ', ' + document.all.Solucion.name;
                            }
                        }
                    }
                }

                if (document.all.clTipoSolQueja.value == "" && (document.all.clEstatusQueja.value == 4 || document.all.clEstatusQueja.value == 6)) {
                    msgVal = msgVal + ', Tipo de Solucion';
                    document.all.btnGuarda.disabled = false;
                    document.all.btnCancela.disabled = false;
                }
            }
        </script>
    </body>
</html>