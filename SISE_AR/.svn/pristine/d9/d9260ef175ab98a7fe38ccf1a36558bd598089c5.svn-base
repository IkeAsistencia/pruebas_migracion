/*
 * DAOTelemarketing.java
 *
 * Created on 30 de marzo de 2006, 04:37 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.model;

//import com.ike.operacion.*;
import java.sql.ResultSet;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.to.registrosantander;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOSantanderR extends com.ike.model.DAOBASE {
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOSantanderR() {
    }

    public registrosantander getRegistroS( String strCuenta,String strClave) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
      
            sb.append("sp_ObtenRegistroSerfin ").append(strCuenta).append(",'").append(strClave).append("'");
            System.out.println(sb.toString());
        col = this.rsSQLNP(sb.toString(), new SantanderFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (registrosantander) it.next() : null;
    }
    
    
    public class SantanderFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            registrosantander registrosantanderG = new com.ike.model.to.registrosantander();
            registrosantanderG.setClave(rs.getString("Clave"));
            registrosantanderG.setNombre(rs.getString("Nombre"));
            registrosantanderG.setFechIni(rs.getString("FechaIni"));
            registrosantanderG.setFechFin(rs.getString("FechaFin"));
            registrosantanderG.setCuenta(rs.getString("clcuenta"));
            registrosantanderG.setNomCuenta(rs.getString("NomCuenta"));
            return registrosantanderG;
        }
    }
}
