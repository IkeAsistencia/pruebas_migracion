<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html" pageEncoding="ISO-8859-1" language="java" %><%@page import="java.sql.ResultSet"%><%@page import="Utilerias.UtileriasBDF"%><%@page import="Seguridad.SeguridadC"%><%@page import="java.sql.ResultSet"%><%@page import="java.sql.ResultSet"%><%@page import="ar.com.ike.util.rest.SimpleRESTCall"%><%@page import="ar.com.ike.asignacion.to.AsignacionDirecta"%><%@page import="ar.com.ike.asignacion.to.AsignacionDirectaResponse"%>
<%  System.out.println("web/api/v1/asignacionDirecta/asignarConTec.jsp");
    String sExpediente = (request.getParameter("expediente")!=null?request.getParameter("expediente"):"0");
    String sProveedor  = (request.getParameter("proveedor")!=null?request.getParameter("proveedor"):"0");
    String sTEC        = (request.getParameter("TEC")!=null?request.getParameter("TEC"):"0");
    String sUsrApp     = (request.getParameter("usr")!=null?request.getParameter("usr"):"0");

    if ( !sExpediente.equals("0") && !sProveedor.equals("0") && !sTEC.equals("0") && !sUsrApp.equals("0" )) {
        ResultSet rs = UtileriasBDF.rsSQLNP( "st_getDirectaVial " + sExpediente + ", " + sUsrApp);
        if (rs.next()) {
            try {
                SimpleRESTCall cli = new SimpleRESTCall();
                //Armo el json con post y publico.
                String sUrl = "http://gps.ikeasistencia.com.ar:8000/ike_ng_r01/asignacion_directa";
                AsignacionDirecta asigTec = new AsignacionDirecta();
                asigTec.cobertura = rs.getString("dsGrupoCuenta");
                asigTec.codigo_de_autorizacion = sExpediente;
                asigTec.demora_esperada = Integer.parseInt(sTEC);
                asigTec.telefono =  rs.getString("Lada1") + " " + rs.getString("Telefono1");
                asigTec.denunciante = rs.getString("nuestrousuario");
                asigTec.desperfecto = rs.getString("descripcionocurrido");
                asigTec.origen = rs.getString("origen");
                asigTec.localidad = rs.getString("dsMunDel");
                asigTec.provincia = rs.getString("dsEntFed");
                asigTec.origengeo = rs.getString("origengeo");
                asigTec.observaciones ="";
                asigTec.idprestador = Integer.parseInt(sProveedor);
                asigTec.destino = rs.getString("destino");
                asigTec.destinogeo = rs.getString("destinogeo");
                asigTec.modelo = rs.getString("modelo"); 
                asigTec.color = rs.getString("color");
                asigTec.patente = rs.getString("patente");
                asigTec.titular = rs.getString("nuestrousuario");
                asigTec.servicio = rs.getString("dsServicio");
                asigTec.subservicio = rs.getString("dsSubServicio");
                AsignacionDirectaResponse adTECR = (AsignacionDirectaResponse)cli.fetchGsonContent(sUrl,"POST", asigTec , AsignacionDirectaResponse.class);
                //Pudo Insertar registro en WSSeguimiento y Bitacora.
                //Actualiza WSSeguimiento y bitacora con resultado de llamado a API Rest.
                UtileriasBDF.ejecutaSQLNP("st_WSActualizaDatosExp " + sExpediente + ",'" +  adTECR.casoid  + ":" + ( adTECR.resultado ?"OK":"ERR") + "'");
                out.println("<html><body><h3>Publicacion directa con TEC exitosa</h3>");
                out.println("<br />Id:" + adTECR.casoid );
                out.println("<br />Estado:" + adTECR.resultado);
                out.println("<br /><form>\n<input type=\"button\" value=\"Cerrar Ventana\" onClick=\"window.close()\">\n</form></body></html>");
            }
            catch (Exception e) {
                out.print("<h1>Error en Publicacion Directa con TEC</h1><br />");
                out.print(e.toString());
            }
        }
        else {
            //Se publico previamente.
            out.println("<html><body><h3>Publicacion directa con TEC<br />Expediente Previamente enviado.</h3>");
            out.println("<br /><form>\n<input type=\"button\" value=\"Cerrar Ventana\" onClick=\"window.close()\">\n</form>\n</body></html>");
        }
        rs.close();
    }
    else {
        System.out.println("asignarConTec.jsp:" + sExpediente + ":" + sProveedor  + ":" + sTEC + ":" + sUsrApp );
        out.println("<html><body><h3>Publicacion directa con TEC<br />Error en Parametros</h3>");
        out.println("<br /><form>\n<input type=\"button\" value=\"Cerrar Ventana\" onClick=\"window.close()\">\n</form>\n</body></html>");
    }
%>