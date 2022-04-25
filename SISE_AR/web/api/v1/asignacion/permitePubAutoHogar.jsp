<%@page contentType="text/html" pageEncoding="ISO-8859-1" import="Utilerias.UtileriasBDF, java.sql.ResultSet"%><%
    System.out.println("web/api/v1/asignacion/permitePubAutoHogar.jsp");
    String clExpediente = (request.getParameter("clExpediente")!=null?request.getParameter("clExpediente"): null);
    try {
        ResultSet rs = UtileriasBDF.rsSQLNP("st_WSValidaExpedienteHogar " + clExpediente );
        if ( rs.next() ) {
            int permite = (rs.getObject("PermiteWS")!=null?rs.getInt("PermiteWS"):-1);
            System.out.print("PermiteWS.Hogar:");
            System.out.println( rs.getInt("PermiteWS" ) );
            //LOGICA DE CANTIDAD DE REPUBLICACIONES AUTOMATICAS
            if ( permite > 0 ) {
                System.out.println("Permite" + clExpediente );
                response.setStatus(HttpServletResponse.SC_OK);
            }
            else {
                System.out.println("No Permite" + clExpediente);
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
            }
        }
        rs.close();
    }
    catch (Exception e) {
        System.out.println("/api/v1/asignacion/permitePubAutoHogar.jsp:Error:" + e.toString());
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }%>