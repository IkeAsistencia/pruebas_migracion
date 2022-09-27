package com.ike.asistencias;

import com.ike.asistencias.to.AsistenciaVial;
import com.ike.asistencias.to.InfoAdicionalKM0;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

//------------------------------------------------------------------------------
public class DAOAsistenciaVial extends com.ike.model.DAOBASE {
//------------------------------------------------------------------------------
    public DAOAsistenciaVial() {    }
//------------------------------------------------------------------------------
    public AsistenciaVial getAsistenciaVial(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_getAsistenciaVial ").append(clExpediente);
        col = this.rsSQLNP(sb.toString(), new AsisVial());
        Iterator it = col.iterator();
        return it.hasNext() ? (AsistenciaVial) it.next() : null;
        }
//------------------------------------------------------------------------------
    public class AsisVial implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            AsistenciaVial AV = new AsistenciaVial();
            //  DATOS ORIGEN
            AV.setClExpediente(rs.getString("clExpediente"));
            AV.setColoniaO(rs.getString("ColoniaOrigen"));
            AV.setCalleO(rs.getString("CalleOrigen"));
            AV.setReferenciasO(rs.getString("ReferenciasOrigen"));
            //  DATOS ASISTENCIA
            AV.setClTipoFalla(rs.getString("clTipoFalla"));
            AV.setDsTipoFalla(rs.getString("dsTipoFalla"));
            AV.setClTipoGrua(rs.getString("clTipoGrua"));
            AV.setDsTipoGrua(rs.getString("dsTipoGrua"));
            AV.setModelo(rs.getString("Modelo"));
            AV.setColor(rs.getString("Color"));
            AV.setPatente(rs.getString("Patente"));
            AV.setClLugar(rs.getString("clLugarEvento"));
            AV.setDsLugar(rs.getString("dsLugarEvento"));
            AV.setClMarca(rs.getString("CodigoMarca"));
            AV.setDsMarca(rs.getString("dsMarcaAuto"));
            AV.setClTipoAuto(rs.getString("clTipoAuto"));
            AV.setDsTipoAuto(rs.getString("dsTipoAuto"));
            AV.setClTipoLiquido(rs.getString("clTipoLiquido"));
            AV.setDsTipoLiquido(rs.getString("dsTipoLiquido"));
            AV.setLitros(rs.getString("litros"));
            AV.setClPaisD(rs.getString("clPaisDest"));
            AV.setDsPaisD(rs.getString("dsPaisDest"));
            AV.setCodEntD(rs.getString("CodEntDest"));
            AV.setDsEntFedD(rs.getString("dsEntFedDest"));
            AV.setCodMDD(rs.getString("CodMDDest"));
            AV.setDsMunDelD(rs.getString("dsMunDelDest"));
            AV.setColoniaD(rs.getString("ColoniaDest"));
            AV.setCalleD(rs.getString("CalleNumDest"));
            AV.setReferenciasD(rs.getString("ReferenciasDest"));
            AV.setClTipoGas(rs.getString("clTipoGas"));
            AV.setDsTipoGas(rs.getString("dsTipoGas"));
            AV.setClTipoBici(rs.getString("clTipoBici"));
            AV.setDsTipoBici(rs.getString("dsTipoBici"));
            AV.setColoniaBici(rs.getString("ColoniaOBici"));
            AV.setCalleNumBici(rs.getString("CalleNumOBici"));
            AV.setReferenciasBici(rs.getString("ReferenciasOBici"));
            AV.setCotizaFlete(rs.getString("CotizaFlete"));
            AV.setCostoFlete(rs.getString("CostoFlete"));
            try {
                AV.setGeoLatLong(rs.getString("LatLong"));
                AV.setGeoLatLongD(rs.getString("LatLongDest"));
            }catch (Exception e) {  System.out.println("DAOAsistenciaVial:Error al setear geo fields. Error:" + e.toString() );   }
            try {
                AV.setFechaEntrada(rs.getString("FechaEntrada"));
                AV.setFechaSalida(rs.getString("FechaSalida"));
                AV.setObservaciones(rs.getString("Observaciones"));
                AV.setClaveAmis(rs.getString("ClaveAmis"));
            }catch (Exception e) {  System.out.println("DAOAsistenciaVial:Error al setear campos de GUARDERIA. Error:" + e.toString() );    }            
            AV.setClInfoAdicKMO( rs.getInt("clInfoAdicKMO") );
            return AV;
            }
    }
//------------------------------------------------------------------------------
        public InfoAdicionalKM0 getInfoAdicAsistenciaVial(String clInfoAdicKMO) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_getInfoAdicionalKM0 ").append(clInfoAdicKMO);
        col = this.rsSQLNP(sb.toString(), new InfoAdicAsisVial() );
        Iterator it = col.iterator();
        return it.hasNext() ? (InfoAdicionalKM0) it.next() : null;
        }
//------------------------------------------------------------------------------
    public class InfoAdicAsisVial implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {                       
            InfoAdicionalKM0 infoAdic = new InfoAdicionalKM0();
            infoAdic.setClInfoAdicKMO( rs.getInt("clInfoAdicKMO") );
            infoAdic.setClExpediente( rs.getInt("clExpediente") );
            infoAdic.setClUbicacionAuto( rs.getInt("clUbicacionAuto") );
            infoAdic.setClUbicacionAutoGaraje( rs.getInt("clUbicacionAutoGaraje") );
            infoAdic.setaNivelAbierto( rs.getInt("aNivelAbierto") );
            infoAdic.setNivelSubsuelo( rs.getInt("nivelSubsuelo") );
            infoAdic.setClTipoFalla( rs.getInt("clTipoFalla") );
            infoAdic.setDetalleFalla( rs.getString("detalleFalla") );
            infoAdic.setAutomatico( rs.getInt("automatico") );
            infoAdic.setRuedaBloqueada( rs.getInt("ruedaBloqueada") );
            infoAdic.setCantBloqueadas( rs.getInt("cantBloqueadas") );
            infoAdic.setDelanteraIzq( rs.getInt("delanteraIzq") );
            infoAdic.setDelanteraDer( rs.getInt("delanteraDer") );
            infoAdic.setTraseraIzq( rs.getInt("traseraIzq") );
            infoAdic.setTraseraDer( rs.getInt("traseraDer") );
            infoAdic.setTieneCarga( rs.getInt("tieneCarga") );
            infoAdic.setPesoCarga( rs.getInt("pesoCarga") );
            infoAdic.setTipoCarga( rs.getString("tipoCarga") ) ;
            infoAdic.setClCantPersona( rs.getInt("clCantPersona") );
            infoAdic.setCedulaVerdeVig( rs.getInt("cedulaVerdeVig") );
            infoAdic.setRecibeNombre( rs.getString("recibeNombre") );
            infoAdic.setRecibeCodArea( rs.getInt("recibeCodArea") );
            infoAdic.setRecibeNroTelef( rs.getLong("recibeNroTelef") );
            infoAdic.setClModifAuto( rs.getInt("clModifAuto") );
            infoAdic.setDistanciaPiso( rs.getInt("distanciaPiso") );
            infoAdic.setLargo( rs.getInt("largo") );
            infoAdic.setAlto( rs.getInt("alto") );
            infoAdic.setDetalleModif( rs.getString("detalleModif") );
            infoAdic.setRuedasDuales( rs.getInt("ruedasDuales") );
            /*Descripcion de las tablas asociadas (combo)*/
            infoAdic.setDsUbicacionAuto( rs.getString("dsUbicacionAuto") );
            infoAdic.setDsUbicacionAutoGaraje( rs.getString("dsUbicacionAutoGaraje") );
            infoAdic.setDsTipoFalla( rs.getString("dsTipoFalla") );
            infoAdic.setDsCantPersona( rs.getString("dsCantPersona") );
            infoAdic.setDsModifAuto( rs.getString("dsModifAuto") );
            infoAdic.setLugarEncajado( rs.getInt("lugarEncajado") );
            infoAdic.setLucesEncienden( rs.getInt("lucesEncienden") );
            infoAdic.setRuedaAuxEnCond( rs.getInt("ruedaAuxEnCond") );
            infoAdic.setTuercaSeguridad( rs.getInt("tuercaSeguridad") );
            infoAdic.setLlaveTuercaSeg(rs.getInt("llaveTuercaSeg") );
            infoAdic.setClTipoGasolina(rs.getInt("clTipoGasolina") );
            infoAdic.setDsTipoGasolina(rs.getString("dsTipoGasolina") );
            infoAdic.setClCantLitros(rs.getInt("clCantLitros") );
            infoAdic.setVehiculoLiberado(rs.getInt("vehiculoLiberado") );
            infoAdic.setEstadoVehiculo(rs.getString("estadoVehiculo") );
	    infoAdic.setDistTierraFirme(rs.getInt("distTierraFirme") );
            infoAdic.setCompraBateria(rs.getInt("compraBateria") );
            infoAdic.setServicioProgramado(rs.getInt("servicioProgramado") );
            infoAdic.setFechaProgramado(rs.getString("fechaProgramado") );
            infoAdic.setHoraDesdeProg(rs.getString("horaDesdeProg") );
            infoAdic.setHoraHastaProg(rs.getString("horaHastaProg") );
            infoAdic.setPeajesCubiertos(rs.getInt("peajesCubiertos") );
            infoAdic.setMontoCubierto(rs.getInt("montoCubierto") );
            infoAdic.setClEstacionamiento(rs.getInt("clEstacionamiento") );
            infoAdic.setKmAsistencia(rs.getInt("kmAsistencia") );
            infoAdic.setCoberturaTotalPeaje(rs.getBoolean("CoberturaTotalPeaje") );
            return infoAdic;
        }
    }
//------------------------------------------------------------------------------
}
