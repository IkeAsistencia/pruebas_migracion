package com.ike.asistencias;

import com.ike.asistencias.to.AsistenciaTransladoRestos;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author fcerqueda
 */
public class DAOAsistenciaTraslado extends com.ike.model.DAOBASE {

    public DAOAsistenciaTraslado() {
    }

    public AsistenciaTransladoRestos getDetalleAsistenciaTraslado(String clExpediente) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_getDetalleAsistenciaTraslado ").append(clExpediente);

        col = this.rsSQLNP(sb.toString(), new DetalleAsistenciaTraslado());

        Iterator it = col.iterator();
        return it.hasNext() ? (AsistenciaTransladoRestos) it.next() : null;
    }

    public class DetalleAsistenciaTraslado implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            AsistenciaTransladoRestos asistenciaTransladoRestos = new AsistenciaTransladoRestos();

            asistenciaTransladoRestos.setClAsistenciaTraslado(rs.getInt("clTrasladoRestos"));
            asistenciaTransladoRestos.setClExpediente("clExpediente");
            asistenciaTransladoRestos.setNombreTitular("nombre");
            asistenciaTransladoRestos.setFechaDeceso(rs.getString("fechaDeceso"));
            asistenciaTransladoRestos.setCita(rs.getString("cita"));
            asistenciaTransladoRestos.setFechaCita(rs.getString("fechaCita"));
            asistenciaTransladoRestos.setObservaciones(rs.getString("Observaciones"));
            
            asistenciaTransladoRestos.setReferenciaVisualOrigen(rs.getString("ReferenciaVisualOrigen"));
            asistenciaTransladoRestos.setClPaisOrigen(rs.getString("clPaisOrigen"));
            asistenciaTransladoRestos.setDsPaisOrigen(rs.getString("dsPaisOrigen"));
            asistenciaTransladoRestos.setDsCodEntOrigen(rs.getString("dsEntFedOrigen"));
            asistenciaTransladoRestos.setCodMDOrigen(rs.getString("CodMDOrigen"));
            asistenciaTransladoRestos.setDsCodMDOrigen(rs.getString("dsMunDelOrigen"));
            asistenciaTransladoRestos.setCodEntOrigen(rs.getString("CodEntOrigen"));
            asistenciaTransladoRestos.setDireccionOrigen(rs.getString("direccionOrigen"));

            asistenciaTransladoRestos.setReferenciaVisualDestino(rs.getString("ReferenciaVisualDestino"));
            asistenciaTransladoRestos.setClPaisDestino(rs.getString("clPaisDestino"));
            asistenciaTransladoRestos.setDsPaisDestino(rs.getString("dsPaisDestino"));
            asistenciaTransladoRestos.setDsCodEntDestino(rs.getString("dsEntFedDestino"));
            asistenciaTransladoRestos.setCodMDODestino(rs.getString("CodMDDestino"));
            asistenciaTransladoRestos.setDsCodMDDestino(rs.getString("dsMunDelDestino"));
            asistenciaTransladoRestos.setCodEntDestino(rs.getString("CodEntDestino"));
            asistenciaTransladoRestos.setDireccionDestino(rs.getString("direccionDestino"));

            
            
            return asistenciaTransladoRestos;
        }
    }
}
