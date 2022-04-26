/*
 * DAOInventarioSP.java
 *
 * Created on 28 de abril de 2009, 07:02 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.ike.helpdeskSP;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

public class DAOInventarioSP extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOInventarioSP */
    public DAOInventarioSP() {
    }

    public InventarioSP getCalificacionSP(String clUsrAppSP) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_UsuarioInventarioSP ").append(clUsrAppSP);

        col = this.rsSQLNP(sb.toString(), new InventarioSPFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (InventarioSP) it.next() : null;
    }

    public class InventarioSPFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            InventarioSP ISP = new InventarioSP();

            ISP.setclUsrAppSP(rs.getString("clUsrAppSP"));
            ISP.setclAreaOperativa(rs.getString("clAreaOperativa"));
            ISP.setdsAreaOperativa(rs.getString("dsAreaOperativa"));
            ISP.setclPiso(rs.getString("clPiso"));
            ISP.setdsPiso(rs.getString("dsPiso"));
            ISP.setUsuario(rs.getString("Usuario"));
            ISP.setNoEmpleado(rs.getString("NoEmpleado"));
            ISP.setextension(rs.getString("Extension"));
            ISP.setcorreo(rs.getString("Correo"));
            ISP.setestatus(rs.getString("Estatus"));
            ISP.setClEmpresa(rs.getString("clEmpresa"));
            ISP.setDsEmpresa(rs.getString("dsEmpresa"));
            return ISP;
        }
    }
}
