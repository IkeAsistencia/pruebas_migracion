<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="com.ike.asistencias.DAOAsistenciaPantallaPro,com.ike.asistencias.to.AsistenciaPantallaPro,Seguridad.SeguridadC,Combos.cbPais,Combos.cbEntidad,java.sql.ResultSet,Utilerias.UtileriasBDF"%>

<html>
    <head>
        <title>Detalle Asistencia Pantalla Protegida</title>
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
            String StrclPaginaWeb = "6154";
            String StrclPais = "10";
            
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
                StrSql = null;
                return;
            }

            DAOAsistenciaPantallaPro daoPP = null;
            AsistenciaPantallaPro PP = null;

            StrSql.append(" st_TieneAsistenciaExp ").append(StrclExpediente);
            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            if (rs.next()) {

                daoPP = new DAOAsistenciaPantallaPro();
                PP = daoPP.getAsistenciaTecnologica(StrclExpediente);

               
            //  DATOS DE LA UBICACION DESTINO
            } else {
                %> El expediente no existe <%
                rs.close();
                rs = null;
                daoPP = null;
                PP = null;
                StrclUsrApp = null;
                StrclExpediente = null;
                StrclPaginaWeb = null;
                StrclPais = null;
                StrSql = null;
                return;
            }

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %>

        <script type="text/javascript">fnOpenLinks()</script>

        <%MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp));%>

        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist", "", "")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="PantallaProtegida.jsp?"%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>

        <%=MyUtil.ObjComboC("Familia", "clFamilia", PP != null ? PP.getDsFamilia() : "", true, true, 30, 70, "", "select clFamilia, dsFamilia from ATcFamilia order by 2", "fnLlenaTipoAsistencia(this.value)", "", 50, true, true)%>
        <%=MyUtil.ObjComboC("Equipo", "clEquipo", PP != null ? PP.getDsEquipo() : "", true, true, 380, 70, "", "select clEquipo, dsEquipo from ATcEquipo order by 2", "fnLlenaMarca(this.value)", "", 50, true, true)%>
        <%=MyUtil.ObjComboC("Marca", "clMarca", PP != null ? PP.getDsMarca() : "", true, true, 30, 110, "", "select clMarca, dsMarca from ATcMarca order by 2", "fnLlenaModelo(this.value)", "", 50, true, true)%>
        <%=MyUtil.ObjComboC("Modelo", "clModelo", PP != null ? PP.getDsModelo() : "", true, true, 380, 110, "", "select clModelo, dsModelo from ATcModelo order by 2", "", "", 50, true, true)%>
        <%=MyUtil.ObjTextArea("Descripcion del Problema", "DescProblema", PP != null ? PP.getDescProblema() : "", "100", "5", true, true, 30, 150, "", true, true)%>
       <%=MyUtil.DoBlock("Pantalla Protegida", 0, 50)%>

        <%=MyUtil.GeneraScripts()%>
        
        <% if (PP != null) { %>
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
            daoPP = null;
            PP = null;
            StrclUsrApp = null;
            StrclExpediente = null;
            StrclPaginaWeb = null;
            StrclPais = null;
            StrSql = null;
            
        %>
        <input name='FechaProgMomMsk' id='FechaProgMomMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>

        <script>
            function fnLlenaTipoAsistencia(clFamilia) {
               
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
        </script>
    </body>
</html>