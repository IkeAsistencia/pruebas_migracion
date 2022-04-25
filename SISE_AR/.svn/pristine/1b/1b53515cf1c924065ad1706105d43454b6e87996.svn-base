package com.ike.asistencias;

import com.ike.asistencias.to.OdontologiaCons;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

public class DAOOdontologiaCons extends com.ike.model.DAOBASE {

    public DAOOdontologiaCons() {
    }

    public OdontologiaCons getOdontologiaCons(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_DAOOdontologiaCons ").append(clExpediente);
        col = this.rsSQLNP(sb.toString(), new OdontologiaConsFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (OdontologiaCons) it.next() : null;
    }

    public class OdontologiaConsFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {

            OdontologiaCons con = new OdontologiaCons();

            con.setClExpediente(rs.getString("clExpediente"));
            con.setNombre(rs.getString("Paciente"));
            con.setEdad(rs.getString("Edad"));
            con.setPeso(rs.getString("Peso"));
            con.setParentesco(rs.getString("dsParentesco"));
            con.setCP("CP");
            con.setDsEntFed(rs.getString("dsEntFed"));
            con.setCodEnt(rs.getString("CodEnt"));
            con.setDsMunDel(rs.getString("dsMunDel"));
            con.setCodMD(rs.getString("CodMD"));
            con.setColonia(rs.getString("Colonia"));
            con.setCalle(rs.getString("Calle"));
            con.setPadecimiento(rs.getString("Padecimiento"));
            con.setMedicoAtendio(rs.getString("MedicoAtendio"));
            con.setDiagnostico(rs.getString("DiagnosticoDx"));
            con.setTratamiento(rs.getString("TratamientoTx"));

            return con;
        }
    }
}
