/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ike.asistencias;

import com.ike.asistencias.to.AsistenciaTrasladosRemis;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author fcerqueda
 */
public class DAOAsistenciaTrasladosRemis extends com.ike.model.DAOBASE {

    public DAOAsistenciaTrasladosRemis() {
    }
    
    public AsistenciaTrasladosRemis getAsistenciaTrasladosRemis(String clExpediente) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        sb.append("st_getTraslados ").append(clExpediente);
        
        col = this.rsSQLNP(sb.toString(), new AsistTraslRemis());
        
        Iterator it = col.iterator();
        return  it.hasNext() ? (AsistenciaTrasladosRemis) it.next() : null ;
    }
    
    public class AsistTraslRemis implements com.ike.model.LlenaDatos{
        
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            
            AsistenciaTrasladosRemis ATR = new AsistenciaTrasladosRemis();
            
            
            ATR.setClExpediente(rs.getString("clExpediente"));
            ATR.setFechaApertura(rs.getString("FechaApertura"));
            ATR.setFechaRegistro(rs.getString("FechaRegistro"));
            ATR.setNumPasajeros(rs.getString("NumPasajeros"));
            ATR.setNumMaletas(rs.getString("NumMaletas"));
            ATR.setClPais(rs.getString("clPais"));
            ATR.setDsPais(rs.getString("dsPais"));
            ATR.setCodEnt(rs.getString("CodEnt"));
            ATR.setDsEntFed(rs.getString("dsEntFed"));
            ATR.setCodMD(rs.getString("CodMD"));
            ATR.setDsMunDel(rs.getString("dsMunDel"));
            ATR.setCalleNumActual(rs.getString("CalleNumActual"));
            ATR.setReferVisuales(rs.getString("ReferVisuales"));
            ATR.setTelUbicacion(rs.getString("TelUbicacion"));
            ATR.setTelCelular(rs.getString("TelCelular"));
            ATR.setCostoCotizacion(rs.getString("CostoCotizacion"));
            ATR.setCostoFinal(rs.getString("CostoFinal"));
            ATR.setClPaisResid(rs.getString("clPaisResid"));
            ATR.setDsPaisResid(rs.getString("dsPaisResid"));
            ATR.setCodEntResid(rs.getString("CodEntResid"));
            ATR.setDsEntFedResid(rs.getString("dsEntFedResid"));
            ATR.setCodMDResid(rs.getString("CodMDResid"));
            ATR.setDsMunDelResid(rs.getString("dsMunDelResid"));
            ATR.setColoniaResid(rs.getString("ColoniaResid"));
            ATR.setCalleNumResid(rs.getString("CalleNumResid"));

            return ATR;
        }
    
    }
}

