/*
 * DAOTieneAsistencia.java
 *
 * Created on 11 de Agosto de 2006, 16:30 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.model;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.to.TieneAsistenciaExp;

/*
 *
 * @author rodrigus
 */
public class DAOTieneAsistencia extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOTieneAsistencia */
    public DAOTieneAsistencia() {
    }

    public TieneAsistenciaExp getExpediente(String strclExpediente) throws DAOException {

        StringBuffer sb = new StringBuffer();
        Collection col = null;


        sb.append("st_TieneAsistenciaExp ").append(strclExpediente);
        col = this.rsSQLNP(sb.toString(), new ExpedienteFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (TieneAsistenciaExp) it.next() : null;

    }

    public class ExpedienteFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {

            TieneAsistenciaExp ExpedienteTA = new TieneAsistenciaExp();

            ExpedienteTA.setTieneAsistencia(rs.getString("TieneAsistencia"));
            ExpedienteTA.setCodEnt(rs.getString("CodEnt"));
            ExpedienteTA.setdsEntFed(rs.getString("dsEntFed"));
            ExpedienteTA.setCodMD(rs.getString("CodMD"));
            ExpedienteTA.setdsMunDel(rs.getString("dsMunDel"));
            return ExpedienteTA;
        }
    }
}
    