<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,Utilerias.UtileriasObj" errorPage="" %>
<html>
    <head>
        <title>Detalle Cobertura del Proveedor Veterinario</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onload="">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script type="text/javascript"  src='../Utilerias/Util.js' ></script>

        <%

            String StrclConcepto = "0";
            String StrclPaginaWeb = "121";
            String StrclUsrApp = "0";
            StringBuffer StrSql = new StringBuffer();

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (request.getParameter("clConcepto") != null) {
                if (request.getParameter("clConcepto") != "") {
                    StrclConcepto = request.getParameter("clConcepto").toString();
                }
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) { %>
                Fuera de Horario
            <%
                StrclConcepto = null;
                StrclUsrApp = null;
                return;
            }
            
            session.setAttribute("clPaginaWebP", StrclPaginaWeb);
            
            StrSql.append("st_getConceptoCosto ").append(StrclConcepto);

            ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
            
            MyUtil.InicializaParametrosC(Integer.parseInt(StrclPaginaWeb), Integer.parseInt(StrclUsrApp));
            %>

        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "", "")%>
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1) + "DetalleConceptoCosto.jsp?"%>'>
        <input id='clConcepto' name='clConcepto' type='hidden' value='<%=StrclConcepto%>'>
        <input id='clPaginaWeb' name='clPaginaWeb' type='hidden' value='<%=StrclPaginaWeb%>'>
        <% if (rs.next()){%>
            <%=MyUtil.ObjInput("Concepto Costo", "dsConcepto", rs.getString("dsConcepto"), true, false, 30, 80, "", false, false, 70)%>
            <%=MyUtil.ObjComboC("Area Operativa", "clAreaOperativa", rs.getString("dsAreaOperativa"), true, false, 30, 125, "0", "st_getComboAreaOperativa", "", "", 50, true, true)%>
            <%=MyUtil.ObjChkBox("Activo", "Activo", rs.getString("Activo"), true, true, 250, 125, "0", "SI", "NO", "")%>
        <% } else { %>
            <%=MyUtil.ObjInput("Concepto Costo", "dsConcepto", "", true, false, 30, 80, "", false, false, 70)%>
            <%=MyUtil.ObjComboC("Area Operativa", "clAreaOperativa", "", true, false, 30, 125, "0", "st_getComboAreaOperativa", "", "", 50, true, true)%>
            <%=MyUtil.ObjChkBox("Activo", "Activo", "", true, true, 250, 125, "0", "SI", "NO", "")%>
        <% } %>
        <%=MyUtil.DoBlock("Detalle de Concepto de Costo", 0, 0)%>
        <%=MyUtil.GeneraScripts()%>
        <%
            StrclConcepto = null;
            StrclUsrApp = null;
            
            rs.close();
            rs = null;
        %>
    </body>
</html>
