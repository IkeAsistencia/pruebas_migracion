/*
 * Pais.java
 *
 * Created on 4 de octubre de 2006, 10:45 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package Combos;

import java.util.List;

/*
 *
 * @author cabrerar
 */
public class Pais {

    private String strclPais;
    private String strdsPais;
    private List lstCiudad = null;

    /* Creates a new instance of Entidad */
    public Pais() {
    }

    public String getStrclPais() {
        return strclPais;
    }

    public void setStrclPais(String strclPais) {
        this.strclPais = strclPais;
    }

    public String getStrdsPais() {
        return strdsPais;
    }

    public void setStrdsPais(String strdsPais) {
        this.strdsPais = strdsPais;
    }

    public List getLstCiudad() {
        return lstCiudad;
    }

    public void setLstCiudad(List lstCiudad) {
        this.lstCiudad = lstCiudad;
    }
}
