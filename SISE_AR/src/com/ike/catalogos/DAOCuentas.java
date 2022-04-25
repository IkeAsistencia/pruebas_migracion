/*
 *
 *
 * Created on 15 de febrero de 2007, 11:48 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.catalogos;

import com.ike.catalogos.to.Cuentas;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author rurbina
 */
public class DAOCuentas extends com.ike.model.DAOBASE {

    public DAOCuentas() {
    }

    public Cuentas getCuentas(String clCuenta) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_getDetalleCuenta ").append(clCuenta);

        col = this.rsSQLNP(sb.toString(), new UsuariosFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (Cuentas) it.next() : null;
    }

    public class UsuariosFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            Cuentas CU = new Cuentas();

            CU.setClCuenta(rs.getString("clCuenta"));
            CU.setDsCuenta(rs.getString("dsCuenta"));
            CU.setNombre(rs.getString("Nombre"));
            CU.setCalle(rs.getString("Calle"));
            CU.setRFC(rs.getString("RFC"));
            CU.setDsMunDel(rs.getString("dsMunDel"));
            CU.setDsEntFed(rs.getString("dsEntFed"));
            CU.setCodEnt(rs.getString("CodEnt"));
            CU.setCodMD(rs.getString("CodMD"));
            CU.setCP(rs.getString("CP"));
            CU.setClTipoCuenta(rs.getString("clTipoCuenta"));
            CU.setDsTipoCuenta(rs.getString("dsTipoCuenta"));
            CU.setClSubTipoCuenta(rs.getString("clSubTipoCuenta"));
            CU.setDsSubTipoCuenta(rs.getString("dsSubTipoCuenta"));
            CU.setClEmpresaSEA(rs.getString("clEmpresaSEA"));
            CU.setDsEmpresaSEA(rs.getString("dsEmpresaSEA"));
            CU.setDsTipoClave(rs.getString("dsTipoClave"));
            CU.setClTipoClave(rs.getString("clTipoClave"));
            CU.setActivo(rs.getString("Activo"));
            CU.setFolio(rs.getString("Folio"));
            CU.setPrefijo(rs.getString("Prefijo"));
            CU.setClTipoValidacion(rs.getString("clTipoValidacion"));
            CU.setDsTipoValidacion(rs.getString("dsTipoValidacion"));
            CU.setClAseguradora(rs.getString("clAseguradora"));
            CU.setDsAseguradora(rs.getString("dsAseguradora"));
            CU.setDsGrupoCuenta(rs.getString("dsGrupoCuenta"));
            CU.setLada1(rs.getString("Lada1"));
            CU.setTel1(rs.getString("Tel1"));
            CU.setLada2(rs.getString("Lada2"));
            CU.setTel2(rs.getString("Tel2"));
            CU.setContacto(rs.getString("Contacto"));
            CU.setDsCanalDistribucion(rs.getString("dsCanalDistribucion"));
            CU.setClCanalDistribucion(rs.getString("clCanalDistribucion"));
            CU.setPermiteEnvioACobro(rs.getString("PermiteEnvioACobro"));
            CU.setBeneficiarios(rs.getString("Beneficiarios"));
            CU.setCuentaVIP(rs.getString("CuentaVIP"));
            CU.setRetencion(rs.getString("Retencion"));
            CU.setReclamo(rs.getString("Reclamo"));

            return CU;
        }
    }
}
