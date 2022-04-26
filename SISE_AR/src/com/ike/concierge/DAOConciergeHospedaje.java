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
import com.ike.concierge.to.Conciergehospedaje;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOConciergeHospedaje extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeHospedaje() {
    }
    
    public Conciergehospedaje getCSHospedaje(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenHospedaje ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new ConciergehospedajeFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergehospedaje) it.next() : null;
    }
    
    
    public class ConciergehospedajeFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergehospedaje conciergehospedaje = new Conciergehospedaje();
            conciergehospedaje.setClHospedaje(rs.getString("clHospedaje"));
            conciergehospedaje.setClAsistencia(rs.getString("clAsistencia"));
            conciergehospedaje.setFechaE(rs.getString("FechaE"));
            conciergehospedaje.setFechaS(rs.getString("FechaS"));                        
            conciergehospedaje.setNombre(rs.getString("Nombre"));                        
            conciergehospedaje.setHotel(rs.getString("Hotel"));
            conciergehospedaje.setIncluye(rs.getString("Incluye"));
            //conciergehospedaje.setEdades(rs.getString("Edades"));
            conciergehospedaje.setHabitaciones(rs.getString("Habitaciones"));
            conciergehospedaje.setTipoHab(rs.getString("TipoHab"));
            conciergehospedaje.setCostoN(rs.getString("CostoN"));
            conciergehospedaje.setCargoT(rs.getString("CargoT"));
            conciergehospedaje.setAdicionales(rs.getString("Adicionales"));
            conciergehospedaje.setClTipoPago(rs.getString("clTipoPago"));
            conciergehospedaje.setNomBanco(rs.getString("NomBanco"));
            conciergehospedaje.setNombreTC(rs.getString("NombreTC"));
            conciergehospedaje.setNumeroTC(rs.getString("NumeroTC"));
            conciergehospedaje.setExpira2(rs.getString("Expira2"));
            conciergehospedaje.setSecC(rs.getString("SecC"));
            conciergehospedaje.setConfirmo(rs.getString("Confirmo"));
            conciergehospedaje.setNConfirmo(rs.getString("NConfirmo"));
            conciergehospedaje.setPCancel(rs.getString("PCancel"));
            conciergehospedaje.setNuInf(rs.getString("NuInf"));
            conciergehospedaje.setComentarios(rs.getString("Comentarios"));
            conciergehospedaje.setEstatus(rs.getString("Estatus"));
            conciergehospedaje.setDsEstatus(rs.getString("dsEstatus"));
            conciergehospedaje.setDsTipoPago(rs.getString("dsTipoPago"));
            conciergehospedaje.setExpira(rs.getString("Expira"));
            conciergehospedaje.setFechaRegistro(rs.getString("FechaRegistro"));
            return conciergehospedaje;
        }
    }
}
