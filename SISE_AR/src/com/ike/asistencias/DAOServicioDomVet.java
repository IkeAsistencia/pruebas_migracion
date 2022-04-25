package com.ike.asistencias;

import com.ike.asistencias.to.ServicioDomVet;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

public class DAOServicioDomVet extends com.ike.model.DAOBASE {

    public DAOServicioDomVet() {
    }

    public ServicioDomVet getServicioDomVet(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_ServicioDomVet ").append(clExpediente);
        col = this.rsSQLNP(sb.toString(), new ServicioDomVetFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (ServicioDomVet) it.next() : null;
    }

    public class ServicioDomVetFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            ServicioDomVet SerDomV = new ServicioDomVet();
            SerDomV.setClExpediente(rs.getString("clExpediente"));
            SerDomV.setNombre(rs.getString("Nombre"));
            SerDomV.setClMascotaRef(rs.getString("clMascotaRef"));
            SerDomV.setDsMascotaRef(rs.getString("dsMascotaRef"));
            SerDomV.setRaza(rs.getString("Raza"));
            SerDomV.setClSexoMascota(rs.getString("clSexoMascota"));
            SerDomV.setDsSexoMascota(rs.getString("dsSexoMascota"));
            SerDomV.setEdad(rs.getString("Edad"));
            SerDomV.setTalla(rs.getString("Talla"));
            SerDomV.setClTipoAlimento(rs.getString("clTipoAlimento"));
            SerDomV.setDsTipoAlimento(rs.getString("dsTipoAlimento"));
            SerDomV.setMarcaAlimento(rs.getString("MarcaAlimento"));
            SerDomV.setClServicioDom(rs.getString("clServicioDom"));
            SerDomV.setDsServicioDom(rs.getString("dsServicioDom"));
            SerDomV.setMedPrev(rs.getString("MedPrev"));
            SerDomV.setObsServicioDom(rs.getString("ObsServicioDom"));
            SerDomV.setCodEnt(rs.getString("CodEnt"));
            SerDomV.setDsEntFed(rs.getString("dsEntFed"));
            SerDomV.setCodMD(rs.getString("CodMD"));
            SerDomV.setDsMunDel(rs.getString("dsMunDel"));
            SerDomV.setCalle(rs.getString("Calle"));
            SerDomV.setNumero(rs.getString("Numero"));
            SerDomV.setDiagnostico(rs.getString("Diagnostico"));
            SerDomV.setTratamiento(rs.getString("Tratamiento"));
            return SerDomV;
        }
    }
}
