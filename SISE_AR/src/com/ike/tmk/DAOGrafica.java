/*
 * DAOGrafica.java
 *
 * Created on 9 de mayo de 2006, 05:37 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ike.tmk;

import com.ike.model.to.PermisoGrafica;
import java.sql.ResultSet;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOGrafica extends com.ike.model.DAOBASE {
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOGrafica() {
    }

    public PermisoGrafica getPermisoGrafica(String strPagina) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
      
            sb.append("st_ObtenPermisoGrafica ").append(strPagina);
        
        col = this.rsSQLNP(sb.toString(), new GraficaFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (PermisoGrafica) it.next() : null;
    }
    
    
    public class GraficaFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            PermisoGrafica permisografica = new com.ike.model.to.PermisoGrafica();
            permisografica.setPermiso(rs.getString("Grafica"));
            permisografica.setDsCampo(rs.getString("dsCampo").toString().trim());
            permisografica.setTipo(rs.getString("Tipo"));
            permisografica.setDsCampoCan(rs.getString("dsCampoValor"));
            return permisografica;
        }
    }
}

