package com.ike.asistencias;

import com.ike.asistencias.to.DatosFactDetAsistencia;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

public class DAODatosFactDetAsistencia extends com.ike.model.DAOBASE {    
        public DAODatosFactDetAsistencia() {        }
        public DatosFactDetAsistencia getDatosFactDetAsistencia(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_WebBuscaDatosFacturacion ").append(clExpediente);
        col = this.rsSQLNP(sb.toString(), new DatosFactDetAsistenciaFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (DatosFactDetAsistencia) it.next() : null;
        }
    public class DatosFactDetAsistenciaFiller implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            DatosFactDetAsistencia domicilioFacturacion = new DatosFactDetAsistencia();
            domicilioFacturacion.setDetAsistCalle(rs.getString("CALLE"));
            domicilioFacturacion.setDetAsistLocalidad(rs.getString("LOCALIDAD"));
            domicilioFacturacion.setDetAsistProvincia(rs.getString("PROVINCIA"));
            domicilioFacturacion.setDetAsistTabla(rs.getString("TABLA"));
            domicilioFacturacion.setDetAsistUsuarioExpediente(rs.getString("USUARIO_EXPEDIENTE"));
            domicilioFacturacion.setDetAsistEmailExpediente(rs.getString("EMAIL_EXPEDIENTE"));
            return domicilioFacturacion;
        }
    }
}