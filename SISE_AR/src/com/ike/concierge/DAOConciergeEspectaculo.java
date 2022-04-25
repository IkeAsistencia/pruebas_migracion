/*
 *
 *
 * Created on 15 de febrero de 2007, 11:48 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.concierge;
import com.ike.concierge.to.Conciergeespectaculo;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOConciergeEspectaculo extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOConciergeEspectaculo */
    public DAOConciergeEspectaculo() {
    }
    
    public Conciergeespectaculo getCSespectaculo(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenEspectaculo ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new ConciergeespectaculoFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergeespectaculo) it.next() : null;
    }
    
    
    public class ConciergeespectaculoFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergeespectaculo conciergeespectaculo = new Conciergeespectaculo();
            conciergeespectaculo.setClEspectaculo(rs.getString("clEspectaculo"));
            conciergeespectaculo.setClAsistencia(rs.getString("clAsistencia"));
            conciergeespectaculo.setDescripcion(rs.getString("Descripcion"));
            conciergeespectaculo.setFechaEvento(rs.getString("FechaEvento"));
            conciergeespectaculo.setDireccion(rs.getString("Direccion"));
            conciergeespectaculo.setCiudad(rs.getString("Ciudad"));
            conciergeespectaculo.setEstado(rs.getString("Estado"));
            conciergeespectaculo.setPais(rs.getString("Pais"));
            conciergeespectaculo.setTelefono(rs.getString("Telefono"));
            conciergeespectaculo.setCelular(rs.getString("Celular"));
            conciergeespectaculo.setCostoH(rs.getString("CostoH"));
            conciergeespectaculo.setHorasC(rs.getString("HorasC"));
            conciergeespectaculo.setCargoT(rs.getString("CargoT"));
            conciergeespectaculo.setClTipoPago(rs.getString("clTipoPago"));
            conciergeespectaculo.setNomBanco(rs.getString("NomBanco"));
            conciergeespectaculo.setNombreTC(rs.getString("NombreTC"));
            conciergeespectaculo.setNumeroTC(rs.getString("NumeroTC"));
            conciergeespectaculo.setExpira(rs.getString("Expira"));
            conciergeespectaculo.setSecC(rs.getString("SecC"));
            conciergeespectaculo.setPagoO(rs.getString("PagoO"));
            conciergeespectaculo.setConfirmo(rs.getString("Confirmo"));
            conciergeespectaculo.setNConfirmo(rs.getString("NConfirmo"));
            conciergeespectaculo.setPCancel(rs.getString("PCancel"));
            conciergeespectaculo.setNuInf(rs.getString("NuInf"));
            conciergeespectaculo.setComentarios(rs.getString("Comentarios"));
            conciergeespectaculo.setEstatus(rs.getString("Estatus"));
            conciergeespectaculo.setDsEstatus(rs.getString("dsEstatus"));
            conciergeespectaculo.setDsTipoPago(rs.getString("dsTipoPago"));
            conciergeespectaculo.setFechaRegistro(rs.getString("FechaRegistro"));
            return conciergeespectaculo;
        }
    }
}
