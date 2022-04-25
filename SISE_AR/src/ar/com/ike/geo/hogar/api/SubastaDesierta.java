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

@Path("/citas")
public class SubastaDesierta {
    @PUT
    @Path("/{clcita}/subasta_desierta/")
    public Response getSubastaDesierta(@PathParam("clcita") int clCita) {
        try {
            System.out.println("EndPoint:/{clCita}/subasta_desierta/ :" + String.valueOf(clCita));
            ResultSet rs = UtileriasBDF.rsSQLNP( "st_getDatosCitaPendienteGEO " + clCita );
            Integer clExpediente = new Integer(0);
            while ( rs.next() ) {
                clExpediente = rs.getInt("clExpediente");
                System.out.println("clExpediente :" + clExpediente );
            }
            rs.close();
            
            if ( clExpediente.intValue() != 0 ) {
                //Tengo un clExpediente valido
                String parms = clExpediente.toString() + ", " 
                                + "6, "      // @pclEstatus as int 6 -> SUBASTA DESIERTA.
                                + "null, "   // @pclMotivo as int = 0,            
                                + "'',"      // @pObservaciones as varchar(max),            
                                + ApplicationConfig.CL_USR_APP_AUTO +","    // @pclUsrApp as int,            (ID Asignador)
                                + "1897,"    // clProveedor -> Asignacion compulsa
                                + "null,"    // @pFechaReco varchar(10),
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
    }
       
}
