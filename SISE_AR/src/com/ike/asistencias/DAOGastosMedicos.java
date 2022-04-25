/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias;

import com.ike.asistencias.to.GastosMedicos;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author rurbina
 */
public class DAOGastosMedicos extends com.ike.model.DAOBASE {

    public DAOGastosMedicos() {
    }

    public GastosMedicos getGastosMedicos(String clExpediente) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_getGastosMedicos ").append(clExpediente);

        col = this.rsSQLNP(sb.toString(), new GastosM());

        Iterator it = col.iterator();
        return it.hasNext() ? (GastosMedicos) it.next() : null;
    }

    public class GastosM implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            GastosMedicos GM = new GastosMedicos();

            GM.setClExpediente(rs.getString("clExpediente"));
            GM.setClPais(rs.getString("clPais"));
            GM.setDsPais(rs.getString("dsPais"));
            GM.setCodEnt(rs.getString("CodEnt"));
            GM.setDsEntFed(rs.getString("dsEntFed"));
            GM.setCodMD(rs.getString("CodMD"));
            GM.setDsMunDel(rs.getString("dsMunDel"));
            GM.setFechaApertura(rs.getString("FechaApertura"));
            GM.setFechaRegistro(rs.getString("FechaRegistro"));
            GM.setNombrePaciente(rs.getString("NombrePaciente"));
            GM.setClParentesco(rs.getString("clParentesco"));
            GM.setDsParentesco(rs.getString("dsParentesco"));
            GM.setEdad(rs.getString("Edad"));
            GM.setClUbicacionPac(rs.getString("clUbicacion"));
            GM.setDsUbicacionPac(rs.getString("dsUbicacion"));
            GM.setNombreHotelHosp(rs.getString("NombreHotelHosp"));
            GM.setNumHabitacion(rs.getString("NumHabitacion"));
            GM.setCalle(rs.getString("calle"));
            GM.setTelHotelHosp(rs.getString("TelHotelHosp"));
            GM.setPadecimiento(rs.getString("Padecimiento"));
            GM.setMedico(rs.getString("Medico"));
            GM.setTelMedico1(rs.getString("TelMedico1"));
            GM.setTelMedico2(rs.getString("TelMedico2"));
            GM.setFechaIngreso(rs.getString("FechaIngreso"));
            GM.setDiagnostico(rs.getString("Diagnostico"));
            GM.setGastoEstimado(rs.getString("GastoEstimado"));
            GM.setCostoFinal(rs.getString("CostoFinal"));

            return GM;
        }
    }
}
