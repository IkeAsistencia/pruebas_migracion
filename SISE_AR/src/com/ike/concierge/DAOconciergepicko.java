/*
 *
 *
 * Created on 21 de febrero de 2007, 09:48 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.concierge;
import com.ike.concierge.to.Conciergepicko;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOconciergepicko extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOconciergepicko() {
    }
    
    public Conciergepicko getCSPuO(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenPuO ").append(StrclAsistencia);
        col = this.rsSQLNP(sb.toString(), new conciergepickoFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergepicko) it.next() : null;
    }
    
    
    public class conciergepickoFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergepicko conciergepicko = new Conciergepicko();
            conciergepicko.setClPickUpO(rs.getString("clPickUpO"));
            conciergepicko.setClAsistencia(rs.getString("clAsistencia"));
            conciergepicko.setNadultos(rs.getString("Nadultos"));
            conciergepicko.setNinos(rs.getString("Ninos"));
            conciergepicko.setEdades(rs.getString("Edades"));
            conciergepicko.setVehiculo(rs.getString("Vehiculo"));
            conciergepicko.setEquipaje(rs.getString("Equipaje"));
            conciergepicko.setVuelo(rs.getString("Vuelo"));
            conciergepicko.setFecha(rs.getString("Fecha"));
            conciergepicko.setFechaA(rs.getString("FechaA"));
            conciergepicko.setOrigen(rs.getString("Origen"));
            conciergepicko.setCiudadA(rs.getString("CiudadA"));
            conciergepicko.setAeropuerto(rs.getString("Aeropuerto"));
            conciergepicko.setEncuentro(rs.getString("Encuentro"));
            conciergepicko.setCargoT(rs.getString("CargoT"));
            conciergepicko.setAdicionales(rs.getString("Adicionales"));
            conciergepicko.setServAds(rs.getString("ServAds"));
            conciergepicko.setDestino(rs.getString("Destino"));
            conciergepicko.setHotel(rs.getString("Hotel"));
            conciergepicko.setFechaI(rs.getString("FechaI"));
            conciergepicko.setReservacion(rs.getString("Reservacion"));
            conciergepicko.setFechaO(rs.getString("FechaO"));
            conciergepicko.setClTipoPago(rs.getString("clTipoPago"));
            conciergepicko.setNomBanco(rs.getString("NomBanco"));
            conciergepicko.setNombreTC(rs.getString("NombreTC"));
            conciergepicko.setNumeroTC(rs.getString("NumeroTC"));
            conciergepicko.setExpira2(rs.getString("Expira2"));
            conciergepicko.setSecC(rs.getString("SecC"));
            conciergepicko.setConfirmo(rs.getString("Confirmo"));
            conciergepicko.setNConfirmo(rs.getString("NConfirmo"));
            conciergepicko.setPCancel(rs.getString("PCancel"));
            conciergepicko.setNuInf(rs.getString("NuInf"));
            conciergepicko.setComentarios(rs.getString("Comentarios"));
            conciergepicko.setEstatus(rs.getString("Estatus"));
            conciergepicko.setDsEstatus(rs.getString("dsEstatus"));
            conciergepicko.setDsTipoPago(rs.getString("dsTipoPago"));
            conciergepicko.setExpira(rs.getString("Expira"));
            conciergepicko.setFechaRegistro(rs.getString("FechaRegistro"));
            return conciergepicko;
        }
    }
}
