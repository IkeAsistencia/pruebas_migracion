package com.ike.operacion;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import com.ike.operacion.to.AltaCitas;

public class DAOAltaCitas extends com.ike.model.DAOBASE {


    public DAOAltaCitas() {
    }

    public AltaCitas getAltaCitas(String StrclCita) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;  
             
        sb.append("st_ObtenDetalleCitas ").append(StrclCita);

        col = this.rsSQLNP(sb.toString(), new AltaCitasFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (AltaCitas) it.next() : null;
        
        
    }

    public class AltaCitasFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            AltaCitas altacitas = new AltaCitas();
            altacitas.setclCita(rs.getString("clCita"));
            altacitas.setclExpediente(rs.getString("clExpediente"));
            altacitas.setclProveedor(rs.getString("clProveedor"));
            altacitas.setclEstatusCita(rs.getString("clEstatusCita"));
            altacitas.setFecha(rs.getString("Fecha"));
            altacitas.setHoraD(rs.getString("HoraD"));
            altacitas.setHoraH(rs.getString("HoraH"));

            return altacitas;
        }
    }
}
