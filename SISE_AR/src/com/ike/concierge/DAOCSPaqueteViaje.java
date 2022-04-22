/*
 * DAOCSPaqueteViaje.java
 * 
 * Created 2011-02-04
 * 
 */ 
 
package com.ike.concierge;
import com.ike.concierge.to.CSPaqueteViaje;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
  
/*
 *
 * @autor rfernandez
 */
 public class DAOCSPaqueteViaje extends com.ike.model.DAOBASE { 
  
    /* Creates a new instance of DAOCSPaqueteViaje */ 
    public DAOCSPaqueteViaje() { 
    } 
  
    public CSPaqueteViaje getCSPaqueteViaje ( String StrclAsistencia ) throws DAOException {
        StringBuffer sb = new StringBuffer(); 
        Collection col = null; 
        sb.append("st_CSPaqueteViaje ").append(StrclAsistencia);
        col = this.rsSQLNP(sb.toString(), new CSPaqueteViajeFiller());  
        Iterator it = col.iterator();  
        return it.hasNext() ? (CSPaqueteViaje) it.next() : null;
    } 
  
    /* Creates Filler of CSPaqueteViaje */ 
    public class CSPaqueteViajeFiller implements com.ike.model.LlenaDatos { 
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException { 
            CSPaqueteViaje PV = new CSPaqueteViaje();
 
            PV.setclPaqueteViaje(rs.getString("clPaqueteViaje")); 
            PV.setclAsistencia(rs.getString("clAsistencia")); 
            PV.setCdOrigenV(rs.getString("CdOrigenV")); 
            PV.setCdDestinoV(rs.getString("CdDestinoV")); 
            PV.setNoNoches(rs.getString("NoNoches")); 
            PV.setAdultos(rs.getString("Adultos")); 
            PV.setMenores(rs.getString("Menores")); 
            PV.setEdades(rs.getString("Edades")); 
            PV.setNoVuelo(rs.getString("NoVuelo")); 
            PV.setClase(rs.getString("Clase")); 
            PV.setOperadox(rs.getString("Operadox")); 
            PV.setCdOrigen(rs.getString("CdOrigen")); 
            PV.setCdDestino(rs.getString("CdDestino")); 
            PV.setAptOrigen(rs.getString("AptOrigen")); 
            PV.setAptDestino(rs.getString("AptDestino")); 
            PV.setFechaSalida(rs.getString("FechaSalida")); 
            PV.setFechaArribo(rs.getString("FechaArribo")); 
            PV.setNoVuelo1(rs.getString("NoVuelo1")); 
            PV.setClase1(rs.getString("Clase1")); 
            PV.setOperadox1(rs.getString("Operadox1")); 
            PV.setCdOrigen1(rs.getString("CdOrigen1")); 
            PV.setCdDestino1(rs.getString("CdDestino1")); 
            PV.setAptOrigen1(rs.getString("AptOrigen1")); 
            PV.setAptDestino1(rs.getString("AptDestino1")); 
            PV.setFechaSalida1(rs.getString("FechaSalida1")); 
            PV.setFechaArribo1(rs.getString("FechaArribo1")); 
            PV.setConexiones(rs.getString("Conexiones")); 
            PV.setTiempoLimite(rs.getString("TiempoLimite")); 
            PV.setNombreHotel(rs.getString("NombreHotel")); 
            PV.setTipoHabitacion(rs.getString("TipoHabitacion")); 
            PV.setReservaNom(rs.getString("ReservaNom")); 
            PV.setIncluye(rs.getString("Incluye")); 
            PV.setNoHabitaciones(rs.getString("NoHabitaciones")); 
            PV.setCheckInn(rs.getString("CheckInn")); 
            PV.setCheckout(rs.getString("Checkout")); 
            PV.setObservaciones(rs.getString("Observaciones")); 
            PV.setCostoTotal(rs.getString("CostoTotal")); 
            PV.setCostoNocheAd(rs.getString("CostoNocheAd")); 
            PV.setclTipoPago(rs.getString("clTipoPago")); 
            PV.setdsTipoPago(rs.getString("dsTipoPago"));
            PV.setNomBanco(rs.getString("NomBanco")); 
            PV.setNombreTC(rs.getString("NombreTC")); 
            PV.setNumeroTC(rs.getString("NumeroTC")); 
            PV.setExpira(rs.getString("Expira")); 
            PV.setSecC(rs.getString("SecC")); 
            PV.setConfirmo(rs.getString("Confirmo")); 
            PV.setNumConfirmacion(rs.getString("NumConfirmacion")); 
            PV.setCancelacion(rs.getString("Cancelacion")); 
            PV.setNUInfo(rs.getString("NUInfo")); 
            PV.setComentarios(rs.getString("Comentarios"));
            PV.setclEstatus(rs.getString("clEstatus"));
            PV.setdsEstatus(rs.getString("dsEstatus"));
            PV.setFechaRegistro(rs.getString("FechaRegistro"));
 
            return PV;
        } 
    } 
  
 } 
