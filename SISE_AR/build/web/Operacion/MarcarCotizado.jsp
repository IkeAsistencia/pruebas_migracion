<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>                                                               
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilMask.js'></script> 
        <%
            String StrclExpediente = "";
            String StrCotizacion = "0";
            String StrVerificar = "";
            String StrBox = "";
            String StrclProveedor = "0";
            String StrclEstatus = "";
            String StrclUsrApp = "0";

            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            StringBuffer StrSql = new StringBuffer();

            StrSql.append(" Select E.clEstatus, E.Cotizacion, coalesce(PXE.clProveedor,0)clProveedor from Expediente E ");
            StrSql.append(" left join ProveedorxExpediente PXE on (E.clExpediente=PXE.clExpediente) ");
            StrSql.append(" where E.clExpediente=").append(StrclExpediente);

            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs.next()) {
                StrCotizacion = rs.getString("Cotizacion");
                StrclProveedor = rs.getString("clProveedor");
                StrclEstatus = rs.getString("clEstatus");

                if ((!StrclEstatus.equalsIgnoreCase("0") || !StrclProveedor.equalsIgnoreCase("0")) && (StrCotizacion.equalsIgnoreCase("0"))) {

        %> <div id='Estatus' Name='Estatus' class='VTable' style='position:absolute; z-index:11; left:30px; top:30px;'><p class='Rojo'>El Expediente no puede ser cotizado ya<br> que no esta abierto o tiene proveedor</p> </div>
                <%     } else { %>
        <form id='Forma' name ='Forma' action='../servlet/Utilerias.GuardaCotizado' method='get'>
            <%
            if (StrCotizacion.equalsIgnoreCase("0")) {%>
            <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrApp%>'>
            <INPUT id='Verificar' name='Verificar' type='hidden' value='1'>
            <table><tr>
                    <td class='VTable'>USUARIO: </td>
                    <td><INPUT id='cUsrAut' name='cUsrAut' type='text' value=''></td>
                </tr>
                <tr>
                    <td class='VTable'>PASSWORD: </td>
                    <td><INPUT id='Password' name='Password' type='password' value=''></td>
                </tr>
                <tr>
                    <td><input type="button" value="Guardar" onClick="fnValidaCotizado();" ></input></td>
                </tr>
            </table>

            <div id='D11' Name='D11' class='VTable' style='position:absolute; z-index:11; left:30px; top:130px;'><p class='FTable'>
                    <INPUT type='hidden' value='1' id='Cotizar' name='Cotizar'>
                    <INPUT class='VTable' type='checkbox' id='CotizarC' name='CotizarC' onClick="if (this.checked) {
                    Cotizar.value = 1;
                    document.all.Valida.style.visibility = 'hidden';
                } else {
                    Cotizar.value = 0;
                }" checked>Cotizado</P></div>
            <div class='cssBGDetSw' style='background-color:#052145; position:absolute; z-index:1; left:30px; top:120px; width:470px; height:70px;'><p class='cssTitDet'></p></div><div class='cssBGDet' style='position:absolute; z-index:2; left:20px; top:110px; width:470px; height:70px;'><p class='cssTitDet'>Cotizando</p></div>

            <%} else {%>
            <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrApp%>'>
            <INPUT id='Verificar' name='Verificar' type='hidden' value='0'>
            <table>
                <tr><td>&nbsp</td></tr>
                <tr><td>&nbsp</td></tr>
                <tr>
                    <td><input type="button" value="Guardar" onClick="this.disabled = true;
                document.all.Forma.submit();" ></input></td>
                </tr>
            </table>

            <div id='D11' Name='D11' class='VTable' style='position:absolute; z-index:11; left:30px; top:130px;'><p class='FTable'>
                    <INPUT type='hidden' value='0' id='Cotizar' name='Cotizar'>
                    <INPUT class='VTable' type='checkbox' id='CotizarC' name='CotizarC' onClick="if (this.checked) {
                    Cotizar.value = 1;
                } else {
                    Cotizar.value = 0;
                }" unchecked>Cotizado</P></div>
            <div class='cssBGDetSw' style='background-color:#052145; position:absolute; z-index:1; left:30px; top:120px; width:470px; height:70px;'><p class='cssTitDet'></p></div><div class='cssBGDet' style='position:absolute; z-index:2; left:20px; top:110px; width:470px; height:70px;'><p class='cssTitDet'>Cotizando</p></div>
                <%}
                        }
                    }
                %>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        </form>
        <div id='Valida' Name='Valida' class='VTable' style='position:absolute; z-index:11; left:120px; top:140px; visibility:hidden'><p class='Rojo'>Debe dar click en la caja de cotizado</p> </div>
        <%
            StrclExpediente = null;
        %>
        <script>
            function fnValidaCotizado() {

                if (document.all.Verificar.value == "1" && document.all.Cotizar.value == "0") {
                    document.all.Valida.style.visibility = 'visible';
                } else {
                    this.disabled = true;
                    document.all.Forma.submit();
                }
            }

        </script>
    </body>
</html>