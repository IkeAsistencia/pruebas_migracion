package com.ike.asistencias;

import com.ike.asistencias.to.DomicilioFacturacion;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

public class DAODomicilioFacturacion extends com.ike.model.DAOBASE{
    public DAODomicilioFacturacion() {   }
        public DomicilioFacturacion getDomicilioFacturacion(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_WebBuscaNuestroUsrFacturacion ").append(clExpediente);
        col = this.rsSQLNP(sb.toString(), new DomicilioFacturacionFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (DomicilioFacturacion) it.next() : null;
        }
    public class DomicilioFacturacionFiller implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            DomicilioFacturacion domicilioFacturacion = new DomicilioFacturacion();
            domicilioFacturacion.setClAfiliado(rs.getString("AFILIADO"));
            domicilioFacturacion.setClExpediente(rs.getString("EXPEDIENTE"));
            domicilioFacturacion.setClave(rs.getString("CLAVE"));
            domicilioFacturacion.setClcuenta(rs.getString("CUENTA"));
            domicilioFacturacion.setCorreo(rs.getString("EMAIL"));
            domicilioFacturacion.setDireccion(rs.getString("DOMICILIO"));
            domicilioFacturacion.setDni(rs.getString("DNICUIL"));
            domicilioFacturacion.setLocalidad(rs.getString("LOCALIDAD"));
            domicilioFacturacion.setNombre(rs.getString("NOMBRE_COMPLETO"));
            domicilioFacturacion.setPrefijo(rs.getString("PREFIJO"));
            domicilioFacturacion.setProvincia(rs.getString("PROVINCIA"));
            domicilioFacturacion.setProvinciaExpediente(rs.getString("PROVINCIA_EXPEDIENTE"));
            domicilioFacturacion.setLocalidadExpediente(rs.getString("LOCALIDAD_EXPEDIENTE"));
            domicilioFacturacion.setDetalleServicio(rs.getString("DETALLE_SERVICIO"));
            return domicilioFacturacion;
        }
    }
}