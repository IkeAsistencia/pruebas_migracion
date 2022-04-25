<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>JSP Page</title> 
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <!--jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /--> 
        <script src='../Utilerias/Util.js' ></script>
        <%
            String StrclUsrApp = "0";
            String StrclPaginaWeb = "434";

            if (session.getAttribute("clUsrApp") != null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();

        %>
        <iframe name="Listado de Costos" id="ListadoCostos" src="Browser.jsp" width="100%" height="100%" frameborder="1"></iframe>
        <%            
            }else{
            %>Debe iniciar sesion.<%
            }

            StrclUsrApp = null;
            StrclPaginaWeb = null;
        %>
    </body>
</html>
