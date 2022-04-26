package com.ike.asistencias;

import com.ike.asistencias.to.AsistenciaTecnologica;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

public class DAOAsistenciaTecnologica extends com.ike.model.DAOBASE {

    public DAOAsistenciaTecnologica() {
    }

    public AsistenciaTecnologica getAsistenciaTecnologica(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_getDetalleAsistenciaTecnologica ").append(clExpediente);

        col = this.rsSQLNP(sb.toString(), new AsistenciaTecnologicaFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (AsistenciaTecnologica) it.next() : null;
    }

    public class AsistenciaTecnologicaFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            AsistenciaTecnologica AT = new AsistenciaTecnologica();

            AT.setClExpediente(rs.getString("clExpediente"));
            AT.setClFamilia(rs.getString("clFamilia"));
            AT.setDsFamilia(rs.getString("dsFamilia"));
            AT.setClEquipo(rs.getString("clEquipo"));
            AT.setDsEquipo(rs.getString("dsEquipo"));
            AT.setClMarca(rs.getString("clMarca"));
            AT.setDsMarca(rs.getString("dsMarca"));
            AT.setClModelo(rs.getString("clModelo"));
            AT.setDsModelo(rs.getString("dsModelo"));
            AT.setDescProblema(rs.getString("DescProblema"));
            AT.setClTipoAsistencia(rs.getString("clTipoAsistencia"));
            AT.setDsTipoAsistencia(rs.getString("dsTipoAsistencia"));
            AT.setClLugarCompra(rs.getString("clLugarCompra"));
            AT.setDsLugarCompra(rs.getString("dsLugarCompra"));
            AT.setClPais(rs.getString("clPais"));
            AT.setDsPais(rs.getString("dsPais"));
            AT.setCodEnt(rs.getString("CodEnt"));
            AT.setDsEntFed(rs.getString("dsEntFed"));
            AT.setCodMD(rs.getString("CodMD"));
            AT.setDsMunDel(rs.getString("dsMunDel"));
            AT.setDireccion(rs.getString("Direccion"));
            AT.setObservaciones(rs.getString("Observaciones"));
            return AT;
        }
    }
}
