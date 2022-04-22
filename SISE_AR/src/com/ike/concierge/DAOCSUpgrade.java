/*
 * DAOCSUpgrade.java
 *
 * Created 2010-11-23
 *
 */

package com.ike.concierge;
import com.ike.concierge.to.CSUpgrade;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @autor rfernandez
 */
 public class DAOCSUpgrade extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOCSUpgrade */
    public DAOCSUpgrade() {
    }

    public CSUpgrade getCSUpgrade ( String StrclAsistencia ) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_CSUpgrade ").append(StrclAsistencia);
        System.out.println("Store: "+sb);
        col = this.rsSQLNP(sb.toString(), new CSUpgradeFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (CSUpgrade) it.next() : null;
    }

    /* Creates Filler of CSUpgrade */
    public class CSUpgradeFiller implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSUpgrade UP = new CSUpgrade();

            UP.setclUpgrade(rs.getString("clUpgrade"));
            UP.setclAsistencia(rs.getString("clAsistencia"));  
            UP.setReservacion(rs.getString("Reservacion"));
            UP.setClaveConfirma(rs.getString("ClaveConfirma"));
            UP.setFormaPago(rs.getString("FormaPago"));
            UP.setDetalleBen(rs.getString("DetalleBen"));
            UP.setNombre(rs.getString("Nombre"));
            UP.setContacto(rs.getString("Contacto"));
            UP.setRequisitos(rs.getString("Requisitos"));
            UP.setclTipoPago(rs.getString("clTipoPago"));
            UP.setdsTipoPago(rs.getString("dsTipoPago"));
            UP.setNomBanco(rs.getString("NomBanco"));
            UP.setNombreTC(rs.getString("NombreTC"));
            UP.setNumeroTC(rs.getString("NumeroTC"));
            UP.setExpira(rs.getString("Expira"));
            UP.setSecC(rs.getString("SecC"));
            UP.setConfirmo(rs.getString("Confirmo"));
            UP.setNConfirmo(rs.getString("NConfirmo"));
            UP.setPCancel(rs.getString("PCancel"));
            UP.setNuInf(rs.getString("NuInf"));
            UP.setComentarios(rs.getString("Comentarios"));
            UP.setEstatus(rs.getString("Estatus"));
            UP.setdsEstatus(rs.getString("dsEstatus"));
            UP.setFechaRegistro(rs.getString("FechaRegistro"));

            return UP;
        }
    }

 }
