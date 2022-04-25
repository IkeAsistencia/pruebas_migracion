/*
 * DAOConciergeSubCategoria.java
 *
 * Created on 26 de agosto de 2008, 04:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ike.concierge;

import com.ike.concierge.to.ConciergeSubCategoria;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author rfernandez
 */

public class DAOConciergeSubCategoria extends com.ike.model.DAOBASE{
    
    /*
     * Creates a new instance of DAOConciergeSubCategoria
     */
    public DAOConciergeSubCategoria() 
    {
    }
    
 public ConciergeSubCategoria getConciergeSubCategoria (String clSubCategoria) throws DAOException
    {
     
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        sb.append("st_CSNuevaSubCategoria ").append(clSubCategoria);
        
        col = this.rsSQLNP(sb.toString(), new ConciergeSubCategoriaFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (ConciergeSubCategoria) it.next() : null;        
    }
     
    public class ConciergeSubCategoriaFiller implements com.ike.model.LlenaDatos
    
    {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException
        {
            ConciergeSubCategoria CSC = new ConciergeSubCategoria();   
            
            CSC.setclCategoria(rs.getString("clCategoria"));
            CSC.setdsCategoria(rs.getString("dsCategoria"));
            CSC.setclSubCategoria(rs.getString("clSubCategoria"));
            CSC.setdsSubCategoria(rs.getString("dsSubCategoria"));
                                              
            return CSC;
        }
    }
} 