package com.ike.model.to;

public class UsuarioAutenticacion implements java.io.Serializable {
//------------------------------------------------------------------------------
    private String usrApp;
    private String nombre;
    private String fechaRegistro;   
    private String correo;
    private String intentosFallidos;
    private String fechaInicio;
    private String fechaVencimiento;
    private String CodigoValidacion;
//------------------------------------------------------------------------------    
    public UsuarioAutenticacion() {    }
//------------------------------------------------------------------------------
    public String getUsrApp() {        return usrApp;    }
    public void setUsrApp(String usrApp) {        this.usrApp = usrApp;    }
//------------------------------------------------------------------------------    
    public String getNombre() {        return nombre;    }
    public void setNombre(String nombre) {        this.nombre = nombre;    }
//------------------------------------------------------------------------------
    public String getFechaRegistro() {        return fechaRegistro;    }
    public void setFechaRegistro(String fechaRegistro) {        this.fechaRegistro = fechaRegistro;    }
//------------------------------------------------------------------------------
    public String getCorreo() {        return correo;    }
    public void setCorreo(String correo) {        this.correo = correo;    }
//------------------------------------------------------------------------------
    public String getIntentosFallidos() {        return intentosFallidos;    }
    public void setIntentosFallidos(String intentosFallidos) {        this.intentosFallidos = intentosFallidos;    }
//------------------------------------------------------------------------------
    public String getFechaInicio() {        return fechaInicio;    }
    public void setFechaInicio(String fechaInicio) {        this.fechaInicio = fechaInicio;    }
//------------------------------------------------------------------------------
    public String getFechaVencimiento() {        return fechaVencimiento;    }
    public void setFechaVencimiento(String fechaVencimiento) {        this.fechaVencimiento = fechaVencimiento;    }
//------------------------------------------------------------------------------    
    public String getCodigoValidacion() {        return CodigoValidacion;    }
    public void setCodigoValidacion(String CodigoValidacion) {        this.CodigoValidacion = CodigoValidacion;    }
//------------------------------------------------------------------------------   
}