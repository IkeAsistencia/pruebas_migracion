/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.asistencias.to;

/*
 *
 * @author rurbina
 */
public class AsistenciaMenores {

    private String clExpediente;
    private String Nombre;
    private String clParentesco;
    private String dsParentesco;
    private String Edad;
    private String clPais;
    private String dsPais;
    private String Direccion;
    private String Observaciones;

    public String getDireccion() {
        return Direccion;
    }

    public void setDireccion(String Direccion) {
        this.Direccion = Direccion;
    }

    public String getEdad() {
        return Edad;
    }

    public void setEdad(String Edad) {
        this.Edad = Edad;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public String getObservaciones() {
        return Observaciones;
    }

    public void setObservaciones(String Observaciones) {
        this.Observaciones = Observaciones;
    }

    public String getClExpediente() {
        return clExpediente;
    }

    public void setClExpediente(String clExpediente) {
        this.clExpediente = clExpediente;
    }

    public String getClPais() {
        return clPais;
    }

    public void setClPais(String clPais) {
        this.clPais = clPais;
    }

    public String getClParentesco() {
        return clParentesco;
    }

    public void setClParentesco(String clParentesco) {
        this.clParentesco = clParentesco;
    }

    public String getDsPais() {
        return dsPais;
    }

    public void setDsPais(String dsPais) {
        this.dsPais = dsPais;
    }

    public String getDsParentesco() {
        return dsParentesco;
    }

    public void setDsParentesco(String dsParentesco) {
        this.dsParentesco = dsParentesco;
    }
}
