/*
 * Usuario.java
 *
 * Created on 29 de septiembre de 2005, 10:33 PM
 */
package UtlHash;

import java.util.List;

/*
 *
 * @author  cabrerar
 */
public class Usuario {

    private String strclUsrApp;
    private String strNombre;
    private StringBuffer strMenus = new StringBuffer();
    private List lstPaginas = null;

    /* Creates a new instance of Entidad */
    public Usuario() {
    }

    public String getStrclUsrApp() {
        return this.strclUsrApp;
    }

    public void setStrclUsrApp(String strclUsrApp) {
        this.strclUsrApp = strclUsrApp;
    }

    public String getStrNombre() {
        return this.strNombre;
    }

    public void setStrNombre(String strNombre) {
        this.strNombre = strNombre;
    }

    public List getLstPaginas() {
        return this.lstPaginas;
    }

    public void setLstPaginas(List lstPaginas) {
        this.lstPaginas = lstPaginas;
    }

    public final StringBuffer getstrMenus() {
        return this.strMenus;
    }

    public void setstrMenus(StringBuffer strMenus) {
        this.strMenus = strMenus;
    }
}
