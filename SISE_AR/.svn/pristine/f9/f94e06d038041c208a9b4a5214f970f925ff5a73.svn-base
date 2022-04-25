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
import com.ike.concierge.to.Conciergepickr;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOConciergepickr extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergepickr() {
    }
    
    public Conciergepickr getCSPuR(String StrclPickUpO) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenPuR ").append(StrclPickUpO);
        col = this.rsSQLNP(sb.toString(), new conciergepickrFiller());
        System.out.println(sb);
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergepickr) it.next() : null;
    }
    
    
    public class conciergepickrFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergepickr conciergepickr = new Conciergepickr();
            conciergepickr.setClPickUpR(rs.getString("clPickUpR"));
            conciergepickr.setClPickUpO(rs.getString("clPickUpO"));
            conciergepickr.setNadultos(rs.getString("Nadultos"));
            conciergepickr.setNinos(rs.getString("Ninos"));
            conciergepickr.setEdades(rs.getString("Edades"));
            conciergepickr.setVehiculo(rs.getString("Vehiculo"));
            conciergepickr.setEquipaje(rs.getString("Equipaje"));
            conciergepickr.setVuelo(rs.getString("Vuelo"));
            conciergepickr.setFecha(rs.getString("Fecha"));
            conciergepickr.setHoraS(rs.getString("HoraS"));
            conciergepickr.setDestino(rs.getString("Destino"));            
            conciergepickr.setCiudadS(rs.getString("CiudadS"));
            conciergepickr.setAeropuerto(rs.getString("Aeropuerto"));
            conciergepickr.setEncuentro(rs.getString("Encuentro"));
            conciergepickr.setHorario(rs.getString("Horario"));
            conciergepickr.setAdicionales(rs.getString("Adicionales"));
            conciergepickr.setCargoT(rs.getString("CargoT"));
            conciergepickr.setDestino2(rs.getString("Destino2"));
            conciergepickr.setConfirmo(rs.getString("Confirmo"));
            conciergepickr.setNConfirmo(rs.getString("NConfirmo"));
            conciergepickr.setPCancel(rs.getString("PCancel"));
            conciergepickr.setNuInf(rs.getString("NuInf"));
            conciergepickr.setComentarios(rs.getString("Comentarios"));
            conciergepickr.setRoundTrip(rs.getString("RoundTrip"));
            conciergepickr.setFechaRegistro(rs.getString("FechaRegistro"));
            
            return conciergepickr;
        }
    }
}
