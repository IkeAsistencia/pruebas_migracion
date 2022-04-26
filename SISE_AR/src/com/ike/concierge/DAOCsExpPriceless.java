/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.concierge;

import com.ike.concierge.to.CsExpPriceless;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/**
 *
 * @author
 * fcerqueda
 */
public class DAOCsExpPriceless extends com.ike.model.DAOBASE {

    public DAOCsExpPriceless() {
    }

    public CsExpPriceless getCsExpPriceless(String StrclExperiencia) throws DAOException {

        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_DetalleExpPriceless ").append(StrclExperiencia);

        col = this.rsSQLNP(sb.toString(), new CsExpPricelessFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (CsExpPriceless) it.next() : null;
    }

    public class CsExpPricelessFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {

            CsExpPriceless detExpPrice = new CsExpPriceless();

            detExpPrice.setClTipoBen(rs.getString("clTipoBen"));
            detExpPrice.setDsTipoBen(rs.getString("dsTipoBen"));
            detExpPrice.setClCiudad(rs.getString("clCiudad"));
            detExpPrice.setDsCiudad(rs.getString("dsCiudad"));
            detExpPrice.setClExperiencia(rs.getString("clExperiencia"));
            detExpPrice.setDsExperiencia(rs.getString("dsExperiencia"));
            detExpPrice.setFechaAlta(rs.getString("fechaAlta"));
            detExpPrice.setFechaini(rs.getString("fechaini"));
            detExpPrice.setFechafin(rs.getString("fechafin"));
            detExpPrice.setActivo(rs.getString("activo"));
            detExpPrice.setFechaInactivacion(rs.getString("fechaInactivacion"));
            detExpPrice.setLimiteLocalidades(rs.getString("limiteLocalidades"));
            detExpPrice.setNumExp(rs.getString("numExp"));
            detExpPrice.setExpDisponibles(rs.getString("expDisponibles"));

            return detExpPrice;
        }
    }
}
