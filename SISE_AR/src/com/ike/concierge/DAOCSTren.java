/*
 * DAOCSTren.java
 *
 * Created 2010-11-23
 *
 */

package com.ike.concierge;
import com.ike.concierge.to.CSTren;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @autor rfernandez
 */
 public class DAOCSTren extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOCSTren */
    public DAOCSTren() {
    }

    public CSTren getCSTren( String StrclAsistencia ) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_CSTren ").append(StrclAsistencia);
        System.out.println("Store: "+sb);
        col = this.rsSQLNP(sb.toString(), new CSTrenFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (CSTren) it.next() : null;
    }

    /* Creates Filler of CSTren */
    public class CSTrenFiller implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSTren T = new CSTren();

            T.setclTren(rs.getString("clTren"));
            T.setclAsistencia(rs.getString("clAsistencia"));          
            T.setRegion(rs.getString("Region"));
            T.setLineaTren(rs.getString("LineaTren"));
            T.setClase(rs.getString("Clase"));
            T.setCiudadO(rs.getString("CiudadO"));
            T.setCiudadD(rs.getString("CiudadD"));
            T.setEstacionO(rs.getString("EstacionO"));
            T.setEstacionD(rs.getString("EstacionD"));
            T.setFechaS(rs.getString("FechaS"));
            T.setFechaAS(rs.getString("FechaAS"));
            T.setEscalas(rs.getString("Escalas"));
            T.setVia(rs.getString("Via"));
            T.setHorasRecorrido(rs.getString("HorasRecorrido"));
            T.setCapacidadC(rs.getString("CapacidadC"));
            T.setCostoC(rs.getString("CostoC"));
            
            T.setAutoFill(rs.getString("AutoFill"));
            T.setRegionR(rs.getString("RegionR"));
            T.setLineaTrenR(rs.getString("LineaTrenR"));
            T.setClaseR(rs.getString("ClaseR"));

            T.setCiudadOR(rs.getString("CiudadOR"));
            T.setCiudadDR(rs.getString("CiudadDR"));
            T.setEstacionOR(rs.getString("EstacionOR"));
            T.setEstacionDR(rs.getString("EstacionDR"));
            T.setFechaSR(rs.getString("FechaSR"));
            T.setFechaAR(rs.getString("FechaAR"));
            T.setEscalasR(rs.getString("EscalasR"));
            T.setViaR(rs.getString("ViaR"));
            T.setHorasRR(rs.getString("HorasRR"));
            T.setCapacidadCR(rs.getString("CapacidadCR"));
            T.setCostoCR(rs.getString("CostoCR"));
            T.setclTipoPago(rs.getString("clTipoPago"));
            T.setdsTipoPago(rs.getString("dsTipoPago"));
            T.setNomBanco(rs.getString("NomBanco"));
            T.setNombreTC(rs.getString("NombreTC"));
            T.setNumeroTC(rs.getString("NumeroTC"));
            T.setExpira(rs.getString("Expira"));
            T.setSecC(rs.getString("SecC"));
            T.setConfirmo(rs.getString("Confirmo"));
            T.setNConfirmo(rs.getString("NConfirmo"));
            T.setPCancel(rs.getString("PCancel"));
            T.setNuInf(rs.getString("NuInf"));
            T.setFechaRegistro(rs.getString("FechaRegistro"));
            T.setComentarios(rs.getString("Comentarios"));
            T.setEstatus(rs.getString("Estatus"));
            T.setdsEstatus(rs.getString("dsEstatus"));

            return T;
        }
    }

 }
