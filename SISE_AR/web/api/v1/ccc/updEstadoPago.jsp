<%@page contentType="text/html" pageEncoding="ISO-8859-1" import="Utilerias.UtileriasBDF, java.sql.ResultSet"%><%
    System.out.println("web/api/v1/ccc/updEstadoPago.jsp");
    try {
        if ( request.getMethod().equalsIgnoreCase("GET") ) {
            String sPagoProveedor = ( request.getParameter("clPagoProveedor") != null ? request.getParameter("clPagoProveedor"): "0");
            String sEstatus       = ( request.getParameter("clEstatus")       != null ? request.getParameter("clEstatus"):"0");
            String sComentarios   = ( request.getParameter("Comentario")      != null ? request.getParameter("Comentario"):"''" );
            System.out.println("st_EnviaExpDisputaCC " + sPagoProveedor + ", " + sEstatus + ", " + sComentarios);
            ResultSet rsEx = UtileriasBDF.rsSQLNP("st_EnviaExpDisputaCC " + sPagoProveedor + ", " + sEstatus + ", " + sComentarios );
            if ( rsEx.next() ) {
                //Retorno registro
                //RESULTADO: -1 ERROR, 0 SIN ACTUALIZAR, >0 ACTUALIZADO
                System.out.println( "updEstadoPago.jsp:retSQL:" + rsEx.getString("resultado") );
                int tmpRetValue = Integer.parseInt( rsEx.getString("resultado") );
                System.out.println(tmpRetValue);
                if ( tmpRetValue > 0 ) {
                    System.out.println("response OK");
                    response.setStatus(HttpServletResponse.SC_OK);
                }
                else {
                    if (tmpRetValue == 0 ) {
                        System.out.println("Error, NO SE ACTUALIZO NINGUN REGISTRO");
                        response.sendError(HttpServletResponse.SC_CONFLICT, "NO SE ACTUALIZO NINGUN PAGO");
                    }
                    else {
                        System.out.println("Error, Estado incorrecto");
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST,"ESTADO INCORRECTO");
                    }
                }
            }
            rsEx.close();
        }
        else {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Metodo Incorrecto" );
        }
    }
    catch (Exception e) {
        System.out.println("/api/v1/seguimiento/updEstadoPago.jsp:Error:" + e.toString());
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
    %>           