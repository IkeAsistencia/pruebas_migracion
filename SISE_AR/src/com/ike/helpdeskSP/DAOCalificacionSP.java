/*
 * DAOCalificacionSP.java
 *
 * Created on 16 de abril de 2009, 03:15 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.ike.helpdeskSP;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author rfernandez
 */
public class DAOCalificacionSP extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOCalificacionSP */
    public DAOCalificacionSP() {
    }

    public CalificacionSP getCalificacionSP(String clSolicitud) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_HelpdeskCalificacion ").append(clSolicitud);

        col = this.rsSQLNP(sb.toString(), new CalificacionSPFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (CalificacionSP) it.next() : null;
    }

    public class CalificacionSPFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CalificacionSP CSP = new CalificacionSP();


            CSP.setclCalificacionxSolicitud(rs.getString("clCalificacionxSolicitud"));
            CSP.setclSolicitud(rs.getString("clSolicitud"));

            CSP.setclAtencion(rs.getString("clAtencion"));
            CSP.setdsAtencion(rs.getString("dsAtencion"));

            CSP.setclDominio(rs.getString("clDominio"));
            CSP.setdsDominio(rs.getString("dsDominio"));

            CSP.setclActitud(rs.getString("clActitud"));
            CSP.setdsActitud(rs.getString("dsActitud"));

            CSP.setclServicio(rs.getString("clServicio"));
            CSP.setdsServicio(rs.getString("dsServicio"));

            CSP.setclTiempodeEspera(rs.getString("clTiempodeEspera"));
            CSP.setdsTiempodeEspera(rs.getString("dsTiempodeEspera"));

            return CSP;
        }
    }
}
