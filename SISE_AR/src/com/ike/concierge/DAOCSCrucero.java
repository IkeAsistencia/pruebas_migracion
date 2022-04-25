/*
 * DAOCSCrucero.java
 *
 * Created 2010-11-23
 *
 */

package com.ike.concierge;
import com.ike.concierge.to.CSCrucero;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @autor rfernandez
 */
 public class DAOCSCrucero extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOCSCrucero */
    public DAOCSCrucero() {
    }

     public CSCrucero getCSCrucero (String StrclAsistencia ) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_CSCrucero ").append(StrclAsistencia);
        System.out.println("Store: "+sb);
        col = this.rsSQLNP(sb.toString(), new CSCruceroFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (CSCrucero) it.next() : null;
    }

    /* Creates Filler of CSCrucero */
    public class CSCruceroFiller implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSCrucero C = new CSCrucero();

            C.setclCrucero(rs.getString("clCrucero"));
            C.setclAsistencia(rs.getString("clAsistencia"));           
            C.setRegion(rs.getString("Region"));
            C.setNaviera(rs.getString("Naviera"));
            C.setDuracionV(rs.getString("DuracionV"));
            C.setTipoCamarote(rs.getString("TipoCamarote"));
            C.setVista(rs.getString("Vista"));
            C.setNoCamarote(rs.getString("NoCamarote"));
            C.setCiudadO(rs.getString("CiudadO"));
            C.setCiudadD(rs.getString("CiudadD"));
            C.setPuertoO(rs.getString("PuertoO"));
            C.setPuertoD(rs.getString("PuertoD"));
            C.setFechaS(rs.getString("FechaS"));
            C.setFechaA(rs.getString("FechaA"));
            C.setHoraS(rs.getString("HoraS"));
            C.setHoraA(rs.getString("HoraA"));
            C.setclTipoPago(rs.getString("clTipoPago"));
            C.setdsTipoPago(rs.getString("dsTipoPago"));
            C.setNomBanco(rs.getString("NomBanco"));
            C.setNombreTC(rs.getString("NombreTC"));
            C.setNumeroTC(rs.getString("NumeroTC"));
            C.setExpira(rs.getString("Expira"));
            C.setSecC(rs.getString("SecC"));
            C.setConfirmo(rs.getString("Confirmo"));
            C.setNConfirmo(rs.getString("NConfirmo"));
            C.setPCancel(rs.getString("PCancel"));
            C.setNuInf(rs.getString("NuInf"));
            C.setComentarios(rs.getString("Comentarios"));
            C.setEstatus(rs.getString("Estatus"));
            C.setdsEstatus(rs.getString("dsEstatus"));
            C.setFechaRegistro(rs.getString("FechaRegistro"));
            return C;
        }
    }
 }
