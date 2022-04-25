/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias;

import com.ike.asistencias.to.EnvioAlimento;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author rurbina
 */
public class DAOEnvioAlimento extends com.ike.model.DAOBASE {

    public DAOEnvioAlimento() {
    }

    public EnvioAlimento getEnvioAlimento(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_getEnvioAlimentos ").append(clExpediente);

        col = this.rsSQLNP(sb.toString(), new AsistenciaEnvioAlimento());

        Iterator it = col.iterator();
        return it.hasNext() ? (EnvioAlimento) it.next() : null;
    }

    public class AsistenciaEnvioAlimento implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            EnvioAlimento EA = new EnvioAlimento();

            EA.setClExpediente(rs.getString("clExpediente"));
            EA.setNombreMascota(rs.getString("NombreMascota"));
            EA.setEdad(rs.getString("Edad"));
            EA.setClTamano(rs.getString("clTamano"));
            EA.setDsTamano(rs.getString("dsTamano"));
            EA.setObservaciones(rs.getString("Observaciones"));
            EA.setCodEnt(rs.getString("CodEnt"));
            EA.setDsEntFed(rs.getString("dsEntFed"));
            EA.setCodMD(rs.getString("CodMD"));
            EA.setDsMunDel(rs.getString("dsMunDel"));
            EA.setDireccion(rs.getString("Direccion"));
            EA.setReferencias(rs.getString("Referencias"));
            EA.setCosto(rs.getString("Costo"));
            EA.setCostoFinal(rs.getString("CostoFinal"));
            EA.setNombre(rs.getString("Nombre"));
            EA.setTelefono(rs.getString("Telefono"));
            EA.setVehiculo(rs.getString("Vehiculo"));
            EA.setNoMovil(rs.getString("NoMovil"));
            EA.setPatente(rs.getString("Patente"));
            return EA;
        }
    }
}
