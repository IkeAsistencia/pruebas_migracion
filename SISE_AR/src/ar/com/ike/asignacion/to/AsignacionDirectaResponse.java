/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ar.com.ike.asignacion.to;

public class AsignacionDirectaResponse {
    public String casoid;
    public AsignacionDirecta debug;
    public boolean resultado;

    
    public String toString() {
        return "AsignacionDirectaResponse: " + casoid + "::" + resultado;
    }
    
    public String debugString() {
        if ( debug != null ) {
            return "Debug Info: " + casoid + "::" + resultado + "\n " +debug.provincia + "\n " + debug.localidad + "\n " + debug.origen ;
        }
        else {
            return "AsignacionDirectaResponse Debug Info Null ->" + casoid + "::" + resultado;            
        }
    }

}