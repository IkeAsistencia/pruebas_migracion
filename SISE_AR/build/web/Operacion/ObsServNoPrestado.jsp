<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ page import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage=""%>

<html>
    <head>
        <title>Motivo Servicio no Prestado</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="">

        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script type="text/javascript" src='../Utilerias/Util.js' ></script>

        <%
            String StrclUsrApp = "0";
            String StrclExpediente = "0";
            String StrclProveedor = "0";
            String StrclPaginaWeb = "6063";
            String StrclmotivoNPS = "0";
            String Strobservaciones = "";
            String StrProveedor = "";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (request.getParameter("clExpediente") != null) {
                StrclExpediente = request.getParameter("clExpediente").toString();
            } else if (session.getAttribute("clExpediente") != null) {
                StrclExpediente = session.getAttribute("clExpediente").toString();
            }

            if (request.getParameter("clProveedor") != null) {
                StrclProveedor = request.getParameter("clProveedor").toString().trim();
            }

            if (request.getParameter("clmotivoNPS") != null) {
                StrclmotivoNPS = request.getParameter("clmotivoNPS").toString().trim();
            }

            if (request.getParameter("observaciones") != null) {
                Strobservaciones = request.getParameter("observaciones").toString().trim();
            }

            //System.out.println("obs: " + StrclmotivoNPS.toString());
            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
                %>Fuera de Horario<%
                StrclUsrApp = null;
                StrclExpediente = null;
                StrclProveedor = null;
                StrclPaginaWeb = null;
                StrclmotivoNPS = null;
                Strobservaciones = null;
                StrProveedor = null;
                return;
            }

            ResultSet rs = null;

            rs = UtileriasBDF.rsSQLNP("select NombreOpe 'provee' from cProveedor where clProveedor = '" + StrclProveedor + "'");
            if (rs.next()) {
                StrProveedor = rs.getString("provee");
            }

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            MyUtil.InicializaParametrosC(6063, Integer.parseInt(StrclUsrApp));

            if ((StrclmotivoNPS != "0")) {
                StringBuffer StrSql = new StringBuffer();

                StrSql.append("sp_insertaNPS '").append(StrclExpediente).append("','").append(StrclProveedor).append("','").append(StrclUsrApp).append("','").append(StrclmotivoNPS).append("','").append(Strobservaciones).append("'");
                System.out.println(StrSql.toString());
                rs = UtileriasBDF.rsSQLNP(StrSql.toString());
                StrSql.delete(0, StrSql.length());

                if (rs.next()) {
                    if (rs.getString("error").equalsIgnoreCase("0")) { %>
                        <script type="text/javascript">location.href = '<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%>../servlet/Utilerias.Lista?P=184';
                        //opener.location.reload();
                        window.close();
                        </script>
                <% } else { %>
                    <script>alert("Error al guardar los datos.");</script>
                <% }
                }
                StrSql.delete(0, StrSql.length());
            }
        %>

        <%=MyUtil.doMenuAct("ObsServNoPrestado.jsp?", "", "")%>

        <input id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <input id='clProveedor' name='clProveedor' type='hidden' value='<%=StrclProveedor%>'>
        <input id='clUsrAppRegistra' name='clUsrAppRegistra' type='hidden' value='<%=StrclUsrApp%>'>

        <div id='D3' Name='D3' class='cssTitDet' style='position:absolute; z-index:3; left:20px; top:50px;'>
            <p class='TTable'>Proveedor: <%=StrProveedor%></p>
        </div>
        <%=MyUtil.ObjComboC("Motivo NPS", "clmotivoNPS", "", true, true, 150, 100, "", "select clmotivoNPS,dsMotivoNPS from cMotivoNPS where activo = 1 order by orden", "", "", 50, true, false)%>  <%--Agrego un campo orden y un order a la seleccion para llenar el motivo 20150901--%>
        <%=MyUtil.ObjTextArea("Observaciones", "observaciones", "", "45", "6", true, true, 150, 140, "", false, false)%>
        <%=MyUtil.DoBlock("Motivo NPS", 70, 60)%>

        <%=MyUtil.GeneraScripts()%>

    </body>
    <%
        StrclUsrApp = null;
        StrclExpediente = null;
        StrclProveedor = null;
        StrclPaginaWeb = null;
        StrclmotivoNPS = null;
        Strobservaciones = null;
        StrProveedor = null;
        rs.close();
        rs = null;
    %>
</html>
