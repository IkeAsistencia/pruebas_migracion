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

import com.ike.concierge.to.CSSchengenLetter;
import java.util.Collection;
import java.util.Iterator;
import com.ike.model.DAOException;

/*
 *
 * @author perezern
 */
public class DAOCSSchengenLetter extends com.ike.model.DAOBASE {

    /* Creates a new instance of DAOCSSchengenLetter */
    public DAOCSSchengenLetter() {
    }

    // METODO PARA LLENAR JSP DE LA ASISTENCIA
    public CSSchengenLetter getCSSchengenLetter(String StrclAsistencia) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;


        sb.append("st_CSObtenSchengenLetter ").append(StrclAsistencia);
        System.out.println(sb);

        col = this.rsSQLNP(sb.toString(), new CSSchengenLetterFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (CSSchengenLetter) it.next() : null;
    }

    public class CSSchengenLetterFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSSchengenLetter CSSchengenLetter = new CSSchengenLetter();

            CSSchengenLetter.setBanco(rs.getString("Banco"));
            CSSchengenLetter.setTipoTarjeta(rs.getString("TipoTarjeta"));
            CSSchengenLetter.setNumeroBin(rs.getString("Clave"));
            CSSchengenLetter.setClAsistencia(rs.getString("clAsistencia"));
            CSSchengenLetter.setNuestroUsuario(rs.getString("NuestroUsuario"));
//            CSSchengenLetter.setClPais(rs.getString("clPais"));
            CSSchengenLetter.setDsPais(rs.getString("dsPais"));
            CSSchengenLetter.setEmailA(rs.getString("EmailA"));
            CSSchengenLetter.setEmailAsis(rs.getString("EmailAsis"));
            CSSchengenLetter.setEmailAsis2(rs.getString("EmailAsis2"));
            CSSchengenLetter.setEmailC(rs.getString("EmailC"));
            CSSchengenLetter.setEmailO(rs.getString("EmailO"));
            CSSchengenLetter.setEmailP(rs.getString("EmailP"));
            CSSchengenLetter.setFechaIniViaje(rs.getString("FechaIniViaje"));
            CSSchengenLetter.setNombreConyuge(rs.getString("NombreConyuge"));
            CSSchengenLetter.setNombresHijos(rs.getString("NombreHijos"));
            CSSchengenLetter.setTelefono(rs.getString("Telefono"));
            CSSchengenLetter.setTelefono2(rs.getString("Telefono2"));
            CSSchengenLetter.setDescipcion(rs.getString("Descripcion"));
            CSSchengenLetter.setFechaRegAsist(rs.getString("FechaRegAsist"));
            CSSchengenLetter.setDsEstatus(rs.getString("dsEstatus"));

            CSSchengenLetter.setEmailA_Env(rs.getString("EmailA_Env"));
            CSSchengenLetter.setEmailAsis2_Env(rs.getString("EmailAsis2_Env"));
            CSSchengenLetter.setEmailAsis_Env(rs.getString("EmailAsis_Env"));
            CSSchengenLetter.setEmailC_Env(rs.getString("EmailC_Env"));
            CSSchengenLetter.setEmailO_Env(rs.getString("EmailO_Env"));
            CSSchengenLetter.setEmailP_Env(rs.getString("EmailP_Env"));
            CSSchengenLetter.setMailContacto(rs.getString("MailContacto"));

            return CSSchengenLetter;
        }
    }

    // METODO PARA LLENAR JSP DE LA ASISTENCIA (SÓLO DATOS PRECARGADOS)
    public CSSchengenLetter getCSSchengenDatPrev(String StrclConcierge) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;


        sb.append("st_CSSchengenDatPrev ").append(StrclConcierge);
        System.out.println(sb);

        col = this.rsSQLNP(sb.toString(), new CSSchengenDatPrevFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (CSSchengenLetter) it.next() : null;
    }

    public class CSSchengenDatPrevFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSSchengenLetter CSSchengenDatPrev = new CSSchengenLetter();

            CSSchengenDatPrev.setBanco(rs.getString("Banco"));
            CSSchengenDatPrev.setTipoTarjeta(rs.getString("TipoTarjeta"));
            CSSchengenDatPrev.setNumeroBin(rs.getString("Clave"));
            CSSchengenDatPrev.setNuestroUsuario(rs.getString("NuestroUsuario"));
            CSSchengenDatPrev.setEmailA(rs.getString("EmailA"));
            CSSchengenDatPrev.setEmailAsis(rs.getString("EmailAsis"));
            CSSchengenDatPrev.setEmailAsis2(rs.getString("Email2Asis"));
            CSSchengenDatPrev.setEmailC(rs.getString("Email"));
            CSSchengenDatPrev.setEmailO(rs.getString("EmailO"));
            CSSchengenDatPrev.setEmailP(rs.getString("EmailP"));
            CSSchengenDatPrev.setTelefono(rs.getString("TelefonoH"));
            CSSchengenDatPrev.setTelefono2(rs.getString("TelefonoC"));

            return CSSchengenDatPrev;
        }
    }

    // METODO PARA LLENAR EL ARCHIVO PDF
    public CSSchengenLetter getCSSchengenPDF(String StrclAsistencia) throws DAOException {
        StringBuffer sb = new StringBuffer();
        Collection col = null;

        sb.append("st_CSSchengenPDF ").append(StrclAsistencia);
        System.out.println(sb);

        col = this.rsSQLNP(sb.toString(), new CSSchengenPDFFiller());

        Iterator it = col.iterator();
        return it.hasNext() ? (CSSchengenLetter) it.next() : null;
    }

    public class CSSchengenPDFFiller implements com.ike.model.LlenaDatos {

        public Object llena(java.sql.ResultSet rs) throws java.sql.SQLException {
            CSSchengenLetter CSSchengenPDF = new CSSchengenLetter();

            CSSchengenPDF.setBanco(rs.getString("Banco"));
            CSSchengenPDF.setNumeroBin(rs.getString("NumeroBin"));
            CSSchengenPDF.setTipoTarjeta(rs.getString("TipoTarjeta"));
            CSSchengenPDF.setNuestroUsuario(rs.getString("NuestroUsuario"));
            CSSchengenPDF.setNombreConyuge(rs.getString("NombreConyuge"));
            CSSchengenPDF.setNombresHijos(rs.getString("NombreHijos"));
            CSSchengenPDF.setFechaIniViaje(rs.getString("FechaIniViaje"));
            CSSchengenPDF.setDsPais(rs.getString("Pais"));
            CSSchengenPDF.setTelefono(rs.getString("Telefono1"));
            CSSchengenPDF.setTelefono2(rs.getString("Telefono2"));
            CSSchengenPDF.setMailContacto(rs.getString("MailContacto"));
            CSSchengenPDF.setNombreConcierge(rs.getString("NombreConcierge"));
            CSSchengenPDF.setEmailConcierge(rs.getString("CorreoConcierge"));

            return CSSchengenPDF;
        }
    }
}
