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
 * @author ddiez
 */
@Path("/citas")
public class RequiereNuevaCita {
    @PUT 
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    @Path("/{clcita}/requiere_nueva_cita/")
    public Response requiereNuevaCita(@PathParam("clcita") int clCita) {
        System.out.println("requiereNuevaCita:clCita:" + String.valueOf(clCita));
        try {
            ResultSet rs = UtileriasBDF.rsSQLNP( "st_WSInsertaRecordatorioNvaCita " + clCita );
            boolean bOk =  rs.next() && rs.getInt("resultado") == 1 ;
            rs.close();
            if ( bOk ) {
                //Retornar OK-
                return Response.status(200).entity("OK:" + String.valueOf(clCita) ).build();
            }       
            else  {
                //analizar otros errores
                System.out.println("RequiereNuevaCita.warn:SIN clCita");
                return Response.notModified().build();
            }
        }
        catch(Exception e) {
            System.out.println("RequiereNuevaCita.Error:" + e.toString() );
            return Response.serverError().build();
        }
    }
    
}
