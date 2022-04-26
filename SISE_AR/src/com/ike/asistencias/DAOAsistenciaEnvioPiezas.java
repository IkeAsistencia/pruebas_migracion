/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias;

import com.ike.asistencias.to.AsistenciaEnvioPiezas;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author fcerqueda
 */
public class DAOAsistenciaEnvioPiezas extends com.ike.model.DAOBASE {

    public DAOAsistenciaEnvioPiezas() {
    }

    public AsistenciaEnvioPiezas getEnvioPiezas(String clExpediente) throws DAOException {

        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_getDetallEnvioPieza ").append(clExpediente);

        col = this.rsSQLNP(sb.toString(), new AsistenciaEnvioPiezasClass());

        Iterator i = col.iterator();
        return i.hasNext() ? (AsistenciaEnvioPiezas) i.next() : null;
    }

    public class AsistenciaEnvioPiezasClass implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            AsistenciaEnvioPiezas AE = new AsistenciaEnvioPiezas();

            AE.setclExpediente(rs.getString("clExpediente"));
            AE.setNuestroUsuario(rs.getString("NuestroUsuario"));
            AE.setClave(rs.getString("Clave"));
            AE.setFechaApertura(rs.getString("FechaApertura"));
            AE.setLada(rs.getString("Lada"));
            AE.setTelefono(rs.getString("Telefono"));
            AE.setEmail(rs.getString("Email"));
            AE.setclPais(rs.getString("clPais"));
            AE.setdsPais(rs.getString("dsPais"));
            AE.setCodEnt(rs.getString("CodEnt"));
            AE.setdsEntFed(rs.getString("dsEntFed"));
            AE.setCodMD(rs.getString("CodMD"));
            AE.setdsMunDel(rs.getString("dsMunDel"));
            AE.setComentarios(rs.getString("Comentarios"));
            AE.setInformacion(rs.getString("Informacion"));
            AE.setTipoPieza(rs.getString("TipoPieza"));
            AE.setTipoMaterial(rs.getString("TipoMaterial"));
            AE.setTipoenvio(rs.getString("TipoEnvio"));
            AE.setPeso(rs.getString("Peso"));
            AE.setDimensiones(rs.getString("Dimensiones"));

            return AE;
        }
    }
}
