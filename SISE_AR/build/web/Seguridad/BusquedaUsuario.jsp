


<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html> 
    <head>
        <title>Filtro Nuestro Usuario</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">

        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='Utilerias/Util.js' ></script>
        <%

        String usrPerfil =  "";
        StringBuffer strSql = new StringBuffer();


        if(request.getParameter("Usuario") != null){
            usrPerfil = request.getParameter("Usuario").toString().trim();
        }

        strSql.delete(0, strSql.length());
        if(request.getParameter("strSQL") != null){
            strSql.append(request.getParameter("strSQL").toString());
            strSql.append(" '").append(usrPerfil).append("'");
        }

        if( strSql.length() > 0){
            StringBuffer strSalida = new StringBuffer();
            UtileriasBDF.rsTableNP(strSql.toString(), strSalida);

        %>
        <%=strSalida.toString()%>

        <%
        strSalida.delete(0,strSalida.length());
    }
        strSql.delete(0,strSql.length());
        %>
    </body>
</html>
