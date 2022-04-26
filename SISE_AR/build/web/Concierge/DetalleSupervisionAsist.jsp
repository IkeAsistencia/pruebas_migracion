<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Detalle de la Supervision</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="fnMuestraTotalDent();">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <script src='../Utilerias/UtilCalendario.js'></script>
        
        <%
        String StrclPaginaWeb = "1191";
        String StrclAsistencia = "0";
        String strclUsr = "0";
        String strclSupervision = "0";
        String strNumSupervision = "0";
        String StrNombreUsuario = "";
        String StrFecha = "";
        String StrFechaAsignacion = ""; 
        String StrTipo = "";

        if (session.getAttribute("clUsrApp") != null) {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }

        if (session.getAttribute("clAsistencia") != null) {
            StrclAsistencia = session.getAttribute("clAsistencia").toString();
        }

        if (request.getParameter("clSupervision") != null) {
            strclSupervision = request.getParameter("clSupervision").toString();
        } else {
            if (session.getAttribute("clSupervision") != null) {
                strclSupervision = session.getAttribute("clSupervision").toString();
            }
        }

        if(request.getParameter("clNumSupervision") != null) {
            strNumSupervision = request.getParameter("clNumSupervision").toString();
        } else {
            if (session.getAttribute("clNumSupervision") != null) {
                strNumSupervision = session.getAttribute("clNumSupervision").toString();
            }
        }

        if (session.getAttribute("NombreUsuario") != null) {
            StrNombreUsuario = session.getAttribute("NombreUsuario").toString();
        }

        session.setAttribute("clSupervision", strclSupervision);
        session.setAttribute("clNumSupervision", strNumSupervision);

        StringBuffer StrSql = new StringBuffer();
        if (strclSupervision.compareToIgnoreCase("0") == 0) {
            StrSql.append(" st_SCSgetDetalleSupSin ").append(StrclAsistencia).append(",").append(strclSupervision).append(",'").append(strclUsr).append("','").append(StrNombreUsuario).append("'");
            //System.out.println("st_getDetalleSupSin " + StrclAsistencia + ", " + strclSupervision + ", " + strclUsr + ", '" + StrNombreUsuario + "'");
        } else {
            StrSql.append(" st_SCSgetDetalleSup ").append(strclSupervision);
            //System.out.println("st_SCSgetDetalleSup " + strclSupervision);
        }

        
        session.setAttribute("clPaginaWebP", StrclPaginaWeb);

        MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(strclUsr));
        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        System.out.println("RS          "+StrSql);
        StrSql.delete(0, StrSql.length());%>

        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "", "fnValidaGuarda();")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1) + "DetalleSupervisionAsist.jsp?"%>'>

        <%
        if (rs.next()) {
            String strdsCalifSup = rs.getString("dsCalificacionSup");
            if (strdsCalifSup == null) {
                strdsCalifSup = "";
            }

            String strclCalifSup = rs.getString("clCalificacionSup");
            if (strclCalifSup == null) {
                strclCalifSup = "0";
            }
            // si es MALO O MALO / CRITICO debe cerrar la ventana y mandar la pagina padre a registro de queja
%>
        <SCRIPT>if(window.name=='Contenido'){
            fnOpenLinks();
        }else{
            if (<%=strclCalifSup%> == 4 || <%=strclCalifSup%>== 5){
                window.opener.fnRelocate('../Supervision/QuejasxSupervisionAsist.jsp?');window.close();
            }
        }</SCRIPT>
        <%
            String strclEstatusSup = rs.getString("clEstatusSup");
            if (strclEstatusSup == null) {
                strclEstatusSup = "0";
            }

            String strNuestroUsuario = rs.getString("NuestroUsuario");
            if (strNuestroUsuario == null) {
                strNuestroUsuario = "";
            }

            String strTelefono1 = rs.getString("TelefonoH");
            if (strTelefono1 == null) {
                strTelefono1 = "";
            }

            String strTelefono2 = rs.getString("TelefonoC");
            if (strTelefono2 == null) {
                strTelefono2 = "";
            }

            if (strclEstatusSup.compareToIgnoreCase("6") == 0 || strclEstatusSup.compareToIgnoreCase("3") == 0) {%>
        <SCRIPT>
        document.all.btnAlta.disabled=true;
        document.all.btnCambio.disabled=false;
        document.all.btnElimina.disabled=true;
        </SCRIPT>
        <%} else if (strclEstatusSup.compareToIgnoreCase("0") == 0) {%>
        <SCRIPT>
        document.all.btnCambio.disabled=true;
        document.all.btnElimina.disabled=true;
        </SCRIPT>
        <% } else {StrSql.append(" st_SCSgerPermiso ").append(strclUsr);

            ResultSet rsPermiso = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rsPermiso.next()) {
                if (rsPermiso.getInt("Permiso") > 0) {
        %>
        <SCRIPT>
        document.all.btnAlta.disabled=true;
        document.all.btnCambio.disabled=false;
        document.all.btnElimina.disabled=true;
        </SCRIPT>
        <% } else {%>
        <SCRIPT>
        document.all.btnAlta.disabled=true;
        document.all.btnCambio.disabled=true;
        document.all.btnElimina.disabled=true;
        </SCRIPT>
        <% }
            }
        }%>
        <INPUT id='clSupervision' name='clSupervision' type='hidden' value='<%= strclSupervision%>'>
        <INPUT id='NumSupervision' name='NumSupervision' type='hidden' value='<%= strNumSupervision%>'>
        <INPUT id='clUsrAppAsig' name='clUsrAppAsig' type='hidden' value='<%=rs.getString("clUsrAppAsig")%>'>
        <INPUT id='clUsrAppSup' name='clUsrAppSup' type='hidden' value='<%= rs.getString("clUsrAppSup")%>'>
        <INPUT id='fechahoy'  name='fechahoy' type='hidden' value='<%=rs.getString("fechahoy")%>'>

        <%=MyUtil.ObjInput("Asistencia", "clAsistencia", StrclAsistencia, false, false, 30, 70, StrclAsistencia, false, false, 15)%>
        <%=MyUtil.ObjInput("Nuestro Usuario", "NuestroUsuario", strNuestroUsuario, false, false, 130, 70, strNuestroUsuario, false, false, 40)%>
        <%=MyUtil.ObjInput("Teléfono1", "Telefono1", strTelefono1, false, false, 430, 70, strTelefono1, false, false, 20)%>
        <%=MyUtil.ObjInput("Teléfono2", "Telefono2", strTelefono2, false, false, 620, 70, strTelefono2, false, false, 20)%>
        <%=MyUtil.DoBlock("Datos Generales del Expediente", -50, 0)%>

        <%=MyUtil.ObjComboC("Estatus", "clEstatusSup", rs.getString("dsEstatusSup"), true, true, 30, 160, "", "Select clEstatusSup, dsEstatusSup from cEstatusSup", "fnMuestraTotalDent();fnGetDate();/*fnValidaEstSup();*/", "", 20, true, true)%>
        <div class='FTable' style='position:absolute; z-index:299; left:205px; top:165px;'>
            <input type='hidden' name='clAreaSupervisada' id='clAreaSupervisada'  value='<%=rs.getString("clAreaSupervisada")%>'>
        <p class='<%=rs.getString("Estilo")%>'><strong>Area a Supervisar: <br></strong><%=rs.getString("dsAreaSupervisada")%></p></div>

        <%=MyUtil.ObjComboC("Tipo de Evaluacion", "clTipoEvaluacion", rs.getString("dsTipoEvaluacion"), true, true, 360, 160, "", "Select clTipoEvaluacion, dsTipoEvaluacion from cTipoEvaluacion", "", "", 75, true, true)%>
        <%=MyUtil.ObjInput("No. de Superv.", "NumSupervisionVTR", strNumSupervision, false, false, 30, 200, "", false, false, 15)%>

        <%
            StrFecha = rs.getString("Fecha");
            StrFechaAsignacion = rs.getString("FechaAsignacion");
        %>
        <%=MyUtil.ObjInput("Fecha Supervisión", "Fecha", StrFecha, true, false, 140, 200, StrFecha, false, false, 22)%>
        <%=MyUtil.ObjInput("Fecha Asignación", "FechaAsignacion", StrFechaAsignacion, true, false, 290, 200, StrFechaAsignacion, false, false, 22)%>
        <%=MyUtil.ObjInput("Usuario que Supervisó", "NomUsrSup", rs.getString("NomUsrSup"), false, false, 435, 200, session.getAttribute("NombreUsuario").toString(), false, false, 50)%>
        <%=MyUtil.ObjComboC("Evaluado Por", "clEvaluadoPor", rs.getString("dsEvaluadoPor"), true, true, 720, 200, "", "Select clEvaluadoPor, dsEvaluadoPor from cEvaluadoPor", "", "", 20, false, false)%>
        <%
            StringBuffer StrSQLPregs = new StringBuffer();
            int iPreg = 1;
            int NumPreg = 1;
            int NumPregS = 1;
            int iY = 240;
            int iY2 = 0;
            int zIndex = 100;

            ResultSet rsPregs = null;

            if (strclEstatusSup.compareToIgnoreCase("0") == 0) {
                System.out.println("Preguntas sin supervision " + strNumSupervision + "'" + rs.getString("clSubservicio"));

                //  EXPEDIENTE SE ENCUENTRA PENDIENTE A SUPERVISAR
                //  OBTIENE LAS PREGUNTAS ESPECÍFICAS PARA EL TIPO DE SUBSERVICIO
            //StrSQLPregs.append(" st_SCSgetPregxSub ").append(rs.getString("clSubservicio")).append(",").append(strNumSupervision);
			/* Modif. 28/09/16 cambia el tipo de respuesta para las preguntas Tipo N por Yanet*/
			StrSQLPregs.append(" st_SCSgetPregxSub ").append(rs.getString("clSubservicio")).append(",").append(strNumSupervision).append(",").append(StrclAsistencia);
			/************************************************************************/
            rsPregs = UtileriasBDF.rsSQLNP(StrSQLPregs.toString());

            while(rsPregs.next()){
                System.out.println("Pregunta:       "+rsPregs.getString("clPreguntaSup")+" - "+rsPregs.getString("dsPreguntaSup"));
                StrTipo = rsPregs.getString("Tipo");
                if(StrTipo.equalsIgnoreCase("N")){
                    %>
                    <INPUT type='hidden' name='clPS<%=iPreg%>' id='clPS<%=iPreg%>' value='<%=rsPregs.getString("clPreguntaSup")%>'>
                    <div class='FTable' style='position:absolute; z-index:<%=zIndex%>; left:30px; top:<%=iY%>px;'>
                        <p><%=rsPregs.getString("dsPreguntaSup")%></p>
                    </div>
                    <%=MyUtil.ObjComboC("", "clCal" + iPreg, "", true, true, 30, iY, "", "Select clCalificacionSup, dsCalificacionSup from cCalificacionSup where Tipo='N' order by dsCalificacionSup", "", "", 30, true, true)%>
                    <%
                iY += 40;
                }
            iPreg += 1;
            NumPreg += 1;
            zIndex = zIndex + 1;
            }
            %>

            <%=MyUtil.ObjTextArea("Observaciones del Afiliado", "ObsAfiliado", rs.getString("ObsAfiliado"), "100", "3", true, true, 30, iY, "", false, false)%>
            <%  iY += 60;%>
            <%=MyUtil.ObjTextArea("Observaciones del Supervisor", "ObsSuperv", rs.getString("ObsSuperv"), "100", "3", true, true, 30, iY, "", false, false)%>
            <%  iY += 60;%>
            <%=MyUtil.ObjTextArea("Sugerencias", "Sugerencias", rs.getString("Sugerencias"), "100", "3", true, true, 30, iY, "", false, false)%>
            <%  iY += 60;%>

            <%
            rsPregs.beforeFirst();
            while(rsPregs.next()){
                StrTipo = rsPregs.getString("Tipo");
                    if(StrTipo.equalsIgnoreCase("S")){
                        System.out.println("Pregunta:       "+rsPregs.getString("clPreguntaSup")+" - "+rsPregs.getString("dsPreguntaSup"));
                        %>
                        <INPUT type='hidden' name='clPE<%=NumPregS%>' id='clPE<%=NumPregS%>' value='<%=rsPregs.getString("clPreguntaSup")%>'>
                        <div class='FTable' style='position:absolute; z-index:<%=zIndex%>; left:30px; top:<%=iY%>px;'>
                            <p><%=rsPregs.getString("dsPreguntaSup")%></p>
                        </div>
                        <%=MyUtil.ObjComboC("", "clCalE" + NumPregS, "", true, true, 30, iY, "", "Select clCalificacionSup, dsCalificacionSup from cCalificacionSup where Tipo='S' order by dsCalificacionSup", "", "", 30, true, true)%>
                        <%
                        NumPregS += 1;
                        iY += 40;
                    }

                    if(StrTipo.equalsIgnoreCase("O")){
                        %>
                        <INPUT type='hidden' name='clPE<%=NumPreg%>' id='clPE<%=NumPreg%>' value='<%=rsPregs.getString("clPreguntaSup")%>'>
                        <div class='FTable' style='position:absolute; z-index:<%=zIndex%>; left:30px; top:<%=iY%>px;'>
                            <p><%=rsPregs.getString("dsPreguntaSup")%></p>
                        </div>
                        <%=MyUtil.ObjInputF("", "FechaCita", "", true, true, 30, iY, "", true, true, 18, 1, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
                        <%
                        NumPregS += 1;
                        iY += 40;
                    }
                    
                iPreg += 1;
                NumPreg += 1;
                zIndex = zIndex + 1;
            }
/////////////////////////////////////////////////////////////////////////            

            rsPregs.beforeFirst();
            
            int NumPregES = 1;
            
            while(rsPregs.next()){
                StrTipo = rsPregs.getString("Tipo");
                   //<<<<<<<<<<< Encuesta de Satisfacción >>>>>>>>>>>
                     //if(StrTipo.equalsIgnoreCase("E")){ // Se quita la Encuesta Anterior (9 preguntas ) 20111228
                     if(StrTipo.equalsIgnoreCase("E1")){
                        //System.out.println("Pregunta:       "+rsPregs.getString("clPreguntaSup")+" - "+rsPregs.getString("dsPreguntaSup"));
                        
                        %>
                        <INPUT type='hidden' name='clPES<%=NumPregES%>' id='clPES<%=NumPregES%>' value='<%=rsPregs.getString("clPreguntaSup")%>'>
                        <div class='FTable' style='position:absolute; z-index:<%=zIndex%>; left:30px; top:<%=iY%>px;'>
                            <p><%=rsPregs.getString("dsPreguntaSup")%></p>
                        </div>
                        <%=MyUtil.ObjComboC("", "clCalES" + NumPregES, "", true, true, 30, iY, "", "Select clCalificacionSup, dsCalificacionSup from cCalificacionSup where Tipo='E1' order by clCalificacionSup asc", "", "", 30, true, true)%>
                        <%
                        NumPregES += 1;
                        iY += 40;
                    }
					/* Modif. 28/09/16 cambia el tipo de respuesta para las preguntas Tipo N por Yanet*/
					if(StrTipo.equalsIgnoreCase("E3")){
						%>
						<INPUT type='hidden' name='clPE3S<%=NumPregES%>' id='clPE3S<%=NumPregES%>' value='<%=rsPregs.getString("clPreguntaSup")%>'>
						<div class='FTable' style='position:absolute; z-index:<%=zIndex%>; left:30px; top:<%=iY%>px;'>
							<p><%=rsPregs.getString("dsPreguntaSup")%></p>
						</div>
						<%=MyUtil.ObjComboC("", "clCalE3S" + NumPregES, "", true, true, 30, iY, "", "Select clCalificacionSup, dsCalificacionSup from cCalificacionSup where Tipo='E3'", "", "", 30, true, true)%>
						<%
						NumPregES += 1;
						iY += 40;
					}
					/************************************************************************/
            }

///

        } else {
            System.out.println("Preguntas ya supervisados");
            //  MUESTRA LAS PREGUNTAS PARA LOS EXPEDIENTES YA SUPERVISADOS?
            StrSQLPregs.append(" st_SCSgetPregSup ").append(strclSupervision);

            rsPregs = UtileriasBDF.rsSQLNP(StrSQLPregs.toString());

            while (rsPregs.next()) {
                StrTipo = rsPregs.getString("Tipo");
                if(StrTipo.equalsIgnoreCase("N")){
                    %>
                    <INPUT type='hidden' name='clPS<%=iPreg%>' id='clPS<%=iPreg%>' value='<%=rsPregs.getString("clPreguntaSup")%>'>
                    <div class='FTable' style='position:absolute; z-index:<%=zIndex%>; left:30px; top:<%=iY%>px;'>
                        <p><%=rsPregs.getString("dsPreguntaSup")%></p>
                    </div>
                    <%=MyUtil.ObjComboC("", "clCal" + iPreg, rs.getString("dsCal" + iPreg), true, true, 30, iY, "", "Select clCalificacionSup, dsCalificacionSup from cCalificacionSup where Tipo='N' order by dsCalificacionSup", "", "", 30, true, true)%>
                    <%
                    iY += 40;
                }
                iPreg += 1;
                NumPreg += 1;
                zIndex = zIndex + 1;
            }
%>

            <%=MyUtil.ObjTextArea("Observaciones del Afiliado", "ObsAfiliado", rs.getString("ObsAfiliado"), "100", "3", true, true, 30, iY, "", false, false)%>
            <%  iY += 60;%>
            <%=MyUtil.ObjTextArea("Observaciones del Supervisor", "ObsSuperv", rs.getString("ObsSuperv"), "100", "3", true, true, 30, iY, "", false, false)%>
            <%  iY += 60;%>
            <%=MyUtil.ObjTextArea("Sugerencias", "Sugerencias", rs.getString("Sugerencias"), "100", "3", true, true, 30, iY, "", false, false)%>
            <%  iY += 60;%>

<%
            rsPregs.beforeFirst();
            while(rsPregs.next()){
                StrTipo = rsPregs.getString("Tipo");
                if(StrTipo.equalsIgnoreCase("S")){
                    %>
                    <INPUT type='hidden' name='clPE<%=NumPregS%>' id='clPE<%=NumPregS%>' value='<%=rsPregs.getString("clPreguntaSup")%>'>
                    <div class='FTable' style='position:absolute; z-index:<%=zIndex%>; left:30px; top:<%=iY%>px;'>
                        <p><%=rsPregs.getString("dsPreguntaSup")%></p>
                    </div>
                    <%=MyUtil.ObjComboC("", "clCalE" + NumPregS, rs.getString("dsCalE" + NumPregS), true, true, 30, iY, "", "Select clCalificacionSup, dsCalificacionSup from cCalificacionSup where Tipo='S' order by dsCalificacionSup", "", "", 30, true, true)%>
                    <%
                    NumPregS += 1;
                    iY += 40;
                }

                iPreg += 1;
                NumPreg += 1;
                zIndex = zIndex + 1;
            }
            %>

            <%
            if(!rs.getString("FechaCita").equalsIgnoreCase("") && !rs.getString("FechaCita").equalsIgnoreCase("1900-01-01")){
                %>
                <div class='FTable' style='position:absolute; z-index:<%=zIndex%>; left:30px; top:<%=iY%>px;'>
                    <p>¿En que fecha quedó coordinada su cita?</p>
                </div>
                <%=MyUtil.ObjInputF("", "FechaCita", rs.getString("FechaCita"), false, false, 30, iY, "", false, false, 18, 1, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
                <%
            }
            
/////////////////////////////////////////////////////////////////////////            

            rsPregs.beforeFirst();
            
            int NumPregES = 1;
            
            while(rsPregs.next()){
                StrTipo = rsPregs.getString("Tipo");
                   //<<<<<<<<<<< Encuesta de Satisfacción >>>>>>>>>>>
                     //if(StrTipo.equalsIgnoreCase("E")){ // Se quita la Encuesta Anterior (9 preguntas ) 20111228
                     if(StrTipo.equalsIgnoreCase("E1")){
                        //System.out.println("Pregunta:       "+rsPregs.getString("clPreguntaSup")+" - "+rsPregs.getString("dsPreguntaSup"));
                        
                        %>
                        <INPUT type='hidden' name='clPES<%=NumPregES%>' id='clPES<%=NumPregES%>' value='<%=rsPregs.getString("clPreguntaSup")%>'>
                        <div class='FTable' style='position:absolute; z-index:<%=zIndex%>; left:30px; top:<%=iY%>px;'>
                            <p><%=rsPregs.getString("dsPreguntaSup")%></p>
                        </div>
                        <%=MyUtil.ObjComboC("", "clCalES" + NumPregES, rs.getString("dsCalES" + NumPregES), true, true, 30, iY, "", "Select clCalificacionSup, dsCalificacionSup from cCalificacionSup where Tipo='E1' order by clCalificacionSup asc", "", "", 30, true, true)%>
                        <%
                        NumPregES += 1;
                        iY += 40;
                    }
					/* Modif. 28/09/16 cambia el tipo de respuesta para las preguntas Tipo N por Yanet*/
					if(StrTipo.equalsIgnoreCase("E3")){
						%>
						<INPUT type='hidden' name='clPE3S<%=NumPregES%>' id='clPE3S<%=NumPregES%>' value='<%=rsPregs.getString("clPreguntaSup")%>'>
						<div class='FTable' style='position:absolute; z-index:<%=zIndex%>; left:30px; top:<%=iY%>px;'>
							<p><%=rsPregs.getString("dsPreguntaSup")%></p>
						</div>
						<%=MyUtil.ObjComboC("", "clCalE3S" + NumPregES, rs.getString("dsCalE3S" + NumPregES), true, true, 30, iY, "", "Select clCalificacionSup, dsCalificacionSup from cCalificacionSup where Tipo='E3'", "", "", 30, true, true)%>
						<%
						NumPregES += 1;
						iY += 40;
					}
            }            
            
        }
            if (iY2 == 1) {
                iY -= 430;
            }%>
      
        <%=MyUtil.ObjChkBox("Inconforme", "Inconforme", rs.getString("Inconforme"), true, true, 590, 240, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjChkBox("Crítico", "Critico", rs.getString("Critico"), true, true, 690, 240, "0", "SI", "NO", "")%>
        <%=MyUtil.ObjInput("Calificación", "CalifLetraVTR", strdsCalifSup, false, false, 590, 286, "", false, false, 25)%>
        <%=MyUtil.ObjInput("Cal. Numérica", "CalifNumerico", rs.getString("CalifNumerico"), false, false, 750, 286, "", false, false, 5)%>
        <%=MyUtil.ObjInput("Cal. Evaluación", "CalifEvaluacion", rs.getString("CalifNumericoE"), false, false, 590, 330, "", false, false, 5)%>
        <%=MyUtil.ObjInput("Cal. CAT", "CalifCAT", rs.getString("CalifNumECAT"), false, false, 720, 330, "", false, false, 5)%>
        <%=MyUtil.ObjInput("Cal. Proveedor", "CalifPROV", rs.getString("CalifNumEPROV"), false, false, 790, 330, "", false, false, 5)%>

        <div id='TotalDent' name='TotalDent' style='visibility:hidden'>
            <%=MyUtil.ObjChkBox("¿Seguro dental?", "SeguroDentalVTR", rs.getString("SeguroDental"), true, true, 590, 370, "0", "SI", "NO", "fnBloqueaCausa();")%>
            <%=MyUtil.ObjComboC("Causa", "clCausaRechaza", rs.getString("dsCausaRechaza"), true, true, 720, 370, "", "Select clCausaRechaza, dsCausaRechaza From cCausaRechaza Order by dsCausaRechaza", "", "", 20, false, false)%>
        </div>
                

        <%-- Modif. Feb/13/2014 --%>
        <%=MyUtil.ObjComboC("¿QUE TAN DISPUESTO ESTARIA EN RECOMENDAR EL SERVICIO?","RecomiendaServ", rs.getString("dsRecomiendaServ"), true, true, 590, 450, "", "select clCalificacionSup , dsCalificacionSup   from cCalificacionSup where Tipo='E3'", "", "", 75, true, true)%>            

        <%--
        <%=MyUtil.ObjChkBox("¿Usted recomendaría el servicio de asistencia?", "RecomiendaServ", rs.getString("RecomiendaServ"), true, true, 590, 450, "0", "SI", "NO", "")%>
        --%>


        <%=MyUtil.ObjInput("¿Por qué?", "CausaRecomienda", rs.getString("CausaRecomienda"), true, true, 590, 490, "", true, true, 75)%>
        
        <%=MyUtil.ObjChkBox("¿Volvería a utilizar el servicios de concierge?", "VolveriaUsarServ", rs.getString("VolveriaUsarServ"), true, true, 590, 540, "0", "SI", "NO", "")%>
        
        

        <INPUT name="SeguroDental" id="SeguroDental" type="hidden" value="<%=rs.getString("SeguroDental")%>">

        <%=MyUtil.DoBlock("Datos de la Supervisión", 20, 20)%>
        <%
            rsPregs.close();
            rsPregs = null;

            StrSQLPregs = null;

            strclEstatusSup = null;
            strNuestroUsuario = null;
            strTelefono1 = null;
            strTelefono2 = null;
            StrFecha = null;
            StrFechaAsignacion = null;

        } else {%>
        <SCRIPT>alert('No existe el expediente que desea supervisar');window.close();</SCRIPT>
        <%
            StrclAsistencia = null;
            strclUsr = null;
            strclSupervision = null;
            strNumSupervision = null;
            StrNombreUsuario = null;
            StrFecha = null;
            StrFechaAsignacion = null;
            StrTipo = null;
            StrclPaginaWeb = null;
            return;
        }%>
        <%=MyUtil.GeneraScripts()%>

        <%
        rs.close();
        rs = null;

        StrclAsistencia = null;
        strclUsr = null;
        strclSupervision = null;
        strNumSupervision = null;
        StrNombreUsuario = null;
        StrFecha = null;
        StrFechaAsignacion = null;
        StrTipo = null;
        StrclPaginaWeb = null;
        %>

        <div class='FTable' style='position:absolute; z-index:30; left:410px; top:120px;'>
        <p class='FTable' readonly name='ClaveMskUsr' id='ClaveMskUsr'></p></div>

        <SCRIPT>
        window.focus();
        document.all.clTipoEvaluacion.visibility=true;
        
        window.focus();

        function fnValidaGuarda(){
            fnDatosObligadosTotalDent();
            if (document.all.clEstatusSup.value==1 && document.all.clEvaluadoPor.value==0){
                msgVal=msgVal + " Evaluado Por. ";
            }
            if(msgVal!=""){
                document.all.btnGuarda.disabled=false;
                document.all.btnCancela.disabled=false;
            }
        }

        function fnActFecha(){
            document.all.FechaVTR.value="2005";
        }

        function fnGetDate(){
            var fecha = document.all.fechahoy.value;
            alert ('Fecha de supervision Actualizada');
            document.all.Fecha.value = fecha;
        }

        function fnValidaEstSup(){
            if (document.all.clEstatusSup.value==3 || document.all.clEstatusSup.value==6){
                document.all.clCal1C.value='6';
                document.all.clCal2C.value='6';
                document.all.clCal3C.value='6';
                //document.all.clCal4C.value='6';

                document.all.clCal1C.disabled=true;
                document.all.clCal2C.disabled=true;
                document.all.clCal3C.disabled=true;
                //document.all.clCal4C.disabled=true;

                document.all.clCalE1C.value='10';
                document.all.clCalE2C.value='10';
                document.all.clCalE3C.value='10';
                /*document.all.clCalE4C.value='10';
                document.all.clCalE5C.value='10';
                document.all.clCalE6C.value='10';*/

                document.all.clCalE1C.disabled=true;
                document.all.clCalE2C.disabled=true;
                document.all.clCalE3C.disabled=true;
                /*document.all.clCalE4C.disabled=true;
                document.all.clCalE5C.disabled=true;
                document.all.clCalE6C.disabled=true;*/
            }else{
                document.all.clCal1C.value='';
                document.all.clCal2C.value='';
                document.all.clCal3C.value='';
                //document.all.clCal4C.value='';

                document.all.clCal1C.disabled=false;
                document.all.clCal2C.disabled=false;
                document.all.clCal3C.disabled=false;
                //document.all.clCal4C.disabled=false;

                document.all.clCalE1C.value='';
                document.all.clCalE2C.value='';
                document.all.clCalE3C.value='';
                /*document.all.clCalE4C.value='';
                document.all.clCalE5C.value='';
                document.all.clCalE6C.value='';*/

                document.all.clCalE1C.disabled=false;
                document.all.clCalE2C.disabled=false;
                document.all.clCalE3C.disabled=false;
                /*document.all.clCalE4C.disabled=false;
                document.all.clCalE5C.disabled=false;
                document.all.clCalE6C.disabled=false;*/
            }
        }

        function fnMuestraTotalDent(){
            if(document.all.clEstatusSup.value == 1){
                document.all.TotalDent.style.visibility="visible";
            }else{
                document.all.TotalDent.style.visibility="hidden";
                document.all.SeguroDentalVTRC.value = '';
                document.all.clCausaRechaza.value = '';
            }
        }

        function fnDatosObligadosTotalDent(){
            if(document.all.clEstatusSup.value == 1){
                if(document.all.SeguroDentalVTRC.checked == false){
                    if(document.all.clCausaRechaza.value == ''){
                        msgVal=msgVal + " Causa.";
                    }
                }else{
                    document.all.SeguroDental.value = 1;
                }
                document.all.btnGuarda.disabled=false;
                document.all.btnCancela.disabled=false;
            }
        }

        function fnBloqueaCausa(){
            if(document.all.SeguroDentalVTRC.checked != false){
                document.all.clCausaRechaza.value = '';
                document.all.clCausaRechazaC.value = '';
                document.all.clCausaRechazaC.disabled = true;
            }else{
                document.all.SeguroDental.value = 0;
                document.all.clCausaRechaza.value = '';
                document.all.clCausaRechazaC.value = '';
                document.all.clCausaRechazaC.disabled = false;
            }
        }
                
        </SCRIPT>
    </body>
</html>