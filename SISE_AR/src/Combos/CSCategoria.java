/*
 * CSCategoria.java
 *
 * Created on 7 de septiembre de 2006, 06:54 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package Combos;

/*
 *
 * @author cabrerar
 */
import java.util.List;

public class CSCategoria {

    private String clCategoria;
    private String Descripcion;
    private List lstSubCategoria = null;

    public String getDescripcion() {
        return Descripcion;
    }

    public void setDescripcion(String Descripcion) {
        this.Descripcion = Descripcion;
    }

    public String getClCategoria() {
        return clCategoria;
    }

    public void setClCategoria(String clCategoria) {
        this.clCategoria = clCategoria;
    }

    public List getLstSubCategoria() {
        return lstSubCategoria;
    }

    public void setLstSubCategoria(List lstSubCategoria) {
        this.lstSubCategoria = lstSubCategoria;
    }
}
