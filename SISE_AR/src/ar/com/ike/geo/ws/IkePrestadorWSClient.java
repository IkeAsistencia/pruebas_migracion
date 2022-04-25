/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.geo.ws;

import ar.com.ike.geo.ws.tns.Application;
import ar.com.ike.geo.ws.tns.Application_Service;
import java.util.ArrayList;
import java.util.List;

public class IkePrestadorWSClient {

    public static void main(String[] args) throws Exception {
        Application_Service sis = new Application_Service();
        Application app = sis.getApplication();
        List<String> localidades = new ArrayList();
        localidades.add("Moreno");        localidades.add("Paso del Rey");        localidades.add("Merlo");
        List<String> servicios = new ArrayList();
        servicios.add("Movida");        servicios.add("UAT");        servicios.add("Cerrajeria");
        List<String> subservicios = new ArrayList();
        subservicios.add("Acarreo");        subservicios.add("Cruce de bateria");        subservicios.add("Destrabacion");
        List<String> idsLocalidades = new ArrayList();
        idsLocalidades.add("-34234234");        idsLocalidades.add("-342345");        idsLocalidades.add("-3423472");
        List<String> prioridades = new ArrayList();
        prioridades.add("1");        prioridades.add("1");        prioridades.add("2");
        for (int i = 0; i < 100; i++) {
            String ikePrestador = app.ikePrestador(Integer.toString(i), "pepe", "Pepe S.A.", "Don Pepe", "20-24588999-2",
                    "1", "Argentina", "Buenos Aires", "Moreno", "Juan XXIII 121", "12.343434; -32.3434334" , "LaV 08-21", "donpepe@gruas.com.ar",
                    "1154885544", "1", "2", "A","B", localidades, subservicios, idsLocalidades, prioridades);

            System.out.println(Integer.toString(i) + "Alta Prestador: " + ikePrestador);
        }
        String proces = app.ikePrestadorProcess();
        System.out.println( "Process: " + proces );
   }

}