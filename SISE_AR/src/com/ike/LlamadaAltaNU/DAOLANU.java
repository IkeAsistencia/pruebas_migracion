package com.ike.LlamadaAltaNU;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import com.ike.LlamadaAltaNU.to.LANUAfiliado;

public class DAOLANU extends com.ike.model.DAOBASE {
    /* Creates a new instance of DAOHelpdesk */

    public DAOLANU() {
    }

    public LANUAfiliado getAfiliado(String strclLlamaAltaNU) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_M24ObtenAfiliado ").append(strclLlamaAltaNU);

        col = this.rsSQLNP(sb.toString(), new AfiliadoFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (LANUAfiliado) it.next() : null;

    }

    public class AfiliadoFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            LANUAfiliado Afiliado = new LANUAfiliado();

            Afiliado.setclLlamaAltaNU(rs.getString("clLlamaAltaNU"));
            Afiliado.setClave(rs.getString("Clave"));
            Afiliado.setclAfiliadoA(rs.getString("clAfiliadoA"));
            Afiliado.setclCuentaA(rs.getString("clCuentaA"));
            Afiliado.setclAfiliadoJ(rs.getString("clAfiliadoJ"));
            Afiliado.setclCuentaJ(rs.getString("clCuentaJ"));
            Afiliado.setFechaAltaA(rs.getString("FechaAltaA"));
            Afiliado.setFechaIniA(rs.getString("FechaIniA"));
            Afiliado.setNombreA(rs.getString("NombreA"));
            Afiliado.setNombre(rs.getString("Nombre"));
            Afiliado.setApellidoPat(rs.getString("ApellidoPat"));
            Afiliado.setApellidoMat(rs.getString("ApellidoMat"));
            Afiliado.setRFC(rs.getString("RFC"));
            Afiliado.setFechaNacA(rs.getString("FechaNacA"));
            Afiliado.setEdadA(rs.getString("EdadA"));
            Afiliado.setNombreJ(rs.getString("NombreJ"));
            Afiliado.setNombreJu(rs.getString("NombreJu"));
            Afiliado.setApellidoPatJ(rs.getString("ApellidoPatJ"));
            Afiliado.setApellidoMatJ(rs.getString("ApellidoMatJ"));
            Afiliado.setFechaNacJ(rs.getString("FechaNacJ"));
            Afiliado.setEdadJ(rs.getString("EdadJ"));
            Afiliado.setCodEnt(rs.getString("CodEnt"));
            Afiliado.setEstado(rs.getString("Estado"));
            Afiliado.setCodMD(rs.getString("CodMD"));
            Afiliado.setMunDel(rs.getString("MunDel"));
            Afiliado.setCalle(rs.getString("Calle"));
            Afiliado.setColonia(rs.getString("Colonia"));
            Afiliado.setCP(rs.getString("CP"));
            Afiliado.setTelefono(rs.getString("Telefono"));
            Afiliado.setCelular(rs.getString("Celular"));
            Afiliado.setCorreo(rs.getString("Correo"));
            Afiliado.setclUsrApp(rs.getString("clUsrApp"));
            Afiliado.setNombreUsrApp(rs.getString("NombreUsrApp"));

            return Afiliado;
        }
    }
}
