/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ike.ws.nrm.to;

/**
 *
 * @author vrayon
 */
public class User {
    
    private Integer exitoso;
    private String name;
    private String phoneNumber;
    private String modelName;
    private String vechicleBrand;
    private String vehicleColor;
    private String vehiclePlateNumber;
    private String message;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }

    public String getVechicleBrand() {
        return vechicleBrand;
    }

    public void setVechicleBrand(String vechicleBrand) {
        this.vechicleBrand = vechicleBrand;
    }

    public String getVehicleColor() {
        return vehicleColor;
    }

    public void setVehicleColor(String vehicleColor) {
        this.vehicleColor = vehicleColor;
    }

    public String getVehiclePlateNumber() {
        return vehiclePlateNumber;
    }

    public void setVehiclePlateNumber(String vehiclePlateNumber) {
        this.vehiclePlateNumber = vehiclePlateNumber;
    }
    
    public Integer getExitoso() {
        return exitoso;
    }

    public void setExitoso(Integer exitoso) {
        this.exitoso = exitoso;
    }
    
    public String getMessage(){
        return message;
    }
    
    public void setMessage(String message){
        this.message = message;
    }
}
