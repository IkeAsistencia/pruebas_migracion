<%@page contentType="text/html; charset=iso-8859-1" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" %>
<html>
    <head>
        <title>Asignación de Expedientes a Supervisores</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>

    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <%
                String StrclUsrApp = "0";
                String StrclPaginaWeb = "0";
                String StrPorcentaje = "0";
                String StrSupervision = "0";

                if (request.getParameter("Supervision") != null) {
                    StrSupervision = request.getParameter("Supervision");
                }

                if (session.getAttribute("clUsrApp") != null) {
                    StrclUsrApp = session.getAttribute("clUsrApp").toString();
                }

                if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %> Fuera de Horario <%
                    return;
                }

                if (request.getParameter("Porcentaje") != null) {
                    StrPorcentaje = request.getParameter("Porcentaje").toString();
                    if (StrPorcentaje.compareToIgnoreCase("") == 0) {
                        StrPorcentaje = "0";
                    }
                }

                if (request.getParameter("VP").compareToIgnoreCase("0") == 0) {
                    // asigna directamente

                    if (request.getParameter("Porcentaje") != null) {
                        if (request.getParameter("Porcentaje").toString().compareToIgnoreCase("") == 0) {
        %><p class='cssTitDet'>Debe informar: Porcentaje </p><%
                                    return;
                                }
                            }

                            if (request.getParameter("clAreaSupervisada") != null) {
                                if (request.getParameter("clAreaSupervisada").toString().compareToIgnoreCase("") == 0) {
        %><p class='cssTitDet'>Debe informar: Area a Supervisar </p><%
                                            return;
                                        }
                                    } else {
        %><p class='cssTitDet'>Debe informar: Area a Supervisar </p><%
                                return;
                            }

                            if (request.getParameter("UsuariosSeleccionados") != null) {
                                if (request.getParameter("UsuariosSeleccionados").toString().compareToIgnoreCase("") == 0) {%>
        <p class='cssTitDet'>Debe informar: Usuarios a Asignar</p>
        <%return;
                                }
                            }

                            StringBuffer StrSql = new StringBuffer();
                            StrSql.append("sp_AsignarExpedaSuperv 0 ");
                            StrSql.append(",'").append(request.getParameter("clServicio").toString());
                            StrSql.append("','").append(request.getParameter("clSubServicio").toString());
                            StrSql.append("','").append(request.getParameter("clCuenta").toString());
                            StrSql.append("','").append(request.getParameter("clGrupoCuenta").toString());
                            StrSql.append("',").append(StrPorcentaje);
                            StrSql.append(",'").append(request.getParameter("Modelo").toString());
                            StrSql.append("','").append(request.getParameter("FechaInicio").toString());
                            StrSql.append("','").append(request.getParameter("FechaFin").toString());
                            StrSql.append("',").append(session.getAttribute("clUsrApp").toString());
                            StrSql.append(",'").append(request.getParameter("clAreaSupervisada").toString());
                            StrSql.append("','").append(request.getParameter("UsuariosSeleccionados").toString());
                            StrSql.append("','").append(request.getParameter("clExpediente").toString()).append("'");
                            StrSql.append(",").append(StrSupervision);
                            StrSql.append(",'").append(request.getParameter("clEstatus").toString()).append("'");
        %>
        <p class='cssTitDet'>Asignación Procesada</p>    
        <% StringBuffer strSalida = new StringBuffer();
                            UtileriasBDF.rsTableNP(StrSql.toString(), strSalida);
                            System.out.println(StrSql);
                            if (strSalida.length() > 508) {
        %>
        <script type="text/javascript" >parent.Selecccion.document.all.Asig.disabled=false;</script>
        <%} else {%>
        <script type="text/javascript">parent.Selecccion.document.all.Asig.disabled=true;</script>
        <%}%>  
        <%=strSalida.toString()%> 
        <%strSalida.delete(0, strSalida.length());
                            strSalida = null;
        %>

        <%  StrSql = null;
                        } else {
                            //vista previa %>Criterios de Selección

        <p class='cssTitDet'>Vista Previa</p>
        <% StringBuffer StrSql = new StringBuffer();
                            StrSql.append("sp_AsignarExpedaSuperv ").append(request.getParameter("VP").toString());
                            StrSql.append(",'").append(request.getParameter("clServicio").toString());
                            StrSql.append("','").append(request.getParameter("clSubServicio").toString());
                            StrSql.append("','").append(request.getParameter("clCuenta").toString());
                            StrSql.append("','").append(request.getParameter("clGrupoCuenta").toString());
                            StrSql.append("',").append(StrPorcentaje);
                            StrSql.append(",'").append(request.getParameter("Modelo").toString());
                            StrSql.append("','").append(request.getParameter("FechaInicio").toString());
                            StrSql.append("','").append(request.getParameter("FechaFin").toString());
                            StrSql.append("',").append(session.getAttribute("clUsrApp").toString());
                            StrSql.append(",'").append(request.getParameter("clAreaSupervisada").toString());
                            StrSql.append("','").append(request.getParameter("UsuariosSeleccionados").toString());
                            StrSql.append("','").append(request.getParameter("clExpediente").toString()).append("'");
                            StrSql.append(",").append(StrSupervision);
                            StrSql.append(",'").append(request.getParameter("clEstatus").toString()).append("'");

                            System.out.println(StrSql);
        %>    
        <% StringBuffer strSalida = new StringBuffer();
                            UtileriasBDF.rsTableNP(StrSql.toString(), strSalida);
                            System.out.println(StrSql);
                            if (strSalida.length() > 170) {
        %>
        <script type="text/javascript">parent.Selecccion.document.all.Asig.disabled=false;</script>
        <%} else {%>
        <script type="text/javascript">parent.Selecccion.document.all.Asig.disabled=true;</script>
        <%}%>   
        <%=strSalida.toString()%>  
        <%strSalida.delete(0, strSalida.length());
                            strSalida = null;
        %>
        <%  StrSql = null;
                }


        %>

    </body>
</html>
