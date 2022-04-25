/*
 * DAOAsistencias.java
 *
 * Created on 14 de marzo de 2007, 03:43 PM
 */

package com.ike.asistencias;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import com.ike.asistencias.to.ExpedienteAsistido;

public class DAOAsistencias extends com.ike.model.DAOBASE
{
    /* Creates a new instance of DAOHelpdesk */
    public DAOAsistencias()
    {
        
    }
    
    public ExpedienteAsistido getclExpediente(String clExpediente) throws DAOException
    {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        
        sb.append("st_ObtenAsistencias ").append(clExpediente);
        
        col = this.rsSQLNP(sb.toString(), new ExpedienteAsistidoFiller());
        
        Iterator it = col.iterator();
        return it.hasNext() ? (ExpedienteAsistido) it.next() : null;
        
    }
    
    public class ExpedienteAsistidoFiller implements com.ike.model.LlenaDatos
    {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException
        {
            ExpedienteAsistido Asiste = new ExpedienteAsistido();

            Asiste.setclExpediente(rs.getString("clExpediente"));
            Asiste.setClaveAMIS(rs.getString("ClaveAMIS"));
            Asiste.setdsTipoAuto(rs.getString("dsTipoAuto"));
            Asiste.setCodigoMarca(rs.getString("CodigoMarca"));
            Asiste.setdsMarcaAuto(rs.getString("dsMarcaAuto"));
            Asiste.setModelo(rs.getString("Modelo"));
            Asiste.setColor(rs.getString("Color"));
            Asiste.setclTipoFalla(rs.getString("clTipoFalla"));
            Asiste.setdsTipoFalla(rs.getString("dsTipoFalla"));
            Asiste.setColonia(rs.getString("Colonia"));
            Asiste.setReferencias(rs.getString("Referencias"));
            Asiste.setCalleNum(rs.getString("CalleNum"));
            Asiste.setclTipoGrua(rs.getString("clTipoGrua"));
            Asiste.setdsTipoGrua(rs.getString("dsTipoGrua"));
            Asiste.setclTipoGasolina(rs.getString("clTipoGasolina"));
            Asiste.setdsTipoGasolina(rs.getString("dsTipoGasolina"));
            Asiste.setLitros(rs.getString("Litros"));
            Asiste.setclLiquidoAuto(rs.getString("clLiquidoAuto"));
            Asiste.setdsLiquidoAuto(rs.getString("dsLiquidoAuto"));
            Asiste.setPlacas(rs.getString("Placas"));
            Asiste.setReferenciasDest(rs.getString("ReferenciasDest"));
            Asiste.setNoSiniestro(rs.getString("NoSiniestro"));
            Asiste.setNoPoliza(rs.getString("NoPoliza"));
            Asiste.setAjustador(rs.getString("Ajustador"));
            Asiste.setTelAjustador(rs.getString("TelAjustador"));
            Asiste.setCodEntDest(rs.getString("CodEntDest"));
            Asiste.setdsEntFedDest(rs.getString("dsEntFedDest"));
            Asiste.setCodMDDest(rs.getString("CodMDDest"));
            Asiste.setdsMunDelDest(rs.getString("dsMunDelDest"));
            Asiste.setColoniaDest(rs.getString("ColoniaDest"));
            Asiste.setCalleNumDest(rs.getString("CalleNumDest"));
            Asiste.setclLugarEvento(rs.getString("clLugarEvento"));
            Asiste.setdsLugarEvento(rs.getString("dsLugarEvento"));
            Asiste.setclConcesionarioGM(rs.getString("clConcesionarioGM"));
            Asiste.setdsConcesionarioGM(rs.getString("dsConcesionarioGM"));
            Asiste.setKM(rs.getString("KM"));
            Asiste.setclTipoFallaGM(rs.getString("clTipoFallaGM"));
            Asiste.setdsTipoFallaGM(rs.getString("dsTipoFallaGM"));
            Asiste.setclDealerBMW(rs.getString("clDealerBMW"));
            Asiste.setDealer(rs.getString("Dealer"));
            Asiste.setNombreSMS(rs.getString("NombreSMS"));
            Asiste.setclTiempoContacto(rs.getString("clTiempoContacto"));
            Asiste.setdsTiempoContacto(rs.getString("dsTiempoContacto"));
            Asiste.setCodEnt(rs.getString("CodEnt"));
            Asiste.setdsEntFed(rs.getString("dsEntFed"));
            Asiste.setCodMD(rs.getString("CodMD"));
            Asiste.setdsMunDel(rs.getString("dsMunDel"));
            return Asiste;
        }
    }
}
