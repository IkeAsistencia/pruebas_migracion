/*
 * DAOC_Compras.java
 * 
 * Created 2010-03-17
 * 
 */ 
 
package com.ike.Compras;
import com.ike.Compras.to.C_Compras;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
  
/*
 *
 * @autor vsampablo
 */
 public class DAOC_Compras extends com.ike.model.DAOBASE { 
  
    /* Creates a new instance of DAOC_Compras */ 
    public DAOC_Compras() { 
    } 
  
    public C_Compras getclCompra ( String clCompra ) throws DAOException { 
        StringBuffer sb = new StringBuffer(); 
        Collection col = null; 
        sb.append("st_C_Compras ").append(clCompra);  
        col = this.rsSQLNP(sb.toString(), new C_ComprasFiller());  
        Iterator it = col.iterator();  
        return it.hasNext() ? ( C_Compras) it.next() : null;
    } 
  
    /* Creates Filler of C_Compras */ 
    public class C_ComprasFiller implements com.ike.model.LlenaDatos { 
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException { 
            C_Compras CC = new C_Compras();
 
            CC.setclCompra(rs.getString("clCompra")); 
            CC.setclUsrAppRegistra(rs.getString("clUsrAppRegistra")); 
            CC.setUsrRegistra(rs.getString("UsrRegistra"));
            CC.setFechaRegistro(rs.getString("FechaRegistro")); 
            CC.setclEstatus(rs.getString("clEstatus")); 
            CC.setdsEstatus(rs.getString("dsEstatus")); 
            CC.setclAreaOperativa(rs.getString("clAreaOperativa")); 
            CC.setdsAreaOperativa(rs.getString("dsAreaOperativa")); 
            CC.setclPiso(rs.getString("clPiso")); 
            CC.setdsPiso(rs.getString("dsPiso")); 
            CC.setExtension(rs.getString("Extension")); 
            CC.setCorreo(rs.getString("Correo")); 
            CC.setDetalleCompra(rs.getString("DetalleCompra")); 
            CC.setAutFinanza(rs.getString("AutFinanza")); 
            CC.setclUsrAppAutFinanza(rs.getString("clUsrAppAutFinanza")); 
            CC.setUsrAutFinanza(rs.getString("UsrAutFinanza"));
            CC.setAutTI(rs.getString("AutTI")); 
            CC.setclUsrAppAutTI(rs.getString("clUsrAppAutTI"));
            CC.setUsrAutTI(rs.getString("UsrAutTI"));
            CC.setclUsrAppCancelacion(rs.getString("clUsrAppCancelacion")); 
            CC.setUsrCancelacion(rs.getString("UsrCancelacion"));
            CC.setMotivoCancelacion(rs.getString("MotivoCancelacion")); 
 
            return CC;
        } 
    } 
  
 } 
