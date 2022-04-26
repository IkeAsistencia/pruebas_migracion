/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ike.Compras;
import com.ike.Compras.to.C_cProducto;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author atorres
 */
public class DAOC_cProducto extends com.ike.model.DAOBASE {

    public DAOC_cProducto(){
    }
    public C_cProducto getClProducto( String clProducto ) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_C_cProducto ").append(clProducto);
        col = this.rsSQLNP(sb.toString(), new cProductoFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? ( C_cProducto) it.next() : null;
    }

     public class cProductoFiller implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            C_cProducto CPR = new C_cProducto();
            CPR.setClProducto(rs.getString("clProducto"));
            CPR.setDsProducto(rs.getString("dsProducto"));
            CPR.setActivo(rs.getString("Activo"));
            return CPR;
        }
    }
}



