/*
 * DAOModuloRedDescuentos.java
 *
 * Created on 30 de junio de 2008, 06:09 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.ike.asistencias;

import com.ike.asistencias.to.ModuloRedDescuentos;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author rfernandez
 */
public class DAOModuloRedDescuentos extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOModuloRedDescuentos */
    public DAOModuloRedDescuentos() {
    }

    public ModuloRedDescuentos getModuloRedDescuentos(String clModuloRedDescuentos) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_MReddeDescuentos ").append(clModuloRedDescuentos);

        col = this.rsSQLNP(sb.toString(), new ModuloRedDescuentosFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (ModuloRedDescuentos) it.next() : null;
    }

    public class ModuloRedDescuentosFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {

            ModuloRedDescuentos MRD = new ModuloRedDescuentos();

            MRD.setClModuloRedDescuentos(rs.getString("clModuloRedDescuentos"));
            MRD.setFechadeApertura(rs.getString("FechadeApertura"));
            MRD.setClCuenta(rs.getString("clCuenta"));
            MRD.setDsCuenta(rs.getString("dsCuenta"));
            MRD.setNombredelUsuario(rs.getString("NombredelUsuario"));
            MRD.setClave(rs.getString("Clave"));
            MRD.setTelefono(rs.getString("Telefono"));
            MRD.setCodEnt(rs.getString("CodEnt"));
            MRD.setDsEntFed(rs.getString("dsEntFed"));
            MRD.setCodMD(rs.getString("CodMD"));
            MRD.setDsMunDel(rs.getString("dsMunDel"));
            MRD.setInformacionSol(rs.getString("InformacionSol"));
            MRD.setClTipoDescuento(rs.getString("clTipoDescuento"));
            MRD.setDsTipoDescuento(rs.getString("dsTipoDescuento"));
            MRD.setClGiroRed(rs.getString("clGiroRed"));
            MRD.setDsGiroRed(rs.getString("dsGiroRed"));
            MRD.setClServicio(rs.getString("clServicio"));
            MRD.setDsServicio(rs.getString("dsServicio"));
            MRD.setClSubServicio(rs.getString("clSubServicio"));
            MRD.setDsSubServicio(rs.getString("dsSubServicio"));
            MRD.setClRedEstatus(rs.getString("clRedEstatus"));
            MRD.setDsRedEstatus(rs.getString("dsRedEstatus"));
            MRD.setObservaciones(rs.getString("Observaciones"));

            return MRD;
        }
    }
}
