/*
 * DAOEquipoSalidaSP.java
 * 
 * Created 2011-03-14
 * 
 */
package com.ike.helpdeskSP;

import com.ike.helpdeskSP.to.EquipoSalidaSP;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @autor bsanchez
 */
public class DAOEquipoSalidaSP extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOEquipoSalidaSP */
    public DAOEquipoSalidaSP() {
    }

    public EquipoSalidaSP getclEquipoSalidaSP(String clEquipoSalidaSP) throws DAOException {

        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_EquipoSalidaSP ").append(clEquipoSalidaSP);
        col = this.rsSQLNP(sb.toString(), new EquipoSalidaSPFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (EquipoSalidaSP) it.next() : null;
    }

    /* Creates Filler of EquipoSalidaSP */
    public class EquipoSalidaSPFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            EquipoSalidaSP ES = new EquipoSalidaSP();

            ES.setclEquipoSalidaSP(rs.getString("clEquipoSalidaSP"));
            ES.setResponsableEntrega(rs.getString("ResponsableEntrega"));
            ES.setResponsableSalida(rs.getString("ResponsableSalida"));
            ES.setFechaEntrega(rs.getString("FechaEntrega"));
            ES.setFechaSalida(rs.getString("FechaSalida"));
            ES.setComentarios(rs.getString("Comentarios"));
            ES.setclMotivoSalida(rs.getString("clEstatus"));
            ES.setdsMotivoSalida(rs.getString("dsEstatus"));
            ES.setClEstatusES(rs.getString("clEstatusES"));
            ES.setDsEstatusES(rs.getString("dsEstatusES"));

            return ES;
        }
    }
}
