<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Combos.cbAcompananteMed,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>JSP Page</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script> 

        <%
            String StrclUsrApp = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {%>
        Fuera de Horario
        <%
                StrclUsrApp = null;

                return;
            }
            String StrclExpediente = "0";
            String StrclPaginaWeb = "0";
            String StrFecha = "";

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            StringBuffer StrSql = new StringBuffer();
            // checar si ya existe asistencia para el expediente, si existe, ya no procede la alta
            StrSql.append(" Select TieneAsistencia");
            StrSql.append(" From Expediente ");
            StrSql.append(" Where clExpediente=").append(StrclExpediente);

            ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs2.next()) {
            } else {
        %>
        El expediente no existe
        <%
                rs2.close();
                rs2 = null;
                StrclUsrApp = null;
                StrclExpediente = null;
                StrSql = null;
                StrclPaginaWeb = null;
                StrFecha = null;

                return;
            }

            ResultSet rs3 = UtileriasBDF.rsSQLNP("Select convert(varchar(20),getdate(),120) FechaApertura ");

            if (rs3.next()) {
                StrFecha = rs3.getString("FechaApertura");
            }

            StrSql.append("st_getDetEvacuacionMedica ").append(StrclExpediente);

            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

        %>
        <script>fnOpenLinks()</script>
        <%            StrclPaginaWeb = "168";
            MyUtil.InicializaParametrosC(168, Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="EvacuacionMedica.jsp?'>"%>
        <%
            if (rs.next()) {
             // El siguiente campo llave no se mete con MyUtil.ObjInput 
%>
        <script>document.all.btnAlta.disabled = true;</script>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjInput("Nombre del Paciente", "NombrePaciente", rs.getString("NombrePaciente"), true, true, 30, 70, "", false, false, 75)%>
        <%=MyUtil.ObjComboC("Parentesco con N/U", "clParentesco", rs.getString("dsParentesco"), true, true, 520, 70, "", "Select clParentesco, dsParentesco From cParentesco ", "", "", 100, false, false)%>
        <%=MyUtil.ObjInput("Edad del Paciente", "EdadPaciente", rs.getString("EdadPaciente"), true, true, 30, 110, "", true, true, 10, "fnRango(document.all.EdadPaciente,0,150)")%>
        <%=MyUtil.ObjInput("Peso (Kgs.)", "PesoKilos", rs.getString("PesoKilos"), true, true, 160, 110, "", true, true, 10, "fnRango(document.all.PesoKilos,0,600)")%>
        <%=MyUtil.ObjInput("Estatura (Mts. y Cms.)", "EstaturaMtsCms", rs.getString("EstaturaMtsCms"), true, true, 280, 110, "", false, false, 10, "fnRango(document.all.EstaturaMtsCms,0,3)")%>
        <%=MyUtil.ObjComboC("Ubicación Actual del Paciente", "clUbicacionActual", rs.getString("dsUbicacion"), true, true, 430, 110, "", "Select clUbicacion, dsUbicacion From cUbicacion Order by dsUbicacion", "", "", 10, false, false)%>
        <%=MyUtil.DoBlock("Detalle de Evacuación Médica")%>

        <%=MyUtil.ObjTextArea("Diagnóstico", "Diagnostico", rs.getString("Diagnostico"), "74", "4", true, true, 30, 190, "", false, false)%>
        <%=MyUtil.ObjInput("Hospital u Hotel", "NombreHospHotel", rs.getString("NombreHospHotel"), true, true, 30, 280, "", false, false, 100)%>
        <%=MyUtil.ObjInput("Fecha de Ingreso", "FechaIngreso", rs.getString("FechaIngreso"), true, true, 30, 320, "", true, true, 22, "if(this.readOnly==false){fnValMask(this,document.all.FechaIngresoMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Fecha de Alta", "FechaAlta", rs.getString("FechaAlta"), true, true, 185, 320, "", true, true, 22, "if(this.readOnly==false){fnValMask(this,document.all.FechaAltaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Núm. Habitación", "NumHabitacion", rs.getString("NumHabitacion"), true, true, 340, 320, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Tel. Hospital U Hotel", "TelHospHotel", rs.getString("TelHospHotel"), true, true, 455, 320, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Médico Tratante", "MedicoTratante", rs.getString("MedicoTratante"), true, true, 30, 360, "", false, false, 80)%>
        <%=MyUtil.ObjInput("Tel. 1 Médico Tratante", "TelMedicoTrata1", rs.getString("TelMedicoTrata1"), true, true, 540, 360, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Tel. 2 Médico Tratante", "TelMedicoTrata2", rs.getString("TelMedicoTrata2"), true, true, 540, 400, "", false, false, 20)%>
        <%=MyUtil.ObjComboC("País de su Ubicación Actual", "clPais", rs.getString("dsPais"), true, true, 30, 400, "", "Select clPais, dsPais From cPais Order by dsPais", "fnLlenaCiudades()", "", 70, false, false)%>
        <%=MyUtil.ObjComboC("Ciudad de su Ubicación Actual", "clCiudad", rs.getString("dsCiudad"), true, true, 300, 400, "", "Select clCiudad, dsCiudad From cCiudad Where clPais=" + rs.getString("clPais") + " Order by dsCiudad", "", "", 60, false, false)%>
        <%=MyUtil.ObjInput("Calle y Número de su Ubicación Actual", "CalleNum", rs.getString("CalleNum"), true, true, 30, 440, "", false, false, 60)%>
        <%=MyUtil.DoBlock("UBICACION ACTUAL DEL PACIENTE", -20, 0)%>

        <%=MyUtil.ObjChkBox("Acompañante", "ViajaconAcompanante", rs.getString("ViajaconAcompanante"), true, true, 30, 520, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjInput("Nombre Acompañante", "NombreAcompanante", rs.getString("NombreAcompanante"), true, true, 125, 520, "", false, false, 80)%>
        <%=MyUtil.ObjChkBox("Equipaje", "ViajaconEquipaje", rs.getString("ViajaconEquipaje"), true, true, 30, 560, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjInput("Cuantas Piezas", "CuantasPiezas", rs.getString("CuantasPiezas"), true, true, 125, 560, "", true, true, 10, "fnRango(document.all.CuantasPiezas,0,250)")%>
        <%=MyUtil.ObjChkBox("Requiere Oxígeno", "RequiereOxigeno", rs.getString("RequiereOxigeno"), true, true, 245, 560, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjInput("Núm. Litros de Oxígeno x Minuto", "OxigenoLtsxMinuto", rs.getString("OxigenoLtsxMinuto"), true, true, 370, 560, "", false, false, 30)%>
        <%=MyUtil.ObjComboC("Tipo de Transporte", "clTipoTransporte", rs.getString("dsTipoTransporte"), true, true, 30, 600, "", "Select clTipoTransporte, dsTipoTransporte From cTipoTransporte Where Clasificacion='EVACU' or Clasificacion='TODAS'", "", "", 70, false, false)%>
        <%=MyUtil.ObjComboC("Forma de Evacuación", "clFormaEvacuacion", rs.getString("dsFormaEvacuacion"), true, true, 200, 600, "", "Select clFormaEvacuacion, dsFormaEvacuacion From cFormaEvacuacion ", "", "", 70, false, false)%>
        <% String strAcompanMed = rs.getString("dsAcompananteMed");%>
        <%=MyUtil.ObjComboMem("Acompañante Médico", "clAcompananteMed", strAcompanMed, rs.getString("clAcompananteMed"), cbAcompananteMed.GeneraHTML(70, strAcompanMed), true, true, 370, 600, "", "", "", 70, false, false)%>
        <%=MyUtil.ObjComboC("Requerimiento Especial", "clRequerimientoEsp", rs.getString("dsRequerimientoEsp"), true, true, 540, 600, "", "Select clRequerimientoEsp, dsRequerimientoEsp From cRequerimientoEsp", "", "", 70, false, false)%>
        <%=MyUtil.ObjComboC("País Destino Final", "clPaisResid", rs.getString("dsPaisResid"), true, true, 30, 640, "", "Select clPais, dsPais From cPais Order by dsPais", "fnLlenaCiudResiden()", "", 70, false, false)%>
        <%=MyUtil.ObjComboC("Ciudad Destino Final", "clCiudadResid", rs.getString("dsCiudadResid"), true, true, 370, 640, "", "Select clCiudad, dsCiudad From cCiudad Where clPais=" + rs.getString("clPaisResid") + " Order by dsCiudad", "", "", 60, false, false)%>
        <%=MyUtil.ObjInput("Calle y Número Destino Final", "CalleNumResid", rs.getString("CalleNumResid"), true, true, 30, 680, "", false, false, 60)%>
        <%=MyUtil.ObjInput("Teléfono", "Telefono", rs.getString("Telefono"), true, true, 540, 680, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Costo Estimado", "CostoEstimado", rs.getString("CostoEstimado"), true, true, 30, 720, "", true, true, 15, "EsNumerico(document.all.CostoEstimado)")%>
        <%=MyUtil.ObjInput("Costo Final", "CostoFinal", rs.getString("CostoFinal"), true, true, 170, 720, "", true, true, 15, "EsNumerico(document.all.CostoFinal)")%>
        <%=MyUtil.ObjInput("Fecha Apertura", "FechaApertura", rs.getString("FechaApertura"), false, false, 370, 720, StrFecha, true, true, 22)%>
        <%=MyUtil.ObjInput("Fecha Registro", "FechaRegistroVTR", rs.getString("FechaRegistro"), false, false, 540, 720, "", false, true, 22)%>
        <%=MyUtil.DoBlock("DATOS DE LA EVACUACION", -19, 0)%>
        <%
        } else {
        %>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjInput("Nombre del Paciente", "NombrePaciente", "", true, true, 30, 70, "", false, false, 75)%>
        <%=MyUtil.ObjComboC("Parentesco con N/U", "clParentesco", "", true, true, 520, 70, "", "Select clParentesco, dsParentesco From cParentesco ", "", "", 100, false, false)%>
        <%=MyUtil.ObjInput("Edad del Paciente", "EdadPaciente", "", true, true, 30, 110, "", true, true, 10, "fnRango(document.all.EdadPaciente,0,150)")%>
        <%=MyUtil.ObjInput("Peso (Kgs.)", "PesoKilos", "", true, true, 160, 110, "", true, true, 10, "fnRango(document.all.PesoKilos,0,600)")%>
        <%=MyUtil.ObjInput("Estatura (Mts. y Cms.)", "EstaturaMtsCms", "", true, true, 280, 110, "", true, true, 10, "fnRango(document.all.EstaturaMtsCms,0,3)")%>
        <%=MyUtil.ObjComboC("Ubicación Actual del Paciente", "clUbicacionActual", "", true, true, 430, 110, "", "Select clUbicacion, dsUbicacion From cUbicacion Order by dsUbicacion", "", "", 10, false, false)%>
        <%=MyUtil.DoBlock("Detalle de Evacuación Médica")%>

        <%=MyUtil.ObjTextArea("Diagnóstico", "Diagnostico", "", "74", "4", true, true, 30, 190, "", false, false)%>
        <%=MyUtil.ObjInput("Hospital u Hotel", "NombreHospHotel", "", true, true, 30, 280, "", false, false, 100)%>
        <%=MyUtil.ObjInput("Fecha de Ingreso", "FechaIngreso", "", true, true, 30, 320, "", true, true, 22, "if(this.readOnly==false){fnValMask(this,document.all.FechaIngresoMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Fecha de Alta", "FechaAlta", "", true, true, 185, 320, "", true, true, 22, "if(this.readOnly==false){fnValMask(this,document.all.FechaAltaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Núm. Habitación", "NumHabitacion", "", true, true, 340, 320, "", false, false, 10)%>
        <%=MyUtil.ObjInput("Tel. Hospital U Hotel", "TelHospHotel", "", true, true, 455, 320, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Médico Tratante", "MedicoTratante", "", true, true, 30, 360, "", false, false, 80)%>
        <%=MyUtil.ObjInput("Tel. 1 Médico Tratante", "TelMedicoTrata1", "", true, true, 540, 360, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Tel. 2 Médico Tratante", "TelMedicoTrata2", "", true, true, 540, 400, "", false, false, 20)%>
        <%=MyUtil.ObjComboC("País de su Ubicación Actual", "clPais", "", true, true, 30, 400, "", "Select clPais, dsPais From cPais Order by dsPais", "fnLlenaCiudades()", "", 70, false, false)%>
        <%=MyUtil.ObjComboC("Ciudad de su Ubicación Actual", "clCiudad", "", true, true, 300, 400, "", "select * from cMunDel where CodEnt = 0", "", "", 60, false, false)%>
        <%=MyUtil.ObjInput("Calle y Número de su Ubicación Actual", "CalleNum", "", true, true, 30, 440, "", false, false, 60)%>
        <%=MyUtil.DoBlock("UBICACION ACTUAL DEL PACIENTE", -20, 0)%>

        <%=MyUtil.ObjChkBox("Acompañante", "ViajaconAcompanante", "", true, true, 30, 520, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjInput("Nombre Acompañante", "NombreAcompanante", "", true, true, 125, 520, "", false, false, 80)%>
        <%=MyUtil.ObjChkBox("Equipaje", "ViajaconEquipaje", "", true, true, 30, 560, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjInput("Cuantas Piezas", "CuantasPiezas", "", true, true, 125, 560, "", true, true, 10, "fnRango(document.all.CuantasPiezas,0,250)")%>
        <%=MyUtil.ObjChkBox("Requiere Oxígeno", "RequiereOxigeno", "", true, true, 245, 560, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjInput("Núm. Litros de Oxígeno x Minuto", "OxigenoLtsxMinuto", "", true, true, 370, 560, "", false, false, 30)%>
        <%=MyUtil.ObjComboC("Tipo de Transporte", "clTipoTransporte", "", true, true, 30, 600, "", "Select clTipoTransporte, dsTipoTransporte From cTipoTransporte Where Clasificacion='EVACU' or Clasificacion='TODAS'", "", "", 70, false, false)%>
        <%=MyUtil.ObjComboC("Forma de Evacuación", "clFormaEvacuacion", "", true, true, 200, 600, "", "Select clFormaEvacuacion, dsFormaEvacuacion From cFormaEvacuacion ", "", "", 70, false, false)%>
        <%=MyUtil.ObjComboMem("Acompañante Médico", "clAcompananteMed", "", "", cbAcompananteMed.GeneraHTML(70, ""), true, true, 370, 600, "", "", "", 70, false, false)%>
        <%=MyUtil.ObjComboC("Requerimiento Especial", "clRequerimientoEsp", "", true, true, 540, 600, "", "Select clRequerimientoEsp, dsRequerimientoEsp From cRequerimientoEsp", "", "", 70, false, false)%>
        <%=MyUtil.ObjComboC("País Destino Final", "clPaisResid", "", true, true, 30, 640, "", "Select clPais, dsPais From cPais Order by dsPais", "fnLlenaCiudResiden()", "", 70, false, false)%>
        <%=MyUtil.ObjComboC("Ciudad Destino Final", "clCiudadResid", "", true, true, 370, 640, "", "select * from cMunDel where CodEnt = 0", "", "", 60, false, false)%>
        <%=MyUtil.ObjInput("Calle y Número Destino Final", "CalleNumResid", "", true, true, 30, 680, "", false, false, 60)%>
        <%=MyUtil.ObjInput("Teléfono", "Telefono", "", true, true, 540, 680, "", false, false, 20)%>
        <%=MyUtil.ObjInput("Costo Estimado", "CostoEstimado", "", true, true, 30, 720, "", true, true, 15, "EsNumerico(document.all.CostoEstimado)")%>
        <%=MyUtil.ObjInput("Costo Final", "CostoFinal", "", true, true, 170, 720, "", true, true, 15, "EsNumerico(document.all.CostoFinal)")%>
        <%=MyUtil.ObjInput("Fecha Apertura", "FechaApertura", "", false, false, 370, 720, StrFecha, true, true, 22)%>
        <%=MyUtil.ObjInput("Fecha Registro", "FechaRegistroVTR", "", false, false, 540, 720, "", false, true, 22)%>
        <%=MyUtil.DoBlock("DATOS DE LA EVACUACION", -19, 0)%>

        <%
            }
            rs2.close();
            rs3.close();
            rs.close();
            rs2 = null;
            rs3 = null;
            rs = null;
            StrclUsrApp = null;
            StrclExpediente = null;
            StrSql = null;
            StrclPaginaWeb = null;
            StrFecha = null;

        %>
        <%=MyUtil.GeneraScripts()%>
        <input name='FechaIngresoMsk' id='FechaIngresoMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <input name='FechaAltaMsk' id='FechaAltaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <script>
            document.all.NombrePaciente.maxLength = 80;
            document.all.EdadPaciente.maxLength = 3;
            document.all.PesoKilos.maxLength = 7;
            document.all.EstaturaMtsCms.maxLength = 4;
            document.all.NombreHospHotel.maxLength = 100;
            document.all.NumHabitacion.maxLength = 10;
            document.all.CalleNum.maxLength = 60;
            document.all.TelHospHotel.maxLength = 20;
            document.all.MedicoTratante.maxLength = 80;
            document.all.TelMedicoTrata1.maxLength = 20;
            document.all.TelMedicoTrata2.maxLength = 20;
            document.all.NombreAcompanante.maxLength = 80;
            document.all.CuantasPiezas.maxLength = 3;
            document.all.OxigenoLtsxMinuto.maxLength = 30;
            document.all.CalleNumResid.maxLength = 60;
            document.all.Telefono.maxLength = 20;
        </script>
    </body>
</html>