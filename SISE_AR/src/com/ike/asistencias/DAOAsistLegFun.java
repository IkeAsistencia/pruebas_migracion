/*
 * DAOAsistLegFun.java
 *
 * Created on 31 de Julio de 2006, 09:59 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.asistencias;
import java.sql.ResultSet;
import java.util.Collection;
import java.util.Iterator;
import com.ike.asistencias.to.LegFun;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOAsistLegFun extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOAsistLegFun() {
    }

    public LegFun getLegfun(String StrclExpediente) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
      
        sb.append("st_AsistLegFun ").append(StrclExpediente);
        col = this.rsSQLNP(sb.toString(), new LegFunFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (LegFun) it.next() : null;
    }
    
    
    public class LegFunFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
             LegFun legfun = new LegFun();

            legfun.setClExpediente(rs.getString("clExpediente"));
            legfun.setPersonaReporta(rs.getString("PersonaReporta"));
            legfun.setUsuario(rs.getString("Usuario"));
            legfun.setParentesco(rs.getString("Parentesco"));
            legfun.setTelconU(rs.getString("TelconU"));
            legfun.setTelMovil(rs.getString("TelMovil"));
            legfun.setPoliza(rs.getString("Poliza"));
            legfun.setCodEntU(rs.getString("CodEntU"));
            legfun.setDsEntfed(rs.getString("dsEntfed"));
            legfun.setCodMDU(rs.getString("CodMDU"));
            legfun.setDsMunDel(rs.getString("dsMunDel"));
            legfun.setColoniaU(rs.getString("ColoniaU"));
            legfun.setCalleU(rs.getString("CalleU"));
            legfun.setReferenciasU(rs.getString("ReferenciasU"));
            legfun.setCodEntF(rs.getString("CodEntF"));
            legfun.setDsEntfedF(rs.getString("dsEntfedF"));
            legfun.setCodMDF(rs.getString("CodMDF"));
            legfun.setDsMunDelF(rs.getString("dsMunDelF"));
            legfun.setFechaF(rs.getString("FechaF"));
            legfun.setCausaMuerte(rs.getString("CausaMuerte"));
            legfun.setDsCausaMuerte(rs.getString("dsCausaMuerte"));
            legfun.setLugarMuerte(rs.getString("LugarMuerte"));
            legfun.setDsLugarFallecimiento(rs.getString("dsLugarFallecimiento"));
            legfun.setPersonaCargo(rs.getString("PersonaCargo"));
            legfun.setTelcontacto(rs.getString("Telcontacto"));
            legfun.setAveriguacion(rs.getString("Averiguacion"));
            legfun.setMinisterioP(rs.getString("MinisterioP"));
            legfun.setCertificadoD(rs.getString("CertificadoD"));
            legfun.setActaD(rs.getString("ActaD"));
            legfun.setDispensaN(rs.getString("DispensaN"));
            legfun.setTrasladoC(rs.getString("TrasladoC"));
            legfun.setTramitesF(rs.getString("TramitesF"));
            legfun.setDemandaR(rs.getString("DemandaR"));
            legfun.setAcreedoresL(rs.getString("AcreedoresL"));
            legfun.setCuerpoM(rs.getString("CuerpoM"));
            legfun.setMedicoF(rs.getString("MedicoF"));
            legfun.setClConcluyeAsistencia(rs.getString("clConcluyeAsistencia"));
            legfun.setOtro(rs.getString("Otro"));
            legfun.setCual(rs.getString("Cual"));
            legfun.setDsConcluyeAsistencia(rs.getString("dsConcluyeAsistencia"));
            legfun.setObservacionesFin(rs.getString("ObservacionesFin"));
            return legfun;
        }
    }
}
