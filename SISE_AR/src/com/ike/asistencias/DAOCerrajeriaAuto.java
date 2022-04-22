/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias;

import com.ike.asistencias.to.CerrajeriaAuto;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author rurbina
 */
public class DAOCerrajeriaAuto extends com.ike.model.DAOBASE {

    public DAOCerrajeriaAuto() {
    }

    public CerrajeriaAuto getCerrajeriaAuto(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_getCerrajeriaAuto ").append(clExpediente);

        col = this.rsSQLNP(sb.toString(), new Cerrajeria());

        Iterator it = col.iterator();
        return it.hasNext() ? (CerrajeriaAuto) it.next() : null;
    }

    public class Cerrajeria implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CerrajeriaAuto CA = new CerrajeriaAuto();

            CA.setClExpediente(rs.getString("clExpediente"));
            CA.setCalleNum(rs.getString("CalleNum"));
            CA.setClaveAMIS(rs.getString("ClaveAMIS"));
            CA.setCodEntDest(rs.getString("CodEntDest"));
            CA.setDsEntFedDest(rs.getString("dsEntFedDest"));
            CA.setCodMDDest(rs.getString("CodMDDest"));
            CA.setDsMunDelDest(rs.getString("dsMunDelDest"));
            CA.setDsMarcaAuto(rs.getString("dsMarcaAuto"));
            CA.setDsTipoAuto(rs.getString("dsTipoAuto"));
            CA.setModelo(rs.getString("Modelo"));
            CA.setColor(rs.getString("Color"));
            CA.setPlacas(rs.getString("Placas"));
            CA.setDsLugarEvento(rs.getString("dsLugarEvento"));
            CA.setReferencias(rs.getString("Referencias"));

            return CA;
        }
    }
}
