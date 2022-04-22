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
public class Abandono {
    @PUT
    @Path("/{clcita}/abandono/")
    public Response putAbandono(@PathParam("clcita") int clCita) {
        
        //ABANDONO  
        //Timeout coordinador:
        //DELETE CitaXexpediente
        //Seguimiento cita Estatus 49 motivo 26
        //PvdXExpediente estatus 4
        //Seguimiento Pvd estatus 4
        
        System.out.println("EndPoint:/{clCita}/abandono/ :" + String.valueOf(clCita));
        try {
                ResultSet rs = UtileriasBDF.rsSQLNP( "st_GeoHogarAbandono " + clCita );
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

        /*
        //traigo las citas con estados pendientes de confirmacion
        Integer clExpediente = new Integer(0);
        Integer clProveedor = new Integer(0);
        Integer clEstatusCita = new Integer(0);
        try {
            ResultSet rs = UtileriasBDF.rsSQLNP( "st_getDatosCitaPendienteGEO " + clCita );
            while ( rs.next() ) {
                clExpediente = rs.getInt("clExpediente");
                //clProveedor deberia ser el de Pendiente de Asignacion Automatica
                clProveedor = rs.getInt("clProveedor");
                clEstatusCita = rs.getInt("clEstatusCita");
            }
            rs.close();
            if ( clExpediente.intValue() != 0 ) {
                //Tengo un clExpediente valido
                String parms = clExpediente.toString() + ", " 
                                + "5, "      // @pclEstatus as int 3 -> Abandonada.
                                + "null, "      // @pclMotivo as int = 0,            
                                + "'',"      // @pObservaciones as varchar(max),            
                                + ApplicationConfig.CL_USR_APP_AUTO + ","    // @pclUsrApp as int,            (ID Asignador)
                                + clProveedor.toString() + ","       // @pclProveedor as int = 0,
                                + "null,"      // @pFechaReco varchar(10),
                                + "null,"      // @pHoraReco varchar(5), 
                                + "1 ";      // ***** Tipo seguimiento 0 =NORMAL // tipo seguimiento 1=GeoHogar
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
                return Response.status(400).entity("Expediente No Existe:" + String.valueOf(clCita)  ).build();
            }
        }
        catch( Exception e) {
            System.out.println(e.toString());
            return Response.status(400).entity("Error:" + String.valueOf(clCita)  ).build();
        }
        */
    }
}
