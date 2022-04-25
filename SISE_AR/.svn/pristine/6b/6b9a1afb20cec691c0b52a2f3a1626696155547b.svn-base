/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.catalogos;

import com.ike.catalogos.to.CostoxProveedor;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

public class DAOCostoxProveedor extends com.ike.model.DAOBASE {

    public DAOCostoxProveedor() {
    }

    public CostoxProveedor getCostoxProveedor(String StrclCostoxProvxSubserv) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_getCostoxProveedor '").append(StrclCostoxProvxSubserv).append("'");

        col = this.rsSQLNP(sb.toString(), new Costos());

        Iterator it = col.iterator();
        return it.hasNext() ? (CostoxProveedor) it.next() : null;
    }

    public class Costos implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CostoxProveedor CP = new CostoxProveedor();

            CP.setClCostoXProvXSubserv(rs.getString("clCostoXProvXSubserv"));
            CP.setClProveedor(rs.getString("clProveedor"));
            CP.setNombreOpe(rs.getString("NombreOpe"));
            CP.setClServicio(rs.getString("clServicio"));
            CP.setDsServicio(rs.getString("dsServicio"));
            CP.setClSubServicio(rs.getString("clSubServicio"));
            CP.setDsSubservicio(rs.getString("dsSubservicio"));
            CP.setClConcepto(rs.getString("clConcepto"));
            CP.setDsConcepto(rs.getString("dsConcepto"));
            CP.setCosto(rs.getString("Costo"));
            CP.setFechaActualiza(rs.getString("FechaActualiza"));
            return CP;
        }
    }
}