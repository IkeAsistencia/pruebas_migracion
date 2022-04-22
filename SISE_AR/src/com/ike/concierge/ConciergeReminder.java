package com.ike.concierge; 

public class ConciergeReminder {

    private String clConcierge;
    private String clReminder;
    private String dsReminder;
    private String dsEvento;
    private String FechaReminder;

    /* Creates a new instance of ConciergeReminder */
    public ConciergeReminder() {
    }

    public String getClConcierge() {
        return clConcierge;
    }

    public void setClConcierge(String clConcierge) {
        this.clConcierge = clConcierge;
    }

    public String getclReminder() {
        return clReminder;
    }

    public void setclReminder(String clReminder) {
        this.clReminder = clReminder;
    }

    public String getdsEvento() {
        return dsEvento;
    }

    public void setdsEvento(String dsEvento) {
        this.dsEvento = dsEvento;
    }

    public String getFechaReminder() {
        return FechaReminder;
    }

    public void setFechaReminder(String FechaReminder) {
        this.FechaReminder = FechaReminder;
    }

    public String getdsReminder() {
        return dsReminder;
    }

    public void setdsReminder(String dsReminder) {
        this.dsReminder = dsReminder;
    }
}
