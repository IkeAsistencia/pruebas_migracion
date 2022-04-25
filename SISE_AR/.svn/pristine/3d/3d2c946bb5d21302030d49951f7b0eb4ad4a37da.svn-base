/*
 * DAOConciergeCategoria.java
 *
 * Created on 26 de agosto de 2008, 04:17 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ike.concierge;

import com.ike.concierge.to.ConciergeCategoria;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
/*
 *
 * @author rfernandez
 */
public class DAOConciergeCategoria extends com.ike.model.DAOBASE{
    
    /*
     * Creates a new instance of DAOConciergeCategoria
     */
    public DAOConciergeCategoria() 
    {
    }
    
     public ConciergeCategoria getConciergeCategoria (String clCategoria) throws DAOException
    {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        sb.append("st_CSNuevaCategoria ").append(clCategoria);
        
        col = this.rsSQLNP(sb.toString(), new ConciergeCategoriaFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (ConciergeCategoria) it.next() : null;        
    }
    
    public class ConciergeCategoriaFiller implements com.ike.model.LlenaDatos
    
    {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException
        {
            ConciergeCategoria CS = new ConciergeCategoria();             
 
            CS.setclCategoria(rs.getString("clCategoria"));    
                                              
            return CS;
        }
    }
} 