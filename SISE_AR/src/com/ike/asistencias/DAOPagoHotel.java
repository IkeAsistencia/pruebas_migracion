/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias;

import com.ike.asistencias.to.PagoHotel;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author rurbina
 */
public class DAOPagoHotel extends com.ike.model.DAOBASE {

    public DAOPagoHotel() {
    }

    public PagoHotel getPagoHotel(String clExpediente) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_getPagoHotel ").append(clExpediente);

        col = this.rsSQLNP(sb.toString(), new Hotel());

        Iterator it = col.iterator();
        return it.hasNext() ? (PagoHotel) it.next() : null;
    }

    public class Hotel implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            PagoHotel PH = new PagoHotel();

            //  DATOS ORIGEN
            PH.setClExpediente(rs.getString("clExpediente"));

            PH.setClPaisO(rs.getString("clPaisReside"));
            PH.setDsPaisO(rs.getString("dsPaisReside"));
            PH.setCodEntO(rs.getString("CodEntReside"));
            PH.setDsEntFedO(rs.getString("dsEntFedReside"));
            PH.setCodMDO(rs.getString("CodMDReside"));
            PH.setDsMunDelO(rs.getString("dsMunDelReside"));

            PH.setFechaApertura(rs.getString("FechaApertura"));
            PH.setFechaRegistro(rs.getString("FechaRegistro"));
            PH.setClCausa(rs.getString("clCausaAsistencia"));
            PH.setDsCausa(rs.getString("dsCausaAsistencia"));
            PH.setTiempoReparacion(rs.getString("TiempoReparacion"));
            PH.setNomReserva(rs.getString("NomReserva"));
            PH.setFechaInicio(rs.getString("FechaIni"));
            PH.setFechaFin(rs.getString("FechaFin"));
            PH.setNoAdultos(rs.getString("NoAdultos"));
            PH.setNoMenores(rs.getString("NoMenores"));

            PH.setNumHabitacion(rs.getString("NumHabitacion"));
            PH.setNombreHotel(rs.getString("NombreHotel"));
            PH.setCostoxHab(rs.getString("CostoxHab"));
            PH.setClTipoHabitacion(rs.getString("clTipoHabitacion"));
            PH.setDsTipoHabitacion(rs.getString("dsTipoHabitacion"));
            PH.setHabReservadas(rs.getString("HabReservadas"));
            PH.setCostoCotizado(rs.getString("CostoCotizado"));
            PH.setCostoFinal(rs.getString("CostoFinal"));

            PH.setClPaisD(rs.getString("clPaisDest"));
            PH.setDsPaisD(rs.getString("dsPaisDest"));
            PH.setCodEntD(rs.getString("CodEntDest"));
            PH.setDsEntFedD(rs.getString("dsEntFedDest"));
            PH.setCodMDD(rs.getString("CodMDDest"));
            PH.setDsMunDelD(rs.getString("dsMunDelDest"));
            PH.setCalleD(rs.getString("CalleNumDest"));

            return PH;
        }
    }
}
