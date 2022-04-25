/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WS;

import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import java.sql.ResultSet;
import Utilerias.UtileriasBDF;

/**
 *
 * @author mramirez
 */
@WebService(serviceName = "WSSISEAR")
public class WSSISEAR {

    String StrRespuesta = "";
    String StrRespuestaM = "";

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "di_hola")
    public String hello(@WebParam(name = "name") String txt) {
        return "Hola " + txt + " !";
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "envia_seguimiento")
    public String envia_seguimiento(@WebParam(name = "idServicio") final String idServicio, @WebParam(name = "FechaHora") final String FechaHora, @WebParam(name = "idPrestador") final String idPrestador, @WebParam(name = "Observaciones") String Observaciones, @WebParam(name = "Estado") String Estado, @WebParam(name = "Aceptado") String Aceptado, @WebParam(name = "DemoraPrometida") String DemoraPrometida, @WebParam(name = "NUContactado") String NUContactado) {
        try {
            ResultSet rsSeguimiento = UtileriasBDF.rsSQLNP("st_WSRegistraSeguimiento '" + idServicio + "','" + FechaHora + "','" + idPrestador + "','" + Observaciones + "','" + Estado + "','" + Aceptado + "','" + DemoraPrometida + "','" + NUContactado + "'");

            if (rsSeguimiento.next()) {
                StrRespuesta = rsSeguimiento.getString("Respuesta");
            } else {
                StrRespuesta = "Error";
            }
        } catch (Exception ex) {
            System.out.println("Error:          " + ex);
        }
        return StrRespuesta;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "envia_monitoreo")
    public String envia_monitoreo(@WebParam(name = "idServicio") final String idServicio, @WebParam(name = "FechaHora") final String FechaHora, @WebParam(name = "idPrestador") final String idPrestador, @WebParam(name = "Observaciones") String Observaciones, @WebParam(name = "Estado") String Estado, @WebParam(name = "Aceptado") String Aceptado, @WebParam(name = "DemoraPrometida") String DemoraPrometida, @WebParam(name = "NUContactado") String NUContactado) {
        try {
            ResultSet rsMonitoreo = UtileriasBDF.rsSQLNP("st_WSRegistraMonitoreo '" + idServicio + "','" + FechaHora + "','" + idPrestador + "','" + Observaciones + "','" + Estado + "','" + Aceptado + "','" + DemoraPrometida + "','" + NUContactado + "'");

            if (rsMonitoreo.next()) {
                StrRespuestaM = rsMonitoreo.getString("Respuesta");
            } else {
                StrRespuestaM = "Error";
            }
        } catch (Exception ex) {
            System.out.println("Error:          " + ex);
        }
        return StrRespuestaM;
    }
}