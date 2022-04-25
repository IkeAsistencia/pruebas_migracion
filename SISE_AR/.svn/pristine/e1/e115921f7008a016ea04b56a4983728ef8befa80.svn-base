/*
 *
 *
 * Created on 18 de agosto de 2006, 09:48 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.concierge;
import com.ike.concierge.to.Conciergecomprasvip;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOConciergeComprasVIP extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeComprasVIP() {
    }
     
    public Conciergecomprasvip getCSVentasVIP(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenComprasVIP ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new ConciergeventavipFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergecomprasvip) it.next() : null;
    }
    
    
    public class ConciergeventavipFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergecomprasvip conciergecomprasvip = new Conciergecomprasvip();
            conciergecomprasvip.setClventavip(rs.getString("clventavip"));
            conciergecomprasvip.setClAsistencia(rs.getString("clAsistencia"));
            conciergecomprasvip.setDsArticulo(rs.getString("dsArticulo"));
            conciergecomprasvip.setCosto(rs.getString("Costo"));
            conciergecomprasvip.setDestinatario(rs.getString("Destinatario"));
            conciergecomprasvip.setDireccion(rs.getString("Direccion"));
            conciergecomprasvip.setCiudad(rs.getString("Ciudad"));
            conciergecomprasvip.setEstado(rs.getString("Estado"));
            conciergecomprasvip.setPais(rs.getString("Pais"));
            conciergecomprasvip.setTelefonoD(rs.getString("TelefonoD"));
            conciergecomprasvip.setOtroTelD(rs.getString("OtroTelD"));
            conciergecomprasvip.setFechaE(rs.getString("FechaE"));
            conciergecomprasvip.setMetodo(rs.getString("Metodo"));
            conciergecomprasvip.setMensajeria(rs.getString("Mensajeria"));
            conciergecomprasvip.setGuia(rs.getString("Guia"));
            conciergecomprasvip.setCargoT(rs.getString("CargoT"));
            conciergecomprasvip.setRemitente(rs.getString("Remitente"));
            conciergecomprasvip.setTelefono(rs.getString("Telefono"));
            conciergecomprasvip.setCelular(rs.getString("Celular"));
            conciergecomprasvip.setClTipoPago(rs.getString("clTipoPago"));
            conciergecomprasvip.setNomBanco(rs.getString("NomBanco"));
            conciergecomprasvip.setNombreTC(rs.getString("NombreTC"));
            conciergecomprasvip.setClTipoTarjeta(rs.getString("clTipoTarjeta"));
            conciergecomprasvip.setNumeroTC(rs.getString("NumeroTC"));
            conciergecomprasvip.setExpira(rs.getString("Expira"));
            conciergecomprasvip.setExpira2(rs.getString("Expira2"));
            conciergecomprasvip.setSecC(rs.getString("SecC"));
            conciergecomprasvip.setPagoO(rs.getString("PagoO"));
            conciergecomprasvip.setConfirmo(rs.getString("Confirmo"));
            conciergecomprasvip.setNConfirmo(rs.getString("NConfirmo"));
            conciergecomprasvip.setPCancel(rs.getString("PCancel"));
            conciergecomprasvip.setNuInf(rs.getString("NuInf"));
            conciergecomprasvip.setComentarios(rs.getString("Comentarios"));
            conciergecomprasvip.setEstatus(rs.getString("Estatus"));
            conciergecomprasvip.setDsEstatus(rs.getString("dsEstatus"));
            conciergecomprasvip.setDsTipoPago(rs.getString("dsTipoPago"));
            conciergecomprasvip.setDsTipoTarjeta(rs.getString("dsTipoTarjeta"));
            conciergecomprasvip.setFechaRegistro(rs.getString("FechaRegistro"));
            return conciergecomprasvip;
        }
    }
}
