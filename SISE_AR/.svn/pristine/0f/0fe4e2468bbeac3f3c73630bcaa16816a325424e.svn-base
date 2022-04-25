   /*
 * DAOConciergeWow.java
 *
 * Created on 24 de enero de 2007, 10:22 AM
 */
package com.ike.concierge;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import com.ike.concierge.ConciergeWow;

/*
 *
 * @author zamoraed
 */
public class DAOConciergeWow extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeWow() {
    }

    public ConciergeWow getConciergeWow(String StrclEvento) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_CSObtenDEatlleWOW ").append(StrclEvento);

        col = this.rsSQLNP(sb.toString(), new ConciergeWowFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (ConciergeWow) it.next() : null;
    }

    public class ConciergeWowFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            ConciergeWow conciergewow = new ConciergeWow();
            conciergewow.setClConcierge(rs.getString("clConcierge"));
            conciergewow.setclWow(rs.getString("clWow"));
            conciergewow.setdsEvento(rs.getString("dsEvento"));
            conciergewow.setFechaWow(rs.getString("FechaWow"));
            conciergewow.setdsWow(rs.getString("dsWow"));

            return conciergewow;
        }
    }
}
