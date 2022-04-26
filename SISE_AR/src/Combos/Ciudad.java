/*
 * Ciudad.java
 *
 * Created on 4 de octubre de 2006, 10:49 AM
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
public class Ciudad {
    
    private String strclCiudad;
    private String strdsCiudad;
    private List lstZonasConcierge = null;

    /* Creates a new instance of Ciudad */
    public Ciudad() {
    }

    public String getStrclCiudad() {
        return strclCiudad;
    }

    public void setStrclCiudad(String strclCiudad) {
        this.strclCiudad = strclCiudad;
    }

    public String getStrdsCiudad() {
        return strdsCiudad;
    }

    public void setStrdsCiudad(String strdsCiudad) {
        this.strdsCiudad = strdsCiudad;
    }

    public List getLstZonasConcierge() {
        return lstZonasConcierge;
    }

    public void setLstZonasConcierge(List lstZonasConcierge) {
        this.lstZonasConcierge = lstZonasConcierge;
    }
    
}
