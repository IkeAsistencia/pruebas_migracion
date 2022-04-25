/*
 *
 *
 * Created on 26 de noviembre de 2011, 03:59 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.concierge;
import com.ike.concierge.to.ConciergeInfTuristCult;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author mmartinez
 */
public class DAOConciergeInfTuristCult extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeInfTuristCult() {
    }
    
    public ConciergeInfTuristCult getCSInfTuristCult(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenInfTuristCult ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new ConciergeventavipFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (ConciergeInfTuristCult) it.next() : null;
    }
    
    
    public class ConciergeventavipFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            ConciergeInfTuristCult ConciergeInfTuristCult = new ConciergeInfTuristCult();
            
            ConciergeInfTuristCult.setCargoT(rs.getString("CargoT"));
            ConciergeInfTuristCult.setCentroComer(rs.getString("CentroComer"));
            ConciergeInfTuristCult.setClAsistencia(rs.getString("clAsistencia"));
            ConciergeInfTuristCult.setClInfTuristCult(rs.getString("clInfTuristCult"));;
            ConciergeInfTuristCult.setClTipoPago(rs.getString("clTipoPago"));;
            ConciergeInfTuristCult.setClUsrApp(rs.getString("clUsrApp"));;
            ConciergeInfTuristCult.setConfirmo(rs.getString("Confirmo"));;
            ConciergeInfTuristCult.setDescripMenores(rs.getString("DescripMenores"));
            ConciergeInfTuristCult.setDescripOtros(rs.getString("DescripOtros"));
            ConciergeInfTuristCult.setDescripcionEvento(rs.getString("DescripcionEvento"));
            ConciergeInfTuristCult.setDsEstatus(rs.getString("dsEstatus"));
            ConciergeInfTuristCult.setDsTipoPago(rs.getString("dsTipoPago"));
            ConciergeInfTuristCult.setEventosCult(rs.getString("EventosCult"));
            ConciergeInfTuristCult.setEventosDep(rs.getString("EventosDep"));
            ConciergeInfTuristCult.setExpira(rs.getString("Expira"));
            ConciergeInfTuristCult.setExpira2(rs.getString("Expira"));
            ConciergeInfTuristCult.setFechaFin(rs.getString("FechaFin"));
            ConciergeInfTuristCult.setFechaI(rs.getString("FechaI"));
            ConciergeInfTuristCult.setFechaInicio(rs.getString("FechaInicio"));
            ConciergeInfTuristCult.setFechaO(rs.getString("FechaO"));
            ConciergeInfTuristCult.setFechaRegistro(rs.getString("FechaRegistro"));
            ConciergeInfTuristCult.setInfLocal(rs.getString("InfLocal"));
            ConciergeInfTuristCult.setHotel(rs.getString("Hotel"));
            ConciergeInfTuristCult.setMenores(rs.getString("Menores"));
            ConciergeInfTuristCult.setMuseoGaleria(rs.getString("MuseoGaleria"));
            ConciergeInfTuristCult.setNConfirmo(rs.getString("NConfirmo"));
            ConciergeInfTuristCult.setNomBanco(rs.getString("NomBanco"));
            ConciergeInfTuristCult.setNombreTC(rs.getString("NombreTC"));
            ConciergeInfTuristCult.setNuInf(rs.getString("NuInf"));
            ConciergeInfTuristCult.setNumeroTC(rs.getString("NumeroTC"));
            ConciergeInfTuristCult.setNumeroTCD(rs.getString("NumeroTCD"));
            ConciergeInfTuristCult.setOtros(rs.getString("Otros"));
            ConciergeInfTuristCult.setPCancel(rs.getString("PCancel"));
            ConciergeInfTuristCult.setParques(rs.getString("Parques"));
            ConciergeInfTuristCult.setRequisitos(rs.getString("Requisitos"));
            ConciergeInfTuristCult.setReservacion(rs.getString("Reservacion"));
            ConciergeInfTuristCult.setSecC(rs.getString("SecC"));
            ConciergeInfTuristCult.setSitiosInteres(rs.getString("SitiosInteres"));
            return ConciergeInfTuristCult;
        }
    }
}
