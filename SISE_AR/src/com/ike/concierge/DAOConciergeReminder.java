package com.ike.concierge;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import com.ike.concierge.ConciergeReminder;

public class DAOConciergeReminder extends com.ike.model.DAOBASE {


    public DAOConciergeReminder() {
    }

    public ConciergeReminder getConciergeReminder(String StrclEvento) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_CSObtenDetalleReminder ").append(StrclEvento);

        col = this.rsSQLNP(sb.toString(), new ConciergeReminderFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (ConciergeReminder) it.next() : null;
    }

    public class ConciergeReminderFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            ConciergeReminder conciergereminder = new ConciergeReminder();
            conciergereminder.setClConcierge(rs.getString("clConcierge"));
            conciergereminder.setclReminder(rs.getString("clReminder"));
            conciergereminder.setdsEvento(rs.getString("dsEvento"));
            conciergereminder.setFechaReminder(rs.getString("FechaReminder"));
            conciergereminder.setdsReminder(rs.getString("dsReminder"));

            return conciergereminder;
        }
    }
}
