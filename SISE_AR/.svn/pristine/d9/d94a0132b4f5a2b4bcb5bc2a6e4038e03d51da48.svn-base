/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias;

import com.ike.asistencias.to.ReemplazoDocumentos;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author rurbina
 */
public class DAOReemplazoDocumentos extends com.ike.model.DAOBASE {

    public DAOReemplazoDocumentos() {
    }

    public ReemplazoDocumentos getReemplazoDocumentos(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_DetalleReemplazoDoc ").append(clExpediente);

        col = this.rsSQLNP(sb.toString(), new Reemplazo());

        Iterator it = col.iterator();
        return it.hasNext() ? (ReemplazoDocumentos) it.next() : null;
    }

    public class Reemplazo implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            ReemplazoDocumentos RD = new ReemplazoDocumentos();

            RD.setClExpediente(rs.getString("clExpediente"));
            RD.setNombre(rs.getString("Nombre"));            
            RD.setDsParentesco(rs.getString("dsParentesco"));
            RD.setTipoDocumento1(rs.getString("TipoDocumento1"));
            RD.setTipoDocumento2(rs.getString("TipoDocumento2"));
            RD.setTipoDocumento3(rs.getString("TipoDocumento3"));
            RD.setTipoDocumento4(rs.getString("TipoDocumento4"));
            RD.setTipoDocumento5(rs.getString("TipoDocumento5"));
            RD.setNumero1(rs.getString("Numero1"));
            RD.setNumero2(rs.getString("Numero2"));
            RD.setNumero3(rs.getString("Numero3"));
            RD.setNumero4(rs.getString("Numero4"));
            RD.setNumero5(rs.getString("Numero5"));
            RD.setCostoTramite1(rs.getString("CostoTramite1"));
            RD.setCostoTramite2(rs.getString("CostoTramite2"));
            RD.setCostoTramite3(rs.getString("CostoTramite3"));
            RD.setCostoTramite4(rs.getString("CostoTramite4"));
            RD.setCostoTramite5(rs.getString("CostoTramite5"));
            RD.setObservaciones(rs.getString("Observaciones"));

            return RD;
        }
    }
}
