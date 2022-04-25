<%@page contentType="text/html" pageEncoding="ISO-8859-1"%><%
    System.out.println("web/api/v1/util/setExpedienteEnSession.jsp");
    try {
        String clExpediente = (request.getParameter("clExpediente")!= null ?  request.getParameter("clExpediente"): null );
        if ( clExpediente != null ) {
            session.setAttribute("clExpediente", clExpediente);
            response.setStatus(HttpServletResponse.SC_OK);
        }
        else {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
        }
    }
    catch (Exception e) {
        System.out.println("/api/v1/util/setExpedienteEnSession.jsp:Error:" + e.toString());
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }%>