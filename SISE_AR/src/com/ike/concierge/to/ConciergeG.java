/*
 * ConciergeG.java
 *
 * Created on 25 de enero de 2007, 03:50 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.ike.concierge.to;

/*
 *     
 * @author perezern
 */
public class ConciergeG {

    private String Ciudad;
    private String TelefonoH;
    private String TelefonoC;
    private String TelefonoOf;
    private String Direccion;
    private String NuestroUsuario;
    private String Nombre;
    private String Email;
    private String Clave;
    private String Observaciones;
    //  private String Asistencia;

    /* Creates a new instance of ConciergeG */
    public ConciergeG() {
    }

    public String getCiudad() {
        return Ciudad;
    }

    public void setCiudad(String Ciudad) {
        this.Ciudad = Ciudad;
    }

    public String getTelefonoH() {
        return TelefonoH;
    }

    public void setTelefonoH(String TelefonoH) {
        this.TelefonoH = TelefonoH;
    }

    public String getTelefonoC() {
        return TelefonoC;
    }

    public void setTelefonoC(String TelefonoC) {
        this.TelefonoC = TelefonoC;
    }

    public String getDireccion() {
        return Direccion;
    }

    public void setDireccion(String Direccion) {
        this.Direccion = Direccion;
    }

    public String getNuestroUsuario() {
        return NuestroUsuario;
    }

    public void setNuestroUsuario(String NuestroUsuario) {
        this.NuestroUsuario = NuestroUsuario;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getClave() {
        return Clave;
    }

    public void setClave(String Clave) {
        this.Clave = Clave;
    }

    public String getTelefonoOf() {
        return TelefonoOf;
    }

    public void setTelefonoOf(String TelefonoOf) {
        this.TelefonoOf = TelefonoOf;
    }

    /*     public void setAsistencia(String Asistencia)
    {
    this.Asistencia = Asistencia;
    }*/
    /*
     * Holds value of property clAsistencia.
     */
    private String clAsistencia;

    /*
     * Getter for property clAsistencia.
     * @return Value of property clAsistencia.
     */
    public String getClAsistencia() {
        return this.clAsistencia;
    }

    /*
     * Setter for property clAsistencia.
     * @param clAsistencia New value of property clAsistencia.
     */
    public void setClAsistencia(String clAsistencia) {
        this.clAsistencia = clAsistencia;
    }
    /*
     * Holds value of property clCuenta.
     */
    private String clCuenta;

    /*
     * Getter for property clCuenta.
     * @return Value of property clCuenta.
     */
    public String getClCuenta() {
        return this.clCuenta;
    }

    /*
     * Setter for property clCuenta.
     * @param clCuenta New value of property clCuenta.
     */
    public void setClCuenta(String clCuenta) {
        this.clCuenta = clCuenta;
    }
    /*
     * Holds value of property clConcierge.
     */
    private String clConcierge;

    /*
     * Getter for property clConcierge.
     * @return Value of property clConcierge.
     */
    public String getClConcierge() {
        return this.clConcierge;
    }

    /*
     * Setter for property clConcierge.
     * @param clConcierge New value of property clConcierge.
     */
    public void setClConcierge(String clConcierge) {
        this.clConcierge = clConcierge;
    }

    /**
     * @return the Observaciones
     */
    public String getObservaciones() {
        return Observaciones;
    }

    /**
     * @param Observaciones the Observaciones to set
     */
    public void setObservaciones(String Observaciones) {
        this.Observaciones = Observaciones;
    }
}