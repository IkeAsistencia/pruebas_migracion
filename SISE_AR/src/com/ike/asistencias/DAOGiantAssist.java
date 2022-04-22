/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias;

import com.ike.asistencias.to.GiantAssist;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

public class DAOGiantAssist extends com.ike.model.DAOBASE {

    public DAOGiantAssist() {
    }
    
    public GiantAssist getGiantAssist(String clExpediente) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        sb.append("st_getGiantAssist '").append(clExpediente).append("'");
        System.out.println(sb.toString());
        col = this.rsSQLNP(sb.toString(), new GiantAsis());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (GiantAssist) it.next() : null;
    } 
    
    public class GiantAsis implements com.ike.model.LlenaDatos{
        
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            
            GiantAssist GA = new GiantAssist();
            
            GA.setClExpediente(rs.getString("clExpediente"));
            GA.setClPais(rs.getString("clPais"));
            GA.setDsPais(rs.getString("dsPais"));
            GA.setCodEnt(rs.getString("CodEnt"));
            GA.setDsEntFed(rs.getString("dsEntFed")); 
            GA.setCodMD(rs.getString("CodMD"));
            GA.setDsMunDel(rs.getString("dsMunDel"));
            GA.setCalleNum(rs.getString("CalleNum")); 
            GA.setReferenciasVisuales(rs.getString("referenciasVisuales"));
            GA.setClTipoBici(rs.getString("clTipoBici"));
            GA.setDsTipoBici(rs.getString("dsTipoBici"));
            GA.setClTipoReparacionB(rs.getString("clTipoReparacionB"));
            GA.setTipoReparacionB(rs.getString("tipoReparacionB")); 
            GA.setObservaciones(rs.getString("observaciones"));
            
            return GA;
        }
    }
}








