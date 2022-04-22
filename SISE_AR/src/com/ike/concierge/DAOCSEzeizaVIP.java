/*
 *
 *
 * Created on 15 de febrero de 2007, 11:48 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */
package com.ike.concierge;

import com.ike.concierge.to.CSEzeizaVIP;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOCSEzeizaVIP extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOCSEzeizaVIP */
    public DAOCSEzeizaVIP() {
    }

    // METODO PARA LLENAR JSP DE LA ASISTENCIA
    public CSEzeizaVIP getCSEzeizaVIP(String StrclAsistencia) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_CSObtenEzeizaVIP ").append(StrclAsistencia);
        //System.out.println(sb);

        col = this.rsSQLNP(sb.toString(), new CSEzeizaVIPFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (CSEzeizaVIP) it.next() : null;
    }

    public class CSEzeizaVIPFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSEzeizaVIP EVIP = new CSEzeizaVIP();

            EVIP.setClAsistencia(rs.getString("clAsistencia"));
            EVIP.setNuestroUsuario(rs.getString("NuestroUsuario"));
            EVIP.setDocumentoNU(rs.getString("DocumentoNU"));
            EVIP.setTelNU(rs.getString("TelNU"));
            EVIP.setDsSala(rs.getString("dsSala"));
            //EVIP.setCorreoNU(rs.getString("CorreoNU"));
            EVIP.setEmailComercialNU(rs.getString("EmailComercialNU"));
            EVIP.setEmailPersonalNU(rs.getString("EmailPersonalNU"));
            EVIP.setEmailAlternoNU(rs.getString("EmailAlternoNU"));
            EVIP.setEmailOtroNU(rs.getString("EmailOtroNU"));
            EVIP.setBanco(rs.getString("Banco"));
            EVIP.setNumeroBin(rs.getString("Clave"));
            EVIP.setTipoTarjeta(rs.getString("TipoTarjeta"));
            EVIP.setDsEstatus(rs.getString("dsEstatus"));
            EVIP.setDescripcion(rs.getString("Descripcion"));
            EVIP.setFechaRegAsist(rs.getString("FechaRegAsist"));
            EVIP.setViajaNU(rs.getString("ViajaNU"));
            EVIP.setClAerolinea_I(rs.getString("clAerolinea_I"));
            EVIP.setDsAerolinea_I(rs.getString("dsAerolinea_I"));
            EVIP.setNumVuelo_I(rs.getString("NumVuelo_I"));
            EVIP.setFechaVuelo_I(rs.getString("FechaVuelo_I"));
            EVIP.setHorario_I(rs.getString("Horario_I"));
            EVIP.setOrigen_I(rs.getString("Origen_I"));
            EVIP.setDestino_I(rs.getString("Destino_I"));
            EVIP.setObservaciones_I(rs.getString("Observaciones_I"));
            EVIP.setNomPAX1_I(rs.getString("NomPAX1_I"));
            EVIP.setNomPAX2_I(rs.getString("NomPAX2_I"));
            EVIP.setNomPAX3_I(rs.getString("NomPAX3_I"));
            EVIP.setNomPAX4_I(rs.getString("NomPAX4_I"));
            EVIP.setNomPAX5_I(rs.getString("NomPAX5_I"));
            EVIP.setNomPAX6_I(rs.getString("NomPAX6_I"));
            EVIP.setDocPAX1_I(rs.getString("DocPAX1_I"));
            EVIP.setDocPAX2_I(rs.getString("DocPAX2_I"));
            EVIP.setDocPAX3_I(rs.getString("DocPAX3_I"));
            EVIP.setDocPAX4_I(rs.getString("DocPAX4_I"));
            EVIP.setDocPAX5_I(rs.getString("DocPAX5_I"));
            EVIP.setDocPAX6_I(rs.getString("DocPAX6_I"));
            EVIP.setMenorPAX1_I(rs.getString("MenorPAX1_I"));
            EVIP.setMenorPAX2_I(rs.getString("MenorPAX2_I"));
            EVIP.setMenorPAX3_I(rs.getString("MenorPAX3_I"));
            EVIP.setMenorPAX4_I(rs.getString("MenorPAX4_I"));
            EVIP.setMenorPAX5_I(rs.getString("MenorPAX5_I"));
            EVIP.setMenorPAX6_I(rs.getString("MenorPAX6_I"));
            EVIP.setTHABPAX1_I(rs.getString("THABPAX1_I"));
            EVIP.setTHABPAX2_I(rs.getString("THABPAX2_I"));
            EVIP.setTHABPAX3_I(rs.getString("THABPAX3_I"));
            EVIP.setTHABPAX4_I(rs.getString("THABPAX4_I"));
            EVIP.setTHABPAX5_I(rs.getString("THABPAX5_I"));
            EVIP.setTHABPAX6_I(rs.getString("THABPAX6_I"));
            EVIP.setBinPAX1_I(rs.getString("BinPAX1_I"));
            EVIP.setBinPAX2_I(rs.getString("BinPAX2_I"));
            EVIP.setBinPAX3_I(rs.getString("BinPAX3_I"));
            EVIP.setBinPAX4_I(rs.getString("BinPAX4_I"));
            EVIP.setBinPAX5_I(rs.getString("BinPAX5_I"));
            EVIP.setBinPAX6_I(rs.getString("BinPAX6_I"));
            EVIP.setClAerolinea_R(rs.getString("clAerolinea_R"));   //  LLEGADA
            EVIP.setDsAerolinea_R(rs.getString("dsAerolinea_R"));
            EVIP.setNumVuelo_R(rs.getString("NumVuelo_R"));
            EVIP.setFechaVuelo_R(rs.getString("FechaVuelo_R"));
            EVIP.setHorario_R(rs.getString("Horario_R"));
            EVIP.setOrigen_R(rs.getString("Origen_R"));
            EVIP.setDestino_R(rs.getString("Destino_R"));
            EVIP.setObservaciones_R(rs.getString("Observaciones_R"));
            EVIP.setNomPAX1_R(rs.getString("NomPAX1_R"));
            EVIP.setNomPAX2_R(rs.getString("NomPAX2_R"));
            EVIP.setNomPAX3_R(rs.getString("NomPAX3_R"));
            EVIP.setNomPAX4_R(rs.getString("NomPAX4_R"));
            EVIP.setNomPAX5_R(rs.getString("NomPAX5_R"));
            EVIP.setNomPAX6_R(rs.getString("NomPAX6_R"));
            EVIP.setDocPAX1_R(rs.getString("DocPAX1_R"));
            EVIP.setDocPAX2_R(rs.getString("DocPAX2_R"));
            EVIP.setDocPAX3_R(rs.getString("DocPAX3_R"));
            EVIP.setDocPAX4_R(rs.getString("DocPAX4_R"));
            EVIP.setDocPAX5_R(rs.getString("DocPAX5_R"));
            EVIP.setDocPAX6_R(rs.getString("DocPAX6_R"));
            EVIP.setMenorPAX1_R(rs.getString("MenorPAX1_R"));
            EVIP.setMenorPAX2_R(rs.getString("MenorPAX2_R"));
            EVIP.setMenorPAX3_R(rs.getString("MenorPAX3_R"));
            EVIP.setMenorPAX4_R(rs.getString("MenorPAX4_R"));
            EVIP.setMenorPAX5_R(rs.getString("MenorPAX5_R"));
            EVIP.setMenorPAX6_R(rs.getString("MenorPAX6_R"));
            EVIP.setTHABPAX1_R(rs.getString("THABPAX1_R"));
            EVIP.setTHABPAX2_R(rs.getString("THABPAX2_R"));
            EVIP.setTHABPAX3_R(rs.getString("THABPAX3_R"));
            EVIP.setTHABPAX4_R(rs.getString("THABPAX4_R"));
            EVIP.setTHABPAX5_R(rs.getString("THABPAX5_R"));
            EVIP.setTHABPAX6_R(rs.getString("THABPAX6_R"));
            EVIP.setBinPAX1_R(rs.getString("BinPAX1_R"));
            EVIP.setBinPAX2_R(rs.getString("BinPAX2_R"));
            EVIP.setBinPAX3_R(rs.getString("BinPAX3_R"));
            EVIP.setBinPAX4_R(rs.getString("BinPAX4_R"));
            EVIP.setBinPAX5_R(rs.getString("BinPAX5_R"));
            EVIP.setBinPAX6_R(rs.getString("BinPAX6_R"));
            EVIP.setParking(rs.getString("Parking"));
            EVIP.setClMarcaAuto(rs.getString("CodigoMarca"));
            EVIP.setDsMarcaAuto(rs.getString("dsMarcaAuto"));
            EVIP.setClTipoAuto(rs.getString("clTipoAuto"));
            EVIP.setDsTipoAuto(rs.getString("dsTipoAuto"));
            EVIP.setPatente(rs.getString("Patente"));
            EVIP.setOtroAuto(rs.getString("OtroAuto"));

            EVIP.setClTipoPago(rs.getString("clTipoPago"));
            EVIP.setDsTipoPago(rs.getString("dsTipoPago"));
            EVIP.setNomBanco(rs.getString("NomBanco"));
            EVIP.setNombreTC(rs.getString("NombreTC"));
            EVIP.setNumeroTC(rs.getString("NumeroTC"));
            EVIP.setExpira(rs.getString("Expira"));
            EVIP.setSecC(rs.getString("SecC"));
            EVIP.setConfirmo(rs.getString("Confirmo"));
            EVIP.setNConfirmo(rs.getString("NConfirmo"));
            EVIP.setPCancel(rs.getString("PCancel"));
            EVIP.setNuInf(rs.getString("NuInf"));

            EVIP.setDomFiscal(rs.getString("DomFiscal"));
            EVIP.setEmailExtra1(rs.getString("EmailExtra1"));

            return EVIP;
        }
    }

    // METODO PARA LLENAR JSP DE LA ASISTENCIA (SÓLO DATOS PRECARGADOS)
    public CSEzeizaVIP getCSEzeizaVIPPRevio(String StrclConcierge) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_CSSchengenDatPrev ").append(StrclConcierge);

        col = this.rsSQLNP(sb.toString(), new CSEzeizaVIPPrevioFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (CSEzeizaVIP) it.next() : null;
    }

    public class CSEzeizaVIPPrevioFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSEzeizaVIP EPREV = new CSEzeizaVIP();

            EPREV.setBanco(rs.getString("Banco"));
            EPREV.setTipoTarjeta(rs.getString("TipoTarjeta"));
            EPREV.setNumeroBin(rs.getString("Clave"));
            EPREV.setNuestroUsuario(rs.getString("NuestroUsuario"));
            //EPREV.setCorreoNU(rs.getString("EmailA"));
            EPREV.setTelNU(rs.getString("TelefonoH"));
            EPREV.setEmailComercialNU(rs.getString("Email"));
            EPREV.setEmailPersonalNU(rs.getString("EmailP"));
            EPREV.setEmailAlternoNU(rs.getString("EmailA"));
            EPREV.setEmailOtroNU(rs.getString("EmailO"));

            return EPREV;
        }
    }
    // METODO PARA LLENAR EL ARCHIVO PDF

    public CSEzeizaVIP getCSEzeizaVIPPDF(String StrclAsistencia) throws DAOException {
        StringBuilder sb = new StringBuilder();
        Collection col = null;

        sb.append("st_CSEzeizaVIPPDF ").append(StrclAsistencia);
        //System.out.println(sb);

        col = this.rsSQLNP(sb.toString(), new CSEzeizaVIPPDFFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (CSEzeizaVIP) it.next() : null;
    }

    public class CSEzeizaVIPPDFFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSEzeizaVIP EVIPPDF = new CSEzeizaVIP();

//    EVIPPDF.setClAsistencia(rs.getString("clAsistencia"));
//    EVIPPDF.setNuestroUsuario(rs.getString("NuestroUsuario"));
//    EVIPPDF.setDocumentoNU(rs.getString("DocumentoNU"));
//    EVIPPDF.setTelNU(rs.getString("TelNU"));
//    EVIPPDF.setCorreoNU(rs.getString("CorreoNU"));
//    EVIPPDF.setBanco(rs.getString("Banco"));
//    EVIPPDF.setNumeroBin(rs.getString("Clave"));
//    EVIPPDF.setTipoTarjeta(rs.getString("TipoTarjeta"));
//    EVIPPDF.setDsEstatus(rs.getString("dsEstatus"));
//    EVIPPDF.setDescripcion(rs.getString("Descripcion"));
//    EVIPPDF.setFechaRegAsist(rs.getString("FechaRegAsist"));
//
//
//    EVIPPDF.setParking(rs.getString("Parking"));
//    EVIPPDF.setDsMarcaAuto(rs.getString("dsMarcaAuto"));
//    EVIPPDF.setDsTipoAuto(rs.getString("dsTipoAuto"));
//    EVIPPDF.setPatente(rs.getString("Patente"));
//    EVIPPDF.setNombreConcierge(rs.getString("NombreConcierge"));
//    EVIPPDF.setEmailConcierge(rs.getString("CorreoConcierge"));

            return EVIPPDF;
        }
    }
}
