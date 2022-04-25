/*
 * DAOPriceless.java
 *
 * Created on 29 de septiembre de 2013, 12:22 PM
 */
package com.ike.concierge;

import com.ike.concierge.to.ConciergePriceless;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author mramirez
 */
public class DAOPriceless extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOTelemarketing */
    public DAOPriceless() {
    }

    public ConciergePriceless getCSPriceless(String StrclAsistencia) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_CSObtenPriceless ").append(StrclAsistencia);
        System.out.println(sb);

        col = this.rsSQLNP(sb.toString(), new conciergepricelessFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (ConciergePriceless) it.next() : null;
    }

    public class conciergepricelessFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            ConciergePriceless conciergepriceless = new ConciergePriceless();
            conciergepriceless.setclAsistencia(rs.getString("clAsistencia"));
            conciergepriceless.setclEstatus(rs.getString("clEstatus"));
            conciergepriceless.setdsEstatus(rs.getString("dsEstatus"));
            conciergepriceless.setInfoSolicitada(rs.getString("InfoSolicitada"));
            conciergepriceless.setCiudad(rs.getString("Ciudad"));
            conciergepriceless.setEstado(rs.getString("Estado"));
            conciergepriceless.setPais(rs.getString("Pais"));
            conciergepriceless.setFechaInicio(rs.getString("FechaInicio"));
            conciergepriceless.setFechaTermino(rs.getString("FechaTermino"));
            conciergepriceless.setCorreo(rs.getString("Correo"));
            conciergepriceless.setOtro(rs.getString("Otro"));
            conciergepriceless.setArchEnviado(rs.getString("ArchEnviado"));
            conciergepriceless.setUbicacion(rs.getString("Ubicacion"));
            conciergepriceless.setComentarios(rs.getString("Comentarios"));
            conciergepriceless.setFechaRegistro(rs.getString("FechaRegistro"));

            return conciergepriceless;
        }
    }
}
