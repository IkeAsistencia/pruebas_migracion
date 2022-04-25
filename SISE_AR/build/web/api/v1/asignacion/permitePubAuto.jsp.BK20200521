<%@page contentType="text/html" pageEncoding="ISO-8859-1" import="Utilerias.UtileriasBDF, java.sql.ResultSet"%><%
    System.out.println("web/api/v1/asignacion/permitePubAuto.jsp");
    String clExpediente = (request.getParameter("clExpediente")!=null?request.getParameter("clExpediente"): null);
    try {
        ResultSet rs = UtileriasBDF.rsSQLNP("st_WSValidaExpediente " + clExpediente );
        if ( rs.next() ) {
            int permite = (rs.getObject("PermiteWS")!=null?rs.getInt("PermiteWS"):-1);
            System.out.print("PermiteWS:");
            System.out.println( rs.getInt("PermiteWS" ) );
            //LOGICA DE CANTIDAD DE REPUBLICACIONES AUTOMATICAS
            if ( permite > 0 && permite < 2 ) {
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
        System.out.println("/api/v1/asignacion/permitePubAuto.jsp:Error:" + e.toString());
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }%>