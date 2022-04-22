/*
 * DAOC_ProductoxCompra.java
 * 
 * Created 2010-03-23
 * 
 */ 
 
package com.ike.Compras;
import com.ike.Compras.to.C_ProductoxCompra;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
  
/*
 *
 * @autor vsampablo
 */
 public class DAOC_ProductoxCompra extends com.ike.model.DAOBASE { 
  
    /* Creates a new instance of DAOC_ProductoxCompra */ 
    public DAOC_ProductoxCompra() { 
    } 
  
    public C_ProductoxCompra getclProductoxCompra ( String clProductoxCompra ) throws DAOException { 
        StringBuffer sb = new StringBuffer(); 
        Collection col = null; 
        sb.append("st_C_ProductoxCompra '").append(clProductoxCompra).append("'");  
        col = this.rsSQLNP(sb.toString(), new C_ProductoxCompraFiller());  
        Iterator it = col.iterator();  
        return it.hasNext() ? ( C_ProductoxCompra) it.next() : null;
    } 
  
    /* Creates Filler of C_ProductoxCompra */ 
    public class C_ProductoxCompraFiller implements com.ike.model.LlenaDatos { 
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException { 
            C_ProductoxCompra PxC = new C_ProductoxCompra();
 
            PxC.setclProductoxCompra(rs.getString("clProductoxCompra")); 
            PxC.setclCompra(rs.getString("clCompra")); 
            PxC.setclProducto(rs.getString("clProducto")); 
            PxC.setdsProducto(rs.getString("dsProducto")); 
            PxC.setclProveedor(rs.getString("clProveedor")); 
            PxC.setNombre(rs.getString("Nombre")); 
            PxC.setCantidad(rs.getString("Cantidad")); 
            PxC.setValorUnitario(rs.getString("ValorUnitario")); 
            PxC.setIVA(rs.getString("IVA")); 
            PxC.setValorTotal(rs.getString("ValorTotal")); 
            PxC.setFormaPago(rs.getString("FormaPago"));
            PxC.setTiempoEntrega(rs.getString("TiempoEntrega"));
            PxC.setGarantia(rs.getString("Garantia"));
            PxC.setClTipoMoneda(rs.getString("clTipoMoneda"));
            PxC.setDsTipoMoneda(rs.getString("dsTipoMoneda"));
 
            return PxC;
        } 
    } 
  
 } 
