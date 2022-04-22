<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<title></title>
</head>
<script src='Util.js'></script>

<%
    String StrclUsrApp="0";
    String strDesc="";
    String strSQL="";
    
    
    
    byte bytLanguaje=2;

    if (session.getAttribute("clUsrApp")!= null){
        StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     } 
    
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %><%="Fuera de Horario"%>
        <% return; 
     } 
     
    %>
    <body class='cssBody' topmargin='25'><%
    
    String clPaginaWeb="444";
    
    if (request.getParameter("Desc")!=null){
        strDesc=request.getParameter("Desc").toString();
    }

    if (request.getParameter("strSQL")!=null){
        strSQL=request.getParameter("strSQL").toString();
    }
    
    %>
    <form action='FiltroBusquedaGral.jsp' method='get' >
    <table><tr><td><%="Descripción"%></td><td>
    <input type='text' size='70' name='Desc' id='Desc' value='<%=strDesc%>'></td>
    </tr></table>
    <input type='hidden' name='strSQL' id='strSQL' value='<%=strSQL%>'>
    <input type='submit' class='cBtn' value='Buscar...'>
    <input type='button' class='cBtn' value='Cancelar...' onClick='window.close();'>
    </form>
    
    <%
    StringBuffer StrSql = new StringBuffer();
    StrSql.append(strSQL).append(" ").append(StrclUsrApp).append(",'").append(strDesc).append("'");
    StringBuffer strSalida = new StringBuffer();
    UtileriasBDF.rsTableNP(StrSql.toString(),strSalida);
    %>
       <%=strSalida.toString()%>
    <%
    strSalida.delete(0,strSalida.length());
    StrSql.delete(0,StrSql.length());
%>
</body>
</html>


