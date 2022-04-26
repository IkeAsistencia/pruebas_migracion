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
import com.ike.concierge.to.ConciergeRentaCasaDepto;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author zamoraed
 */
public class DAORentaCasaDepto extends com.ike.model.DAOBASE{
    
    /* Creates a new instance of DAOTelemarketing */
    public DAORentaCasaDepto() {
    }
    
    public ConciergeRentaCasaDepto getCSRentaCasaDepto(String StrclAsistencia) throws DAOException{
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        
        sb.append("st_CSObtenRentaCasaDepto ").append(StrclAsistencia);
        System.out.println(sb);
        
        col = this.rsSQLNP(sb.toString(), new conciergerentacasadeptoFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (ConciergeRentaCasaDepto) it.next() : null;
    }
    
    
    public class conciergerentacasadeptoFiller implements com.ike.model.LlenaDatos{
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{
            ConciergeRentaCasaDepto conciergerentacasadepto = new ConciergeRentaCasaDepto();
            conciergerentacasadepto.setclEstatus(rs.getString("clEstatus"));
            conciergerentacasadepto.setdsEstatus(rs.getString("dsEstatus"));
            conciergerentacasadepto.setComentarios(rs.getString("Comentarios"));
            conciergerentacasadepto.setNumAdultos(rs.getString("NumAdultos"));
            conciergerentacasadepto.setNinos(rs.getString("Ninos"));
            conciergerentacasadepto.setEdades(rs.getString("Edades"));
            conciergerentacasadepto.setTipoInmueble(rs.getString("TipoInmueble"));
            conciergerentacasadepto.setFechaI(rs.getString("FechaI"));
            conciergerentacasadepto.setFecha0(rs.getString("Fecha0"));
            conciergerentacasadepto.setServicios(rs.getString("Servicios"));
            conciergerentacasadepto.setCiudad(rs.getString("Ciudad"));
            conciergerentacasadepto.setEstado(rs.getString("Estado"));
            conciergerentacasadepto.setPais(rs.getString("Pais"));
            conciergerentacasadepto.setCostoxDia(rs.getString("CostoxDia"));
            conciergerentacasadepto.setOtrosCargos(rs.getString("OtrosCargos"));
            conciergerentacasadepto.setCargoTotal(rs.getString("CargoTotal"));
            conciergerentacasadepto.setLEntregaLlaves(rs.getString("LEntregaLlaves"));
            conciergerentacasadepto.setEntregaLlaves(rs.getString("EntregaLlaves"));
            conciergerentacasadepto.setclFormaPago(rs.getString("clFormaPago"));
            conciergerentacasadepto.setdsFormaPago(rs.getString("dsFormaPago"));
            conciergerentacasadepto.setNomBanco(rs.getString("NomBanco"));
            conciergerentacasadepto.setNombreTC(rs.getString("NombreTC"));
            conciergerentacasadepto.setNumeroTC(rs.getString("NumeroTC"));
            conciergerentacasadepto.setExpira(rs.getString("Expira"));
            conciergerentacasadepto.setSecC(rs.getString("SecC"));
            conciergerentacasadepto.setConfirmo(rs.getString("Confirmo"));
            conciergerentacasadepto.setNumConfirmacion(rs.getString("NumConfirmacion"));
            conciergerentacasadepto.setCancelacion(rs.getString("Cancelacion"));
            conciergerentacasadepto.setNUInfo(rs.getString("NUInfo"));
            conciergerentacasadepto.setClAsistencia(rs.getString("clAsistencia"));
            conciergerentacasadepto.setFechaRegistro(rs.getString("FechaRegistro"));

            return conciergerentacasadepto;
        }
    }
}

