/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.geo.hogar.api;

import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Response;
import java.sql.ResultSet;
import Utilerias.UtileriasBDF;

/* NOTA: Abandono es cuando se pasa el tiempo de monitoreo y no tenemos nignun feedback */

@Path("/citas")
public class IniciaTarea {
    @PUT
    @Path("/{clcita}/inicia_tarea/")
    public Response putAbandono(@PathParam("clcita") int clCita) {
        System.out.println("clCita:" + String.valueOf(clCita));
        int demora = 0;
        try {
            //TODO:
            //motivo_cancelacion.nombre enviar a monitoreo cuando respuesta es NO 
            //agregar campo apara agregar ese campo
            ResultSet rs = UtileriasBDF.rsSQLNP( "st_insGeoHogarMonitoreo " + String.valueOf(clCita)  + ", 0, 'INICIO_TAREA', " + demora + ", '' ");
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
