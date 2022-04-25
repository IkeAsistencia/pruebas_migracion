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
import com.ike.concierge.to.Conciergelocaltaquilla;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOConciergeLocaltaquilla extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeLocaltaquilla() {
    }
    
    public Conciergelocaltaquilla getCSLocalidadesTaquilla(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenLocalidadesTaquilla ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new ConciergeventavipFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergelocaltaquilla) it.next() : null;
    }
    
    
    public class ConciergeventavipFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergelocaltaquilla conciergelocaltaquilla = new Conciergelocaltaquilla();
            conciergelocaltaquilla.setClLocalidades(rs.getString("clLocaltaquilla"));
            conciergelocaltaquilla.setClAsistencia(rs.getString("clAsistencia"));
            conciergelocaltaquilla.setNadultos(rs.getString("Nadultos"));
            conciergelocaltaquilla.setNinos(rs.getString("Ninos"));
            conciergelocaltaquilla.setEdades(rs.getString("Edades"));
            conciergelocaltaquilla.setEvento(rs.getString("Evento"));
            conciergelocaltaquilla.setFechaE(rs.getString("FechaE"));
            conciergelocaltaquilla.setTeatro(rs.getString("Teatro"));
            conciergelocaltaquilla.setDireccion(rs.getString("Direccion"));
            conciergelocaltaquilla.setSeccion(rs.getString("Seccion"));
            conciergelocaltaquilla.setFila(rs.getString("Fila"));
            conciergelocaltaquilla.setHotel(rs.getString("Hotel"));
            conciergelocaltaquilla.setFechaI(rs.getString("FechaI"));
            conciergelocaltaquilla.setReservacion(rs.getString("Reservacion"));
            conciergelocaltaquilla.setFechaO(rs.getString("FechaO"));
            conciergelocaltaquilla.setClTipoPago(rs.getString("clTipoPago"));
            conciergelocaltaquilla.setNomBanco(rs.getString("NomBanco"));
            conciergelocaltaquilla.setNombreTC(rs.getString("NombreTC"));
            conciergelocaltaquilla.setCargoT(rs.getString("CargoT"));
            conciergelocaltaquilla.setNumeroTC(rs.getString("NumeroTC"));
            conciergelocaltaquilla.setExpira2(rs.getString("Expira2"));
            conciergelocaltaquilla.setSecC(rs.getString("SecC"));
            conciergelocaltaquilla.setMetodo(rs.getString("Metodo"));
            conciergelocaltaquilla.setAutoriza(rs.getString("Autoriza"));
            conciergelocaltaquilla.setConfirmo(rs.getString("Confirmo"));
            conciergelocaltaquilla.setNConfirmo(rs.getString("NConfirmo"));
            conciergelocaltaquilla.setPCancel(rs.getString("PCancel"));
            conciergelocaltaquilla.setNuInf(rs.getString("NuInf"));
            conciergelocaltaquilla.setComentarios(rs.getString("Comentarios"));
            conciergelocaltaquilla.setEstatus(rs.getString("Estatus"));
            conciergelocaltaquilla.setDsEstatus(rs.getString("dsEstatus"));
            conciergelocaltaquilla.setDsTipoPago(rs.getString("dsTipoPago"));
            conciergelocaltaquilla.setExpira(rs.getString("Expira"));
            conciergelocaltaquilla.setFechaRegistro(rs.getString("FechaRegistro"));

            return conciergelocaltaquilla;
        }
    }
}
