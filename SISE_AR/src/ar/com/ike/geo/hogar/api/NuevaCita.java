/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.geo.hogar.api;
import Utilerias.UtileriasBDF;
import ar.com.ike.geo.hogar.api.to.CitaNueva;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.MediaType;


/**
 *
 * @author ddiez
 */
@Path("citas/")
public class NuevaCita {
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    @Path("nueva/")
    public Response nuevaCita(CitaNueva cita) {
        try {
            int iExpediente = cita.expediente;
            int iCita = cita.id_sise;               
            int geoCita = cita.id;
            String fecha = cita.dia;
            String hInicio = cita.hora_desde;
            String hFin = cita.hora_hasta;
            System.out.println("st_WSInsertaNuevaCita " + iExpediente + ", " + iCita + ", " + geoCita + ", '" + fecha + "', '" + hInicio + "', '" + hFin + "'" );
            ResultSet rs = UtileriasBDF.rsSQLNP( "st_WSInsertaNuevaCita " + iExpediente + ", " + iCita + ", " + geoCita + ", '" + fecha + "', '" + hInicio + "', '" + hFin + "'");
            if ( rs.next() ) {
                if (rs.getInt("resultado") == 1 ) {
                    cita.id_sise = rs.getInt("clCita");
                }
                else {
                    cita.id_sise = 0;
                }
                System.out.println("nuevaCita:" + String.valueOf(cita.id_sise) );
                rs.close();
                return Response.ok(cita, MediaType.APPLICATION_JSON).build();
            }       
            else  {
                //analizar otros errores
                System.out.println("GeoHogar.NuevaCita.warn:SIN clCita");
                return Response.status(Response.Status.NOT_FOUND).entity("CITA NO ENCONTRADA").build();
            }
        }
        catch(Exception e) {
            e.printStackTrace();
            System.out.println("GeoHogar.NuevaCita.Error:" + e.toString() );
            return Response.serverError().build();
        }
    }

    private static GregorianCalendar getDT( String strDate ) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSSSXXX");
        Date d = sdf.parse(strDate);
        GregorianCalendar dt = new GregorianCalendar();
        dt.setTimeInMillis(d.getTime());
        return dt;
    }
        
    public static void main(String[] args) throws ParseException  {
        System.out.println( getDT("2019-10-15T12:09:17.1234567-03:00").getTime() );
    }    
    
}

