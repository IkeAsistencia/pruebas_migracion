/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias;

import com.ike.asistencias.to.DetalleALineaMarron;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author fcerqueda
 */
public class DAOALineaMarron extends com.ike.model.DAOBASE {

    public DAOALineaMarron() {
    }

    public DetalleALineaMarron getDetalleALineaMarron(String clExpediente) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_getDetalleLineaMarron ").append(clExpediente);

        col = this.rsSQLNP(sb.toString(), new DetalleALineaMarronFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (DetalleALineaMarron) it.next() : null;
    }

    public class DetalleALineaMarronFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            DetalleALineaMarron LM = new DetalleALineaMarron();

            LM.setClExpediente(rs.getString("clExpediente"));
            LM.setTipoElectrodomestico(rs.getString("tipoElectrodomestico"));
            LM.setDescripcionFalla(rs.getString("DescripcionFalla"));
            LM.setObservaciones(rs.getString("Observaciones"));
            LM.setEsProgramado(rs.getString("EsProgramado"));
            LM.setFechaProgMom(rs.getString("FechaProgMom"));
            LM.setClPais(rs.getString("clPais"));
            LM.setDsPais(rs.getString("dsPais"));
            LM.setCodEnt(rs.getString("CodEnt"));
            LM.setDsEntFed(rs.getString("dsEntFed"));
            LM.setCodMD(rs.getString("CodMD"));
            LM.setDsMunDel(rs.getString("dsMunDel"));
            LM.setReferencias(rs.getString("Referencias"));

            return LM;
        }
    }
}
