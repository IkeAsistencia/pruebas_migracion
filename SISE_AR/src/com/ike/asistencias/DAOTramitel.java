/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias;

import com.ike.asistencias.to.Tramitel;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author fcerqueda
 */
public class DAOTramitel extends com.ike.model.DAOBASE {

    public DAOTramitel() {
    }

    public Tramitel getTramitel(String clExpediente) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_getTramitel ").append(clExpediente);

        col = this.rsSQLNP(sb.toString(), new AsisTramitel());

        Iterator it = col.iterator();
        return it.hasNext() ? (Tramitel) it.next() : null;
    }

    public class AsisTramitel implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            Tramitel TM = new Tramitel();

            TM.setClExpediente(rs.getString("clExpediente"));
            TM.setClCuenta(rs.getString("clCuenta"));
            TM.setDsCuenta(rs.getString("dsCuenta"));
            TM.setNombredelUsuario(rs.getString("NombredelUsuario"));
            TM.setClave(rs.getString("Clave"));
            TM.setFechadeApertura(rs.getString("FechadeApertura"));
            TM.setTelefono(rs.getString("Telefono"));
            TM.setCorreo(rs.getString("Correo"));
            TM.setLigaPro(rs.getString("LigaPro"));
            TM.setInformacionSol(rs.getString("InformacionSol"));
            TM.setInformacionPro(rs.getString("InformacionPro"));
            TM.setClPais(rs.getString("clPais"));
            TM.setDsPais(rs.getString("dsPais"));
            TM.setCodEnt(rs.getString("CodEnt"));
            TM.setDsEntfed(rs.getString("dsEntfed"));
            TM.setCodMD(rs.getString("CodMD"));
            TM.setDsMunDel(rs.getString("dsMunDel"));
            TM.setClTipoFalla(rs.getString("clTipoFalla"));
            TM.setDsTipoFalla(rs.getString("dsTipoFalla"));
            TM.setClTipoGrua(rs.getString("clTipoGrua"));
            TM.setDsTipoGrua(rs.getString("dsTipoGrua"));
            TM.setModelo(rs.getString("Modelo"));
            TM.setColor(rs.getString("Color"));
            TM.setPatente(rs.getString("Patente"));
            TM.setCodigoMarca(rs.getString("CodigoMarca"));
            TM.setDsMarcaAuto(rs.getString("dsMarcaAuto"));
            TM.setClLugarEvento(rs.getString("clLugarEvento"));
            TM.setDsLugarEvento(rs.getString("dsLugarEvento"));
            TM.setClTipoAuto(rs.getString("clTipoAuto"));
            TM.setDsTipoAuto(rs.getString("dsTipoAuto"));
            return TM;

        }
    }
}
