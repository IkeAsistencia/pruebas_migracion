/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias;

import com.ike.asistencias.to.AsistenciaEnvTrasMedico;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author mramirez
 */
public class DAOAsistenciaEnvTrasMedico extends com.ike.model.DAOBASE {

    public DAOAsistenciaEnvTrasMedico() {
    }

    public AsistenciaEnvTrasMedico getAsistenciaEnvTrasMedico(String clExpediente) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_getEnvioTrasladoMedico ").append(clExpediente);
        col = this.rsSQLNP(sb.toString(), new AsistenciaEnvTrasMedicoClass());

        Iterator i = col.iterator();
        return i.hasNext() ? (AsistenciaEnvTrasMedico) i.next() : null;
    }

    public class AsistenciaEnvTrasMedicoClass implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            AsistenciaEnvTrasMedico AET = new AsistenciaEnvTrasMedico();

            AET.setClExpediente(rs.getString("clExpediente"));
            AET.setFechaApertura(rs.getString("FechaApertura"));
            AET.setFechaRegistro(rs.getString("FechaRegistro"));
            AET.setDsTipoTransporte(rs.getString("dsTipoTransporte"));
            AET.setDsMarcaAuto(rs.getString("dsMarcaAuto"));
            AET.setDsTipoAuto(rs.getString("dsTipoAuto"));
            AET.setCodigoMarca(rs.getString("CodigoMarca"));
            AET.setClaveAmis(rs.getString("ClaveAMIS"));
            AET.setReservacion(rs.getString("ReservacionA"));
            AET.setNumAdultos(rs.getString("NumAdultosViajan"));
            AET.setNumMenores(rs.getString("NumNinosViajan"));
            AET.setClPaisReside(rs.getString("clPaisReside"));
            AET.setDsPaisReside(rs.getString("dsPaisReside"));
            AET.setCodEntReside(rs.getString("CodEntReside"));
            AET.setDsEntFedReside(rs.getString("dsEntFedReside"));
            AET.setCodMdReside(rs.getString("CodMDReside"));
            AET.setDsMunDelReside(rs.getString("dsMunDelReside"));
            AET.setClPaisDest(rs.getString("clPaisDest"));
            AET.setDsPaisDest(rs.getString("dsPaisDest"));
            AET.setCodEntDest(rs.getString("CodtEnDest"));
            AET.setDsEntFedDest(rs.getString("dsEntFedDest"));
            AET.setCodMDDest(rs.getString("CodMDDest"));
            AET.setDsMunDelDest(rs.getString("dsMunDelDest"));
            AET.setCostoCotizado(rs.getString("CostoCotizacion"));
            AET.setCostoFinal(rs.getString("CostoFinal"));
            AET.setPatente(rs.getString("Patente"));
            AET.setChofer(rs.getString("Chofer"));
            AET.setCalleNumeroOrigen(rs.getString("CalleNumeroOrigen"));
            AET.setCalleNumeroDestino(rs.getString("CalleNumeroDestino"));
            AET.setCita(rs.getString("Cita"));
            AET.setObservaciones(rs.getString("Observaciones"));
            return AET;
        }
    }
}
