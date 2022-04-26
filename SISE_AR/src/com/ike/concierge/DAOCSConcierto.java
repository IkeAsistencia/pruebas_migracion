/*
 * DAOCSConcierto.java
 * 
 * Created 2010-09-14
 * 
 */ 
 
package com.ike.concierge;
import com.ike.concierge.to.CSConcierto;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
  
/*
 *
 * @autor rfernandez
 */
 public class DAOCSConcierto extends com.ike.model.DAOBASE { 
  
    /* Creates a new instance of DAOCSConcierto */ 
    public DAOCSConcierto() { 
    } 
  
    public CSConcierto getclConcierto ( String clConcierto ) throws DAOException { 
        StringBuffer sb = new StringBuffer(); 
        Collection col = null; 
        sb.append("st_CSConcierto ").append(clConcierto);  
        col = this.rsSQLNP(sb.toString(), new CSConciertoFiller());  
        Iterator it = col.iterator();  
        return it.hasNext() ? ( CSConcierto) it.next() : null;
    } 
  
    /* Creates Filler of CSConcierto */ 
    public class CSConciertoFiller implements com.ike.model.LlenaDatos { 
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException { 
            CSConcierto CSC = new CSConcierto();
 
            CSC.setclConcierto(rs.getString("clConcierto")); 
            CSC.setdsConcierto(rs.getString("dsConcierto")); 
            CSC.setActivo(rs.getString("Activo"));
            CSC.setclUsrAppAut1(rs.getString("clUsrAppAut1")); 
            CSC.setclUsrAppAut2(rs.getString("clUsrAppAut2"));

            return CSC;
        } 
    } 
  
 } 
