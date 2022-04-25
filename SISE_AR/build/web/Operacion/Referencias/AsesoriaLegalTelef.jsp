<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>JSP Page</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head> 
    <body class="cssBody">
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 

        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <%
            String StrclExpediente = "0";
            String StrclUsrApp = "0";
            String StrclPaginaWeb = "344";
            String StrFecha = "";
            String StrclSubServicio = "";
            String StrdsSubServicio = "";
            

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            
            if (session.getAttribute("clSubServicio") != null) {
                StrclSubServicio = session.getAttribute("clSubServicio").toString();
            }
            
            if (session.getAttribute("dsSubServicio") != null) {
                StrdsSubServicio = session.getAttribute("dsSubServicio").toString();
            }
            
            System.out.println("StrclSubServicio: "+StrclSubServicio);
            System.out.println("StrclSubServicio: "+StrclSubServicio);
            System.out.println("StrclSubServicio: "+StrclSubServicio);
            
            System.out.println("StrdsSubServicio: "+StrdsSubServicio);
            System.out.println("StrdsSubServicio: "+StrdsSubServicio);
            System.out.println("StrdsSubServicio: "+StrdsSubServicio);
            
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %><%="Fuera de Horario"%><%
                return;
            }

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }
            
            StringBuffer StrSql1 = new StringBuffer();
            // checar si ya existe asistencia para el expediente, si existe, ya no procede la alta
            StrSql1.append(" Select TieneAsistencia, CodEnt From Expediente");
            StrSql1.append(" Where clExpediente=").append(StrclExpediente);
            ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql1.toString());
            StrSql1.delete(0, StrSql1.length());

            if (rs2.next()) {   //StrCodEnt=rs2.getString("CodEnt"); 
            } else {
                 %><%="El expediente no existe"%><%
                   rs2.close();
                   return;
               }

            ResultSet rs3 = UtileriasBDF.rsSQLNP("Select convert(varchar(20),getdate(),120) FechaApertura ");
            if (rs3.next()) {
                StrFecha = rs3.getString("FechaApertura");
            }

            StrSql1.append(" Select ");
            StrSql1.append(" coalesce(RD.dsRamaDerecho,'') as dsRamaDerecho,");
            StrSql1.append(" convert(varchar(16),AL.FechaApertura,120) as FechaApertura,");
            StrSql1.append(" convert(varchar(16),AL.FechaRegistro,120) as FechaRegistro");
            StrSql1.append(" From AsesoriaLegalTelef AL");
            StrSql1.append(" Left Join cRamaDerecho RD ON (AL.clRamaDerecho=RD.clRamaDerecho)");
            StrSql1.append(" Where AL.clExpediente=").append(StrclExpediente);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql1.toString());
            StrSql1.delete(0, StrSql1.length());
            %>
                <script>fnOpenLinks()</script>
            <%
            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="AsesoriaLegalTelef.jsp?'>"%>
        <% if (rs.next()) { %>
            <script>document.all.btnAlta.disabled = true;</script>
            <script>document.all.btnElimina.disabled = true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjComboC("Rama del Derecho", "clRamaDerecho", rs.getString("dsRamaDerecho"), true, true, 30, 80, "", "Select clRamaDerecho,dsRamaDerecho from cRamaDerecho", "", "", 140, true, true)%>
            <%=MyUtil.ObjInput("Fecha de Apertura", "FechaApertura", rs.getString("FechaApertura"), false, false, 270, 80, "", false, false, 30)%>
            <%=MyUtil.ObjInput("Fecha de Registro", "FechaRegistroVTR", rs.getString("FechaRegistro"), false, false, 490, 80, "", false, false, 30)%>
            <%=MyUtil.DoBlock(StrdsSubServicio, 0, 0)%>
        <% } else { %>
            <script>document.all.btnCambio.disabled = true;</script>
            <script>document.all.btnElimina.disabled = true;</script>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <%=MyUtil.ObjComboC("Rama del Derecho", "clRamaDerecho", "", true, true, 30, 80, "", "Select clRamaDerecho,dsRamaDerecho from cRamaDerecho", "", "", 140, true, true)%>
            <%=MyUtil.ObjInput("Fecha de Apertura", "FechaApertura", "", false, false, 270, 80, StrFecha, false, false, 30)%>
            <%=MyUtil.ObjInput("Fecha de Registro", "FechaRegistroVTR", "", false, false, 490, 80, "", false, false, 30)%>
            <%=MyUtil.DoBlock(StrdsSubServicio, 0, 0)%>
        <% } %>
        <%=MyUtil.GeneraScripts()%>
        <%
            rs2.close();
            rs3.close();
            rs.close();
            rs2 = null;
            rs3 = null;
            rs = null;

            StrclExpediente = null;
            StrSql1 = null;
            StrclUsrApp = null;
            StrclPaginaWeb = null;
            StrFecha = null;

        %>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
    </body>
</html>

