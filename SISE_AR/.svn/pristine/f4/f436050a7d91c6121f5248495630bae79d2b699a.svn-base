/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias;

import com.ike.asistencias.to.ReferenciaAdiestramiento;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author rurbina
 */
public class DAOReferenciaAdiestramiento extends com.ike.model.DAOBASE {

    public DAOReferenciaAdiestramiento() {
    }

    public ReferenciaAdiestramiento getReferenciaAdiestramiento(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_getReferenciaAdiestramiento ").append(clExpediente);

        col = this.rsSQLNP(sb.toString(), new AsistenciaVet());

        Iterator it = col.iterator();
        return it.hasNext() ? (ReferenciaAdiestramiento) it.next() : null;
    }

    public class AsistenciaVet implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            ReferenciaAdiestramiento RA = new ReferenciaAdiestramiento();

            RA.setClExpediente(rs.getString("clExpediente"));
            RA.setTelefono(rs.getString("Telefono"));
            RA.setCorreo(rs.getString("Correo"));
            RA.setCodEnt(rs.getString("CodEnt"));
            RA.setDsEntFed(rs.getString("DsEntFed"));
            RA.setCodMD(rs.getString("CodMD"));
            RA.setDsMunDel(rs.getString("DsMunDel"));
            RA.setLigaPro(rs.getString("LigaPro"));
            RA.setInformacionSol(rs.getString("InformacionSol"));
            RA.setInformacionPro(rs.getString("InformacionPro"));
            RA.setNombre(rs.getString("Nombre"));
            RA.setClMascotaRef(rs.getString("ClMascotaRef"));
            RA.setDsMascotaRef(rs.getString("DsMascotaRef"));
            RA.setClRTipoRecreacion(rs.getString("ClRTipoRecreacion"));
            RA.setDsRTipoRecreacion(rs.getString("DsRTipoRecreacion"));
            RA.setClSexo(rs.getString("ClSexo"));
            RA.setDsSexo(rs.getString("DsSexo"));
            RA.setPeso(rs.getString("Peso"));
            RA.setEdad(rs.getString("Edad"));

            return RA;
        }
    }
}
