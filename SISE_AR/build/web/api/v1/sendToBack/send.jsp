<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="Utilerias.UtileriasBDF" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%
    System.out.println("web/api/v1/sendToBack/send.jsp");
    try {
        if ( request.getMethod().equalsIgnoreCase("GET") ) {
            String sExpediente = ( request.getParameter("clExpediente") != null ?request.getParameter("clExpediente"): "0");
            String sUsrPublica = ( request.getParameter("clUsrApp") != null ? request.getParameter("clUsrApp"):"0");
            
            String sAProgramar = ( request.getParameter("AProgramar") != null ? request.getParameter("AProgramar"):"0");
            String sConExcedente = ( request.getParameter("ConExcedente") != null ? request.getParameter("ConExcedente"):"0");
            
            //Operacion default SEND TO BACK
            String sOperacion  = ( request.getParameter("operacion") != null ? request.getParameter("operacion"):"SEND");
            //Valida que se envie un clExpediente y un UsrApp.
            System.out.println("sExpediente: " + sExpediente );
            System.out.println("clUsrApp: " + sUsrPublica );
            System.out.println("AProgramar: " + sAProgramar );
            System.out.println("ConExcedente: " + sConExcedente );
            
            
            if ( "SEND".equalsIgnoreCase(sOperacion) ) {
                if ( !( "0".equals( sExpediente ) || "0".equals(sUsrPublica) ) ) {
                    //ENVIO INICIAL.
                    ResultSet rsEx = UtileriasBDF.rsSQLNP("st_EnviaExpediente " + sExpediente + ", " + sUsrPublica + ", 'SEND'," +sAProgramar+ "," + sConExcedente);
                    if ( rsEx.next() ) {
                        //Retorno registro
                        int tmpRetValue = rsEx.getInt("insertado");
                        if ( tmpRetValue == 1 ) {
                            //Inserto en bolsa de asignacion
                            response.setStatus(HttpServletResponse.SC_OK);
                        }
                        else {
                            if ( tmpRetValue == -2 ) {
                                System.out.println("Error, expediente previamente enviado");
                                response.sendError(HttpServletResponse.SC_ACCEPTED, rsEx.getString("comentarios") );
                            }
                            else {
                                //No estaban las condiciones para insertar
                                System.out.println("Error, Otro error");
                                response.sendError(HttpServletResponse.SC_CONFLICT,rsEx.getString("comentarios"));
                            }
                        }
                    }
                    rsEx.close();
                }
                else {
                    //ELSE GET
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST,"Error con parametros enviados");
                }
            }
            else {
                //OTRA OPERACION:: ENVIO POR AUTOMATICO. -> STATUS 10.
                if ( "AUTO".equalsIgnoreCase(sOperacion) ) {
                    if ( !( "0".equals( sExpediente ) || "0".equals(sUsrPublica) ) ) {
                        ResultSet rsEx = UtileriasBDF.rsSQLNP("st_EnviaExpediente " + sExpediente + ", " + sUsrPublica + ", 'AUTO'" );
                        int tmpRetValue = rsEx.getInt("insertado");
                        if ( tmpRetValue == 1 ) {
                            //Inserto en bolsa de asignacion
                            response.setStatus(HttpServletResponse.SC_OK);
                        }
                        else {
                            System.out.println("Error, expediente previamente enviado");
                           response.sendError(HttpServletResponse.SC_ACCEPTED, rsEx.getString("comentarios") );
                        }
                    }
                }
            }
        }
        else {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }
    catch (Exception e) {
        System.out.println("/api/v1/sendToBack/send.jsp:Error:" + e.toString());
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
%>