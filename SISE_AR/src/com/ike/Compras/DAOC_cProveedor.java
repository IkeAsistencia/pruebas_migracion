/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ike.Compras;
import com.ike.Compras.to.C_cProveedor;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
/*
 *
 * @author atorres
 */
public class DAOC_cProveedor extends com.ike.model.DAOBASE{
    public DAOC_cProveedor(){
    }
    public C_cProveedor getClProveedor( String clProveedor ) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_C_cProveedor ").append(clProveedor);
        col = this.rsSQLNP(sb.toString(), new cProveedorFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? ( C_cProveedor) it.next() : null;
    }

     public class cProveedorFiller implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            C_cProveedor CP = new C_cProveedor();
            CP.setClProveedor(rs.getString("clProveedor"));
            CP.setNombre(rs.getString("Nombre"));
            CP.setTelefono1(rs.getString("Telefono1"));
            CP.setTelefono2(rs.getString("Telefono2"));
            CP.setContacto(rs.getString("Contacto"));
            CP.setNit(rs.getString("Nit"));
            CP.setActivo(rs.getString("Activo"));
            return CP;
        }
    }
}
