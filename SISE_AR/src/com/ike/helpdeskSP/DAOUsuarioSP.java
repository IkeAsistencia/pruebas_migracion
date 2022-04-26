/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.helpdeskSP;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author rfernandez
 */
public class DAOUsuarioSP extends com.ike.model.DAOBASE {

    /*
     * Creates a new instance of DAOConciergeSubCategoria
     */
    public DAOUsuarioSP() {
    }

    public UsuarioSP getUsuarioSP(String clUsrAppSP) throws DAOException {

        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_UsuarioSP ").append(clUsrAppSP);

        col = this.rsSQLNP(sb.toString(), new UsuarioSPFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (UsuarioSP) it.next() : null;
    }

    public class UsuarioSPFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            UsuarioSP USP = new UsuarioSP();

            USP.setclUsrAppSP(rs.getString("clUsrAppSP"));
            USP.setNombre(rs.getString("Nombre"));
            USP.setCorreo(rs.getString("Correo"));

            return USP;
        }
    }
}
