     /*
 *
 *
 * Created on 23 de febrero de 2007, 11:02 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.concierge;
import com.ike.concierge.to.Conciergeequipaje;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOConciergeEquipaje extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeEquipaje() {
    }
    
    public Conciergeequipaje getCSEquipaje(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenEquipaje ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new ConciergeequipajeFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergeequipaje) it.next() : null;
    }
    
    
    public class ConciergeequipajeFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergeequipaje conciergeequipaje = new Conciergeequipaje();
            conciergeequipaje.setClEquipaje(rs.getString("clEquipaje"));
            conciergeequipaje.setClAsistencia(rs.getString("clAsistencia"));
            conciergeequipaje.setVuelo(rs.getString("Vuelo"));
            conciergeequipaje.setMaletas(rs.getString("Maletas"));
            conciergeequipaje.setCiudadO(rs.getString("CiudadO"));
            conciergeequipaje.setCiudadD(rs.getString("CiudadD"));
            conciergeequipaje.setAptoO(rs.getString("AptoO"));
            conciergeequipaje.setAptoD(rs.getString("AptoD"));
            conciergeequipaje.setFechaS(rs.getString("FechaS"));
            conciergeequipaje.setFechaA(rs.getString("FechaA"));
            conciergeequipaje.setConexion(rs.getString("Conexion"));
            conciergeequipaje.setReclamo(rs.getString("Reclamo"));
            conciergeequipaje.setHotel(rs.getString("Hotel"));
            conciergeequipaje.setFechaI(rs.getString("FechaI"));
            conciergeequipaje.setReservacion(rs.getString("Reservacion"));
            conciergeequipaje.setFechaO(rs.getString("FechaO"));
            conciergeequipaje.setFechrecupera(rs.getString("Fechrecupera"));
            conciergeequipaje.setFechentrega(rs.getString("Fechentrega"));
            conciergeequipaje.setDireccionE(rs.getString("DireccionE"));
            conciergeequipaje.setComentarios(rs.getString("Comentarios"));
            conciergeequipaje.setEstatus(rs.getString("Estatus"));
            conciergeequipaje.setDsEstatus(rs.getString("dsEstatus"));
            conciergeequipaje.setFechaRegistro(rs.getString("FechaRegistro"));

            return conciergeequipaje;
        }
    }
}
