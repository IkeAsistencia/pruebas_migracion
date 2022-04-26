/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.geo.hogar;
import com.google.gson.Gson;
import ar.com.ike.util.rest.SimpleRESTCall;
import ar.com.ike.geo.hogar.api.to.Cita;
import java.io.IOException;

/**
 *
 * @author ddiez
 */
public class CancelaCita {

    public static void main(String[] args) throws IOException, Exception {
        CancelaCita cc = new CancelaCita();
        cc.Cancelar(350 , "28", "NU CANCELA CITA");
        /*
            String resultados = "{\"id\":350,\"direccion_geo\":{\"latitude\":-34.62056,\"longitude\":-58.44656},\"localidad\":\"00320\",\"subasta_desierta\":false,\"monitoreo\":{\"id\":345,\"usuario\":null,\"descripcion_motivo\":\"\",\"respuesta\":null,\"demora\":null,\"fecha_respuesta\":null},\"tecnico\":null,\"tiene_estado_final\":true,\"cancelada\":true,\"abandonada\":false,\"cerrada\":false,\"requiere_nueva_cita\":null,\"nueva_cita_coordinada\":false,\"descripcion_motivo_no_conformidad\":null,\"cancelaciones_tecnicos\":[],\"cancelaciones_coordinadores\":[],\"mensajes_cliente\":[],\"id_sise\":62485,\"clservicio\":3,\"clsubservicio\":218,\"codigo_proveedor\":14,\"codigos_proveedores_excluidos\":[],\"hora_desde\":\"18:00\",\"hora_hasta\":\"20:00\",\"short_id\":\"CVNieclq6ZnO\",\"nombre_cliente\":\"JUAN MANUEL VAZQUEZ\",\"email_cliente\":\"a@a.com\",\"telefono_cliente\":\"12345678\",\"dia\":\"2020-08-21\",\"descripcion_servicio\":\"COBERTURA: 2600.00, COBERTURA FINANCIERA: S., PROVINCIA: S/D, LOCALIDAD: , CALLE: , CP: 871, TIPO DOCUMENTO: DNI, DOCUMENTO: 27614177.\",\"direccion\":\"Espinosa 101-151\",\"urgente\":false,\"vip\":false,\"expediente\":2497421,\"subasta\":false,\"descripcion_motivo_cancelacion\":\"NU CANCELA CITA\",\"codigo_motivo_cancelacion\":\"28\",\"estado\":\"cancelada\",\"fecha_en_camino\":null,\"fecha_inicio_servicio\":null,\"fecha_finalizacion_servicio\":null,\"hora_estimada_llegada\":null,\"recordatorio_enviado\":false,\"creacion\":\"2020-08-20T16:50:59.918098-03:00\",\"prioridad\":1,\"conformidad_cliente\":null,\"quiero_que_me_contacten\":false,\"descripcion_no_conformidad\":\"\",\"requiere_otra_cita\":\"cita_no_finalizada\",\"dia_nueva_cita\":null,\"hora_desde_nueva_cita\":null,\"hora_hasta_nueva_cita\":null,\"trabajo_realizado\":\"\",\"mano_de_obra\":null,\"materiales\":null,\"viaticos\":null,\"otros\":null,\"cancelacion_cliente_consume_servicio\":false,\"foto_antes\":null,\"foto_despues\":null,\"firma_cliente\":null,\"motivo_no_conformidad\":null,\"nueva_cita\":null}";
            int p = resultados.indexOf("cancelada");
            System.out.println( resultados.substring(p+11, p+15));
        */
    }       
    
    public boolean Cancelar(int clCita, String codigo, String motivo) {
        MotivoCancelacionSISETO motivoSise = new MotivoCancelacionSISETO();
        motivoSise.codigo_motivo_cancelacion = codigo;
        motivoSise.descripcion_motivo_cancelacion = motivo;
        Config cfg = new Config();
        String url = cfg.getEndPoint() + String.valueOf(clCita) + "/cancelar/";
        SimpleRESTCall cli = new SimpleRESTCall();
        cli.addHeader("Authorization", "Api-Key " + cfg.getApiKey() );
        Gson gson = new Gson();
        String postString = gson.toJson(motivoSise);
        System.out.println("<!--");    
        System.out.println("url: " + url + "/n");
        System.out.println(postString);
        System.out.println("-->");
        try {
            String  citaResponse = cli.fetchJsonStringContent(url, "POST", postString);
            if ( citaResponse != null ) {
                //Si retorno un 200 es que cancelo correctamente.
                System.out.println(citaResponse);
                int i = citaResponse.indexOf("cancelada");
                if ( i > 0 ) {
                    return ( "true".equalsIgnoreCase( citaResponse.substring(i+11, i+15) ) );
                }
                else
                    return false;
            }
            else {
                return false;
            }
        }
        catch (IOException io) {
            System.out.println("CancelaCita.IOException.error:" + io.toString() );
            return false;
        }
        catch (Exception e){
            System.out.println("CancelaCita.Exception.error:" + e.toString() );
            return false;
        }
    }
}
