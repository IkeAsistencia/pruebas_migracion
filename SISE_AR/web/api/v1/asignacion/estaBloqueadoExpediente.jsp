<%@page contentType="text/html" pageEncoding="ISO-8859-1" import="Utilerias.UtileriasBDF, java.sql.ResultSet"%><%
    System.out.println("web/api/v1/asignacion/estaBloqueadoExpediente.jsp");
    String clExpediente = (request.getParameter("clExpediente")!=null?request.getParameter("clExpediente"): null);
    String clUsrApp     = (request.getParameter("clUsrApp")!=null?request.getParameter("clUsrApp"):null);
    try {
        ResultSet rs = UtileriasBDF.rsSQLNP("st_estaExpedienteBloqueado " + clExpediente );
        if ( rs.next() ) {
            int owner = (rs.getObject("clUsrAppAsignado")!=null?rs.getInt("clUsrAppAsignado"):0);
            int publicado = (rs.getObject("ExpPublicado")!=null?rs.getInt("ExpPublicado"):0);
            
            if ( publicado == 0 ) {
                //NO PUBLICADO. Se puede publicar. retornar 200,
                System.out.println("No Publicado en back:" + clExpediente + " : " + clUsrApp  );
                response.setStatus(HttpServletResponse.SC_OK);
            }
            else {
                //Publicado.
                if (owner == 0  ) {
                    //SIN DUEÑO.  HTTP_CODE: 409
                    System.out.println("Enviado a Asignar y SIN Dueño" + clExpediente + ":" + clUsrApp );
                    response.sendError(HttpServletResponse.SC_CONFLICT,"PUBLISHED");
                }
                else {
                    //Publicado CON DUEÑO
                    if ( owner == Integer.parseInt(clUsrApp) ) {
                        //SI SOY DUEÑO -> Puedo ASIGNAR  -HTTP_CODE: 202
                        System.out.println("Publicado y Owner: Puede Asignar" + clExpediente + ":" + clUsrApp );
                        response.setStatus(HttpServletResponse.SC_ACCEPTED);
                    }
                    else {
                        //NO DUEÑO -> NO ASIGNAR   -HTTP_CODE: 403
                        System.out.println("Publicado y NO Owner: No puede accionar" + clExpediente + ":" + clUsrApp );
                        response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    }
                }
            }
        }
        rs.close();
    }
    catch (Exception e) {
        System.out.println("/api/v1/asignacion/estaBloqueadoExpediente.jsp:Error:" + e.toString());
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }%>