<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>Ambulancia</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        
        <script src='../../Utilerias/Util.js'></script>
        <script src='../../Utilerias/UtilDireccion.js'></script>
        
        <%
            com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es", "AR");

            String StrclUsrApp = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
                StrclUsrApp = null;
                return;
            }

            String StrclExpediente = "0";
            String StrclPaginaWeb = "0";
            String StrDescripCall = "";
            String StrCP = "";

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            StringBuffer StrSql = new StringBuffer();
            StrSql.append(" Select E.TieneAsistencia ");
            StrSql.append(" From Expediente E");
            StrSql.append(" Where E.clExpediente=").append(StrclExpediente);

            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs.next()) {
                rs.close();
                rs = null;
            } else {
        %>El expediente no existe<%
                rs.close();
                rs = null;

                StrclUsrApp = null;
                StrclExpediente = null;
                StrclPaginaWeb = null;
                StrDescripCall = null;
                StrCP = null;
                StrSql = null;
                return;
            }

            StrSql.append("Select A.clExpediente,coalesce(A.Paciente,'') as Paciente, coalesce(A.Edad, 0) Edad, coalesce(A.PesoKg, 0) PesoKg, ");
            StrSql.append(" coalesce(P.dsParentesco,'') as dsParentesco,  ");
            StrSql.append(" coalesce(L.dsTipoLugarTraslado,'') as dsTipoLugarTraslado, ");
            StrSql.append(" coalesce(TA.dsTipoAmbulancia,'') as dsTipoAmbulancia,  ");
            StrSql.append(" coalesce(A.CP,'') CP,  ");
            StrSql.append(" coalesce(E.dsEntFed,'') dsEntFed, ");
            StrSql.append(" coalesce(A.CodEnt,'') CodEnt, ");
            StrSql.append(" coalesce(M.dsMunDel,'') dsMunDel, ");
            StrSql.append(" coalesce(A.CodMD,'') CodMD, ");
            StrSql.append(" coalesce(A.Colonia,'') Colonia, ");
            StrSql.append(" coalesce(A.Calle,'') Calle,  ");
            StrSql.append(" coalesce(A.Referencias,'') Referencias, ");
            StrSql.append(" coalesce(A.Padecimiento,'') Padecimiento, ");
            StrSql.append(" coalesce(A.MedicoRecibe,'') MedicoRecibe, ");
            StrSql.append(" coalesce(A.TA,'') TA, coalesce(A.FC,'') FC, coalesce(A.FR,'') FR, ");
            StrSql.append(" coalesce(A.Glasgow,'') Glasgow, coalesce(A.Glucosa,'') Glucosa, coalesce(A.SaturacionO2,'') SaturacionO2, ");
            StrSql.append(" coalesce(A.DiagnosticoDx,'') DiagnosticoDx, coalesce(A.TratamientoTx,'') TratamientoTx ");

            StrSql.append(" From Ambulancia A  ");
            StrSql.append(" Left Join cParentesco P ON (P.clParentesco = A.clParentesco)  ");
            StrSql.append(" Left join cTipoLugarTraslado L on (L.clTipoLugarTraslado=A.clTipoLugarTraslado) ");
            StrSql.append(" Left join cTipoAmbulancia TA on (TA.clTipoAmbulancia=A.clTipoAmbulancia) ");
            StrSql.append(" Left Join cMundel M on (A.CodEnt=M.CodEnt and A.CodMD=M.CodMD)  ");
            StrSql.append(" Left join cEntFed E on (A.CodEnt=E.CodEnt) ");

            StrSql.append(" Where A.clExpediente = ").append(StrclExpediente);

            rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
        %>
        <script>fnOpenLinks()</script>
        <%
            StrclPaginaWeb = "222";
            MyUtil.InicializaParametrosC(222, Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

        %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="Ambulancia.jsp?"%>'>
        <%
            if (rs.next()) {

        %><script>document.all.btnAlta.disabled=true;</script>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>                                 
        
        <%=MyUtil.ObjInput("Nombre del Paciente", "Paciente", rs.getString("Paciente"), true, true, 30, 70, "", true, true, 60)%>
        <%=MyUtil.ObjInput("Edad", "Edad", rs.getString("Edad"), true, true, 370, 70, "", false, false, 10, "fnRango(document.all.Edad,0,150)")%>
        <%=MyUtil.ObjInput("Peso (Kgs.)", "PesoKg", rs.getString("PesoKg"), true, true, 450, 70, "", false, false, 10, "EsNumerico(document.all.PesoKg)")%>
        <%=MyUtil.ObjComboC("Parentesco con N/U", "clParentesco", rs.getString("dsParentesco"), true, true, 30, 110, "", "Select clParentesco, dsParentesco From cParentesco ", "", "", 30, true, true)%>
        <%=MyUtil.ObjComboC("Lugar de Traslado", "clTipoLugarTraslado", rs.getString("dsTipoLugarTraslado"), true, true, 200, 110, "", "Select clTipoLugarTraslado, dsTipoLugarTraslado From cTipoLugarTraslado ", "", "", 30, true, true)%>
        <%=MyUtil.ObjComboC("Tipo de Ambulancia", "clTipoAmbulancia", rs.getString("dsTipoAmbulancia"), true, true, 370, 110, "", "Select clTipoAmbulancia, dsTipoAmbulancia From cTipoAmbulancia ", "", "", 30, true, true)%>
        <%=MyUtil.DoBlock("Servicio de Ambulancia", -50, 0)%>               
        
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"), "CP", rs.getString("CP"), true, true, 30, 200, "", false, false, 10)%>                
        <div class='VTable' style='position:absolute; z-index:25; left:100px; top:210px;'>
            <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaN2();' class='cBtn'>
        </div>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"), "dsEntFed", rs.getString("dsEntFed"), false, false, 190, 200, "", false, false, 50)%>                
        <INPUT id='CodEnt' name='CodEnt' type='hidden' value='<%=rs.getString("CodEnt")%>'>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"), "dsMunDel", rs.getString("dsMunDel"), false, false, 30, 240, "", false, false, 50)%>               
        <INPUT id='CodMD' name='CodMD' type='hidden' value='<%=rs.getString("CodMD")%>'>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"), "Colonia", rs.getString("Colonia"), false, false, 300, 240, "", false, false, 50)%>
        <%=MyUtil.ObjInput("Calle", "Calle", rs.getString("Calle"), true, true, 30, 280, "", false, false, 105)%>
        <%=MyUtil.ObjInput("Referencias (entre que calles, tiendas comerciales, etc)", "Referencias", rs.getString("Referencias"), true, true, 30, 320, "", false, false, 105)%>
        <%=MyUtil.DoBlock("Ubicación del Paciente", 100, 0)%>  
        
        <%=MyUtil.ObjInput("Padecimiento", "Padecimiento", rs.getString("Padecimiento"), true, true, 30, 410, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Médico Tratante", "MedicoRecibe", rs.getString("MedicoRecibe"), true, true, 310, 410, "", false, false, 50)%>
        <%=MyUtil.ObjInput("TA", "TA", rs.getString("TA"), true, true, 30, 450, "", false, false, 30)%>
        <%=MyUtil.ObjInput("FC", "FC", rs.getString("FC"), true, true, 210, 450, "", false, false, 30)%>
        <%=MyUtil.ObjInput("FR", "FR", rs.getString("FR"), true, true, 390, 450, "", false, false, 35)%>
        <%=MyUtil.ObjInput("Glasgow", "Glasgow", rs.getString("Glasgow"), true, true, 30, 490, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Glucosa", "Glucosa", rs.getString("Glucosa"), true, true, 210, 490, "", false, false, 30)%>
        <%=MyUtil.ObjInput("Saturación Oxigeno", "SaturacionO2", rs.getString("SaturacionO2"), true, true, 390, 490, "", false, false, 35)%>
        <%=MyUtil.ObjTextArea("Diagnóstico", "DiagnosticoDx", rs.getString("DiagnosticoDx"), "105", "2", true, true, 30, 530, "", false, false)%>
        <%=MyUtil.ObjTextArea("Tratamiento", "TratamientoTx", rs.getString("TratamientoTx"), "105", "2", true, true, 30, 580, "", false, false)%> 
        <%=MyUtil.DoBlock("Signos Vitales y Datos de la Evaluación", 10, 20)%>
        <%
        } else {
            rs.close();
            rs = null;
            StrSql.append("Select rtrim(ltrim(coalesce(Calle,''))) Calle , rtrim(ltrim(coalesce(CP,''))) CP from Expediente E ");
            StrSql.append("INNER JOIN cafiliadoadt A ON (E.Clave=A.Clave)");
            StrSql.append("INNER JOIN AfiliadoInfoAdicionalADT IA ON (A.clAfiliado=IA.clAfiliado)");
            StrSql.append("Where E.clExpediente =").append(StrclExpediente);
            rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs.next()) {
                StrDescripCall = rs.getString("Calle");
                StrCP = rs.getString("CP");
            }
        %>
        
        <script>document.all.btnCambio.disabled=true;</script>   
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>                                
        
        <%=MyUtil.ObjInput("Nombre del Paciente", "Paciente", "", true, true, 30, 70, "PENDIENTE", true, true, 60)%>
        <%=MyUtil.ObjInput("Edad", "Edad", "", true, true, 370, 70, "0", false, false, 10, "fnRango(document.all.Edad,0,150)")%>
        <%=MyUtil.ObjInput("Peso (Kgs.)", "PesoKg", "", true, true, 450, 70, "0", false, false, 10, "EsNumerico(document.all.PesoKg)")%>
        
        <%=MyUtil.ObjComboC("Parentesco con N/U", "clParentesco", "", true, true, 30, 110, "5", "Select clParentesco, dsParentesco From cParentesco ", "", "", 30, true, true)%>
        <%=MyUtil.ObjComboC("Lugar de Traslado", "clTipoLugarTraslado", "", true, true, 200, 110, "1", "Select clTipoLugarTraslado, dsTipoLugarTraslado From cTipoLugarTraslado ", "", "", 30, true, true)%>
        <%=MyUtil.ObjComboC("Tipo de Ambulancia", "clTipoAmbulancia", "", true, true, 370, 110, "1", "Select clTipoAmbulancia, dsTipoAmbulancia From cTipoAmbulancia ", "", "", 30, true, true)%>
        <%=MyUtil.DoBlock("Servicio de Ambulancia", -50, 0)%> 
        
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"), "CP", StrCP, true, true, 30, 200, StrCP, false, false, 10)%>            
        <div class='VTable' style='position:absolute; z-index:25; left:100px; top:210px;'>
            <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaN2();' class='cBtn'>
        </div>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"), "dsEntFed", "", false, false, 190, 200, "PENDIENTE", false, false, 50)%>             
        <INPUT id='CodEnt' name='CodEnt' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"), "dsMunDel", "", false, false, 30, 240, "PENDIENTE", false, false, 50)%>             
        <INPUT id='CodMD' name='CodMD' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"), "Colonia", "", false, false, 300, 240, "PENDIENTE", false, false, 50)%>              
        <%=MyUtil.ObjInput("Calle", "Calle", StrDescripCall, true, true, 30, 280, StrDescripCall, false, false, 105)%>          
        <%=MyUtil.ObjInput("Referencias (entre que calles, tiendas comerciales, etc)", "Referencias", "", true, true, 30, 320, "PENDIENTE", false, false, 105)%> 
        <%=MyUtil.DoBlock("Ubicación del Paciente", 100, 0)%> 
        
        <%=MyUtil.ObjInput("Padecimiento", "Padecimiento", "", true, true, 30, 410, "PENDIENTE", true, true, 50)%> 
        <%=MyUtil.ObjInput("Médico Tratante", "MedicoRecibe", "", true, true, 310, 410, "PENDIENTE", false, false, 50)%> 
        <%=MyUtil.ObjInput("TA", "TA", "", true, true, 30, 450, "PENDIENTE", false, false, 30)%>
        <%=MyUtil.ObjInput("FC", "FC", "", true, true, 210, 450, "PENDIENTE", false, false, 30)%>
        <%=MyUtil.ObjInput("FR", "FR", "", true, true, 390, 450, "PENDIENTE", false, false, 35)%>
        <%=MyUtil.ObjInput("Glasgow", "Glasgow", "", true, true, 30, 490, "PENDIENTE", false, false, 30)%>
        <%=MyUtil.ObjInput("Glucosa", "Glucosa", "", true, true, 210, 490, "PENDIENTE", false, false, 30)%> 
        <%=MyUtil.ObjInput("Saturación Oxigeno", "SaturacionO2", "", true, true, 390, 490, "PENDIENTE", false, false, 35)%> 
        <%=MyUtil.ObjTextArea("Diagnóstico", "DiagnosticoDx", "", "105", "2", true, true, 30, 530, "PENDIENTE", false, false)%>
        <%=MyUtil.ObjTextArea("Tratamiento", "TratamientoTx", "", "105", "2", true, true, 30, 580, "PENDIENTE", false, false)%>
        <%=MyUtil.DoBlock("Signos Vitales y Datos de la Evaluación", 10, 20)%>
        <%
            }
        %>
        <%=MyUtil.GeneraScripts()%>
        <%
            if (rs != null) {
                rs.close();
                rs = null;
            }

            StrclUsrApp = null;
            StrclExpediente = null;
            StrclPaginaWeb = null;
            StrDescripCall = null;
            StrCP = null;
            
            StrSql = null;
        %>
        
        <script>
            document.all.Paciente.maxLength=50;  
            document.all.Edad.maxLength=3;   
            document.all.PesoKg.maxLength=7;   
            document.all.Calle.maxLength=150;   
            document.all.Referencias.maxLength=50;   
            document.all.MedicoRecibe.maxLength=50;   
            document.all.Padecimiento.maxLength=50;   
            document.all.TA.maxLength=20;      
            document.all.FC.maxLength=20;      
            document.all.FR.maxLength=20;      
            document.all.Glasgow.maxLength=50;      
            document.all.Glucosa.maxLength=20;      
            document.all.SaturacionO2.maxLength=20;      
            document.all.DiagnosticoDx.maxLength=200;      
            document.all.TratamientoTx.maxLength=200;         
        </script>
    </body>
</html>
