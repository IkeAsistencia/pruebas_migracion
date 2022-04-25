/*
 * DAORetencion.java
 *
 * Created on 27 de febrero de 2009, 05:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package Validacion;

import Validacion.to.PermisosExp;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author escobarm
 */
public class DAOExpPermisos extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAODatosPaciente */
    public DAOExpPermisos() {
    }

    public PermisosExp getPermisosExp(String clUsrApp) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append(" st_getPermisosExp ").append(clUsrApp);

        //System.out.println("Entra DAO PermisosExp: "+sb.toString());

        col = this.rsSQLNP(sb.toString(), new PermisosExpFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (PermisosExp) it.next() : null;
    }

    public class PermisosExpFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {

            PermisosExp per = new PermisosExp();

            per.setPermiteCobertura(rs.getInt("PermiteCobertura"));
            per.setPermiteCotizar(rs.getInt("PermiteCotizar"));
            per.setPermiteDuplicar(rs.getInt("PermiteDuplicar"));
            per.setPermiteMarcaCita(rs.getInt("PermiteMarcarCita"));
            per.setPermiteSMS(rs.getInt("PermiteSMS"));

            return per;
        }
    }
}
