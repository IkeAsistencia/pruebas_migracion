package com.ike.retencion;

import com.ike.retencion.to.Retencion;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

public class DAORetencion extends com.ike.model.DAOBASE {

    public DAORetencion() {
    }

    public Retencion getRetencion(String clRetencTmk) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("sp_getRetenciones ").append(clRetencTmk);

        col = this.rsSQLNP(sb.toString(), new RetencionFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (Retencion) it.next() : null;
    }

    public class RetencionFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {

            Retencion ret = new Retencion();

            ret.setClRetencionTmk(rs.getString("clRetencTmk"));
            ret.setClCuenta(rs.getString("clcuenta"));
            ret.setClAfiliado(rs.getString("clAfil"));
            ret.setNombreCta(rs.getString("Nombre"));
            ret.setFechaLlamada(rs.getString("FechaLlamada"));
            ret.setNomAfil(rs.getString("NomAfil"));
            ret.setClave(rs.getString("Clave"));
            ret.setPersonaReporta(rs.getString("NombPerReporta"));
            ret.setTelefono(rs.getString("TelefonoCasa"));
            ret.setRfc(rs.getString("Rfc"));
            ret.setBeneficiario(rs.getString("Beneficiario"));
            ret.setClEstatus(rs.getString("clStatus"));
            ret.setDsEstatus(rs.getString("dsStatus"));
            ret.setClMotivoCancela(rs.getString("clMotivoCancela"));
            ret.setDsMotivoCancela(rs.getString("dsMotivoCancela"));
            ret.setObservaciones(rs.getString("Observaciones"));
            ret.setDni(rs.getString("DNI"));
            ret.setChkBCompleta(rs.getString("MismaPerReporta"));
            ret.setClaveMask(rs.getString("ClaveMask"));
            ret.setCanalVenta(rs.getString("CanalVenta"));
            ret.setDirOldDom(rs.getString("dirOld"));
            ret.setCalleDom(rs.getString("calle"));
            ret.setNcalleDom(rs.getString("ncalle"));
            ret.setNpisoDom(rs.getString("npiso"));
            ret.setNdeptoDom(rs.getString("ndepto"));
            ret.setCpDom(rs.getString("cp"));
            ret.setCamDom(rs.getString("cambioDom"));
            ret.setTelCasaDom(rs.getString("telCasa"));
            ret.setTelOfiDom(rs.getString("telOfi"));
            ret.setCorreoDom(rs.getString("correo"));
            ret.setCodEntDom(rs.getString("CodEnt"));
            ret.setDsEntFedDom(rs.getString("dsEntFed"));
            ret.setCodMDDom(rs.getString("CodMD"));
            ret.setDsMunDelDom(rs.getString("dsMunDel"));
            ret.setHR1(rs.getString("HR1"));
            ret.setHR2(rs.getString("HR2"));
            ret.setPR1(rs.getString("PR1"));
            ret.setPR2(rs.getString("PR2"));
            ret.setPR3(rs.getString("PR3"));
            ret.setPE1(rs.getString("PE1"));
            ret.setPE2(rs.getString("PE2"));

            return ret;
        }
    }
}
