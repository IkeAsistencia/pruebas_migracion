/*
 * DAOAI.java
 *
 * Created on 27 de Septiembre de 2006, 04:09 PM
 */
package com.ike.ActuaInter;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import com.ike.ActuaInter.to.AIExpediente;

/*
 * @author Rodrigus
 */
public class DAOAI extends com.ike.model.DAOBASE {
    /* Creates a new instance of DAOHelpdesk */

    public DAOAI() {
    }

    public AIExpediente getExpediente(String strclExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_AIObtenExpediente ").append(strclExpediente);
        System.out.println(sb.toString());
        col = this.rsSQLNP(sb.toString(), new ExpedienteFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (AIExpediente) it.next() : null;

    }

    public class ExpedienteFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            AIExpediente Expediente = new AIExpediente();

            Expediente.setclExpediente(rs.getString("clExpediente"));
            Expediente.setclAsistencia(rs.getString("clAsistencia"));
            Expediente.setAsistencia(rs.getString("Asistencia"));
            Expediente.setFechaActualizacion(rs.getString("FechaActualizacion"));
            Expediente.setAveriguacionPrevia(rs.getString("AveriguacionPrevia"));
            Expediente.setdsEstatusRecupDanos(rs.getString("dsEstatusRecupDanos"));
            Expediente.setclEstatusUnidad(rs.getString("clEstatusUnidad"));
            Expediente.setdsEstatusUnidad(rs.getString("dsEstatusUnidad"));
            Expediente.setFechaDetencion(rs.getString("FechaDetencion"));
            Expediente.setFechaAcredProp(rs.getString("FechaAcredProp"));
            Expediente.setFechaOficioLibera(rs.getString("FechaOficioLibera"));
            Expediente.setAvaluoPericial(rs.getString("AvaluoPericial"));
            Expediente.setFechaLibera(rs.getString("FechaLibera"));
            Expediente.setFechaPresQuerella(rs.getString("FechaPresQuerella"));
            Expediente.setMotivoNoLiberacion(rs.getString("MotivoNoLiberacion"));
            Expediente.setEmail(rs.getString("Email"));
            Expediente.setclCulpaDicta(rs.getString("clCulpaDicta"));
            Expediente.setdsCulpaDicta(rs.getString("dsCulpaDicta"));
            return Expediente;
        }
    }
    /**
     * **************************************************************************************************************
     */
}
