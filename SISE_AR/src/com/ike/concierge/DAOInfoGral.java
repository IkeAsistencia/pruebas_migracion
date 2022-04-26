
package com.ike.concierge;
import com.ike.concierge.to.ConciergeInfoGral;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

public class DAOInfoGral extends com.ike.model.DAOBASE{
    
    public DAOInfoGral(){  }
    public ConciergeInfoGral getCSInfoGral(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_CSObtenInfoGral ").append(StrclAsistencia);
        col = this.rsSQLNP(sb.toString(), new conciergeinfogralFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (ConciergeInfoGral) it.next() : null;
    }
    public class conciergeinfogralFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            ConciergeInfoGral conciergeinfogral = new ConciergeInfoGral();
            conciergeinfogral.setclAsistencia(rs.getString("clAsistencia"));
            conciergeinfogral.setclEstatus(rs.getString("clEstatus"));
            conciergeinfogral.setdsEstatus(rs.getString("dsEstatus"));
            conciergeinfogral.setInfoSolicitada(rs.getString("InfoSolicitada"));
            conciergeinfogral.setCiudad(rs.getString("Ciudad"));
            conciergeinfogral.setEstado(rs.getString("Estado"));
            conciergeinfogral.setPais(rs.getString("Pais"));
            conciergeinfogral.setFechaInicio(rs.getString("FechaInicio"));
            conciergeinfogral.setFechaTermino(rs.getString("FechaTermino"));
            conciergeinfogral.setCorreo(rs.getString("Correo"));
            conciergeinfogral.setOtro(rs.getString("Otro"));
            conciergeinfogral.setArchEnviado(rs.getString("ArchEnviado"));
            conciergeinfogral.setUbicacion(rs.getString("Ubicacion"));
            conciergeinfogral.setComentarios(rs.getString("Comentarios"));
            conciergeinfogral.setFechaRegistro(rs.getString("FechaRegistro"));
            conciergeinfogral.setClTipoInfoBrindada(rs.getString("clTipoInfoBrindada"));
            conciergeinfogral.setDsTipoInfoBrindada(rs.getString("dsTipoInfoBrindada"));
            return conciergeinfogral;
        }
    }
}


