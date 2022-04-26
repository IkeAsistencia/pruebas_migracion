/*
 * DAOHelpdesk.java
 *
 * Created on 3 de abril de 2006, 04:09 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.helpdesk;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import java.util.ArrayList;

/*
 *
 * @author cabrerar
 */
public class DAOHelpdesk extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOHelpdesk */
    public DAOHelpdesk() {
    }

    public HDSolicitud getSolicitud(String strclSolicitudHD) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append(" st_HDDetalleSolicitud ").append(strclSolicitudHD);

        col = this.rsSQLNP(sb.toString(), new SolicitudFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (HDSolicitud) it.next() : null;
    }

    public class SolicitudFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            HDSolicitud Solicitud = new HDSolicitud();

            Solicitud.setClSolicitud(rs.getInt("clSolicitud"));
            Solicitud.setUsrRegistra(rs.getString("UsrRegistra"));
            Solicitud.setClUsrRegistra(rs.getInt("clUsrAppRegistra"));
            Solicitud.setFechaRegistro(rs.getString("FechaRegistro"));
            Solicitud.setclEstatus(rs.getInt("clEstatus"));
            Solicitud.setRevisadaxSistemas(rs.getString("RevisadaxSistemas"));
            Solicitud.setDsEstatusSol(rs.getString("dsEstatusSol"));
            Solicitud.setClTipoSol(rs.getInt("clTipoSol"));
            Solicitud.setDsTipoSol(rs.getString("dsTipoSol"));
            Solicitud.setFechaInicio(rs.getString("FechaInicio"));
            Solicitud.setFechaTermino(rs.getString("FechaTermino"));
            Solicitud.setFechaCompromiso(rs.getString("FechaCompromiso"));
            Solicitud.setAsunto(rs.getString("Asunto"));
            Solicitud.setDetalleSolicitud(rs.getString("DetalleSol"));
            Solicitud.setClUsrRevisa(rs.getInt("clUsrRevisa"));
            Solicitud.setUsrRevisa(rs.getString("UsrRev"));
            Solicitud.setFechaRevis(rs.getString("FechaRevis"));
            Solicitud.setClPrioridadHD(rs.getInt("clPrioridadHD"));
            Solicitud.setDsPrioridadHD(rs.getString("dsPrioridadHD"));
            Solicitud.setRequiereFirmas(rs.getString("RequiereFirmas"));
            Solicitud.setFirmas(rs.getString("Firmas"));
            Solicitud.setClUsrValFirmas(rs.getInt("clUsrValidaFirmas"));
            Solicitud.setUsrValFirmas(rs.getString("UsrVal"));
            Solicitud.setFechaValFirmas(rs.getString("FechaValFirmas"));
            Solicitud.setObservacionesSist(rs.getString("ObservacionesSist"));
            Solicitud.setAreaSolicitante(rs.getString("AreaSolicitante"));
            Solicitud.setFolioLibera(rs.getString("FolioLibera"));
            Solicitud.setTitular(rs.getString("Titular"));

            return Solicitud;
        }
    }

    public HDColabxSolic getColabxSol(String strclUsrxSol) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append(" st_HDColaboradorxSol ").append(strclUsrxSol);

        col = this.rsSQLNP(sb.toString(), new UsrxSolFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (HDColabxSolic) it.next() : null;
    }

    public class UsrxSolFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            HDColabxSolic UsrxSol = new HDColabxSolic();
            //UsrxSol.setClUsrxSol(rs.getInt("clUsrxSol"));
            UsrxSol.setClSolicitud(rs.getInt("clSolicitud"));
            UsrxSol.setClUsrApp(rs.getInt("clUsrApp"));
            UsrxSol.setNombreColaborador(rs.getString("NombreColaborador"));
            UsrxSol.setFechaAsignacion(rs.getString("FechaAsignacion"));
            UsrxSol.setclEstatus(rs.getInt("clEstatus"));
            UsrxSol.setDsEstatusSol(rs.getString("dsEstatusSol"));
            UsrxSol.setObservaciones(rs.getString("Observaciones"));
            UsrxSol.setClUsrAppAsigna(rs.getInt("clUsrAppAsigna"));
            UsrxSol.setNombreUsrQueAsigna(rs.getString("NombreUsrQueAsigna"));
            UsrxSol.setFechaInicio(rs.getString("FechaInicio"));
            UsrxSol.setFechaTermino(rs.getString("FechaTermino"));
            /*este no quitar UsrxSol.setCalifServ(rs.getInt("CalifServ"));
            UsrxSol.setCalifAtn(rs.getInt("CalifAtn"));
            UsrxSol.setCalifDominio(rs.getInt("CalifDominio"));
            UsrxSol.setCalifActitud(rs.getInt("CalifActitud"));
            UsrxSol.setCalifTR(rs.getInt("CalifTR"));*/
            return UsrxSol;
        }
    }

    public HDActivxUsr getActivxUsr(String strclActivxUsr) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append(" st_HDActividadxUsr ").append(strclActivxUsr);

        col = this.rsSQLNP(sb.toString(), new ActivxUsrFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (HDActivxUsr) it.next() : null;

    }

    public class ActivxUsrFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            HDActivxUsr ActivxUsr = new HDActivxUsr();
            ActivxUsr.setClActivxUsr(rs.getInt("clActivxUsr"));
            //ActivxUsr.setClUsrxSol(rs.getInt("clUsrxSol"));
            ActivxUsr.setClUsrApp(rs.getInt("clUsrApp"));
            ActivxUsr.setClSolicitud(rs.getInt("clSolicitud"));
            ActivxUsr.setColaborador(rs.getString("NombreColaborador"));
            ActivxUsr.setFechaAlta(rs.getString("FechaAlta"));
            ActivxUsr.setclEstatus(rs.getInt("clEstatus"));
            ActivxUsr.setDsEstatusSol(rs.getString("dsEstatusSol"));
            ActivxUsr.setGrupo(rs.getString("Grupo"));
            ActivxUsr.setObservaciones(rs.getString("Observaciones"));
            ActivxUsr.setFechaInicio(rs.getString("FechaInicio"));
            ActivxUsr.setFechaTermino(rs.getString("FechaTermino"));
            ActivxUsr.setFechaCompromiso(rs.getString("FechaCompromiso"));
            ActivxUsr.setPorcentaje(rs.getInt("Porcentaje"));
            ActivxUsr.setSecuencia(rs.getInt("Secuencia"));

            return ActivxUsr;
        }
    }

    public Object getActividades(String strclSolicitud) throws DAOException {

        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append(" st_HDDetalleActividad ").append(strclSolicitud);

        col = this.rsSQLNP(sb.toString(), new ActividadesFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (ArrayList) it.next() : null;

    }

    public class ActividadesFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            ArrayList lstReturn = new ArrayList();
            do {

                HDActivxUsr ActivxUsr = new HDActivxUsr();
                ActivxUsr.setClActivxUsr(rs.getInt("clActivxUsr"));
                ActivxUsr.setClUsrApp(rs.getInt("clUsrApp"));
                ActivxUsr.setClSolicitud(rs.getInt("clSolicitud"));
                ActivxUsr.setColaborador(rs.getString("NombreColaborador"));
                ActivxUsr.setFechaAlta(rs.getString("FechaAlta"));
                ActivxUsr.setclEstatus(rs.getInt("clEstatus"));
                ActivxUsr.setDsEstatusSol(rs.getString("dsEstatusSol"));
                ActivxUsr.setGrupo(rs.getString("Grupo"));
                ActivxUsr.setObservaciones(rs.getString("Observaciones"));
                ActivxUsr.setFechaInicio(rs.getString("FechaInicio"));
                ActivxUsr.setFechaTermino(rs.getString("FechaTermino"));
                ActivxUsr.setFechaCompromiso(rs.getString("FechaCompromiso"));
                ActivxUsr.setPorcentaje(rs.getInt("Porcentaje"));
                ActivxUsr.setSecuencia(rs.getInt("Secuencia"));
                lstReturn.add(ActivxUsr);
            } while (rs.next());
            return lstReturn;
        }
    }
}
