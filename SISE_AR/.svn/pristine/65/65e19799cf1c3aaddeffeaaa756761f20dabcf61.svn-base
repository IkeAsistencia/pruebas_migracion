<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head><title>Supervisión Serfin</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js'></script>
        <script src='../../Utilerias/UtilDireccion.js'></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <script src='../../Utilerias/UtilGM.js'></script>
        <%   
        String StrclUsrApp="0";
        String StrclPaginaWeb="0";
        String strClave ="";
        StringBuffer strSql= new StringBuffer();
        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>
        Fuera de Horario
        <% 
        return;
        }
        
        if (request.getParameter("Clave")!= null) {
            strClave = request.getParameter("Clave").toString().trim();
        }
        if (strClave.compareToIgnoreCase("")!=0){
            strSql.append(" Select clave from CSConcierge where clave='").append(strClave).append("'");
            ResultSet rs = UtileriasBDF.rsSQLNP( strSql.toString());
            strSql.delete(0,strSql.length());
            if (rs.next()) {
        %>
<script>top.opener.fnVerificaClave(1,'')</script>
        <script>window.close()</script>
        <%
            } else {
        %>
<script>top.opener.fnVerificaClave(0,'')</script>
        <script>window.close()</script>
        <%
            }
        }
        
        else{
        %>
        <script>alert("Debe de Ingresar la Clave");
        window.close();
        </script>
        <%
        }
        %>
    </body>
</html>  