<%@page contentType="text/html" pageEncoding="ISO-8859-1" import="Utilerias.UtileriasBDF, java.sql.ResultSet"%><%

    try {
        if ( request.getMethod().equalsIgnoreCase("GET") ) {
            String sExpediente = ( request.getParameter("clExpediente") != null ?request.getParameter("clExpediente"): "0");
            String sUsrPublica = ( request.getParameter("clUsrApp") != null ? request.getParameter("clUsrApp"):"0");
            ResultSet rsEx = UtileriasBDF.rsSQLNP("st_validaExpxCC " + sExpediente + ", " + sUsrPublica  );
            if ( rsEx.next() ) {
                //Retorno registro       
                System.out.println( "validarCosto.jsp:retSQL:" + rsEx.getString("codigo") );
                int tmpRetValue = Integer.parseInt( rsEx.getString("codigo") );
                /*
                if ( tmpRetValue == 0 ) {
                    System.out.println("response OK");
                    response.setStatus(HttpServletResponse.SC_OK);
                }else if(tmpRetValue == 3){
                    System.out.println("Validacion de Costos: " + rsEx.getString("msg"));                    
                    response.setStatus(HttpServletResponse.SC_ACCEPTED);
                }else{
                    System.out.println("Error valida expediente: " + rsEx.getString("msg"));
                    response.sendError(HttpServletResponse.SC_CONFLICT,rsEx.getString("msg"));     
                    }
                */
                if ( tmpRetValue == 0 ) {
                    System.out.println("response OK");
                    response.setStatus(HttpServletResponse.SC_OK);
                }
                else {
                    System.out.println("Error valida expediente: " + rsEx.getString("msg"));
                    response.sendError(HttpServletResponse.SC_CONFLICT,rsEx.getString("msg"));     
                }
            }
            rsEx.close();
        }
        else {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Metodo Incorrecto" );
        }
    }
    catch (Exception e) {
        System.out.println("/api/v1/seguimiento/validarCosto.jsp:Error:" + e.toString());
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
    %>

