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
import com.ike.concierge.to.ConciergeLocalidades;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOConciergeLocalidades extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeLocalidades() {
    }
    
    public ConciergeLocalidades getCSLocalidades(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenLocalidades ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new ConciergeventavipFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (ConciergeLocalidades) it.next() : null;
    }
    
    
    public class ConciergeventavipFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            ConciergeLocalidades conciergeLocalidades = new ConciergeLocalidades();
            conciergeLocalidades.setClLocalidades(rs.getString("clLocalidades"));
            conciergeLocalidades.setClAsistencia(rs.getString("clAsistencia"));
            conciergeLocalidades.setNadultos(rs.getString("Nadultos"));
            conciergeLocalidades.setNinos(rs.getString("Ninos"));
            conciergeLocalidades.setEdades(rs.getString("Edades"));
            conciergeLocalidades.setEvento(rs.getString("Evento"));
            conciergeLocalidades.setFechaE(rs.getString("FechaE"));
            conciergeLocalidades.setTeatro(rs.getString("Teatro"));
            conciergeLocalidades.setDireccion(rs.getString("Direccion"));
            conciergeLocalidades.setSeccion(rs.getString("Seccion"));
            conciergeLocalidades.setFila(rs.getString("Fila"));
            conciergeLocalidades.setHotel(rs.getString("Hotel"));
            conciergeLocalidades.setFechaI(rs.getString("FechaI"));
            conciergeLocalidades.setReservacion(rs.getString("Reservacion"));
            conciergeLocalidades.setFechaO(rs.getString("FechaO"));
            conciergeLocalidades.setFace(rs.getString("Face"));
            conciergeLocalidades.setSale(rs.getString("Sale"));
            conciergeLocalidades.setClTipoPago(rs.getString("clTipoPago"));
            conciergeLocalidades.setNomBanco(rs.getString("NomBanco"));
            conciergeLocalidades.setNombreTC(rs.getString("NombreTC"));
            conciergeLocalidades.setCargoT(rs.getString("CargoT"));
            conciergeLocalidades.setNumeroTC(rs.getString("NumeroTC"));
            conciergeLocalidades.setExpira2(rs.getString("Expira2"));
            conciergeLocalidades.setSecC(rs.getString("SecC"));
            conciergeLocalidades.setMetodo(rs.getString("Metodo")); 
            conciergeLocalidades.setConfirmo(rs.getString("Confirmo"));
            conciergeLocalidades.setNConfirmo(rs.getString("NConfirmo"));
            conciergeLocalidades.setPCancel(rs.getString("PCancel"));
            conciergeLocalidades.setNuInf(rs.getString("NuInf"));
            conciergeLocalidades.setComentarios(rs.getString("Comentarios"));
            conciergeLocalidades.setEstatus(rs.getString("Estatus"));
            conciergeLocalidades.setDsEstatus(rs.getString("dsEstatus"));
            conciergeLocalidades.setDsTipoPago(rs.getString("dsTipoPago"));
            conciergeLocalidades.setExpira(rs.getString("Expira"));
            conciergeLocalidades.setFechaRegistro(rs.getString("FechaRegistro"));

            return conciergeLocalidades;
        }
    }
}
