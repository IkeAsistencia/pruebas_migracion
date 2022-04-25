/*
 * DAOUsuarios.java
 *
 * Created on 18 de mayo de 2009, 05:16 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.ike.catalogos;

import com.ike.catalogos.to.Proveedor;
import com.ike.model.DAOException;
import java.util.Collection;
import java.util.Iterator;

/*
 *
 * @author rfernandez
 */
public class DAOProveedor extends com.ike.model.DAOBASE {

    public DAOProveedor() {
    }

    public Proveedor getProveedor(String clProveedor, String clUsrApp) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("sp_DetalleProveedor '").append(clProveedor).append("','").append(clUsrApp).append("'");

        col = this.rsSQLNP(sb.toString(), new ProveedorFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (Proveedor) it.next() : null;
    }

    public class ProveedorFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            Proveedor prov = new Proveedor();

            prov.setANombreDe(rs.getString("ANombreDe"));
            prov.setActivo(rs.getString("Activo"));
            prov.setAdiestramiento(rs.getString("Adiestramiento"));
            prov.setAprobado(rs.getString("Aprobado"));
            prov.setCP(rs.getString("CP"));
            prov.setCalle(rs.getString("Calle"));
            prov.setCedula(rs.getString("Cedula"));
            prov.setCedulaEsp(rs.getString("CedulaEsp"));
            prov.setCertificado(rs.getString("Certificado"));
            prov.setCitas(rs.getString("Citas"));
            prov.setClAreaOperativa(rs.getString("clAreaOperativa"));
            prov.setClGerenciaReg(rs.getString("clGerenciaReg"));
            prov.setClProveedor(rs.getString("clProveedor"));
            prov.setClSubEspecialidad(rs.getString("clSubEspecialidad"));
            prov.setClabe(rs.getString("Clabe"));
            prov.setClespecialidad(rs.getString("clespecialidad"));
            prov.setCodEnt(rs.getString("CodEnt"));
            prov.setCodMD(rs.getString("CodMD"));
            prov.setColonia(rs.getString("Colonia"));
            prov.setConocimientos(rs.getString("Conocimientos"));
            prov.setConvenio(rs.getString("Convenio"));
            prov.setCopiaFactura(rs.getString("CopiaFactura"));
            prov.setCopiaIdent(rs.getString("CopiaIdent"));
            prov.setCopiaRFC(rs.getString("CopiaRFC"));
            prov.setCuentaBan(rs.getString("CuentaBan"));
            prov.setCURP(rs.getString("CURP"));
            prov.setDiplomaEsp(rs.getString("DiplomaEsp"));
            prov.setDsAreaOperativa(rs.getString("dsAreaOperativa"));
            prov.setDsBanco(rs.getString("dsBanco"));
            prov.setDsEntFed(rs.getString("dsEntFed"));
            prov.setDsEspecialidad(rs.getString("dsEspecialidad"));
            prov.setDsGerencia(rs.getString("dsGerencia"));
            prov.setDsGiro(rs.getString("dsGiro"));
            prov.setDsMunDel(rs.getString("dsMunDel"));
            prov.setDsSubEspecialidad(rs.getString("dsSubEspecialidad"));
            prov.setDsTipoProveedor(rs.getString("dsTipoProveedor"));
            prov.setDsTipoTabulador(rs.getString("dsTipoTabulador"));
            prov.setEdoCuenta(rs.getString("EdoCuenta"));
            prov.setEspecialidad(rs.getString("Especialidad"));
            prov.setExperiencia(rs.getString("Experiencia"));
            prov.setFechaAlta(rs.getString("FechaAlta"));
            prov.setFechaBaja(rs.getString("FechaBaja"));
            prov.setFechaContratacion(rs.getString("FechaContratacion"));
            prov.setFicha(rs.getString("Ficha"));
            prov.setFotografias(rs.getString("Fotografias"));
            prov.setHorario(rs.getString("Horario"));
            prov.setInfraestructura(rs.getString("Infraestructura"));
            prov.setNombreOpe(rs.getString("NombreOpe"));
            prov.setNombreRZ(rs.getString("NombreRZ"));
            prov.setNumNextel(rs.getString("NumNextel"));
            prov.setObservaciones(rs.getString("Observaciones"));
            prov.setPlazaBan(rs.getString("PlazaBan"));
            prov.setPrioridad(rs.getString("Prioridad"));
            prov.setRFC(rs.getString("RFC"));
            prov.setRecertificacion(rs.getString("Recertificacion"));
            prov.setSucursalBan(rs.getString("SucursalBan"));
            prov.setTipoCuentaBan(rs.getString("TipoCuentaBan"));
            prov.setTitulo(rs.getString("Titulo"));
            prov.setTitular(rs.getString("Titular"));
            prov.setDsPais(rs.getString("dsPais"));
            prov.setClPais(rs.getString("clPais"));
            prov.setEmail1(rs.getString("Email1"));
            prov.setEmail2(rs.getString("Email2"));
            prov.setEmail3(rs.getString("Email3"));
            prov.setCuitA(rs.getString("CuitA"));
            prov.setCheque(rs.getString("Cheque"));

            return prov;
        }
    }
}
