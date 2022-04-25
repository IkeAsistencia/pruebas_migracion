/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ike.concierge;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import com.ike.concierge.to.CSPasajero;

/*
 *
 * @author rfernandez
 */
public class DAOCSPasajero extends com.ike.model.DAOBASE{

    public DAOCSPasajero() {
    }

    public CSPasajero getCSPasajero(String StrclPasajero) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_CSDatosPasajero ").append(StrclPasajero);
        System.out.println(sb);
        col = this.rsSQLNP(sb.toString(), new CSPasajeroFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (CSPasajero) it.next() : null;
    }
    public class CSPasajeroFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{

            CSPasajero Pasajero = new CSPasajero();

            Pasajero.setclAsistencia(rs.getString("clAsistencia"));
            Pasajero.setclPasajero(rs.getString("clPasajero"));
            Pasajero.setNombre(rs.getString("Nombre"));
            Pasajero.setEdad(rs.getString("Edad"));
            Pasajero.setTipoBoleto(rs.getString("TipoBoleto"));
            Pasajero.setClaveConf(rs.getString("ClaveConf"));
            Pasajero.setCosto(rs.getString("Costo"));

            return Pasajero;
        }
    }
}