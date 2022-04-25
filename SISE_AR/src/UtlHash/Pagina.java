package UtlHash;

/*
 * Pagina.java
 *
 * Created on 15 de febrero de 2006, 12:32 PM
 */
import java.util.List;

/*
 *
 * @author  cabrerar
 */
public class Pagina {

    private String strclPagina;
    private String strTablaBitacora;
    private String strTituloRPT;
    private String strSentenciaRPT;
    private String strPaginaDetalle;
    private String strTarget;
    private String strNombrePaginaWeb;
    private String strNombrePaginaWebCSV;
    private String strNombrePaginaWebMail;
    private List lstFiltros = null;

    /* Creates a new instance of Entidad */
    public Pagina() {
    }

    public String getStrclPagina() {
        return this.strclPagina;
    }

    public void setStrclPagina(String strclPagina) {
        this.strclPagina = strclPagina;
    }

    public String getStrTablaBitacora() {
        return this.strTablaBitacora;
    }

    public void setStrTablaBitacora(String strTablaBitacora) {
        this.strTablaBitacora = strTablaBitacora;
    }

    public String getStrTituloRPT() {
        return this.strTituloRPT;
    }

    public void setStrTituloRPT(String strTituloRPT) {
        this.strTituloRPT = strTituloRPT;
    }

    public String getStrSentenciaRPT() {
        return this.strSentenciaRPT;
    }

    public void setStrSentenciaRPT(String strSentenciaRPT) {
        this.strSentenciaRPT = strSentenciaRPT;
    }

    public String getStrPaginaDetalle() {
        return this.strPaginaDetalle;
    }

    public void setStrPaginaDetalle(String strPaginaDetalle) {
        this.strPaginaDetalle = strPaginaDetalle;
    }

    public String getStrTarget() {
        return this.strTarget;
    }

    public void setStrTarget(String strTarget) {
        this.strTarget = strTarget;
    }

    public String getStrNombrePaginaWeb() {
        return this.strNombrePaginaWeb;
    }

    public void setStrNombrePaginaWeb(String strNombrePaginaWeb) {
        this.strNombrePaginaWeb = strNombrePaginaWeb;
    }

    public String getStrNombrePaginaWebCSV() {
        return this.strNombrePaginaWebCSV;
    }

    public void setStrNombrePaginaWebCSV(String strNombrePaginaWebCSV) {
        this.strNombrePaginaWebCSV = strNombrePaginaWebCSV;
    }

    public String getStrNombrePaginaWebMail() {
        return this.strNombrePaginaWebMail;
    }

    public void setStrNombrePaginaWebMail(String strNombrePaginaWebMail) {
        this.strNombrePaginaWebMail = strNombrePaginaWebMail;
    }

    public List getLstFiltros() {
        return this.lstFiltros;
    }

    public void setLstFiltros(List lstFiltros) {
        this.lstFiltros = lstFiltros;
    }
}
