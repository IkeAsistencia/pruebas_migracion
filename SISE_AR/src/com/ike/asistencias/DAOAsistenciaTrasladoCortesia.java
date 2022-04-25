package com.ike.asistencias;

/**
 *
 * @author dmontaut
 */

import com.ike.asistencias.to.DetalleAsistenciaTrasladoCortesia;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

public class DAOAsistenciaTrasladoCortesia extends com.ike.model.DAOBASE {

public DAOAsistenciaTrasladoCortesia() {
    }

    public DetalleAsistenciaTrasladoCortesia getDetalleAsistenciaTrasladoCortesia(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_getDetAsisTrasladoCortesia ").append(clExpediente);

        col = this.rsSQLNP(sb.toString(), new DetalleAsistenciaTrasladoCortesiaFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (DetalleAsistenciaTrasladoCortesia) it.next() : null;
    }

    public class DetalleAsistenciaTrasladoCortesiaFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            DetalleAsistenciaTrasladoCortesia AH = new DetalleAsistenciaTrasladoCortesia();

            AH.setClExpediente(rs.getString("clExpediente"));
            AH.setMotivo(rs.getString("Motivo"));
            AH.setCantPersonas(rs.getString("CantPersonas"));
            AH.setFechaTraslado(rs.getString("FechaTraslado"));
            AH.setHoraD(rs.getString("HoraD"));
            AH.setHoraH(rs.getString("HoraH"));
            
            AH.setDsEntFedO(rs.getString("dsEntFedO"));
            AH.setDsMunDelO(rs.getString("dsMunDelO"));
            AH.setCodMDO(rs.getString("CodMDO"));
            AH.setCodEntO(rs.getString("CodEntO"));
            AH.setCalleO(rs.getString("CalleO"));
            AH.setLatLongO(rs.getString("LatLongO"));
            AH.setReferenciasO(rs.getString("ReferenciasO"));
            
            AH.setDsEntFedD(rs.getString("dsEntFedD"));
            AH.setDsMunDelD(rs.getString("dsMunDelD"));
            AH.setCodMDD(rs.getString("CodMDD"));
            AH.setCodEntD(rs.getString("CodEntD"));
            AH.setCalleD(rs.getString("CalleD"));
            AH.setLatLongD(rs.getString("LatLongD"));
            AH.setReferenciasD(rs.getString("ReferenciasD"));
                      
            AH.setObservaciones(rs.getString("Observaciones"));
            AH.setCosto(rs.getString("Costo"));
    
            return AH;
        }
    }
}
