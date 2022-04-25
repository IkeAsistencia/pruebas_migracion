/*
 * HDSolicitud.java
 *
 * Created on 31 de marzo de 2006, 12:15 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */

package com.ike.helpdesk;

/*
 *
 * @author cabrerar
 */

public class HDSolicitud {
    
    private int clSolicitud;
    private String UsrRegistra;
    private int clUsrRegistra;
    private String FechaRegistro;
    private int clEstatus;
    private String RevisadaxSistemas;
    private String dsEstatusSol;
    private int clTipoSol;
    private String dsTipoSol;
    private String FechaInicio;
    private String FechaTermino;
    private String Asunto;
    private String DetalleSolicitud;
    private int clUsrRevisa;
    private String UsrRevisa;
    private String FechaRevis;
    private int clPrioridadHD;
    private String dsPrioridadHD;
    private String RequiereFirmas;
    private String Firmas;
    private int clUsrValFirmas;
    private String UsrValFirmas;
    private String FechaValFirmas;
    private String ObservacionesSist;
    private String FechaCompromiso;
    private String AreaSolicitante;
    private String FolioLibera;
    private String Titular;

            
    /* Creates a new instance of HDSolicitud */
    public HDSolicitud() {
    }

    public int getClSolicitud() {
        return clSolicitud;
    }

    public void setClSolicitud(int clSolicitud) {
        this.clSolicitud = clSolicitud;
    }

    public String getUsrRegistra() {
        return UsrRegistra;
    }

    public void setUsrRegistra(String UsrRegistra) {
        this.UsrRegistra = UsrRegistra;
    }

    public int getClUsrRegistra() {
        return clUsrRegistra;
    }

    public void setClUsrRegistra(int clUsrRegistra) {
        this.clUsrRegistra = clUsrRegistra;
    }

    public String getFechaRegistro() {
        return FechaRegistro;
    }

    public void setFechaRegistro(String FechaRegistro) {
        this.FechaRegistro = FechaRegistro;
    }

    public int getclEstatus() {
        return getClEstatus();
    }

    public void setclEstatus(int clEstatus) {
        this.setClEstatus(clEstatus);
    }

    public String getRevisadaxSistemas() {
        return RevisadaxSistemas;
    }

    public void setRevisadaxSistemas(String RevisadaxSistemas) {
        this.RevisadaxSistemas = RevisadaxSistemas;
    }

    public String getDsEstatusSol() {
        return dsEstatusSol;
    }

    public void setDsEstatusSol(String dsEstatusSol) {
        this.dsEstatusSol = dsEstatusSol;
    }

    public int getClTipoSol() {
        return clTipoSol;
    }

    public void setClTipoSol(int clTipoSol) {
        this.clTipoSol = clTipoSol;
    }

    public String getDsTipoSol() {
        return dsTipoSol;
    }

    public void setDsTipoSol(String dsTipoSol) {
        this.dsTipoSol = dsTipoSol;
    }

    public String getFechaTermino() {
        return FechaTermino;
    }

    public void setFechaTermino(String FechaTermino) {
        this.FechaTermino = FechaTermino;
    }

    public String getDetalleSolicitud() {
        return DetalleSolicitud;
    }

    public void setDetalleSolicitud(String DetalleSolicitud) {
        this.DetalleSolicitud = DetalleSolicitud;
    }

    public int getClUsrRevisa() {
        return clUsrRevisa;
    }

    public void setClUsrRevisa(int clUsrRevisa) {
        this.clUsrRevisa = clUsrRevisa;
    }

    public String getUsrRevisa() {
        return UsrRevisa;
    }

    public void setUsrRevisa(String UsrRevisa) {
        this.UsrRevisa = UsrRevisa;
    }

    public String getFechaRevis() {
        return FechaRevis;
    }

    public void setFechaRevis(String FechaRevis) {
        this.FechaRevis = FechaRevis;
    }

    public int getClPrioridadHD() {
        return clPrioridadHD;
    }

    public void setClPrioridadHD(int clPrioridadHD) {
        this.clPrioridadHD = clPrioridadHD;
    }

    public String getDsPrioridadHD() {
        return dsPrioridadHD;
    }

    public void setDsPrioridadHD(String dsPrioridadHD) {
        this.dsPrioridadHD = dsPrioridadHD;
    }

    public String getRequiereFirmas() {
        return RequiereFirmas;
    }

    public void setRequiereFirmas(String RequiereFirmas) {
        this.RequiereFirmas = RequiereFirmas;
    }

    public String getFirmas() {
        return Firmas;
    }

    public void setFirmas(String Firmas) {
        this.Firmas = Firmas;
    }

    public int getClUsrValFirmas() {
        return clUsrValFirmas;
    }

    public void setClUsrValFirmas(int clUsrValFirmas) {
        this.clUsrValFirmas = clUsrValFirmas;
    }

    public String getUsrValFirmas() {
        return UsrValFirmas;
    }

    public void setUsrValFirmas(String UsrValFirmas) {
        this.UsrValFirmas = UsrValFirmas;
    }

    public String getFechaValFirmas() {
        return FechaValFirmas;
    }

    public void setFechaValFirmas(String FechaValFirmas) {
        this.FechaValFirmas = FechaValFirmas;
    }

    public String getObservacionesSist() {
        return ObservacionesSist;
    }

    public void setObservacionesSist(String ObservacionesSist) {
        this.ObservacionesSist = ObservacionesSist;
    }

    public String getFechaCompromiso() {
        return FechaCompromiso;
    }

    public void setFechaCompromiso(String FechaCompromiso) {
        this.FechaCompromiso = FechaCompromiso;
    }

    public String getFechaInicio() {
        return FechaInicio;
    }

    public void setFechaInicio(String FechaInicio) {
        this.FechaInicio = FechaInicio;
    }

    public String getAsunto() {
        return Asunto;
    }

    public void setAsunto(String Asunto) {
        this.Asunto = Asunto;
    }

    public int getClEstatus() {
        return clEstatus;
    }

    public void setClEstatus(int clEstatus) {
        this.clEstatus = clEstatus;
    }

    public String getAreaSolicitante() {
        return AreaSolicitante;
    }

    public void setAreaSolicitante(String AreaSolicitante) {
        this.AreaSolicitante = AreaSolicitante;
    }

    public String getFolioLibera() {
        return FolioLibera;
    }

    public void setFolioLibera(String FolioLibera) {
        this.FolioLibera = FolioLibera;
    }

    public String getTitular() {
        return Titular;
    }

    public void setTitular(String Titular) {
        this.Titular = Titular;
    }

}
