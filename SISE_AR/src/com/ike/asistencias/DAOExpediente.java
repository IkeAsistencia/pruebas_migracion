package com.ike.asistencias;

import com.ike.asistencias.to.Expediente;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

public class DAOExpediente extends com.ike.model.DAOBASE {

    public DAOExpediente() {
    }

    public Expediente getExpediente(String clExpediente) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("sp_DetalleExpediente ").append(clExpediente);
        col = this.rsSQLNP(sb.toString(), new ExpedienteFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (Expediente) it.next() : null;
    }

    public class ExpedienteFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {

            Expediente exp = new Expediente();
            exp.setClExpediente(rs.getString("clExpediente"));
            exp.setNuestroUsuario(rs.getString("NuestroUsuario"));
            exp.setContacto(rs.getString("Contacto"));
            exp.setClave(rs.getString("clave"));
            exp.setClDerechoHab(rs.getString("clDerechoHab"));
            exp.setNombre(rs.getString("Nombre"));
            exp.setFechaApertura(rs.getString("FechaApertura"));
            exp.setClCuenta(rs.getString("clCuenta"));
            exp.setFechaRegistro(rs.getString("FechaRegistro"));
            exp.setTelefono1(rs.getString("Telefono1"));
            exp.setTelefono2(rs.getString("Telefono2"));
            exp.setFechaSiniestro(rs.getString("FechaSiniestro"));
            exp.setDescripcionOcurrido(rs.getString("DescripcionOcurrido"));
            exp.setLada1(rs.getString("Lada1"));
            exp.setLada2(rs.getString("Lada2"));
            exp.setDsServicio(rs.getString("dsServicio"));
            exp.setDsSubServicio(rs.getString("dsSubServicio"));
            exp.setDsEntFed(rs.getString("dsEntFed"));
            exp.setDsMunDel(rs.getString("dsMunDel"));
            exp.setDsEstatus(rs.getString("dsEstatus"));
            exp.setClEstatus(rs.getString("clEstatus"));
            exp.setDsEstatusPolizaGNP(rs.getString("dsEstatusPolizaGNP"));
            exp.setCodEnt(rs.getString("CodEnt"));
            exp.setCodMD(rs.getString("CodMD"));
            exp.setCita(rs.getString("Cita"));
            exp.setFechaCita(rs.getString("FechaCita"));
            exp.setCotizacion(rs.getString("Cotizacion"));
            exp.setReferencias(rs.getString("Referencias"));
            exp.setUsrReg(rs.getString("UsrReg"));
            exp.setUsrAut(rs.getString("UsrAut"));
            exp.setFechaAut(rs.getString("FechaAut"));
            exp.setMotivoAut(rs.getString("MotivoAut"));
            exp.setClUsrApp(rs.getString("clUsrApp"));
            exp.setClUsrAppAut(rs.getString("clUsrAppAut"));
            exp.setAgente(rs.getString("Agente"));
            exp.setClPais(rs.getString("clPais"));
            exp.setDsPais(rs.getString("dsPais"));
            exp.setCiudadExt(rs.getString("CiudadExt"));
            exp.setClTipoContactante(rs.getString("clTipoContactante"));
            exp.setDsTipoContactante(rs.getString("dsTipoContactante"));
            exp.setEmail(rs.getString("Email"));
            exp.setClTipoServicio(rs.getString("clTipoServicio"));
            exp.setDsTipoServicio(rs.getString("dsTipoServicio"));
            exp.setDsTipoBeneficiario(rs.getString("dsTipoBeneficiario"));
            exp.setPermiteEnvioACobro(rs.getString("PermiteEnvioACobro"));
            exp.setSeMandaCobro(rs.getString("SeMandaCobro"));
            exp.setClaveMask(rs.getString("ClaveMask"));
            exp.setRevCalidad(rs.getString("RevCalidad"));
            exp.setClSolicitud(rs.getString("clSolicitud"));
            exp.setLongitud(rs.getString("longitud"));
            exp.setLatitud(rs.getString("latitud"));
            exp.setChckAlerta(rs.getString("chckAlerta"));
            exp.setObserAlerta(rs.getString("ObserAlerta"));
            exp.setCompania(rs.getString("Compania"));
            exp.setNoSiniestro(rs.getString("NoSiniestro"));
            exp.setTieneAsistencia(rs.getString("TieneAsistencia"));  ////agrego bandera 20150903
            exp.setClServicio(rs.getString("clServicio"));
            exp.setClSubServicio(rs.getString("clSubServicio"));
            exp.setChckAlertaPVD(rs.getString("chckAlertaPVD"));   
            exp.setEsDeApp(rs.getString("EsDeApp"));
            exp.setClCodigoCompania(rs.getString("clCodigoCompania"));
            exp.setDsCodigo(rs.getString("dsCodigo"));
            exp.setClExcepcion(rs.getString("clExcepcion"));
            exp.setDsExcepcion(rs.getString("dsExcepcion"));
            exp.setVip( "1".equals(rs.getString("VIP")) ? true:false );
            return exp;
        }
    }
}