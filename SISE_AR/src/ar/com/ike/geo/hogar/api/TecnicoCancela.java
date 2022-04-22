/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.geo.hogar.api;
import Utilerias.UtileriasBDF;
import ar.com.ike.geo.hogar.api.to.Cancelacion;
import java.sql.ResultSet;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.MediaType;

@Path("/citas")
public class TecnicoCancela {

    @PUT 
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    @Path("/{clcita}/tecnico_cancela/")
    public Response tecnicoCancela(@PathParam("clcita") int clCita) {
        System.out.println("EndPoint:/{clCita}/tecnico_cancela/ :" + String.valueOf(clCita));
        //TODO: EVALUAR SI SE REGISTRA ALGO EN LA DB
        return Response.status(200).entity("OK: " + String.valueOf(clCita)  ).build();

        /* YA ES SOLAMENTE ANECDOTICO
        try {
            ResultSet rs = UtileriasBDF.rsSQLNP( "st_getDatosCitaPendienteGEO " + clCita );
            while ( rs.next() ) {
                clExpediente = rs.getInt("clExpediente");
                clProveedor = rs.getInt("clProveedor");
                clEstatusCita = rs.getInt("clEstatusCita");
            }
            rs.close();
            if ( clExpediente.intValue() != 0 ) {
                //Tengo un clExpediente valido
                String parms = clExpediente.toString() + ", " 
                                + "4, "      // @pclEstatus as int 4 -> Cancelar.
                                + "0, "      // @pclMotivo as int = 0,            
                                + "'Técnico Cancela - Cancelacion de PVD ',"      // @pObservaciones as varchar(max),            
                                + ApplicationConfig.CL_USR_APP_AUTO + ","    // @pclUsrApp as int,            (ID Asignador)
                                + clProveedor.toString() + ","       // @pclProveedor as int = 0,
                                + "'',"      // @pFechaReco varchar(10),
                                + "'',"      // @pHoraReco varchar(5), 
                                + "1 ";      // Tipo seguimiento 0 =NORMAL // tipo seguimiento 1=GeoHogar
                ResultSet rs1 = UtileriasBDF.rsSQLNP( "sp_GuardaSeguimiento " + parms );
                if ( rs1.next() ) {
                    if (rs1.getBoolean("resultado")) {
                        return Response.status(200).entity("OK: " + String.valueOf(clCita)  ).build();
                    }
                    else {
                        return Response.status(200).entity("NO OK: " + String.valueOf(clCita)  ).build();
                    }
                }
                else {
                    return Response.status(200).entity("Sin Registro: " + String.valueOf(clCita)  ).build();
                }
            }
            else {
                //La cita no tiene un expediente valido.
                return Response.status(200).entity("Expediente No Existe:" + String.valueOf(clCita)  ).build();
            }
        }
        catch( Exception e) {
            System.out.println(e.toString());
            return Response.status(400).entity("Error:" + String.valueOf(clCita)  ).build();
        }            
        */
    }
}