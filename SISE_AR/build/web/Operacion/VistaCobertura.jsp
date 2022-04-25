<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title>Cobertura</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <script type="text/javascript" src='Util.js'></script>
        <%
            String strclUsr = "0";
            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();      }
            if(SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true){
                %><font color="white"  style="font-family:Verdana,Arial,Helvetica,sans-serif; background-color:red;" size=3>LA SESION EXPIRO</font><%  
                strclUsr=null;
                return;
                }
            String clCuenta = "0";
            String StrclCoberturaMixta = "";
            StringBuffer StrSql = new StringBuffer();
            String StrRutaCondicionados = "";
            if (request.getParameter("clCuenta") != null) {     clCuenta = request.getParameter("clCuenta").toString();
            } else {     return;       }
            StrSql.append(" st_getCoberturas ").append(clCuenta);
            ResultSet rs2 = null;
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            if (rs.next()) {
                StrRutaCondicionados = rs.getString("Condicionado");
                if (!StrRutaCondicionados.equalsIgnoreCase("")) {%>
                    <div class='VTable' style='position:absolute; z-index:35; left:12px; top:20px;'>
                        <input name ='btnVerCond' id="btnVerCond" type='button' value='Ver Condicionado' class='cBtn' onclick ="openPDF('<%=StrRutaCondicionados%>')">
                    </div>
                    <br><br>
                    <% }%>
                <table width='990px' class='cssTitDet'><tr><td Valign=top>Cobertura</td></tr></table>
                <table width='990px' Border=1 Class='vTable'>
                    <tr>
                        <td colspan="6" class="TitC"><%=rs.getString(1)%></td>
                    </tr>
                    <TR>
                        <td Valign=top>USUARIOS Y/O BENEFICIARIOS</td><td Valign=top>TELEFONO ASISTENCIA</td><td Valign=top>TELEFONO ATENCION A CLIENTES</td>
                        <td Valign=top>TELEFONO VALIDACION</td><td Valign=top>DATOS VALIDACION</td><td Valign=top>VIGENCIA CUENTA</td>
                    </TR>
                    <TR>
                        <TD><%=rs.getString(2)%></TD>
                        <TD><%=rs.getString(3)%></TD>
                        <TD><%=rs.getString(4)%></TD>
                        <TD><%=rs.getString(5)%></TD>
                        <TD><%=rs.getString(6)%></TD>
                        <TD><%=rs.getString(7)%></TD>
                    </TR>
                </table>
                <%}
            rs.close();
            rs = null;
            StrSql.append(" st_getPuntosCobertura ").append(clCuenta);
            rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            StrSql = null;
            %>
            <BR>
            <table width='990px' class='cssTitDet'><tr><td Valign=top>SubServicios por Cobertura</td></tr></table>
            <TABLE width='990px' Border=1 Class='vTable'>
                <TR>
                    <td Valign=top>SERVICIO</td>
                    <td Valign=top>SUBSERVICIO</td>
                    <td Valign=top>LIMITE MONTO</td>
                    <td Valign=top>LIMITE EVENTOS</td>
                    <td Valign=top>LIMITE EVENTOS MENSUAL</td>
                    <td Valign=top>SERVICIO ADICIONAL</td>
                    <td Valign=top>LIMITE SERVICIO ADICIONAL</td>
                    <td Valign=top>PUNTOS IMPORTANTES</td>
                    <td Valign=top>EXCLUSIONES</td>
                </TR>
            <% while (rs.next()) {%>
            <TR>  
                <TD Valign=top><%=rs.getString(1)%></TD>
                <TD Valign=top><%=rs.getString(2)%></TD>
                <TD Valign=top><%=rs.getString(3)%></TD>
                <TD Valign=top><%=rs.getString(4)%></TD>
                <TD Valign=top><%=rs.getString(5)%></TD>
                <TD Valign=top><%=rs.getString(6)%></TD>
                <TD Valign=top><%=rs.getString(7)%></TD>
                <TD Valign=top><%=rs.getString(8)%></TD>
                <TD Valign=top><%=rs.getString(9)%></TD>
            </TR>
                <%}
            rs.close();
            rs = null;
            rs = UtileriasBDF.rsSQLNP(" st_ListaCoberturasMIX " + clCuenta);
            while (rs.next()) {
                StrclCoberturaMixta = rs.getString("clCoberturaMixta"); %>
                <tr class='cssTitDet'>
                    <td colspan="2">Cob. Mixta: <%=rs.getString("dsCoberturaMixta")%></td>
                    <td colspan="2">Limite Monto: <%=rs.getString("LimiteMonto")%></td>
                    <td colspan="2">Limite Eventos: <%=rs.getString("LimiteEventos")%></td>
                </tr>
                <tr class='vTable'><td Valign=top>SERVICIO</td><td >SUBSERVICIO</td><td colspan="3">PUNTOS IMPORTANTES</td><td colspan="1">EXCLUSIONES</td></tr> 
                <%rs2 = UtileriasBDF.rsSQLNP(" st_ListaSubServCobMIXnoLink " + StrclCoberturaMixta);
                while (rs2.next()) {%>
                    <tr class="vTable">
                        <td Valign=top><%=rs2.getString("Servicio")%></td>
                        <td Valign=top><%=rs2.getString("SubServicioCob")%></td>
                        <td colspan="2"><%=rs2.getString("PuntosImp")%></td>
                        <td colspan="2"><%=rs2.getString("Exclusiones")%></td>
                    </tr>
                    <%}
                    rs2.close();
                    rs2 = null;
                }
            rs.close();
            rs = null;
            %>
            </TABLE>
            <table width='990px' class='cssTitDet'><tr><td>SubServicios Opcionales por Cobertura</td></tr></table>
            <table width='990px' Border=1 Class='vTable'>  
                <tr class="TitC">
                    <td>SERVICIO</td>
                    <td>SUBSERVICIO</td>
                    <td>ALCANCE</td>
                    <td>LIMITE MONTO</td>
                    <td>LIMITE EVENTOS</td>
                    <td>MONEDA</td>
                    <td>PUNTOS IMPORTANTES</td>
                    <td>EXCLUSIONES</td>
                </tr>
                <%ResultSet rs3 = null;
                rs3 = UtileriasBDF.rsSQLNP(" st_getPuntosCoberturaSubOpcional '" + clCuenta.toString() + "',''");
                int i = 0;
                if (rs3.next()) { i = rs3.getRow(); %>
                    <tr>
                        <td><%=rs3.getString(1)%></td>
                        <td><%=rs3.getString(2)%></td>
                        <td><%=rs3.getString(3)%></td>
                        <td><%=rs3.getString(4)%></td>
                        <td><%=rs3.getString(5)%></td>
                        <td><%=rs3.getString(6)%></td>
                        <td><%=rs3.getString(7)%></td>
                        <td><%=rs3.getString(8)%></td>
                    </tr>
                    <%} // fin while
                if (i == 0) {%>
                    <td>No Cuenta con SubServicios Opcionales</td>  <% }
                rs3.close();
                rs3 = null; %>
            </table>
            <%
            clCuenta = null;
            StrclCoberturaMixta = null;
            StrSql = null;
            StrRutaCondicionados = null;
            %>
    <script>
//------------------------------------------------------------------------------        
        function openPDF(file) {
            location.href(file);   }
//------------------------------------------------------------------------------
    </script>
    </body>
</html>