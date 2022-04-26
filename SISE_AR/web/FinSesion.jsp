<%@page contentType="text/html; charset=iso-8859-1" import="Utilerias.UtileriasBDF"%>
<html>
<head><title>Cierra Session</title></head>
<body>
<%
    String strUsuario="0";
    if (session.getAttribute("Usr")!=null){
      strUsuario = session.getAttribute("Usr").toString();
    }
    
    UtileriasBDF.actSQLNP("Update BitacoraAccesos set FechaFinSess = getdate() where usuario = '" + strUsuario + "' and FechaFinSess is null");
    session.invalidate();
%>
<script>
top.location.href='Registro.jsp';
    //window.close()
</script>
</body>
</html>
