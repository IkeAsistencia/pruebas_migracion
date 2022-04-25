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
import com.ike.concierge.to.Conciergeauto;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOConciergeAuto extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeAuto() {
    }
    
    public Conciergeauto getCSAuto(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenAuto ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new ConciergeautoFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergeauto) it.next() : null;
    }
    
    
    public class ConciergeautoFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergeauto conciergeauto = new Conciergeauto();
            conciergeauto.setClAuto(rs.getString("clAuto"));
            conciergeauto.setClAsistencia(rs.getString("clAsistencia"));
            conciergeauto.setVehiculo(rs.getString("Vehiculo"));
            conciergeauto.setPasajeros(rs.getString("Pasajeros"));
            conciergeauto.setCiudad(rs.getString("Ciudad"));
            conciergeauto.setEstado(rs.getString("Estado"));
            conciergeauto.setPais(rs.getString("Pais"));
            conciergeauto.setFechaE(rs.getString("FechaE"));
            conciergeauto.setLugarEn(rs.getString("LugarEn"));
            conciergeauto.setFechaD(rs.getString("FechaD"));
            conciergeauto.setLugarDev(rs.getString("LugarDev"));
            conciergeauto.setCostoH(rs.getString("CostoH"));
            conciergeauto.setHorasC(rs.getString("HorasC"));
            conciergeauto.setCargoT(rs.getString("CargoT"));
            conciergeauto.setAdicionales(rs.getString("Adicionales"));
            conciergeauto.setSolAdic(rs.getString("SolAdic"));
            conciergeauto.setHotel(rs.getString("Hotel"));
            conciergeauto.setFechaI(rs.getString("FechaI"));
            conciergeauto.setReservacion(rs.getString("Reservacion"));
            conciergeauto.setFechaO(rs.getString("FechaO"));
            conciergeauto.setClTipoPago(rs.getString("clTipoPago"));
            conciergeauto.setNomBanco(rs.getString("NomBanco"));
            conciergeauto.setNombreTC(rs.getString("NombreTC"));
            conciergeauto.setNumeroTC(rs.getString("NumeroTC"));
            conciergeauto.setExpira2(rs.getString("Expira2"));
            conciergeauto.setSecC(rs.getString("SecC"));
            conciergeauto.setConfirmo(rs.getString("Confirmo"));
            conciergeauto.setNConfirmo(rs.getString("NConfirmo"));
            conciergeauto.setPCancel(rs.getString("PCancel"));
            conciergeauto.setNuInf(rs.getString("NuInf"));
            conciergeauto.setComentarios(rs.getString("Comentarios"));
            conciergeauto.setEstatus(rs.getString("Estatus"));
            conciergeauto.setDsEstatus(rs.getString("dsEstatus"));
            conciergeauto.setDsTipoPago(rs.getString("dsTipoPago"));
            conciergeauto.setExpira(rs.getString("Expira"));
            conciergeauto.setFechaRegistro(rs.getString("FechaRegistro"));
            return conciergeauto;
        }
    }
}
