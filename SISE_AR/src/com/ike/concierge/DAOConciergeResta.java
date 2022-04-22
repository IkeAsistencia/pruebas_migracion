/*
 *
 *
 * Created on 21 de febrero de 2007, 09:48 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.concierge;
import com.ike.concierge.to.Conciergeresta;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOConciergeResta extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeResta() {
    }
    
    public Conciergeresta getCSRestaurant(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenRestaurante ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new ConciergeventavipFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergeresta) it.next() : null;
    }
    
    
    public class ConciergeventavipFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergeresta conciergeresta = new Conciergeresta();
            conciergeresta.setClRestaurante(rs.getString("clRestaurante"));
            conciergeresta.setClAsistencia(rs.getString("clAsistencia"));
            conciergeresta.setNadultos(rs.getString("Nadultos"));
            conciergeresta.setNinos(rs.getString("Ninos"));
            conciergeresta.setEdades(rs.getString("Edades"));
            conciergeresta.setFechaD(rs.getString("FechaD"));
            conciergeresta.setCodigo(rs.getString("Codigo"));
            conciergeresta.setTelefono(rs.getString("Telefono"));
            //conciergeresta.setFechaC(rs.getString("FechaC"));            
            conciergeresta.setOcasion(rs.getString("Ocasion"));
            conciergeresta.setclCallRest(rs.getString("clCallRest"));
            conciergeresta.setClSeccion(rs.getString("clSeccion"));            
            conciergeresta.setHotel(rs.getString("Hotel"));
            //conciergeresta.setFechaI(rs.getString("FechaI"));
            conciergeresta.setReservacion(rs.getString("Reservacion"));
            //conciergeresta.setFechaO(rs.getString("FechaO"));
            conciergeresta.setClTipoPago(rs.getString("clTipoPago"));
            conciergeresta.setNomBanco(rs.getString("NomBanco"));
            conciergeresta.setNombreTC(rs.getString("NombreTC"));
            conciergeresta.setNumeroTC(rs.getString("NumeroTC"));
            conciergeresta.setExpira2(rs.getString("Expira2"));
            conciergeresta.setSecC(rs.getString("SecC"));
            conciergeresta.setConfirmo(rs.getString("Confirmo"));
            conciergeresta.setNConfirmo(rs.getString("NConfirmo"));
            conciergeresta.setPCancel(rs.getString("PCancel"));
            conciergeresta.setNuInf(rs.getString("NuInf"));
            conciergeresta.setTolerancia(rs.getString("Tolerancia"));
            conciergeresta.setComentarios(rs.getString("Comentarios"));
            conciergeresta.setEstatus(rs.getString("Estatus"));
            conciergeresta.setDsEstatus(rs.getString("dsEstatus"));
            conciergeresta.setDsTipoPago(rs.getString("dsTipoPago"));
            conciergeresta.setExpira(rs.getString("Expira"));
            conciergeresta.setDsSeccion(rs.getString("dsSeccion"));                                    
            conciergeresta.setFechaRegistro(rs.getString("FechaRegistro"));
            conciergeresta.setDsCallRest(rs.getString("dsCallRest")); 
            return conciergeresta;
        }
    }
}