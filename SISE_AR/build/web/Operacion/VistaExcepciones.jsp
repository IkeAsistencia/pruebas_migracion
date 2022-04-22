<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Excepciones</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="/*fnDevuelveFoco()*/">
        <script type="text/javascript" src='Util.js'></script>
        <%
            String clCuenta = "0";
            StringBuffer StrSql = new StringBuffer();

            if (request.getParameter("clCuenta") != null) {
                clCuenta = request.getParameter("clCuenta").toString();
            }
            session.setAttribute("clCuenta", clCuenta);
        %>

        <%
            StrSql.append(" st_getExcepcionesCobertura ").append(clCuenta);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());
            StrSql = new StringBuffer();

        %>
        <br><br>
        <table width='750px' class='cssTitDet'><tr><td Valign=top>Excepciones por Cobertura</td></tr></table>
        <TABLE width='750px' Border=1 Class='vTable'>
            <TR>
                <td style="text-align:center; width: 250px"><b>SERVICIO</b></td>
                <td style="text-align:center; width: 250px"><b>SUBSERVICIO</b></td>
                <td style="text-align:center; width: 250px"><b>CONCEPTO COSTO</b></td>
            </TR>
            <% while (rs.next()) {%>
            <TR>  
                <TD Valign=top><%=rs.getString(1)%></TD>
                <TD Valign=top><%=rs.getString(2)%></TD>
                <TD Valign=top><%=rs.getString(3)%></TD>
            </TR>
            <%}%>
        </table>

        <%
            /* Codigo Para cajas de busqueda
            String strDsServicio = "";
            String strDsServicioTxt = "";
            String strDsSunServicioTxt = "";
            String strDsTxt = "";

            if (request.getParameter("strDsServicioTxt") != null) {
                strDsServicioTxt = request.getParameter("strDsServicioTxt").toString();
                strDsServicio = request.getParameter("strDsServicioTxt").toString();
            }
            if (request.getParameter("strDsSunServicioTxt") != null) {
                strDsSunServicioTxt = request.getParameter("strDsSunServicioTxt").toString();
            }
            if (request.getParameter("strDsTxt") != null) {
                strDsTxt = request.getParameter("strDsTxt").toString();
            }

            System.out.println("strDsServicio " + strDsServicio);
            System.out.println("strDsSunServicioTxt " + strDsSunServicioTxt);
            System.out.println("strDsTxt " + strDsTxt);
            System.out.println("clCuenta " + clCuenta);*/
            StrSql.append("st_getExcepcionesCuenta ").append(clCuenta);//.append(",'").append(strDsServicio).append("','");
            //StrSql.append(strDsSunServicioTxt).append("','").append(strDsTxt).append("'");
            rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

        %>

        <!--form id="formTablaCuenta"-->
            <input type="hidden" id="clCuenta" name="clCuenta" value="<%=clCuenta%>">
            <table width='750px' class='cssTitDet'><tr><td Valign=top>Excepciones por Tipo de Cuenta</td></tr></table>
            <TABLE width='750px' Border=1 Class='vTable'>
                <TR>
                    <td style="text-align:center; width: 250px"><b>SERVICIO <!--input type="text" id="strDsServicioTxt" onkeyup="fnActualizaTabla()" name="strDsServicioTxt" value="<=strDsServicio%>"--></b></td>
                    <td style="text-align:center; width: 250px"><b>SUBSERVICIO <!--input type="text" id="strDsSunServicioTxt" onkeyup="fnActualizaTabla()" name="strDsSunServicioTxt" value="<=strDsSunServicioTxt%>"--></b></td>
                    <td style="text-align:center; width: 250px"><b>DESCRIPCION <!--input type="text" id="strDsTxt" onkeyup="fnActualizaTabla()" name="strDsTxt" value="<=strDsTxt%>"--></b></td>
                </TR>
                <% while (rs.next()) {%>
                <TR>  
                    <TD Valign=top><%=rs.getString(1)%></TD>
                    <TD Valign=top><%=rs.getString(2)%></TD>
                    <TD Valign=top><%=rs.getString(3)%></TD>
                </TR>
                <%}%>
            </table>
        <!--/form-->

        <script>
            /* Funciones para las cajas de busqueda
            function fnActualizaTabla() {
                document.getElementById("formTablaCuenta").submit();
            }

            function fnDevuelveFoco() {
                //alert(document.getElementById('strDsServicioTxt').value)
                //alert(document.getElementById('strDsSunServicioTxt').value)
                //alert(document.getElementById('strDsTxt').value)
                if (document.getElementById('strDsServicioTxt').value != "") {
                    document.getElementById('strDsServicioTxt').focus();
                    if (document.getElementById('strDsServicioTxt').value != "") {
                        document.getElementById('strDsServicioTxt').value += "";
                    }

                }
                if (document.getElementById('strDsSunServicioTxt').value != "") {
                    document.getElementById('strDsSunServicioTxt').focus();
                    if (document.getElementById('strDsSunServicioTxt').value != "") {
                        document.getElementById('strDsSunServicioTxt').value += "";
                    }

                }
                if (document.getElementById('strDsTxt').value != "") {
                    document.getElementById('strDsTxt').focus();
                    if (document.getElementById('strDsTxt').value != "") {
                        document.getElementById('strDsTxt').value += "";
                    }

                }
            }*/
        </script>
        <%
            rs.close();
            rs = null;
        %>
        <%
            clCuenta = null;
            StrSql = null;
        %>
    </body>
</html>