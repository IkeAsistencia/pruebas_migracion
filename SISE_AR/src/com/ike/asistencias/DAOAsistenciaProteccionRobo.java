/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ike.asistencias;

import com.ike.asistencias.to.AsistenciaProteccionRobo;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author fcerqueda
 */
public class DAOAsistenciaProteccionRobo extends com.ike.model.DAOBASE {

    public DAOAsistenciaProteccionRobo() {
    }
    
    public AsistenciaProteccionRobo getAsistenciaProteccionRobo(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_getProteccionRobo ").append(clExpediente);

        col = this.rsSQLNP(sb.toString(), new AsistProcRobo());

        Iterator it = col.iterator();
        return it.hasNext() ? (AsistenciaProteccionRobo) it.next() : null;
    }
    
    public class AsistProcRobo implements com.ike.model.LlenaDatos{

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException{

               AsistenciaProteccionRobo APR = new AsistenciaProteccionRobo();

               APR.setClExpediente(rs.getString("clExpediente"));
               APR.setPersonaReporta(rs.getString("PersonaReporta"));
               APR.setClTipoPerReporta(rs.getString("clTipoPerReporta"));
               APR.setDsTipoPersonaRep(rs.getString("dsTipoPersonaRep"));
               APR.setDetalleRobado(rs.getString("DetalleRobado"));
               APR.setValor(rs.getString("Valor"));
               APR.setFechaSiniestro(rs.getString("FechaSiniestro"));
               APR.setClPais(rs.getString("clPais"));
               APR.setDsPais(rs.getString("dsPais"));
               APR.setCodEnt(rs.getString("CodEnt"));
               APR.setDsEntFed(rs.getString("dsEntFed"));
               APR.setCodMD(rs.getString("CodMD"));
               APR.setDsMunDel(rs.getString("dsMunDel"));
               APR.setEnvioAbogado(rs.getString("EnvioAbogado"));
               APR.setClTipoReclamacion(rs.getString("clTipoReclamacion"));
               APR.setDsTipoReclamacion(rs.getString("dsTipoReclamacion"));
               APR.setNumCuentaDep(rs.getString("NumCuentaDep"));
               APR.setSucursal(rs.getString("Sucursal"));
               APR.setBanco(rs.getString("Banco"));
               APR.setNombreTitular(rs.getString("NombreTitular"));
               APR.setClabe(rs.getString("Clabe"));
               APR.setFechaPago(rs.getString("FechaPago"));
               APR.setCostoPagado(rs.getString("CostoPagado"));
               APR.setFechaApertura(rs.getString("FechaApertura"));
               APR.setFechaRegistro(rs.getString("FechaRegistro"));
               APR.setDenunciaCopia(rs.getString("DenunciaCopia"));
               APR.setComprobanteUso(rs.getString("ComprobanteUso"));
               APR.setIdentOficialCopia(rs.getString("IdentOficialCopia"));
               APR.setTarjetaReclama(rs.getString("TarjetaReclama"));
               APR.setCartaReclama(rs.getString("CartaReclama"));
               APR.setOtroDocto(rs.getString("OtroDocto"));

               return APR;
        }
    }
}
