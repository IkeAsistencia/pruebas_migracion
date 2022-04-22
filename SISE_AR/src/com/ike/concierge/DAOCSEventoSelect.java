/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.concierge;

import com.ike.concierge.to.CSEventoSelect;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;


public class DAOCSEventoSelect extends com.ike.model.DAOBASE {

    public DAOCSEventoSelect() {
    }

    public CSEventoSelect getCSEventoSelect(String StrclEventoSelect) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_DetalleEventSelect ").append(StrclEventoSelect);

        col = this.rsSQLNP(sb.toString(), new CSEventoSelectFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (CSEventoSelect) it.next() : null;

    }

    public class CSEventoSelectFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSEventoSelect detEVS = new CSEventoSelect();

            detEVS.setClTipoBen(rs.getString("clTipoBen"));
            detEVS.setDsTipoBen(rs.getString("dsTipoBen"));
            detEVS.setClCiudad(rs.getString("clCiudad"));
            detEVS.setDsCiudad(rs.getString("dsCiudad"));
            detEVS.setClEventoSelect(rs.getString("clEventoSelect"));
            detEVS.setDsEventoSelect(rs.getString("dsEventoSelect"));
            detEVS.setFechaAlta(rs.getString("fechaAlta"));
            detEVS.setFechaini(rs.getString("fechaini"));
            detEVS.setFechafin(rs.getString("fechafin"));
            detEVS.setActivo(rs.getString("activo"));
            detEVS.setFechaInactivacion(rs.getString("fechaInactivacion"));
            detEVS.setLimiteLocalidades(rs.getString("limiteLocalidades"));
            detEVS.setNumExp(rs.getString("numExp"));
            detEVS.setExpDisponibles(rs.getString("expDisponibles"));

            return detEVS;
        }
    }
}
