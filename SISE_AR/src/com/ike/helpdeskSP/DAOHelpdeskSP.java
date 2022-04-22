/*
 * DAOHelpdeskSP.java
 *
 * Created on 19 de marzo de 2009, 04:30 PM
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
public class DAOHelpdeskSP extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOHelpdeskSP */
    public DAOHelpdeskSP() {
    }

    public HelpdeskSP getHelpdeskSP(String clSolicitud) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_HelpdeskSP ").append(clSolicitud);

        col = this.rsSQLNP(sb.toString(), new HelpdeskSPFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (HelpdeskSP) it.next() : null;
    }

    public class HelpdeskSPFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            HelpdeskSP HD = new HelpdeskSP();

            HD.setclSolicitud(rs.getString("clSolicitud"));
            HD.setclUsrAppRegistra(rs.getString("clUsrAppRegistra"));
            HD.setNombre(rs.getString("Nombre"));
            HD.setFechaRegistro(rs.getString("FechaRegistro"));
            HD.setclEstatus(rs.getString("clEstatus"));
            HD.setdsEstatus(rs.getString("dsEstatus"));
            HD.setclAreaOperativa(rs.getString("clAreaOperativa"));
            HD.setdsAreaOperativa(rs.getString("dsAreaOperativa"));
            HD.setclPiso(rs.getString("clPiso"));
            HD.setdsPiso(rs.getString("dsPiso"));
            HD.setExtencion(rs.getString("Extencion"));
            HD.setDetalleSol(rs.getString("DetalleSol"));
            HD.setclColaboradorAsignadoSP(rs.getString("clColaboradorAsignadoSP"));
            HD.setdsColaboradorAsignadoSP(rs.getString("dsColaboradorAsignadoSP"));
            HD.setSeguimiento(rs.getString("Seguimiento"));
            HD.setActividadR(rs.getString("ActividadR"));
            HD.setFechaCompromiso(rs.getString("FechaCompromiso"));
            HD.setFechaTermino(rs.getString("FechaTermino"));
            HD.setclTipoFallaSP(rs.getString("clTipoFallaSP"));
            HD.setdsTipoFallaSP(rs.getString("dsTipoFallaSP"));
            HD.setClAtencion(rs.getString("clAtencion"));
            HD.setDsAtencion(rs.getString("dsAtencion"));
            HD.setClDominio(rs.getString("clDominio"));
            HD.setDsDominio(rs.getString("dsDominio"));
            HD.setClActitud(rs.getString("clActitud"));
            HD.setDsActitud(rs.getString("dsActitud"));
            HD.setClServicio(rs.getString("clServicio"));
            HD.setDsServicio(rs.getString("dsServicio"));
            HD.setClTiempodeEspera(rs.getString("clTiempodeEspera"));
            HD.setDsTiempodeEspera(rs.getString("dsTiempodeEspera"));
            HD.setclUsrAppSP(rs.getString("clUsrAppSP"));
            HD.setNombreUsrSP(rs.getString("NombreUsrSP"));
            HD.setCorreo(rs.getString("Correo"));

            return HD;
        }
    }
}
