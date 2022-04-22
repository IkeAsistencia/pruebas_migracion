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
            String StrclServicio = "0";
            String StrclUsrApp = "0";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) {%>
        Fuera de Horario
        <%

                return;
            }

            if (request.getParameter("clServicio") != null) {
                StrclServicio = request.getParameter("clServicio");
            }

            StringBuffer StrSql = new StringBuffer();

            StrSql.append("select S.clServicio, S.dsServicio, coalesce(P.dsAreaOperativa,'') as dsAreaOperativa ");
            StrSql.append(" From cServicio S Inner Join cAreaOperativa P ON (S.clAreaOperativa= P.clAreaOperativa) ");
            StrSql.append(" Where clServicio=").append(StrclServicio);

            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            StrSql.delete(0, StrSql.length());

            String StrclPaginaWeb = "25";
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);

            MyUtil.InicializaParametrosC(25, Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina 
%>
        <!--%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%-->
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="Servicio.jsp?'>"%>
        <%
            if (rs.next()) {
                // El siguiente campo llave no se mete con MyUtil.ObjInput
%>
        <INPUT id='clServicio' name='clServicio' type='hidden' value='<%=StrclServicio%>'><br><br><br><br>
        <%=MyUtil.ObjInput("Servicio", "dsServicio", rs.getString("dsServicio"), true, true, 20, 100, "", true, true, 70)%>
        <%=MyUtil.ObjComboC("Area Operativa", "clAreaOperativa", rs.getString("dsAreaOperativa"), true, true, 470, 100, "", "Select clAreaOperativa, dsAreaOperativa From cAreaOperativa Order by dsAreaOperativa", "", "", 60, true, true)%>
        <%
        } else {
        %>
        <INPUT id='clServicio' name='clServicio' type='hidden' value='<%=StrclServicio%>'><br><br><br><br>
        <%=MyUtil.ObjInput("Servicio", "dsServicio", "", true, true, 20, 100, "", true, true, 70)%>
        <%=MyUtil.ObjComboC("Area Operativa", "clAreaOperativa", "", true, true, 470, 100, "", "Select clAreaOperativa, dsAreaOperativa From cAreaOperativa Order by dsAreaOperativa", "", "", 60, true, true)%>
        <%
            }
            StrclUsrApp = null;
            StrclServicio = null;
            StrSql = null;
            rs.close();
            rs = null;

        %>
        <%=MyUtil.DoBlock("Detalle del Servicio")%>
        <%=MyUtil.GeneraScripts()%> 
        <script>
            document.all.dsServicio.maxLength = 60;
        </script>
    </body>
</html>