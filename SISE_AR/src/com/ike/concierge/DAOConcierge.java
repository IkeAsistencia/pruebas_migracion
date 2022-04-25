   /*
 * DAOConcierge.java
 *
 * Created on 7 de septiembre de 2006, 01:40 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.ike.concierge;

import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;
import com.ike.concierge.to.CSReferencia;

/*
 *
 * @author cabrerar
 */
public class DAOConcierge extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOConcierge */
    public DAOConcierge() {
    }

    public CSReferencia getReferencia(String strclReferencia) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append(" st_CSObtenReferencia '").append(strclReferencia).append("'");
        col = this.rsSQLNP(sb.toString(), new ReferenciaFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (CSReferencia) it.next() : null;
    }

    public class ReferenciaFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSReferencia Referencia = new CSReferencia();
            Referencia.setClReferencia(rs.getInt("clReferencia"));
            Referencia.setNomEstablec(rs.getString("NomEstablec"));
            Referencia.setNomAlter(rs.getString("NomAlter"));
            Referencia.setClCategoria(rs.getInt("clCategoria"));
            Referencia.setDsCategoria(rs.getString("dsCategoria"));
            Referencia.setClSubCategoria(rs.getInt("clSubCategoria"));
            Referencia.setDsSubCategoria(rs.getString("dsSubCategoria"));
            Referencia.setCalleNum(rs.getString("CalleNum"));
            Referencia.setEntreCalles(rs.getString("EntreCalles"));
            Referencia.setClPais(rs.getInt("clPais"));
            Referencia.setDsPais(rs.getString("dsPais"));
            Referencia.setClCiudad(rs.getInt("clCiudad"));
            Referencia.setDsCiudad(rs.getString("dsCiudad"));
            Referencia.setClZona(rs.getInt("clZona"));
            Referencia.setDsZona(rs.getString("dsZona"));
            Referencia.setCodEnt(rs.getString("CodEnt"));
            Referencia.setDsEntFed(rs.getString("dsEntFed"));
            Referencia.setCodMD(rs.getString("CodMD"));
            Referencia.setDsMunDel(rs.getString("dsMunDel"));
            Referencia.setColonia(rs.getString("Colonia"));
            Referencia.setCP(rs.getString("CP"));
            Referencia.setEntidad(rs.getString("Entidad"));
            Referencia.setCiudad(rs.getString("Ciudad"));
            Referencia.setHorario(rs.getString("Horario"));
            Referencia.setNotas(rs.getString("Notas"));
            Referencia.setVISA(rs.getString("VISA"));
            Referencia.setMasterCard(rs.getString("MasterCard"));
            Referencia.setAMEX(rs.getString("AMEX"));
            Referencia.setDinners(rs.getString("Dinners"));
            Referencia.setTDebito(rs.getString("TDebito"));
            Referencia.setEfectivo(rs.getString("Efectivo"));
            Referencia.setContacto(rs.getString("Contacto"));
            Referencia.setFechaAlta(rs.getString("FechaAlta"));
            Referencia.setActivo(rs.getString("Activo"));
            Referencia.setActivo(rs.getString("Activo"));
            Referencia.setActivo(rs.getString("Activo"));
            Referencia.setRutaLogo(rs.getString("RutaLogo"));
            Referencia.setTelefono(rs.getString("Telefono"));

            return Referencia;
        }
    }

    public CSContactoxRef getContactoxRef(String strclContactoxRef) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append(" select CxR.clContactoxRef, CxR.Contacto, TC.clTipoContacto, TC.dsTipoContacto, CxR.clReferencia ");
        sb.append(" From CSContactoxRef CxR ");
        sb.append("inner join cTipoContacto TC on (CxR.clTipoContacto = TC.clTipoContacto)");
        sb.append(" Where CxR.clContactoxRef=").append(strclContactoxRef);

        col = this.rsSQLNP(sb.toString(), new ContactoxRefFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (CSContactoxRef) it.next() : null;
    }

    public class ContactoxRefFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSContactoxRef ContactoxRef = new CSContactoxRef();
            ContactoxRef.setClContactoxRef(rs.getInt("clContactoxRef"));
            ContactoxRef.setContacto(rs.getString("Contacto"));
            ContactoxRef.setDsTipoContacto(rs.getString("dsTipoContacto"));
            ContactoxRef.setClTipoContacto(rs.getInt("clTipoContacto"));
            ContactoxRef.setClReferencia(rs.getInt("clReferencia"));

            return ContactoxRef;
        }
    }

    public CSZonaxRef getZonaxRef(String strclZonaxRef) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append(" select ZxR.clZonaxRef, ZxR.clZona, ZxR.clReferencia, C.clCiudad, C.dsCiudad, Z.dsZona, R.clCiudad clCiudadRef ");
        sb.append(" From CSZonaxRef ZxR ");
        sb.append("inner join CScZona Z on (ZxR.clZona = Z.clZona)");
        sb.append("inner join cCiudad C on (Z.clCiudad = C.clCiudad)");
        sb.append("inner join CScReferencia R on (R.clReferencia = ZxR.clReferencia)");
        sb.append(" Where ZxR.clZonaxRef=").append(strclZonaxRef);

        col = this.rsSQLNP(sb.toString(), new ZonaxRefFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (CSZonaxRef) it.next() : null;

    }

    public class ZonaxRefFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSZonaxRef ZonaxRef = new CSZonaxRef();
            ZonaxRef.setClZonaxRef(rs.getInt("clZonaxRef"));
            ZonaxRef.setClZona(rs.getInt("clZona"));
            ZonaxRef.setClReferencia(rs.getInt("clReferencia"));
            ZonaxRef.setClCiudad(rs.getString("clCiudad"));
            ZonaxRef.setDsCiudad(rs.getString("dsCiudad"));
            ZonaxRef.setDsZona(rs.getString("dsZona"));
            ZonaxRef.setClCiudadRef(rs.getString("clCiudadRef"));

            return ZonaxRef;
        }
    }
}
