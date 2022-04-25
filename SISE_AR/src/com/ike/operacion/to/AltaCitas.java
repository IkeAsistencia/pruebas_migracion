package com.ike.operacion.to; 

public class AltaCitas {

    private String clCita;
    private String clExpediente;
    private String clProveedor;
    private String clEstatusCita;
    private String Fecha;
    private String HoraD;
    private String HoraH;

    /* Creates a new instance of ConciergeReminder */
    public AltaCitas() {
    }

    public String getclCita() {
        return clCita;
    }

    public void setclCita(String clCita) {
        this.clCita = clCita;
    }

    public String getclExpediente() {
        return clExpediente;
    }

    public void setclExpediente(String clExpediente) {
        this.clExpediente = clExpediente;
    }

    public String getclProveedor() {
        return clProveedor;
    }

    public void setclProveedor (String clProveedor) {
        this.clProveedor = clProveedor;
    }

    public String getclEstatusCita() {
        return clEstatusCita;
    }

    public void setclEstatusCita(String clEstatusCita) {
        this.clEstatusCita = clEstatusCita;
    }

    public String getFecha() {
        return Fecha;
    }

    public void setFecha(String Fecha) {
        this.Fecha = Fecha;
    }
    
        public String getHoraD() {
        return HoraD;
    }

    public void setHoraD(String HoraD) {
        this.HoraD = HoraD;
    }
        public String getHoraH() {
        return HoraH;
    }

    public void setHoraH(String HoraH) {
        this.HoraH = HoraH;
    }
}
