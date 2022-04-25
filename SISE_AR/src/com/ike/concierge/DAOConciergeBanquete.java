/*
 *
 * Created on 18 de agosto de 2006, 09:48 PM
 * 
 */
package com.ike.concierge;
import com.ike.concierge.to.Conciergebanquete;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOConciergeBanquete extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeBanquete() {
    }
    
    public Conciergebanquete getCSBanquete(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenBanquete ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new ConciergebanqueteFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergebanquete) it.next() : null;
    }
          
    public class ConciergebanqueteFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergebanquete conciergebanquete = new Conciergebanquete();
            conciergebanquete.setClBanquete(rs.getString("clBanquete"));
            conciergebanquete.setClAsistencia(rs.getString("clAsistencia"));
            conciergebanquete.setEvento(rs.getString("Evento"));
            conciergebanquete.setInvitadMos(rs.getString("Invitados"));            
            conciergebanquete.setFechaEventoI(rs.getString("FechaEventoI"));
            conciergebanquete.setFechaEventoF(rs.getString("FechaEventoF"));
            conciergebanquete.setUbicacion(rs.getString("Ubicacion"));
            conciergebanquete.setCiudad(rs.getString("Ciudad"));
            conciergebanquete.setEstado(rs.getString("Estado"));
            conciergebanquete.setPais(rs.getString("Pais"));
            conciergebanquete.setCostoH(rs.getString("CostoH"));
            conciergebanquete.setHorasC(rs.getString("HorasC"));
            conciergebanquete.setCargoT(rs.getString("CargoT"));
            conciergebanquete.setCostoP(rs.getString("CostoP"));
            conciergebanquete.setCargosO(rs.getString("cargosO"));
            conciergebanquete.setClTipoPago(rs.getString("clTipoPago"));
            conciergebanquete.setNomBanco(rs.getString("NomBanco"));
            conciergebanquete.setNombreTC(rs.getString("NombreTC"));
            conciergebanquete.setClTipoTarjeta(rs.getString("clTipoTarjeta"));
            conciergebanquete.setNumeroTC(rs.getString("NumeroTC"));
            conciergebanquete.setExpira2(rs.getString("Expira2"));
            conciergebanquete.setSecC(rs.getString("SecC"));
            conciergebanquete.setPagoO(rs.getString("PagoO"));
            conciergebanquete.setConfirmo(rs.getString("Confirmo"));
            conciergebanquete.setNConfirmo(rs.getString("NConfirmo"));
            conciergebanquete.setPCancel(rs.getString("PCancel"));
            conciergebanquete.setNuInf(rs.getString("NuInf"));
            conciergebanquete.setComentarios(rs.getString("Comentarios"));
            conciergebanquete.setCiudadE(rs.getString("CiudadE"));
            conciergebanquete.setTelefonoH(rs.getString("TelefonoH"));
            conciergebanquete.setCalle(rs.getString("calle"));
            conciergebanquete.setTelefonoC(rs.getString("TelefonoC"));
            conciergebanquete.setEstatus(rs.getString("Estatus"));
            conciergebanquete.setDsEstatus(rs.getString("dsEstatus"));
            conciergebanquete.setDsTipoPago(rs.getString("dsTipoPago"));
            conciergebanquete.setDsTipoTarjeta(rs.getString("dsTipoTarjeta"));
            conciergebanquete.setTelefono(rs.getString("Telefono"));
            conciergebanquete.setCelular(rs.getString("Celular"));
            conciergebanquete.setExpira(rs.getString("Expira"));
            conciergebanquete.setFechaRegistro(rs.getString("FechaRegistro"));
                                    
            return conciergebanquete;
        }
    }
}
