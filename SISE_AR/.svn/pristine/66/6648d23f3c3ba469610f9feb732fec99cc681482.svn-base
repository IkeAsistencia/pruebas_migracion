/*
 * DAORCReunion.java
 *
 * Created on 06 de Octubre de 2006
 */
package com.ike.SL;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import com.ike.SL.to.SLExpediente;
import com.ike.SL.to.SLLlamadaEncuesta;

/*
 * @author Rodrigus
 */
public class DAOSL extends com.ike.model.DAOBASE {
    /* Creates a new instance of DAOHelpdesk */

    public DAOSL() {
    }

    public SLExpediente getclExpediente(String strclExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("sp_SLObtenExpediente ").append(strclExpediente);

        col = this.rsSQLNP(sb.toString(), new ExpedienteFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (SLExpediente) it.next() : null;
    }

    public class ExpedienteFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            SLExpediente Expediente = new SLExpediente();

            Expediente.setclExpediente(rs.getString("clExpediente"));
            Expediente.setCuenta(rs.getString("Cuenta"));
            Expediente.setFechaRegistro(rs.getString("FechaRegistro"));
            Expediente.setNuestroUsuario(rs.getString("NuestroUsuario"));
            Expediente.setEstatus(rs.getString("Estatus"));
            Expediente.setConductor(rs.getString("Conductor"));
            Expediente.setVehiculo(rs.getString("Vehiculo"));
            Expediente.setColor(rs.getString("Color"));
            Expediente.setPlacas(rs.getString("Placas"));
            Expediente.setLada(rs.getString("Lada"));
            Expediente.setTelefonoCasa(rs.getString("TelefonoCasa"));
            Expediente.setLada2(rs.getString("Lada2"));
            Expediente.setTelefonoOtro(rs.getString("TelefonoOtro"));
            Expediente.setSubServicio(rs.getString("Subservicio"));
            Expediente.setProveedor(rs.getString("Proveedor"));
            Expediente.setEstado(rs.getString("Estado"));
            Expediente.setMunDel(rs.getString("MunDel"));
            return Expediente;
        }
    }

    /**
     * **************************************************************************************************************
     */
    public SLLlamadaEncuesta getclExpedienteLL(String strclExpedienteLL) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_ObtenExpedienteLlamada ").append(strclExpedienteLL);

        col = this.rsSQLNP(sb.toString(), new LlamadaFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (SLLlamadaEncuesta) it.next() : null;
    }

    public class LlamadaFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            SLLlamadaEncuesta Llamada = new SLLlamadaEncuesta();

            Llamada.setclLlamada(rs.getString("clLlamada"));
            Llamada.setclExpediente(rs.getString("clExpediente"));
            Llamada.setNombre(rs.getString("Nombre"));
            Llamada.setExtension(rs.getString("Extension"));
            Llamada.setFechaLlamada(rs.getString("FechaLlamada"));
            Llamada.setTipoContactante(rs.getString("TipoContactante"));
            Llamada.setNombreContactante(rs.getString("NombreContactante"));
            Llamada.setclIndicador(rs.getString("clIndicador"));
            Llamada.setdsIndicador(rs.getString("dsIndicador"));
            Llamada.setObservaciones(rs.getString("Observaciones"));
            Llamada.setFechaProgramada(rs.getString("FechaProgramada"));
            Llamada.setLada(rs.getString("Lada"));
            Llamada.setTelefonoContacto(rs.getString("TelefonoContacto"));
            Llamada.setIntentoLlamada(rs.getString("IntentoLlamada"));
            Llamada.setresp1(rs.getString("Resp1"));
            Llamada.setresp2(rs.getString("Resp2"));
            Llamada.setresp3(rs.getString("Resp3"));
            Llamada.setresp4(rs.getString("Resp4"));
            Llamada.setresp5(rs.getString("Resp5"));
            Llamada.setresp6(rs.getString("Resp6"));
            Llamada.setNotas(rs.getString("Notas"));

            return Llamada;
        }
    }
}
