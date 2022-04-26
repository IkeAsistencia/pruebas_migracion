package com.ike.model.to;

public class Usuario implements java.io.Serializable {
//------------------------------------------------------------------------------
    private String activo;
    private String mess;
    private String clUsrApp;
    private String password;
    private String nombre;
    private String fechaAlta;
    private String fechaInicio;
    private String correo;
    private String agente;
    private String cambiopwd;
    private String webPhone;
    private String AccesoID;
    private String phoneClass;
    private String PermisoDesbloqueo;
    private String alertaApp;
    private String ValidaDobleFactor;   
//------------------------------------------------------------------------------
    public Usuario() {   }
//------------------------------------------------------------------------------
    public String getActivo() {        return activo;    }
    public void setActivo(String activo) {        this.activo = activo;    }
//------------------------------------------------------------------------------
    public String getMess() {        return mess;    }
    public void setMess(String mess) {        this.mess = mess;    }
//------------------------------------------------------------------------------
    public String getClUsrApp() {        return clUsrApp;    }
    public void setClUsrApp(String clUsrApp) {        this.clUsrApp = clUsrApp;    }
//------------------------------------------------------------------------------
    public String getPassword() {        return password;    }
    public void setPassword(String password) {        this.password = password;    }
//------------------------------------------------------------------------------
    public String getNombre() {        return nombre;    }
    public void setNombre(String nombre) {        this.nombre = nombre;    }
//------------------------------------------------------------------------------
    public String getFechaAlta() {        return fechaAlta;    }
    public void setFechaAlta(String fechaAlta) {        this.fechaAlta = fechaAlta;    }
//------------------------------------------------------------------------------
    public String getFechaInicio() {        return fechaInicio;    }
    public void setFechaInicio(String fechaInicio) {        this.fechaInicio = fechaInicio;    }
//------------------------------------------------------------------------------
    public String getCorreo() {        return correo;    }
    public void setCorreo(String correo) {        this.correo = correo;    }
//------------------------------------------------------------------------------
    public String getAgente() {        return agente;    }
    public void setAgente(String agente) {        this.agente = agente;    }
//------------------------------------------------------------------------------
    public String getCambioPwd() {        return cambiopwd;    }
    public void setCambioPwd(String cambiopwd) {        this.cambiopwd = cambiopwd;    }
//------------------------------------------------------------------------------
    public String getWebPhone() {        return this.webPhone;    }
    public void setWebPhone(String webPhone) {        this.webPhone = webPhone;    }
//------------------------------------------------------------------------------
    public String getPhoneClass() {        return this.phoneClass;    }
    public void setPhoneClass(String phoneClass) {        this.phoneClass = phoneClass;    }
//------------------------------------------------------------------------------
    public String getAccesoID() {        return AccesoID;    }
    public void setAccesoID(String AccesoID) {        this.AccesoID = AccesoID;    }
//------------------------------------------------------------------------------
    public String getPermisoDesbloqueo() {        return PermisoDesbloqueo;    }
    public void setPermisoDesbloqueo(String PermisoDesbloqueo) {        this.PermisoDesbloqueo = PermisoDesbloqueo;    }
//------------------------------------------------------------------------------
    public String getAlertaApp() {        return alertaApp;    }
    public void setAlertaApp(String alertaApp) {        this.alertaApp = alertaApp;    }
//------------------------------------------------------------------------------
    public String getValidaDobleFactor() {        return ValidaDobleFactor;    }
    public void setValidaDobleFactor(String ValidaDobleFactor) {        this.ValidaDobleFactor = ValidaDobleFactor;    }
//------------------------------------------------------------------------------    
}