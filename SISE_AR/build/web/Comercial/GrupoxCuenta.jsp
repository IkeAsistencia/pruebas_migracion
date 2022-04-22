<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>JSP Page</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilDireccion.js' ></script>
        <% 
            String StrclUsrApp="0";

            if (session.getAttribute("clUsrApp")!= null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) {
        %>Fuera de Horario<%
            StrclUsrApp=null;

            return;
            }

            String StrclGrupoCuenta = "0";


            if (request.getParameter("clGrupoCuenta") != null) {
                StrclGrupoCuenta = request.getParameter("clGrupoCuenta");
            }

            StringBuffer StrSql = new StringBuffer();
            StrSql.append("select C.clGrupoCuenta, C.dsGrupoCuenta " );
            StrSql.append(" From cGrupoCuenta C " );
            StrSql.append("Where C.clGrupoCuenta=").append(StrclGrupoCuenta);
            ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
            StrSql.delete(0,StrSql.length());

            String StrclPaginaWeb = "637";

            session.setAttribute("clPaginaWebP",StrclPaginaWeb);

            MyUtil.InicializaParametrosC(637,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

        %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="GrupoxCuenta.jsp?'>"%>
        <script>document.all.btnElimina.disabled=true;</script><%   

            if (rs.next()) {
        %>
        <INPUT id='clGrupoCuenta' name='clGrupoCuenta' type='hidden' value='<%=StrclGrupoCuenta%>'>
        <%=MyUtil.ObjInput("Grupo de Cuenta","dsGrupoCuenta",rs.getString("dsGrupoCuenta"),true,true,30,70,"",true,true,50)%>
        <%=MyUtil.DoBlock("Grupo de cuenta",100,0)%>
        <%
                } else { %>
        <INPUT id='clGrupoCuenta' name='clGrupoCuenta' type='hidden' value='<%=StrclGrupoCuenta%>'>
        <%=MyUtil.ObjInput("Grupo de Cuenta","dsGrupoCuenta","",true,true,30,70,"",true,true,50)%>
        <%=MyUtil.DoBlock("Grupo de cuenta",100,0)%>
        <%
            }
        %>        
        <%=MyUtil.GeneraScripts()%><% 
            rs.close();
            rs=null;
            StrclPaginaWeb = null;
            StrclGrupoCuenta = null;
            StrSql = null;
            StrclUsrApp = null;

        %>

    </body>
</html>
