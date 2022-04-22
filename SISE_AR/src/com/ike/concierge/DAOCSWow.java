/*
 * DAOCSWow.java
 *
 * Created 2010-11-23
 *
 */

package com.ike.concierge;
import com.ike.concierge.to.CSWow;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @autor rfernandez
 */
 public class DAOCSWow extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOCSWow */
    public DAOCSWow() {
    }

    public CSWow getCSWow ( String StrclAsistencia ) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_CSWow ").append(StrclAsistencia);
        System.out.println("Store: "+sb);
        col = this.rsSQLNP(sb.toString(), new CSWowFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (CSWow) it.next() : null;
    }

    /* Creates Filler of CSWow */
    public class CSWowFiller implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSWow W = new CSWow();

            W.setclCSwow(rs.getString("clCSwow"));
            W.setclAsistencia(rs.getString("clAsistencia"));   
            W.setFechaS(rs.getString("FechaS"));
            W.setNoPersonas(rs.getString("NoPersonas"));
            W.setLimiteGastos(rs.getString("LimiteGastos"));
            W.setDetalleSolicitud(rs.getString("DetalleSolicitud"));
            W.setclTipoPago(rs.getString("clTipoPago"));
            W.setdsTipoPago(rs.getString("dsTipoPago"));
            W.setNomBanco(rs.getString("NomBanco"));
            W.setNombreTC(rs.getString("NombreTC"));
            W.setNumeroTC(rs.getString("NumeroTC"));
            W.setExpira(rs.getString("Expira"));
            W.setSecC(rs.getString("SecC"));
            W.setConfirmo(rs.getString("Confirmo"));
            W.setNConfirmo(rs.getString("NConfirmo"));
            W.setPCancel(rs.getString("PCancel"));
            W.setNuInf(rs.getString("NuInf"));
            W.setComentarios(rs.getString("Comentarios"));
            W.setEstatus(rs.getString("clEstatus"));
            W.setdsEstatus(rs.getString("dsEstatus"));
            W.setFechaRegistro(rs.getString("FechaRegistro"));
 

            return W;
        }
    }

 }
