<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%> 
<html>
    <head><title>Medico a Domicilio</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />  
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>

        <%
            com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es", "AR");

            String StrclExpediente = "0";
            String StrclUsrApp = "0";
            String StrclPaginaWeb = "6069";
            String StrdsSubServicio = "";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {%>
        Fuera de Horario
        <%
                StrclExpediente = null;
                StrclUsrApp = null;
                StrclPaginaWeb = null;
                StrdsSubServicio = null;
                return;
            }

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            if (session.getAttribute("dsSubServicio") != null) {
                StrdsSubServicio = session.getAttribute("dsSubServicio").toString();
            }

            StringBuffer StrSql = new StringBuffer();
            StrSql.append("st_TieneAsistenciaExp ").append(StrclExpediente);

            ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
                    if (rs2.next()) { %>
        <% } else { %>
        El expediente no existe
        <%
                rs2.close();
                rs2 = null;
                return;
            }
            StrSql.append("st_getDetalleServicioMedico ").append(StrclExpediente);

            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

        %>
        <script>fnOpenLinks()</script>
        <%            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="AcompananteNocturno.jsp?'>"%> 
        <INPUT id='clParentesco' name='clParentesco' type='hidden' value='5'>
        <% if (rs.next()) {%>
        <script>
            document.all.btnAlta.disabled = true;
        </script>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjInput("Nombre del Paciente", "Paciente", rs.getString("Paciente"), true, true, 30, 80, "", true, true, 60)%>
        <%=MyUtil.ObjInput("Edad", "Edad", rs.getString("Edad"), true, true, 370, 80, "", false, false, 10, "fnRango(document.all.Edad,0,150)")%>
        <!--%=MyUtil.ObjInput("Peso (Kgs.)", "PesoKg", rs.getString("PesoKg"), true, true, 450, 80, "", false, false, 10, "EsNumerico(document.all.PesoKg)")%-->
        <!--%=MyUtil.ObjComboC("Parentesco con N/U", "clParentesco", rs.getString("dsParentesco"), true, true, 530, 80, "", "Select clParentesco, dsParentesco From cParentesco ", "", "", 30, true, true)%-->
        <%=MyUtil.DoBlock("Detalle de " + StrdsSubServicio, -50, 0)%>

        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"), "CP", rs.getString("CP"), true, true, 30, 170, "", false, false, 10)%>
        <!--div class='VTable' style='position:absolute; z-index:25; left:105px; top:180px;'>
            <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaN2();' class='cBtn'></div-->
        <!--%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"), "dsEntFed", rs.getString("dsEntFed"), false, false, 190, 170, "", false, false, 50)%-->
        <!--INPUT id='CodEnt' name='CodEnt' type='hidden' value='<%//=rs.getString("CodEnt")%>'-->
        <!--%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"), "dsMunDel", rs.getString("dsMunDel"), false, false, 30, 210, "", false, false, 50)%-->
        <!--INPUT id='CodMD' name='CodMD' type='hidden' value='<%//=rs.getString("CodMD")%>'-->            


        <%=MyUtil.ObjComboC("Provincia", "CodEnt", rs.getString("dsEntFed"), true, true, 180, 170, "", "select CodEnt, dsEntFed from cEntFed where clpais = 10 order by 2", "fnLlenaMunicipiosCS();", "", 35, true, true)%>
        <%=MyUtil.ObjComboC("Localidad", "CodMD", rs.getString("dsMunDel"), true, true, 30, 210, "", "Select CodMD, dsMunDel from cMunDel where CodEnt='" + rs.getString("CodEnt") + "' order by dsMunDel", "", "", 30, true, true)%>


        <!--%=MyUtil.ObjInput("Colonia", "Colonia", rs.getString("Colonia"), true, true, 300, 210, "", false, false, 50)%-->
        <%=MyUtil.ObjInput("Calle", "Calle", rs.getString("Calle"), true, true, 30, 250, "", false, false, 105)%>
        <%=MyUtil.DoBlock("Ubicación del Paciente", 220, 0)%>

        <%=MyUtil.ObjInput("Padecimiento", "Padecimiento", rs.getString("Padecimiento"), true, true, 30, 340, "", true, true, 50)%> 
        <%=MyUtil.ObjInput("Médico Tratante", "MedicoAtendio", rs.getString("MedicoAtendio"), true, true, 310, 340, "", false, false, 50)%>
        <%=MyUtil.ObjTextArea("Diagnóstico", "DiagnosticoDx", rs.getString("DiagnosticoDx"), "105", "2", true, true, 30, 380, "", false, false)%>
        <%=MyUtil.ObjTextArea("Tratamiento", "TratamientoTx", rs.getString("TratamientoTx"), "105", "2", true, true, 30, 430, "", false, false)%>
        <%=MyUtil.DoBlock("Datos de la Evaluación", 95, 20)%>
        <% } else {%>
        <script>
            document.all.btnCambio.disabled = true;
        </script>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>                                  

        <%=MyUtil.ObjInput("Nombre del Paciente", "Paciente", "", true, true, 30, 80, "", true, true, 60)%>
        <%=MyUtil.ObjInput("Edad", "Edad", "", true, true, 370, 80, "", false, false, 10, "fnRango(document.all.Edad,0,150)")%>
        <!--%=MyUtil.ObjInput("Peso (Kgs.)", "PesoKg", "", true, true, 450, 80, "", false, false, 10, "EsNumerico(document.all.PesoKg)")%-->
        <!--%=MyUtil.ObjComboC("Parentesco con N/U", "clParentesco", "", true, true, 530, 80, "", "Select clParentesco, dsParentesco From cParentesco ", "", "", 30, true, true)%-->
        <%=MyUtil.DoBlock("Detalle de " + StrdsSubServicio, -30, 0)%>

        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"), "CP", "", true, true, 30, 170, "", false, false, 10)%>
        <!--div class='VTable' style='position:absolute; z-index:25; left:105px; top:180px;'>
            <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaN2();' class='cBtn'>
        </div-->
        <!--%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"), "dsEntFed", "", false, false, 190, 170, "", false, false, 50)%-->
        <!--INPUT id='CodEnt' name='CodEnt' type='hidden' value=''-->
        <!--%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"), "dsMunDel", "", false, false, 30, 210, "", false, false, 50)%-->            
        <!--INPUT id='CodMD' name='CodMD' type='hidden' value=''-->
        <%=MyUtil.ObjComboC("Provincia", "CodEnt", "", true, true, 180, 170, "", "select CodEnt, dsEntFed from cEntFed where clpais = 10 order by 2", "fnLlenaMunicipiosCS();", "", 35, true, true)%>
        <%=MyUtil.ObjComboC("Localidad", "CodMD", "", true, true, 30, 210, "", "Select CodMD, dsMunDel from cMunDel where CodEnt=0", "", "", 30, true, true)%>
        <!--%=MyUtil.ObjInput("Colonia", "Colonia", "", true, true, 300, 210, "", false, false, 50)%-->
        <%=MyUtil.ObjInput("Calle", "Calle", "", true, true, 30, 250, "", false, false, 105)%>                       
        <%=MyUtil.DoBlock("Ubicación del Paciente", 200, 0)%>   

        <%=MyUtil.ObjInput("Padecimiento", "Padecimiento", "", true, true, 30, 340, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Médico Tratante", "MedicoAtendio", "", true, true, 310, 340, "", false, false, 50)%> 
        <%=MyUtil.ObjTextArea("Diagnóstico", "DiagnosticoDx", "", "105", "2", true, true, 30, 380, "", false, false)%>
        <%=MyUtil.ObjTextArea("Tratamiento", "TratamientoTx", "", "105", "2", true, true, 30, 430, "", false, false)%>
        <%=MyUtil.DoBlock("Datos de la Evaluación", 95, 20)%>
        <% }%>

        <%=MyUtil.GeneraScripts()%>
        <%
            rs2.close();
            rs.close();
            rs2 = null;
            rs = null;
            StrSql = null;
            StrclExpediente = null;
            StrclUsrApp = null;
            StrclPaginaWeb = null;

        %>
        <script>
            document.all.Paciente.maxLength = 50;
            document.all.Edad.maxLength = 3;
            //document.all.PesoKg.maxLength = 7;
            document.all.Calle.maxLength = 80;
            document.all.MedicoAtendio.maxLength = 50;
            document.all.Padecimiento.maxLength = 50;
            document.all.DiagnosticoDx.maxLength = 200;
            document.all.TratamientoTx.maxLength = 200;
        </script>
    </body>
</html>