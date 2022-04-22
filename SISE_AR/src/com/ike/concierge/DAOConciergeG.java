/*
 *
 *
 * Created on 18 de agosto de 2006, 09:48 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.concierge;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import com.ike.concierge.to.ConciergeG;

/*
 *
 * @author perezern
 */
public class DAOConciergeG extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeG() {
    }

    public ConciergeG getConciergeGenerico(String StrclRetencTmk) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_CSDConciergeG ").append(StrclRetencTmk);
        //System.out.println(sb);

        col = this.rsSQLNP(sb.toString(), new ConciergeGenericoFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (ConciergeG) it.next() : null;
    }

    public class ConciergeGenericoFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            ConciergeG conciergeg = new ConciergeG();
            conciergeg.setCiudad(rs.getString("Ciudad"));
            conciergeg.setTelefonoH(rs.getString("TelefonoH"));
            conciergeg.setTelefonoOf(rs.getString("TelefonoO"));
            conciergeg.setTelefonoC(rs.getString("TelefonoC"));
            conciergeg.setDireccion(rs.getString("Direccion"));
            conciergeg.setNuestroUsuario(rs.getString("NuestroUsuario"));
            conciergeg.setNombre(rs.getString("Nombre"));
            conciergeg.setEmail(rs.getString("Email"));
            conciergeg.setClave(rs.getString("Clave"));
            conciergeg.setClCuenta(rs.getString("clCuenta"));
            conciergeg.setClConcierge(rs.getString("clConcierge"));
            conciergeg.setObservaciones(rs.getString("Observaciones"));
            return conciergeg;
        }
    }
}
