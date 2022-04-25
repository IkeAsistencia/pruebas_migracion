/*
 * DAOTelemarketing.java
 *
 * Created on 30 de marzo de 2006, 04:37 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.tmk;

import java.sql.ResultSet;
import java.util.Collection;
import java.util.Iterator;
import com.ike.tmk.Llamada;
import com.ike.model.DAOException;

/*
 *
 * @author cabrerar
 */
public class DAOTelemarketing extends com.ike.model.DAOBASETMK {
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOTelemarketing() {
    }

    public Llamada getLlamada(String strcllamada, String strclUsrApp) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
         if (strcllamada.compareToIgnoreCase("0")==0){
          // Obtiene un nuevo registro
            sb.append("sp_ObtenAfiliadoTMKWeb ").append(strclUsrApp).append(",1");
         }
         else{
            sb.append("sp_ObtenAfiliadoPrevTMKWeb ").append(strcllamada);
         }
        
        col = this.rsSQLNP(sb.toString(), new LlamadaFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (Llamada) it.next() : null;
    }
    
    public class LlamadaFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Llamada llamada = new Llamada();
            return llamada;
        }
    }
}
