<%@page contentType="text/html; charset=iso-8859-1"%>

<html>
<head><title>JSP Page</title></head>

<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<frameset framespacing='0' noresize frameborder='no' cols="500,*">
    <frame frameborder='no' noresize name='Selecccion' id='Seleccion' src='AsignaciondeAsist.jsp'></frame>
    <frame frameborder='no' noresize name='VistaPrevia' id='VistaPrevia' src='../Empty.jsp?'></frame>
</frameset>

</html>
