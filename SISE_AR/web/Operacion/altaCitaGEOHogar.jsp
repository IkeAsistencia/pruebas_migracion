<%@page contentType="text/html" pageEncoding="ISO-8859-1" import="ar.com.ike.geo.hogar.api.ApplicationConfig,java.sql.ResultSet,Utilerias.UtileriasBDF"%>
<%@page import="Seguridad.SeguridadC,com.google.gson.Gson,ar.com.ike.util.rest.SimpleRESTCall,ar.com.ike.geo.hogar.ServicioHogarTO,ar.com.ike.geo.hogar.DireccionGeo"%>
<%@page import="ar.com.ike.geo.hogar.ServicioHogarResponse,ar.com.ike.geo.hogar.Config"%>
<% 
    String StrclUsrApp = "0";
    if (session.getAttribute("clUsrApp") != null) {
        StrclUsrApp = session.getAttribute("clUsrApp").toString();      }
    if(SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true){
        %><font color="white"  style="font-family:Verdana,Arial,Helvetica,sans-serif; background-color:red;" size=3>LA SESION EXPIRO</font><%  
        StrclUsrApp=null;
        return;
        }    
    String sCLExpediente  = (request.getParameter("clExpediente")  !=null?request.getParameter("clExpediente")  :null);
    String sCLProveedor   = (request.getParameter("clProveedor")   !=null?request.getParameter("clProveedor")   :null);
    String sCLEstatusCita = (request.getParameter("clEstatusCita") !=null?request.getParameter("clEstatusCita") :null);
    String sFecha         = (request.getParameter("Fecha")         !=null?request.getParameter("Fecha")         :null);
    String sHoraD         = (request.getParameter("HoraD")         !=null?request.getParameter("HoraD")         :null);
    String sHoraH         = (request.getParameter("HoraH")         !=null?request.getParameter("HoraH")         :null);
    String sCLUsrApp      = (request.getParameter("clUsrApp")      !=null?request.getParameter("clUsrApp")      :null);
    String sEnvioHogar    = (request.getParameter("enviarGeoHogar")!=null?request.getParameter("enviarGeoHogar"):null);
    //Tipo = 1 == ASIGNACION DIRECTA  ## Tipo = 2 == ASIGNACION AUTOMATICA
    //Campos con datos temporales por si falla el alta en geo hogar y hay que hacer un rollback.
    int rlbClCita = 0;
    int rlbClEstatusCita = 0;
    boolean rollback = false;
    boolean bAutomatica   = (request.getParameter("AUTO")          !=null?"1".equals(request.getParameter("AUTO")):false);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>altaCitas</title>
    </head>
    <body>
     <%        
        Config cfg = new Config();
        String url = cfg.getEndPoint();
        SimpleRESTCall cli = new SimpleRESTCall();
        cli.addHeader("Authorization", "Api-Key " + cfg.getApiKey() );
        if (sCLExpediente != null && sCLEstatusCita != null && sCLProveedor != null && sFecha != null && sHoraD != null) {
            String parms = sCLExpediente + ", " + sCLProveedor + ", " + sCLEstatusCita + ", " + "\"" + sFecha + "\", " +
                           "\"" + sHoraD + "\", " + "\"" + sHoraH + "\", " + sCLUsrApp;
            ServicioHogarTO servHogar = new ServicioHogarTO();
            //NOTA:: AUTOMATICA SE UTILIZA PARA CONCENPTOS DISTINTOS EN DISTINTOS LADOS. 
            //       ACA AUTOMATICA SIGNIFICA QUE ES POR ASIGNACION COMPULSA.
            bAutomatica =( ApplicationConfig.CL_PVD_PENDIENTE_APP.equals(sCLProveedor) || sCLProveedor.isEmpty()  );
            //Alta en CitasXExpediente
            try {
                ResultSet rs = UtileriasBDF.rsSQLNP( "st_AltaCitaXExpediente " + parms );
                if (rs.next()) {
                    rlbClCita = rs.getInt("RollBackCLCita");
                    rlbClEstatusCita = rs.getInt("RollBackCLEstatusCita");
                    servHogar.id_sise = rs.getInt("clCita");  
                    servHogar.nombre_cliente = rs.getString("NuestroUsuario");
                    servHogar.clave_sise_cliente = rs.getString("clave");
                    servHogar.email_cliente =  ( (null != rs.getString("email") && !rs.getString("email").equals("") )? rs.getString("email"): "operacione@ikeasistencia.com.ar" ) ;
                    //Hay que limpiar el 0 inicial de lada 1
                    String tmpCaracteristica = "";
                    if (null != rs.getString("lada1") ) {
                        tmpCaracteristica = rs.getString("lada1").trim();
                        tmpCaracteristica = tmpCaracteristica.startsWith("0")?tmpCaracteristica.substring(1):tmpCaracteristica;
                        }
                    //Si el numero arranca con 15 hay que quitarlo.
                    String tmpNumero = "";
                    if ( null != rs.getString("telefono1")  ) {
                        tmpNumero = rs.getString("telefono1").trim();
                        tmpNumero = tmpNumero.startsWith("15")?tmpNumero.substring(2):tmpNumero;
                        }
                    String telefono = tmpCaracteristica + tmpNumero;
                    servHogar.telefono_cliente = (telefono.isEmpty()?"+541141360963":  "54" + telefono);
                    servHogar.localidad = rs.getString("codMD");
                    servHogar.servicio = rs.getString("dsServicio");
                    servHogar.subservicio = rs.getString("dsSubServicio");
                    servHogar.descripcion_servicio = rs.getString("DescripcionOcurrido");
                    servHogar.zona = rs.getString("dsMunDel");
                    servHogar.expediente =  sCLExpediente;
                    servHogar.urgente = ("EMERGENCIA".equalsIgnoreCase( rs.getString("dsTipoServicio") ) ?true : false);
                    servHogar.clservicio = rs.getInt("clServicio");
                    servHogar.clsubservicio = rs.getInt("clSubServicio");
                    //TODO: VER SI SE AGREGAN CAMPO DE REFERENCIAS VISUALES
                    servHogar.direccion = rs.getString("calle");
                    DireccionGeo dirGeo = new DireccionGeo(rs.getString("LatLong"));
                    servHogar.direccion_geo = dirGeo;                    
                    servHogar.dia = sFecha;
                    servHogar.hora_desde = sHoraD;
                    servHogar.hora_hasta = sHoraH;
                    servHogar.vip = rs.getBoolean("VIP");
                    servHogar.cliente_chat_id = rs.getString("user_chat");
                    String uuidCita = rs.getString("UUID");
                    servHogar.canal_chat = "cita_"+uuidCita;
                    
                    if ( bAutomatica  ) {     servHogar.codigo_proveedor = null;
                    } else {       servHogar.codigo_proveedor = sCLProveedor;          }
                    rs.close();
                    // SI ES UN SERVICIO HOGAR Y VA POR GEO HOGAR
                    if ( servHogar.clservicio == 3  ) {
                        //Alta en GEOHogar
                        //la clase de SimpleRestCall deveria retornar alguna Exception de HTTP u otras mas para poder capturar y guardas datos al respecto.
                        Gson gson = new Gson();
                        String postString = gson.toJson(servHogar);
                        out.println("<!--");    
                        out.println(postString);
                        out.println("-->");
                        ServicioHogarResponse servHogarRes = (ServicioHogarResponse)cli.fetchGsonHttpsContent(url, "POST", servHogar, ServicioHogarResponse.class);
                        if ( !bAutomatica ) {
                            out.println("<html><body><h3>Publicacion Directa exitosa</h3>");
                            out.println("<br />Proveedor: " + sCLProveedor );
                        } else {
                            out.println("<html><body><h3>Publicacion Automatica exitosa</h3>");
                        }
                        out.println("<br />Id Geo Hogar:" + servHogarRes.id );
                        out.println("<br />Expediente: " + sCLExpediente );
                        out.println("<br />Fecha Cita: " +sFecha);
                        out.println("<br />Desde: " + sHoraD + " Hasta: " + sHoraH);
                        out.println("<br /><form>\n<input type=\"button\" value=\"Cerrar Ventana\" onClick=\"window.close()\">\n</form> "
                                + " <script type=\"text/javascript\"> "
                                + " window.oncontextmenu = function() { return false; } "
                                + " </script>"
                                + " </body></html>");
                        ResultSet rs2 = UtileriasBDF.rsSQLNP("st_WSGeoHogarRegistraEvento " + servHogarRes.expediente + ", " + servHogarRes.id + ", " +
                           (bAutomatica?"1":"0") + " , null, 1, null, 1, 'OK', 1, 'ALTA', null, null, " + sCLProveedor);
                        rs2.close();
                    }
                }
            }                
            catch (Exception e) {                
                UtileriasBDF.ejecutaSQLNP("st_RLB_AltaCitaXExpediente " + sCLExpediente + ", " + sCLProveedor + ", " +
                    rlbClCita + ", " +  rlbClEstatusCita + ", " + servHogar.id_sise );                
                out.println("<h3>Error al GUARDAR Estado en SISE de Publicacion Directa HOGAR</h3>");
                out.println("<input type=\"button\" value=\"Cerrar Ventana\" onClick=\"window.close()\">\n</form>");
                }
            finally {      session.removeAttribute("MODO");        }
        }else {
            out.println("<h3>Cita Creada</h3>");
            out.print("<br /><form>\n<input type=\"button\" value=\"Reintentar Envio\" onClick=\"location.reload();\">\n<br /> ");
            out.println("<input type=\"button\" value=\"Cerrar Ventana\" onClick=\"window.close()\">\n</form>");
            }
        %>
        </table>
    </body>
</html>
