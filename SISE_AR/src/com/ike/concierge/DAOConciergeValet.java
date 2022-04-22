/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ike.concierge;
import com.ike.concierge.to.ConciergeValet;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author rfernandez
 */
public class DAOConciergeValet extends com.ike.model.DAOBASE{

  public DAOConciergeValet() {
    }

    public ConciergeValet getConciergeValet (String StrclAsistencia ) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_CSValetEjecutivo ").append(StrclAsistencia);
        System.out.println("Store: "+sb);
        col = this.rsSQLNP(sb.toString(), new ConciergeValetFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (ConciergeValet) it.next() : null;
    }

    /* Creates Filler of CSPreventa */
    public class ConciergeValetFiller implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            ConciergeValet CV = new ConciergeValet();

            CV.setclValetEjecutivo(rs.getString("clValetEjecutivo"));
            CV.setclAsistencia(rs.getString("clAsistencia"));
            CV.setFechaServicio(rs.getString("FechaServicio"));
            CV.setNoPersonas(rs.getString("NoPersonas"));
            CV.setEtiqueta(rs.getString("Etiqueta"));
            CV.setComentariosS(rs.getString("ComentariosS"));
            CV.setCosto(rs.getString("Costo"));            
            CV.setNombre(rs.getString("Nombre"));
            CV.setDireccion(rs.getString("Direccion"));
            CV.setTelefono(rs.getString("Telefono"));
            CV.setTelefono2(rs.getString("Telefono2"));
            CV.setTelefono3(rs.getString("Telefono3"));
            CV.setTelefono4(rs.getString("Telefono4"));
            CV.setContacto(rs.getString("Contacto"));
            CV.setClTipoPago(rs.getString("clTipoPago"));
            CV.setNomBanco(rs.getString("NomBanco"));
            CV.setNombreTC(rs.getString("NombreTC"));
            CV.setNumeroTC(rs.getString("NumeroTC"));
            CV.setExpira(rs.getString("Expira"));
            CV.setSecC(rs.getString("SecC"));
            CV.setConfirmo(rs.getString("Confirmo"));
            CV.setNConfirmo(rs.getString("NConfirmo"));
            CV.setPCancel(rs.getString("PCancel"));
            CV.setNuInf(rs.getString("NuInf"));
            CV.setEstatus(rs.getString("Estatus"));
            CV.setDsEstatus(rs.getString("dsEstatus"));
            CV.setDsTipoPago(rs.getString("dsTipoPago"));

            CV.setFechaRegistro(rs.getString("FechaRegistro"));
            CV.setComentarios(rs.getString("Comentarios"));
    
            return CV;
        }
    }
 }

