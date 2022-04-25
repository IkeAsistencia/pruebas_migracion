/*
 * DAOCSAutobus.java
 *
 * Created 2010-11-23
 *
 */

package com.ike.concierge;
import com.ike.concierge.to.CSAutobus;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @autor rfernandez
 */
 public class DAOCSAutobus extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOCSAutobus */
    public DAOCSAutobus() {
    }

  public CSAutobus getCSAutobus (String StrclAsistencia ) throws DAOException {
        StringBuffer sb = new StringBuffer(); 
        Collection col = null; 
        sb.append("st_CSAutobus ").append(StrclAsistencia);

        System.out.println("Store: "+sb);

        col = this.rsSQLNP(sb.toString(), new CSAutobusFiller());
        Iterator it = col.iterator();  
        return it.hasNext() ? (CSAutobus) it.next() : null;
  }

    /* Creates Filler of CSAutobus */
    public class CSAutobusFiller implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSAutobus A = new CSAutobus();

            A.setclAutobus(rs.getString("clAutobus"));
            A.setclAsistencia(rs.getString("clAsistencia"));           
           
            A.setCiudadO(rs.getString("CiudadO"));
            A.setCiudadD(rs.getString("CiudadD"));
            A.setTerminalO(rs.getString("TerminalO"));
            A.setTerminalD(rs.getString("TerminalD"));
            A.setFechaS(rs.getString("FechaS"));
            A.setFechaAS(rs.getString("FechaAS"));
            A.setLinea(rs.getString("Linea"));
            A.setClase(rs.getString("Clase"));
            A.setHorasR(rs.getString("HorasR"));
            A.setCorrida(rs.getString("Corrida"));
            A.setAutoFill(rs.getString("AutoFill"));
            A.setCiudadOR(rs.getString("CiudadOR"));
            A.setCiudadDR(rs.getString("CiudadDR"));
            A.setTerminalOR(rs.getString("TerminalOR"));
            A.setTerminalDR(rs.getString("TerminalDR"));
            A.setFechaSR(rs.getString("FechaSR"));
            A.setFechaAR(rs.getString("FechaAR"));
            A.setLineaR(rs.getString("LineaR"));
            A.setClaseR(rs.getString("ClaseR"));
            A.setHorasRR(rs.getString("HorasRR"));
            A.setCorridaR(rs.getString("CorridaR"));
            A.setclTipoPago(rs.getString("clTipoPago"));
            A.setdsTipoPago(rs.getString("dsTipoPago"));
            A.setNomBanco(rs.getString("NomBanco"));
            A.setNombreTC(rs.getString("NombreTC"));
            A.setNumeroTC(rs.getString("NumeroTC"));
            A.setExpira(rs.getString("Expira"));
            A.setSecC(rs.getString("SecC"));
            A.setConfirmo(rs.getString("Confirmo"));
            A.setNConfirmo(rs.getString("NConfirmo"));
            A.setPCancel(rs.getString("PCancel"));
            A.setNuInf(rs.getString("NuInf"));
            A.setComentarios(rs.getString("Comentarios"));
            A.setEstatus(rs.getString("Estatus"));
            A.setdsEstatus(rs.getString("dsEstatus"));
            A.setFechaRegistro(rs.getString("FechaRegistro"));

            return A;
        }
    }

 }
