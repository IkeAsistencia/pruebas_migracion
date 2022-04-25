<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Costos Generales</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">

        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js' ></script>
        <script src='../Utilerias/UtilCostos.js' ></script>

        <%

            String StrclExpediente = "0";
            StringBuffer StrSql = new StringBuffer();
            String StrclUsrApp = "0";
            String StrclPaginaWeb = "0";
            String StrclCosto = "0";
            String StrclServicio = "0";
            String StrclSubServicio = "0";
            String strTotal = "";
            String strMontoL = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
                       return;
                   }

                   if (session.getAttribute("clExpediente") != null) {
                       StrclExpediente = session.getAttribute("clExpediente").toString();
                   }
                   if (session.getAttribute("clServicio") != null) {
                       StrclServicio = session.getAttribute("clServicio").toString();
                   }
                   if (session.getAttribute("clSubServicio") != null) {
                       StrclSubServicio = session.getAttribute("clSubServicio").toString();
                   }
                   if (request.getParameter("clCosto") != null) {
                       StrclCosto = request.getParameter("clCosto").toString();
                   }

                   StrSql.append(" select clExpediente, SUM(CostoSEA) 'CostoSEAT'");
                   StrSql.append(" FROM Costos");
                   StrSql.append(" Where clExpediente =").append(StrclExpediente).append("group by clExpediente");

                   ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
                   if (rs.next()) {
                       strTotal = rs.getString("CostoSEAT");
                       if (strTotal == null) {
                           strTotal = "";
                       }
                   }
                   rs.close();
                   rs = null;

                   StrSql.delete(0, StrSql.length());
                   StrSql.append(" select SxC.LimiteMonto as LimiteMonto");
                   StrSql.append(" from expediente E");
                   StrSql.append(" inner join ccobertura COB on (E.clCuenta = COB.clCuenta)");
                   StrSql.append(" inner join SubServicioxCobertura SxC on (COB.clCobertura = SxC.clCobertura and SxC.clServicio=").append(StrclServicio).append("and SxC.clSubServicio=").append(StrclSubServicio).append(")");
                   StrSql.append(" where clExpediente =").append(StrclExpediente);

                   rs = UtileriasBDF.rsSQLNP(StrSql.toString());
                   if (rs.next()) {
                       strMontoL = rs.getString("LimiteMonto");
                       if (strMontoL == null) {
                           strMontoL = "";
                       }
                   }

                   StrSql.delete(0, StrSql.length());

                   StrSql.append("Select coalesce(clPagoProveedor,'') as clPagoProveedor From Costos C");
                   StrSql.append(" left join cConceptoCosto CC on (CC.clConcepto = C.clConcepto) ");
                   StrSql.append(" INNER JOIN cProveedor P on(P.clProveedor=C.clProveedor) ");
                   StrSql.append(" Where clCosto =").append(StrclCosto);

                   ResultSet rsPago = UtileriasBDF.rsSQLNP(StrSql.toString());

                   StrSql.delete(0, StrSql.length());
                   StrSql.append("Select C.clCosto, P.clProveedor, p.NombreOpe 'dsProveedor',");
                   StrSql.append(" c.Concepto, c.CostoSEA, coalesce(C.CostoNU,0) CostoNU ");
                   StrSql.append(" FROM Costos C");
                   StrSql.append(" INNER JOIN cProveedor P on(P.clProveedor=C.clProveedor) ");
                   StrSql.append(" Where clCosto =").append(StrclCosto);

                   rs = UtileriasBDF.rsSQLNP(StrSql.toString());

        %><script>fnOpenLinks()</script><%       StrclPaginaWeb = "275";
               MyUtil.InicializaParametrosC(275, Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

               session.setAttribute("clPaginaWebP", StrclPaginaWeb);

        %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>DetalleCostosGrales.jsp?'>
        <%
            if (rsPago.next()) {
                if (rsPago.getString("clPagoProveedor").equalsIgnoreCase("0")) {
        %><script>document.all.btnElimina.disabled = false;
                     document.all.btnCambio.disabled = false;</script><%
                 } else {
        %><script>document.all.btnElimina.disabled = true;
                     document.all.btnCambio.disabled = true;</script><%
                         }
                     }
                     rsPago.close();
                     rsPago = null;

                     if (rs.next()) {
        %><INPUT id='clCosto' name='clCosto' type='hidden' value='<%=rs.getString("clCosto")%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='Nomina' name='Nomina' type='hidden' value='0'>
        <%=MyUtil.ObjComboC("Proveedor", "clProveedor", rs.getString("dsProveedor"), true, true, 30, 70, "", "sp_LlenaComboProvxExp " + StrclExpediente, "", "", 50, true, true)%>
        <%=MyUtil.ObjInput("Concepto", "Concepto", rs.getString("Concepto"), true, true, 30, 110, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Costo SEA", "CostoSEA", rs.getString("CostoSEA"), true, true, 30, 150, "", true, true, 7)%>
        <%
            if (StrclServicio.equals("27") || (StrclSubServicio.equals("27") || StrclSubServicio.equals("254") || StrclSubServicio.equals("282")
                    || StrclSubServicio.equals("283") || StrclSubServicio.equals("284") || StrclSubServicio.equals("285"))) {
            }// no despliega Costo NU en servicios legales
            else {
        %><%=MyUtil.ObjInput("Costo NU", "CostoNU", rs.getString("CostoNU"), true, true, 100, 150, "", false, false, 7)%><%
            }
        %><%=MyUtil.ObjInput("Costo SEA TOTAL", "CostoSEAT", strTotal, false, false, 170, 150, strTotal, false, false, 7)%>
        <%=MyUtil.ObjInput("Limite de cobertura", "LimiteMonto", strMontoL, false, false, 280, 150, strMontoL, false, false, 7)%>
        <div class='VTable' style='position:absolute; z-index:25; left:500px; top:80px;'>
            <INPUT type='button' VALUE='Registro de Pago' onClick='this.disabled = true;
                fnRegistraPago();' class='cBtn'></div>
            <%=MyUtil.DoBlock("Costo", 180, 0)%><%
            } else {
            %><INPUT id='clCosto' name='clCosto' type='hidden' value='0'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='Nomina' name='Nomina' type='hidden' value='0'>
        <%=MyUtil.ObjComboC("Proveedor", "clProveedor", "", true, true, 30, 70, "", "sp_LlenaComboProvxExp " + StrclExpediente, "", "", 50, true, true)%>
        <%=MyUtil.ObjInput("Concepto", "Concepto", "", true, true, 30, 110, "", true, true, 50)%>
        <%=MyUtil.ObjInput("Costo SEA", "CostoSEA", "", true, true, 30, 150, "", true, true, 7)%>
        <%
            if (StrclServicio.equals("27") || (StrclSubServicio.equals("27") || StrclSubServicio.equals("254") || StrclSubServicio.equals("282")
                    || StrclSubServicio.equals("283") || StrclSubServicio.equals("284") || StrclSubServicio.equals("285"))) {
            }// no despliega Costo NU en servicios legales
            else {%>
        <%=MyUtil.ObjInput("Costo NU", "CostoNU", "", true, true, 100, 150, "", false, false, 7)%>
        <%
            }
        %><%=MyUtil.ObjInput("Costo SEA TOTAL", "CostoSEAT", strTotal, false, false, 170, 150, strTotal, false, false, 7)%>
        <%=MyUtil.ObjInput("Limite de cobertura", "LimiteMonto", strMontoL, false, false, 280, 150, strMontoL, false, false, 7)%>
        <div class='VTable' style='position:absolute; z-index:25; left:500px; top:80px;'>
            <INPUT type='button' VALUE='Registro de Pago' onClick='this.disabled = true;
                fnRegistraPago();' class='cBtn'></div>
            <%=MyUtil.DoBlock("Costo", 180, 0)%><%
                }
            %><%=MyUtil.GeneraScripts()%><%
           rs.close();
           rs = null;

            %>

        <script>
            /*function fncomparecosto(){
             var sum;
             sum = document.all.CostoSEA.value + document.all.CostoSEAT.value;
             if (sum > document.all.LimiteMonto.value){
             msgVal = msgVal + "El Costo SEA Total a revasado el Limite de la cobertura";
             document.all.CostoSEA.value = "";
             }
      
             }*/
        </script>
    </body>
</html>




