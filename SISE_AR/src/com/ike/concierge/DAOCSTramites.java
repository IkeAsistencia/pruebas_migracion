/*
 * DAOCSTramites.java
 *
 * Created 2010-11-23
 *
 */

package com.ike.concierge;
import com.ike.concierge.to.CSTramites;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @autor rfernandez
 */
 public class DAOCSTramites extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOCSTramites */
    public DAOCSTramites() {
    }

    public CSTramites getCSTramites ( String StrclAsistencia ) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_CSTramites ").append(StrclAsistencia);
        System.out.println("Store: "+sb);
        col = this.rsSQLNP(sb.toString(), new CSTramitesFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (CSTramites) it.next() : null;
    }

    /* Creates Filler of CSTramites */
    public class CSTramitesFiller implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSTramites T = new CSTramites();

            T.setclTramites(rs.getString("clTramites"));
            T.setclAsistencia(rs.getString("clAsistencia"));
            T.setFechaRegistro(rs.getString("FechaRegistro"));
            T.setTipoTramite(rs.getString("TipoTramite"));
            T.setPagoDerechos(rs.getString("PagoDerechos"));
            T.setHorario(rs.getString("Horario"));
            T.setFechaCita(rs.getString("FechaCita"));
            T.setUbicacion(rs.getString("Ubicacion"));
            T.setRequisitos(rs.getString("Requisitos"));
            T.setRequisitos1(rs.getString("Requisitos1"));
            T.setRequisitos2(rs.getString("Requisitos2"));
            T.setRequisitos3(rs.getString("Requisitos3"));
            T.setRequisitos4(rs.getString("Requisitos4"));
            T.setRequisitos5(rs.getString("Requisitos5"));
            T.setRequisitos6(rs.getString("Requisitos6"));
            T.setRequisitos7(rs.getString("Requisitos7"));
            T.setRequisitos8(rs.getString("Requisitos8"));
            T.setRequisitos9(rs.getString("Requisitos9"));
            T.setObservaciones(rs.getString("Observaciones"));
            T.setObservaciones1(rs.getString("Observaciones1"));
            T.setObservaciones2(rs.getString("Observaciones2"));
            T.setObservaciones3(rs.getString("Observaciones3"));
            T.setObservaciones4(rs.getString("Observaciones4"));
            T.setObservaciones5(rs.getString("Observaciones5"));
            T.setObservaciones6(rs.getString("Observaciones6"));
            T.setObservaciones7(rs.getString("Observaciones7"));
            T.setObservaciones8(rs.getString("Observaciones8"));
            T.setObservaciones9(rs.getString("Observaciones9"));            
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
            T.setComentarios(rs.getString("Comentarios"));
            T.setEstatus(rs.getString("Estatus"));
            T.setdsEstatus(rs.getString("dsEstatus"));
            T.setFechaRegistro(rs.getString("FechaRegistro"));

            return T;
        }
    }

 }
