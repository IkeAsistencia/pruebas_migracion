/*
 * DAOSeguimientoProveedor.java
 *
 * Created on 21 de enero de 2009, 10:55 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.ike.asistencias;

import com.ike.asistencias.to.SeguimientoProveedor;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/* @author rfernandez */

public class DAOSeguimientoProveedor extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOSeguimientoProveedor */
    public DAOSeguimientoProveedor() {
    }

    public SeguimientoProveedor getSeguimientoProveedor(String clSeguimientoProveedor) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_SeguimientoProveedor ").append(clSeguimientoProveedor);

        col = this.rsSQLNP(sb.toString(), new SeguimientoProveedorFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (SeguimientoProveedor) it.next() : null;
    }

    public class SeguimientoProveedorFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            SeguimientoProveedor SP = new SeguimientoProveedor();
            
            SP.setClSeguimientoProveedor(rs.getString("clSeguimientoProveedor"));
            SP.setClProveedor(rs.getString("clProveedor"));
            SP.setFecha(rs.getString("fecha"));
            SP.setClMediosContacto(rs.getString("clMediosContacto"));
            SP.setDsMediosContacto(rs.getString("dsMediosContacto"));
            SP.setClClasificacionSeguimiento(rs.getString("clClasificacionSeguimiento"));
            SP.setDsClasificacionSeguimiento(rs.getString("dsClasificacionSeguimiento"));
            SP.setObservaciones(rs.getString("Observaciones"));
            return SP;
        }
    }
}