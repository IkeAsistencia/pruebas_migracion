package com.ike.asistencias;

import com.ike.asistencias.to.ConsultaOdont;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

public class DAOConsultaOdont extends com.ike.model.DAOBASE {

    public DAOConsultaOdont() {
    }

    public ConsultaOdont getConsultaOdont(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_DAOConsultaOdont ").append(clExpediente);
        col = this.rsSQLNP(sb.toString(), new ConsultaOdontFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (ConsultaOdont) it.next() : null;
    }

    public class ConsultaOdontFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {

            ConsultaOdont con = new ConsultaOdont();

            con.setClExpediente(rs.getString("clExpediente"));
            con.setNombre(rs.getString("Paciente"));
            con.setEdad(rs.getString("Edad"));
            con.setPeso(rs.getString("Peso"));
            con.setParentesco(rs.getString("dsParentesco"));
            con.setPadecimiento(rs.getString("Padecimiento"));
            con.setTiempoEvol(rs.getString("TiempoEvolucion"));
            con.setantecedentes(rs.getString("Antecedentes"));
            con.setTratamientoPrev(rs.getString("TratamientosPrevios"));
            con.setEstudiosPrev(rs.getString("EstudiosPrevios"));
            con.setRecomendacion(rs.getString("RecomendaMedico"));
            con.setTieneAsist(rs.getString("TieneAsistencia"));

            return con;
        }
    }
}
