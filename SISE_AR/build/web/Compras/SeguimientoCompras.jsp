<%-- 
    Document   : SeguimientoSolicitud.jsp
    Created on : 9/03/2010, 10:40:50 PM
    Author     : rfernandez
--%>

<%@ page contentType="text/html;" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@ page pageEncoding="iso-8859-1"%>

<html>
    <head>
        <title>Seguimiento Solicitud</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilProveedor.js'></script>
        <%
                    String strclUsrApp = "0";
                    String strFecha = "";

                    if (session.getAttribute("clUsrApp") != null) {
                        strclUsrApp = session.getAttribute("clUsrApp").toString();
                    }

                    if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsrApp)) != true) {
                     %>Fuera de Horario<%
                        return;
                    }

                     String StrclCompra = "0";
                
                    if (session.getAttribute("clCompra") != null ){
                        StrclCompra = session.getAttribute("clCompra").toString();
                    }

                    ResultSet rs = UtileriasBDF.rsSQLNP("select getdate() as 'fecha' ");
                    if (rs.next()) {
                        strFecha = rs.getString("fecha");
                    }

                    String StrclPaginaWeb = "5087";
                    session.setAttribute("clPaginaWebP", StrclPaginaWeb);
                    MyUtil.InicializaParametrosC(5087, Integer.parseInt(strclUsrApp));
        %>
        <script>fnOpenLinks()</script>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion", "")%>

        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleC_Compras.jsp?"%>'>
        <INPUT id='clCompra' name='clCompra' type='hidden' value='<%=StrclCompra%>'>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsrApp%>'>
        <INPUT id='Fecha' name='Fecha' type='hidden' value='<%=strFecha%>'>

        <%=MyUtil.ObjComboC("Estatus", "clEstatus", "", true, true, 30, 70, "", "select * from C_cestatus where clEstatus = 9", "", "", 50, true, false)%>
        <%=MyUtil.ObjTextArea("Seguimiento", "Observaciones", "", "100", "7", true, true, 30, 110, "", true, false)%>
        <%=MyUtil.DoBlock("Seguimiento de solicitud", 340, 90)%>

        <%=MyUtil.GeneraScripts()%>
        <%
                    strclUsrApp = null;
                    strFecha = null;
                   
        %>
    </body>
</html>
