/*
 *
 *
 * Created on 16 de febrero de 2007, 09:48 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.concierge;
import com.ike.concierge.to.ConciergeAvionOneWay;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author zamoraed
 */
public class DAOAvionOneWay extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOAvionOneWay(){
    }
    
    public ConciergeAvionOneWay getCSAvionOneWay(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenAvionOneWay ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new conciergerentacasadeptoFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (ConciergeAvionOneWay) it.next() : null;
    }
    
    
    public class conciergerentacasadeptoFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            ConciergeAvionOneWay conciergeaviononeway = new ConciergeAvionOneWay();


            conciergeaviononeway.setclEstatus(rs.getString("clEstatus"));
            conciergeaviononeway.setdsEstatus(rs.getString("dsEstatus"));
            conciergeaviononeway.setclAsistencia(rs.getString("clAsistencia"));
            conciergeaviononeway.setComentarios(rs.getString("Comentarios"));

            conciergeaviononeway.setNoVuelo(rs.getString("NoVuelo"));
            conciergeaviononeway.setClase(rs.getString("Clase"));
            conciergeaviononeway.setOperadox(rs.getString("Operadox"));
            conciergeaviononeway.setCdOrigen(rs.getString("CdOrigen"));
            conciergeaviononeway.setCdDestino(rs.getString("CdDestino"));
            conciergeaviononeway.setAptOrigen(rs.getString("AptOrigen"));
            conciergeaviononeway.setAptDestino(rs.getString("AptDestino"));
            conciergeaviononeway.setFechaSalida(rs.getString("FechaSalida"));
            conciergeaviononeway.setFechaArribo(rs.getString("FechaArribo"));
            conciergeaviononeway.setConexiones(rs.getString("Conexiones"));
            conciergeaviononeway.setTiempoLimite(rs.getString("TiempoLimite"));
            conciergeaviononeway.setCdOrigen1(rs.getString("CdOrigen1"));
            conciergeaviononeway.setCdDestino1(rs.getString("CdDestino1"));
            conciergeaviononeway.setAptOrigen1(rs.getString("AptOrigen1"));
            conciergeaviononeway.setAptDestino1(rs.getString("AptDestino1"));
            conciergeaviononeway.setFechaSalida1(rs.getString("FechaSalida1"));
            conciergeaviononeway.setFechaArribo1(rs.getString("FechaArribo1"));
            conciergeaviononeway.setConexiones1(rs.getString("Conexiones1"));
            conciergeaviononeway.setTiempoLimite1(rs.getString("TiempoLimite1"));
            conciergeaviononeway.setCdOrigen2(rs.getString("CdOrigen2"));
            conciergeaviononeway.setCdDestino2(rs.getString("CdDestino2"));
            conciergeaviononeway.setAptOrigen2(rs.getString("AptOrigen2"));
            conciergeaviononeway.setAptDestino2(rs.getString("AptDestino2"));
            conciergeaviononeway.setFechaSalida2(rs.getString("FechaSalida2"));
            conciergeaviononeway.setFechaArribo2(rs.getString("FechaArribo2"));
            conciergeaviononeway.setConexiones2(rs.getString("Conexiones2"));
            conciergeaviononeway.setTiempoLimite2(rs.getString("TiempoLimite2"));
            conciergeaviononeway.setCdOrigen3(rs.getString("CdOrigen3"));
            conciergeaviononeway.setCdDestino3(rs.getString("CdDestino3"));
            conciergeaviononeway.setAptOrigen3(rs.getString("AptOrigen3"));
            conciergeaviononeway.setAptDestino3(rs.getString("AptDestino3"));
            conciergeaviononeway.setFechaSalida3(rs.getString("FechaSalida3"));
            conciergeaviononeway.setFechaArribo3(rs.getString("FechaArribo3"));
            conciergeaviononeway.setConexiones3(rs.getString("Conexiones3"));
            conciergeaviononeway.setTiempoLimite3(rs.getString("TiempoLimite3"));
   
            conciergeaviononeway.setdsTipoPago(rs.getString("dsTipoPago"));
            conciergeaviononeway.setclTipoPago(rs.getString("clTipoPago"));
            conciergeaviononeway.setNomBanco(rs.getString("NomBanco"));
            conciergeaviononeway.setNombreTC(rs.getString("NombreTC"));
            conciergeaviononeway.setNumeroTC(rs.getString("NumeroTC"));
            conciergeaviononeway.setExpira(rs.getString("Expira"));
            conciergeaviononeway.setSecC(rs.getString("SecC"));
            conciergeaviononeway.setConfirmo(rs.getString("Confirmo"));
            conciergeaviononeway.setNumConfirmacion(rs.getString("NumConfirmacion"));
            conciergeaviononeway.setCancelacion(rs.getString("Cancelacion"));
            conciergeaviononeway.setNUInfo(rs.getString("NUInfo"));
            conciergeaviononeway.setFechaRegistro(rs.getString("FechaRegistro"));
            
            return conciergeaviononeway;
        }
    }
}

