    /*
 * CSContactoxRef.java
 *
 * Created on 11 de septiembre de 2006, 04:41 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ike.concierge;

/*
 *
 * @author cabrerar
 */
public class CSContactoxRef {
    
    /* Creates a new instance of CSContactoxRef */
    public CSContactoxRef() {
    }
    
    private int clContactoxRef;
    private String Contacto;
    private int clTipoContacto;
    private int clReferencia;
    private String dsTipoContacto;

    public int getClContactoxRef() {
        return clContactoxRef;
    }

    public void setClContactoxRef(int clContactoxRef) {
        this.clContactoxRef = clContactoxRef;
    }

    public String getContacto() {
        return Contacto;
    }

    public void setContacto(String Contacto) {
        this.Contacto = Contacto;
    }

    public String getDsTipoContacto() {
        return dsTipoContacto;
    }

    public void setDsTipoContacto(String dsTipoContacto) {
        this.dsTipoContacto = dsTipoContacto;
    }

    public int getClTipoContacto() {
        return clTipoContacto;
    }

    public void setClTipoContacto(int clTipoContacto) {
        this.clTipoContacto = clTipoContacto;
    }

    public int getClReferencia() {
        return clReferencia;
    }

    public void setClReferencia(int clReferencia) {
        this.clReferencia = clReferencia;
    }
    
}
