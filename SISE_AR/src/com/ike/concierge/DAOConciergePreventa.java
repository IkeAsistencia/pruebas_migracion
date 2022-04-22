/*
 * DAOCSPreventa.java
 * 
 * Created 2010-09-09
 * 
 */ 
 
package com.ike.concierge;
import com.ike.concierge.to.ConciergePreventa;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
  
/*
 *
 * @autor rfernandez
 */
 public class DAOConciergePreventa extends com.ike.model.DAOBASE {
  
    /* Creates a new instance of DAOCSPreventa */ 
    public DAOConciergePreventa() {
    } 
  
    public ConciergePreventa getConciergePreventa (String StrclAsistencia ) throws DAOException {
        StringBuffer sb = new StringBuffer(); 
        Collection col = null; 
        sb.append("st_CSPreventa ").append(StrclAsistencia);

        //System.out.println("Store: "+sb);

         col = this.rsSQLNP(sb.toString(), new ConciergePreventaFiller());
        Iterator it = col.iterator();  
        return it.hasNext() ? (ConciergePreventa) it.next() : null;
    } 
  
    /* Creates Filler of CSPreventa */ 
    public class ConciergePreventaFiller implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException { 
            ConciergePreventa P = new ConciergePreventa();
         
            P.setClPreventa(rs.getString("clPreventa"));
            P.setClAsistencia(rs.getString("clAsistencia"));
            P.setDescripcion(rs.getString("Descripcion"));
            P.setFechaEvento(rs.getString("FechaEvento"));
            P.setDireccion(rs.getString("Direccion"));
            P.setCiudad(rs.getString("Ciudad"));
            P.setEstado(rs.getString("Estado"));
            P.setPais(rs.getString("Pais"));
            P.setTelefono(rs.getString("Telefono"));
            P.setCelular(rs.getString("Celular"));
            P.setCostoH(rs.getString("CostoH"));
            P.setHorasC(rs.getString("HorasC"));
            P.setCargoT(rs.getString("CargoT"));
            P.setClTipoPago(rs.getString("clTipoPago"));
            P.setNomBanco(rs.getString("NomBanco"));
            P.setNombreTC(rs.getString("NombreTC"));
            P.setNumeroTC(rs.getString("NumeroTC"));
            P.setExpira(rs.getString("Expira"));
            P.setSecC(rs.getString("SecC"));
            P.setPagoO(rs.getString("PagoO"));
            P.setConfirmo(rs.getString("Confirmo"));
            P.setNConfirmo(rs.getString("NConfirmo"));
            P.setPCancel(rs.getString("PCancel"));
            P.setNuInf(rs.getString("NuInf"));
            P.setComentarios(rs.getString("Comentarios"));
            P.setEstatus(rs.getString("Estatus"));
            P.setDsEstatus(rs.getString("dsEstatus"));
            P.setDsTipoPago(rs.getString("dsTipoPago"));
            P.setFechaRegistro(rs.getString("FechaRegistro"));
            P.setdsConcierto(rs.getString("dsConcierto"));
            P.setclConcierto(rs.getString("clConcierto"));
            return P;
        } 
    }   
 } 
