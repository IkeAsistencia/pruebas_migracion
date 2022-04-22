<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="snaq.db.ConnectionPool,java.sql.Connection,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<script src='../Utilerias/Util.js'></script>

<%  

    String StrclUsrApp = "0";
    ConnectionPool conPool = null;
    Connection con = null;
    //UtileriasBDF.InitAgain();
    conPool = UtileriasBDF.getPool();
    //conPool.releaseForcibly();
    //conPool.flush();
    //conPool.init(10);
    //con = UtileriasBDF.getConnection();
    if (session.getAttribute("clUsrApp")!= null){
        StrclUsrApp= session.getAttribute("clUsrApp").toString(); 
    }
    
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %>Fuera de Horario<%
        //con.close();return;
    }
    
    %><script>fnCloseLinks()</script><%
    StringBuffer StrSQL = new StringBuffer();
    String StrclPaginaWeb = "408";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    //con.close();
    %>
    Free Count: <%=conPool.getFreeCount()%>
    Pool Size: <%=conPool.getPoolSize()%>
    Size: <%=conPool.getSize()%>
    Hit Rate: <%=conPool.getHitRate()%>
    MaxSize: <%=conPool.getMaxSize()%>
    Is Async: <%=conPool.isAsyncDestroy()%>
    
    <%  %>
</body>
</html>
