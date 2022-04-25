<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title>Información Proveedor</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" SCROLL = YES>
        <script type="text/javascript" src='../Utilerias/Util.js'></script>
        <%
            String StrclProveedor = "0";
            String StrclAreaOperativa = "0";
            String StrclCentroAtencion = "0";
            String StrclSubServicio = "0";
            String StrclCuenta = "0";
            String StrLimiteCosto = "";
            String StrObservaciones = "";
            int TotalValores = 0;

            if (request.getParameter("clProveedor") != null) {
                StrclProveedor = request.getParameter("clProveedor").toString();
            }

            if (request.getParameter("clCentroAtencion") != null) {
                StrclCentroAtencion = request.getParameter("clCentroAtencion").toString();
            }

            if (session.getAttribute("clSubServicio") != null) {
                StrclSubServicio = session.getAttribute("clSubServicio").toString();
            }

            if (session.getAttribute("clCuenta") != null) {
                StrclCuenta = session.getAttribute("clCuenta").toString();
            }

            StringBuffer strSQL = new StringBuffer();

            strSQL.append("st_getInfoOperProvDet ").append(StrclProveedor);

            ResultSet rs = UtileriasBDF.rsSQLNP(strSQL.toString());
            strSQL.delete(0, strSQL.length());

            if (rs.next()) {
                StrclAreaOperativa = rs.getString("clAreaOperativa");
                StrObservaciones = rs.getString("Observaciones");
        %>
    <center>
        <table border=1 class='FTable'>
            <tr><td class='cssTitDet' colspan="2">Nombre del Proveedor : </td><td colspan="2"><%=rs.getString("NombreOpe")%> </td></tr>
            <tr><td class='TTable'>Nombre Razón Social : </td><td><%=rs.getString("NombreRZ")%> </td>
                <td class='TTable'>Titular : </td><td><%=rs.getString("Titular")%> </td></tr>
            <tr><td class='TTable'>Horario: </td><td colspan="3"><%=rs.getString("Horario")%> </td></tr>
            <%
                if (StrclAreaOperativa.equalsIgnoreCase("8")) {%>
            <tr><td class='Blanco'>Especialidad : </td><td><%=rs.getString("dsEspecialidad")%></td><td class='Blanco'>SubEspecialidad : </td><td><%=rs.getString("dsSubEspecialidad")%></td></tr>
            <%} else {
                }

                if (!StrclAreaOperativa.equalsIgnoreCase("8") && !StrclAreaOperativa.equalsIgnoreCase("9")) {
                    strSQL.append("st_getInfoOperProvxP ").append(StrclProveedor);

                    ResultSet rsPersonal = UtileriasBDF.rsSQLNP(strSQL.toString());
                    strSQL.delete(0, strSQL.length());

                    while (rsPersonal.next()) {
            %><tr><td class='TitResumen'>Nombre del Personal</td>
                <td><%=rsPersonal.getString("Nombre")%></td>
                <td colspan="2">
                    <%
                        strSQL.append("st_getInfoOperProvPersonal ").append(rsPersonal.getString("clPersonalxProv"));

                        ResultSet rsContactos = UtileriasBDF.rsSQLNP(strSQL.toString());
                        strSQL.delete(0, strSQL.length());

                        while (rsContactos.next()) {
                    %><table class='FTable'><tr><td><%=rsContactos.getString("dsTipoContacto")%></td><td><%=rsContactos.getString("Contacto")%></td></tr></table>
                                <% }%>
                </td>
            </tr>
            <% }
                if ((StrclAreaOperativa.compareToIgnoreCase("3") == 0) || (StrclAreaOperativa.compareToIgnoreCase("5") == 0) || (StrclAreaOperativa.compareToIgnoreCase("1") == 0)) {
                    if (!StrObservaciones.equalsIgnoreCase("")) {
            %><tr><td class='TitResumen'>Observaciones</td><td class='FTable'colspan="3" ><%=StrObservaciones%></td></tr><%
                    }
                }
                if (StrclAreaOperativa.equalsIgnoreCase("1")) {
                    strSQL.append("st_getInfoOperProv ").append(StrclProveedor);

                    ResultSet rsCostos = UtileriasBDF.rsSQLNP(strSQL.toString());
                    strSQL.delete(0, strSQL.length());
                %>
            <tr><td colspan="4" class='cssTitDet' align="center">Lista de Costos</td></tr>
            <tr><td colspan="4">
                    <table border=1 class='FTable'  width="100%">
                        <tr>
                            <td class='TTable' align="center">SubServicio </td>
                            <td class='TTable' align="center">Concepto</td>
                            <td class='TTable' align="center">Costo </td>
                            <td class='TTable' align="center">Número </td>
                            <td class='TTable' align="center">Parcial </td>
                        </tr>
                        <%
                            int contador = 0;

                            while (rsCostos.next()) {
                                String Cantidad = "Cantidad" + String.valueOf(contador);
                                String Costos = "Costo" + String.valueOf(contador);
                                String Suma = "Suma" + String.valueOf(contador);
                        %>
                        <tr><td><%=rsCostos.getString("dsSubservicio")%></td><td><%=rsCostos.getString("dsConcepto")%></td><td><%=rsCostos.getString("Costo")%>
                            </td>
                            <td><INPUT STYLE="font-weight:bold" ALIGN="center" id= '<%=Cantidad%>' name= '<%=Cantidad%>' type='text' VALUE='0' class='cssBlanco' size="10" onblur="fnCalculadora('<%=Cantidad%>', '<%=Suma%>', '<%=Costos%>')"></td>
                            <td><INPUT STYLE="font-weight:bold" id= '<%=Suma%>' name= '<%=Suma%>' type='text' VALUE='0' class='cssBlanco' size="10" readonly='readonly' ></td> </tr>
                        <td><INPUT id= '<%=Costos%>' name= '<%=Costos%>' type='hidden' VALUE=<%=rsCostos.getString("Costo")%> class='cssBlanco' size="10"></td>
                            <%
                                    contador = contador + 1;
                                }
                                TotalValores = contador;
                            %>
                        <td></td>
                        <td></td>
                        <td class='TTable' align="center">Total</td>
                        <td>
                            <Input STYLE="font-weight:bold" id='SumaTotal' name='SumaTotal' type='text' VALUE = '0' class='cBtn' readonly='readonly' size="10" ></td>
                            <%
                                strSQL.append(" st_getInfoOperProvCob ").append(StrclCuenta).append(",").append(StrclSubServicio);
                                //System.out.println(strSQL);
                                ResultSet rsLimiteCosto = UtileriasBDF.rsSQLNP(strSQL.toString());
                                strSQL.delete(0, strSQL.length());

                            %>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class='TTable' align="center">Cobertura</td>
                            <%if (rsLimiteCosto.next()) {
                                    StrLimiteCosto = rsLimiteCosto.getString("LimiteMonto");
                                }
                                rsLimiteCosto.close();
                                rsLimiteCosto = null;

                            %>
                            <td><Input STYLE="font-weight:bold" id='Cobertura' name='Cobertura' type='text' VALUE = "<%=StrLimiteCosto%>" class='cssBlanco' size="10"  ONBLUR="ImptTotal()"></td>
                        </tr>

                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class='TTable' align="center">A Cargo de N/U</td>
                            <td><Input STYLE="font-weight:bold" id='Imptotal' name='Imptotal' type='text' VALUE = '0' class='cBtn' size="10" ></td>
                        </tr>
                    </table></td></tr>
                    <%
                        }
                    } else {
                        strSQL.append("st_getInfoOperProvCentroContacto ").append(StrclCentroAtencion);

                        ResultSet rsCA = UtileriasBDF.rsSQLNP(strSQL.toString());
                        strSQL.delete(0, strSQL.length());
                        if (rsCA.next()) {
                    %>
            <tr><td class='cssAzul' colspan="4"><%=rsCA.getString("dsTipoCentroAtencion")%> : <%=rsCA.getString("NmbCentroAtecion")%></td></tr>
            <tr><td class='TitResumen'><%=rsCA.getString("PuestoContacto")%></td><td><%=rsCA.getString("Contacto")%></td><td>Tel:<%=rsCA.getString("Telefono1")%></td><td>Tel:<%=rsCA.getString("Telefono2")%></td></tr>
            <tr>
                <td>Provincia:<%=rsCA.getString("dsEntFed")%></td>
                <td>Localidad:<%=rsCA.getString("dsMunDel")%></td>
                <td>Colonia:<%=rsCA.getString("Colonia")%></td>
                <td>Calle:<%=rsCA.getString("CalleNum")%></td>
            </tr>
            <tr>
                <td>CP:<%=rsCA.getString("CP")%></td>
                <td>Horario:<%=rsCA.getString("Horario")%></td>
                <td colspan="2">Observaciones:<%=rsCA.getString("Observaciones")%></td>
            </tr>
            <%
                if (StrclAreaOperativa.equalsIgnoreCase("9")) {
                    strSQL.append("st_getInfoOperProvCentroAtencion ").append(StrclCentroAtencion);

                    ResultSet rsSM = UtileriasBDF.rsSQLNP(strSQL.toString());
                    strSQL.delete(0, strSQL.length());
            %><tr>
                <td class='Blanco'>Servicio Medico : </td><td colspan="3">
                    <%
                        while (rsSM.next()) {
                    %>
                    <%=rsSM.getString("dsServicioMedico")%><br>
                    <%
                        }

                        //Fin de While rsSM
                    %>
                </td>
            </tr>
            <%                                    rsSM.close();
                                rsSM = null;
                            }
                            //Fin IF AreaOperativa 9
                        }
                        //Fin de While rsCA
                        rsCA.close();
                        rsCA = null;
                    }
                }

                rs.close();
                rs = null;

                StrclProveedor = null;
                StrclAreaOperativa = null;
                StrclCentroAtencion = null;
                StrclSubServicio = null;
                StrclCuenta = null;
                StrLimiteCosto = null;
            %>
        </table>
    </center>

    <script type="text/javascript">
        function fnCalculadora(Cantidad, Suma, Costos) {
            if (IsNumeric(document.getElementById(Cantidad).value) == false) {
                document.getElementById(Cantidad).value = "0";
                alert("Debes ingresar un valor numérico.");
            }

            Valor = eval(parseFloat(document.getElementById(Cantidad).value) * parseFloat(document.getElementById(Costos).value));
            document.getElementById(Suma).value = Valor.toFixed(2);

            var Total = 0;
            for (cont = 0; cont < parseInt(<%=String.valueOf(TotalValores)%>); cont++) {
                Nombsuma = ('Suma' + cont);
                Total = Total + (parseFloat(document.getElementById(Nombsuma).value));
            }
            document.all.SumaTotal.value = Total.toFixed(2);
            ImporteTot = eval(parseFloat(document.all.SumaTotal.value) - parseFloat(document.all.Cobertura.value));
            document.all.Imptotal.value = ImporteTot.toFixed(2);
        }

        function ImptTotal() {
            if (IsNumeric(document.all.Cobertura.value) == false) {
                document.all.Cobertura.value = "0";
                alert("Debes ingresar un valor numérico.");
            }

            ImporteTot = eval(parseFloat(document.all.SumaTotal.value) - parseFloat(document.all.Cobertura.value));
            document.all.Imptotal.value = ImporteTot.toFixed(2);
            Nflotante = parseFloat(document.all.Cobertura.value);
            document.all.Cobertura.value = Nflotante.toFixed(2);
        }

        function IsNumeric(sText) {
            var ValidChars = "0123456789. ";
            var IsNumber = true;
            var Char;

            if (sText == "" || sText == " ") {
                IsNumber = false;
            }
            for (i = 0; i < sText.length && IsNumber == true; i++) {
                Char = sText.charAt(i);
                if (ValidChars.indexOf(Char) == -1) {
                    IsNumber = false;
                }
            }
            return IsNumber;
        }
    </script>
</body>
</html>