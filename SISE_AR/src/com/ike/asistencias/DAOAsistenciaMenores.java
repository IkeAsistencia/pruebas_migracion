/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias;

import com.ike.asistencias.to.AsistenciaMenores;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author rurbina
 */
public class DAOAsistenciaMenores extends com.ike.model.DAOBASE {

    public DAOAsistenciaMenores() {
    }

    public AsistenciaMenores getAsistenciaMenores(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_getDetalleAMenores ").append(clExpediente);
        //System.out.println("query: " + sb);
        col = this.rsSQLNP(sb.toString(), new Menores());

        Iterator it = col.iterator();
        return it.hasNext() ? (AsistenciaMenores) it.next() : null;
    }

    public class Menores implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            AsistenciaMenores AM = new AsistenciaMenores();
            //System.out.println("entra1");
            AM.setClExpediente(rs.getString("clExpediente"));
            AM.setNombre(rs.getString("Nombre"));
            AM.setEdad(rs.getString("Edad"));
            AM.setDsParentesco(rs.getString("dsParentesco"));
            AM.setDsPais(rs.getString("dsPais"));
            AM.setDireccion(rs.getString("Direccion"));
            AM.setObservaciones(rs.getString("Observaciones"));

            return AM;
        }
    }
}
