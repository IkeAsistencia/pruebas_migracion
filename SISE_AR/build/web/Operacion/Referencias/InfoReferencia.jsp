<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <title></title>
    </head>
    <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 

    <script src='../../Utilerias/Util.js' ></script>
    <%
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es", "AR");
        String StrclUsrApp = "0";
        String StrclReferencia = "0";
        String StrclCuenta = "0";
        String StrReferencia = "0";
        String StrdsCategoria = "0";
        String StrdsSubCategoria = "0";
        String StrdsEntFed = "0";
        String StrdsMunDel = "0";
        String StrColonia = "0";
        String StrCP = "0";
        String StrCalle = "0";
        String StrTelefono = "0";
        String StrHorario = "0";
        String StrObservaciones = "0";
        String StrFechaAlta = "0";

        if (session.getAttribute("clUsrApp") != null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if (session.getAttribute("clCuenta") != null) {
            StrclCuenta = session.getAttribute("clCuenta").toString();
        }

        if (request.getParameter("clReferencia") != null) {
            StrclReferencia = request.getParameter("clReferencia").toString();
        }

        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
    %><%="Fuera de Horario"%><%
                    return;
                }
    %><body class='cssBody' topmargin='10'>
        <%
            StringBuffer StrSql = new StringBuffer();

            StrSql.append("Select coalesce(R.dsReferencia,'') dsReferencia,coalesce(C.dsCategoria,'') dsCategoria, ");
            StrSql.append(" coalesce(SC.dsSubCategoria,'') dsSubCategoria,coalesce(EF.dsEntFed,'') dsEntFed,");
            StrSql.append(" coalesce(MD.dsMunDel,'') dsMunDel,coalesce(R.Colonia,'') Colonia,coalesce(R.CP,'') CP,");
            StrSql.append(" coalesce(R.Calle,'') Calle,coalesce(R.Telefonos,'') Telefonos,coalesce(R.Horario,'') Horario,");
            StrSql.append(" coalesce(R.Observaciones,'') Observaciones,coalesce(R.FechaAlta,'') FechaAlta");
            StrSql.append(" from cReferencia R");
            StrSql.append(" left join cCategoria C on (C.clCategoria=R.clCategoria)");
            StrSql.append(" left join cSubCategoria SC on (SC.clSubCategoria=R.clSubCategoria)");
            StrSql.append(" left join cEntFed EF on (EF.CodEnt= R.CodEnt)");
            StrSql.append(" left join cMunDel MD on (MD.CodMD=R.CodMD and MD.CodEnt=EF.CodEnt)");
            StrSql.append(" where clReferencia = ").append(StrclReferencia);


            ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs2.next()) {
                StrReferencia = rs2.getString("dsReferencia");
                if (StrReferencia == null) {
                    StrReferencia = "";
                }

                StrdsCategoria = rs2.getString("dsCategoria");
                if (StrdsCategoria == null) {
                    StrdsCategoria = "";
                }

                StrdsSubCategoria = rs2.getString("dsSubCategoria");
                if (StrdsSubCategoria == null) {
                    StrdsSubCategoria = "";
                }

                StrdsEntFed = rs2.getString("dsEntFed");
                if (StrdsEntFed == null) {
                    StrdsEntFed = "";
                }

                StrdsMunDel = rs2.getString("dsMunDel");
                if (StrdsMunDel == null) {
                    StrdsMunDel = "";
                }

                StrColonia = rs2.getString("Colonia");
                if (StrColonia == null) {
                    StrColonia = "";
                }

                StrCP = rs2.getString("CP");
                if (StrCP == null) {
                    StrCP = "";
                }

                StrCalle = rs2.getString("Calle");
                if (StrCalle == null) {
                    StrCalle = "";
                }

                StrTelefono = rs2.getString("Telefonos");
                if (StrTelefono == null) {
                    StrTelefono = "";
                }

                StrHorario = rs2.getString("Horario");
                if (StrHorario == null) {
                    StrHorario = "";
                }

                StrObservaciones = rs2.getString("Observaciones");
                if (StrObservaciones == null) {
                    StrObservaciones = "";
                }

                StrFechaAlta = rs2.getString("FechaAlta");
                if (StrFechaAlta == null) {
                    StrFechaAlta = "";
                }
            }


            StrSql.append("Select coalesce(clCuenta,'') clCuenta, coalesce(Observaciones,'') Observaciones ");
            StrSql.append(" from cRefxCta  ");
            StrSql.append(" where clReferencia = ").append(StrclReferencia).append("and activa=1");
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs.next()) {
                String Strcuenta = rs.getString("clCuenta").toString();

                if (Strcuenta.equalsIgnoreCase(StrclCuenta)) {
        %><table lign='left' border='1'>
            <tr>
                <td class='cssTitDet'>Referencia</td>
                <td class='FTable'>
                    <%=StrReferencia%>
                </td>
                <td class='cssTitDet'>Categoria</td>
                <td class='FTable'>
                    <%=StrdsCategoria%>
                </td>
                <td class='cssTitDet'>SubCategoria</td>
                <td class='FTable'>
                    <%=StrdsSubCategoria%>
                </td>
            </tr>
        </table>
        <table lign='left' border='1'>
            <tr>
                <td class='cssTitDet'><%=i18n.getMessage("message.title.entidad")%></td>
                <td class='cssTitDet'><%=i18n.getMessage("message.title.municipio")%></td>
                <td class='cssTitDet'><%=i18n.getMessage("message.title.colonia")%></td>
            </tr>
            <tr>
                <td class='FTable'>
                    <%=StrdsEntFed%>
                </td>
                <td class='FTable'>
                    <%=StrdsMunDel%>
                </td>
                <td class='FTable'>
                    <%=StrColonia%>
                </td>
            </tr>
            <tr>
                <td class='cssTitDet'><%=i18n.getMessage("message.title.cp")%></td>
                <td class='cssTitDet'>Calle</td>
                <td class='cssTitDet'>Telefonos</td>
            </tr>
            <tr>
                <td class='FTable'>
                    <%=StrCP%>
                </td>
                <td class='FTable'>
                    <%=StrCalle%>
                </td>
                <td class='FTable'>
                    <%=StrTelefono%>
                </td>
            </tr> 
            <tr>
                <td class='cssTitDet'>Horario</td>
                <td class='cssTitDet'>Fecha de Alta</td>
                <td class='cssTitDet'>Observaciones</td>
            </tr>
            <tr>
                <td class='FTable'>
                    <%=StrHorario%>
                </td>
                <td class='FTable'>
                    <%=StrFechaAlta%>
                </td>
                <td class='FTable'>
                    <%=StrObservaciones%>
                </td>
            </tr> 
        </tr>
    </table>

    <%String StrObsExtra = rs.getString("Observaciones").toString();
        if (StrObsExtra.equalsIgnoreCase(null)) {
    %><table  class='TTable'><tr><td>No tiene Observaciones Extra</td></tr></table><%                                } else {%>
    <table lign='left' border='1'>
        <tr>
            <td class='cssTitDet'>Observaciones Especiales</td>
        </tr>
        <tr>
            <td class='FTable'>
                <%=StrObsExtra%>
            </td>
        </tr>
    </table>
    <%}
    } else {
    %><table  class='TTable'><tr><td>La Referencia es Confidencial</td></tr></table><%                                }
  } else {
                %><table lign='left' border='1'>
        <tr>
            <td class='cssTitDet'>Referencia</td>
            <td class='FTable'>
                <%=StrReferencia%>
            </td>
            <td class='cssTitDet'>Categoria</td>
            <td class='FTable'>
                <%=StrdsCategoria%>
            </td>
            <td class='cssTitDet'>SubCategoria</td>
            <td class='FTable'>
                <%=StrdsSubCategoria%>
            </td>
        </tr>
    </table>
    <table lign='left' border='1'>
        <tr>
            <td class='cssTitDet'><%=i18n.getMessage("message.title.entidad")%></td>
            <td class='cssTitDet'><%=i18n.getMessage("message.title.municipio")%></td>
            <td class='cssTitDet'><%=i18n.getMessage("message.title.colonia")%></td>
        </tr>
        <tr>
            <td class='FTable'>
                <%=StrdsEntFed%>
            </td>
            <td class='FTable'>
                <%=StrdsMunDel%>
            </td>
            <td class='FTable'>
                <%=StrColonia%>
            </td>
        </tr>
        <tr>
            <td class='cssTitDet'><%=i18n.getMessage("message.title.cp")%></td>
            <td class='cssTitDet'>Calle</td>
            <td class='cssTitDet'>Telefonos</td>
        </tr>
        <tr>
            <td class='FTable'>
                <%=StrCP%>
            </td>
            <td class='FTable'>
                <%=StrCalle%>
            </td>
            <td class='FTable'>
                <%=StrTelefono%>
            </td>
        </tr> 
        <tr>
            <td class='cssTitDet'>Horario</td>
            <td class='cssTitDet'>Fecha de Alta</td>
            <td class='cssTitDet'>Observaciones</td>
        </tr>
        <tr>
            <td class='FTable'>
                <%=StrHorario%>
            </td>
            <td class='FTable'>
                <%=StrFechaAlta%>
            </td>
            <td class='FTable'>
                <%=StrObservaciones%>
            </td>
        </tr> 
    </tr>
</table><%

    }

    rs2.close();
    rs.close();
    rs2 = null;
    rs = null;
    StrSql = null;
    StrclUsrApp = null;
    StrclReferencia = null;
    StrclCuenta = null;
    StrReferencia = null;
    StrdsCategoria = null;
    StrdsSubCategoria = null;
    StrdsEntFed = null;
    StrdsMunDel = null;
    StrColonia = null;
    StrCP = null;
    StrCalle = null;
    StrTelefono = null;
    StrHorario = null;
    StrObservaciones = null;
    StrFechaAlta = null;

%>
</table>
</center>


</body>
</html>

