<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF,Combos.cbServicio" %>

<html>
    <head>
        <title>Asignación de Expedientes</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body topmargin=470 leftmargin=30 class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script type="text/javascript" src='../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../Utilerias/UtilServicio.js'></script>

        <%
                String StrSql = "";
                String StrclUsrApp = "0";
                String StrclPaginaWeb = "0";
                String StrWhere = "";

                int iCont = 0;

                if (session.getAttribute("clUsrApp") != null) {
                    StrclUsrApp = session.getAttribute("clUsrApp").toString();
                }

                if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %> Fuera de Horario <%
                    StrSql = null;
                    StrclUsrApp = null;
                    return;
                }

                StrclPaginaWeb = "296";
                MyUtil.InicializaParametrosC(296, Integer.parseInt(StrclUsrApp));
        %>
        <script type="text/javascript" >fnOpenLinks();</script>
        <%
                StrSql = "Select clUsrApp, Nombre from cUsrApp where Activo = 1 and clPerfilOperativo = 5 order by Nombre";
                ResultSet rs = UtileriasBDF.rsSQLNP(StrSql);

        %>

        <form target='VistaPrevia' method='post' action='AsignarExpedientes.jsp'>
            <div style='position:absolute; z-index:303; left:30px; top:310px'>
                <input type='reset' value='Limpiar' onclick='fnLimpiaParametros();'>
                <input type='submit' value='Asignar' name="Asig" onclick='document.all.VP.value=0;fnConcatena()'>
                <input type='submit' value='Vista Previa' name="Vtp" onclick='document.all.VP.value=1;fnConcatena()'>
            </div>

            <%=MyUtil.ObjComboC("Servicio", "clServicio", "", true, true, 30, 70, "", "Select clServicio, dsServicio from cServicio order by dsServicio", "fnLlenaSubServicios()", "", 40, false, false)%>
            <%=MyUtil.ObjChkBox("Segunda Supervision", "Supervision", "0", true, true, 360, 80, "0", "fnSegundaSupervision()")%>
            <%=MyUtil.ObjComboC("Grupo de Cuenta", "clGrupoCuenta", "", true, true, 30, 110, "", "Select clGrupoCuenta, dsGrupoCuenta from cGrupoCuenta order by dsGrupoCuenta", "", "", 40, false, false)%>
            <%=MyUtil.ObjInput("Cuenta", "Cuenta", "", true, true, 30, 150, "", false, false, 40, "if(this.readOnly==false){fnBuscaCuenta();}")%>
            <%=MyUtil.ObjInput("Modelo (aaaa)", "Modelo", "", true, true, 30, 190, "", false, false, 4, "")%>
            <%=MyUtil.ObjInput("Expediente", "clExpediente", "", true, true, 260, 190, "", false, false, 20, "")%>
            <%=MyUtil.ObjInput("Fecha Inicio (aaaa-mm-dd)", "FechaInicio", "", true, true, 30, 230, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
            <%=MyUtil.ObjInput("Fecha Fin (aaaa-mm-dd)", "FechaFin", "", true, true, 260, 230, "", false, false, 20, "if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
            <%=MyUtil.ObjComboC("Estatus", "clEstatus", "", true, true, 260, 270, "", "st_ComboEstatus", "", "", 40, false, false)%>
            <%=MyUtil.ObjComboMem("Subservicio", "clSubServicio", "", "", "", true, true, 30, 270, "", "", "", 40, false, false)%>

            <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
            <INPUT id='clCuenta' name='clCuenta' type='hidden' value='0'>
            <INPUT id='VP' name='VP' type='hidden' value='0'>

            <div class='VTable' style='position:absolute; z-index:25; left:250px; top:165px;'>
                <IMG alt=""  SRC='../Imagenes/Lupa.gif' onClick='fnBuscaCuenta();' WIDTH=20 HEIGHT=20></div>
                <%=MyUtil.DoBlock("Criterios de Selección", 0, 30)%>

            <%=MyUtil.ObjComboC("Area a Supervisar", "clAreaSupervisada", "", true, true, 30, 390, "", "st_SMSgetAreaSupervision", "", "", 40, false, false)%>
            <%=MyUtil.ObjInput("Porcentaje a Repartir", "Porcentaje", "", true, true, 30, 430, "", false, false, 15, "")%>
            <%=MyUtil.DoBlock("Atributos para Asignación", 60, 0)%>
            <textarea name='UsuariosSeleccionados' id='UsuariosSeleccionados' cols='80' rows='3' ></textarea>
            <table><tr><td class='cssTitDet' colspan=2>Supervisores Activos</td></tr><tr class='TTable'><td>Selección</td><td class='TTable'>Usuario</td></tr>

                <%
                        while (rs.next()) {
                %>
                <tr>
                    <td><INPUT id='Usuarios<%=iCont%>' name='Usuarios<%=iCont%>' type='checkbox'></td>
                    <td><INPUT disabled='true' id='Nombre<%=iCont%>' name='Nombre<%=iCont%>' type='text' value='<%=rs.getString("Nombre")%>'></td>
                    <td><INPUT disabled='true' id='clUsrApp<%=iCont%>' name='clUsrApp<%=iCont%>' type='hidden' value='<%=rs.getString("clUsrApp")%>'></td>
                </tr>

                <%
                            iCont = iCont + 1;
                        }

                        rs.close();
                        rs = null;

                %>
            </table>
            <input type='hidden' name='Total' id='Total' value ='<%=iCont%>'>
        </form>

        <script type="text/javascript" >
            document.all.Supervision.value='0';
            document.all.SupervisionC.disabled=false;

            document.all.UsuariosSeleccionados.style.visibility='hidden';
            document.all.clServicioC.disabled=false;
            document.all.clEstatusC.disabled=false;
            document.all.clSubServicioC.disabled=false;
            document.all.clGrupoCuentaC.disabled=false;
            document.all.clExpediente.readOnly=false;
            document.all.FechaInicio.readOnly=false;
            document.all.FechaFin.readOnly=false;
            document.all.clAreaSupervisadaC.disabled=false;
            document.all.Porcentaje.readOnly=false;
            document.all.Modelo.readOnly=false;
            document.all.Asig.disabled=true;


            function fnLimpiaParametros(){
                //document.all.Supervision.value=0;
                document.all.clServicioC.disabled=false;
                document.all.clServicio.value=0;
                fnLlenaSubServicios();
            }

            function fnConcatena(){
                var total = document.getElementById('Total').value;
                var selectedList = document.getElementById('UsuariosSeleccionados');
                selectedList.value = '0';
                for (var i = 0; i < total; i++) {
                    if (document.getElementById('Usuarios'+i).checked){
                        selectedList.value = selectedList.value + ',' + document.getElementById('clUsrApp'+i).value;
                            }
                        }
                    }

            function fnBuscaCuenta(){
                if (document.all.Nombre.value!=''){
                    var pstrCadena = "../Utilerias/FiltrosCuenta.jsp?strSQL=sp_WebBuscaCuenta ";
                    pstrCadena = pstrCadena + "&Cuenta= " ;
                    document.all.clCuenta.value='';
                    window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
                }
            }

            function fnActualizaDatosCuenta(dsCuenta,clCuenta,clTipoVal, Msk, MskUsr, Agentes){
                document.all.Cuenta.value = dsCuenta;
                document.all.clCuenta.value = clCuenta;
            }

            function fnSegundaSupervision(){
                if (document.all.Supervision.value=="1"){
                    document.all.clServicioC.disabled=true;
                    document.all.clServicioC.value=8;
                    document.all.clServicio.value=8;
                    fnLlenaSubServicios();
                } else {
                    document.all.clServicioC.disabled=false;}
            }
        </script>
    </body>
</html>
