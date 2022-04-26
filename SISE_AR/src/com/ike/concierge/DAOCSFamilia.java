/*
 * DAOCSWow.java
 *
 * Created 2010-11-23
 *
 */

package com.ike.concierge;
import com.ike.concierge.ConciergeFamilia;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @autor rfernandez
 */

 public class DAOCSFamilia extends com.ike.model.DAOBASE{

    /* Creates a new instance of DAOCSWow */
    public DAOCSFamilia() {
    }
  
     public ConciergeFamilia getConciergeFamilia(String StrclEvento) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;


        sb.append("st_CSObtenDetalleFamilia ").append(StrclEvento);
        System.out.println(sb);

        col = this.rsSQLNP(sb.toString(), new CSFamiliaFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (ConciergeFamilia) it.next() : null;
    }
    
    
     public class CSFamiliaFiller implements com.ike.model.LlenaDatos{
         
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
                ConciergeFamilia CF = new ConciergeFamilia();               
                CF.setClEvento(rs.getString("clEvento"));
                CF.setClConcierge(rs.getString("clConcierge"));
                CF.setClGenero(rs.getString("clGenero"));
                CF.setDsGenero(rs.getString("dsGenero"));
                CF.setClParentesco(rs.getString("clParentesco"));
                CF.setDsParentesco(rs.getString("dsParentesco"));
                CF.setNombreFam(rs.getString("NombreFam"));
                CF.setFechaNac(rs.getString("FechaNac"));
                CF.setClCompFam(rs.getString("clCompFam"));
                
            return CF;
        }
    }
 }
