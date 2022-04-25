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
import com.ike.concierge.to.Conciergetour;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOConciergeTour extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeTour() {
    }
    
    public Conciergetour getCSTour(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenTour ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new ConciergeventavipFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergetour) it.next() : null;
    }
    
    
    public class ConciergeventavipFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergetour conciergetour = new Conciergetour();
            conciergetour.setClTour(rs.getString("clTour"));
            conciergetour.setClAsistencia(rs.getString("clAsistencia"));
            conciergetour.setNadultos(rs.getString("Nadultos"));
            conciergetour.setNinos(rs.getString("Ninos"));
            conciergetour.setEdades(rs.getString("Edades"));
            conciergetour.setTour(rs.getString("Tour"));
            conciergetour.setVehiculo(rs.getString("vehiculo"));
            conciergetour.setCiudad(rs.getString("Ciudad"));
            conciergetour.setEstado(rs.getString("Estado"));
            conciergetour.setPais(rs.getString("Pais"));
            conciergetour.setFechaIn(rs.getString("FechaIn"));
            conciergetour.setFechaFi(rs.getString("FechaFi"));
            conciergetour.setCostoH(rs.getString("CostoH"));
            conciergetour.setHorasC(rs.getString("HorasC"));
            conciergetour.setCostoP(rs.getString("CostoP"));
            conciergetour.setOtrosC(rs.getString("OtrosC"));
            conciergetour.setCargoT(rs.getString("CargoT"));            
            conciergetour.setEncuentro(rs.getString("Encuentro"));
            conciergetour.setHorario(rs.getString("Horario"));             
            conciergetour.setHotel(rs.getString("Hotel"));
            conciergetour.setFechaI(rs.getString("FechaI"));
            conciergetour.setReservacion(rs.getString("Reservacion"));
            conciergetour.setFechaO(rs.getString("FechaO"));
            conciergetour.setClTipoPago(rs.getString("clTipoPago"));
            conciergetour.setNomBanco(rs.getString("NomBanco"));
            conciergetour.setNombreTC(rs.getString("NombreTC"));
            conciergetour.setNumeroTC(rs.getString("NumeroTC"));
            conciergetour.setExpira2(rs.getString("Expira2"));
            conciergetour.setSecC(rs.getString("SecC"));
            conciergetour.setConfirmo(rs.getString("Confirmo"));
            conciergetour.setNConfirmo(rs.getString("NConfirmo"));
            conciergetour.setPCancel(rs.getString("PCancel"));
            conciergetour.setNuInf(rs.getString("NuInf"));
            conciergetour.setComentarios(rs.getString("Comentarios"));
            conciergetour.setEstatus(rs.getString("Estatus"));
            conciergetour.setDsEstatus(rs.getString("dsEstatus"));
            conciergetour.setDsTipoPago(rs.getString("dsTipoPago"));
            conciergetour.setExpira(rs.getString("Expira"));
            conciergetour.setFechaRegistro(rs.getString("FechaRegistro"));
            return conciergetour;
        }
    }
}
