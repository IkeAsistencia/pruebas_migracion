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
import com.ike.concierge.to.Conciergeflores;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOConciergeFlores extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeFlores() {
    }
    
    public Conciergeflores getCSFlores(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenFlores ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new ConciergeventavipFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergeflores) it.next() : null;
    }
    
    
    public class ConciergeventavipFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            Conciergeflores conciergeflores = new Conciergeflores();
            conciergeflores.setClFlores(rs.getString("clFlores"));
            conciergeflores.setClAsistencia(rs.getString("clAsistencia"));
            conciergeflores.setDestinatario(rs.getString("Destinatario"));
            conciergeflores.setDireccion(rs.getString("Direccion"));
            conciergeflores.setCiudad(rs.getString("Ciudad"));
            conciergeflores.setEstado(rs.getString("Estado"));
            conciergeflores.setPais(rs.getString("Pais"));
            conciergeflores.setTelefonoD(rs.getString("TelefonoD"));
            conciergeflores.setCelularD(rs.getString("CelularD"));
            conciergeflores.setFechaE(rs.getString("FechaE"));
            conciergeflores.setRemitente(rs.getString("Remitente"));
            conciergeflores.setTelefonoR(rs.getString("TelefonoR"));
            conciergeflores.setCelularR(rs.getString("CelularR"));
            conciergeflores.setEvento(rs.getString("Evento"));
            conciergeflores.setCargoT(rs.getString("CargoT"));
            conciergeflores.setArreglo(rs.getString("Arreglo"));
            conciergeflores.setAdicionales(rs.getString("Adicionales"));
            conciergeflores.setDescripcion(rs.getString("Descripcion"));
            conciergeflores.setMensaje(rs.getString("Mensaje"));
            conciergeflores.setClTipoPago(rs.getString("clTipoPago"));
            conciergeflores.setNomBanco(rs.getString("NomBanco"));
            conciergeflores.setNombreTC(rs.getString("NombreTC"));
            conciergeflores.setNumeroTC(rs.getString("NumeroTC"));
            conciergeflores.setExpira2(rs.getString("Expira2"));
            conciergeflores.setSecC(rs.getString("SecC"));
            conciergeflores.setFloristaC(rs.getString("FloristaC"));
            conciergeflores.setRecibio(rs.getString("Recibio"));
            conciergeflores.setComentarios(rs.getString("Comentarios"));
            conciergeflores.setEstatus(rs.getString("Estatus"));
            conciergeflores.setDsEstatus(rs.getString("dsEstatus"));
            conciergeflores.setDsTipoPago(rs.getString("dsTipoPago"));
            conciergeflores.setExpira(rs.getString("Expira"));
            conciergeflores.setFechaRegistro(rs.getString("FechaRegistro"));
            return conciergeflores;
        }
    }
}
