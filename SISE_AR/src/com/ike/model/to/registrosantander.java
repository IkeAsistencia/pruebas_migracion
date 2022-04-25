
package com.ike.model.to;

/*
 *
 * @author cabrerar
 */
public class registrosantander implements java.io.Serializable{

    private String FechIni;
    private String FechFin;
    private String Clave;
    private String Cuenta;
    private String Nombre;
    private String NomCuenta;
    
    /* Creates a new instance of Usuario */
    public registrosantander() {
    }

    public String getFechIni() {
        return FechIni;
    }

    public void setFechIni(String FechIni) {
        this.FechIni = FechIni;
    }

    public String getFechFin() {
        return FechFin;
    }

    public void setFechFin(String FechFin) {
        this.FechFin = FechFin;
    }

    public String getClave() {
        return Clave;
    }

    public void setClave(String Clave) {
        this.Clave = Clave;
    }

    public String getCuenta() {
        return Cuenta;
    }

    public void setCuenta(String Cuenta) {
        this.Cuenta = Cuenta;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public String getNomCuenta() {
        return NomCuenta;
    }

    public void setNomCuenta(String NomCuenta) {
        this.NomCuenta = NomCuenta;
    }



  

 
}
