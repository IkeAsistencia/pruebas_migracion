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
import com.ike.concierge.to.Conciergerentajet;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOConciergeRentajet extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeRentajet() {
    }
    
    public Conciergerentajet getCSRentaJet(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenRentajet ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new ConciergeRentajetFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergerentajet) it.next() : null;
    }
    
    
    public class ConciergeRentajetFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergerentajet conciergerentajet = new Conciergerentajet();
            conciergerentajet.setClRentajet(rs.getString("clRentajet"));
            conciergerentajet.setClAsistencia(rs.getString("clAsistencia"));
            conciergerentajet.setAeronave(rs.getString("Aeronave"));
            conciergerentajet.setPasajeros(rs.getString("Pasajeros"));
            conciergerentajet.setOrigen(rs.getString("Origen"));
            conciergerentajet.setDestino(rs.getString("Destino"));
            conciergerentajet.setFechaS(rs.getString("FechaS"));
            conciergerentajet.setCostoH(rs.getString("CostoH"));
            conciergerentajet.setHorasP(rs.getString("HorasP"));
            conciergerentajet.setCargoT(rs.getString("CargoT"));
            conciergerentajet.setHotel(rs.getString("Hotel"));
            conciergerentajet.setFechaI(rs.getString("FechaI"));
            conciergerentajet.setReservacion(rs.getString("Reservacion"));
            conciergerentajet.setFechaO(rs.getString("FechaO"));
            conciergerentajet.setClTipoPago(rs.getString("clTipoPago"));
            conciergerentajet.setNomBanco(rs.getString("NomBanco"));
            conciergerentajet.setNombreTC(rs.getString("NombreTC"));
            conciergerentajet.setNumeroTC(rs.getString("NumeroTC"));
            conciergerentajet.setExpira2(rs.getString("Expira2"));
            conciergerentajet.setSecC(rs.getString("SecC"));
            conciergerentajet.setConfirmo(rs.getString("Confirmo"));
            conciergerentajet.setNConfirmo(rs.getString("NConfirmo"));
            conciergerentajet.setPCancel(rs.getString("PCancel"));
            conciergerentajet.setNuInf(rs.getString("NuInf"));
            conciergerentajet.setComentarios(rs.getString("Comentarios"));
            conciergerentajet.setEstatus(rs.getString("Estatus"));
            conciergerentajet.setDsEstatus(rs.getString("dsEstatus"));
            conciergerentajet.setDsTipoPago(rs.getString("dsTipoPago"));
            conciergerentajet.setExpira(rs.getString("Expira"));
            conciergerentajet.setFechaRegistro(rs.getString("FechaRegistro"));

            return conciergerentajet;
        }
    }
}
