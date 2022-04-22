/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ike.concierge;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import com.ike.concierge.ConciergePreferencia;

/*
 *
 * @author rfernandez
 */
public class DAOConciergePreferencia extends com.ike.model.DAOBASE{

/* Creates a new instance of DAOTelemarketing */
    public DAOConciergePreferencia() {
    }

    public ConciergePreferencia getConciergePreferencia(String StrclCSHistoricoP) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;


        sb.append("st_CSObtenDetallePreferencia ").append(StrclCSHistoricoP);
        System.out.println(sb);

        col = this.rsSQLNP(sb.toString(), new ConciergePreferenciaFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (ConciergePreferencia) it.next() : null;
    }

    public class ConciergePreferenciaFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{

                ConciergePreferencia CP = new ConciergePreferencia();

            CP.setclCSHistoricoP(rs.getString("clCSHistoricoP"));
            CP.setClConcierge(rs.getString("clConcierge"));
            CP.setclCSPreferencias(rs.getString("clCSPreferencias"));
            CP.setdsCSPreferencias(rs.getString("dsCSPreferencias"));
            CP.setEvento(rs.getString("Evento"));
            
            return CP;
        }
    }
}

