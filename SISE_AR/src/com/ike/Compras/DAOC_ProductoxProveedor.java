/*
 * DAOC_ProductoxProveedor.java
 * 
 * Created 2010-03-26
 * 
 */ 
 
package com.ike.Compras;
import com.ike.Compras.to.C_ProductoxProveedor;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
  
/*
 *
 * @autor vsampablo
 */
 public class DAOC_ProductoxProveedor extends com.ike.model.DAOBASE { 
  
    /* Creates a new instance of DAOC_ProductoxProveedor */ 
    public DAOC_ProductoxProveedor() { 
    } 
  
    public C_ProductoxProveedor getclProductoxProveedor ( String clProductoxProveedor ) throws DAOException { 
        StringBuffer sb = new StringBuffer(); 
        Collection col = null; 
        sb.append("st_C_ProductoxProveedor ").append(clProductoxProveedor);  
        col = this.rsSQLNP(sb.toString(), new C_ProductoxProveedorFiller());  
        Iterator it = col.iterator();  
        return it.hasNext() ? ( C_ProductoxProveedor) it.next() : null;
    } 
  
    /* Creates Filler of C_ProductoxProveedor */ 
    public class C_ProductoxProveedorFiller implements com.ike.model.LlenaDatos { 
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException { 
            C_ProductoxProveedor PXP = new C_ProductoxProveedor();
 
            PXP.setclProductoxProveedor(rs.getString("clProductoxProveedor")); 
            PXP.setclProveedor(rs.getString("clProveedor")); 
            PXP.setNombre(rs.getString("Nombre")); 
            PXP.setclProducto(rs.getString("clProducto")); 
            PXP.setdsProducto(rs.getString("dsProducto")); 
 
            return PXP;
        } 
    } 
  
 } 
