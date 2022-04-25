/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.operacion;

import com.ike.operacion.to.AltaNUAsatej;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author rurbina
 */
public class DAOAltaNUAsatej extends com.ike.model.DAOBASE {

    public DAOAltaNUAsatej() {
    }

    public AltaNUAsatej getAltaNUAsatej(String clAfiliado) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_getDetalleUsuarioAsatej ").append(clAfiliado);
        //System.out.println(sb);

        col = this.rsSQLNP(sb.toString(), new AltaNUAsatejFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (AltaNUAsatej) it.next() : null;
    }

    public class AltaNUAsatejFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            AltaNUAsatej AA = new AltaNUAsatej();

            AA.setClAfiliado(rs.getString("clAfiliado"));
            AA.setNombre(rs.getString("Nombre"));
            AA.setApellido(rs.getString("Apellido"));
            AA.setMail(rs.getString("Mail"));
            AA.setCodEnt(rs.getString("Codent"));
            AA.setDsEntFed(rs.getString("dsEntFed"));
            AA.setCodMD(rs.getString("CodMD"));
            AA.setDsMunDel(rs.getString("dsMunDel"));
            AA.setDireccion(rs.getString("Direccion"));
            AA.setCP(rs.getString("CP"));
            AA.setClTipoDocumento(rs.getString("clTipoDocumento"));
            AA.setDsTipoDocumento(rs.getString("dsTipoDocumento"));
            AA.setClave(rs.getString("Clave"));
            AA.setClCuenta(rs.getString("clCuenta"));
            AA.setNombreCuenta(rs.getString("NombreCuenta"));
            AA.setClTipoProducto(rs.getString("clTipoProducto"));
            AA.setDsTipoProducto(rs.getString("dsTipoProducto"));
            AA.setISIC(rs.getString("ISIC"));
            AA.setFechaIni(rs.getString("FechaIni"));
            AA.setFechaFin(rs.getString("FechaFin"));
            AA.setTelefono1(rs.getString("Telefono1"));
            AA.setTelefono2(rs.getString("Telefono2"));
            AA.setClPais(rs.getString("clPais"));
            AA.setDsPais(rs.getString("dsPais"));
            AA.setPrecioAsatej(rs.getString("PrecioAsatej"));
            AA.setPrecioPublico(rs.getString("PrecioPublico"));
            AA.setFechaAlta(rs.getString("FechaAlta"));
            AA.setFechaBaja(rs.getString("FechaBaja"));
            AA.setActivo(rs.getString("Activo"));
            AA.setFechaNac(rs.getString("FechaNac"));
            AA.setNombreContacto(rs.getString("NombreContacto"));

            return AA;
        }
    }
}
