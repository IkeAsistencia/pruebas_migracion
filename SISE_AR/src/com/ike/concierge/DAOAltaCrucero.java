/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ike.concierge;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import com.ike.concierge.to.CSAltaCrucero;

/*
 *
 * @author rfernandez
 */
public class DAOAltaCrucero extends com.ike.model.DAOBASE{

    public DAOAltaCrucero() {
    }

    public CSAltaCrucero getCSAltaCrucero(String StrclCrucero) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_CSDatosCrucero ").append(StrclCrucero);
        System.out.println(sb);
        col = this.rsSQLNP(sb.toString(), new CSAltaCruceroFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (CSAltaCrucero) it.next() : null;
    }
    public class CSAltaCruceroFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{

            CSAltaCrucero Crucero = new CSAltaCrucero();

            Crucero.setclAsistencia(rs.getString("clAsistencia"));
            Crucero.setclCrucero(rs.getString("clCrucero"));
            Crucero.setDia(rs.getString("Dia"));
            Crucero.setPuerto(rs.getString("Puerto"));
            Crucero.setArribo(rs.getString("Arribo"));
            Crucero.setSalida(rs.getString("Salida"));
            Crucero.setDescripcion(rs.getString("Descripcion"));

            return Crucero;
        }
    }
}