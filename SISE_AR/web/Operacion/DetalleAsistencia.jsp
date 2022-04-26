<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
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
            String strclUsr = "0";
            if (session.getAttribute("clUsrApp") != null) {
                strclUsr = session.getAttribute("clUsrApp").toString();        }
            if(SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true){
                %><font color="white"  style="font-family:Verdana,Arial,Helvetica,sans-serif; background-color:red;" size=3>LA SESION EXPIRO</font><%  
                strclUsr=null;
                return;
                }
            String StrclSubServicio = "0";
            String StrclServicio = "0";
            String StrdsSubServicio = "0";
            String StrdsServicio = "0";
            String StrclExpediente = "0";
            String strclAreaOperativa = "0";
            String StrCond = "0"; /* condición de cubiertos / no cubiertos*/
            String StrSubServsOP = "";
            String StrClave = "";
            String StrclCuenta = "";
            StringBuffer StrSql = new StringBuffer();
            if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();            }
            String StrclPaginaWeb = "160";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
        %><script>fnOpenLinks()</script><%            
            MyUtil.InicializaParametrosC(160, Integer.parseInt(strclUsr));
            if (request.getParameter("clSubServicio") != null) {
                StrclSubServicio = request.getParameter("clSubServicio").toString();
                if (StrclSubServicio.compareToIgnoreCase("") == 0) {
                    StrclSubServicio = "0";                }
                session.setAttribute("clSubServicio", StrclSubServicio);
            }
            if (request.getParameter("clAreaOperativa") != null) {
                strclAreaOperativa = request.getParameter("clAreaOperativa").toString();
                session.setAttribute("areaOperativa", strclAreaOperativa);
            }
            if (request.getParameter("Cond") != null) {
                StrCond = request.getParameter("Cond").toString();            }
            StrSql.append(" st_getInfoServicio '").append(StrclExpediente).append("','").append(StrclSubServicio).append("'");
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
                } else {
                    if (request.getParameter("clSubServicio") != null) {
                        StrclSubServicio = request.getParameter("clSubServicio");
                        session.setAttribute("clSubServicio", StrclSubServicio);
                    }

                    if (request.getParameter("clServicio") != null) {
                        StrclServicio = request.getParameter("clServicio");
                        session.setAttribute("clServicio", StrclServicio);
                    }
                    if (request.getParameter("dsServicio") != null) {
                        StrdsServicio = request.getParameter("dsServicio");
                        session.setAttribute("dsServicio", StrdsServicio);
                    }
                }
            }
            if (session.getAttribute("clCuenta") != null) {
                StrclCuenta = session.getAttribute("clCuenta").toString();            }
            
            if (session.getAttribute("Clave") != null) {
                StrClave = session.getAttribute("Clave").toString();            }
            /*Luego del reload, hace el contron de siniestralidad*/    
            if (StrclServicio != "0") {
                /*Ahora siempre consultará el nombre del subservicio*/
                StrSql.append(" select dsSubServicio from cSubServicio where clSubServicio = '").append(StrclSubServicio).append("'");
                ResultSet rsN = UtileriasBDF.rsSQLNP(StrSql.toString());
                StrSql.delete(0, StrSql.length());

                if (rsN.next()) {
                    StrdsSubServicio = rsN.getString("dsSubServicio");
                    session.setAttribute("dsSubServicio", StrdsSubServicio);
                }

                rsN.close();
                rsN = null;

                if (rs.getString("NombrePaginaWeb") != null) {
                        String StrFechaAp = rs.getString("FechaAp");
                        session.setAttribute("FechaAp", StrFechaAp);
                        StrFechaAp = null;
                        %>
                        <script>
                            //location.href = '../Operacion/ValidaAutorizacion.jsp?NombrePagina=<%=rs.getString("NombrePaginaWeb")%>&clExpediente=<%=StrclExpediente%>&clSubServcio=<%=StrclSubServicio%>';
                        </script>
                    <% //} else {%>
                    <script>
                        location.href = '../<%=rs.getString("NombrePaginaWeb")%>&clExpediente=<%=StrclExpediente%>'
                    </script>
                    <%
                    //}
        } else {
        %>  EL SUBSERVICIO NO TIENE PAGINA CONFIGURADA  <% }
            } else {
                /*MARIO PARA OBTENER LOS SUBSERVICIOS OPCIOALES DEL AFILIADO*/
                StrSql.append("st_ObtenSubServsOpcionales ").append(StrclExpediente);
                ResultSet rs4 = UtileriasBDF.rsSQLNP(StrSql.toString());
                StrSql.delete(0, StrSql.length());
                if (rs4.next()) {                    StrSubServsOP = rs4.getString("SubServsOP");              }
                rs4.close();
                rs4 = null;
            }
        %>
        <p align='right'><input type='Button' class='cBtn' value='Regresar' onClick="history.go(-1)">
            <input type='Button' class='cBtn' value='Servicios no Cubiertos' onClick="location.href = 'DetalleAsistencia.jsp?clAreaOperativa=1&Cond=0'"></p>
    <center>
        <table>
            <% if (StrCond.compareToIgnoreCase("1") == 0) { %>
            <tr><td class='cssTitDet'>Servicios Cubiertos Opcionales</td>
            </tr><tr><td><table><tr><td>
                                <%
                                    StringBuffer strSalida = new StringBuffer();

                                    UtileriasBDF.rsTableNP("sp_ListaSubServCubiertosOpcional '" + StrclCuenta + "'," + strclAreaOperativa + ", " + "'" + StrclExpediente + "','" + StrSubServsOP + "'", strSalida);%>
                                <%=strSalida.toString()%><%
                                    strSalida.delete(0, strSalida.length());
                                    strSalida = null;%>
                            </td></tr></table></td></tr>
            <tr><td><br></td></tr>

            <table>
                <tr><td class='cssTitDet'>Servicios Cubiertos</td></tr>
                <tr><td><table><tr><td><%

                    StringBuffer strSalida2 = new StringBuffer();
                    UtileriasBDF.rsTableNP("sp_ListaSubServCubiertos '" + StrclCuenta + "'," + strclAreaOperativa +",'"+StrClave+"'", strSalida2);%>
                                    <%=strSalida2.toString()%><%
                                        if (strSalida2.length() <= 8) {

                                    %><tr class='R1Table'><td> No cuenta con SubServicios Opcionales</td></tr><%                                        }
                                        strSalida2.delete(0, strSalida2.length());
                                        strSalida2 = null;%>
                    </td></tr></table></td></tr>                
            <tr><td><br></td></tr>  
        </table>
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
        </tr>
        <% } %>
    </table>
</center>
<%
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
    StrclPaginaWeb = null;
    StrclCuenta = null;
    StrClave = null;
    StrSql = null;
%>
</body>
</html>

