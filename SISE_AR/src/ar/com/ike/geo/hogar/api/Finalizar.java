/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.geo.hogar.api;
import Utilerias.UtileriasBDF;
import java.sql.ResultSet;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.MediaType;

@Path("/citas")
public class Finalizar {

    @PUT 
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    @Path("/{clcita}/cita_finalizada/")
    public Response cancelar(@PathParam("clcita") int clCita ) {
        System.out.println("EndPoint:/{clCita}/cita_finalizada/ :" + String.valueOf(clCita));
        try {
            ResultSet rs = UtileriasBDF.rsSQLNP( "st_FinalizarCitaGeoHogar " + clCita );
            if ( rs.next() ) {
                if (rs.getBoolean("resultado")) {
                        return Response.status(200).entity("OK").build();
                    }
                    else {
                        return Response.status(200).entity("NO OK").build();
                    }
            }
            else {
                return Response.status(200).entity("OTRO ERROR" ).build();
            }
        }
        catch( Exception e) {
            System.out.println(e.toString());
            return Response.status(200).entity("Error:" + String.valueOf(clCita)  ).build();
        }            
    }
}