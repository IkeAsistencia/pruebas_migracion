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
import ar.com.ike.geo.hogar.api.to.Aceptacion;

@Path("/citas")
public class Aceptar {
    @PUT
    @Path("/{clcita}/aceptar/")
    public Response getAceptar(@PathParam("clcita") int clCita, Aceptacion aceptaCita) {
        System.out.println("EndPoint:/{clCita}/Aceptar/ :" + String.valueOf(clCita));
        //traigo las citas con estados pendientes de confirmacion
        Integer clExpediente = new Integer(0);
        Integer clProveedor = new Integer(0);
        Integer clEstatusCita = new Integer(0);
        try {
            ResultSet rs = UtileriasBDF.rsSQLNP( "st_getDatosCitaPendienteGEO " + clCita );
            while ( rs.next() ) {
                clExpediente = rs.getInt("clExpediente");
                clProveedor = rs.getInt("clProveedor");
                clEstatusCita = rs.getInt("clEstatusCita");
                System.out.println("clExpediente :" + clExpediente );
                System.out.println("clProveedor  :" + clProveedor);
                System.out.println("clEstatusCita:" + clEstatusCita);
            }
            rs.close();
            //FIXME: VALIDAR  SIEMPRE EL PVD ES TOMADO DEL LLAMADO
            clProveedor = aceptaCita.codigo_proveedor;
            if (clEstatusCita == 77 ) {
                //Es asignacion automatica, se toma el Prestador desde el servicio.
                clProveedor = aceptaCita.codigo_proveedor;
                System.out.println("Asignacion AUTOMATICA: Gano PVD:" + clProveedor);
            }
            
            if ( clExpediente.intValue() != 0 ) {
                //Tengo un clExpediente valido
                String parms = clExpediente.toString() + ", " 
                                + "3, "                             // @pclEstatus as int 3 -> Aceptada.
                                + clEstatusCita.toString() + ", "   // @pclMotivo as int = 0,            
                                + "'',"                             // @pObservaciones as varchar(max),            
                                + ApplicationConfig.CL_USR_APP_AUTO + ","                           // @pclUsrApp as int,            (ID Asignador)
                                + clProveedor.toString() + ","      // @pclProveedor as int = 0,
                                + "'',"                             // @pFechaReco varchar(10),
                                + "'',"                             // @pHoraReco varchar(5), 
                                + "1 ";                             // Tipo seguimiento 0 =NORMAL // tipo seguimiento 1=GeoHogar
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
            return Response.status(200).entity("Error:" + String.valueOf(clCita)  ).build();
        }
        
    }
}
