/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.geo.hogar.api;

import Utilerias.UtileriasBDF;
import ar.com.ike.geo.hogar.api.to.MsgAlCliente;
import java.sql.ResultSet;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 *
 * @author ddiez
 */
@Path("/citas")

public class MensajeAlCliente {
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    @Path("/{clcita}/mensaje/")
    public Response mensaje(@PathParam("clcita") int clCita, MsgAlCliente msg) {
        System.out.println("EndPoint:/{clCita}/mensaje/ :" + String.valueOf(clCita));
        try {
            ResultSet rs = UtileriasBDF.rsSQLNP( "st_WSInsNuevoMsgAlCliente " + msg.id_sise + ", '" + msg.canal + "', '" + msg.mensaje + "', '" + msg.destino + "'");
            if ( rs.next() ) {
                if (rs.getBoolean("resultado")) {
                    return Response.status(200).entity("OK" ).build();
                }
                else {
                    return Response.status(400).entity("NO ENCONTRADO" ).build();
                }
            }
            else {
                return Response.status(400).entity("SIN REGISTRO"  ).build();
            }
        }
        catch( Exception e) {
            System.out.println(e.toString());
            return Response.status(400).entity("Error:" + String.valueOf(clCita)  ).build();
        }            
        
    }
}