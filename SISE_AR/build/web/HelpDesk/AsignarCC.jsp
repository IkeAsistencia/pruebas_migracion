<%@page contentType="text/html; charset=iso-8859-1" import="Seguridad.SeguridadC,Utilerias.UtileriasBDF" %>
<html>
<head><title>Asignación de Usuarios a Solicitudes</title></head>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<body class="cssBody">

<%

    String StrclUsrApp="0";
    String StrclPaginaWeb="0";
   
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {%>
       Fuera de Horario
       <%return;  
     }    

    StringBuffer StrSql = new StringBuffer();
    StrSql.append("sp_AsignarUsuariosSol ");
    StrSql.append(session.getAttribute("clUsrApp").toString());
    StrSql.append(",'").append(request.getParameter("UsuariosSeleccionados").toString());
    StrSql.append("','").append(request.getParameter("clSolicitud").toString()).append("'");
    StringBuffer strSalida = new StringBuffer();
    
    UtileriasBDF.rsTableNP(StrSql.toString(), strSalida);
    %><%=strSalida.toString()%><%
    
    strSalida.delete(0,strSalida.length());
    StrSql=null;
    
    StrclUsrApp=null;
    StrclPaginaWeb=null;
    
%>
</body>
</html>
