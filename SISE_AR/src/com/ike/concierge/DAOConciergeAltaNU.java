/*
 *
 *
 * Created on 18 de agosto de 2006, 09:48 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.concierge;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOConciergeAltaNU extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOTelemarketing */
    public DAOConciergeAltaNU() {
    }

    public Conciergealtanu getConciergeNU(String StrclRetencTmk) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_CSDetalleConcierge ").append(StrclRetencTmk);
        System.out.println(sb);

        col = this.rsSQLNP(sb.toString(), new ConciergealtanuFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (Conciergealtanu) it.next() : null;
    }

    public class ConciergealtanuFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {

            Conciergealtanu CA = new Conciergealtanu();

            CA.setClConcierge(rs.getString("clConcierge"));
            CA.setClCuenta(rs.getString("clCuenta"));
            CA.setDsCuenta(rs.getString("dsCuenta"));
            CA.setNuestroUsuario(rs.getString("NuestroUsuario"));
            CA.setClave(rs.getString("Clave"));
            CA.setClTipoDocumento(rs.getString("clTipoDocumento"));
            CA.setDsTipoDocumento(rs.getString("dsTipoDocumento"));
            CA.setFechaNacNU(rs.getString("FechaNacNU"));
            CA.setClSexo(rs.getString("clSexo"));
            CA.setDsSexo(rs.getString("dsSexo"));
            CA.setClTitulo(rs.getString("clTitulo"));
            CA.setDsTitulo(rs.getString("dsTitulo"));
            CA.setNomBancoBIN(rs.getString("NomBancoBIN"));
            CA.setClPaisOrigenNU(rs.getString("clPaisOrigenNU"));
            CA.setDsPaisOrigenNU(rs.getString("dsPaisOrigenNU"));
            CA.setClCiudadOrigenNU(rs.getString("clCiudadOrigenNU"));
            CA.setDsCiudadOrigenNU(rs.getString("dsCiudadOrigenNU"));
            CA.setObservaciones(rs.getString("Observaciones"));
            CA.setTelHogarNU(rs.getString("TelHogarNU"));
            CA.setTelCelularNU(rs.getString("TelCelularNU"));
            CA.setTelOficinaNU(rs.getString("TelOficinaNU"));
            CA.setTelOtroNU(rs.getString("TelOtroNU"));
            CA.setTelAlternoNU(rs.getString("TelAlternoNU"));
            CA.setFaxNU(rs.getString("FaxNU"));
            CA.setEmailComercialNU(rs.getString("EmailComercialNU"));
            CA.setEmailPersonalNU(rs.getString("EmailPersonalNU"));
            CA.setEmailAlternoNU(rs.getString("EmailAlternoNU"));
            CA.setEmailOtroNU(rs.getString("EmailOtroNU"));
            CA.setClUsrConcierge(rs.getString("clUsrConcierge"));
            CA.setDsUsrConcierge(rs.getString("dsUsrConcierge"));
            CA.setClUsrConciergeAlterno(rs.getString("clUsrConciergeAlterno"));
            CA.setDsUsrConciergeAlterno(rs.getString("dsUsrConciergeAlterno"));
            CA.setNombreAsis(rs.getString("NombreAsis"));
            CA.setTituloAsis(rs.getString("TituloAsis"));
            CA.setFechaNacAsis(rs.getString("FechaNacAsis"));
            CA.setTelOficinaAsis(rs.getString("TelOficinaAsis"));
            CA.setTelCelularAsis(rs.getString("TelCelularAsis"));
            CA.setTelOtroAsis(rs.getString("TelOtroAsis"));
            CA.setEmailPersonalAsis(rs.getString("EmailPersonalAsis"));
            CA.setEmailOtroAsis(rs.getString("EmailOtroAsis"));
            CA.setClPaisBIN(rs.getString("clPaisBIN"));
            CA.setDsPaisBIN(rs.getString("dsPaisBIN"));
            CA.setClPaisFactura(rs.getString("clPaisFactura"));
            CA.setDsPaisFactura(rs.getString("dsPaisFactura"));
            CA.setCodEntFactura(rs.getString("CodEntFactura"));
            CA.setDsEntFedFactura(rs.getString("dsEntFedFactura"));
            CA.setCodMDFactura(rs.getString("CodMDFactura"));
            CA.setDsMunDelFactura(rs.getString("dsMunDelFactura"));
            CA.setCiudadFactura(rs.getString("CiudadFactura"));
            CA.setCalleFactura(rs.getString("CalleFactura"));
            CA.setCPFactura(rs.getString("CPFactura"));
            CA.setUsrAppVIP(rs.getString("UsrAppVIP"));
            CA.setNombreBanco(rs.getString("NombreBanco"));
            CA.setWarmTransfer(rs.getString("WarmTransfer"));
            CA.setFechaAlta(rs.getString("FechaAlta"));
            CA.setActivo(rs.getString("Activo"));
            CA.setVigencia(rs.getString("Vigencia"));
            CA.setClUsrAppReg(rs.getString("clUsrApp"));          
            CA.setClTipoUsConcierge(rs.getString("clTipoUsConcierge"));
            CA.setdsTipoUsConcierge(rs.getString("dsTipoUsConcierge"));
            CA.setTUConciergeAct(rs.getString("TUConciergeAct"));             
            return CA;
        }
    }
}