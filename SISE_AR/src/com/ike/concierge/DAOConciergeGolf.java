/*
 *
 *
 * Created on 27 de febrero de 2007, 09:48 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.concierge;
import com.ike.concierge.to.Conciergegolf;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOConciergeGolf extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeGolf() {
    }
    
    public Conciergegolf getCSGolf(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenGolf ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new conciergegolfFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergegolf) it.next() : null;
    }
    
    
    public class conciergegolfFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergegolf conciergegolf = new Conciergegolf();
            conciergegolf.setClGolf(rs.getString("clGolf"));
            conciergegolf.setClAsistencia(rs.getString("clAsistencia"));
            conciergegolf.setJugadores(rs.getString("Jugadores"));
            conciergegolf.setFecha(rs.getString("Fecha"));
            conciergegolf.setGreen(rs.getString("Green"));
            conciergegolf.setEquipo(rs.getString("Equipo"));
            conciergegolf.setDiestros(rs.getString("Diestros"));
            conciergegolf.setZurdos(rs.getString("Zurdos"));
            conciergegolf.setOtrosC(rs.getString("OtrosC"));
            conciergegolf.setCargoT(rs.getString("CargoT"));
            conciergegolf.setHotel(rs.getString("Hotel"));
            conciergegolf.setFechaI(rs.getString("FechaI"));
            conciergegolf.setReservacion(rs.getString("Reservacion"));
            conciergegolf.setFechaO(rs.getString("FechaO"));
            conciergegolf.setClTipoPago(rs.getString("clTipoPago"));
            conciergegolf.setNomBanco(rs.getString("NomBanco"));
            conciergegolf.setNombreTC(rs.getString("NombreTC"));
            conciergegolf.setNumeroTC(rs.getString("NumeroTC"));
            conciergegolf.setExpira2(rs.getString("Expira2"));
            conciergegolf.setSecC(rs.getString("SecC"));
            conciergegolf.setConfirmo(rs.getString("Confirmo"));
            conciergegolf.setNConfirmo(rs.getString("NConfirmo"));
            conciergegolf.setPCancel(rs.getString("PCancel"));
            conciergegolf.setNuInf(rs.getString("NuInf"));
            conciergegolf.setComentarios(rs.getString("Comentarios"));
            conciergegolf.setEstatus(rs.getString("Estatus"));
            conciergegolf.setDsEstatus(rs.getString("dsEstatus"));
            conciergegolf.setDsTipoPago(rs.getString("dsTipoPago"));
            conciergegolf.setExpira(rs.getString("Expira"));
            conciergegolf.setFechaRegistro(rs.getString("FechaRegistro"));
            return conciergegolf;
        }
    }
}
