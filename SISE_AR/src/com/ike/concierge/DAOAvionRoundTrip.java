/*
 *
 *
 * Created on 16 de febrero de 2007, 09:48 PM
 *
 */
package com.ike.concierge;
import com.ike.concierge.to.ConciergeAvionRoundTrip;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author zamoraed
 */
public class DAOAvionRoundTrip extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOAvionRoundTrip(){
    }
    
    public ConciergeAvionRoundTrip getCSAvionRoundTrip(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenAvionRoundTrip ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new conciergerentacasadeptoFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (ConciergeAvionRoundTrip) it.next() : null;
    }
    
    
    public class conciergerentacasadeptoFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            ConciergeAvionRoundTrip conciergeavionroundtrip = new ConciergeAvionRoundTrip();
            conciergeavionroundtrip.setclAvionRoundTrip(rs.getString("clAvionRoundTrip"));
            conciergeavionroundtrip.setclEstatus(rs.getString("clEstatus"));
            conciergeavionroundtrip.setdsEstatus(rs.getString("dsEstatus"));
            conciergeavionroundtrip.setclAsistencia(rs.getString("clAsistencia"));
            conciergeavionroundtrip.setComentarios(rs.getString("Comentarios"));
            conciergeavionroundtrip.setNumAdultos(rs.getString("NumAdultos"));
            conciergeavionroundtrip.setNumNinos(rs.getString("NumNinos"));
            conciergeavionroundtrip.setEdades(rs.getString("Edades"));
            conciergeavionroundtrip.setInfoVuelo(rs.getString("InfoVuelo"));
            conciergeavionroundtrip.setCargo(rs.getString("Cargo"));
            conciergeavionroundtrip.setCdOrigen(rs.getString("CdOrigen"));
            conciergeavionroundtrip.setCdDestino(rs.getString("CdDestino"));
            conciergeavionroundtrip.setAptOrigen(rs.getString("AptOrigen"));
            conciergeavionroundtrip.setAptDestino(rs.getString("AptDestino"));
            conciergeavionroundtrip.setFechaSalida(rs.getString("FechaSalida"));
            conciergeavionroundtrip.setFechaArribo(rs.getString("FechaArribo"));
            conciergeavionroundtrip.setConexiones(rs.getString("Conexiones"));
            conciergeavionroundtrip.setClase(rs.getString("Clase"));
            conciergeavionroundtrip.setTiempoLimite(rs.getString("TiempoLimite"));
            conciergeavionroundtrip.setdsFormaPago(rs.getString("dsFormaPago"));
            conciergeavionroundtrip.setclFormaPago(rs.getString("clFormaPago"));
            conciergeavionroundtrip.setNomBanco(rs.getString("NomBanco"));
            conciergeavionroundtrip.setNombreTC(rs.getString("NombreTC"));
            conciergeavionroundtrip.setNumeroTC(rs.getString("NumeroTC"));
            conciergeavionroundtrip.setExpira(rs.getString("Expira"));
            conciergeavionroundtrip.setSecC(rs.getString("SecC"));
            conciergeavionroundtrip.setConfirmo(rs.getString("Confirmo"));
            conciergeavionroundtrip.setNumConfirmacion(rs.getString("NumConfirmacion"));
            conciergeavionroundtrip.setCancelacion(rs.getString("Cancelacion"));
            conciergeavionroundtrip.setNUInfo(rs.getString("NUInfo"));
            conciergeavionroundtrip.setLugarPagar(rs.getString("LugarPagar"));
            conciergeavionroundtrip.setCveReservacion(rs.getString("CveReservacion"));
            conciergeavionroundtrip.setMetEntrega(rs.getString("MetEntrega"));
            conciergeavionroundtrip.setFechaRegistro(rs.getString("FechaRegistro"));

            return conciergeavionroundtrip;
        }
    }
}

