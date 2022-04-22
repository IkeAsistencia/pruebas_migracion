/*
 * DAOConciergeZona.java
 *
 * Created on 26 de agosto de 2008, 04:31 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ike.concierge;

import com.ike.concierge.to.ConciergeZona;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
/*
 *
 * @author rfernandez
 */
public class DAOConciergeZona extends com.ike.model.DAOBASE{
    
    /*
     * Creates a new instance of DAOConciergeZona
     */
    public DAOConciergeZona() 
    {
    }
    
     public ConciergeZona getConciergeZona (String clZona) throws DAOException
    {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        sb.append("st_CSNuevaZona ").append(clZona);
        
        col = this.rsSQLNP(sb.toString(), new ConciergeZonaFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (ConciergeZona) it.next() : null;        
    }
    
    public class ConciergeZonaFiller implements com.ike.model.LlenaDatos
    
    {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException
        {
            ConciergeZona CZ = new ConciergeZona();             
            
            //CZ.setclPais(rs.getString("clPais"));
            CZ.setDsPais(rs.getString("dsPais"));
            //CZ.setclZona(rs.getString("clZona")); 
            CZ.setDsZona(rs.getString("dsZona")); 
                                              
            return CZ;
        }
    }
} 
