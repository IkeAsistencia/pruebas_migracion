/*
 *
 *
 * Created on 08 de Marzo de 2007, 13:22 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.concierge;
import com.ike.concierge.to.Conciergespa;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOConciergeSpa extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeSpa() {
    }
    
    public Conciergespa getCSSpa(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenSpa ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new ConciergespaFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergespa) it.next() : null;
    }
    
    
    public class ConciergespaFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergespa conciergespa = new Conciergespa();
            conciergespa.setClSpa(rs.getString("clSpa"));
            conciergespa.setClAsistencia(rs.getString("clAsistencia"));
            conciergespa.setTipoServicio(rs.getString("TipoServicio"));
            conciergespa.setFechaD(rs.getString("FechaD"));
          //conciergespa.setFechaC(rs.getString("FechaC"));
            conciergespa.setNombre(rs.getString("Nombre"));
          //conciergespa.setHombre(rs.getString("Hombre"));
          //conciergespa.setMujer(rs.getString("Mujer"));
          //conciergespa.setIndistinto(rs.getString("Indistinto"));
            conciergespa.setDuracion(rs.getString("Duracion"));            
            conciergespa.setCargoT(rs.getString("CargoT"));            
          //conciergespa.setHotel(rs.getString("Hotel"));
          //conciergespa.setFechaI(rs.getString("FechaI"));
          //conciergespa.setReservacion(rs.getString("Reservacion"));
          //conciergespa.setFechaO(rs.getString("FechaO"));
            conciergespa.setClTipoPago(rs.getString("clTipoPago"));
            conciergespa.setNomBanco(rs.getString("NomBanco"));
            conciergespa.setNombreTC(rs.getString("NombreTC"));
            conciergespa.setNumeroTC(rs.getString("NumeroTC"));
            conciergespa.setExpira2(rs.getString("Expira2"));
            conciergespa.setSecC(rs.getString("SecC"));
            conciergespa.setConfirmo(rs.getString("Confirmo"));
            conciergespa.setNConfirmo(rs.getString("NConfirmo"));
            conciergespa.setPCancel(rs.getString("PCancel"));
            conciergespa.setNuInf(rs.getString("NuInf"));
            conciergespa.setComentarios(rs.getString("Comentarios"));
            conciergespa.setEstatus(rs.getString("Estatus"));
            conciergespa.setDsEstatus(rs.getString("dsEstatus"));
            conciergespa.setDsTipoPago(rs.getString("dsTipoPago"));
            conciergespa.setExpira(rs.getString("Expira"));
            conciergespa.setMasajista(rs.getString("Masajista"));
            conciergespa.setDesTratamiento(rs.getString("DesTratamiento"));
            conciergespa.setFechaRegistro(rs.getString("FechaRegistro"));
            return conciergespa;
        }
    }
}
