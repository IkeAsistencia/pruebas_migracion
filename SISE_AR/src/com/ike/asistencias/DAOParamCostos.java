
package com.ike.asistencias;


import com.ike.asistencias.to.ParamCostos;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/**
 *
 * @author J. Muriel
 */
public class DAOParamCostos extends com.ike.model.DAOBASE {

    public DAOParamCostos() {
    }

    public ParamCostos getParamC() throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_BuscaParametros");
        col = this.rsSQLNP(sb.toString(), new ParamFiller());
        

        Iterator it = col.iterator();
        return it.hasNext() ? (ParamCostos) it.next() : null;
    }

    public class ParamFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {

            ParamCostos ParamC = new ParamCostos();

            ParamC.setGestionCat(rs.getString("id"));
            ParamC.setGestionCat(rs.getString("GestionCat"));
            ParamC.setPorcentajeRec(rs.getString("PorcentajeRec"));
            ParamC.setUsuario(rs.getString("Usuario"));
            ParamC.setFechaCambio(rs.getString("fechaCambio"));


            return ParamC;
        }
    }
}