<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="java.util.Calendar,Utilerias.Grafica,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" %>

<html>
    <head>
        <title>Reporte Indicadores ISO</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../StyleClasses/Calendario.css" rel="stylesheet" type="text/css">
        <style type="text/css">
            .STableTitRpt {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 13px; color: #000000; text-transform: uppercase;text-align: center;font-weight:bold;}
            .STableTit {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #FFFFFF; text-transform: uppercase;text-align: center;background-color: #000066;}
            .STableTexto{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; color: #000000; text-transform: uppercase;text-align: center; font-weight:bold;}
            .STableR1{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;background-color: #FFFFFF;}
            .STableR2{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;}
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
            String StrclColabora = "";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %>Fuera de Horario<%
                StrclUsrApp = null;
                StrFechaIni = null;
                StrFechaFin = null;
                StrclColabora = null;
                return;
            }

            if (request.getParameter("FechaIni") != null) {
                StrFechaIni = request.getParameter("FechaIni");
            }

            if (request.getParameter("FechaFin") != null) {
                StrFechaFin = request.getParameter("FechaFin");
            }

            if (request.getParameter("clColaboradorAsignadoSP") != null) {
                StrclColabora = request.getParameter("clColaboradorAsignadoSP");
            }

            StringBuffer StrSql = new StringBuffer();

            MyUtil.InicializaParametrosC(5051, Integer.parseInt(StrclUsrApp));
        %>

        <form name='frmBusq' id='frmBusq' method='post' action='../HelpDeskSP/RptIndicadorISO.jsp'>
            <INPUT name="varcontrol" id="varcontrol" type="text" value="<%=StrFechaIni%>">
            <INPUT NAME="Action" ID="Action" VALUE="1" TYPE="hidden">

            <%=MyUtil.ObjInputF("Fecha Inicial", "FechaIni", "", true, true, 20, 20, "", false, false, 20, 1, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};")%>
            <%=MyUtil.ObjInputFF("Fecha Final", "FechaFin", "", true, true, 20, 60, "", false, false, 20, 1, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};")%>
            <%=MyUtil.ObjComboC("Colaborador", "clColaboradorAsignadoSP", "", true, true, 20, 100, "", "st_HDSPColaboradores", "", "", 30, false, false)%>
            <%=MyUtil.DoBlock("Parametros de Busqueda", 150, 0)%>

            <div class='VTable' style='position:absolute; z-index:30; left:275px; top:110px;'>
                <input type="button" class="cBtn" value="Buscar.." onclick="this.form.submit();">
            </div>
        </form>

        <%
            StrSql.append("st_RptIndicadorISO '").append(StrFechaIni).append("','").append(StrFechaFin).append("','").append(StrclColabora).append("'");
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());

            if (rs.next()) {
                if (rs.getString(1).equalsIgnoreCase("1")) {
        %>
        <div style='position:absolute; z-index:20; left:20px; top:160px;'>
            <table border="0" cellspacing="1" cellpadding="1">
                <tr><td class="STableTexto">DEBE INFORMAR AMBAS FECHAS ¡¡¡</td></tr>
            </table>
        </div>

        <%   } else {%>

        <div style='position:absolute; z-index:20; left:10px; top:20px;'>
            <font class="STableTitRpt"> Calificación de servicios<br><br>Periodo <%=StrFechaIni%> - <%=StrFechaFin%> </font><br>
            <table width="50%" border="0" cellspacing="1" cellpadding="1">
                <tr>
                    <td class="STableTit">RUBRO</td>
                    <td width="4%" class="STableTit">EXCELENTE</td>
                    <td width="4%" class="STableTit">BUENO</td>
                    <td width="4%" class="STableTit">MALO</td>
                </tr>
                <tr>
                    <td width="6%" class="STableTexto">ATENCIÓN</td>
                    <td class="STableR1"><%=rs.getString("ATE_E")%></td>
                    <td class="STableR2"><%=rs.getString("ATE_B")%></td>
                    <td class="STableR1"><%=rs.getString("ATE_M")%></td>
                </tr>
                <tr>
                    <td width="6%" class="STableTexto">DOMINIO</td>
                    <td class="STableR2"><%=rs.getString("DOM_E")%></td>
                    <td class="STableR1"><%=rs.getString("DOM_B")%></td>
                    <td class="STableR2"><%=rs.getString("DOM_M")%></td>
                </tr>
                <tr>
                    <td width="6%" class="STableTexto">ACTITUD</td>
                    <td class="STableR1"><%=rs.getString("ACT_E")%></td>
                    <td class="STableR2"><%=rs.getString("ACT_B")%></td>
                    <td class="STableR1"><%=rs.getString("ACT_M")%></td>
                </tr>
                <tr>
                    <td width="6%" class="STableTexto">SERVICIO</td>
                    <td class="STableR2"><%=rs.getString("SER_E")%></td>
                    <td class="STableR1"><%=rs.getString("SER_B")%></td>
                    <td class="STableR2"><%=rs.getString("SER_M")%></td>
                </tr>
                <tr>
                    <td width="6%" class="STableTexto">TIEMPO DE RESPUESTA</td>
                    <td class="STableR1"><%=rs.getString("TE_E")%></td>
                    <td class="STableR2"><%=rs.getString("TE_B")%></td>
                    <td class="STableR1"><%=rs.getString("TE_M")%></td>
                </tr>
                <tr>
                    <td colspan="4" class="STableTit"></td>
                </tr>
                <tr>
                    <td width="6%" class="STableTexto">TOTAL DE SOLICITUDES EN EL PERIODO</td>
                    <td class="STableR1"><%=rs.getString("TT")%></td>
                </tr>
                <tr>
                    <td colspan="4" class="STableTit"></td>
                </tr>
                <tr>
                    <td colspan="4" class="STableTit"></td>
                </tr>
                <tr>
                    <td width="4%" class="STableTexto">TOTAL DE SOLICITUDES EN EL PERIODO SIN CALIFICAR</td>
                    <td class="STableR1"><%=rs.getString("TTSC")%></td>
                </tr>
            </table>
        </div>
        <%
                }
            }

            StrSql.delete(0, StrSql.length());
            rs = null;

            StrclUsrApp = null;
            StrFechaIni = null;
            StrFechaFin = null;
            StrclColabora = null;
        %>
        <script>
            document.all.clColaboradorAsignadoSPC.disabled = false;
            //alert();
            document.all.FechaIni.disabled = false;
            document.all.FechaIni.readOnly = false;
            document.all.FechaIni.maxLength="10";
            

            function OcultaParametros() {
                if (document.all.varcontrol.value != '') {
                    document.all.frmBusq.style.visibility = 'hidden';
                }
            }
        </script>
    </body>
</html>