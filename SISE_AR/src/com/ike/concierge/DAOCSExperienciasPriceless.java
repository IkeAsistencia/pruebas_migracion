/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.concierge;

import com.ike.concierge.to.CSExperienciasPriceless;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author fcerqueda
 */
public class DAOCSExperienciasPriceless extends com.ike.model.DAOBASE {

    public DAOCSExperienciasPriceless() {
    }

    public CSExperienciasPriceless getCSExperienciasPriceless(String StrclAsistencia) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_CSObtenExperienciasPriceless ").append(StrclAsistencia);

        col = this.rsSQLNP(sb.toString(), new CSExperienciasPricelessFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (CSExperienciasPriceless) it.next() : null;

    }

    public class CSExperienciasPricelessFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSExperienciasPriceless ExPri = new CSExperienciasPriceless();


            ExPri.setClAsistencia(rs.getString("clAsistencia"));
            ExPri.setClCSExpPriceless(rs.getString("clCSExpPriceless"));
            ExPri.setClExperiencia(rs.getString("clExperiencia"));
            ExPri.setDsEstatus(rs.getString("dsEstatus"));
            ExPri.setDescEvent(rs.getString("Descripcion"));
            ExPri.setFechaRegistro(rs.getString("FechaRegAsist"));
            ExPri.setDsExperiencia(rs.getString("dsExperiencia"));
            ExPri.setFechaE(rs.getString("FechaE"));
            ExPri.setNAdultos(rs.getString("NAdultos"));
            ExPri.setNinos(rs.getString("Ninos"));
            ExPri.setEdades(rs.getString("edades"));
            ExPri.setComentExp(rs.getString("comentExp"));
            ExPri.setClTipoBen(rs.getString("clTipoBen"));
            ExPri.setDsTipoBen(rs.getString("dsTipoBen"));
            ExPri.setClCiudadExp(rs.getString("clCiudadExp"));
            ExPri.setDsCiudadExp(rs.getString("dsCiudadExp"));
            ExPri.setLimiteLocalidades(rs.getString("limiteLocalidades"));
            ExPri.setWList(rs.getString("wList"));
            ExPri.setExpCancelada(rs.getString("expCancelada"));
            ExPri.setFechaExpCancelada(rs.getString("fechaExpCancelada"));
            ExPri.setClTipoPago(rs.getString("clTipoPago"));
            ExPri.setDsTipoPago(rs.getString("dsTipoPago"));
            ExPri.setNomBanco(rs.getString("NomBanco"));
            ExPri.setNombreTC(rs.getString("NombreTC"));
            ExPri.setNumeroTC(rs.getString("NumeroTC"));
            ExPri.setExpira(rs.getString("Expira"));
            ExPri.setSecC(rs.getString("SecC"));
            ExPri.setConfirmo(rs.getString("Confirmo"));
            ExPri.setNConfirmo(rs.getString("NConfirmo"));
            ExPri.setPCancel(rs.getString("PCancel"));
            ExPri.setNuInf(rs.getString("NuInf"));
            ExPri.setDomFiscal(rs.getString("DomFiscal"));

            return ExPri;
        }
    }
}
