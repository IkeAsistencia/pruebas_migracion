<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="com.ike.asistencias.DAOAsistenciaTecnologica,com.ike.asistencias.to.AsistenciaTecnologica,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,java.sql.ResultSet,Utilerias.UtileriasBDF"%>

<html>
    <head>
        <title>Detalle Asistencia Hogar</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script type="text/javascript" src='../../Utilerias/Util.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilMask.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilDireccion.js'></script>
        <script type="text/javascript" src='../../Utilerias/UtilAjax.js'></script>

        <%
            String StrclUsrApp = "";
            String StrclExpediente = "0";
            String StrclPaginaWeb = "6074";
            String StrclPais = "10";
            String StrCodEnt = "";
            StringBuffer StrSql = new StringBuffer();

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }
            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %>Fuera de Horario<%
                StrclUsrApp = null;
                StrclExpediente = null;
                StrclPaginaWeb = null;
                StrclPais = null;
                StrCodEnt = null;
                StrSql = null;
                return;
            }

            DAOAsistenciaTecnologica daoAT = null;
            AsistenciaTecnologica AT = null;

            StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs.next()) {

                daoAT = new DAOAsistenciaTecnologica();
                AT = daoAT.getAsistenciaTecnologica(StrclExpediente);

                if (AT != null) {
                    StrclPais = AT.getClPais();
                    StrCodEnt = AT.getCodEnt();
                }

            //  DATOS DE LA UBICACION DESTINO
            } else {
                %> El expediente no existe <%
                rs.close();
                rs = null;
                daoAT = null;
                AT = null;
                StrclUsrApp = null;
                StrclExpediente = null;
                StrclPaginaWeb = null;
                StrclPais = null;
                StrCodEnt = null;
                StrSql = null;
                return;
            }

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>

        <script type="text/javascript">fnOpenLinks()</script>

        <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp));%>

        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "", "")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="AsistenciaTecnologica.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjComboC("Familia", "clFamilia", AT != null ? AT.getDsFamilia() : "", true, true, 30, 70, "", "select clFamilia, dsFamilia from ATcFamilia order by 2", "fnLlenaTipoAsistencia(this.value)", "", 50, true, true)%>
        <%=MyUtil.ObjComboC("Equipo", "clEquipo", AT != null ? AT.getDsEquipo() : "", true, true, 380, 70, "", "select clEquipo, dsEquipo from ATcEquipo order by 2", "fnLlenaMarca(this.value)", "", 50, true, true)%>
        <%=MyUtil.ObjComboC("Marca", "clMarca", AT != null ? AT.getDsMarca() : "", true, true, 30, 110, "", "select clMarca, dsMarca from ATcMarca order by 2", "fnLlenaModelo(this.value)", "", 50, true, true)%>
        <%=MyUtil.ObjComboC("Modelo", "clModelo", AT != null ? AT.getDsModelo() : "", true, true, 380, 110, "", "select clModelo, dsModelo from ATcModelo order by 2", "", "", 50, true, true)%>
        <%=MyUtil.ObjTextArea("Descripcion del Problema", "DescProblema", AT != null ? AT.getDescProblema() : "", "100", "5", true, true, 30, 150, "", true, true)%>
        <%=MyUtil.ObjComboC("Tipo de Asistencia", "clTipoAsistencia", AT != null ? AT.getDsTipoAsistencia() : "", true, true, 30, 240, "", "select clTipoAsistencia, dsTipoAsistencia from ATcTipoAsistencia order by 2", "", "", 50, true, true)%>
        <!--%=MyUtil.ObjComboC("Lugar de Compra", "clLugarCompra", AT != null ? AT.getDsLugarCompra() : "", true, true, 380, 240, "1", "select clLugarCompra, dsLugarCompra from ATcLugarCompra", "", "", 50, false, false)%-->
        <%=MyUtil.DoBlock("Asistencia Tecnológica", 0, 0)%>

        <%=MyUtil.ObjComboC("Pais", "clPais", AT != null ? AT.getDsPais() : "", true, true, 30, 330, "10", "Select clPais ,dsPais from cPais order by dsPais", "fnLlenaProvincia(this.value)", "", 20, false, false)%>
        <%=MyUtil.ObjComboC("Provincia", "CodEnt", AT != null ? AT.getDsEntFed() : "", true, true, 300, 330, "", "Select CodEnt,dsEntFed from cEntFed where clPais =  " + StrclPais + "order by dsEntFed", "fnLlenaLocalidad(this.value)", "", 20, false, false)%>
        <%=MyUtil.ObjComboC("Localidad", "CodMD", AT != null ? AT.getDsMunDel() : "", true, true, 30, 370, "", "Select CodMD, dsMunDel from cMunDel where CodEnt = " + StrCodEnt, "", "", 20, false, false)%>
        <%=MyUtil.ObjInput("Direccion", "Direccion", AT != null ? AT.getDireccion() : "", true, true, 340, 370, "", false, false, 63, "")%>
        <%=MyUtil.ObjTextArea("Referecnias Visuales / Observaciones", "Observaciones", AT != null ? AT.getObservaciones() : "", "125", "5", true, true, 30, 410, "", false, false)%>
        <%=MyUtil.DoBlock("Dirección", 170, 50)%>

        <%=MyUtil.GeneraScripts()%>
        
        <% if (AT != null) { %>
            <script>
                document.all.btnAlta.disabled = true;
            </script>
        <% }else { %>
            <script>
                document.all.btnCambio.disabled = true;
                document.all.btnElimina.disabled = true;
            </script>
        <% } %>

        <%
            rs.close();
            rs = null;
            daoAT = null;
            AT = null;
            StrclUsrApp = null;
            StrclExpediente = null;
            StrclPaginaWeb = null;
            StrclPais = null;
            StrCodEnt = null;
            StrSql = null;
            
        %>
        <input name='FechaProgMomMsk' id='FechaProgMomMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>

        <script>
            function fnLlenaTipoAsistencia(clFamilia) {
                var strConsulta = "st_ATgetTipoAsistencia " + clFamilia;
                var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=clTipoAsistenciaC";
                fnOptionxDefault('clTipoAsistenciaC', pstrCadena);

                var strConsulta = "st_ATgetEquipo " + clFamilia;
                var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=clEquipoC";
                fnOptionxDefault('clEquipoC', pstrCadena);
            }

            function fnLlenaMarca(clEquipo) {
                var strConsulta = "st_ATgetMarca " + clEquipo;
                var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=clMarcaC";
                fnOptionxDefault('clMarcaC', pstrCadena);
            }

            function fnLlenaModelo(clMarca) {
                var strConsulta = "st_ATgetModelo " + clMarca;
                var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=clModeloC";
                fnOptionxDefault('clModeloC', pstrCadena);
            }

            function fnLlenaProvincia(clPais) {
                var strConsulta = "st_ATgetProvincia " + clPais;
                var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=CodEntC";
                fnOptionxDefault('CodEntC', pstrCadena);
            }

            function fnLlenaLocalidad(CodEnt) {
                var strConsulta = "st_ATgetLocalidad '" + CodEnt + "'";
                var pstrCadena = "../../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                pstrCadena = pstrCadena + "&strName=CodMDC";
                fnOptionxDefault('CodMDC', pstrCadena);
            }
        </script>
    </body>
</html>