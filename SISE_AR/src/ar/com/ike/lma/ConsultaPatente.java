    /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.client.lma;

import ar.com.ike.util.rest.SimpleRESTCall;

/**
 *
 * @author ddiez
 */
public class ConsultaPatente {
    private String URL = "https://servicios.qamercantilandina.com.ar:444/api_emision/v2/asistencias/patentes/";
    private String token = null;
            
    public static void main(String[] args ) throws Exception {
        ConsultaPatente cp = new ConsultaPatente();
        try {
            ServConsultaPatenteResponse CPresp = cp.getDatos("JZF940");
            if ( CPresp != null ) {
                System.out.println("Poliza: " +  CPresp.poliza);
                System.out.println("NU: " + CPresp.nombre);
                System.out.println("Razon Social: " + CPresp.razonSocial);
                System.out.println("Direccion: " + CPresp.direccion);
                System.out.println("Marca: " + CPresp.marca);
                System.out.println("Codigo Producto: " + CPresp.codigoProducto);
            }
            else {
                System.out.println("NO EXISTE USUARIO, NO BRINDAR SERVICIO");
            }
        }
        catch (PatenteSinPolizaException sinPoliza) {
            System.out.println("PATENTE SIN POLIZA!");
        }
    }
    
    public ConsultaPatente() {
        Autenticacion auth = Autenticacion.Autenticacion();
        System.out.println(auth.getAuthToken() );
        this.token = auth.getAuthToken();
        //this.token = "kzdRnahYyRRDCJhUthOE4rPwXZbPf6hvGi6ktv7Q4A7d4NI4jnbwQVByPki5NzYI";
    }

    public ServConsultaPatenteResponse getDatos(String patente ) throws PatenteSinPolizaException, Exception { 
        SimpleRESTCall src = new SimpleRESTCall();
        if ( token != null && !"".equals(token) ) {
            src.addHeader("Authorization", "Bearer " + this.token );
            String finalUrl = this.URL + patente;
            System.out.println("Consultando: " + finalUrl);
            SimpleRESTCall.Resultado res = src.getGsonHttpsUrl(finalUrl, "GET", ServConsultaPatenteResponse.class);
            if (res.getCodigo() == 200 || res.getCodigo() == 201 ) {
                ServConsultaPatenteResponse str = (ServConsultaPatenteResponse) res.getContenido();
                return str;
            }
            else {
                if (res.getCodigo() == 400) {
                    //La patente no corresponde a una poliza activa.
                    throw new PatenteSinPolizaException("Patente No Encontrada");
                }
                else {
                    //Alguna otra clase de error.
                    throw new Exception("Error" + res.getCodigo() );
                }
            }
        }
        else {
            System.out.println("ERROR");
            return null;
        }
       
    }
}
