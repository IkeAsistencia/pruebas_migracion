package com.ike.asistencias;

import com.ike.asistencias.to.AsistenciaMoto;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author fcerqueda
 */
public class DAOAsistenciaMoto extends com.ike.model.DAOBASE {

    public DAOAsistenciaMoto() {
    }

    public AsistenciaMoto getDetalleAsistenciaMoto(String clExpediente) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_getAsistenciaMoto ").append(clExpediente);
        col = this.rsSQLNP(sb.toString(), new DetalleAsistenciaMoto());

        Iterator it = col.iterator();
        return it.hasNext() ? (AsistenciaMoto) it.next() : null;
    }

    public class DetalleAsistenciaMoto implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            AsistenciaMoto AM = new AsistenciaMoto();

            // DATOS DE ORIGEN
            AM.setClExpediente(rs.getString("clExpediente"));
            AM.setColoniaO(rs.getString("ColoniaOrigen"));
            AM.setCalleO(rs.getString("CalleOrigen"));
            AM.setReferenciasO(rs.getString("ReferenciasOrigen"));
            
            // DATOS DE ASISTENCIA
            AM.setClTipoFalla(rs.getString("clTipoFalla"));
            AM.setDsTipoFalla(rs.getString("dsTipoFalla"));
            AM.setClTipoGrua(rs.getString("clTipoGrua"));
            AM.setDsTipoGrua(rs.getString("dsTipoGrua"));
            AM.setModelo(rs.getString("Modelo"));
            AM.setColor(rs.getString("Color"));
            AM.setPatente(rs.getString("Patente"));
            AM.setClLugar(rs.getString("clLugarEvento"));
            AM.setDsLugar(rs.getString("dsLugarEvento"));
            AM.setClMarca(rs.getString("CodigoMarca"));
            AM.setDsMarca(rs.getString("dsMarcaMoto"));
            AM.setClTipoMoto(rs.getString("clTipoMoto"));
            AM.setDsTipoMoto(rs.getString("dsTipoMoto"));
            AM.setClTipoLiquido(rs.getString("clTipoLiquido"));
            AM.setDsTipoLiquido(rs.getString("dsTipoLiquido"));
            AM.setLitros(rs.getString("litros"));
            AM.setClPaisD(rs.getString("clPaisDest"));
            AM.setDsPaisD(rs.getString("dsPaisDest"));
            AM.setCodEntD(rs.getString("CodEntDest"));
            AM.setDsEntFedD(rs.getString("dsEntFedDest"));
            AM.setCodMDD(rs.getString("CodMDDest"));
            AM.setDsMunDelD(rs.getString("dsMunDelDest"));
            AM.setColoniaD(rs.getString("ColoniaDest"));
            AM.setCalleD(rs.getString("CalleNumDest"));
            AM.setReferenciasD(rs.getString("ReferenciasDest"));
            AM.setClTipoGas(rs.getString("clTipoGas"));
            AM.setDsTipoGas(rs.getString("dsTipoGas"));
            AM.setClTipoBici(rs.getString("clTipoBici"));
            AM.setDsTipoBici(rs.getString("dsTipoBici"));
            AM.setColoniaBici(rs.getString("ColoniaOBici"));
            AM.setCalleNumBici(rs.getString("CalleNumOBici"));
            AM.setReferenciasBici(rs.getString("ReferenciasOBici"));
            AM.setCotizaFlete(rs.getString("CotizaFlete"));
            AM.setCostoFlete(rs.getString("CostoFlete"));
            
            
            return AM;
        }
    }
}
