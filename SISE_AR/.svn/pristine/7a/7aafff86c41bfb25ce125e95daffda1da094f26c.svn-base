/*
 * DAOReferenciasxAsist.java
 *
 * Created on 4 de septiembre de 2008, 14:10
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ike.concierge;

import com.ike.concierge.to.ReferenciasxAsist;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author vsampablo
 */
public class DAOReferenciasxAsist  extends com.ike.model.DAOBASE {
    
    /* Creates a new instance of DAOReferenciasxAsist */
    public DAOReferenciasxAsist() {
    }
      public ReferenciasxAsist  getclAsistencia(String StrclAsistencia ) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_CSReferenciaxAsistencia ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new ReferenciasxAsistFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (ReferenciasxAsist ) it.next() : null;
    }
    
    
    public class ReferenciasxAsistFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            ReferenciasxAsist ref = new ReferenciasxAsist();
            ref.setReferencias(rs.getString("Referencias"));
            return ref;
        }
    }
    
}
