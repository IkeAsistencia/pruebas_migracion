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
import com.ike.concierge.to.Conciergerentayate;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOConciergeRentayate extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeRentayate() {
    }
    
    public Conciergerentayate getCSRentaYate(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenRentayate ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new ConciergeyateFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergerentayate) it.next() : null;
    }
    
    
    public class ConciergeyateFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergerentayate conciergerentayate = new Conciergerentayate();
            conciergerentayate.setClYate(rs.getString("clYate"));
            conciergerentayate.setClAsistencia(rs.getString("clAsistencia"));
            conciergerentayate.setEmbarcacion(rs.getString("Embarcacion"));
            conciergerentayate.setPasajeros(rs.getString("Pasajeros"));
            conciergerentayate.setUbicacion(rs.getString("Ubicacion"));
            conciergerentayate.setCamarotes(rs.getString("Camarotes"));                 
            conciergerentayate.setCiudad(rs.getString("Ciudad"));
            conciergerentayate.setEstado(rs.getString("Estado"));
            conciergerentayate.setPais(rs.getString("Pais"));
            conciergerentayate.setFechaS(rs.getString("FechaS"));
            conciergerentayate.setFechaR(rs.getString("FechaR"));
            conciergerentayate.setCostoH(rs.getString("CostoH"));
            conciergerentayate.setHorasP(rs.getString("HorasP"));
            conciergerentayate.setCargoT(rs.getString("CargoT"));
            conciergerentayate.setHotel(rs.getString("Hotel"));
            conciergerentayate.setFechaI(rs.getString("FechaI"));
            conciergerentayate.setReservacion(rs.getString("Reservacion"));
            conciergerentayate.setFechaO(rs.getString("FechaO"));
            conciergerentayate.setClTipoPago(rs.getString("clTipoPago"));
            conciergerentayate.setNomBanco(rs.getString("NomBanco"));
            conciergerentayate.setNombreTC(rs.getString("NombreTC"));
            conciergerentayate.setNumeroTC(rs.getString("NumeroTC"));
            conciergerentayate.setExpira2(rs.getString("Expira2"));
            conciergerentayate.setSecC(rs.getString("SecC"));
            conciergerentayate.setConfirmo(rs.getString("Confirmo"));
            conciergerentayate.setNConfirmo(rs.getString("NConfirmo"));
            conciergerentayate.setPCancel(rs.getString("PCancel"));
            conciergerentayate.setNuInf(rs.getString("NuInf"));
            conciergerentayate.setComentarios(rs.getString("Comentarios"));
            conciergerentayate.setEstatus(rs.getString("Estatus"));
            conciergerentayate.setDsEstatus(rs.getString("dsEstatus"));
            conciergerentayate.setDsTipoPago(rs.getString("dsTipoPago"));
            conciergerentayate.setExpira(rs.getString("Expira"));
            conciergerentayate.setFechaRegistro(rs.getString("FechaRegistro"));

            return conciergerentayate;
        }
    }
}
