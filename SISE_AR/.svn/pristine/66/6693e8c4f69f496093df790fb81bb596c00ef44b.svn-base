<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head><title></title></head>
    <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    <body class="cssBody">

        <script src='Util.js'></script>
        <%
            com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es", "AR");
            String clClave = request.getParameter("Clave");
            String strEntreCalles;

            StringBuffer StrSql = new StringBuffer();
            StrSql.append(" select A.Clave as 'Clave', A.Nombre as 'NomUsu', IA.Calle as 'Direccion',IA.EntreCalles 'EntreCalles',IA.CP as 'CP',");
            StrSql.append(" A.FechaIni as 'FechIni', A.FechaFin as 'FechFin', IA.TelAfiliado as 'Telefono'");
            StrSql.append(" from expediente  E");
            StrSql.append(" inner join cafiliadoADT A on (E.clave=A.clave)");
            StrSql.append(" inner join AfiliadoInfoAdicionalADT IA on (A.clAfiliado=IA.clAfiliado)");
            StrSql.append(" inner join ContratoxCuenta CC on (A.clContrato=CC.clContrato and A.clCuenta=CC.clCuenta)");
            StrSql.append(" inner join ccuenta CU on  (E.clcuenta=CU.clcuenta)");
            StrSql.append(" left join cEntFed EF on (IA.CodEnt=EF.CodEnt)");
            StrSql.append("where E.clave='").append(clClave).append("'");

            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            if (rs.next()) {
        %>

        <table class="FTable" width="76%" border="0" cellspacing="1" cellpadding="1">
            <tr> 
                <td colspan="2"> <div align="right"></div>
                    <div align="left"></div>
                    <div align="right"></div></td>
                <td width="5%" colspan="-2"  class="TTable">Clave:</td>
                <td colspan="3" class="cssBGDet" ><%=rs.getString("Clave")%></td>
            </tr>
            <tr> 
                <td colspan="6">&nbsp;</td>
            </tr>
            <tr> 
                <td colspan="3"> <div align="center"></div></td>
                <td colspan="2"><div align="center" class="TTable">Fecha de vigencia<br>(aaaa/mm/dd)</div></td>
                <td width="28%">&nbsp;</td>
            </tr>
            <tr> 
                <td colspan="3"> <div align="left"></div></td>
                <td width="19%"><div align="center" class="TTable">Inicio</div></td>
                <td width="21%"><div align="center" class="TTable">Fin</div></td>
                <td>&nbsp;</td>
            </tr>
            <tr> 
                <td colspan="3"> <div align="left"></div></td>
                <td><div align="center" class="cssBGDet"><%=rs.getString("FechIni").substring(0, 10)%></div>
                    <div align="center"></div></td>
                <td><div align="center" class="cssBGDet"><%=rs.getString("FechFin").substring(0, 10)%></div>
                    <div align="center"></div></td>
                <td>&nbsp;</td>
            </tr>
            <tr> 
                <td colspan="6">&nbsp;</td>
            </tr>
            <tr> 
                <td class="TTable">Nombre Usuario:</td>
                <td colspan="5" class="cssBGDet"><%=rs.getString("NomUsu")%></td>
            </tr>
            <tr> 
                <td width="18%" class="TTable">Direccion: </td>
                <td colspan="5" class="cssBGDet"><%=rs.getString("Direccion")%> </td>
            </tr>
            <tr> 
                <%strEntreCalles = rs.getString("EntreCalles");%>
                <td width="18%" class="TTable">Entre Calles:</td>
                <td colspan="5" class="cssBGDet"><%=strEntreCalles != null ? strEntreCalles : "&nbsp;"%> </td>
            </tr>
            <tr> 
                <td class="TTable"><%=i18n.getInstance("es", "AR").getMessage("message.title.cp")%> :</td>
                <td colspan="5" class="cssBGDet"> <div align="left"><%=rs.getString("CP")%></div>
                    <div align="left"></div></td>
            </tr>
            <tr> 
                <td class="TTable">Telefono:</td>
                <td colspan="5" class="cssBGDet"><%=rs.getString("Telefono")%></td>
            </tr>
        </table>

        <%
        } else {
        %>
        No Existe Información
        <%            }
        %>
    </body>
</html>

