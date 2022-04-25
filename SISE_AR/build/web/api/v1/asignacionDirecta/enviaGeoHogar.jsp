<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="Seguridad.SeguridadC,com.google.gson.Gson,java.sql.ResultSet,Utilerias.UtileriasBDF, ar.com.ike.util.rest.SimpleRESTCall, ar.com.ike.geo.hogar.ServicioHogarTO, ar.com.ike.geo.hogar.DireccionGeo,ar.com.ike.geo.hogar.ServicioHogarResponse, ar.com.ike.geo.hogar.Config "%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
    String sCLProveedor  = (request.getParameter("clproveedor") !=null?request.getParameter("clproveedor"):"0" );
    String sCLExpediente = (request.getParameter("clexpediente")!=null?request.getParameter("clexpediente"):"0");
    String sFechaCita    = (request.getParameter("fechaCita")   !=null?request.getParameter("fechaCita"):"0");
    String sHoraIniCita  = (request.getParameter("horaIniCita") !=null?request.getParameter("horaIniCita"):"0");
    String sHoraFinCita  = (request.getParameter("horaFinCita") !=null?request.getParameter("horaFinCita"):"0");
    boolean bPubAuto     = (request.getParameter("clproveedor") !=null?("1897".equalsIgnoreCase(request.getParameter("clproveedor"))):false);
%>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Publicar Expediente por GEO HOGAR</title>
    </head>
    <body>
        <%--
        PASOS: 
            Consultar expediente, si esta en condiciones:
                Armar objeto para publicacion
                Publicar
                Si retorno ok publicacion
                    Guardar el PVD asignado y bitacora.
                Si hay error:
                    Informar error, guardar error en bitacora y alguna tabla de log.
        --%>
        <%
            ResultSet cdr = UtileriasBDF.rsSQLNP( "sp_DetalleExpediente " + sCLExpediente );
            if (cdr.next()) {
                System.out.println(cdr.getString("clEstatus"));
                System.out.println(cdr.getString("clServicio"));
                Config cfg = new Config();
                System.out.println( cfg.getEndPoint() );
                if ( (cdr.getInt("clEstatus") == 0 || cdr.getInt("clEstatus") == 53   ) && cdr.getInt("clServicio") == 3 ) {
                    //El expediente debe estar en estado abierto y SERVICIO Hogar.
                    //Config cfg = new Config();
                    String url = cfg.getEndPoint();
                    SimpleRESTCall cli = new SimpleRESTCall();
                    cli.addHeader("Authorization", "Api-Key " + cfg.getApiKey() );
                    ServicioHogarTO servHogar = new ServicioHogarTO();
                    //servHogar.id_sise = Integer.parseInt(sCLCita);  //FIXME:: VA clCita ??
                    servHogar.nombre_cliente = cdr.getString("NuestroUsuario");
                    servHogar.clave_sise_cliente = cdr.getString("clave");
                    servHogar.email_cliente = cdr.getString("email");
                    servHogar.telefono_cliente = "1165458777"; //cdr.getString("lada1") + cdr.getString("telefono1");
                    servHogar.localidad = cdr.getString("codMD");
                    servHogar.servicio = cdr.getString("dsServicio");
                    servHogar.subservicio = cdr.getString("dsSubServicio");
                    servHogar.descripcion_servicio = cdr.getString("DescripcionOcurrido");
                    servHogar.zona = cdr.getString("dsMunDel");
                    servHogar.expediente =  sCLExpediente;
                    servHogar.urgente = ("EMERGENCIA".equalsIgnoreCase( cdr.getString("dsTipoServicio") ) ?true : false);
                    servHogar.clservicio = cdr.getInt("clServicio");
                    servHogar.clsubservicio = cdr.getInt("clSubServicio");
                    if ( !bPubAuto ) {
                       servHogar.codigo_proveedor = "14"; //999999"; //14"; //sCLProveedor;
                    }
                    else {
                        servHogar.codigo_proveedor = null;
                    }
                    cdr.close();
                    //DATOS GEO
                    ResultSet geoRS = UtileriasBDF.rsSQLNP( "st_getDetalleAsistenciaHogar " + sCLExpediente );
                    if (geoRS.next() ) {
                        servHogar.direccion = geoRS.getString("calle");
                        DireccionGeo dirGeo = new DireccionGeo(geoRS.getString("LatLong"));
                        servHogar.direccion_geo = dirGeo;                    
                        geoRS.close();
                    }
                    //DATOS CITA
                    //Obtengo el ID de la Cita.
                    ResultSet citaRS = UtileriasBDF.rsSQLNP( "st_getCLCitaByExpedientePVD " + sCLExpediente +"," + sCLProveedor );
                    if (citaRS.next() ) {
                        servHogar.id_sise = citaRS.getInt("clCita");
                        System.out.println("clCita: " +  citaRS.getString("clCita"));
                        citaRS.close();
                    }
                    
                    servHogar.dia = sFechaCita;  // "2019-11-20";
                    servHogar.hora_desde = sHoraIniCita;  //"09:00";
                    servHogar.hora_hasta = sHoraFinCita;  //"12:00";
                    //FIXME:
                    //Hacer un try catch.
                    //la clase de SimpleRestCall deveria retornar alguna Exception de HTTP u otras mas para poder capturar y guardas datos al respecto.
                    Gson gson = new Gson();
                    String postString = gson.toJson(servHogar);
                    //System.out.println(postString);
                    out.println("<!--");
                    out.println(postString);
                    out.println("-->");
                    
                    ServicioHogarResponse servHogarRes = (ServicioHogarResponse)cli.fetchGsonHttpsContent(url, "POST", servHogar, ServicioHogarResponse.class);
                    try {
                        System.out.println(servHogarRes.id);
                        out.println("<html><body><h3>Publicacion directa exitosa</h3>");
                        out.println("Id Geo Hogar:" + servHogarRes.id ); // FIXME:: VA EL CLCITA ???
                        out.println("<br />Proveedor: " + sCLProveedor );
                        out.println("<br />Expediente: " + sCLExpediente );
                        out.println("<br />Fecha Cita: " +sFechaCita);
                        out.println("<br />Desde: " + sHoraIniCita + " Hasta: " + sHoraFinCita);
                        out.println("<br /><form>\n<input type=\"button\" value=\"Cerrar Ventana\" onClick=\"window.close()\">\n</form></body></html>");
                        ResultSet rs = UtileriasBDF.rsSQLNP("st_WSGeoHogarRegistraEvento " + servHogarRes.expediente + ", " + servHogarRes.id + ", " +
                                " 1, null, 1, null, 1, 'OK', 1, 'ALTA', null, null, " + sCLProveedor  );
                    }
                    catch (Exception e) {
                        System.out.println("enviaGeoHogar.jsp:ERROR:" + e.toString());
                        out.println("<html><body><h3>Error en Publicacion directa</h3>");
                        out.println("<br /><form>\n<input type=\"button\" value=\"Cerrar Ventana\" onClick=\"window.close()\">\n</form></body></html>");
                    }
                }
            }
        %>
    </body>
</html>
