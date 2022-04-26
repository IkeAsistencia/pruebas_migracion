package com.ike.ws.nrm.to;

public class Blocking {
    
    private String latitud;
    private String longitud;
    private String ubicacionVehiculo;
    private String fechaHoraRegistro;
    private String estatusServicio;
    private String velocidad;
    private String estatusArranque;
    private String nivelBateria;
    private String kilometraje;
    private Integer exitoso;
    private String message;

    public String getUbicacionVehiculo() {
        return ubicacionVehiculo;
    }

    public void setUbicacionVehiculo(String ubicacionVehiculo) {
        this.ubicacionVehiculo = ubicacionVehiculo;
    }

    public String getFechaHoraRegistro() {
        return fechaHoraRegistro;
    }

    public void setFechaHoraRegistro(String fechaHoraRegistro) {
        this.fechaHoraRegistro = fechaHoraRegistro;
    }

    public String getEstatusServicio() {
        return estatusServicio;
    }

    public void setEstatusServicio(String estatusServicio) {
        this.estatusServicio = estatusServicio;
    }

    public String getVelocidad() {
        return velocidad;
    }

    public void setVelocidad(String velocidad) {
        this.velocidad = velocidad;
    }

    public String getEstatusArranque() {
        return estatusArranque;
    }

    public void setEstatusArranque(String estatusArranque) {
        this.estatusArranque = estatusArranque;
    }

    public String getNivelBateria() {
        return nivelBateria;
    }

    public void setNivelBateria(String nivelBateria) {
        this.nivelBateria = nivelBateria;
    }

    public String getKilometraje() {
        return kilometraje;
    }

    public void setKilometraje(String kilometraje) {
        this.kilometraje = kilometraje;
    }

    public Integer getExitoso() {
        return exitoso;
    }

    public void setExitoso(Integer exitoso) {
        this.exitoso = exitoso;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    public String getLatitud() {
        return latitud;
    }

    public void setLatitud(String latitud) {
        this.latitud = latitud;
    }

    public String getLongitud() {
        return longitud;
    }

    public void setLongitud(String longitud) {
        this.longitud = longitud;
    }

    @Override
    public String toString() {
        return "Blocking{" + "latitud=" + latitud + ", longitud=" + longitud + ", ubicacionVehiculo=" + ubicacionVehiculo + ", fechaHoraRegistro=" + fechaHoraRegistro + ", estatusServicio=" + estatusServicio + ", velocidad=" + velocidad + ", estatusArranque=" + estatusArranque + ", nivelBateria=" + nivelBateria + ", kilometraje=" + kilometraje + ", exitoso=" + exitoso + ", message=" + message + '}';
    }
}
