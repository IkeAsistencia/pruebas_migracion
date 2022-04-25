<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head><title>Desasignar Expedientes de Supervisión</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" topmargin=150>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <%
            String StrclUsrApp = "0";
            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();         }
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {%>
                Fuera de Horario 
                <% return;
                }
            String StrclUsrAppAs = "0"; // Usuario asignado 
            String StrclExpediente = "0";
            String StrFechaAsignacionIni = "";
            String StrFechaAsignacionFin = "";
            String FechaExpedienteIni = "";
            String FechaExpedienteFin = "";
            String GrupoCuenta = "";
            int iCont = 0;
            if (request.getParameter("clUsrAppAs") != null) {
                StrclUsrAppAs = request.getParameter("clUsrAppAs").toString();          }
            if (StrclUsrAppAs.compareToIgnoreCase("") == 0) {
                StrclUsrAppAs = "0";           }
            if (request.getParameter("clExpedienteF") != null) {
                StrclExpediente = request.getParameter("clExpedienteF").toString();          }
            if (StrclExpediente.compareToIgnoreCase("") == 0) {
                StrclExpediente = "0";          }
            if (request.getParameter("FechaAsignacionIni") != null) {
                StrFechaAsignacionIni = request.getParameter("FechaAsignacionIni");            }
            if (request.getParameter("FechaAsignacionFin") != null) {
                StrFechaAsignacionFin = request.getParameter("FechaAsignacionFin").toString();           }
            if (request.getParameter("FechaExpedienteIni") != null) {
                FechaExpedienteIni = request.getParameter("FechaExpedienteIni").toString();            }
            if (request.getParameter("FechaExpedienteFin") != null) {
                FechaExpedienteFin = request.getParameter("FechaExpedienteFin").toString();            }
            if (request.getParameter("GrupoCuenta") != null) {
                GrupoCuenta = request.getParameter("GrupoCuenta").toString();            }
            MyUtil.InicializaParametrosC(297, Integer.parseInt(StrclUsrApp));%>   
            
        <form method='get' action='DesasignarExped.jsp'>
            <%=MyUtil.ObjComboC("Usuario Asignado", "clUsrAppAs", "", true, true, 30, 60, "", "Select clUsrApp, Nombre from cUsrApp where Activo = 1 and clPerfilOperativo = 5 order by Nombre", "", "", 20, true, true)%>
            <%=MyUtil.ObjInput("Expediente", "clExpedienteF", "", true, true, 230, 60, "", false, false, 20)%>
            <%=MyUtil.ObjComboC("<br>Grupo de Cuenta", "GrupoCuenta", "", true, false, 110, 100, "", "Select clGrupoCuenta, dsGrupoCuenta from cGrupoCuenta order by dsGrupoCuenta", "", "", 40, false, false)%>
            <%=MyUtil.ObjInput("Fecha Asignación Ini<BR>AAAA/MM/DD", "FechaAsignacionIni", "", true, false, 350, 50, "", true, true, 22, "if(this.readOnly == false){ fnValMask(this, FechaMsk.value, this.name)}")%>
            <%=MyUtil.ObjInput("Fecha Asignación Fin<BR>AAAA/MM/DD", "FechaAsignacionFin", "", true, false, 500, 50, "", true, true, 22, "if(this.readOnly == false){ fnValMask(this, FechaMsk.value, this.name)}")%>
            <%=MyUtil.ObjChkBox("Todos", "chkSeleccionar", "0", false, true, 30, 100, "0", "SI", "NO", "fnSelecc(this.checked);")%>
            <%=MyUtil.ObjInput("Fecha Expediente Ini<BR>AAAA/MM/DD", "FechaExpedienteIni", "", true, false, 350, 100, "", true, true, 22, "if(this.readOnly == false){ fnValMask(this, FechaMsk.value, this.name)}")%>
            <%=MyUtil.ObjInput("Fecha Expediente Fin<BR>AAAA/MM/DD", "FechaExpedienteFin", "", true, false, 500, 100, "", true, true, 22, "if(this.readOnly == false){ fnValMask(this, FechaMsk.value, this.name)}")%>
            <div class='VTable' style='position:absolute; z-index:25; left:30px; top:145px;'>
                <input class='cBtn' type='submit' value='Buscar...'/>
            </div>
            <%=MyUtil.DoBlock("Criterios de Búsqueda", 30, 30)%>
        </form>

        <%  StringBuffer StrSql = new StringBuffer();
            StrSql.append(" sp_BuscaDesasignarExpedaSuperv ").append(StrclUsrAppAs).append(",").append(StrclExpediente);
            StrSql.append(",'").append(StrFechaAsignacionIni).append("','").append(StrFechaAsignacionFin).append("'");
            StrSql.append(",'").append(FechaExpedienteIni).append("','").append(FechaExpedienteFin).append("'");
            StrSql.append(",'").append(GrupoCuenta).append("'");
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        %> 
        <form target='WinSave' method='post' action='DesasignaExped.jsp'>
            <table >
                <tr class='cssTitDet'>
                    <td>Seleccionado</td>
                    <td>Grupo de Cuenta</td>
                    <td>Cuenta</td>
                    <td>Servicio</td>
                    <td>Expediente</td>
                    <td>Supervisor</td>
                    <td>Fecha de Asignación</td>
                    <td>Fecha de Registro</td>
                </tr>
                <%while (rs.next()) {%>
                    <tr>
                        <td><input id='Expedientes<%=iCont%>' name='Expedientes<%=iCont%>' type='checkbox'/></td>
                        <td><input disabled='true' id='GpoCuenta' name='GpoCuenta' type='text' value='<%=rs.getString("GrupoCuenta")%>'/></td>
                        <td><input disabled='true' id='Cuenta' name='Cuenta' type='text' value='<%=rs.getString("Cuenta")%>'/></td>
                        <td><input disabled='true' id='Servicio' name='Servicio' type='text'  value='<%=rs.getString("dsSubservicio")%>' style="size: auto"/></td>
                        <td><input disabled='true' id='clExpediente<%=iCont%>' name='clExpediente<%=iCont%>' value='<%=rs.getString("clExpediente")%>' size="10" style="text-align: center"/></td>
                        <td><input disabled='true' id='Supervisor' name='Supervisor' type='text' value='<%=rs.getString("Supervisor")%>'/></td>
                        <td><input disabled='true' id='FechaAsig' name='Fecha de Asignación' type='text' value='<%=rs.getString("FechaAsig")%>' size="16" style="text-align: center"/></td>
                        <td><input disabled='true' id='FechaAsig' name='Fecha de Registro' type='text' value='<%=rs.getString("FechaReg")%>' size="16" style="text-align: center"/></td>
                    </tr>
                    <%
                    iCont = iCont + 1;
                    }; // fin while 
                rs.close();
                rs = null;
                StrSql = null;
                %>
                <textarea name='Resultados' id='Resultados' cols='80' rows='3' ></textarea
                <input name='Total' id='Total' type='hidden' value='<%=iCont%>'/>
                <tr><td></td></tr>
                <tr><td></td></tr>
                <tr><td><input type='submit' name='submit' value='Desasignar' onclick='fnConcatena();'/></td>
                </tr>
            </table>
        </form>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'/>
        <script>
//------------------------------------------------------------------------------
            document.getElementById("clUsrAppAsC").disabled = false;
            document.getElementById("clUsrAppAsC").readOnly = false;
            document.getElementById("clExpedienteF").readOnly = false;
            document.getElementById("clExpedienteF").disabled = false;
            document.getElementById("chkSeleccionarC").readOnly = false;
            document.getElementById("chkSeleccionarC").disabled = false;
            document.getElementById("FechaAsignacionIni").readOnly = false;
            document.getElementById("FechaAsignacionIni").disabled = false;
            document.getElementById("FechaAsignacionFin").readOnly = false;
            document.getElementById("FechaAsignacionFin").disabled = false;
            document.getElementById("Resultados").style.visibility = 'hidden';
            document.getElementById("FechaExpedienteIni").readOnly = false;
            document.getElementById("FechaExpedienteIni").disabled = false;
            document.getElementById("FechaExpedienteFin").readOnly = false;
            document.getElementById("FechaExpedienteFin").disabled = false;
            document.getElementById("GrupoCuentaC").readOnly = false;
            document.getElementById("GrupoCuentaC").disabled = false;
//------------------------------------------------------------------------------
            function fnSelecc(ActionSelect) {
                // ActionSelect:   0: No seleccionar, 1:Seleccionar
                Total=<%=iCont%>;
                i = 0;
                Action=0;
                if(ActionSelect){Action=1;}
                while (i <= Total - 1) {
                    document.getElementById("Expedientes"+i).checked = Action;
                    i += 1;
                    }
                }
//------------------------------------------------------------------------------
            function fnConcatena() {
                i = 0;
                Total=<%=iCont%>;
                document.getElementById("Resultados").value = '0';
                fnOpenWindow();
                while (i <= Total - 1) {
                    if (document.getElementById("Expedientes"+i).checked) {
                        document.getElementById("Resultados").value=document.getElementById("Resultados").value+','+document.getElementById("clExpediente"+i).value;      }
                    i++;
                    }
                alert("Expedientes a Eliminar: "+document.getElementById("Resultados").value);
                }
//------------------------------------------------------------------------------
        </script>
    </body>
</html>