<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="java.util.Calendar,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" %>

<html>
    <head>
        <title>Reporte de Solicitudes por Colaborador</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
        <style type="text/css">
            .STableTitRpt {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 13px; color: #000000; text-transform: uppercase;text-align: center;font-weight:bold;}
            .STableTexto{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; color: #000000; text-transform: uppercase;text-align: center; font-weight:bold;}
            .STableR1{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;background-color: #FFFFFF;}
            .STableR2L{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: left; background-color: #E6F2F9;font-weight:bold}
        </style>
    </head>
    <body class="cssBody" onload="OcultaParametros();">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <script src="../Utilerias/UtilCalendario.js"></script>

        <%
            String StrclUsrApp = "0";
            String StrFechaIni = "";
            String StrFechaFin = "";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %> Fuera de Horario <%
                StrclUsrApp = null;
                StrFechaIni = null;
                StrFechaFin = null;
                return;
            }

            if (request.getParameter("FechaIni") != null) {
                StrFechaIni = request.getParameter("FechaIni");
            }

            if (request.getParameter("FechaFin") != null) {
                StrFechaFin = request.getParameter("FechaFin");
            }

            StringBuffer StrSql = new StringBuffer();

            MyUtil.InicializaParametrosC(5052, Integer.parseInt(StrclUsrApp));
        %>

        <form name='frmBusq' id='frmBusq' method='post' action='../HelpDeskSP/RptColaboradorAsignado.jsp'>
            <INPUT name="varcontrol" id="varcontrol" type="text" value="<%=StrFechaIni%>">
            <INPUT name="Action" id="Action" value="1" type="hidden">
            <INPUT name="FechaVTR" id="FechaVTR" value="" type="hidden">

            <%=MyUtil.ObjInputF("Fecha Inicial", "FechaIni", "", true, true, 20, 20, "", false, false, 20, 1, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};")%>
            <%=MyUtil.ObjInputFF("Fecha Final", "FechaFin", "", true, true, 20, 60, "", false, false, 20, 1, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};")%>
            <%=MyUtil.DoBlock("Parametros de Busqueda", 150, 30)%>

            <div class='VTable' style='position:absolute; z-index:30; left:250px; top:95px;'>
                <input type="button" class="cBtn" value="Buscar.." onclick="this.form.submit();">
            </div>
        </form>

        <%
            StrSql.append("st_RptColaboradorAsignado '").append(StrFechaIni).append("','").append(StrFechaFin).append("'");
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());

            if (rs.next()) {
                if (rs.getString(1).equalsIgnoreCase("E")) {
        %>
        <div style='position:absolute; z-index:20; left:20px; top:150px;'>
            <table border="0" cellspacing="1" cellpadding="1">
                <tr><td class="STableTexto">DEBE INFORMAR AMBAS FECHAS !!!</td></tr>
            </table>
        </div>
        <%  } else {%>
        <div style='position:absolute; z-index:20; left:10px; top:20px;'>
            <font class="STableTitRpt"> Reporte de Solicitudes x Colaborador<br><br>Periodo <%=StrFechaIni.substring(0, 10)%> 00:00 - <%=StrFechaFin.substring(0, 10)%> 23:59 </font><br>
            <table>
                <tr class='TTable'>
                    <td>
                <center>Colaborador</center>
                </td>
                <td class='TTable'><center>Total de Solicitudes en el Periodo</center></td>
                <td class='TTable'><center>Solicitudes Asignadas</center></td>
                <td class='TTable'><center>Solicitudes en Proceso</center></td>
                <td class='TTable'><center>Solicitudes Concluidas</center></td>
                <td class='TTable'><center>Solicitudes Canceladas</center></td>
                <td class='TTable'><center>Solicitudes con Calificación Negativa</center></td>
                </tr>
                <%
                    rs.beforeFirst();

                    while (rs.next()) {
                %>
                <tr class="STableR1">
                    <td class="STableR2L" align="left"><%=rs.getString("Nombre")%></td>
                    <td><%=rs.getString("TotalSol")%></td>
                    <td><%=rs.getString("SolAsignada")%></td>
                    <td><%=rs.getString("SolProceso")%></td>
                    <td><%=rs.getString("SolConcluida")%></td>
                    <td><%=rs.getString("SolCancelada")%></td>
                    <td><%=rs.getString("FoliosMalos")%></td>
                </tr>
                <% }; %>

            </table>
        </div>
        <% }
            }

            StrSql.delete(0, StrSql.length());
            rs = null;

            StrclUsrApp = null;
            StrFechaIni = null;
            StrFechaFin = null;
        %>
        <script>
            function OcultaParametros() {
                if (document.all.varcontrol.value != '') {
                    document.all.frmBusq.style.visibility = 'hidden';
                }
            }
        </script>
    </body>
</html>