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
import com.ike.concierge.to.Conciergebar;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOConciergeBar extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeBar() {
    }
    
    public Conciergebar getCSBar(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenBar ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new ConciergebarFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergebar) it.next() : null;
    }
    
    
    public class ConciergebarFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergebar conciergebar = new Conciergebar();
            conciergebar.setClBar(rs.getString("clBar"));
            conciergebar.setClAsistencia(rs.getString("clAsistencia"));
            conciergebar.setAdultos(rs.getString("Adultos"));
            conciergebar.setDamas(rs.getString("Damas"));
            conciergebar.setCaballeros(rs.getString("Caballeros"));
            conciergebar.setFechaD(rs.getString("FechaD"));
            conciergebar.setFechaC(rs.getString("FechaC"));
            conciergebar.setOcasion(rs.getString("Ocasion"));
            conciergebar.setCover(rs.getString("Cover"));
            conciergebar.setHotel(rs.getString("Hotel"));
            conciergebar.setFechaI(rs.getString("FechaI"));
            conciergebar.setReservacion(rs.getString("Reservacion"));
            conciergebar.setFechaO(rs.getString("FechaO"));
            conciergebar.setClTipoPago(rs.getString("clTipoPago"));
            conciergebar.setNomBanco(rs.getString("NomBanco"));
            conciergebar.setNombreTC(rs.getString("NombreTC"));
            conciergebar.setNumeroTC(rs.getString("NumeroTC"));
            conciergebar.setExpira2(rs.getString("Expira2"));
            conciergebar.setSecC(rs.getString("SecC"));
            conciergebar.setConfirmo(rs.getString("Confirmo"));
            conciergebar.setNConfirmo(rs.getString("NConfirmo"));
            conciergebar.setPCancel(rs.getString("PCancel"));
            conciergebar.setNuInf(rs.getString("NuInf"));
            conciergebar.setTolerancia(rs.getString("Tolerancia"));
            conciergebar.setComentarios(rs.getString("Comentarios"));
            conciergebar.setEstatus(rs.getString("Estatus"));
            conciergebar.setDsEstatus(rs.getString("dsEstatus"));
            conciergebar.setDsTipoPago(rs.getString("dsTipoPago"));
            conciergebar.setExpira(rs.getString("Expira"));
            conciergebar.setFechaRegistro(rs.getString("FechaRegistro"));
            return conciergebar;
        }
    }
}
