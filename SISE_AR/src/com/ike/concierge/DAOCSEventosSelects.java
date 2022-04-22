/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.concierge;

import com.ike.concierge.to.CSEventosSelects;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author fcerqueda
 */
public class DAOCSEventosSelects extends com.ike.model.DAOBASE {

    public DAOCSEventosSelects() {
    }

    public CSEventosSelects getCSEventosSelects(String StrclAsistencia) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_CSObtenEventosSelects ").append(StrclAsistencia);

        col = this.rsSQLNP(sb.toString(), new CSEventosSelectsFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (CSEventosSelects) it.next() : null;

    }

    public class CSEventosSelectsFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSEventosSelects EvSel = new CSEventosSelects();


            EvSel.setClAsistencia(rs.getString("clAsistencia"));
            EvSel.setClCSEventoSelect(rs.getString("clCSEventoSelect"));
            EvSel.setClEventoSelect(rs.getString("clEventoSelect"));
            EvSel.setDsEstatus(rs.getString("dsEstatus"));
            EvSel.setDescEvent(rs.getString("Descripcion"));
            EvSel.setFechaRegistro(rs.getString("FechaRegAsist"));
            EvSel.setDsEventoSelect(rs.getString("dsEventoSelect"));
            EvSel.setFechaE(rs.getString("FechaE"));
            EvSel.setNAdultos(rs.getString("NAdultos"));
            EvSel.setNinos(rs.getString("Ninos"));
            EvSel.setEdades(rs.getString("edades"));
            EvSel.setComentExp(rs.getString("comentExp"));
            EvSel.setClTipoBen(rs.getString("clTipoBen"));
            EvSel.setDsTipoBen(rs.getString("dsTipoBen"));
            EvSel.setClCiudadEveSel(rs.getString("clCiudadEveSel"));
            EvSel.setDsCiudadEveSel(rs.getString("dsCiudadEveSel"));
            EvSel.setLimiteLocalidades(rs.getString("limiteLocalidades"));
            EvSel.setWList(rs.getString("wList"));
            EvSel.setExpCancelada(rs.getString("expCancelada"));
            EvSel.setFechaExpCancelada(rs.getString("fechaExpCancelada"));
            EvSel.setClTipoPago(rs.getString("clTipoPago"));
            EvSel.setDsTipoPago(rs.getString("dsTipoPago"));
            EvSel.setNomBanco(rs.getString("NomBanco"));
            EvSel.setNombreTC(rs.getString("NombreTC"));
            EvSel.setNumeroTC(rs.getString("NumeroTC"));
            EvSel.setExpira(rs.getString("Expira"));
            EvSel.setSecC(rs.getString("SecC"));
            EvSel.setConfirmo(rs.getString("Confirmo"));
            EvSel.setNConfirmo(rs.getString("NConfirmo"));
            EvSel.setPCancel(rs.getString("PCancel"));
            EvSel.setNuInf(rs.getString("NuInf"));
            EvSel.setDomFiscal(rs.getString("DomFiscal"));

            return EvSel;
        }
    }
}
