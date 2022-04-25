/*
 * DAOMantenimientoSP.java
 * 
 * Created 2010-08-05
 * 
 */ 
 
package com.ike.helpdeskSP;
import com.ike.helpdeskSP.to.MantenimientoSP;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
  
/*
 *
 * @autor bsanchez
 */
 public class DAOMantenimientoSP extends com.ike.model.DAOBASE { 
  
    /* Creates a new instance of DAOMantenimientoSP */ 
    public DAOMantenimientoSP() { 
    } 
  
    public MantenimientoSP getclMantenimiento ( String clMantenimiento ) throws DAOException { 
        StringBuffer sb = new StringBuffer(); 
        Collection col = null; 
        sb.append("st_MantenimientoSP ").append(clMantenimiento);  
        col = this.rsSQLNP(sb.toString(), new MantenimientoSPFiller());  
        Iterator it = col.iterator();  
        return it.hasNext() ? ( MantenimientoSP) it.next() : null;
    } 
  
    /* Creates Filler of MantenimientoSP */ 
    public class MantenimientoSPFiller implements com.ike.model.LlenaDatos { 
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException { 
            MantenimientoSP MSP = new MantenimientoSP();
 
            MSP.setclMantenimiento(rs.getString("clMantenimiento")); 
            MSP.setclTipoPeriferico(rs.getString("clPeriferico"));           
            MSP.setMttoProg(rs.getString("MttoProg")); 
            MSP.setFolio(rs.getString("Folio")); 
            MSP.setRealizo(rs.getString("Realizo")); 
 
            return MSP;
        } 
    } 
  
 } 
