package com.ike.generales;

import com.ike.generales.to.SubServxProv;
import com.ike.model.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Iterator;

public class DAOSubServxProv extends com.ike.model.DAOBASE {

    public DAOSubServxProv() {
    }

    public SubServxProv getSubServxProv(String clProveedor, String clServicio, String clSubServicio) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_DAOSubServxProv ").append("'").append(clProveedor).append("','").append(clServicio).append("','").append(clSubServicio).append("'");
        col = rsSQLNP(sb.toString(), new SubServxProvFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (SubServxProv) it.next() : null;
    }

    public class SubServxProvFiller implements com.ike.model.LlenaDatos {

        public Object llena(ResultSet rs) throws SQLException {
            SubServxProv sub = new SubServxProv();
            sub.setClServicio(rs.getString("ClServicio"));
            sub.setCosto(rs.getString("costo"));
            sub.setDsServicio(rs.getString("DsServicio"));
            sub.setDsSubServicio(rs.getString("DsSubServicio"));
            sub.setNombreOperativo(rs.getString("NombreOpe"));
            sub.setObservaciones(rs.getString("Observaciones"));
            sub.setPrioridad(rs.getString("Prioridad"));
            return sub;
        }
    }
}