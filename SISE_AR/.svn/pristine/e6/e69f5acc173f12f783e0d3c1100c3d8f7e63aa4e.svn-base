/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import com.ike.asistencias.to.DetalleProveedor; //Debe ser la clase de los getters y setters

public class DAODetalleProveedor extends com.ike.model.DAOBASE {

    public DAODetalleProveedor() {
    }

    public DetalleProveedor getDetalleProveedor(String clProveedor) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;
        //Variable del DAO
        sb.append("st_Intervenciones ");

        col = this.rsSQLNP(sb.toString(), new DetalleProveedorFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (DetalleProveedor) it.next() : null;
    }

    public class DetalleProveedorFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            DetalleProveedor DetProv = new DetalleProveedor();
            DetProv.setClProveedor(rs.getString("clProveedor"));
            DetProv.setNombreRZ(rs.getString("NombreRZ"));
            DetProv.setNombreOpe(rs.getString("NombreOpe"));
            DetProv.setActivo(rs.getString("Activo"));
            DetProv.setFechaAlta(rs.getString("FechaAlta"));
            DetProv.setFechaBaja(rs.getString("FechaBaja"));
            DetProv.setClGiro(rs.getString("clGiro"));
            DetProv.setCodEnt(rs.getString("CodEnt"));
            DetProv.setCodMD(rs.getString("CodMD"));
            DetProv.setColonia(rs.getString("Colonia"));
            DetProv.setCalle(rs.getString("Calle"));
            DetProv.setTitular(rs.getString("Titular"));
            DetProv.setCP(rs.getString("CP"));
            DetProv.setRFC(rs.getString("RFC"));
            DetProv.setHorario(rs.getString("Horario"));
            DetProv.setClBanco(rs.getString("clBanco"));
            DetProv.setPlazaBan(rs.getString("PlazaBan"));
            DetProv.setSucursalBan(rs.getString("SucursalBan"));
            DetProv.setTipoCuentaBan(rs.getString("TipoCuentaBan"));
            DetProv.setCuentaBan(rs.getString("CuentaBan"));
            DetProv.setANombreDe(rs.getString("ANombreDe"));
            DetProv.setNumNextel(rs.getString("NumNextel"));
            DetProv.setClTipoProveedor(rs.getString("clTipoProveedor"));
            DetProv.setClAreaOperativa(rs.getString("clAreaOperativa"));
            DetProv.setPrioridad(rs.getString("Prioridad"));
            DetProv.setFechaContratacion(rs.getString("FechaContratacion"));
            DetProv.setClabe(rs.getString("Clabe"));
            DetProv.setClGerenciaReg(rs.getString("clGerenciaReg"));
            DetProv.setCitas(rs.getString("Citas"));
            DetProv.setExperiencia(rs.getString("Experiencia"));
            DetProv.setEdoCuenta(rs.getString("EdoCuenta"));
            DetProv.setCopiaFactura(rs.getString("CopiaFactura"));
            DetProv.setFotografias(rs.getString("Fotografias"));
            DetProv.setInfraestructura(rs.getString("Infraestructura"));
            DetProv.setCopiaRFC(rs.getString("CopiaRFC"));
            DetProv.setCopiaIdent(rs.getString(""));
            DetProv.setCopiaImpre(rs.getString(""));
            DetProv.setCopiaSegUni(rs.getString(""));
            DetProv.setCheckList(rs.getString(""));
            DetProv.setConvenio(rs.getString(""));
            DetProv.setFicha(rs.getString(""));
            DetProv.setConocimientos(rs.getString(""));
            DetProv.setClProveedorAnt(rs.getString(""));
            DetProv.setObservaciones(rs.getString(""));
            DetProv.setTitulo(rs.getString(""));
            DetProv.setCedula(rs.getString(""));
            DetProv.setRecertificacion(rs.getString(""));
            DetProv.setEspecialidad(rs.getString(""));
            DetProv.setDiplomaEsp(rs.getString(""));
            DetProv.setAdiestramiento(rs.getString(""));
            DetProv.setCedulaEsp(rs.getString(""));
            DetProv.setCertificado(rs.getString(""));
            DetProv.setCURP(rs.getString(""));
            DetProv.setClEspecialidad(rs.getString(""));
            DetProv.setClSubEspecialidad(rs.getString(""));
            DetProv.setClTipoTabulador(rs.getString(""));
            DetProv.setAprobado(rs.getString(""));
            return DetProv;
        }
    }
}
