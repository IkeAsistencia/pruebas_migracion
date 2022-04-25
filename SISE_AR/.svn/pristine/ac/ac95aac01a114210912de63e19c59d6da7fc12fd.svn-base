/*
 * DAOCSRecepcionVip.java
 *
 * Created 2010-11-23
 *
 */

package com.ike.concierge;
import com.ike.concierge.to.CSRecepcionVip;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @autor rfernandez
 */
 public class DAOCSRecepcionVip extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOCSRecepcionVip */
    public DAOCSRecepcionVip() {
    }

    public CSRecepcionVip getCSRecepcionVip( String StrclAsistencia ) throws DAOException {
       StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_CSRecepcionVip ").append(StrclAsistencia);
        System.out.println("Store: "+sb);
        col = this.rsSQLNP(sb.toString(), new CSRecepcionVipFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (CSRecepcionVip) it.next() : null;
    }

    /* Creates Filler of CSRecepcionVip */
    public class CSRecepcionVipFiller implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSRecepcionVip R = new CSRecepcionVip();

            R.setclRecepcionVip(rs.getString("clRecepcionVip"));
            R.setclAsistencia(rs.getString("clAsistencia"));
            R.setNoPasajeros(rs.getString("NoPasajeros"));
            R.setRequiereT(rs.getString("RequiereT"));
            R.setDestino(rs.getString("Destino"));
            R.setCostoT(rs.getString("CostoT"));
            R.setNoVuelo(rs.getString("NoVuelo"));
            R.setOperado(rs.getString("Operado"));
            R.setPasajero(rs.getString("Pasajero"));
            R.setCiudadO(rs.getString("CiudadO"));
            R.setCiudadD(rs.getString("CiudadD"));
            R.setAeropuertoO(rs.getString("AeropuertoO"));
            R.setAeropuertoD(rs.getString("AeropuertoD"));
            R.setFechaS(rs.getString("FechaS"));
            R.setFechaA(rs.getString("FechaA"));
            R.setConexiones(rs.getString("Conexiones"));
            R.setTerminal(rs.getString("Terminal"));
            R.setclTipoPago(rs.getString("clTipoPago"));
            R.setdsTipoPago(rs.getString("dsTipoPago"));
            R.setNomBanco(rs.getString("NomBanco"));
            R.setNombreTC(rs.getString("NombreTC"));
            R.setNumeroTC(rs.getString("NumeroTC"));
            R.setExpira(rs.getString("Expira"));
            R.setSecC(rs.getString("SecC"));
            R.setConfirmo(rs.getString("Confirmo"));
            R.setNConfirmo(rs.getString("NConfirmo"));
            R.setPCancel(rs.getString("PCancel"));
            R.setNuInf(rs.getString("NuInf"));
            R.setComentarios(rs.getString("Comentarios"));
            R.setEstatus(rs.getString("Estatus"));
            R.setDsEstatus(rs.getString("dsEstatus"));
            R.setFechaRegistro(rs.getString("FechaRegistro"));
        

            return R;
        }
    }

 }
