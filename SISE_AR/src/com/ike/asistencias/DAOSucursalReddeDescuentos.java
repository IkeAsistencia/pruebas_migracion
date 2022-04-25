/*
 * DAOSucursalReddeDescuentos.java
 *
 * Created on 14 de MAYO de 2008, 16:30 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor
 */
package com.ike.asistencias;

import com.ike.asistencias.to.SucursalReddeDescuentos;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author rfernandez
 */
public class DAOSucursalReddeDescuentos extends com.ike.model.DAOBASE {

    /*
     * Creates a new instance of DAOSucursalReddeDescuentos
     */
    public DAOSucursalReddeDescuentos() {
    }

    public SucursalReddeDescuentos getSucursalReddeDescuentos(String clSucursalReddeDescuentos) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_SucursalReddeDescuentos ").append(clSucursalReddeDescuentos);

        col = this.rsSQLNP(sb.toString(), new SucursalReddeDescuentosFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (SucursalReddeDescuentos) it.next() : null;
    }

    public class SucursalReddeDescuentosFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            SucursalReddeDescuentos SuRe = new SucursalReddeDescuentos();

            SuRe.setClSucursalReddeDescuentos(rs.getString("clSucursalReddeDescuentos"));
            SuRe.setContacto(rs.getString("Contacto"));
            SuRe.setSucursal(rs.getString("Sucursal"));
            SuRe.setCodEnt(rs.getString("CodEnt"));
            SuRe.setDsEntFed(rs.getString("dsEntFed"));
            SuRe.setCodMD(rs.getString("CodMD"));
            SuRe.setDsMunDel(rs.getString("dsMunDel"));
            SuRe.setCalle(rs.getString("Calle"));
            SuRe.setCodigoPostal(rs.getString("CodigoPostal"));
            SuRe.setTelefono1(rs.getString("Telefono1"));
            SuRe.setTelefono2(rs.getString("Telefono2"));

            return SuRe;
        }
    }
}
