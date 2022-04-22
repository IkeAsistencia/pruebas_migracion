/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.geo.hogar.api;
import Utilerias.UtileriasBDF;
import ar.com.ike.geo.hogar.api.to.MsgMonitoreo;
import java.sql.ResultSet;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author ddiez
 */
@Path("/citas")
public class Monitoreo {

    @PUT 
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    @Path("/{clcita}/monitoreo/")
    public Response monitorear(@PathParam("clcita") int clCita, MsgMonitoreo monitoreo) {
        System.out.println("Monitoreo.clCita:" + String.valueOf(clCita));
        System.out.println("Monitoreo.respuesta:" + monitoreo.respuesta );
        
        int demora = 0;
        if (monitoreo.minutos_demora != null && monitoreo.minutos_demora > 0 ) {
            demora = monitoreo.minutos_demora;
        }
        try {
            String tmpMotCancelacion = (null != monitoreo.motivo_cancelacion && "NO".equalsIgnoreCase(monitoreo.respuesta)  ?monitoreo.motivo_cancelacion.nombre:"");
            System.out.println("Monitoreo.motivoCancelacion:" + tmpMotCancelacion  );
            ResultSet rs = UtileriasBDF.rsSQLNP( "st_insGeoHogarMonitoreo " + monitoreo.clcita  + ", " + monitoreo.cita + ", '" +monitoreo.respuesta + "', " + demora + ", '" + monitoreo.timestamp + "', '" + tmpMotCancelacion + "'");
            boolean bOk =  rs.next() && rs.getInt("resultado") == 1 ;
            String sObs = (rs.getString("Observacion")!=null?rs.getString("Observacion"):"Sin clCita");
            rs.close();
            if ( bOk ) {
                //Retornar OK-
                return Response.status(200).entity("OK:" + String.valueOf(clCita) ).build();
            }       
            else  {
                //analizar otros errores
                System.out.println("Monitoreo.warn:SIN clCita");
                return Response.status(400).entity("ERROR: NO EXISTE clCita").build();
            }
        }
        catch(Exception e) {
            System.out.println("Monitoreo.Error:" + e.toString() );
            return Response.status(400).entity("ERROR").build();
        }
    }
}