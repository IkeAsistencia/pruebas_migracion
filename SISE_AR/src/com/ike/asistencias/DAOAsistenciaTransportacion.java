/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias;

import com.ike.asistencias.to.AsistenciaTransportacion;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author fcerqueda
 */
public class DAOAsistenciaTransportacion extends com.ike.model.DAOBASE {
    public DAOAsistenciaTransportacion() {
    }

    public AsistenciaTransportacion getAsistenciaTransportacion(String clExpediente) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_getTransportacion ").append(clExpediente);
        col = this.rsSQLNP(sb.toString(), new AsistenciaTransportacionClass());

        Iterator i = col.iterator();
        return i.hasNext() ? (AsistenciaTransportacion) i.next() : null;
    }

    public class AsistenciaTransportacionClass implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            AsistenciaTransportacion AT = new AsistenciaTransportacion();

            AT.setClExpediente(rs.getString("clExpediente"));
            AT.setFechaApertura(rs.getString("FechaApertura"));
            AT.setFechaRegistro(rs.getString("FechaRegistro"));
            AT.setDsTipoTransporte(rs.getString("dsTipoTransporte"));
            AT.setTiempoReparacion(rs.getString("TiempoReparacion"));
            AT.setDsMarcaAuto(rs.getString("dsMarcaAuto"));
            AT.setDsTipoAuto(rs.getString("dsTipoAuto"));
            AT.setCodigoMarca(rs.getString("CodigoMarca"));
            AT.setClaveAmis(rs.getString("ClaveAMIS"));
            AT.setReservacion(rs.getString("ReservacionA"));
            AT.setNumAdultos(rs.getString("NumAdultosViajan"));
            AT.setNumMenores(rs.getString("NumNinosViajan"));
            AT.setClPaisReside(rs.getString("clPaisReside"));
            AT.setDsPaisReside(rs.getString("dsPaisReside"));
            AT.setCodEntReside(rs.getString("CodEntReside"));
            AT.setDsEntFedReside(rs.getString("dsEntFedReside"));
            AT.setCodMdReside(rs.getString("CodMDReside"));
            AT.setDsMunDelReside(rs.getString("dsMunDelReside"));
            AT.setClPaisDest(rs.getString("clPaisDest"));
            AT.setDsPaisDest(rs.getString("dsPaisDest"));
            AT.setCodEntDest(rs.getString("CodtEnDest"));
            AT.setDsEntFedDest(rs.getString("dsEntFedDest"));
            AT.setCodMDDest(rs.getString("CodMDDest"));
            AT.setDsMunDelDest(rs.getString("dsMunDelDest"));
            AT.setFechaCorrida(rs.getString("HoraFechaCorrida"));
            AT.setCostoCotizado(rs.getString("CostoCotizacion"));
            AT.setCostoFinal(rs.getString("CostoFinal"));

            return AT;
        }
    }
}
