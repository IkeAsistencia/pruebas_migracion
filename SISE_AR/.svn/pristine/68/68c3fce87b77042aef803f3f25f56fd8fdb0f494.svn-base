/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias;

/*
 *
 * @author fcerqueda
 */
import com.ike.asistencias.to.Internacion;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

public class DAOInternacion extends com.ike.model.DAOBASE {

    public DAOInternacion() {
    }

    public Internacion getInternacion(String clExpediente) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_getInternacion ").append(clExpediente);

        col = this.rsSQLNP(sb.toString(), new AsisInternacion());

        Iterator it = col.iterator();
        return it.hasNext() ? (Internacion) it.next() : null;
    }

    public class AsisInternacion implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            Internacion I = new Internacion();

            I.setClExpediente(rs.getString("clExpediente"));
            I.setClCuenta(rs.getString("clCuenta"));
            I.setDsCuenta(rs.getString("dsCuenta"));
            I.setNombredelUsuario(rs.getString("NombredelUsuario"));
            I.setClave(rs.getString("Clave"));
            I.setFechadeApertura(rs.getString("FechadeApertura"));
            I.setTelefono(rs.getString("Telefono"));
            I.setCorreo(rs.getString("Correo"));
            I.setLigaPro(rs.getString("LigaPro"));
            I.setInformacionSol(rs.getString("InformacionSol"));
            I.setInformacionPro(rs.getString("InformacionPro"));
            I.setClPais(rs.getString("clPais"));
            I.setDsPais(rs.getString("dsPais"));
            I.setCodEnt(rs.getString("CodEnt"));
            I.setDsEntfed(rs.getString("dsEntfed"));
            I.setCodMD(rs.getString("CodMD"));
            I.setDsMunDel(rs.getString("dsMunDel"));

            return I;
        }
    }
}
