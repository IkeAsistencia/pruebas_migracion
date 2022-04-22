<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>JSP Page</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">

        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <%

            String StrclSubServicio = "0";
            String StrclUsrApp = "0";
            StringBuffer StrSql = new StringBuffer();
            String StrclPaginaWeb = "30";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) { %>
                <%="Fuera de Horario"%>
                <%
                StrclSubServicio = null;
                StrclUsrApp = null;
                StrSql = null;
                StrclPaginaWeb = null;
                return;
            }

            if (request.getParameter("clSubServicio") != null) {
                StrclSubServicio = request.getParameter("clSubServicio");
            }
            
            StrSql.append("st_getSubServicio ").append(StrclSubServicio);

            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            session.setAttribute("clSubServicio", StrclSubServicio);

            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp)); %>
            
            <SCRIPT>fnOpenLinks();</SCRIPT>
            
            <!--%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%-->
            <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="SubServicio.jsp?'>"%>
        
            <% if (rs.next()) { %>
                <INPUT id='clSubServicio' name='clSubServicio' type='hidden' value='<%=StrclSubServicio%>'><br><br><br><br>

                <%=MyUtil.ObjComboC("Servicio", "clServicio", rs.getString("dsServicio"), false, false, 20, 100, "", "Select clServicio, dsServicio From cServicio Order by dsServicio", "", "", 120, true, true)%>
                <%=MyUtil.ObjInput("SubServicio", "dsSubServicio", rs.getString("dsSubServicio"), false, false, 20, 140, "", true, true, 75)%>

            <% } else { %>
                <INPUT id='clSubServicio' name='clSubServicio' type='hidden' value='<%=StrclSubServicio%>'><br><br><br><br>

                <%=MyUtil.ObjComboC("Servicio", "clServicio", "", false, false, 20, 100, "", "Select clServicio, dsServicio From cServicio Order by dsServicio", "", "", 120, true, true)%>
                <%=MyUtil.ObjInput("SubServicio", "dsSubServicio", "", false, false, 20, 140, "", true, true, 75)%>
            <% } %>
            <%=MyUtil.DoBlock("Detalle del SubServicio", 300, 0)%>                          
            <%=MyUtil.GeneraScripts()%><%

            rs.close();
            rs = null;

            StrSql = null;
            StrclSubServicio = null;
            StrclUsrApp = null;

        %>
        <script>
            document.all.dsSubServicio.maxLength = 60;
        </script>
    </body>
</html>