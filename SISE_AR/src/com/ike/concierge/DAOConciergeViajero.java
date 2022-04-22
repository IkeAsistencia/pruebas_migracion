

package com.ike.concierge;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import com.ike.concierge.ConciergeViajero;

/*
 *
 * @author rfernandez
 */

public class DAOConciergeViajero extends com.ike.model.DAOBASE{

    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeViajero() {
    }

    public ConciergeViajero getConciergeViajero(String StrclCSViajero) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;


        sb.append("st_CSObtenDetalleViajero ").append(StrclCSViajero);
        System.out.println(sb);

        col = this.rsSQLNP(sb.toString(), new ConciergeViajeroFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (ConciergeViajero) it.next() : null;
    }

    public class ConciergeViajeroFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{

                ConciergeViajero CV = new ConciergeViajero();

            CV.setclCSViajero(rs.getString("clCSViajero"));
            CV.setClConcierge(rs.getString("clConcierge"));
            CV.setclCSPrograma(rs.getString("clCSPrograma"));
            CV.setdsCSPrograma(rs.getString("dsCSPrograma"));
            CV.setCompania(rs.getString("Compania"));
            CV.setMembresia(rs.getString("Membresia"));
            CV.setFechaVigencia(rs.getString("FechaVigencia"));
            //System.out.println(rs.getString("dsWow"));
            return CV;
        }
    }
}

