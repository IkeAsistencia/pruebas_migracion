/*
 * DAOAltaNU2.java
 *
 * Created on 14 de abril de 2009, 11:51 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 *///package com.ike.operacion;
//
///*
// *
// * @author escobarm
// */
//public class DAOAltaNU2 {
//    
//    /* Creates a new instance of DAOAltaNU2 */
//    public DAOAltaNU2() {
//    }
//    
//}
//
package com.ike.operacion;

import com.ike.operacion.to.AltaNU;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author escobarm
 */
public class DAOAltaNU2 extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAODatosPaciente */
    public DAOAltaNU2() {
    }

    public AltaNU getAltaNU(String clLlamadaAlta) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;


        sb.append("sp_getLlamadaAltaNU ").append(clLlamadaAlta);


        col = this.rsSQLNP(sb.toString(), new AltaNUFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (AltaNU) it.next() : null;

    }

    public class AltaNUFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {

            AltaNU alta = new AltaNU();

            alta.setClAfiliado(rs.getString("ClAfiliado"));
            alta.setAnio(rs.getString("modelo"));
            alta.setCP(rs.getString("cp"));
            alta.setCalle(rs.getString("Calle"));
            alta.setClave(rs.getString("clave"));
            alta.setCodEnt(rs.getString("CodEnt"));
            alta.setCodMD(rs.getString("CodMD"));
            alta.setColonia(rs.getString("Colonia"));
            alta.setDescAuto(rs.getString("DescAuto"));
            alta.setDsEntFed(rs.getString("dsEntFed"));
            alta.setDsMunDel(rs.getString("dsMunDel"));
            alta.setEmpresa(rs.getString("Empresa"));
            alta.setFechaNac(rs.getString("FechaNac"));
            alta.setFolio(rs.getString("clLlamaAltaNU"));
            alta.setIdCliente(rs.getString("id_Cliente"));
            alta.setNombre(rs.getString("Nombre"));
            alta.setNombrecta(rs.getString("NombreC"));
            alta.setTelefono(rs.getString("Telefono"));
            alta.setClCuenta(rs.getString("clCuenta"));
            alta.setClLlamada(rs.getString("clLlamaAltaNU"));

            alta.setCodigoMarca(rs.getString("CodigoMarca"));
            alta.setDsMarcaAuto(rs.getString("DsMarcaAuto"));
            alta.setClTipoAuto(rs.getString("clTipoAuto"));
            alta.setDsTipoAuto(rs.getString("DsTipoAuto"));
            alta.setClaveAmis(rs.getString("ClaveAmis"));

            return alta;
        }
    }
}