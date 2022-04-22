/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.concierge;

import com.ike.concierge.to.CSEventoAmex;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;


public class DAOCSEventoAmex extends com.ike.model.DAOBASE {

    public DAOCSEventoAmex() {
    }

    public CSEventoAmex getCSEventoAmex(String StrclEventoAmex) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_DetalleEventAmex ").append(StrclEventoAmex);

        col = this.rsSQLNP(sb.toString(), new CSEventoAmexFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (CSEventoAmex) it.next() : null;

    }

    public class CSEventoAmexFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSEventoAmex detEVA = new CSEventoAmex();

            detEVA.setClTipoBen(rs.getString("clTipoBen"));
            detEVA.setDsTipoBen(rs.getString("dsTipoBen"));
            detEVA.setClCiudad(rs.getString("clCiudad"));
            detEVA.setDsCiudad(rs.getString("dsCiudad"));
            detEVA.setClEventoAmex(rs.getString("clEventoAmex"));
            detEVA.setDsEventoAmex(rs.getString("dsEventoAmex"));
            detEVA.setFechaAlta(rs.getString("fechaAlta"));
            detEVA.setFechaini(rs.getString("fechaini"));
            detEVA.setFechafin(rs.getString("fechafin"));
            detEVA.setActivo(rs.getString("activo"));
            detEVA.setFechaInactivacion(rs.getString("fechaInactivacion"));
            detEVA.setLimiteLocalidades(rs.getString("limiteLocalidades"));
            detEVA.setNumExp(rs.getString("numExp"));
            detEVA.setExpDisponibles(rs.getString("expDisponibles"));

            return detEVA;
        }
    }
}
