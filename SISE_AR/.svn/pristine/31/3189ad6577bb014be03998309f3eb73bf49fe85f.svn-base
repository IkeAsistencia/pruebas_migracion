/*
 * DAOConciergeGolfProgram
 *
 * @author rfernandez
 */
package com.ike.concierge;
import com.ike.concierge.to.Conciergegolfprogram;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;


public class DAOConciergeGolfProgram extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeGolfProgram() {
    }
    
    public Conciergegolfprogram getCSGolf(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;                
        sb.append("st_CSGolfProgram ").append(StrclAsistencia);
        System.out.println(sb);        
        col = this.rsSQLNP(sb.toString(), new conciergegolfFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergegolfprogram) it.next() : null;
    }
        
    public class conciergegolfFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergegolfprogram golfprogram = new Conciergegolfprogram();
            
            golfprogram.setclGolfProgram(rs.getString("clGolfProgram"));
            golfprogram.setClAsistencia(rs.getString("clAsistencia"));
            golfprogram.setJugadores(rs.getString("Jugadores"));
            golfprogram.setFecha(rs.getString("Fecha"));
            golfprogram.setGreen(rs.getString("Green"));
            golfprogram.setEquipo(rs.getString("Equipo"));
            golfprogram.setDiestros(rs.getString("Diestros"));
            golfprogram.setZurdos(rs.getString("Zurdos"));
            golfprogram.setOtrosC(rs.getString("OtrosC"));
            golfprogram.setCargoT(rs.getString("CargoT"));
            golfprogram.setHotel(rs.getString("Hotel"));
            golfprogram.setFechaI(rs.getString("FechaI"));
            golfprogram.setReservacion(rs.getString("Reservacion"));
            golfprogram.setFechaO(rs.getString("FechaO"));  
            golfprogram.setClTipoPago(rs.getString("clTipoPago"));
            golfprogram.setdsTipoPago(rs.getString("dsTipoPago"));
            golfprogram.setNomBanco(rs.getString("NomBanco"));
            golfprogram.setNombreTC(rs.getString("NombreTC"));
            golfprogram.setNumeroTC(rs.getString("NumeroTC"));
            golfprogram.setExpira(rs.getString("Expira"));
            golfprogram.setSecC(rs.getString("SecC"));
            golfprogram.setConfirmo(rs.getString("Confirmo"));
            golfprogram.setNConfirmo(rs.getString("NConfirmo"));
            golfprogram.setPCancel(rs.getString("PCancel"));
            golfprogram.setNuInf(rs.getString("NuInf"));            
            golfprogram.setComentarios(rs.getString("Comentarios"));
            golfprogram.setEstatus(rs.getString("Estatus"));
            golfprogram.setDsEstatus(rs.getString("dsEstatus"));
            golfprogram.setFechaRegistro(rs.getString("FechaRegistro"));

            golfprogram.setHandicap(rs.getString("Handicap"));
            golfprogram.setAprobada(rs.getString("Aprobada"));
            golfprogram.setAprovacion(rs.getString("Aprovacion"));                 
           
            return golfprogram;
        }
    }
}
