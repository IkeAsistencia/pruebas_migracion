/*
 * DAORCAIKE.java
 *
 * Created on 06 de Octubre de 2006
 */
package com.ike.ReuComer;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import com.ike.ReuComer.to.RCAIKE;

/*
 * @author Rodrigus
 */
public class DAORCAIKE extends com.ike.model.DAOBASE {
    /* Creates a new instance of DAOHelpdesk */

    public DAORCAIKE() {
    }

    public RCAIKE getAsistente(String strclAsistente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_RCObtenAsistentes ").append(strclAsistente);
        System.out.println(sb);
        col = this.rsSQLNP(sb.toString(), new AsistenteFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (RCAIKE) it.next() : null;

    }

    public class AsistenteFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            RCAIKE Asistente = new RCAIKE();
            Asistente.setclAsistente(rs.getString("clAsistente"));
            Asistente.setclReunion(rs.getString("clReunion"));
            Asistente.setclUsrAppAsistente(rs.getString("clUsrAppAsistente"));
            Asistente.setNombre(rs.getString("Nombre"));
            return Asistente;
        }
    }
}
