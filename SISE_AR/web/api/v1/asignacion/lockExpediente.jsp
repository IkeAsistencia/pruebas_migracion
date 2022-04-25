<%@page contentType="text/html" pageEncoding="ISO-8859-1" import="Utilerias.UtileriasBDF, java.sql.ResultSet, java.util.ArrayList, java.util.List, com.google.gson.Gson, com.google.gson.GsonBuilder, ar.com.ike.api.back.asignacion.ExpedienteTO"%><%
    System.out.println("web/api/v1/asignacion/lockExpedientes.jsp");
    String clExpediente = (request.getParameter("clExpediente")!=null?request.getParameter("clExpediente"): null);
    String clUsrApp     = (request.getParameter("clUsrApp")!=null?request.getParameter("clUsrApp"):null);
    //Operacion: LOCK o UNLOCK
    String sOperacion   = (request.getParameter("operacion")!=null?request.getParameter("operacion"):null);
    sOperacion =  ( ( "LOCK".equalsIgnoreCase(sOperacion) || "UNLOCK".equalsIgnoreCase(sOperacion ) ) ? sOperacion.toUpperCase() : null);
    try {
        if ( clExpediente != null  && clUsrApp != null && sOperacion != null ) {
            ResultSet rs = UtileriasBDF.rsSQLNP("st_lockExpedienteAAsignar " + clExpediente + ", " + clUsrApp + ", " + sOperacion);
            if ( rs.next() ) {
                //Si el resultado fue mayor >-1 la operacion fue exitosa, sino fue error.
                boolean bResult = (rs.getObject("lockOn")!=null?rs.getInt("lockOn")>-1:false );
                if ( bResult ) {
                    System.out.println("LockOn:" + clExpediente + " : " + clUsrApp + " : " + sOperacion );
                    response.setStatus(HttpServletResponse.SC_OK);
                }
                else {
                    System.out.println("LockOn.Error:" + clExpediente + ":" + clUsrApp+ " : " + sOperacion );
                    response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
                }
            }
            rs.close();
        }
        else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    catch (Exception e) {
        System.out.println("/api/v1/asignacion/listaExpedientes.jsp:Error:" + e.toString());
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
%>