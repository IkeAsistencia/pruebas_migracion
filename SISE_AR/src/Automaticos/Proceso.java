/*
 * Proceso.java
 *
 * Created on 10 de enero de 2005, 07:10 PM
 */
package Automaticos;

import java.beans.*;
import java.io.Serializable;

/*
 * @author colinj
 */
public class Proceso extends Object implements Serializable {

    private int numProceso;
    private String nombre;
    private String horario;
    private String storeProcedure;
    private String status;
    private PropertyChangeSupport propertySupport;

    public Proceso() {
        propertySupport = new PropertyChangeSupport(this);
    }

    public int getNumProceso() {
        return this.numProceso;
    }

    public void setNumproceso(int numProceso) {
        this.numProceso = numProceso;
    }

    public String getNombre() {
        return this.nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getHorario() {
        return this.horario;
    }

    public void setHorario(String horario) {
        this.horario = horario;
    }

    public String getStoreProcedure() {
        return this.storeProcedure;
    }

    public void setStoreProcedure(String storeProcedure) {
        this.storeProcedure = storeProcedure;
    }

    public String getStatus() {
        return this.status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
