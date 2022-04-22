/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias;

import com.ike.asistencias.to.AsistenciaVeterinaria;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author rurbina
 */
public class DAOGuarderiaMascota extends com.ike.model.DAOBASE {

    public DAOGuarderiaMascota() {
    }

    public AsistenciaVeterinaria getAsistenciaVeterinaria(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_getGuarderiaMascota ").append(clExpediente);

        col = this.rsSQLNP(sb.toString(), new AsistenciaVet());

        Iterator it = col.iterator();
        return it.hasNext() ? (AsistenciaVeterinaria) it.next() : null;
    }

    public class AsistenciaVet implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            AsistenciaVeterinaria AV = new AsistenciaVeterinaria();

            AV.setClExpediente(rs.getString("clExpediente"));
            AV.setNombreMascota(rs.getString("NombreMascota"));
            AV.setEdad(rs.getString("Edad"));
            AV.setPeso(rs.getString("Peso"));
            AV.setRaza(rs.getString("Raza"));
            AV.setClTipoMascota(rs.getString("clTipoMascota"));
            AV.setDsTipoMascota(rs.getString("dsTipoMascota"));
            AV.setDireccion(rs.getString("Direccion"));
            AV.setFechaEntrada(rs.getString("FechaEntrada"));
            AV.setFechaSalida(rs.getString("FechaSalida"));
            AV.setRecomendacionVet(rs.getString("Recomendacion"));
            AV.setObservaciones(rs.getString("Observaciones"));

            return AV;
        }
    }
}
