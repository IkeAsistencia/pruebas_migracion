/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias;

import com.ike.asistencias.to.AsistenciaSeguros;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author fcerqueda
 */
public class DAOAsistenciaSeguros extends com.ike.model.DAOBASE {

    public DAOAsistenciaSeguros() {
    }

    public AsistenciaSeguros getSeguro(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_getSeguros ").append(clExpediente);

        col = this.rsSQLNP(sb.toString(), new AsistenciaSegurosClass());

        Iterator i = col.iterator();
        return i.hasNext() ? (AsistenciaSeguros) i.next() : null;
    }
    //Agregar DS pais aqui y en el contro pais

    public class AsistenciaSegurosClass implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            AsistenciaSeguros AS = new AsistenciaSeguros();

            AS.setclExpediente(rs.getString("clExpediente"));
            AS.setPersonaReporta(rs.getString("PersonaReporta"));
            AS.setDsTipoPersonaRep(rs.getString("dsTipoPersonaRep"));
            AS.setFechaDeceso(rs.getString("FechaDeceso"));
            AS.setclPais(rs.getString("clPais"));
            AS.setdsPais(rs.getString("dsPais"));
            AS.setCodEnt(rs.getString("CodEnt"));
            AS.setdsEntFed(rs.getString("dsEntFed"));
            AS.setCodMD(rs.getString("CodMD"));
            AS.setdsMunDel(rs.getString("dsMunDel"));
            AS.setEnvioAbogado(rs.getString("EnvioAbogado"));
            AS.setdsTipoReclamacion(rs.getString("dsTipoReclamacion"));
            AS.setNumCuentaDep(rs.getString("NumCuentaDep"));
            AS.setSucursal(rs.getString("Sucursal"));
            AS.setBanco(rs.getString("Banco"));
            AS.setNombreTitular(rs.getString("NombreTitular"));
            AS.setClabe(rs.getString("Clabe"));
            AS.setFechaPago(rs.getString("FechaPago"));
            AS.setCostoPagado(rs.getString("CostoPagado"));
            AS.setFechaApertura(rs.getString("FechaApertura"));
            AS.setFechaRegistro(rs.getString("FechaRegistro"));
            AS.setCartaReclama(rs.getString("CartaReclama"));
            AS.setDenunciaCopia(rs.getString("DenunciaCopia"));
            AS.setActaDefuncionCopia(rs.getString("ActaDefuncionCopia"));
            AS.setComprobanteUso(rs.getString("ComprobanteUso"));
            AS.setIdentOficialCopia(rs.getString("IdentOficialCopia"));
            AS.setTarjetaReclama(rs.getString("TarjetaReclama"));
            AS.setOtroDocto(rs.getString("OtroDocto"));
            return AS;
        }
    }
}
