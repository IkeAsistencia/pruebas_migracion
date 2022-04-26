<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title>Detalle de la Asistencia</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" topmargin="10">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilServicio.js'></script>
        <%
        String StrclSubServicio = "0";
        String StrclServicio = "0";
        String StrdsSubServicio = "0";
        String StrdsServicio = "0";
        String StrclExpediente = "0";
        String strclUsr = "0";
        String strclAreaOperativa = "0";
        String StrCond = "0"; /* condición de cubiertos / no cubiertos*/
        String StrLimEventos = "0";
        String StrBrindados = "0";
        String StrclTipoVal = "0";
        String StrPrefijo = "";

        StringBuffer StrSql = new StringBuffer();

        if (session.getAttribute("clUsrApp") != null) {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }

        if (session.getAttribute("clExpediente") != null) {
            StrclExpediente = session.getAttribute("clExpediente").toString();
        }

        String StrclPaginaWeb = "160";
        session.setAttribute("clPaginaWebP", StrclPaginaWeb);

        %><script>fnOpenLinks()</script><%

        MyUtil.InicializaParametrosC(160, Integer.parseInt(strclUsr));

        if (request.getParameter("clSubServicio") != null) {
            StrclSubServicio = request.getParameter("clSubServicio").toString();
            if (StrclSubServicio.compareToIgnoreCase("") == 0) {
                StrclSubServicio = "0";
            }
            session.setAttribute("clSubServicio", StrclSubServicio);
        }

        if (request.getParameter("clAreaOperativa") != null) {
            strclAreaOperativa = request.getParameter("clAreaOperativa").toString();
        }

        if (request.getParameter("Cond") != null) {
            StrCond = request.getParameter("Cond").toString();
        }

        StrSql.append(" Select coalesce(E.TieneAsistencia,0) TieneAsistencia , P.NombrePaginaWeb, coalesce(S.clServicio,0) clServicio, ");
        StrSql.append(" coalesce(S.dsServicio,'') dsServicio, ");
        StrSql.append(" coalesce(SUB.clSubservicio,0) clSubServicio , ");
        StrSql.append(" coalesce(SUB.dsSubservicio,'') dsSubServicio, getdate() FechaAp ");
        StrSql.append(" from cSubservicio SUB ");
        StrSql.append(" inner join cServicio S on (SUB.clServicio = S.clServicio)  ");
        StrSql.append(" left join Expediente E on (E.clSubservicio = SUB.clSubservicio AND E.clExpediente = ").append(StrclExpediente).append(")  ");
        StrSql.append(" left join cPaginaWeb P on (SUB.clPaginaWeb = P.clPaginaWeb)  ");
        StrSql.append(" where E.clSubservicio is not null or sub.clSubservicio = ").append(StrclSubServicio);

        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0, StrSql.length());

        if (rs.next()) {
            if (rs.getString("TieneAsistencia").toString().compareToIgnoreCase("1") == 0) {
                if (rs.getString("clSubServicio") != null) {
                    StrclSubServicio = rs.getString("clSubServicio");
                    session.setAttribute("clSubServicio", StrclSubServicio);
                }
                if (rs.getString("clServicio") != null) {
                    StrclServicio = rs.getString("clServicio");
                    session.setAttribute("clServicio", StrclServicio);
                }
                if (rs.getString("dsSubServicio") != null) {
                    StrdsSubServicio = rs.getString("dsSubServicio");
                    session.setAttribute("dsSubServicio", StrdsSubServicio);
                }
                if (rs.getString("dsServicio") != null) {
                    StrdsServicio = rs.getString("dsServicio");
                    session.setAttribute("dsServicio", StrdsServicio);
                }
                //Se redirecciona al servicio

        %><script>/*/location.href='..*/<%=rs.getString("NombrePaginaWeb")%>/*&clExpediente=*/<%=StrclExpediente%></script>
        <%
            } else {
                if (request.getParameter("clSubServicio") != null) {
                    StrclSubServicio = request.getParameter("clSubServicio");
                    session.setAttribute("clSubServicio", StrclSubServicio);
                }

                if (request.getParameter("clServicio") != null) {
                    StrclServicio = request.getParameter("clServicio");
                    session.setAttribute("clServicio", StrclServicio);
                }

                if (request.getParameter("dsSubServicio") != null) {
                    StrdsSubServicio = request.getParameter("dsSubServicio");
                    session.setAttribute("dsSubServicio", StrdsSubServicio);
                }

                if (request.getParameter("dsServicio") != null) {
                    StrdsServicio = request.getParameter("dsServicio");
                    session.setAttribute("dsServicio", StrdsServicio);
                }
            }
        }

        String StrclCuenta = "";
        if (session.getAttribute("clCuenta") != null) {
            StrclCuenta = session.getAttribute("clCuenta").toString();
        }

        String StrClave = "";
        if (session.getAttribute("Clave") != null) {
            StrClave = session.getAttribute("Clave").toString();
        }

        if (StrclServicio != "0") {
            if (rs.getString("NombrePaginaWeb") != null) {

                //Validamos de la cobertura de la cuenta, el límite de eventos
                // buscamos el limite de eventos

                StrSql.append(" select coalesce(SSC.LimiteEventos,0)  LimiteEventos");
                StrSql.append(" from cCobertura Cob ");
                StrSql.append(" Inner Join SubServicioxCobertura SSC ON (Cob.clCobertura=SSC.clCobertura) ");
                StrSql.append(" Where Cob.clCuenta =").append(StrclCuenta);
                StrSql.append(" And SSC.clSubServicio=").append(StrclSubServicio);

                ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql.toString());
                StrSql.delete(0, StrSql.length());

                if (rs2.next()) {
                    StrLimEventos = rs2.getString("LimiteEventos");
                }
                rs2.close();
                rs2 = null;

                // buscamos tipo de validacion y prefijo de la cuenta

                StrSql.append(" Select clTipoValidacion, coalesce(Prefijo,'') Prefijo from cCuenta where clCuenta=").append(StrclCuenta);
                rs2 = UtileriasBDF.rsSQLNP(StrSql.toString());
                StrSql.delete(0, StrSql.length());

                if (rs2.next()) {
                    StrclTipoVal = rs2.getString("clTipoValidacion");
                    StrPrefijo = rs2.getString("Prefijo");
                }
                rs2.close();
                rs2 = null;

                if (StrclTipoVal.equals("1") || StrclTipoVal.equals("3")) //validacion con base de datos y prefijo
                {
                    StrSql.append(" Select count(*) Maximo ");
                    StrSql.append(" From Expediente ");
                    // unir Prefijo a la tabla
                    StrSql.append(" INNER JOIN cAfiliado").append(StrPrefijo).append(" cAfiliadoPersona ");
                    StrSql.append(" ON cAfiliadoPersona.clCuenta = Expediente.clCuenta ");
                    StrSql.append(" AND cAfiliadoPersona.Clave = Expediente.Clave ");
                    StrSql.append(" INNER JOIN ContratoxCuenta ON ContratoxCuenta.clCuenta = Expediente.clCuenta ");
                    StrSql.append(" WHERE Expediente.clCuenta = ").append(StrclCuenta);
                    StrSql.append(" AND Expediente.Clave = '").append(StrClave).append("'");
                    StrSql.append(" AND Expediente.clSubServicio = ").append(StrclSubServicio);
                    StrSql.append(" AND ContratoxCuenta.FechaIni <= CAST(getdate() as smalldatetime ) ");
                    StrSql.append(" AND ContratoxCuenta.FechaFin >= CAST(getdate() as smalldatetime ) ");
                    StrSql.append(" AND cAfiliadoPersona.FechaIni <= CAST(getdate() as smalldatetime ) ");
                    StrSql.append(" AND cAfiliadoPersona.FechaFin >= CAST(getdate() as smalldatetime ) ");
                    StrSql.append(" AND cAfiliadoPersona.clContrato = ContratoxCuenta.clContrato ");
                    StrSql.append(" AND Expediente.clEstatus in(10,14,33,35,36,37) ");
                    StrSql.append(" AND Expediente.clTipoServicio in(1,6) ");
                } else {
                    StrSql.append(" Select count(*) Maximo ");
                    StrSql.append(" From Expediente ");
                    StrSql.append(" INNER JOIN ContratoxCuenta ON  ContratoxCuenta.clCuenta = Expediente.clCuenta ");
                    StrSql.append(" WHERE Expediente.clCuenta =").append(StrclCuenta);
                    StrSql.append(" AND Expediente.Clave = '").append(StrClave).append("'");
                    StrSql.append(" AND Expediente.clSubServicio = ").append(StrclSubServicio);
                    StrSql.append(" AND ContratoxCuenta.FechaIni <= CAST(getdate() as smalldatetime ) ");
                    StrSql.append(" AND ContratoxCuenta.FechaFin >= CAST(getdate() as smalldatetime ) ");
                    StrSql.append(" AND Expediente.clEstatus in(10,14,33,35,36,37) ");
                    StrSql.append(" AND Expediente.clTipoServicio in(1,6) ");
                }
                ResultSet rs3 = UtileriasBDF.rsSQLNP(StrSql.toString());
                StrSql.delete(0, StrSql.length());
                if (rs3.next()) {
                    StrBrindados = rs3.getString("Maximo");
                }
                rs3.close();
                rs3 = null;

                String StrFechaAp = rs.getString("FechaAp");
                session.setAttribute("FechaAp", StrFechaAp);
                StrFechaAp = null;

                if ((Integer.parseInt(StrBrindados) >= Integer.parseInt(StrLimEventos)) && Integer.parseInt(StrLimEventos) != 0) {
                    //Este servicio excede el límite de eventos de la cobertura de la cuenta;

        %><script>location.href='../Operacion/ValidaAutorizacion.jsp?NombrePagina=<%=rs.getString("NombrePaginaWeb")%>&clExpediente=<%=StrclExpediente%>&clSubServcio=<%=StrclSubServicio%>';</script>
        <%
            } else {
                //No excede límite de eventos;
                //Se redirecciona al servicio

        %><script>location.href='../<%=rs.getString("NombrePaginaWeb")%>&clExpediente=<%=StrclExpediente%>'</script>"
        <%
            }
        } else {
        %>  EL SUBSERVICIO NO TIENE PAGINA CONFIGURADA  <% }
        }

        %><p align='right'><input type='Button' class='cBtn' value='Regresar' onClick="history.go(-1)"></input>
        <input type='Button' class='cBtn' value='Servicios no Cubiertos' onClick="location.href='DetalleAsistencia.jsp?clAreaOperativa=1&Cond=0'"></input></p>
        <center>
            <table>
                <%
        if (StrCond.compareToIgnoreCase("1") == 0) {
                %><tr><td class='cssTitDet'>Servicios Cubiertos</td>
                </tr><tr><td><table><tr><td><%
                    StringBuffer strSalida = new StringBuffer();
                    UtileriasBDF.rsTableNP("sp_ListaSubServCubiertos '" + StrclCuenta + "'," + strclAreaOperativa, strSalida);%>
                                    <%=strSalida.toString()%><%
                    strSalida.delete(0, strSalida.length());
                    strSalida = null;%>
                </td></tr></table></td></tr>
                <tr><td><br></td></tr>
                <% } else {%>
                <tr><td class='cssTitDet'>Servicios NO Cubiertos</td>
                </tr><tr><td><table><tr><td><%
                    StringBuffer strSalida = new StringBuffer();
                    UtileriasBDF.rsTableNP("sp_ListaSubServNoCubiertos '" + StrclCuenta + "'", strSalida);%>
                                    <%=strSalida.toString()%><%
                    strSalida.delete(0, strSalida.length());
                    strSalida = null;%>
                            </td></tr>
                        </table>
                    </td>
                </tr><%
        }
        %></table></center><%
        rs.close();
        rs = null;

        StrclSubServicio = null;
        StrclServicio = null;
        StrdsSubServicio = null;
        StrdsServicio = null;
        StrclExpediente = null;
        strclUsr = null;
        strclAreaOperativa = null;
        StrCond = null;
        StrLimEventos = null;
        StrBrindados = null;
        StrclTipoVal = null;
        StrPrefijo = null;
        StrclPaginaWeb = null;
        StrclCuenta = null;
        StrClave = null;

        StrSql = null;
        %>
    </body>
</html>

