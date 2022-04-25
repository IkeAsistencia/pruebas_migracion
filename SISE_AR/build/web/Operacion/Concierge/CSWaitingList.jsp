<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>Waiting List</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onLoad="">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script type="text/javascript" src='../../Utilerias/Util.js' ></script>
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px; right:10px;'>
            <p align="center"><font color="navy" face="Arial" size="2" ><b><i></i></b></font><br>
            </p>
        </div>
        <%
                    StringBuffer strSalida = new StringBuffer();
                    String StrClAsistencia = "0";
                    
                    if(request.getParameter("pclAsistencia") != null){
                         StrClAsistencia = request.getParameter("pclAsistencia").toString();                
                    }
                    
                    //UtileriasBDF.rsTableNP("st_CSWaitingList ", strSalida);
                    System.out.println("st_CSWaitingList " + StrClAsistencia);
                    UtileriasBDF.rsTableNP("st_CSWaitingList " + StrClAsistencia, strSalida);
        %>
        <%=strSalida.toString()%>
        <%strSalida.delete(0, strSalida.length());%>
        <%
                    strSalida = null;
        %>

    </body>
</html>
