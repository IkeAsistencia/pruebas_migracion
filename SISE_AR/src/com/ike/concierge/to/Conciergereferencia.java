/*
 * Conciergereferencia.java
 *
 * Created on 30 de abril de 2007, 04:29 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ike.concierge.to;

/*
 *
 * @author perezern
 */
public class Conciergereferencia {
    private String NomAlter;
    private String NomEstablec;
    private String Contacto;
    private String Direccion;
    private String Ciudad;

    /* Creates a new instance of Conciergereferencia */
    public String getNomAlter() {
        return NomAlter;
    }

    public void setNomAlter(String NomAlter) {    
        this.NomAlter = NomAlter;
    }

    public String getNomEstablec() {
        return NomEstablec;
    }

    public void setNomEstablec(String NomEstablec) {
        this.NomEstablec = NomEstablec;
    }

    public String getContacto() {
        return Contacto;
    }

    public void setContacto(String Contacto) {
        this.Contacto = Contacto;
    }

    public String getDireccion() {
        return Direccion;
    }

    public void setDireccion(String Direccion) {
        this.Direccion = Direccion;
    }

    public String getCiudad() {
        return Ciudad;
    }

    public void setCiudad(String Ciudad) {
        this.Ciudad = Ciudad;
    }

    
}
