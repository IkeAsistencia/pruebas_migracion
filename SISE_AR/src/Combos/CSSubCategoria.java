/*
 * CSSubCategoria.java
 *
 * Created on 7 de septiembre de 2006, 06:55 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package Combos;

/*
 *
 * @author cabrerar
 */
public class CSSubCategoria {

    private String clCategoria;
    private String clSubCategoria;
    private String Descripcion;

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

    public String getClSubCategoria() {
        return clSubCategoria;
    }

    public void setClSubCategoria(String clSubCategoria) {
        this.clSubCategoria = clSubCategoria;
    }
}