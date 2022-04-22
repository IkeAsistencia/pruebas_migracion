/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.client.lma;

/**
 *
 * @author ddiez
 */
public class PatenteSinPolizaException extends Exception {
    private String error;
    
    public PatenteSinPolizaException(String patente) {
        this.error = patente;
    }
    
    public String getError() {
        return this.error;
    }
    
}
