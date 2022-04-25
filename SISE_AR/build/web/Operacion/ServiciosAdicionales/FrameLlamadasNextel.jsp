<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet" errorPage="" %>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<%
    String StrclLlamada = "0";  
    String StrclEmpresa = "0";  
   
    if (request.getParameter("clLlamada") != null)
    {
      StrclLlamada = request.getParameter("clLlamada");
    }    
    
    if (request.getParameter("clEmpresa") != null)
    {
      StrclEmpresa = request.getParameter("clEmpresa");
    }        
    
        String StrSqlSP = "";  
	%><%="<frameset framespacing='0' noresize frameborder='no' id='topm' rows='370,*'>"%>
        <%="  <frame frameborder='no' name='llamada' noresize id='llamada' src='../ServiciosAdicionales/RetencionNextel.jsp?clLlamada="%><%=StrclLlamada%><%="&Apartado=S' scrolling='yes'></frame>"%>
        <%="  <frame frameborder='no' name='numerosnextel' noresize id='numerosnextel' src='../ServiciosAdicionales/CancNumNextel.jsp?clEmpresa="%><%=StrclEmpresa%><%="&Apartado=S' scrolling='yes'></frame>"%>     
        <%="</frameset>"%><% 
%>
    
</html>
