<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.Timestamp,java.util.Calendar,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Registro de la Operacion Cauciones</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../StyleClasses/Calendario.css" rel="stylesheet" type="text/css"> 
        <style type="text/css">
            .STableTitRpt {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 13px; color: #000000; text-transform: uppercase;text-align: center;font-weight:bold;}            
            .STableTit {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #FFFFFF; text-transform: uppercase;text-align: center;background-color: #000066;}
            .STableGpo {background-color: #ffffff;}
            .STableTexto{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; color: #000000; text-transform: uppercase;text-align: center; font-weight:bold;}
            .STableR1{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;background-color: #FFFFFF;}            
            .STableR1L{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: left;background-color: #FFFFFF;}            
            .STableR2{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center; background-color: #E6F2F9} 
            .STableR2L{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: left; background-color: #E6F2F9;font-weight:bold} 
            .STableReg{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;}
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

            StringBuffer StrSql = new StringBuffer();

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %>Fuera de Horario<%
                StrclUsrApp = null;
                return;
            }

            if (request.getParameter("FechaIni") != null) {
                StrFechaIni = request.getParameter("FechaIni");
            }

            if (request.getParameter("FechaFin") != null) {
                StrFechaFin = request.getParameter("FechaFin");
            }

            MyUtil.InicializaParametrosC(5053, Integer.parseInt(StrclUsrApp));
        %>

        <form name='frmBusq' id='frmBusq' method='post' action='../HelpDeskSP/RptAreaOperativa.jsp'>
            <INPUT name="varcontrol" id="varcontrol" type="text" value="<%=StrFechaIni%>">
            <INPUT NAME="Action" ID="Action" VALUE="1" TYPE="hidden">
            <INPUT id='FechaVTR' name='FechaVTR' type='hidden' value=''>
            <%=MyUtil.ObjInputF("Fecha Inicial", "FechaIni", "", true, true, 20, 20, "", false, false, 20, 1, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};fnfecha(this);")%>
            <%=MyUtil.ObjInputFF("Fecha Final", "FechaFin", "", true, true, 20, 60, "", false, false, 20, 1, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};fnfecha(this);")%>
            <%=MyUtil.DoBlock("Parametros de Busqueda", 150, 30)%>
            <div class='VTable' style='position:absolute; z-index:30; left:250px; top:95px;'> 
                <input type="button" class="cBtn" value="Buscar.." onclick="this.form.submit();">
            </div>
        </form>

        <%
            StrSql.append("st_RptAreaOperativa '").append(StrFechaIni).append("','").append(StrFechaFin).append("'");
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            System.out.println("StrSql:     " + StrSql);
            if (rs.next()) {
                System.out.println("HUBO RS");
                if (rs.getString(1).equalsIgnoreCase("E")) {
        %>
        <div style='position:absolute; z-index:20; left:20px; top:150px;'>
            <table border="0" cellspacing="1" cellpadding="1">
                <tr><td class="STableTexto">DEBE INFORMAR AMBAS FECHAS ¡¡¡</td></tr>
            </table>
        </div>
        <%
        } else {
        %>       
        <div style='position:absolute; z-index:20; left:10px; top:20px;'> 
            <font class="STableTitRpt"> Reporte de Solicitudes x Area Operativa<br><br>Periodo <%=StrFechaIni%> - <%=StrFechaFin%> </font><br>
            <table>
                <tr>
                    <td class='STableTit'>
                        Area Operativa
                    </td>
                    <td class='STableTit'>
                        Solicitudes
                    </td>
                    <td class='STableTit'>
                        Solicitudes Pendientes
                    </td>
                    <td class='STableTit'>
                        Solicitudes Asignadas
                    </td>
                    <td class='STableTit'>
                        Solicitudes en Proceso
                    </td>
                    <td class='STableTit'>
                        Solicitudes Concluidas
                    </td>
                    <td class='STableTit'>
                        Solicitudes Canceladas
                    </td>
                </tr>
                <%
                    rs.beforeFirst();
                    while (rs.next()) {
                %>
                <tr>
                    <td class="STableR2L">
                        <%=rs.getString("Nombre")%>
                    </td>
                    <td class="STableR1">
                        <%=rs.getString("SolTotal")%>
                    </td>
                    <td class="STableR1">
                        <%=rs.getString("SolPendiente")%>
                    </td>
                    <td class="STableR1">
                        <%=rs.getString("SolAsignada")%>
                    </td>
                    <td class="STableR1">
                        <%=rs.getString("SolProceso")%>
                    </td>
                    <td class="STableR1">
                        <%=rs.getString("SolConcluida")%>
                    </td>
                    <td class="STableR1">
                        <%=rs.getString("SolCancelada")%>
                    </td>
                </tr>
                <%
                    };
                %>
            </table>
        </div>
    <%
            }
        }
        StrSql.delete(0, StrSql.length());
        rs = null;
    %>
    <script>

        function fnfecha(fechaelegida) {
            mueveReloj();
            if (fechaelegida != "") {
                if (fechaelegida.value < document.all.FechaVTR.value) {
                    //alert("La Fecha para Programar una Reunion es anterior a la fecha actual.");
                    alert("La Fecha y hora para Programar una Reunion debe ser posterior a la fecha seleccionada.");
                    showCalendarControl(fechaelegida);
                }
            }
            if (fechaelegida == "") {
                if (fechaelegida.value > document.all.FechaVTR.value) {
                    alert("La Fecha y hora debe ser anterior a la fecha seleccionada.");
                    showCalendarControl(fechaelegida);
                }
            }
        }

        function mueveReloj() {
            if (document.all.Action.value == 2) {
                momentoActual = new Date()
                var year = momentoActual.getYear();
                if (year < 1000)
                    year += 1900;
                var day = momentoActual.getDay();
                var month = momentoActual.getMonth() + 1;
                if (month < 10)
                    month = "0" + month

                var daym = momentoActual.getDate();
                if (daym < 10)
                    daym = "0" + daym

                hora = momentoActual.getHours()
                minuto = momentoActual.getMinutes()
                if (minuto < 10)
                    minuto = "0" + minuto

                segundo = momentoActual.getSeconds()
                horaImprimible = year + "-" + month + "-" + daym + " " + hora + ":" + minuto
                document.forma.FechaVTR.value = horaImprimible
            }
            //setTimeout("mueveReloj()",1000)
        }

        function OcultaParametros() {
            if (document.all.varcontrol.value != '') {
                document.all.frmBusq.style.visibility = 'hidden';
            }
        }
    </script>
</body>
</html>