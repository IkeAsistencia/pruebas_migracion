/*
 * DAORCReunion.java
 *
 * Created on 06 de Octubre de 2006
 */
package com.ike.ReuComer;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import com.ike.ReuComer.to.RCReunion;

/*
 * @author Rodrigus
 */
public class DAORCReunion extends com.ike.model.DAOBASE {
    /* Creates a new instance of DAOHelpdesk */

    public DAORCReunion() {
    }

    public RCReunion getclReunion(String strclReunion) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_RCObtenReunion ").append(strclReunion);
        System.out.println(sb);
        col = this.rsSQLNP(sb.toString(), new ReunionFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (RCReunion) it.next() : null;

    }

    public class ReunionFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            RCReunion Reunion = new RCReunion();

            Reunion.setclReunion(rs.getString("clReunion"));
            Reunion.setclCliente(rs.getString("clCliente"));
            Reunion.setNombreCliente(rs.getString("NombreCliente"));
            Reunion.setFechaRegistro(rs.getString("FechaRegistro"));
            Reunion.setFechaProgramada(rs.getString("FechaProgramada"));
            Reunion.setclUsrAppConvoca(rs.getString("clUsrAppConvoca"));
            Reunion.setNombre(rs.getString("Nombre"));
            Reunion.setAsistentes(rs.getString("Asistentes"));
            Reunion.setPuntos(rs.getString("Puntos"));
            Reunion.setdsTipoReunion(rs.getString("dsTipoReunion"));

            return Reunion;
        }
    }
    /**
     * **************************************************************************************************************
     */
}
