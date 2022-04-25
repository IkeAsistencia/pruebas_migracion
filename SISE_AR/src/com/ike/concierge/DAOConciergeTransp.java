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
import com.ike.concierge.to.Conciergetransp;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOConciergeTransp extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeTransp() {
    }
    
    public Conciergetransp getCSTransportacion(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenTransportacion ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new ConciergeventavipFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergetransp) it.next() : null;
    }
    
    
    public class ConciergeventavipFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergetransp conciergetransp = new Conciergetransp();
            conciergetransp.setClTransportacion(rs.getString("clTransportacion"));
            conciergetransp.setClAsistencia(rs.getString("clAsistencia"));
            conciergetransp.setNadultos(rs.getString("Nadultos"));
            conciergetransp.setNinos(rs.getString("Ninos"));
            conciergetransp.setEdades(rs.getString("Edades"));
            conciergetransp.setVehiculo(rs.getString("vehiculo"));
            conciergetransp.setEquipaje(rs.getString("Equipaje"));
            conciergetransp.setFechaC(rs.getString("FechaC"));
            conciergetransp.setOrigen(rs.getString("Origen"));
            conciergetransp.setDestino(rs.getString("Destino"));
            conciergetransp.setCostoH(rs.getString("CostoH"));
            conciergetransp.setHorasC(rs.getString("HorasC"));
            conciergetransp.setOtrosC(rs.getString("OtrosC"));
            conciergetransp.setEncuentro(rs.getString("Encuentro"));            
            conciergetransp.setCargoT(rs.getString("CargoT"));            
            conciergetransp.setHotel(rs.getString("Hotel"));
            conciergetransp.setFechaI(rs.getString("FechaI"));
            conciergetransp.setReservacion(rs.getString("Reservacion"));
            conciergetransp.setFechaO(rs.getString("FechaO"));
            conciergetransp.setClTipoPago(rs.getString("clTipoPago"));
            conciergetransp.setNomBanco(rs.getString("NomBanco"));
            conciergetransp.setNombreTC(rs.getString("NombreTC"));
            conciergetransp.setNumeroTC(rs.getString("NumeroTC"));
            conciergetransp.setExpira2(rs.getString("Expira2"));
            conciergetransp.setSecC(rs.getString("SecC"));
            conciergetransp.setConfirmo(rs.getString("Confirmo"));
            conciergetransp.setNConfirmo(rs.getString("NConfirmo"));
            conciergetransp.setPCancel(rs.getString("PCancel"));
            conciergetransp.setNuInf(rs.getString("NuInf"));
            conciergetransp.setComentarios(rs.getString("Comentarios"));
            conciergetransp.setEstatus(rs.getString("Estatus"));
            conciergetransp.setDsEstatus(rs.getString("dsEstatus"));
            conciergetransp.setDsTipoPago(rs.getString("dsTipoPago"));
            conciergetransp.setExpira(rs.getString("Expira"));
            conciergetransp.setFechaRegistro(rs.getString("FechaRegistro"));

            return conciergetransp;
        }
    }
}
