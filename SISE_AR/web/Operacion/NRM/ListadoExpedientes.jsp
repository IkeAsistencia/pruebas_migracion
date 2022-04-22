<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <link href="../../StyleClasses/Bootstrap/bootstrap.min.css" rel="stylesheet"  type="text/css">
        <link href="../../StyleClasses/AlertaNRM.css" rel="stylesheet" type="text/css">
        <title>Listado de PreAfilidados NRM</title>
    </head>
    <body class='cssBody' topmargin='10' style="width: 90%; margin: auto;">
        
        <%
        String StrclUsrApp="0";
        if(session.getAttribute("clUsrApp") != null){
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
            System.out.println("El clUsrApp que llego es: " + StrclUsrApp);
        }
        if(SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp, 10)) != true) {
            %>Fuera de Horario<%
            StrclUsrApp = null;
            return;
        }
        %>
        <p class="cssTitDet" style="width: 30%; margin: auto; margin-top: 20px;">Listado de Expedientes Proveedor NRM</p>
        <% 
        StringBuffer strSql = new StringBuffer();
        StringBuffer strSalida = new StringBuffer();
        UtileriasBDF.rsTableNP(strSql.append("[st_nrm_ListaExpedientesProveedor] ").append(StrclUsrApp).toString(), strSalida);
        %><%=strSalida.toString()%><%
        strSql.delete(0,strSql.length());
        strSalida.delete(0,strSalida.length());
        strSalida = null;
        strSql = null;
        StrclUsrApp = null;
        %>
        
       <script src='../../Utilerias/Util.js'></script>
       <script src='js/InfoUsuarioNRM.js'></script>
       <script src='../../Utilerias/v1/Ajax.js'></script>
       <script src='../../Utilerias/v1/AjaxConsumeWs.js'></script>
    </body>
</html>