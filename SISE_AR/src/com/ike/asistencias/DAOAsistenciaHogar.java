package com.ike.asistencias;

import com.ike.asistencias.to.DetalleAsistenciaHogar;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

public class DAOAsistenciaHogar extends com.ike.model.DAOBASE {
//------------------------------------------------------------------------------
    public DAOAsistenciaHogar() {    }
//------------------------------------------------------------------------------
    public DetalleAsistenciaHogar getDetalleAsistenciaHogar(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        sb.append("st_getDetalleAsistenciaHogar ").append(clExpediente);
        col = this.rsSQLNP(sb.toString(), new DetalleAsistenciaHogarFiller());
        Iterator it = col.iterator();
        return it.hasNext() ? (DetalleAsistenciaHogar) it.next() : null;
        }
//------------------------------------------------------------------------------
    public class DetalleAsistenciaHogarFiller implements com.ike.model.LlenaDatos {
        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            DetalleAsistenciaHogar AH = new DetalleAsistenciaHogar();
            AH.setClExpediente(rs.getString("clExpediente"));
            AH.setColonia(rs.getString("Colonia"));
            AH.setCalle(rs.getString("Calle"));
            AH.setReferencias(rs.getString("Referencias"));
            AH.setCodEnt(rs.getString("CodEnt"));
            AH.setDsEntFed(rs.getString("dsEntFed"));
            AH.setCodMD(rs.getString("CodMD"));
            AH.setDsMunDel(rs.getString("dsMunDel"));
            AH.setCP(rs.getString("CP"));
            AH.setClTipoSolucion(rs.getString("clTipoSolucion"));
            AH.setDsTipoSolucion(rs.getString("dsTipoSolucion"));
            AH.setVerificador(rs.getString("Verificador"));
            AH.setMotivoServicio(rs.getString("MotivoServicio"));
            AH.setTiempoCobertura(rs.getString("TiempoCobertura"));
            AH.setObsInfo(rs.getString("ObsInfo"));
            AH.setCobertura(rs.getString("Cobertura"));
            AH.setCosto(rs.getString("Costo"));
            AH.setFueraZona(rs.getString("FueraZona"));
            AH.setVisitasVer(rs.getString("VisitasVer"));
            AH.setGestionF(rs.getString("GestionF"));
            AH.setInformeF(rs.getString("InformeF"));
            AH.setClUbFallaH(rs.getString("clUbFallaH"));
            AH.setClTipoFallaH(rs.getString("clTipoFallaH"));
            AH.setDsUbFallaH(rs.getString("dsUbFallaH"));
            AH.setClTipoFallaH(rs.getString("clTipoFallaH"));
            AH.setDsTipoFallaH(rs.getString("dsTipoFallaH"));
            AH.setDsTipoSolucion(rs.getString("dsTipoSolucion"));
            AH.setClGarantiaHogar(rs.getString("clGarantiaHogar"));
            AH.setDsGarantiaHogar(rs.getString("dsGarantiaHogar"));
            AH.setLatLong(rs.getString("LatLong"));
            AH.setPiso(rs.getString("Piso"));
            AH.setDepartamento(rs.getString("Departamento"));
            /*Nuevas columnas para HDI CRI*/
            AH.setClUbFallaHLugar(rs.getString("clUbFallaHLugar"));
            AH.setDsUbFallaHLugar(rs.getString("dsUbFallaHLugar"));
            AH.setQuienSeComunica(rs.getString("QuienSeComunica"));
            AH.setNecesitaProvisorio(rs.getString("NecesitaProvisorio"));
            AH.setClTipoCristalH(rs.getString("clTipoCristalH"));
            AH.setDsTipoCristalH(rs.getString("dsTipoCristalH"));
            AH.setClMotivoSiniestroH(rs.getString("clMotivoSiniestroH"));
            AH.setDsMotivoSiniestroH(rs.getString("dsMotivoSiniestroH"));
            AH.setFechaSiniestro(rs.getString("fechaSiniestro"));
            AH.setClTipoContactante(rs.getString("clTipoContactante"));
            AH.setDsTipoContactante(rs.getString("dsTipoContactante"));
            AH.setCoberturaFin(rs.getString("CoberturaFin"));
            AH.setPoliza(rs.getString("Poliza"));
            AH.setHoraCita(rs.getString("horaCita"));
            AH.setOtroMotivoSiniestro(rs.getString("OtroMotivoSiniestro"));
            AH.setOtroTipoCristal(rs.getString("OtroTipoCristal"));
            AH.setOtroTipoContactante(rs.getString("OtroTipoContactante"));
            AH.setDescripcionOtro(rs.getString("DescripcionOtro"));
            AH.setUbicacionOtro(rs.getString("UbicacionOtro"));
            AH.setFrigorias(rs.getString("Frigorias"));
            return AH;
        }
    }
//------------------------------------------------------------------------------
}