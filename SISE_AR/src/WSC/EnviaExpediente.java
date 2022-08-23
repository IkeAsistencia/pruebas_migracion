/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package WSC;

import java.sql.ResultSet;
import Utilerias.UtileriasBDF;
import javax.xml.ws.BindingProvider;
/**
 *
 * @author mramirez
 */
public class EnviaExpediente extends com.ike.model.DAOBASE {  //09436 mzara

    private String getTipoLogica( int clGrupoCuenta ) {
            return String.valueOf(clGrupoCuenta);
    } 
    
    public int EnviaExpediente(String clExpediente, String clUsrApp) {
        System.out.println("WS 2 EnviaExpediente: " + clExpediente );
        try { // Call Web Service Operation
            ResultSet rsEx = UtileriasBDF.rsSQLNP("st_WSgetDatosExp " + clExpediente + "," + clUsrApp);
            if (rsEx.next()) {
                System.out.println("WS 3");
// -- PROD
//                ar.com.ike.geo.ws.tns.Application_Service service = new ar.com.ike.geo.ws.tns.Application_Service();
//                ar.com.ike.geo.ws.tns.Application port = service.getApplication();

// -- DEV
                ar.com.ike.geo.ws.capa.Application_Service service = new ar.com.ike.geo.ws.capa.Application_Service();
                ar.com.ike.geo.ws.capa.Application port = service.getApplication();
                
                // TODO initialize WS operation arguments here
                java.lang.String nombreOrigen = rsEx.getString("NombreOrigen");
                java.lang.String codigoDeAutorizacion = rsEx.getString("CodigoAutorizacion");
                java.lang.String telefono = rsEx.getString("Telefono");
                java.lang.String denunciante = rsEx.getString("QuienReporta");
                java.lang.String cobertura = rsEx.getString("Cobertura");
//                java.lang.String cobertura = getTipoLogica(rsEx.getInt("clGrupoCuenta"));
                java.lang.String tipoSrvInicial = rsEx.getString("ServicioSubServicio");
                java.lang.String desperfecto = rsEx.getString("Desperfecto");
                java.lang.String ubicacion = rsEx.getString("Ubicacion");
                java.lang.String localidad = rsEx.getString("Localidad");
                java.lang.String destino = rsEx.getString("Destino");
                java.lang.String origengeo = rsEx.getString("Origengeo");
                java.lang.String destinogeo = rsEx.getString("Destinogeo");
                java.lang.String patente = rsEx.getString("Patente");
                java.lang.String titular = rsEx.getString("Titular");
                java.lang.String modelo = rsEx.getString("Modelo");
                java.lang.String color = rsEx.getString("Color");
                java.lang.String horaInicio = rsEx.getString("HoraInicio");
                java.lang.String operador = rsEx.getString("Operador");
                java.lang.String observaciones = rsEx.getString("Observaciones");
                
                java.lang.String datos = "";
                datos = datos + "nombreOrigen = " + nombreOrigen + "\n";
                datos = datos + "codigoDeAutorizacion = " + codigoDeAutorizacion + "\n";
                datos = datos + "telefono = " + telefono + "\n";
                datos = datos + "denunciante = " + denunciante + "\n";
                datos = datos + "cobertura = " + cobertura + "\n";
                datos = datos + "tipoSrvInicial = " + tipoSrvInicial + "\n";
                datos = datos + "desperfecto = " + desperfecto + "\n";
                datos = datos + "ubicacion = " + ubicacion + "\n";
                datos = datos + "localidad = " + localidad + "\n";
                datos = datos + "destino = " + destino + "\n";
                datos = datos + "origengeo = " + origengeo + "\n";
                datos = datos + "destinogeo = " + destinogeo + "\n";
                datos = datos + "patente = " + patente + "\n";
                datos = datos + "titular = " + titular + "\n";
                datos = datos + "modelo = " + modelo + "\n";
                datos = datos + "color = " + color + "\n";
                datos = datos + "horaInicio = " + horaInicio + "\n";
                datos = datos + "operador = " + operador + "\n";
                datos = datos + "observaciones = " + observaciones + "\n";
                System.out.println(datos);
                

                
                java.lang.String result = port.agregarServicio(nombreOrigen, codigoDeAutorizacion, telefono, denunciante, cobertura, tipoSrvInicial, desperfecto, ubicacion, localidad, destino, origengeo, destinogeo, patente, titular, modelo, color, horaInicio, operador, observaciones);
                System.out.println("Result = " + result);

                if (result != null) {
                    UtileriasBDF.ejecutaSQLNP("st_WSActualizaDatosExp " + clExpediente + ",'" + result + "'");
                    return 0;
                } else {
                    UtileriasBDF.ejecutaSQLNP("st_WSActualizaDatosExpFail " + clExpediente + ",'" + "La respuesta fue NULL" + "'");
                    return 1;
                }
            } else {
                UtileriasBDF.ejecutaSQLNP("st_WSActualizaDatosExpFail " + clExpediente + ",'" + "No hubo RS" + "'");
                return 2;
            }

        } catch (Exception ex) {
            System.out.println("Error WS " + ex);
            UtileriasBDF.ejecutaSQLNP("st_WSActualizaDatosExpFail " + clExpediente + ",'" + "Excepcion " + ex + "'");
            return 3;
        }finally{
            UtileriasBDF.ejecutaSQLNP("st_WSValidaDatosExp " + clExpediente);
        }
    }

    private static String agregarServicio(java.lang.String nombreOrigen, java.lang.String codigoDeAutorizacion, java.lang.String telefono, java.lang.String denunciante, java.lang.String cobertura, java.lang.String tipoSrvInicial, java.lang.String desperfecto, java.lang.String ubicacion, java.lang.String localidad, java.lang.String destino, java.lang.String origengeo, java.lang.String destinogeo, java.lang.String patente, java.lang.String titular, java.lang.String modelo, java.lang.String color, java.lang.String horaInicio, java.lang.String operador, java.lang.String observaciones) {
        WSC.Application_Service service = new WSC.Application_Service();
        WSC.Application port = service.getApplication();
        return port.agregarServicio(nombreOrigen, codigoDeAutorizacion, telefono, denunciante, cobertura, tipoSrvInicial, desperfecto, ubicacion, localidad, destino, origengeo, destinogeo, patente, titular, modelo, color, horaInicio, operador, observaciones);
    }
}
